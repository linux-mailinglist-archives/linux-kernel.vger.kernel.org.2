Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996A33AA881
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFQBRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:17:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhFQBRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:17:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G53vL4VqgzZfjy;
        Thu, 17 Jun 2021 09:12:46 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:15:42 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:15:42 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Anson.Jacob@amd.com>, <Nicholas.Kazlauskas@amd.com>,
        <roman.li@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove unused variable 'dc'
Date:   Thu, 17 Jun 2021 09:16:32 +0800
Message-ID: <20210617011632.187690-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c:70:13:
warning:
 variable ‘dc’ set but not used [-Wunused-but-set-variable]
    70 |  struct dc *dc = NULL;
       |             ^~

This variable is not used in function, this commit remove it to
fix the warning.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f7c77ae0d965..70a554f1e725 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -67,14 +67,12 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 	struct dc_link *link = NULL;
 	struct psr_config psr_config = {0};
 	struct psr_context psr_context = {0};
-	struct dc *dc = NULL;
 	bool ret = false;
 
 	if (stream == NULL)
 		return false;
 
 	link = stream->link;
-	dc = link->ctx->dc;
 
 	psr_config.psr_version = link->dpcd_caps.psr_caps.psr_version;
 
-- 
2.17.1

