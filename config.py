from os import environ

class Config:
    # Service credentials fetched from environment variables
    API_ID = int(environ.get("API_ID", "577678"))
    API_HASH = environ.get("API_HASH", "d2c6e01uuiuiouioiuiou0fc6d7a1be")
    BOT_TOKEN = environ.get("BOT_TOKEN", "70955...") 
    BOT_SESSION = environ.get("BOT_SESSION", "bot") 
    
    # FIX: Checks both "DATABASE_URI" and "DATABASE" so it adapts to your Hugging Face Secret naming
    DATABASE_URI = environ.get("DATABASE_URI", environ.get("DATABASE", ""))
    DATABASE_NAME = environ.get("DATABASE_NAME", "forward-bot")
    
    # Owner ID setup
    BOT_OWNER_ID = [int(id) for id in environ.get("BOT_OWNER_ID", '6463734458').split()]

class temp(object): 
    lock = {}
    CANCEL = {}
    forwardings = 0
    BANNED_USERS = []
    IS_FRWD_CHAT = []
