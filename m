Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BEE396E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFAIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:06:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2816 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhFAIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:06:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvPhh5ZYkzWqPw;
        Tue,  1 Jun 2021 16:00:04 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:04:45 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:04:44 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <aurabindo.pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <bas@basnieuwenhuizen.nl>, <nikola.cornij@amd.com>,
        <Wayne.Lin@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] =?UTF-8?q?drm/amd/display:=20fix=20warning:=20?= =?UTF-8?q?=E2=80=98update=5Fdsc=5Fcaps=E2=80=99=20and=20=E2=80=98apply=5F?= =?UTF-8?q?dsc=5Fpolicy=5Ffor=5Fstream=E2=80=99=20defined=20but=20not=20us?= =?UTF-8?q?ed?=
Date:   Tue, 1 Jun 2021 16:14:00 +0800
Message-ID: <20210601081400.123089-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-function' warning:

‘update_dsc_caps’ and ‘apply_dsc_policy_for_stream’ are only used
if 'CONFIG_DRM_AMD_DC_DCN' is defined,

however, it's defined even if 'CONFIG_DRM_AMD_DC_DCN' is not defined.
Thus gcc will report following warning
if 'CONFIG_DRM_AMD_DC_DCN' is not defined:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5572:13: warning:
‘apply_dsc_policy_for_stream’ defined but not used [-Wunused-function]

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5556:13: warning:
‘update_dsc_caps’ defined but not used [-Wunused-function]

Thus move the definition of ‘update_dsc_caps’ and
‘apply_dsc_policy_for_stream’ inside define macro to fix it.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f0adfda32213..e0af394103aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5553,6 +5553,7 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 							struct dc_sink *sink, struct dc_stream_state *stream,
 							struct dsc_dec_dpcd_caps *dsc_caps)
@@ -5560,12 +5561,10 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 	stream->timing.flags.DSC = 0;
 
 	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 				      dsc_caps);
-#endif
 	}
 }
 
@@ -5578,7 +5577,6 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
@@ -5609,8 +5607,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
 		stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
-#endif
 }
+#endif
 
 static struct drm_display_mode *
 get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
-- 
2.31.1

