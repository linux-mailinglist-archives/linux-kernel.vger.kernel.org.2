Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E64427CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKBHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhKBHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEDC061225
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z7H2uMR0uxxJtXu9fOPcPDz0zbyjBDU/ALJfpwrtfLc=; b=oki75RnzfvtqpQiiC5YdcHBxKN
        toIshs+I0dp5bbcdKyD2VjlAmifpuUORQkKIwqiIXudIXTH78ES7bzy684p2DxnzSV4JKPydyPsrm
        m5NELqxHWDNOQWo5+PXjh0y/NQocWo9J5Wk6LBo5qrbzccIXzyMedugZ5hLprZ14NlmotXqz0D90l
        1OrPUuF0fE9x7mcQUcGP+ofdug3aiwHWeYqucy6EwB7J+QXgiIK/8IANM5JggjVwvIqpB6I1ZjjrP
        Xl+FCe0OR5Xh8ao/kfgnvu934/oejELliq4VvDYxAQ/Hewk1TxD2WUkspqkX2bxo3s/8Fy1TsG+mB
        5UkC+BeA==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhntn-000iIo-1g; Tue, 02 Nov 2021 07:07:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] drm/i915/gvt: devirtualize ->gfn_to_mfn
Date:   Tue,  2 Nov 2021 08:05:51 +0100
Message-Id: <20211102070601.155501-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gtt.c       |  9 +++++----
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 16 ----------------
 drivers/gpu/drm/i915/gvt/mpt.h       | 14 --------------
 4 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index d3f9c22de7761..3a7822bbf4570 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1176,15 +1176,16 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	struct intel_gvt_gtt_entry *entry)
 {
 	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
-	unsigned long pfn;
+	kvm_pfn_t pfn;
 
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
 
-	pfn = intel_gvt_hypervisor_gfn_to_mfn(vgpu, ops->get_pfn(entry));
-	if (pfn == INTEL_GVT_INVALID_ADDR)
+	if (!vgpu->attached)
+		return -EINVAL;
+	pfn = gfn_to_pfn(vgpu->kvm, ops->get_pfn(entry));
+	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
-
 	return PageTransHuge(pfn_to_page(pfn));
 }
 
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index c1a9eeed04607..dbde492cafc84 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -47,7 +47,6 @@ struct intel_gvt_mpt {
 	void (*host_exit)(struct device *dev, void *gvt);
 	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
-	unsigned long (*gfn_to_mfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 
 	int (*dma_map_guest_page)(struct intel_vgpu *vgpu, unsigned long gfn,
 				  unsigned long size, dma_addr_t *dma_addr);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index fd46f904e86a4..3bc400629920d 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1856,21 +1856,6 @@ void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 	vgpu->region = NULL;
 }
 
-static unsigned long kvmgt_gfn_to_pfn(struct intel_vgpu *vgpu,
-		unsigned long gfn)
-{
-	kvm_pfn_t pfn;
-
-	if (!vgpu->attached)
-		return INTEL_GVT_INVALID_ADDR;
-
-	pfn = gfn_to_pfn(vgpu->kvm, gfn);
-	if (is_error_noslot_pfn(pfn))
-		return INTEL_GVT_INVALID_ADDR;
-
-	return pfn;
-}
-
 static int kvmgt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size, dma_addr_t *dma_addr)
 {
@@ -1967,7 +1952,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_exit = kvmgt_host_exit,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
-	.gfn_to_mfn = kvmgt_gfn_to_pfn,
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 1a796f2181ba8..2d4bb6eaa08e3 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -99,20 +99,6 @@ static inline int intel_gvt_hypervisor_disable_page_track(
 	return intel_gvt_host.mpt->disable_page_track(vgpu, gfn);
 }
 
-/**
- * intel_gvt_hypervisor_gfn_to_mfn - translate a GFN to MFN
- * @vgpu: a vGPU
- * @gpfn: guest pfn
- *
- * Returns:
- * MFN on success, INTEL_GVT_INVALID_ADDR if failed.
- */
-static inline unsigned long intel_gvt_hypervisor_gfn_to_mfn(
-		struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	return intel_gvt_host.mpt->gfn_to_mfn(vgpu, gfn);
-}
-
 /**
  * intel_gvt_hypervisor_dma_map_guest_page - setup dma map for guest page
  * @vgpu: a vGPU
-- 
2.30.2

