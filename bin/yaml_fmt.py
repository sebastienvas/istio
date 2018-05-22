#!/usr/bin/python

import sys
import StringIO
from ruamel.yaml import YAML


def parse_file(filename):
    with open(filename, 'r') as f:
        data = f.read()
    splitter = '\n---\n'
    output = StringIO.StringIO()
    yamls = data.split(splitter)
    for i, y in enumerate(yamls):
        if y.strip() == '':
            continue
        yaml = YAML()
        try:
            new_data = yaml.load(y)
            out = StringIO.StringIO()
            yaml.dump(new_data, out)
            out = out.getvalue()
        except:
            print("unable to parse %s" % filename)
            out = y
        
        if out.strip():
            output.write(out.strip())
            
            if i < len(yamls) - 1:
                output.write(splitter)

    with open(filename, 'w') as f:
        f.write(output.getvalue())

def main():
    if len(sys.argv) != 2:
        print("only one argument supported")
        sys.exit(1)
    parse_file(sys.argv[1])



if __name__ == '__main__':
    main()
