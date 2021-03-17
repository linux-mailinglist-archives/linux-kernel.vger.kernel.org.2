Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4733EB79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhCQI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:28:04 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54623 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhCQI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:27:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USFl2Xq_1615969654;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0USFl2Xq_1615969654)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 16:27:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/gma500: use NULL instead of using plain integer as pointer
Date:   Wed, 17 Mar 2021 16:27:32 +0800
Message-Id: <1615969652-80225-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warnings:
drivers/gpu/drm/gma500/psb_drv.c:303:56: warning: Using plain integer as
NULL pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 0bcab06..c2aab62 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -303,7 +303,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 
 	ret = -ENOMEM;
 
-	dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, 0);
+	dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, NULL);
 	if (!dev_priv->mmu)
 		goto out_err;
 
-- 
1.8.3.1

