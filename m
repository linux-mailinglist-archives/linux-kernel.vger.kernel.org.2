Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FEF43FB23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJ2LCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhJ2LCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:02:05 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2928C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 03:59:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:20b9:ea2a:8e1c:8da1])
        by andre.telenet-ops.be with bizsmtp
        id BmzY2600i01kgUz01mzYpo; Fri, 29 Oct 2021 12:59:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mgPbg-008ir7-KN; Fri, 29 Oct 2021 12:59:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mgObF-00FChw-47; Fri, 29 Oct 2021 11:55:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/armada: Fix off-by-one error in armada_overlay_get_property()
Date:   Fri, 29 Oct 2021 11:54:42 +0200
Message-Id: <5818c8b04834e6a9525441bc181580a230354b69.1635501237.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ffs() returns one more than the index of the first bit set (zero
means no bits set), the color key mode value is shifted one position too
much.

Fix this by using FIELD_GET() instead.

Fixes: c96103b6c49ff9a8 ("drm/armada: move colorkey properties into overlay plane state")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/gpu/drm/armada/armada_overlay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 424250535fed9e87..0383deb970bbbb03 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -4,6 +4,8 @@
  *  Rewritten from the dovefb driver, and Armada510 manuals.
  */
 
+#include <linux/bitfield.h>
+
 #include <drm/armada_drm.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -451,8 +453,8 @@ static int armada_overlay_get_property(struct drm_plane *plane,
 			     drm_to_overlay_state(state)->colorkey_ug,
 			     drm_to_overlay_state(state)->colorkey_vb, 0);
 	} else if (property == priv->colorkey_mode_prop) {
-		*val = (drm_to_overlay_state(state)->colorkey_mode &
-			CFG_CKMODE_MASK) >> ffs(CFG_CKMODE_MASK);
+		*val = FIELD_GET(CFG_CKMODE_MASK,
+				 drm_to_overlay_state(state)->colorkey_mode);
 	} else if (property == priv->brightness_prop) {
 		*val = drm_to_overlay_state(state)->brightness + 256;
 	} else if (property == priv->contrast_prop) {
-- 
2.25.1

