Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A943A68C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhJYW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhJYW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:28:47 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CCD9C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:26:25 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3C03492009C; Tue, 26 Oct 2021 00:26:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 378FE92009B;
        Tue, 26 Oct 2021 00:26:22 +0200 (CEST)
Date:   Tue, 26 Oct 2021 00:26:22 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Wim Osterholt <wim@djo.tudelft.nl>,
        "Pavel V. Panteleev" <panteleev_p@mcst.ru>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vgacon: Propagate console boot parameters before calling
 `vc_resize'
Message-ID: <alpine.DEB.2.21.2110252317110.58149@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a division by zero in `vgacon_resize' with a backtrace like:

vgacon_resize
vc_do_resize
vgacon_init
do_bind_con_driver
do_unbind_con_driver
fbcon_fb_unbind
do_unregister_framebuffer
do_register_framebuffer
register_framebuffer
__drm_fb_helper_initial_config_and_unlock
drm_helper_hpd_irq_event
dw_hdmi_irq
irq_thread
kthread

caused by `c->vc_cell_height' not having been initialized.  This has 
only started to trigger with commit 860dafa90259 ("vt: Fix character 
height handling with VT_RESIZEX"), however the ultimate offender is 
commit 50ec42edd978 ("[PATCH] Detaching fbcon: fix vgacon to allow 
retaking of the console").

Said commit has added a call to `vc_resize' whenever `vgacon_init' is 
called with the `init' argument set to 0, which did not happen before. 
And the call is made before a key vgacon boot parameter retrieved in 
`vgacon_startup' has been propagated in `vgacon_init' for `vc_resize' to 
use to the console structure being worked on.  Previously the parameter 
was `c->vc_font.height' and now it is `c->vc_cell_height'.

In this particular scenario the registration of fbcon has failed and vt 
resorts to vgacon.  Now fbcon does have initialized `c->vc_font.height' 
somehow, unlike `c->vc_cell_height', which is why this code did not 
crash before, but either way the boot parameters should have been copied 
to the console structure ahead of the call to `vc_resize' rather than 
afterwards, so that first the call has a chance to use them and second 
they do not change the console structure to something possibly different 
from what was used by `vc_resize'.

Move the propagation of the vgacon boot parameters ahead of the call to 
`vc_resize' then.  Adjust the comment accordingly.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
Reported-by: Pavel V. Panteleev <panteleev_p@mcst.ru>
Fixes: 50ec42edd978 ("[PATCH] Detaching fbcon: fix vgacon to allow retaking of the console")
Cc: stable@vger.kernel.org # v2.6.18+
---
 drivers/video/console/vgacon.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

linux-vt-vgacon-init-cell-height-fix.diff
Index: linux-macro-ide-tty/drivers/video/console/vgacon.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/video/console/vgacon.c
+++ linux-macro-ide-tty/drivers/video/console/vgacon.c
@@ -366,11 +366,17 @@ static void vgacon_init(struct vc_data *
 	struct uni_pagedir *p;
 
 	/*
-	 * We cannot be loaded as a module, therefore init is always 1,
-	 * but vgacon_init can be called more than once, and init will
-	 * not be 1.
+	 * We cannot be loaded as a module, therefore init will be 1
+	 * if we are the default console, however if we are a fallback
+	 * console, for example if fbcon has failed registration, then
+	 * init will be 0, so we need to make sure our boot parameters
+	 * have been copied to the console structure for vgacon_resize
+	 * ultimately called by vc_resize.  Any subsequent calls to
+	 * vgacon_init init will have init set to 0 too.
 	 */
 	c->vc_can_do_color = vga_can_do_color;
+	c->vc_scan_lines = vga_scan_lines;
+	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
 
 	/* set dimensions manually if init != 0 since vc_resize() will fail */
 	if (init) {
@@ -379,8 +385,6 @@ static void vgacon_init(struct vc_data *
 	} else
 		vc_resize(c, vga_video_num_columns, vga_video_num_lines);
 
-	c->vc_scan_lines = vga_scan_lines;
-	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
 	c->vc_complement_mask = 0x7700;
 	if (vga_512_chars)
 		c->vc_hi_font_mask = 0x0800;
