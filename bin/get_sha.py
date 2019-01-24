import sys
import json

if len(sys.argv) < 2:
    print "No ref payload provided"
    sys.exit(1)
sha = json.loads(sys.argv[1])["object"]["sha"]
if not sha:
    print "No commit hash found"
    sys.exit(2)
print sha
