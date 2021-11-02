Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F44427C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhKBHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhKBHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19CC061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zpIYHRRuh/x3eFxNb3I43glE0uRJx00tjYUDg0ZLlzM=; b=3PX4HAcPlIgXI46EZTo5yL/LJd
        HziH3rQkAbLcx1K6sVShWHXMK+ZcwtUHoOa5rsEZMVW62fQoUHEi86RWWjH0nB0zKAfW2ZBBnORCc
        K1QQYIB+vxMwK5ODaC7XwX2lYkzmEMzjFHPHZ4vGCZT0zLYsKLGujhe+iy+LE3tG3iHr8kNPXSjoB
        ZNFRSHHsT7hTCWDIp4ip79eYU6wMr3FMN+beVI6/fT2DAjRUrfE5EAlg+TkGvij9MVOf68SLmgYF6
        LDnrTZPUapty4mAm5aiK+3Lb+yjrvT4ljrcWPLwrUfedD4V6oLD01gHQ4Qwdiegs3Sxr1+1+QqK9N
        cbHV7HHQ==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnth-000iHG-CY; Tue, 02 Nov 2021 07:07:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/29] drm/i915/gvt: devirtualize ->is_valid_gfn
Date:   Tue,  2 Nov 2021 08:05:50 +0100
Message-Id: <20211102070601.155501-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just call the code directly and move towards the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gtt.c       | 20 ++++++++++++++++++--
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 17 -----------------
 drivers/gpu/drm/i915/gvt/mpt.h       | 17 -----------------
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 1a9b9b8a5d937..d3f9c22de7761 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -47,6 +47,22 @@
 static bool enable_out_of_sync = false;
 static int preallocated_oos_pages = 8192;
 
+static bool intel_gvt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
+{
+	struct kvm *kvm = vgpu->kvm;
+	int idx;
+	bool ret;
+
+	if (!vgpu->attached)
+		return false;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	ret = kvm_is_visible_gfn(kvm, gfn);
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return ret;
+}
+
 /*
  * validate a gm address and related range size,
  * translate it to host gm address
@@ -1329,7 +1345,7 @@ static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt)
 			ppgtt_set_shadow_entry(spt, &se, i);
 		} else {
 			gfn = ops->get_pfn(&ge);
-			if (!intel_gvt_hypervisor_is_valid_gfn(vgpu, gfn)) {
+			if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
 				ops->set_pfn(&se, gvt->gtt.scratch_mfn);
 				ppgtt_set_shadow_entry(spt, &se, i);
 				continue;
@@ -2313,7 +2329,7 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 		/* one PTE update may be issued in multiple writes and the
 		 * first write may not construct a valid gfn
 		 */
-		if (!intel_gvt_hypervisor_is_valid_gfn(vgpu, gfn)) {
+		if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
 			ops->set_pfn(&m, gvt->gtt.scratch_mfn);
 			goto out;
 		}
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index de63bd8dd05ba..c1a9eeed04607 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -55,7 +55,6 @@ struct intel_gvt_mpt {
 				dma_addr_t dma_addr);
 
 	int (*dma_pin_guest_page)(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
-	bool (*is_valid_gfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 };
 
 #endif /* _GVT_HYPERCALL_H_ */
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index dcec7549461f2..fd46f904e86a4 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1962,22 +1962,6 @@ static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 	mutex_unlock(&vgpu->cache_lock);
 }
 
-static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	struct kvm *kvm = vgpu->kvm;
-	int idx;
-	bool ret;
-
-	if (!vgpu->attached)
-		return false;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = kvm_is_visible_gfn(kvm, gfn);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return ret;
-}
-
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
@@ -1987,7 +1971,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
-	.is_valid_gfn = kvmgt_is_valid_gfn,
 };
 
 struct intel_gvt_host intel_gvt_host = {
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 59369e8b3b692..1a796f2181ba8 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -157,21 +157,4 @@ intel_gvt_hypervisor_dma_pin_guest_page(struct intel_vgpu *vgpu,
 	return intel_gvt_host.mpt->dma_pin_guest_page(vgpu, dma_addr);
 }
 
-/**
- * intel_gvt_hypervisor_is_valid_gfn - check if a visible gfn
- * @vgpu: a vGPU
- * @gfn: guest PFN
- *
- * Returns:
- * true on valid gfn, false on not.
- */
-static inline bool intel_gvt_hypervisor_is_valid_gfn(
-		struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	if (!intel_gvt_host.mpt->is_valid_gfn)
-		return true;
-
-	return intel_gvt_host.mpt->is_valid_gfn(vgpu, gfn);
-}
-
 #endif /* _GVT_MPT_H_ */
-- 
2.30.2

