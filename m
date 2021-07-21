Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C13D1313
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhGUPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbhGUPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:18:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC1C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rhgYkSM2KrtiQ2UW6ZK8t+lwuqGluamH30ixmb/SaAE=; b=hh55SBeqe8TDP+RTwhU8vXYK6A
        GhdqDHiVJfSeNXrzHL8wlLiOIrrd4tjWswf8bZV545a0VISYpwRn7X2SMacOd0SCC9Mpox7+VMIpr
        G8tQCv0lkhfBLtB6R4eVn7Leg5g2l3mFuBeIfwUCQYgOPKHwBL/Zv8oNvF1UqqkiO1msdCgTxZT2d
        HCC6EEh2j/FZJjtviyIq3VQJ7rOUY8Tj6tknFWAiYMlar5q1zJdXYM7qaJ0S4Hvjo2zy17JhYtiwl
        h8osILShMoItis0CEAZz+C/x+8y9C5HKwhJCcjCo4TGp6srU1qut9/kIHTvrbh9u/c/E9ytfP6Yty
        yG35NSkg==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EcI-009MYx-Cf; Wed, 21 Jul 2021 15:58:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] drm/i915/gvt: devirtualize ->detach_vgpu
Date:   Wed, 21 Jul 2021 17:53:48 +0200
Message-Id: <20210721155355.173183-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721155355.173183-1-hch@lst.de>
References: <20210721155355.173183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just call the function directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.h       |  1 +
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  3 +--
 drivers/gpu/drm/i915/gvt/mpt.h       | 16 ----------------
 drivers/gpu/drm/i915/gvt/vgpu.c      |  2 +-
 5 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 1cb4b48d9a25..82cd00a5b904 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -580,6 +580,7 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu);
 
 int intel_gvt_scan_and_shadow_workload(struct intel_vgpu_workload *workload);
 void enter_failsafe_mode(struct intel_vgpu *vgpu, int reason);
+void intel_vgpu_detach_regions(struct intel_vgpu *vgpu);
 
 enum {
 	GVT_FAILSAFE_UNSUPPORTED_GUEST,
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 091249a924a8..08c622c4079b 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -45,7 +45,6 @@ struct intel_vgpu;
 struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
-	void (*detach_vgpu)(struct intel_vgpu *vgpu);
 	int (*inject_msi)(struct intel_vgpu *vgpu, u32 addr, u16 data);
 	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 572d51950abb..218c3deaf2b4 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1839,7 +1839,7 @@ static bool kvmgt_guest_exit(struct intel_vgpu *info)
 	return true;
 }
 
-static void kvmgt_detach_vgpu(struct intel_vgpu *vgpu)
+void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 {
 	int i;
 
@@ -2003,7 +2003,6 @@ static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.detach_vgpu = kvmgt_detach_vgpu,
 	.inject_msi = kvmgt_inject_msi,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 9738aa3377b4..78efcf1e6946 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,22 +71,6 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-/**
- * intel_gvt_hypervisor_detach_vgpu - call hypervisor to release vGPU
- * related stuffs inside hypervisor.
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline void intel_gvt_hypervisor_detach_vgpu(struct intel_vgpu *vgpu)
-{
-	/* optional to provide */
-	if (!intel_gvt_host.mpt->detach_vgpu)
-		return;
-
-	intel_gvt_host.mpt->detach_vgpu(vgpu);
-}
-
 #define MSI_CAP_CONTROL(offset) (offset + 2)
 #define MSI_CAP_ADDRESS(offset) (offset + 4)
 #define MSI_CAP_DATA(offset) (offset + 8)
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 2fadd6fea5ac..7a7f768083d2 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -293,7 +293,7 @@ void intel_gvt_destroy_vgpu(struct intel_vgpu *vgpu)
 	intel_vgpu_clean_opregion(vgpu);
 	intel_vgpu_reset_ggtt(vgpu, true);
 	intel_vgpu_clean_gtt(vgpu);
-	intel_gvt_hypervisor_detach_vgpu(vgpu);
+	intel_vgpu_detach_regions(vgpu);
 	intel_vgpu_free_resource(vgpu);
 	intel_vgpu_clean_mmio(vgpu);
 	intel_vgpu_dmabuf_cleanup(vgpu);
-- 
2.30.2

