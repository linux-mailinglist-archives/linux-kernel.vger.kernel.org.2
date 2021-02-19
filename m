Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60331F748
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBSKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:24:14 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49763 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbhBSKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:24:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UOxlXPK_1613730199;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOxlXPK_1613730199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Feb 2021 18:23:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu/swsmu/navi1x: Remove unnecessary conversion to bool
Date:   Fri, 19 Feb 2021 18:23:18 +0800
Message-Id: <1613730198-107418-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:900:47-52: WARNING:
conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cd7efa9..dc9ce86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -897,7 +897,7 @@ static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
-	return dpm_desc->SnapToDiscrete == 0 ? true : false;
+	return !(dpm_desc->SnapToDiscrete == 0);
 }
 
 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
-- 
1.8.3.1

