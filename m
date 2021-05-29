Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC1394B45
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhE2JUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:20:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2093 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:20:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsbTk17yKzWp8R;
        Sat, 29 May 2021 17:14:18 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:18:55 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:18:55 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm/amd/display: fix gcc set but not used warning of variable 'old_plane_state'
Date:   Sat, 29 May 2021 17:28:16 +0800
Message-ID: <20210529092816.3133745-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

define a new macro for_each_new_plane_in_state_reverse to replace
for_each_oldnew_plane_in_state_reverse, so that the unused variable
'old_plane_state' can be removed.

Fix gcc warning:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10066:26: warning:
 variable ‘old_plane_state’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++--
 include/drm/drm_atomic.h                          | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f7a5e5b48ea6..9f4b334bc071 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10063,11 +10063,11 @@ static int validate_overlay(struct drm_atomic_state *state)
 {
 	int i;
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *new_plane_state;
 	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
 
 	/* Check if primary plane is contained inside overlay */
-	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
 		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
 				return 0;
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index ac5a28eff2c8..8f1350e599eb 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -895,6 +895,18 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			      (old_plane_state) = (__state)->planes[__i].old_state,\
 			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
 
+/**
+ * for_each_new_plane_in_state_reverse - other than only tracking new state,
+ * it's the same as for_each_oldnew_plane_in_state_reverse
+ */
+#define for_each_new_plane_in_state_reverse(__state, plane, new_plane_state, __i) \
+	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
+	     (__i) >= 0;						\
+	     (__i)--)							\
+		for_each_if ((__state)->planes[__i].ptr &&		\
+			     ((plane) = (__state)->planes[__i].ptr,	\
+			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+
 /**
  * for_each_old_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_state pointer
-- 
2.25.4

