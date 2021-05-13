Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC537F510
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhEMJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:52:55 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:33188 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEMJww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:52:52 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CF68E92009D; Thu, 13 May 2021 11:51:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CA8CA92009C;
        Thu, 13 May 2021 11:51:41 +0200 (CEST)
Date:   Thu, 13 May 2021 11:51:41 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Hostettler <textshell@uchuujin.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] vgacon: Record video mode changes with VT_RESIZEX
In-Reply-To: <alpine.DEB.2.21.2105131132100.3032@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2105131136230.3032@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2105131132100.3032@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue with VGA console font size changes made after the initial 
video text mode has been changed with a user tool like `svgatextmode' 
calling the VT_RESIZEX ioctl.  As it stands in that case the original 
screen geometry continues being used to validate further VT resizing.

Consequently when the video adapter is firstly reprogrammed from the 
original say 80x25 text mode using a 9x16 character cell (720x400 pixel 
resolution) to say 80x37 text mode and the same character cell (720x592 
pixel resolution), and secondly the CRTC character cell updated to 9x8 
(by loading a suitable font with the KD_FONT_OP_SET request of the 
KDFONTOP ioctl), the VT geometry does not get further updated from 80x37 
and only upper half of the screen is used for the VT, with the lower 
half showing rubbish corresponding to whatever happens to be there in 
the video memory that maps to that part of the screen.  Of course the 
proportions change according to text mode geometries and font sizes 
chosen.

Address the problem then, by updating the text mode geometry defaults 
rather than checking against them whenever the VT is resized via a user 
ioctl.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: e400b6ec4ede ("vt/vgacon: Check if screen resize request comes from userspace")
Cc: stable@vger.kernel.org # v2.6.24+
---
No changes from v1.
---
 drivers/video/console/vgacon.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-macro-ide/drivers/video/console/vgacon.c
===================================================================
--- linux-macro-ide.orig/drivers/video/console/vgacon.c
+++ linux-macro-ide/drivers/video/console/vgacon.c
@@ -1089,12 +1089,20 @@ static int vgacon_resize(struct vc_data
 	if ((width << 1) * height > vga_vram_size)
 		return -EINVAL;
 
+	if (user) {
+		/*
+		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
+		 * the video mode!  Set the new defaults then and go away.
+		 */
+		screen_info.orig_video_cols = width;
+		screen_info.orig_video_lines = height;
+		vga_default_font_height = c->vc_font.height;
+		return 0;
+	}
 	if (width % 2 || width > screen_info.orig_video_cols ||
 	    height > (screen_info.orig_video_lines * vga_default_font_height)/
 	    c->vc_font.height)
-		/* let svgatextmode tinker with video timings and
-		   return success */
-		return (user) ? 0 : -EINVAL;
+		return -EINVAL;
 
 	if (con_is_visible(c) && !vga_is_gfx) /* who knows */
 		vgacon_doresize(c, width, height);
