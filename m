Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2969E31F55D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:30:12 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42127 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhBSHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:30:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UOxD3N8_1613719765;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UOxD3N8_1613719765)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Feb 2021 15:29:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/radeon/dpm: fix non-restricted types with le16_to_cpu()
Date:   Fri, 19 Feb 2021 15:29:20 +0800
Message-Id: <1613719760-42773-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:
drivers/gpu/drm/radeon/rv6xx_dpm.c:1798:21: warning: cast to restricted
__le32
drivers/gpu/drm/radeon/rv6xx_dpm.c:1799:22: warning: cast to restricted
__le16
drivers/gpu/drm/radeon/rv6xx_dpm.c:1800:23: warning: cast to restricted
__le16

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/radeon/rv6xx_dpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rv6xx_dpm.c b/drivers/gpu/drm/radeon/rv6xx_dpm.c
index 69d380f..e6ab99e 100644
--- a/drivers/gpu/drm/radeon/rv6xx_dpm.c
+++ b/drivers/gpu/drm/radeon/rv6xx_dpm.c
@@ -1795,9 +1795,9 @@ static void rv6xx_parse_pplib_non_clock_info(struct radeon_device *rdev,
 					     struct radeon_ps *rps,
 					     struct _ATOM_PPLIB_NONCLOCK_INFO *non_clock_info)
 {
-	rps->caps = le32_to_cpu(non_clock_info->ulCapsAndSettings);
-	rps->class = le16_to_cpu(non_clock_info->usClassification);
-	rps->class2 = le16_to_cpu(non_clock_info->usClassification2);
+	rps->caps = le32_to_cpu((__le32 __force)non_clock_info->ulCapsAndSettings);
+	rps->class = le16_to_cpu((__le16 __force)non_clock_info->usClassification);
+	rps->class2 = le16_to_cpu((__le16 __force)non_clock_info->usClassification2);
 
 	if (r600_is_uvd_state(rps->class, rps->class2)) {
 		rps->vclk = RV6XX_DEFAULT_VCLK_FREQ;
-- 
1.8.3.1

