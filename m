Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC444BE87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhKJK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:27:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:56560 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhKJK1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:27:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="256332912"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="256332912"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 02:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="501330380"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2021 02:24:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 963FD155; Wed, 10 Nov 2021 12:24:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 1/1] drm: Replace kernel.h with the necessary inclusions
Date:   Wed, 10 Nov 2021 12:24:23 +0200
Message-Id: <20211110102423.54282-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/drm/drm_gem_ttm_helper.h  | 2 +-
 include/drm/drm_gem_vram_helper.h | 2 +-
 include/drm/drm_mm.h              | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
index c1aa02bd4c89..78040f6cc6f3 100644
--- a/include/drm/drm_gem_ttm_helper.h
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -3,7 +3,7 @@
 #ifndef DRM_GEM_TTM_HELPER_H
 #define DRM_GEM_TTM_HELPER_H
 
-#include <linux/kernel.h>
+#include <linux/container_of.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index d3cf06c9af65..b4ce27a72773 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -11,8 +11,8 @@
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
+#include <linux/container_of.h>
 #include <linux/dma-buf-map.h>
-#include <linux/kernel.h> /* for container_of() */
 
 struct drm_mode_create_dumb;
 struct drm_plane;
diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
index 9b4292f229c6..ac33ba1b18bc 100644
--- a/include/drm/drm_mm.h
+++ b/include/drm/drm_mm.h
@@ -39,13 +39,15 @@
  */
 #include <linux/bug.h>
 #include <linux/rbtree.h>
-#include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/mm_types.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #ifdef CONFIG_DRM_DEBUG_MM
 #include <linux/stackdepot.h>
 #endif
+#include <linux/types.h>
+
 #include <drm/drm_print.h>
 
 #ifdef CONFIG_DRM_DEBUG_MM
-- 
2.33.0

