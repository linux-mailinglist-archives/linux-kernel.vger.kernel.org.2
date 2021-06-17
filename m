Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050403AA8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFQCc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 22:32:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7336 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhFQCc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 22:32:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G55XB3lMfz6ySF;
        Thu, 17 Jun 2021 10:26:18 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:30:17 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:30:17 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jun.Lei@amd.com>, <wenjing.liu@amd.com>, <Anson.Jacob@amd.com>,
        <qingqing.zhuo@amd.com>, <Wesley.Chalmers@amd.com>,
        <Jimmy.Kizito@amd.com>, <aric.cyr@amd.com>, <martin.tsai@amd.com>,
        <jinlong.zhang@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] drm/amd/display: Fix gcc unused variable warning
Date:   Thu, 17 Jun 2021 10:31:09 +0800
Message-ID: <20210617023109.204591-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3635:17:
warning:
 variable ‘status’ set but not used [-Wunused-but-set-variable]
  3635 |  enum dc_status status = DC_ERROR_UNEXPECTED;
       |                 ^~~~~~

The variable should be used for error check, let's fix it.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index fcb635c85330..cf29265870c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3681,6 +3681,10 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
 				lttpr_dpcd_data,
 				sizeof(lttpr_dpcd_data));
+		if (status != DC_OK) {
+			dm_error("%s: Read LTTPR caps data failed.\n", __func__);
+			return false;
+		}
 
 		link->dpcd_caps.lttpr_caps.revision.raw =
 				lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
-- 
2.17.1

