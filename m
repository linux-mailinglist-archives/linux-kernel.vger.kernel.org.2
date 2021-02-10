Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4D3165F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBJMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:05:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39841 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhBJMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:04:15 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l9oDS-00006y-P1; Wed, 10 Feb 2021 12:03:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: fix spelling mistake in various messages "power_dpm_force_perfomance_level"
Date:   Wed, 10 Feb 2021 12:03:30 +0000
Message-Id: <20210210120330.54066-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in error and warning messages, the text
power_dpm_force_perfomance_level is missing a letter r and should be
power_dpm_force_performance_level.  Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index ed05a30d1139..d1358a6dd2c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 	}
 
 	if (!smu10_data->fine_grain_enabled) {
-		pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
+		pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 093b01159408..8abb25a28117 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1462,7 +1462,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 
 	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
 		dev_warn(smu->adev->dev,
-			"pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
+			"pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5faa509f0dba..b59156dfca19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -351,7 +351,7 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
 
 	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
 		dev_warn(smu->adev->dev,
-			"pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
+			"pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
 		return -EINVAL;
 	}
 
-- 
2.30.0

