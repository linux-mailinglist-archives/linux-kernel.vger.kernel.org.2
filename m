Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95694427B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhKBHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhKBHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902CC061766
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g5/OGp0rG03Vs2+KvxKPUdymR3PClSaeZFtaqT9ZUEk=; b=Qhvd+VENJ35jshMap44FVsCJLV
        FHZnPrJnZtxcDbc16wn41FWgXy4KbWo5ehpSdrv5qjJJMAB2vUB/qN+98i0zLP7ytCIML55iiUuqE
        +YSTYZGWvW308zWhKHeCcReu7bB2dcfzx1AmOj9uDoNQmlXqoTgfdE+rHtOrZsnio+4L7NN2QrpHq
        9jOW6BYVFlBWlWsfwIGHTv5GQY6c+RLZxbQGSquaUmIsYnEp/v/RYtY7Uw5CfXiAa0s0FtcuYEhnA
        WN/YjEZAyGzcL8xniIn/yRoBpMvxZDpFpdg81NSYqvaM7WyKEYhn3Ph1Qxy+BIQWeMNKCeTRVBite
        Y74jCgIg==;
Received: from 213-225-15-89.nat.highway.a1.net ([213.225.15.89] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhntb-000iGo-Ka; Tue, 02 Nov 2021 07:07:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] drm/i915/gvt: devirtualize ->inject_msi
Date:   Tue,  2 Nov 2021 08:05:49 +0100
Message-Id: <20211102070601.155501-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102070601.155501-1-hch@lst.de>
References: <20211102070601.155501-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just open code the MSI injection in a single place instead of going
through the method table.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/interrupt.c | 38 +++++++++++++++++++++++++++-
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 24 ------------------
 drivers/gpu/drm/i915/gvt/mpt.h       | 37 ---------------------------
 4 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 08c622c4079bb..de63bd8dd05ba 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -45,7 +45,6 @@ struct intel_vgpu;
 struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
-	int (*inject_msi)(struct intel_vgpu *vgpu, u32 addr, u16 data);
 	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	unsigned long (*gfn_to_mfn)(struct intel_vgpu *vgpu, unsigned long gfn);
diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
index 614b951d919fc..f3c350a9a80f5 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.c
+++ b/drivers/gpu/drm/i915/gvt/interrupt.c
@@ -396,9 +396,45 @@ static void init_irq_map(struct intel_gvt_irq *irq)
 }
 
 /* =======================vEvent injection===================== */
+
+#define MSI_CAP_CONTROL(offset) (offset + 2)
+#define MSI_CAP_ADDRESS(offset) (offset + 4)
+#define MSI_CAP_DATA(offset) (offset + 8)
+#define MSI_CAP_EN 0x1
+
 static int inject_virtual_interrupt(struct intel_vgpu *vgpu)
 {
-	return intel_gvt_hypervisor_inject_msi(vgpu);
+	unsigned long offset = vgpu->gvt->device_info.msi_cap_offset;
+	u16 control, data;
+	u32 addr;
+
+	control = *(u16 *)(vgpu_cfg_space(vgpu) + MSI_CAP_CONTROL(offset));
+	addr = *(u32 *)(vgpu_cfg_space(vgpu) + MSI_CAP_ADDRESS(offset));
+	data = *(u16 *)(vgpu_cfg_space(vgpu) + MSI_CAP_DATA(offset));
+
+	/* Do not generate MSI if MSIEN is disabled */
+	if (!(control & MSI_CAP_EN))
+		return 0;
+
+	if (WARN(control & GENMASK(15, 1), "only support one MSI format\n"))
+		return -EINVAL;
+
+	trace_inject_msi(vgpu->id, addr, data);
+
+	/*
+	 * When guest is powered off, msi_trigger is set to NULL, but vgpu's
+	 * config and mmio register isn't restored to default during guest
+	 * poweroff. If this vgpu is still used in next vm, this vgpu's pipe
+	 * may be enabled, then once this vgpu is active, it will get inject
+	 * vblank interrupt request. But msi_trigger is null until msi is
+	 * enabled by guest. so if msi_trigger is null, success is still
+	 * returned and don't inject interrupt into guest.
+	 */
+	if (!vgpu->attached)
+		return -ESRCH;
+	if (vgpu->msi_trigger && eventfd_signal(vgpu->msi_trigger, 1) != 1)
+		return -EFAULT;
+	return 0;
 }
 
 static void propagate_event(struct intel_gvt_irq *irq,
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 13d4551b566f9..dcec7549461f2 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1856,29 +1856,6 @@ void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 	vgpu->region = NULL;
 }
 
-static int kvmgt_inject_msi(struct intel_vgpu *vgpu, u32 addr, u16 data)
-{
-	if (!vgpu->attached)
-		return -ESRCH;
-
-	/*
-	 * When guest is poweroff, msi_trigger is set to NULL, but vgpu's
-	 * config and mmio register isn't restored to default during guest
-	 * poweroff. If this vgpu is still used in next vm, this vgpu's pipe
-	 * may be enabled, then once this vgpu is active, it will get inject
-	 * vblank interrupt request. But msi_trigger is null until msi is
-	 * enabled by guest. so if msi_trigger is null, success is still
-	 * returned and don't inject interrupt into guest.
-	 */
-	if (vgpu->msi_trigger == NULL)
-		return 0;
-
-	if (eventfd_signal(vgpu->msi_trigger, 1) == 1)
-		return 0;
-
-	return -EFAULT;
-}
-
 static unsigned long kvmgt_gfn_to_pfn(struct intel_vgpu *vgpu,
 		unsigned long gfn)
 {
@@ -2004,7 +1981,6 @@ static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.inject_msi = kvmgt_inject_msi,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
 	.gfn_to_mfn = kvmgt_gfn_to_pfn,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 78efcf1e69469..59369e8b3b692 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,43 +71,6 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-#define MSI_CAP_CONTROL(offset) (offset + 2)
-#define MSI_CAP_ADDRESS(offset) (offset + 4)
-#define MSI_CAP_DATA(offset) (offset + 8)
-#define MSI_CAP_EN 0x1
-
-/**
- * intel_gvt_hypervisor_inject_msi - inject a MSI interrupt into vGPU
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_inject_msi(struct intel_vgpu *vgpu)
-{
-	unsigned long offset = vgpu->gvt->device_info.msi_cap_offset;
-	u16 control, data;
-	u32 addr;
-	int ret;
-
-	control = *(u16 *)(vgpu_cfg_space(vgpu) + MSI_CAP_CONTROL(offset));
-	addr = *(u32 *)(vgpu_cfg_space(vgpu) + MSI_CAP_ADDRESS(offset));
-	data = *(u16 *)(vgpu_cfg_space(vgpu) + MSI_CAP_DATA(offset));
-
-	/* Do not generate MSI if MSIEN is disable */
-	if (!(control & MSI_CAP_EN))
-		return 0;
-
-	if (WARN(control & GENMASK(15, 1), "only support one MSI format\n"))
-		return -EINVAL;
-
-	trace_inject_msi(vgpu->id, addr, data);
-
-	ret = intel_gvt_host.mpt->inject_msi(vgpu, addr, data);
-	if (ret)
-		return ret;
-	return 0;
-}
-
 /**
  * intel_gvt_hypervisor_enable_page_track - track a guest page
  * @vgpu: a vGPU
-- 
2.30.2

