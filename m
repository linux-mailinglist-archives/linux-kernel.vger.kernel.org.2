Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259A435279B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhDBIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:54:59 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:55114 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:54:58 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 9B78C40047D;
        Fri,  2 Apr 2021 16:54:55 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Aaron Liu <aaron.liu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/amd: remove not needed conversion to bool
Date:   Fri,  2 Apr 2021 01:54:02 -0700
Message-Id: <20210402085454.76864-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEhKQk0ZSx0ZSUNPVkpNSkxITkhNQk5CT09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6FAw6HT8OGioiKzpDCh05
        DxUwClZVSlVKTUpMSE5ITUJNSUhLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJT09DNwY+
X-HM-Tid: 0a7891cae284d991kuws9b78c40047d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:
drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c:573:39-44: WARNING: conversion to bool not needed here
drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c:575:39-44: WARNING: conversion to bool not needed here

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ab9be5ad5a5f..0734e8ef5e41 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -570,9 +570,9 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
 		return 0;
 
 	mmhub_v2_3_update_medium_grain_clock_gating(adev,
-			state == AMD_CG_STATE_GATE ? true : false);
+			(state == AMD_CG_STATE_GATE));
 	mmhub_v2_3_update_medium_grain_light_sleep(adev,
-			state == AMD_CG_STATE_GATE ? true : false);
+			(state == AMD_CG_STATE_GATE));
 
 	return 0;
 }
-- 
2.31.0

