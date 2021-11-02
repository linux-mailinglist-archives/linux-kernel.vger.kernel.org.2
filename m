Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F54427B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKBHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhKBHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60383C0613B9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gCWDnOg+1MMlzx9QrEbUzZ+VZn1ZsRtpuaaNrJVzh/w=; b=G+qDtauYKe9F7fd1WLqG8lhXxE
        p3DMSbKMpqv/xx+6WpvaHW3gYVUXk4USGB3FNqWXtEl3sOXfLU2WyCky992piissiKz1UL1A2FsgZ
        t9yGlK6GI6EQbjnaS5IcT2Hjo//bQJyRpFN3f5tXcZkDlKyd4gabGxfzvSkG6ZVb2Ir61zWh+/2dX
        rW6iKbigMKfL5lksof9ueywi79x7z7EJLlTPyo2ol2q/ypHJbsJHHiTflDHGK1XjBFFfjC3TRcUGF
        w+qHea1Xbp3WFYXlmOkyY3zkAEJwiICPZA6lhzUYg/mXdl86z3R5OWh10nvyiaosAtIJQhCOm6tkP
        ygpySBmw==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhntQ-000iEN-NN; Tue, 02 Nov 2021 07:07:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/29] drm/i915/gvt: devirtualize ->set_edid and ->set_opregion
Date:   Tue,  2 Nov 2021 08:05:47 +0100
Message-Id: <20211102070601.155501-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just call the code to setup the opregions and EDID data directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.h       |  3 +++
 drivers/gpu/drm/i915/gvt/hypercall.h |  3 ---
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  6 ++----
 drivers/gpu/drm/i915/gvt/mpt.h       | 32 ----------------------------
 drivers/gpu/drm/i915/gvt/vgpu.c      |  6 +++---
 5 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 73931601a573f..1963eac9d0cf8 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -516,6 +516,9 @@ void intel_gvt_reset_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_deactivate_vgpu(struct intel_vgpu *vgpu);
 
+int intel_gvt_set_opregion(struct intel_vgpu *vgpu);
+int intel_gvt_set_edid(struct intel_vgpu *vgpu, int port_num);
+
 /* validating GM functions */
 #define vgpu_gmadr_is_aperture(vgpu, gmadr) \
 	((gmadr >= vgpu_aperture_gmadr_base(vgpu)) && \
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index fd903d52f4314..091249a924a85 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -57,9 +57,6 @@ struct intel_gvt_mpt {
 				dma_addr_t dma_addr);
 
 	int (*dma_pin_guest_page)(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
-
-	int (*set_opregion)(struct intel_vgpu *vgpu);
-	int (*set_edid)(struct intel_vgpu *vgpu, int port_num);
 	bool (*is_valid_gfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 87dcfce3d532b..1481a48cb1f00 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -644,7 +644,7 @@ static int intel_vgpu_register_reg(struct intel_vgpu *vgpu,
 	return 0;
 }
 
-static int kvmgt_set_opregion(struct intel_vgpu *vgpu)
+int intel_gvt_set_opregion(struct intel_vgpu *vgpu)
 {
 	void *base;
 	int ret;
@@ -671,7 +671,7 @@ static int kvmgt_set_opregion(struct intel_vgpu *vgpu)
 	return ret;
 }
 
-static int kvmgt_set_edid(struct intel_vgpu *vgpu, int port_num)
+int intel_gvt_set_edid(struct intel_vgpu *vgpu, int port_num)
 {
 	struct intel_vgpu_port *port = intel_vgpu_port(vgpu, port_num);
 	struct vfio_edid_region *base;
@@ -2012,8 +2012,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
-	.set_opregion = kvmgt_set_opregion,
-	.set_edid = kvmgt_set_edid,
 	.is_valid_gfn = kvmgt_is_valid_gfn,
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 2196187203af1..9738aa3377b4b 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -210,38 +210,6 @@ intel_gvt_hypervisor_dma_pin_guest_page(struct intel_vgpu *vgpu,
 	return intel_gvt_host.mpt->dma_pin_guest_page(vgpu, dma_addr);
 }
 
-/**
- * intel_gvt_hypervisor_set_opregion - Set opregion for guest
- * @vgpu: a vGPU
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_set_opregion(struct intel_vgpu *vgpu)
-{
-	if (!intel_gvt_host.mpt->set_opregion)
-		return 0;
-
-	return intel_gvt_host.mpt->set_opregion(vgpu);
-}
-
-/**
- * intel_gvt_hypervisor_set_edid - Set EDID region for guest
- * @vgpu: a vGPU
- * @port_num: display port number
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_set_edid(struct intel_vgpu *vgpu,
-						int port_num)
-{
-	if (!intel_gvt_host.mpt->set_edid)
-		return 0;
-
-	return intel_gvt_host.mpt->set_edid(vgpu, port_num);
-}
-
 /**
  * intel_gvt_hypervisor_is_valid_gfn - check if a visible gfn
  * @vgpu: a vGPU
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 9e8fa9f388eb0..2fadd6fea5acf 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -426,14 +426,14 @@ static struct intel_vgpu *__intel_gvt_create_vgpu(struct intel_gvt *gvt,
 
 	intel_gvt_debugfs_add_vgpu(vgpu);
 
-	ret = intel_gvt_hypervisor_set_opregion(vgpu);
+	ret = intel_gvt_set_opregion(vgpu);
 	if (ret)
 		goto out_clean_sched_policy;
 
 	if (IS_BROADWELL(dev_priv) || IS_BROXTON(dev_priv))
-		ret = intel_gvt_hypervisor_set_edid(vgpu, PORT_B);
+		ret = intel_gvt_set_edid(vgpu, PORT_B);
 	else
-		ret = intel_gvt_hypervisor_set_edid(vgpu, PORT_D);
+		ret = intel_gvt_set_edid(vgpu, PORT_D);
 	if (ret)
 		goto out_clean_sched_policy;
 
-- 
2.30.2

