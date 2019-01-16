import sys
import json

next_arg_is_commit = False
for arg in sys.argv:
    if next_arg_is_commit:
        commit_hash = arg
        commit_hash = commit_hash.replace("\"", "")
        commit_hash = commit_hash.replace(",", "")
        print commit_hash
        sys.exit(0)
    next_arg_is_commit = "\"sha\":" == arg
print "No commit hash found"
sys.exit(1)
