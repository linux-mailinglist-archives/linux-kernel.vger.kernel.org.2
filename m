Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D800312F06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBHKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:30:59 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41482 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232165AbhBHKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:18:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UOBlFUi_1612779461;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOBlFUi_1612779461)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Feb 2021 18:17:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/radeon: Simplify bool comparison
Date:   Mon,  8 Feb 2021 18:17:38 +0800
Message-Id: <1612779458-70938-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/gpu/drm/radeon/rs690.c:190:6-35: WARNING: Comparison to bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/radeon/rs690.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
index c296f94..7bc302a 100644
--- a/drivers/gpu/drm/radeon/rs690.c
+++ b/drivers/gpu/drm/radeon/rs690.c
@@ -187,7 +187,7 @@ static void rs690_mc_init(struct radeon_device *rdev)
 		/* FastFB shall be used with UMA memory. Here it is simply disabled when sideport 
 		 * memory is present.
 		 */
-		if (rdev->mc.igp_sideport_enabled == false && radeon_fastfb == 1) {
+		if (!rdev->mc.igp_sideport_enabled && radeon_fastfb == 1) {
 			DRM_INFO("Direct mapping: aper base at 0x%llx, replaced by direct mapping base 0x%llx.\n", 
 					(unsigned long long)rdev->mc.aper_base, k8_addr);
 			rdev->mc.aper_base = (resource_size_t)k8_addr;
-- 
1.8.3.1

