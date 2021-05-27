Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220FC392723
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhE0GLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:11:55 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:55871 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhE0GLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:11:53 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d25 with ME
        id 9iAG2500521Fzsu03iAGgj; Thu, 27 May 2021 08:10:18 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 May 2021 08:10:18 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/2] drm/kmb: Fix an error handling path
Date:   Thu, 27 May 2021 08:10:14 +0200
Message-Id: <91d2b0417ccb8497b977e175b0b44417e47405aa.1622095610.git.christophe.jaillet@wanadoo.fr>
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
handling path, instead of 'of_reserved_mem_device_release()'.


Also, it is spurious to return directly if 'of_reserved_mem_device_init()'
fails.
Goto the error handling path instead to free some resources.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Keep label name
    Fix the commit message where a wrong function name was used
---
 drivers/gpu/drm/kmb/kmb_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index f64e06e1067d..fa28e42da460 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -144,7 +144,7 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	/* Get the optional framebuffer memory resource */
 	ret = of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
-		return ret;
+		goto setup_fail;
 
 	spin_lock_init(&kmb->irq_lock);
 
@@ -153,7 +153,7 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	return 0;
 
  setup_fail:
-	of_reserved_mem_device_release(drm->dev);
+	kmb_display_clk_disable(kmb);
 
 	return ret;
 }
-- 
2.30.2

