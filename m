Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD242E43E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhJNWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhJNWfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634250807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=egnKqCHkR4Fnj6NN7fmxhEU7pCui8wPPPUhMDYH+2HQ=;
        b=TW3WsR3TslkoUb0oACbO/s50dZVQaeTr/dECghGHBZkajvQmpPkbeeqjI4ywGFylIGFuEg
        ty+JxuKeSfj21Y7XgRYlILm0Q1mtXOEr3IMJ+IYve5B7QErSZD24/vaW4jEwPLx50vpSdu
        HgV83CwbI+4UN2HbrATjGhheYgOH7B4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-HhohRMUWPW2F9cZxSkTtgg-1; Thu, 14 Oct 2021 18:33:24 -0400
X-MC-Unique: HhohRMUWPW2F9cZxSkTtgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9769E18D6A2C;
        Thu, 14 Oct 2021 22:33:21 +0000 (UTC)
Received: from mguma.remote.csb (unknown [10.22.16.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3C2E70886;
        Thu, 14 Oct 2021 22:33:08 +0000 (UTC)
From:   Mwesigwa Guma <mguma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mwesigwa Guma <mguma@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, fedora-rpi@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>,
        Chukpozohn Toe <ctoe@redhat.com>,
        Clark Williams <clark@redhat.com>
Subject: [PATCH] staging: vchiq_arm: Add 36-bit address support
Date:   Thu, 14 Oct 2021 18:32:30 -0400
Message-Id: <20211014223230.451659-1-mguma@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ojaswin Mujoo <ojaswin98@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-rpi-kernel@lists.infradead.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-staging@lists.linux.dev 
Cc: fedora-rpi@googlegroups.com
Cc: Joel Savitz <jsavitz@redhat.com>
Cc: Chukpozohn Toe <ctoe@redhat.com>
Cc: Clark Williams <clark@redhat.com>

This is a forward port of Phil Elwell's commit from the Raspberry Pi
Linux fork described as follows [1]:

    Conditional on a new compatible string, change the pagelist encoding
    such that the top 24 bits are the pfn, leaving 8 bits for run length
    (-1), giving a 36-bit address range.
    
    Manage the split between addresses for the VPU and addresses for the
    40-bit DMA controller with a dedicated DMA device pointer that on non-
    BCM2711 platforms is the same as the main VCHIQ device. This allows
    the VCHIQ node to stay in the usual place in the DT.

This commit enables VCHIQ device access on a Raspberry Pi 4B running the 
mainline Linux kernel.

Tested on Fedora Linux running on a Raspberry Pi 4B.

[1]: https://github.com/raspberrypi/linux/commit/97268fd23eb8d08dc74eac5e3fd697303de26610

Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 131 +++++++++++++++---
 .../interface/vchiq_arm/vchiq_arm.h           |   1 +
 2 files changed, 109 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b25369a13452..888526694e56 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -67,6 +67,9 @@ struct vchiq_state g_state;
 
 static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
+static struct platform_device *bcm2835_codec;
+static struct platform_device *vcsm_cma;
+static struct platform_device *bcm2835_isp;
 
 static struct vchiq_drvdata bcm2835_drvdata = {
 	.cache_line_size = 32,
@@ -76,6 +79,11 @@ static struct vchiq_drvdata bcm2836_drvdata = {
 	.cache_line_size = 64,
 };
 
+static struct vchiq_drvdata bcm2711_drvdata = {
+	.cache_line_size = 64,
+	.use_36bit_addrs = true,
+};
+
 struct vchiq_2835_state {
 	int inited;
 	struct vchiq_arm_state arm_state;
@@ -105,11 +113,13 @@ static void __iomem *g_regs;
  * of 32.
  */
 static unsigned int g_cache_line_size = 32;
+static unsigned int g_use_36bit_addrs;
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
 static struct device *g_dev;
+static struct device *g_dma_dev;
 
 static DEFINE_SEMAPHORE(g_free_fragments_mutex);
 
@@ -139,7 +149,7 @@ static void
 cleanup_pagelistinfo(struct vchiq_pagelist_info *pagelistinfo)
 {
 	if (pagelistinfo->scatterlist_mapped) {
-		dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
+		dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
 			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
 	}
 
@@ -288,7 +298,7 @@ create_pagelist(char *buf, char __user *ubuf,
 		count -= len;
 	}
 
-	dma_buffers = dma_map_sg(g_dev,
+	dma_buffers = dma_map_sg(g_dma_dev,
 				 scatterlist,
 				 num_pages,
 				 pagelistinfo->dma_dir);
@@ -302,25 +312,61 @@ create_pagelist(char *buf, char __user *ubuf,
 
 	/* Combine adjacent blocks for performance */
 	k = 0;
-	for_each_sg(scatterlist, sg, dma_buffers, i) {
-		u32 len = sg_dma_len(sg);
-		u32 addr = sg_dma_address(sg);
+	if (g_use_36bit_addrs) {
+		for_each_sg(scatterlist, sg, dma_buffers, i) {
+			u32 len = sg_dma_len(sg);
+			u64 addr = sg_dma_address(sg);
+			u32 page_id = (u32)((addr >> 4) & ~0xff);
+			u32 sg_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+			/* Note: addrs is the address + page_count - 1
+			 * The firmware expects blocks after the first to be page-
+			 * aligned and a multiple of the page size
+			 */
+			WARN_ON(len == 0);
+			WARN_ON(i &&
+				(i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
+			WARN_ON(i && (addr & ~PAGE_MASK));
+			WARN_ON(upper_32_bits(addr) > 0xf);
+			if (k > 0 &&
+			    ((addrs[k - 1] & ~0xff) +
+			     (((addrs[k - 1] & 0xff) + 1) << 8)
+			     == page_id)) {
+				u32 inc_pages = min(sg_pages,
+						    0xff - (addrs[k - 1] & 0xff));
+				addrs[k - 1] += inc_pages;
+				page_id += inc_pages << 8;
+				sg_pages -= inc_pages;
+			}
+			while (sg_pages) {
+				u32 inc_pages = min(sg_pages, 0x100u);
 
-		/* Note: addrs is the address + page_count - 1
-		 * The firmware expects blocks after the first to be page-
-		 * aligned and a multiple of the page size
-		 */
-		WARN_ON(len == 0);
-		WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
-		WARN_ON(i && (addr & ~PAGE_MASK));
-		if (k > 0 &&
-		    ((addrs[k - 1] & PAGE_MASK) +
-		     (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT))
-		    == (addr & PAGE_MASK))
-			addrs[k - 1] += ((len + PAGE_SIZE - 1) >> PAGE_SHIFT);
-		else
-			addrs[k++] = (addr & PAGE_MASK) |
-				(((len + PAGE_SIZE - 1) >> PAGE_SHIFT) - 1);
+				addrs[k++] = page_id | (inc_pages - 1);
+				page_id += inc_pages << 8;
+				sg_pages -= inc_pages;
+			}
+		}
+	} else {
+		for_each_sg(scatterlist, sg, dma_buffers, i) {
+			u32 len = sg_dma_len(sg);
+			u32 addr = sg_dma_address(sg);
+			u32 new_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+			/* Note: addrs is the address + page_count - 1
+			 * The firmware expects blocks after the first to be page-
+			 * aligned and a multiple of the page size
+			 */
+			WARN_ON(len == 0);
+			WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
+			WARN_ON(i && (addr & ~PAGE_MASK));
+			if (k > 0 &&
+			    ((addrs[k - 1] & PAGE_MASK) +
+			     (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT))
+			    == (addr & PAGE_MASK))
+				addrs[k - 1] += new_pages;
+			else
+				addrs[k++] = (addr & PAGE_MASK) | (new_pages - 1);
+		}
 	}
 
 	/* Partial cache lines (fragments) require special measures */
@@ -364,7 +410,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 	 * NOTE: dma_unmap_sg must be called before the
 	 * cpu can touch any of the data/pages.
 	 */
-	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
+	dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
 		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
 	pagelistinfo->scatterlist_mapped = 0;
 
@@ -422,6 +468,7 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 {
 	struct device *dev = &pdev->dev;
+	struct device *dma_dev = NULL;
 	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
 	struct rpi_firmware *fw = drvdata->fw;
 	struct vchiq_slot_zero *vchiq_slot_zero;
@@ -443,6 +490,24 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	g_cache_line_size = drvdata->cache_line_size;
 	g_fragments_size = 2 * g_cache_line_size;
 
+	if (drvdata->use_36bit_addrs) {
+		struct device_node *dma_node =
+			of_find_compatible_node(NULL, NULL, "brcm,bcm2711-dma");
+
+		if (dma_node) {
+			struct platform_device *pdev;
+
+			pdev = of_find_device_by_node(dma_node);
+			if (pdev)
+				dma_dev = &pdev->dev;
+			of_node_put(dma_node);
+			g_use_36bit_addrs = true;
+		} else {
+			dev_err(dev, "40-bit DMA controller not found\n");
+			return -EINVAL;
+		}
+	}
+
 	/* Allocate space for the channels in coherent memory */
 	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
 	frag_mem_size = PAGE_ALIGN(g_fragments_size * MAX_FRAGMENTS);
@@ -455,13 +520,14 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	}
 
 	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
+	channelbase = slot_phys;
 
 	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
 	if (!vchiq_slot_zero)
 		return -EINVAL;
 
 	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
-		(int)slot_phys + slot_mem_size;
+		channelbase + slot_mem_size;
 	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX] =
 		MAX_FRAGMENTS;
 
@@ -495,7 +561,6 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	}
 
 	/* Send the base address of the slots to VideoCore */
-	channelbase = slot_phys;
 	err = rpi_firmware_property(fw, RPI_FIRMWARE_VCHIQ_INIT,
 				    &channelbase, sizeof(channelbase));
 	if (err || channelbase) {
@@ -504,6 +569,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	}
 
 	g_dev = dev;
+	g_dma_dev = dma_dev ?: dev;
+
 	vchiq_log_info(vchiq_arm_log_level,
 		"vchiq_init - done (slots %pK, phys %pad)",
 		vchiq_slot_zero, &slot_phys);
@@ -1746,6 +1813,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 static const struct of_device_id vchiq_of_match[] = {
 	{ .compatible = "brcm,bcm2835-vchiq", .data = &bcm2835_drvdata },
 	{ .compatible = "brcm,bcm2836-vchiq", .data = &bcm2836_drvdata },
+	{ .compatible = "brcm,bcm2711-vchiq", .data = &bcm2711_drvdata },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
@@ -1755,6 +1823,7 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
 {
 	struct platform_device_info pdevinfo;
 	struct platform_device *child;
+	struct device_node *np;
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
@@ -1763,12 +1832,22 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
 	pdevinfo.id = PLATFORM_DEVID_NONE;
 	pdevinfo.dma_mask = DMA_BIT_MASK(32);
 
+	np = of_get_child_by_name(pdev->dev.of_node, name);
+
+	/* Skip the child if it is explicitly disabled */
+	if (np && !of_device_is_available(np))
+		return NULL;
+
 	child = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(child)) {
 		dev_warn(&pdev->dev, "%s not registered\n", name);
 		child = NULL;
 	}
 
+	child->dev.of_node = np;
+
+	of_dma_configure(&child->dev, np, true);
+
 	return child;
 }
 
@@ -1819,8 +1898,11 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
+	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
+	bcm2835_codec = vchiq_register_child(pdev, "bcm2835-codec");
 	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	bcm2835_isp = vchiq_register_child(pdev, "bcm2835-isp");
 
 	return 0;
 
@@ -1832,8 +1914,11 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(bcm2835_isp);
 	platform_device_unregister(bcm2835_audio);
 	platform_device_unregister(bcm2835_camera);
+	platform_device_unregister(bcm2835_codec);
+	platform_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index e8e39a154c74..b7653e8ce9e0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -61,6 +61,7 @@ struct vchiq_arm_state {
 
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
+	const bool use_36bit_addrs;
 	struct rpi_firmware *fw;
 };
 
-- 
2.31.1

