# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**DMI Portfolio Website** — Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

## Architecture

### Application (Static Site)
- **index.html** (613 lines) — Single-page portfolio featuring About, Services, Courses, Books, Community, and Contact sections
- **style.css** (1145 lines) — All styling; mobile-first responsive design with breakpoints at 900px, 768px, and 600px
- **privacy.html** (202 lines) — Privacy policy page with inline styles
- **terms.html** (217 lines) — Terms page with inline styles
- **images/** — Static assets: logo.png, profile.jpg, signature.png, course thumbnails (dmi-course.jpg, Git.jpg, awsCloud.jpg, Devops.jpg), and background image

Pure HTML5 and CSS3. No JavaScript. No build step. No framework.

## Commands
- terraform init
- terraform plan
- terraform apply

## Conventions
- All infrastructure changes go through Terraform — never modify AWS resources manually
- No JavaScript in this project
- CSS uses mobile-first approach with breakpoints at 900px, 768px, and 600px

## Safety
Never put secrets in this file. No API keys, passwords, or AWS credentials.

## Development

### Local Preview
Open `index.html` directly in a browser to preview the site:
```bash
# macOS / Linux
open index.html

# Windows
start index.html
```

### Editing Content
- **Portfolio content** — Edit sections in `index.html` (About, Services, Courses, Books, Community, Contact)
- **Styling** — All CSS lives in `style.css`; breakpoints at 900px, 768px, 600px for responsive behavior
- **Standalone pages** — `privacy.html` and `terms.html` each include their own inline styles

Refresh the browser to see changes immediately (no build step).

## DMI Deployment Requirement

**Before deploying to production, students MUST edit the footer in `index.html` to add ownership proof.** This is a mandatory DMI Week 1 rule and must appear in screenshots submitted for verification.

Original footer line (line 604):
```html
<p>Crafted with <span>cloud</span> excellence by Pravin Mishra</p>
```

Students must **add** (not replace) a line like:
```html
<p><strong>Deployed by:</strong> DMI Cohort 2 | [Name] | Group [N] | Week 1 | [Date]</p>
```

This proves ownership and is visible in browser screenshots.

## Deployment (Student-Facing)

Students deploy this site on an Ubuntu VM with Nginx:

```bash
# Copy files to Nginx document root
sudo cp -r /path/to/portfolio/* /var/www/html/

# Test Nginx config
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx

# Site is now live at http://<public-ip>
```

## File Structure Summary

```
.
├── index.html          # Main portfolio (About, Services, Courses, etc.)
├── style.css           # Responsive CSS (mobile-first)
├── privacy.html        # Privacy policy
├── terms.html          # Terms page
├── README.md           # Student instructions and context
├── images/
│   ├── logo.png        # Site logo
│   ├── profile.jpg     # Profile photo
│   ├── signature.png   # Signature graphic
│   ├── dmi-course.jpg  # DMI course image
│   ├── Git.jpg         # Git thumbnail
│   ├── awsCloud.jpg    # AWS cloud thumbnail
│   ├── Devops.jpg      # DevOps thumbnail
│   └── image.png       # Large background/hero image
└── .git/               # Git repository
```

## Conventions

- **No build process** — All files are served as-is; no minification, bundling, or compilation
- **Responsive design** — CSS uses mobile-first approach; tablet and desktop breakpoints cascade from smaller screens
- **Static only** — No JavaScript, no server-side code, no API calls
- **Ownership proof** — Footer is a required DMI submission element; any content edits should preserve the deployment metadata
