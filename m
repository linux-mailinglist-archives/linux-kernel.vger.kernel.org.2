Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7833D12E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhGUPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhGUPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:14:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC20DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CFruYlgCsPK2YRGeBFBbj8jWjorPOh0m/2CGHuei2Bw=; b=eyMH7EBdMX1c7PcMlL/YFk+3d1
        k5flRp9ySwbsyA2ByNIhZ0mNLrCzX3pp/yAuHsyOx8HqrpzUrQ2eL8aqZpTUCgmhzQyeOdjyl9Dno
        oqYv6iGkpCz45tIPAdZZot5ByF+FMCv3dTUqgQlfLqsttfIDGwR7vuQD2n85/8WSdGz3dKAVPBfsQ
        /lSIT65kicne/Nt2IP8VUgeoKnyuUcGoTwkd2T6riO73RLwyRHL1MPRmJE5v9e2Sm2yqnoqQnfudi
        CfOzSPpT7utZdmhNbJaC08VcoiQqvwja+PVxxtdboGepN58YNobFWhLkfptYFPkGI9PnZi2lm7tJg
        TKeB6s0A==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EYI-009MFi-V4; Wed, 21 Jul 2021 15:54:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] drm/i915/gvt: remove enum hypervisor_type
Date:   Wed, 21 Jul 2021 17:53:37 +0200
Message-Id: <20210721155355.173183-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721155355.173183-1-hch@lst.de>
References: <20210721155355.173183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only supported hypervisor is KVM, so don't bother with dead code
enumerating hypervisors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.c       |  17 +--
 drivers/gpu/drm/i915/gvt/gvt.h       |   1 -
 drivers/gpu/drm/i915/gvt/hypercall.h |   6 --
 drivers/gpu/drm/i915/gvt/kvmgt.c     |   1 -
 drivers/gpu/drm/i915/gvt/opregion.c  | 150 ++++++---------------------
 5 files changed, 34 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 6d7938aacca4..ee09bba970af 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -41,11 +41,6 @@
 
 struct intel_gvt_host intel_gvt_host;
 
-static const char * const supported_hypervisors[] = {
-	[INTEL_GVT_HYPERVISOR_XEN] = "XEN",
-	[INTEL_GVT_HYPERVISOR_KVM] = "KVM",
-};
-
 static const struct intel_gvt_ops intel_gvt_ops = {
 	.emulate_cfg_read = intel_vgpu_emulate_cfg_read,
 	.emulate_cfg_write = intel_vgpu_emulate_cfg_write,
@@ -304,23 +299,13 @@ intel_gvt_register_hypervisor(const struct intel_gvt_mpt *m)
 	if (!intel_gvt_host.initialized)
 		return -ENODEV;
 
-	if (m->type != INTEL_GVT_HYPERVISOR_KVM &&
-	    m->type != INTEL_GVT_HYPERVISOR_XEN)
-		return -EINVAL;
-
 	intel_gvt_host.mpt = m;
-	intel_gvt_host.hypervisor_type = m->type;
 	gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
 
 	ret = intel_gvt_hypervisor_host_init(intel_gvt_host.dev, gvt,
 					     &intel_gvt_ops);
-	if (ret < 0) {
-		gvt_err("Failed to init %s hypervisor module\n",
-			supported_hypervisors[intel_gvt_host.hypervisor_type]);
+	if (ret < 0)
 		return -ENODEV;
-	}
-	gvt_dbg_core("Running with hypervisor %s in host mode\n",
-		     supported_hypervisors[intel_gvt_host.hypervisor_type]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(intel_gvt_register_hypervisor);
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 0c0615602343..9b9fdbf9df10 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -59,7 +59,6 @@
 struct intel_gvt_host {
 	struct device *dev;
 	bool initialized;
-	int hypervisor_type;
 	const struct intel_gvt_mpt *mpt;
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index f33e3cbd0439..317983153645 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -37,17 +37,11 @@
 
 struct device;
 
-enum hypervisor_type {
-	INTEL_GVT_HYPERVISOR_XEN = 0,
-	INTEL_GVT_HYPERVISOR_KVM,
-};
-
 /*
  * Specific GVT-g MPT modules function collections. Currently GVT-g supports
  * both Xen and KVM by providing dedicated hypervisor-related MPT modules.
  */
 struct intel_gvt_mpt {
-	enum hypervisor_type type;
 	int (*host_init)(struct device *dev, void *gvt, const void *ops);
 	void (*host_exit)(struct device *dev, void *gvt);
 	int (*attach_vgpu)(void *vgpu, unsigned long *handle);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 1ac98f8aba31..0d0902d7405d 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -2204,7 +2204,6 @@ static bool kvmgt_is_valid_gfn(unsigned long handle, unsigned long gfn)
 }
 
 static const struct intel_gvt_mpt kvmgt_mpt = {
-	.type = INTEL_GVT_HYPERVISOR_KVM,
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
 	.attach_vgpu = kvmgt_attach_vgpu,
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 33569b910ed5..286ac6d7c6ce 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -255,33 +255,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	return 0;
 }
 
-static int map_vgpu_opregion(struct intel_vgpu *vgpu, bool map)
-{
-	u64 mfn;
-	int i, ret;
-
-	for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++) {
-		mfn = intel_gvt_hypervisor_virt_to_mfn(vgpu_opregion(vgpu)->va
-			+ i * PAGE_SIZE);
-		if (mfn == INTEL_GVT_INVALID_ADDR) {
-			gvt_vgpu_err("fail to get MFN from VA\n");
-			return -EINVAL;
-		}
-		ret = intel_gvt_hypervisor_map_gfn_to_mfn(vgpu,
-				vgpu_opregion(vgpu)->gfn[i],
-				mfn, 1, map);
-		if (ret) {
-			gvt_vgpu_err("fail to map GFN to MFN, errno: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	vgpu_opregion(vgpu)->mapped = map;
-
-	return 0;
-}
-
 /**
  * intel_vgpu_opregion_base_write_handler - Opregion base register write handler
  *
@@ -294,34 +267,13 @@ static int map_vgpu_opregion(struct intel_vgpu *vgpu, bool map)
 int intel_vgpu_opregion_base_write_handler(struct intel_vgpu *vgpu, u32 gpa)
 {
 
-	int i, ret = 0;
+	int i;
 
 	gvt_dbg_core("emulate opregion from kernel\n");
 
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_KVM:
-		for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
-			vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
-		break;
-	case INTEL_GVT_HYPERVISOR_XEN:
-		/**
-		 * Wins guest on Xengt will write this register twice: xen
-		 * hvmloader and windows graphic driver.
-		 */
-		if (vgpu_opregion(vgpu)->mapped)
-			map_vgpu_opregion(vgpu, false);
-
-		for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
-			vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
-
-		ret = map_vgpu_opregion(vgpu, true);
-		break;
-	default:
-		ret = -EINVAL;
-		gvt_vgpu_err("not supported hypervisor\n");
-	}
-
-	return ret;
+	for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
+		vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
+	return 0;
 }
 
 /**
@@ -336,12 +288,7 @@ void intel_vgpu_clean_opregion(struct intel_vgpu *vgpu)
 	if (!vgpu_opregion(vgpu)->va)
 		return;
 
-	if (intel_gvt_host.hypervisor_type == INTEL_GVT_HYPERVISOR_XEN) {
-		if (vgpu_opregion(vgpu)->mapped)
-			map_vgpu_opregion(vgpu, false);
-	} else if (intel_gvt_host.hypervisor_type == INTEL_GVT_HYPERVISOR_KVM) {
-		/* Guest opregion is released by VFIO */
-	}
+	/* Guest opregion is released by VFIO */
 	free_pages((unsigned long)vgpu_opregion(vgpu)->va,
 		   get_order(INTEL_GVT_OPREGION_SIZE));
 
@@ -470,39 +417,22 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 	u64 scic_pa = 0, parm_pa = 0;
 	int ret;
 
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_XEN:
-		scic = *((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_SCIC);
-		parm = *((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_PARM);
-		break;
-	case INTEL_GVT_HYPERVISOR_KVM:
-		scic_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
-					INTEL_GVT_OPREGION_SCIC;
-		parm_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
-					INTEL_GVT_OPREGION_PARM;
-
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, scic_pa,
-						    &scic, sizeof(scic));
-		if (ret) {
-			gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
-
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, parm_pa,
-						    &parm, sizeof(parm));
-		if (ret) {
-			gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
+	scic_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
+				INTEL_GVT_OPREGION_SCIC;
+	parm_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
+				INTEL_GVT_OPREGION_PARM;
+	ret = intel_gvt_hypervisor_read_gpa(vgpu, scic_pa, &scic, sizeof(scic));
+	if (ret) {
+		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
+	}
 
-		break;
-	default:
-		gvt_vgpu_err("not supported hypervisor\n");
-		return -EINVAL;
+	ret = intel_gvt_hypervisor_read_gpa(vgpu, parm_pa, &parm, sizeof(parm));
+	if (ret) {
+		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
 	}
 
 	if (!(swsci & SWSCI_SCI_SELECT)) {
@@ -535,34 +465,20 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 	parm = 0;
 
 out:
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_XEN:
-		*((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_SCIC) = scic;
-		*((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_PARM) = parm;
-		break;
-	case INTEL_GVT_HYPERVISOR_KVM:
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, scic_pa,
-						    &scic, sizeof(scic));
-		if (ret) {
-			gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
-
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, parm_pa,
-						    &parm, sizeof(parm));
-		if (ret) {
-			gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
+	ret = intel_gvt_hypervisor_write_gpa(vgpu, scic_pa, &scic,
+					     sizeof(scic));
+	if (ret) {
+		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
+	}
 
-		break;
-	default:
-		gvt_vgpu_err("not supported hypervisor\n");
-		return -EINVAL;
+	ret = intel_gvt_hypervisor_write_gpa(vgpu, parm_pa, &parm,
+					     sizeof(parm));
+	if (ret) {
+		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
 	}
 
 	return 0;
-- 
2.30.2

