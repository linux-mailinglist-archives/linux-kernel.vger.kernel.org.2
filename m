Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C471389834
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhESUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:48:29 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:42256 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:48:28 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d81 with ME
        id 6kn32500A21Fzsu03kn3Bq; Wed, 19 May 2021 22:47:05 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 May 2021 22:47:05 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/kmb: Fix an error handling path
Date:   Wed, 19 May 2021 22:47:02 +0200
Message-Id: <ce19f0d78174b0674dc963d134fbdec222250e84.1621457119.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'platform_get_irq()' fails, it is spurious to call
'of_reserved_mem_device_release()' in the error handling path, because
'of_reserved_mem_device_init() has not been called yet.

Moreover, a previous 'kmb_initialize_clocks()' is unbalanced by a
corresponding 'kmb_display_clk_disable()' call, has already done in the
remove function.

It is likely that 'kmb_display_clk_disable()' is expected in the error
handling path, instead of 'kmb_display_clk_disable()'.


Also, it is spurious to return directly if 'of_reserved_mem_device_init()'
fails.
Goto the error handling path instead to free some resources.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index f64e06e1067d..b41b8789fe57 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -138,13 +138,13 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	irq_lcd = platform_get_irq(pdev, 0);
 	if (irq_lcd < 0) {
 		drm_err(&kmb->drm, "irq_lcd not found");
-		goto setup_fail;
+		goto disable_clk_err;
 	}
 
 	/* Get the optional framebuffer memory resource */
 	ret = of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
-		return ret;
+		goto disable_clk_err;
 
 	spin_lock_init(&kmb->irq_lock);
 
@@ -152,8 +152,8 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 
 	return 0;
 
- setup_fail:
-	of_reserved_mem_device_release(drm->dev);
+ disable_clk_err:
+	kmb_display_clk_disable(kmb);
 
 	return ret;
 }
-- 
2.30.2

