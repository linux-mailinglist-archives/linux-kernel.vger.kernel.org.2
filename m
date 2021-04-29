Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E999C36E36A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhD2CwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:52:06 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:63170 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhD2CwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:52:05 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 22:52:04 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id B1253801C3;
        Thu, 29 Apr 2021 10:42:13 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/i915: Use might_alloc()
Date:   Wed, 28 Apr 2021 19:42:11 -0700
Message-Id: <20210429024211.58245-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhISFZLSk5LGBpKSxpPSEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6DAw6OT8QEkkyEktMCRA5
        N00aFB1VSlVKTUpCTU1PSkhPSkxPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJT0hINwY+
X-HM-Tid: 0a791b815ee5b037kuuub1253801c3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This maybe used lockdep through the fs_reclaim annotations.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/i915/i915_sw_fence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 2744558f3050..cc1b49cabb6c 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -341,7 +341,7 @@ static int __i915_sw_fence_await_sw_fence(struct i915_sw_fence *fence,
 	unsigned long flags;
 
 	debug_fence_assert(fence);
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(gfp);
 
 	if (i915_sw_fence_done(signaler)) {
 		i915_sw_fence_set_error_once(fence, signaler->error);
@@ -477,7 +477,7 @@ int i915_sw_fence_await_dma_fence(struct i915_sw_fence *fence,
 	int ret;
 
 	debug_fence_assert(fence);
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(gfp);
 
 	if (dma_fence_is_signaled(dma)) {
 		i915_sw_fence_set_error_once(fence, dma->error);
@@ -576,7 +576,7 @@ int i915_sw_fence_await_reservation(struct i915_sw_fence *fence,
 	int ret = 0, pending;
 
 	debug_fence_assert(fence);
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(gfp);
 
 	if (write) {
 		struct dma_fence **shared;
-- 
2.31.0

