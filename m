Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FF3B268C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 06:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFXEyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 00:54:55 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:34262 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhFXEyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 00:54:49 -0400
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 440C34FA6A;
        Thu, 24 Jun 2021 00:52:08 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH v3] drm/radeon: Fix NULL dereference when updating memory stats
Date:   Thu, 24 Jun 2021 00:51:20 -0400
Message-Id: <20210624045121.15643-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <085b7f51-15b8-42e0-fcf0-66da839542c8@amd.com>
References: <085b7f51-15b8-42e0-fcf0-66da839542c8@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon_ttm_bo_destroy() is attempting to access the resource object to
update memory counters. However, the resource object is already freed when
ttm calls this function via the destroy callback. This causes an oops when
a bo is freed:

	BUG: kernel NULL pointer dereference, address: 0000000000000010
	RIP: 0010:radeon_ttm_bo_destroy+0x2c/0x100 [radeon]
	Call Trace:
	 radeon_bo_unref+0x1a/0x30 [radeon]
	 radeon_gem_object_free+0x33/0x50 [radeon]
	 drm_gem_object_release_handle+0x69/0x70 [drm]
	 drm_gem_handle_delete+0x62/0xa0 [drm]
	 ? drm_mode_destroy_dumb+0x40/0x40 [drm]
	 drm_ioctl_kernel+0xb2/0xf0 [drm]
	 drm_ioctl+0x30a/0x3c0 [drm]
	 ? drm_mode_destroy_dumb+0x40/0x40 [drm]
	 radeon_drm_ioctl+0x49/0x80 [radeon]
	 __x64_sys_ioctl+0x8e/0xd0

Avoid the issue by updating the counters in the delete_mem_notify callback
instead. Also, fix memory statistic updating in radeon_bo_move() to
identify the source type correctly. The source type needs to be saved
before the move, because the moved from object may be altered by the move.

Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/gpu/drm/radeon/radeon_object.c | 29 ++++++++++++-----------------
 drivers/gpu/drm/radeon/radeon_object.h |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c    | 13 ++++++++++---
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index bfaaa3c969a3..56ede9d63b12 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -49,23 +49,23 @@ static void radeon_bo_clear_surface_reg(struct radeon_bo *bo);
  * function are calling it.
  */
 
-static void radeon_update_memory_usage(struct radeon_bo *bo,
-				       unsigned mem_type, int sign)
+static void radeon_update_memory_usage(struct ttm_buffer_object *bo,
+				       unsigned int mem_type, int sign)
 {
-	struct radeon_device *rdev = bo->rdev;
+	struct radeon_device *rdev = radeon_get_rdev(bo->bdev);
 
 	switch (mem_type) {
 	case TTM_PL_TT:
 		if (sign > 0)
-			atomic64_add(bo->tbo.base.size, &rdev->gtt_usage);
+			atomic64_add(bo->base.size, &rdev->gtt_usage);
 		else
-			atomic64_sub(bo->tbo.base.size, &rdev->gtt_usage);
+			atomic64_sub(bo->base.size, &rdev->gtt_usage);
 		break;
 	case TTM_PL_VRAM:
 		if (sign > 0)
-			atomic64_add(bo->tbo.base.size, &rdev->vram_usage);
+			atomic64_add(bo->base.size, &rdev->vram_usage);
 		else
-			atomic64_sub(bo->tbo.base.size, &rdev->vram_usage);
+			atomic64_sub(bo->base.size, &rdev->vram_usage);
 		break;
 	}
 }
@@ -76,8 +76,6 @@ static void radeon_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 
 	bo = container_of(tbo, struct radeon_bo, tbo);
 
-	radeon_update_memory_usage(bo, bo->tbo.resource->mem_type, -1);
-
 	mutex_lock(&bo->rdev->gem.mutex);
 	list_del_init(&bo->list);
 	mutex_unlock(&bo->rdev->gem.mutex);
@@ -727,24 +725,21 @@ int radeon_bo_check_tiling(struct radeon_bo *bo, bool has_moved,
 }
 
 void radeon_bo_move_notify(struct ttm_buffer_object *bo,
-			   bool evict,
+			   unsigned int old_type,
 			   struct ttm_resource *new_mem)
 {
 	struct radeon_bo *rbo;
 
+	radeon_update_memory_usage(bo, old_type, -1);
+	if (new_mem)
+		radeon_update_memory_usage(bo, new_mem->mem_type, 1);
+
 	if (!radeon_ttm_bo_is_radeon_bo(bo))
 		return;
 
 	rbo = container_of(bo, struct radeon_bo, tbo);
 	radeon_bo_check_tiling(rbo, 0, 1);
 	radeon_vm_bo_invalidate(rbo->rdev, rbo);
-
-	/* update statistics */
-	if (!new_mem)
-		return;
-
-	radeon_update_memory_usage(rbo, bo->resource->mem_type, -1);
-	radeon_update_memory_usage(rbo, new_mem->mem_type, 1);
 }
 
 vm_fault_t radeon_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
index 1739c6a142cd..1afc7992ef91 100644
--- a/drivers/gpu/drm/radeon/radeon_object.h
+++ b/drivers/gpu/drm/radeon/radeon_object.h
@@ -161,7 +161,7 @@ extern void radeon_bo_get_tiling_flags(struct radeon_bo *bo,
 extern int radeon_bo_check_tiling(struct radeon_bo *bo, bool has_moved,
 				bool force_drop);
 extern void radeon_bo_move_notify(struct ttm_buffer_object *bo,
-				  bool evict,
+				  unsigned int old_type,
 				  struct ttm_resource *new_mem);
 extern vm_fault_t radeon_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
 extern int radeon_bo_get_surface_reg(struct radeon_bo *bo);
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index ad2a5a791bba..a06d4cc2fb1c 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -199,7 +199,7 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	struct ttm_resource *old_mem = bo->resource;
 	struct radeon_device *rdev;
 	struct radeon_bo *rbo;
-	int r;
+	int r, old_type;
 
 	if (new_mem->mem_type == TTM_PL_TT) {
 		r = radeon_ttm_tt_bind(bo->bdev, bo->ttm, new_mem);
@@ -216,6 +216,9 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (WARN_ON_ONCE(rbo->tbo.pin_count > 0))
 		return -EINVAL;
 
+	/* Save old type for statistics update */
+	old_type = old_mem->mem_type;
+
 	rdev = radeon_get_rdev(bo->bdev);
 	if (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == NULL) {
 		ttm_bo_move_null(bo, new_mem);
@@ -261,7 +264,7 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 out:
 	/* update statistics */
 	atomic64_add(bo->base.size, &rdev->num_bytes_moved);
-	radeon_bo_move_notify(bo, evict, new_mem);
+	radeon_bo_move_notify(bo, old_type, new_mem);
 	return 0;
 }
 
@@ -682,7 +685,11 @@ bool radeon_ttm_tt_is_readonly(struct radeon_device *rdev,
 static void
 radeon_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	radeon_bo_move_notify(bo, false, NULL);
+	unsigned int old_type = TTM_PL_SYSTEM;
+
+	if (bo->resource)
+		old_type = bo->resource->mem_type;
+	radeon_bo_move_notify(bo, old_type, NULL);
 }
 
 static struct ttm_device_funcs radeon_bo_driver = {
-- 
2.13.7

