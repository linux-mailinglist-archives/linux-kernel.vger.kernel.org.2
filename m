Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86CC449E27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhKHVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhKHVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:30:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D8C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:27:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u11so39417448lfs.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=szzjjGu57F1UNGE99GMCdFzS2u7sEVVtyt9kYnjiTBc=;
        b=je3jIHscqh1oMlgYYnMqkd3p7nakiJzMBsjbL3FMk6yJmdxWnH+KVIooFnp/x1qrL4
         G70YO/w+6ur5ldwzfchwQy95JMJMtpxjQeHsunKn474pvKO/QOrajQVaILiMdqrn3cLz
         Kz1oDLrzCq/u1vcZtSpnZuZAMWYC3VInhfaDv1O2hb1y8CU2wBcCuO9lIUB0OO74YylL
         fCalrqjDxR44dmKD1ASDPVwHnn2jvU55V4yL6C+Ttk3hVgqHtys+rxTTvJ0TbOYtUmqd
         IjOCV8o/lPhdS/LJztPsxuPes+N1rW8eHZ3F58tqxu1jJghSmHuEjDaiUdFFgksg94yE
         lbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=szzjjGu57F1UNGE99GMCdFzS2u7sEVVtyt9kYnjiTBc=;
        b=Rg5XKpxuiiyNmUP/h4IRn7+qHFJlBpvfTmz/IbB8SzB0u9C3T3uQKz7zfXuhCxiaKi
         hIQfu32MAD92zVUDyJK8qMMcU1msbU4aKeb8gSax7ihrYEGi+1IoqxXTt9vxOYqUDSbJ
         Q0lpSjlgViqols1t0ANgcqXA+l9Xkydh3YYXhzbYFm/7l8St1Ve4KYP90vsrOA51NMef
         rY49LNZDrh6TM9axiBRsuCL5md2hbAUpmcnO4dDlC/U91zn2zHZDo4W/+yquZUanub0Z
         YeLa0DA3wlnh1HVfmxqVJe1w7IGm9Odqf4yw/7TwD2yAOmaQZv7Mx9tkjnAWIEN4HV/l
         Xzhg==
X-Gm-Message-State: AOAM531J3joIhlUXshWRdVD0jSR8HTTccy/Dj1qSOpUV909jgFFiRI3n
        qNQksrRidqJkoeQc4HppEF0=
X-Google-Smtp-Source: ABdhPJx/ToKd4a6+WOfSeorR6LEm/MGsIroD/Jc8tEr9dguE45/BO3wnDlqPmabD9Rl4xp0t8Qnjwg==
X-Received: by 2002:a19:7709:: with SMTP id s9mr2240852lfc.682.1636406843756;
        Mon, 08 Nov 2021 13:27:23 -0800 (PST)
Received: from zhiwang1-mobl.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id y11sm212671ljh.54.2021.11.08.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:27:23 -0800 (PST)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jgg@nvidia.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>
Subject: [PATCH 3/3] i915/gvt: Use the initial HW state snapshot saved in i915
Date:   Mon,  8 Nov 2021 16:27:18 -0500
Message-Id: <20211108212718.10576-3-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108212718.10576-1-zhi.a.wang@intel.com>
References: <20211108212718.10576-1-zhi.a.wang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhi Wang <zhi.wang.linux@gmail.com>

The code of saving initial HW state snapshot has been moved into i915.
Let the GVT-g core logic use that snapshot.

Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Zhi Wang <zhi.wang.linux@gmail.com>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c |  2 +-
 drivers/gpu/drm/i915/gvt/firmware.c  | 45 ++++------------------------
 drivers/gpu/drm/i915/gvt/gvt.h       |  2 --
 drivers/gpu/drm/i915/gvt/mmio.c      |  2 +-
 4 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index b490e3db2e38..51588ca95113 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -379,7 +379,7 @@ void intel_vgpu_init_cfg_space(struct intel_vgpu *vgpu,
 	u16 *gmch_ctl;
 	u8 next;
 
-	memcpy(vgpu_cfg_space(vgpu), gvt->firmware.cfg_space,
+	memcpy(vgpu_cfg_space(vgpu), gvt->hw_state.cfg_space,
 	       info->cfg_space_size);
 
 	if (!primary) {
diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 1a8274a3f4b1..a98af544abca 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -66,13 +66,6 @@ static struct bin_attribute firmware_attr = {
 	.mmap = NULL,
 };
 
-static int mmio_snapshot_handler(struct intel_gvt *gvt, u32 offset, void *data)
-{
-	*(u32 *)(data + offset) = intel_uncore_read_notrace(gvt->gt->uncore,
-							    _MMIO(offset));
-	return 0;
-}
-
 static int expose_firmware_sysfs(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
@@ -81,7 +74,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 	void *firmware;
 	void *p;
 	unsigned long size, crc32_start;
-	int i, ret;
+	int ret;
 
 	size = sizeof(*h) + info->mmio_size + info->cfg_space_size;
 	firmware = vzalloc(size);
@@ -99,17 +92,11 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 
 	p = firmware + h->cfg_space_offset;
 
-	for (i = 0; i < h->cfg_space_size; i += 4)
-		pci_read_config_dword(pdev, i, p + i);
-
-	memcpy(gvt->firmware.cfg_space, p, info->cfg_space_size);
+	memcpy(gvt->hw_state.cfg_space, p, info->cfg_space_size);
 
 	p = firmware + h->mmio_offset;
 
-	/* Take a snapshot of hw mmio registers. */
-	intel_gvt_for_each_tracked_mmio(gvt, mmio_snapshot_handler, p);
-
-	memcpy(gvt->firmware.mmio, p, info->mmio_size);
+	memcpy(gvt->hw_state.mmio, p, info->mmio_size);
 
 	crc32_start = offsetof(struct gvt_firmware_header, crc32) + 4;
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
@@ -142,9 +129,6 @@ void intel_gvt_free_firmware(struct intel_gvt *gvt)
 {
 	if (!gvt->firmware.firmware_loaded)
 		clean_firmware_sysfs(gvt);
-
-	kfree(gvt->firmware.cfg_space);
-	vfree(gvt->firmware.mmio);
 }
 
 static int verify_firmware(struct intel_gvt *gvt,
@@ -204,36 +188,17 @@ static int verify_firmware(struct intel_gvt *gvt,
  */
 int intel_gvt_load_firmware(struct intel_gvt *gvt)
 {
-	struct intel_gvt_device_info *info = &gvt->device_info;
 	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	struct intel_gvt_firmware *firmware = &gvt->firmware;
 	struct gvt_firmware_header *h;
 	const struct firmware *fw;
 	char *path;
-	void *mem;
 	int ret;
 
 	path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
-	mem = kmalloc(info->cfg_space_size, GFP_KERNEL);
-	if (!mem) {
-		kfree(path);
-		return -ENOMEM;
-	}
-
-	firmware->cfg_space = mem;
-
-	mem = vmalloc(info->mmio_size);
-	if (!mem) {
-		kfree(path);
-		kfree(firmware->cfg_space);
-		return -ENOMEM;
-	}
-
-	firmware->mmio = mem;
-
 	sprintf(path, "%s/vid_0x%04x_did_0x%04x_rid_0x%02x.golden_hw_state",
 		 GVT_FIRMWARE_PATH, pdev->vendor, pdev->device,
 		 pdev->revision);
@@ -256,9 +221,9 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt)
 
 	h = (struct gvt_firmware_header *)fw->data;
 
-	memcpy(firmware->cfg_space, fw->data + h->cfg_space_offset,
+	memcpy(gvt->hw_state.cfg_space, fw->data + h->cfg_space_offset,
 	       h->cfg_space_size);
-	memcpy(firmware->mmio, fw->data + h->mmio_offset,
+	memcpy(gvt->hw_state.mmio, fw->data + h->mmio_offset,
 	       h->mmio_size);
 
 	release_firmware(fw);
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 1defee730cf3..4e2fd564abea 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -280,8 +280,6 @@ struct intel_gvt_mmio {
 };
 
 struct intel_gvt_firmware {
-	void *cfg_space;
-	void *mmio;
 	bool firmware_loaded;
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/mmio.c
index 24210b1eaec5..63f806113560 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.c
+++ b/drivers/gpu/drm/i915/gvt/mmio.c
@@ -241,7 +241,7 @@ void intel_vgpu_reset_mmio(struct intel_vgpu *vgpu, bool dmlr)
 {
 	struct intel_gvt *gvt = vgpu->gvt;
 	const struct intel_gvt_device_info *info = &gvt->device_info;
-	void  *mmio = gvt->firmware.mmio;
+	void  *mmio = gvt->hw_state.mmio;
 
 	if (dmlr) {
 		memcpy(vgpu->mmio.vreg, mmio, info->mmio_size);
-- 
2.25.1

