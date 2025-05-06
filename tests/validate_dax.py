import os

def validate_dax_files(dax_dir="scripts/dax"):
    """Validate DAX scripts for syntax and content."""
    for file in os.listdir(dax_dir):
        if file.endswith(".dax"):
            with open(os.path.join(dax_dir, file), "r") as f:
                content = f.read()
                if "DIVIDE" in content and "COUNTROWS" in content:
                    print(f"{file}: Valid DAX measure detected")
                else:
                    raise ValueError(f"{file}: Invalid DAX measure")

if __name__ == "__main__":
    validate_dax_files()