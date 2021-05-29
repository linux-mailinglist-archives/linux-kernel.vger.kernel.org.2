Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A34394B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhE2JWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:22:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2531 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2JWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:22:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsbZM0vpbzYpVW;
        Sat, 29 May 2021 17:18:19 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:21:00 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:20:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm/amd/display: fix gcc set but not used warning of variable 'link_bandwidth_kbps'
Date:   Sat, 29 May 2021 17:30:21 +0800
Message-ID: <20210529093021.3135273-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apply_dsc_policy_for_stream() will only be used if
'CONFIG_DRM_AMD_DC_DCN' is enabled, thus the function can be
declared inside the ifdefine marco.

Fix gcc warning:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5577:11: warning:
 variable ‘link_bandwidth_kbps’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f0adfda32213..f7a5e5b48ea6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5569,6 +5569,7 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 										struct dc_sink *sink, struct dc_stream_state *stream,
 										struct dsc_dec_dpcd_caps *dsc_caps)
@@ -5578,7 +5579,6 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
-- 
2.25.4

