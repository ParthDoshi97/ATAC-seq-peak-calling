import os
import requests

def download_file(url, output_dir, filename=None):
    try:
        # Remove surrounding quotes from the URL if present
        url = url.strip('\"')
        # Extract the filename from the URL or use the provided filename
        if not filename:
            path = url.split('?')[0].rstrip('/')
            filename = os.path.basename(path)
            if not filename:
                raise ValueError(f"Unable to determine filename from URL: {url}")
        filepath = os.path.join(output_dir, filename)
        
        response = requests.get(url, stream=True)
        response.raise_for_status()

        with open(filepath, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"Downloaded: {filepath}")
    except requests.exceptions.RequestException as e:
        print(f"Error downloading {url}: {e}")
    except ValueError as e:
        print(e)

def main(urls_file, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    with open(urls_file, 'r') as file:
        for url in file:
            url = url.strip()
            if url:
                if "metadata" in url:
                    download_file(url, output_dir, filename="metadata.tsv")
                else:
                    download_file(url, output_dir)

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python download_files.py <urls_file> <output_dir>")
        sys.exit(1)
    urls_file = sys.argv[1]
    output_dir = sys.argv[2]
    main(urls_file, output_dir)
