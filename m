Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841653D12E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhGUPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhGUPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:13:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vyOKqVf04VZNTbnMGjin9W8FP1xQqeT7kSDPOCdqRkU=; b=SAYuuRWAs/O0z1w2Y4ovtVp6CQ
        cC5ZIl8uhLAXJ0yDVbxVgakJ5a/93egaI+tH/rKSFwLne9hpKJCLiv0r8rOYoD7DVToDVbVqix2Fq
        DpWu1lYviHHAaah9dmhXuCPHlEBfodB2HFbAaqSto1+iunWk5CunwOFohzaVcJMUW4WuuJXCfqRPs
        LLv6t2aEVaf3QFwOrDG0NPjuNCRDntT3pjHnP6IVGUyFFmakety8/29tC5Rp4O1iyeDbtkh7o49Oh
        3YRhS2+2JvNDI3MDFKKFPs4XOY9T6/s/EfyQUyjwvEEzXF6kFhMrThSqvzo9CagYLcsRFlAXoUunp
        8hoHNOyQ==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EXt-009MDl-HV; Wed, 21 Jul 2021 15:54:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] drm/i915/gvt: integrate into the main Makefile
Date:   Wed, 21 Jul 2021 17:53:35 +0200
Message-Id: <20210721155355.173183-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721155355.173183-1-hch@lst.de>
References: <20210721155355.173183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the separately included Makefile and just use the relative
reference from the main i915 Makefile as for source files in other
subdirectories.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/Makefile     | 29 ++++++++++++++++++++++++-----
 drivers/gpu/drm/i915/gvt/Makefile |  9 ---------
 drivers/gpu/drm/i915/gvt/trace.h  |  2 +-
 3 files changed, 25 insertions(+), 15 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gvt/Makefile

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 4f22cac1c49b..2153f67705b8 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -289,11 +289,30 @@ i915-$(CONFIG_DRM_I915_SELFTEST) += \
 
 # virtual gpu code
 i915-y += i915_vgpu.o
-
-ifeq ($(CONFIG_DRM_I915_GVT),y)
-i915-y += intel_gvt.o
-include $(src)/gvt/Makefile
-endif
+i915-$(CONFIG_DRM_I915_GVT) += \
+	intel_gvt.o \
+	gvt/gvt.o \
+	gvt/aperture_gm.o \
+	gvt/handlers.o \
+	gvt/vgpu.o \
+	gvt/trace_points.o \
+	gvt/firmware.o \
+	gvt/interrupt.o \
+	gvt/gtt.o \
+	gvt/cfg_space.o \
+	gvt/opregion.o \
+	gvt/mmio.o \
+	gvt/display.o \
+	gvt/edid.o \
+	gvt/execlist.o \
+	gvt/scheduler.o \
+	gvt/sched_policy.o \
+	gvt/mmio_context.o \
+	gvt/cmd_parser.o \
+	gvt/debugfs.o \
+	gvt/fb_decoder.o \
+	gvt/dmabuf.o \
+	gvt/page_track.o
 
 obj-$(CONFIG_DRM_I915) += i915.o
 obj-$(CONFIG_DRM_I915_GVT_KVMGT) += gvt/kvmgt.o
diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
deleted file mode 100644
index ea8324abc784..000000000000
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-GVT_DIR := gvt
-GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
-	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
-	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
-	fb_decoder.o dmabuf.o page_track.o
-
-ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
-i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/i915/gvt/trace.h b/drivers/gpu/drm/i915/gvt/trace.h
index 6d787750d279..348f57f8301d 100644
--- a/drivers/gpu/drm/i915/gvt/trace.h
+++ b/drivers/gpu/drm/i915/gvt/trace.h
@@ -379,5 +379,5 @@ TRACE_EVENT(render_mmio,
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE trace
+#define TRACE_INCLUDE_FILE gvt/trace
 #include <trace/define_trace.h>
-- 
2.30.2

