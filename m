Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0857452A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhKPFyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:54:24 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92]:55007 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237537AbhKPFyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:54:01 -0500
X-QQ-mid: bizesmtp42t1637041833t56n8jsa
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 16 Nov 2021 13:50:32 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000B00A0000000
X-QQ-FEAT: 0VgNaGdhy9gMzxiMf1vmpjJbNpQ/R/ZOeZ0tS/XNDElwqgpr4Swqsek2YJaCD
        cziT7dWpG99gNhZes+Eql5RTGoAx2xSjd1Pw+aU9sSvzp0tiKfo1TQC9GmyO4+8kSKl68Yq
        TVMAPW/mA0Kb3dMLZXWaa23CFclqHcPBU5QgNKZBDKqWI/+IlJfm3aP0N4H371ykVGAFHgx
        XgUA1vQtlW9hnw+iVWNZGCygwzL4obN9r36Nmkfk3JSslx52Z3YiRG943brxIHHY+xvUqA6
        8LSSWRMwlpLowvCePefZimT/O1Ivshy7bwlYLIILabMJrX/ljNh8AXi2ZIvg7LYCuMGq4OS
        dUS9TRGSjqzWRY3kXUJ20T5WdFyvGQJuyl7Fdu9gfrxxrH+xag=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] drm/radeon:WARNING opportunity for max()
Date:   Tue, 16 Nov 2021 13:50:31 +0800
Message-Id: <20211116055031.31621-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
drivers/gpu/drm/radeon/r100.c:3450:26-27: WARNING opportunity for max()
drivers/gpu/drm/radeon/r100.c:2812:23-24: WARNING opportunity for max()

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/gpu/drm/radeon/r100.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 2dd85ba1faa2..c65ee6f44af2 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -2809,10 +2809,7 @@ void r100_vram_init_sizes(struct radeon_device *rdev)
 		if (rdev->mc.aper_size > config_aper_size)
 			config_aper_size = rdev->mc.aper_size;
 
-		if (config_aper_size > rdev->mc.real_vram_size)
-			rdev->mc.mc_vram_size = config_aper_size;
-		else
-			rdev->mc.mc_vram_size = rdev->mc.real_vram_size;
+		rdev->mc.mc_vram_size = max(config_aper_size, rdev->mc.real_vram_size);
 	}
 }
 
@@ -3447,10 +3444,7 @@ void r100_bandwidth_update(struct radeon_device *rdev)
 	mc_latency_mclk.full += disp_latency_overhead.full + cur_latency_mclk.full;
 	mc_latency_sclk.full += disp_latency_overhead.full + cur_latency_sclk.full;
 
-	if (mc_latency_mclk.full > mc_latency_sclk.full)
-		disp_latency.full = mc_latency_mclk.full;
-	else
-		disp_latency.full = mc_latency_sclk.full;
+	disp_latency.full = max(mc_latency_mclk.full, mc_latency_sclk.full);
 
 	/* setup Max GRPH_STOP_REQ default value */
 	if (ASIC_IS_RV100(rdev))
-- 
2.20.1



