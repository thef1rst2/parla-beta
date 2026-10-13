# Parla beta 🇮🇹

Parla is a Mac app for learning to **speak** Italian: short daily lessons, plus real
conversations with a friendly tutor who corrects you as you go.

Thanks for testing it! Here's how to get it running.

## Install (1 minute)

You need a Mac with **macOS 14 (Sonoma) or newer**.

1. Open **Terminal** (press ⌘ Space, type `Terminal`, press Return).
2. Paste this line and press Return:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/thef1rst2/parla-beta/main/install.sh | bash
   ```

3. Parla opens by itself. When it asks for your **beta key**, paste the key you were sent.

That's it. Parla tells you when there's an update and installs it with one click.

### Prefer not to use Terminal?

1. Download the latest **Parla-x.y.z.dmg** from [Releases](https://github.com/thef1rst2/parla-beta/releases/latest).
2. Open it and drag **Parla** into **Applications**.
3. Open Parla. The first time, macOS blocks it because it isn't from the App Store yet:
   go to **System Settings → Privacy & Security**, scroll down to *"Parla was blocked…"*,
   click **Open Anyway** and confirm. You only do this once.

### No Mac? Use it in your browser

Open **[parla-web.pages.dev](https://parla-web.pages.dev)** in Chrome, Edge or Safari (on a
computer, or a phone with headphones) and paste the same beta key. It has the same course and
conversations; your progress there is kept in that browser.

## Good to know

- **Microphone.** Parla asks to use your microphone and speech recognition; that's how you
  talk to your tutor. Somewhere quiet works best: background noise and TV can confuse it.
  macOS may ask again after an update (Parla isn't from the App Store yet). Just click Allow.
- **Your key is personal.** It gives you a daily amount of conversation time. Please don't share it.
- **Privacy.** Conversations with the tutor are processed by **Google Gemini**. During the
  beta Parla uses Gemini's free plan, on which **Google may use what's sent to improve its
  products**. Don't say anything you wouldn't want a stranger to hear. Lessons (everything
  except talking with the tutor) run entirely on your Mac.
- **Your progress** stays on your Mac (in `~/Library/Application Support/Parla`).
- **Something went wrong?** Tell me what happened. If you can, also send the file
  `~/Library/Logs/Parla/parla.log`. It lists what the app did (never what you said).

## Uninstall

Drag Parla from Applications to the Trash. To also remove your progress, delete the folder
`~/Library/Application Support/Parla`.
