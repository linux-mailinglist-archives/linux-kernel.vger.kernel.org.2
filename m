Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110573ADE6A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhFTM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhFTM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 08:59:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE098C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:57:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bb20so4179323pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLdCas7X3LkNs4ttDItS1W5jgGf0j45KNW4xOoMdFCs=;
        b=TND25wscFbac2J933iYeikhbRdw2RUW1/KJgF0tGguL3eytUbWa2uidfjHfTCd6zrj
         e8F1BZRUbnrd/2Bl3tbOYSvvjHNkQF/eOIy0Z5oO7lztuE2SCmvvrfMCNQqte91oCMyH
         Wv044OV0q3tOjKJWD7IvPgNua2tLLcH/Ng5tO48x9SDFwkFEaE7eDH78BaePHrd27ESv
         KeFqO5W8H8T+Mhi26aGLaQSUOCyR0s5DPX2q7kJAiRI41AvOcHs9lQw8wVUqsE2t4jC+
         Qz9TuXioZh7P7GfXD0f9fI59mjwNZJM0imeFSxU5k/bRvfRcWLR9fdCOMDSTWf1mA3dr
         PLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLdCas7X3LkNs4ttDItS1W5jgGf0j45KNW4xOoMdFCs=;
        b=B7+nGWCoJOgvhofsjQoxpqqOqd5inwnrey+oZG8TMKdrhy7IB+i+ONQIHTfKrJK06+
         NeXomjEjTRZFH/4p7B7v/GSQkF6gHoaZxFvnBPn1uupPpMeK47Dx1X5vSgZZv9+T1o6H
         b+JGR86sqLCUsK1eLTDpEI53mhbuBCgNokwNQpa0u5DXt8mWqhx843MYCk2ZJICuMX6o
         xPvejQwl1/B+K75nK9SQUjY/R6yYkT6rY4hJ/6tiK0ME8TrUVbsZPN6kYNgBCI/d574a
         zDatFThrQiiqyGb1anUKtm1wojs5QJYecFib9+NYvvDUu/iA0RwfroTFYcQtBnALMoNn
         pdxw==
X-Gm-Message-State: AOAM531cviEF1BocOoYu6JJABKZaeeUqIt4t6HcQo5Dp4/m0qpGklnmz
        WULzqfO7sgBaio6EWp/3cWs=
X-Google-Smtp-Source: ABdhPJyfLv+oSPcgXygQx51RcC9mQ3b83kNRCDMi0Af0qglylchIZLlbeM1RU/ClG2Ov0FHiwovHzQ==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr32931717pjg.218.1624193858309;
        Sun, 20 Jun 2021 05:57:38 -0700 (PDT)
Received: from ojas ([122.177.154.120])
        by smtp.gmail.com with ESMTPSA id q12sm14236861pgc.25.2021.06.20.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 05:57:38 -0700 (PDT)
Date:   Sun, 20 Jun 2021 18:27:25 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, stefan.wahren@i2se.com, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: vchiq: Combine vchiq platform code into
 single file
Message-ID: <03145b153c7d1b1a285ccdefb60abc2377dc5558.1624185152.git.ojaswin98@gmail.com>
References: <cover.1624185152.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624185152.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the vchiq platform initialization code into a single file. The
file vchiq_2835_arm.c is now merged in vchiq_arm.c

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Makefile        |   1 -
 .../interface/vchiq_arm/vchiq_2835_arm.c      | 651 ------------------
 .../interface/vchiq_arm/vchiq_arm.c           | 635 +++++++++++++++++
 3 files changed, 635 insertions(+), 652 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index cc6371386a62..cc0a81996eda 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
 vchiq-objs := \
    interface/vchiq_arm/vchiq_core.o  \
    interface/vchiq_arm/vchiq_arm.o \
-   interface/vchiq_arm/vchiq_2835_arm.o \
    interface/vchiq_arm/vchiq_debugfs.o \
    interface/vchiq_arm/vchiq_connected.o \
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
deleted file mode 100644
index 2a1d8d6541b2..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ /dev/null
@@ -1,651 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/pagemap.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmapool.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/uaccess.h>
-#include <linux/mm.h>
-#include <linux/of.h>
-#include <linux/slab.h>
-#include <soc/bcm2835/raspberrypi-firmware.h>
-
-#define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
-
-#include "vchiq_arm.h"
-#include "vchiq_connected.h"
-#include "vchiq_pagelist.h"
-
-#define MAX_FRAGMENTS (VCHIQ_NUM_CURRENT_BULKS * 2)
-
-#define VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX 0
-#define VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX  1
-
-#define BELL0	0x00
-#define BELL2	0x08
-
-#define VCHIQ_DMA_POOL_SIZE PAGE_SIZE
-
-struct vchiq_2835_state {
-	int inited;
-	struct vchiq_arm_state arm_state;
-};
-
-struct vchiq_pagelist_info {
-	struct pagelist *pagelist;
-	size_t pagelist_buffer_size;
-	dma_addr_t dma_addr;
-	bool is_from_pool;
-	enum dma_data_direction dma_dir;
-	unsigned int num_pages;
-	unsigned int pages_need_release;
-	struct page **pages;
-	struct scatterlist *scatterlist;
-	unsigned int scatterlist_mapped;
-};
-
-static void __iomem *g_regs;
-/* This value is the size of the L2 cache lines as understood by the
- * VPU firmware, which determines the required alignment of the
- * offsets/sizes in pagelists.
- *
- * Modern VPU firmware looks for a DT "cache-line-size" property in
- * the VCHIQ node and will overwrite it with the actual L2 cache size,
- * which the kernel must then respect.  That property was rejected
- * upstream, so we have to use the VPU firmware's compatibility value
- * of 32.
- */
-static unsigned int g_cache_line_size = 32;
-static struct dma_pool *g_dma_pool;
-static unsigned int g_use_36bit_addrs = 0;
-static unsigned int g_fragments_size;
-static char *g_fragments_base;
-static char *g_free_fragments;
-static struct semaphore g_free_fragments_sema;
-static struct device *g_dev;
-static struct device *g_dma_dev;
-
-static DEFINE_SEMAPHORE(g_free_fragments_mutex);
-
-static irqreturn_t
-vchiq_doorbell_irq(int irq, void *dev_id);
-
-static struct vchiq_pagelist_info *
-create_pagelist(char *buf, char __user *ubuf, size_t count, unsigned short type);
-
-static void
-free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
-	      int actual);
-
-int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
-{
-	struct device *dev = &pdev->dev;
-	struct device *dma_dev = NULL;
-	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
-	struct rpi_firmware *fw = drvdata->fw;
-	struct vchiq_slot_zero *vchiq_slot_zero;
-	void *slot_mem;
-	dma_addr_t slot_phys;
-	u32 channelbase;
-	int slot_mem_size, frag_mem_size;
-	int err, irq, i;
-
-	/*
-	 * VCHI messages between the CPU and firmware use
-	 * 32-bit bus addresses.
-	 */
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-
-	if (err < 0)
-		return err;
-
-	g_cache_line_size = drvdata->cache_line_size;
-	g_fragments_size = 2 * g_cache_line_size;
-
-	if (drvdata->use_36bit_addrs) {
-		struct device_node *dma_node =
-			of_find_compatible_node(NULL, NULL, "brcm,bcm2711-dma");
-
-		if (dma_node) {
-			struct platform_device *pdev;
-
-			pdev = of_find_device_by_node(dma_node);
-			if (pdev)
-				dma_dev = &pdev->dev;
-			of_node_put(dma_node);
-			g_use_36bit_addrs = true;
-		} else {
-			dev_err(dev, "40-bit DMA controller not found\n");
-			return -EINVAL;
-		}
-	}
-
-	/* Allocate space for the channels in coherent memory */
-	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
-	frag_mem_size = PAGE_ALIGN(g_fragments_size * MAX_FRAGMENTS);
-
-	slot_mem = dmam_alloc_coherent(dev, slot_mem_size + frag_mem_size,
-				       &slot_phys, GFP_KERNEL);
-	if (!slot_mem) {
-		dev_err(dev, "could not allocate DMA memory\n");
-		return -ENOMEM;
-	}
-
-	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
-	channelbase = slot_phys;
-
-	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
-	if (!vchiq_slot_zero)
-		return -EINVAL;
-
-	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
-		channelbase + slot_mem_size;
-	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX] =
-		MAX_FRAGMENTS;
-
-	g_fragments_base = (char *)slot_mem + slot_mem_size;
-
-	g_free_fragments = g_fragments_base;
-	for (i = 0; i < (MAX_FRAGMENTS - 1); i++) {
-		*(char **)&g_fragments_base[i*g_fragments_size] =
-			&g_fragments_base[(i + 1)*g_fragments_size];
-	}
-	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
-	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
-
-	if (vchiq_init_state(state, vchiq_slot_zero) != VCHIQ_SUCCESS)
-		return -EINVAL;
-
-	g_regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(g_regs))
-		return PTR_ERR(g_regs);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq;
-
-	err = devm_request_irq(dev, irq, vchiq_doorbell_irq, IRQF_IRQPOLL,
-			       "VCHIQ doorbell", state);
-	if (err) {
-		dev_err(dev, "failed to register irq=%d\n", irq);
-		return err;
-	}
-
-	/* Send the base address of the slots to VideoCore */
-	err = rpi_firmware_property(fw, RPI_FIRMWARE_VCHIQ_INIT,
-				    &channelbase, sizeof(channelbase));
-	if (err || channelbase) {
-		dev_err(dev, "failed to set channelbase\n");
-		return err ? : -ENXIO;
-	}
-
-	g_dev = dev;
-	g_dma_dev = dma_dev ?: dev;
-	g_dma_pool = dmam_pool_create("vchiq_scatter_pool", dev,
-				      VCHIQ_DMA_POOL_SIZE, g_cache_line_size,
-				      0);
-	if (!g_dma_pool) {
-		dev_err(dev, "failed to create dma pool");
-		return -ENOMEM;
-	}
-
-	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq_init - done (slots %pK, phys %pad)",
-		vchiq_slot_zero, &slot_phys);
-
-	vchiq_call_connected_callbacks();
-
-	return 0;
-}
-
-enum vchiq_status
-vchiq_platform_init_state(struct vchiq_state *state)
-{
-	enum vchiq_status status = VCHIQ_SUCCESS;
-	struct vchiq_2835_state *platform_state;
-
-	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
-	if (!state->platform_state)
-		return VCHIQ_ERROR;
-
-	platform_state = (struct vchiq_2835_state *)state->platform_state;
-
-	platform_state->inited = 1;
-	status = vchiq_arm_init_state(state, &platform_state->arm_state);
-
-	if (status != VCHIQ_SUCCESS)
-		platform_state->inited = 0;
-
-	return status;
-}
-
-struct vchiq_arm_state*
-vchiq_platform_get_arm_state(struct vchiq_state *state)
-{
-	struct vchiq_2835_state *platform_state;
-
-	platform_state   = (struct vchiq_2835_state *)state->platform_state;
-
-	WARN_ON_ONCE(!platform_state->inited);
-
-	return &platform_state->arm_state;
-}
-
-void
-remote_event_signal(struct remote_event *event)
-{
-	wmb();
-
-	event->fired = 1;
-
-	dsb(sy);         /* data barrier operation */
-
-	if (event->armed)
-		writel(0, g_regs + BELL2); /* trigger vc interrupt */
-}
-
-enum vchiq_status
-vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset,
-			void __user *uoffset, int size, int dir)
-{
-	struct vchiq_pagelist_info *pagelistinfo;
-
-	pagelistinfo = create_pagelist(offset, uoffset, size,
-				       (dir == VCHIQ_BULK_RECEIVE)
-				       ? PAGELIST_READ
-				       : PAGELIST_WRITE);
-
-	if (!pagelistinfo)
-		return VCHIQ_ERROR;
-
-	bulk->data = pagelistinfo->dma_addr;
-
-	/*
-	 * Store the pagelistinfo address in remote_data,
-	 * which isn't used by the slave.
-	 */
-	bulk->remote_data = pagelistinfo;
-
-	return VCHIQ_SUCCESS;
-}
-
-void
-vchiq_complete_bulk(struct vchiq_bulk *bulk)
-{
-	if (bulk && bulk->remote_data && bulk->actual)
-		free_pagelist((struct vchiq_pagelist_info *)bulk->remote_data,
-			      bulk->actual);
-}
-
-int vchiq_dump_platform_state(void *dump_context)
-{
-	char buf[80];
-	int len;
-
-	len = snprintf(buf, sizeof(buf),
-		"  Platform: 2835 (VC master)");
-	return vchiq_dump(dump_context, buf, len + 1);
-}
-
-/*
- * Local functions
- */
-
-static irqreturn_t
-vchiq_doorbell_irq(int irq, void *dev_id)
-{
-	struct vchiq_state *state = dev_id;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned int status;
-
-	/* Read (and clear) the doorbell */
-	status = readl(g_regs + BELL0);
-
-	if (status & 0x4) {  /* Was the doorbell rung? */
-		remote_event_pollall(state);
-		ret = IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
-static void
-cleanup_pagelistinfo(struct vchiq_pagelist_info *pagelistinfo)
-{
-	if (pagelistinfo->scatterlist_mapped) {
-		dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
-			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
-	}
-
-	if (pagelistinfo->pages_need_release)
-		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
-
-	if (pagelistinfo->is_from_pool) {
-		dma_pool_free(g_dma_pool, pagelistinfo->pagelist,
-			      pagelistinfo->dma_addr);
-	} else {
-		dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
-				  pagelistinfo->pagelist,
-				  pagelistinfo->dma_addr);
-	}
-}
-
-/* There is a potential problem with partial cache lines (pages?)
- * at the ends of the block when reading. If the CPU accessed anything in
- * the same line (page?) then it may have pulled old data into the cache,
- * obscuring the new data underneath. We can solve this by transferring the
- * partial cache lines separately, and allowing the ARM to copy into the
- * cached area.
- */
-
-static struct vchiq_pagelist_info *
-create_pagelist(char *buf, char __user *ubuf,
-		size_t count, unsigned short type)
-{
-	struct pagelist *pagelist;
-	struct vchiq_pagelist_info *pagelistinfo;
-	struct page **pages;
-	u32 *addrs;
-	unsigned int num_pages, offset, i, k;
-	int actual_pages;
-	bool is_from_pool;
-	size_t pagelist_size;
-	struct scatterlist *scatterlist, *sg;
-	int dma_buffers;
-	dma_addr_t dma_addr;
-
-	if (count >= INT_MAX - PAGE_SIZE)
-		return NULL;
-
-	if (buf)
-		offset = (uintptr_t)buf & (PAGE_SIZE - 1);
-	else
-		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
-	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
-
-	if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
-			 sizeof(struct vchiq_pagelist_info)) /
-			(sizeof(u32) + sizeof(pages[0]) +
-			 sizeof(struct scatterlist)))
-		return NULL;
-
-	pagelist_size = sizeof(struct pagelist) +
-			(num_pages * sizeof(u32)) +
-			(num_pages * sizeof(pages[0]) +
-			(num_pages * sizeof(struct scatterlist))) +
-			sizeof(struct vchiq_pagelist_info);
-
-	/* Allocate enough storage to hold the page pointers and the page
-	 * list
-	 */
-	if (pagelist_size > VCHIQ_DMA_POOL_SIZE) {
-		pagelist = dma_alloc_coherent(g_dev,
-					       pagelist_size,
-					       &dma_addr,
-					       GFP_KERNEL);
-		is_from_pool = false;
-	} else {
-		pagelist = dma_pool_alloc(g_dma_pool, GFP_KERNEL, &dma_addr);
-		is_from_pool = true;
-	}
-
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
-
-	if (!pagelist)
-		return NULL;
-
-	addrs		= pagelist->addrs;
-	pages		= (struct page **)(addrs + num_pages);
-	scatterlist	= (struct scatterlist *)(pages + num_pages);
-	pagelistinfo	= (struct vchiq_pagelist_info *)
-			  (scatterlist + num_pages);
-
-	pagelist->length = count;
-	pagelist->type = type;
-	pagelist->offset = offset;
-
-	/* Populate the fields of the pagelistinfo structure */
-	pagelistinfo->pagelist = pagelist;
-	pagelistinfo->pagelist_buffer_size = pagelist_size;
-	pagelistinfo->dma_addr = dma_addr;
-	pagelistinfo->is_from_pool = is_from_pool;
-	pagelistinfo->dma_dir =  (type == PAGELIST_WRITE) ?
-				  DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	pagelistinfo->num_pages = num_pages;
-	pagelistinfo->pages_need_release = 0;
-	pagelistinfo->pages = pages;
-	pagelistinfo->scatterlist = scatterlist;
-	pagelistinfo->scatterlist_mapped = 0;
-
-	if (buf) {
-		unsigned long length = count;
-		unsigned int off = offset;
-
-		for (actual_pages = 0; actual_pages < num_pages;
-		     actual_pages++) {
-			struct page *pg =
-				vmalloc_to_page((buf +
-						 (actual_pages * PAGE_SIZE)));
-			size_t bytes = PAGE_SIZE - off;
-
-			if (!pg) {
-				cleanup_pagelistinfo(pagelistinfo);
-				return NULL;
-			}
-
-			if (bytes > length)
-				bytes = length;
-			pages[actual_pages] = pg;
-			length -= bytes;
-			off = 0;
-		}
-		/* do not try and release vmalloc pages */
-	} else {
-		actual_pages = pin_user_pages_fast(
-					  (unsigned long)ubuf & PAGE_MASK,
-					  num_pages,
-					  type == PAGELIST_READ,
-					  pages);
-
-		if (actual_pages != num_pages) {
-			vchiq_log_info(vchiq_arm_log_level,
-				       "%s - only %d/%d pages locked",
-				       __func__, actual_pages, num_pages);
-
-			/* This is probably due to the process being killed */
-			if (actual_pages > 0)
-				unpin_user_pages(pages, actual_pages);
-			cleanup_pagelistinfo(pagelistinfo);
-			return NULL;
-		}
-		 /* release user pages */
-		pagelistinfo->pages_need_release = 1;
-	}
-
-	/*
-	 * Initialize the scatterlist so that the magic cookie
-	 *  is filled if debugging is enabled
-	 */
-	sg_init_table(scatterlist, num_pages);
-	/* Now set the pages for each scatterlist */
-	for (i = 0; i < num_pages; i++)	{
-		unsigned int len = PAGE_SIZE - offset;
-
-		if (len > count)
-			len = count;
-		sg_set_page(scatterlist + i, pages[i], len, offset);
-		offset = 0;
-		count -= len;
-	}
-
-	dma_buffers = dma_map_sg(g_dma_dev,
-				 scatterlist,
-				 num_pages,
-				 pagelistinfo->dma_dir);
-
-	if (dma_buffers == 0) {
-		cleanup_pagelistinfo(pagelistinfo);
-		return NULL;
-	}
-
-	pagelistinfo->scatterlist_mapped = 1;
-
-	/* Combine adjacent blocks for performance */
-	k = 0;
-	if (g_use_36bit_addrs) {
-		for_each_sg(scatterlist, sg, dma_buffers, i) {
-			u32 len = sg_dma_len(sg);
-			u64 addr = sg_dma_address(sg);
-			u32 page_id = (u32)((addr >> 4) & ~0xff);
-			u32 sg_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-			/* Note: addrs is the address + page_count - 1
-			 * The firmware expects blocks after the first to be page-
-			 * aligned and a multiple of the page size
-			 */
-			WARN_ON(len == 0);
-			WARN_ON(i &&
-				(i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
-			WARN_ON(i && (addr & ~PAGE_MASK));
-			WARN_ON(upper_32_bits(addr) > 0xf);
-			if (k > 0 &&
-			    ((addrs[k - 1] & ~0xff) +
-			     (((addrs[k - 1] & 0xff) + 1) << 8)
-			     == page_id)) {
-				u32 inc_pages = min(sg_pages,
-						    0xff - (addrs[k - 1] & 0xff));
-				addrs[k - 1] += inc_pages;
-				page_id += inc_pages << 8;
-				sg_pages -= inc_pages;
-			}
-			while (sg_pages) {
-				u32 inc_pages = min(sg_pages, 0x100u);
-				addrs[k++] = page_id | (inc_pages - 1);
-				page_id += inc_pages << 8;
-				sg_pages -= inc_pages;
-			}
-		}
-	} else {
-		for_each_sg(scatterlist, sg, dma_buffers, i) {
-			u32 len = sg_dma_len(sg);
-			u32 addr = sg_dma_address(sg);
-			u32 new_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-			/* Note: addrs is the address + page_count - 1
-			 * The firmware expects blocks after the first to be page-
-			 * aligned and a multiple of the page size
-			 */
-			WARN_ON(len == 0);
-			WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
-			WARN_ON(i && (addr & ~PAGE_MASK));
-			if (k > 0 &&
-			    ((addrs[k - 1] & PAGE_MASK) +
-			     (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT))
-			    == (addr & PAGE_MASK))
-				addrs[k - 1] += new_pages;
-			else
-				addrs[k++] = (addr & PAGE_MASK) | (new_pages - 1);
-		}
-	}
-
-	/* Partial cache lines (fragments) require special measures */
-	if ((type == PAGELIST_READ) &&
-		((pagelist->offset & (g_cache_line_size - 1)) ||
-		((pagelist->offset + pagelist->length) &
-		(g_cache_line_size - 1)))) {
-		char *fragments;
-
-		if (down_interruptible(&g_free_fragments_sema)) {
-			cleanup_pagelistinfo(pagelistinfo);
-			return NULL;
-		}
-
-		WARN_ON(!g_free_fragments);
-
-		down(&g_free_fragments_mutex);
-		fragments = g_free_fragments;
-		WARN_ON(!fragments);
-		g_free_fragments = *(char **) g_free_fragments;
-		up(&g_free_fragments_mutex);
-		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
-			(fragments - g_fragments_base) / g_fragments_size;
-	}
-
-	return pagelistinfo;
-}
-
-static void
-free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
-	      int actual)
-{
-	struct pagelist *pagelist = pagelistinfo->pagelist;
-	struct page **pages = pagelistinfo->pages;
-	unsigned int num_pages = pagelistinfo->num_pages;
-
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
-			__func__, pagelistinfo->pagelist, actual);
-
-	/*
-	 * NOTE: dma_unmap_sg must be called before the
-	 * cpu can touch any of the data/pages.
-	 */
-	dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
-		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
-	pagelistinfo->scatterlist_mapped = 0;
-
-	/* Deal with any partial cache lines (fragments) */
-	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
-		char *fragments = g_fragments_base +
-			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
-			g_fragments_size;
-		int head_bytes, tail_bytes;
-
-		head_bytes = (g_cache_line_size - pagelist->offset) &
-			(g_cache_line_size - 1);
-		tail_bytes = (pagelist->offset + actual) &
-			(g_cache_line_size - 1);
-
-		if ((actual >= 0) && (head_bytes != 0)) {
-			if (head_bytes > actual)
-				head_bytes = actual;
-
-			memcpy((char *)kmap(pages[0]) +
-				pagelist->offset,
-				fragments,
-				head_bytes);
-			kunmap(pages[0]);
-		}
-		if ((actual >= 0) && (head_bytes < actual) &&
-			(tail_bytes != 0)) {
-			memcpy((char *)kmap(pages[num_pages - 1]) +
-				((pagelist->offset + actual) &
-				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
-				fragments + g_cache_line_size,
-				tail_bytes);
-			kunmap(pages[num_pages - 1]);
-		}
-
-		down(&g_free_fragments_mutex);
-		*(char **)fragments = g_free_fragments;
-		g_free_fragments = fragments;
-		up(&g_free_fragments_mutex);
-		up(&g_free_fragments_sema);
-	}
-
-	/* Need to mark all the pages dirty. */
-	if (pagelist->type != PAGELIST_WRITE &&
-	    pagelistinfo->pages_need_release) {
-		unsigned int i;
-
-		for (i = 0; i < num_pages; i++)
-			set_page_dirty(pages[i]);
-	}
-
-	cleanup_pagelistinfo(pagelistinfo);
-}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 06a19d6e2674..6e082ab29c1f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -25,15 +25,32 @@
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/dmapool.h>
+#include <linux/uaccess.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #include "vchiq_core.h"
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
+#include "vchiq_connected.h"
+#include "vchiq_pagelist.h"
 
 #define DEVICE_NAME "vchiq"
 
+#define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
+
+#define MAX_FRAGMENTS (VCHIQ_NUM_CURRENT_BULKS * 2)
+
+#define VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX 0
+#define VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX  1
+
+#define BELL0	0x00
+#define BELL2	0x08
+
+#define VCHIQ_DMA_POOL_SIZE PAGE_SIZE
+
 /* Override the default prefix, which would be vchiq_arm (from the filename) */
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX DEVICE_NAME "."
@@ -67,10 +84,628 @@ static struct vchiq_drvdata bcm2711_drvdata = {
 	.use_36bit_addrs = true,
 };
 
+struct vchiq_2835_state {
+	int inited;
+	struct vchiq_arm_state arm_state;
+};
+
+struct vchiq_pagelist_info {
+	struct pagelist *pagelist;
+	size_t pagelist_buffer_size;
+	dma_addr_t dma_addr;
+	bool is_from_pool;
+	enum dma_data_direction dma_dir;
+	unsigned int num_pages;
+	unsigned int pages_need_release;
+	struct page **pages;
+	struct scatterlist *scatterlist;
+	unsigned int scatterlist_mapped;
+};
+
+static void __iomem *g_regs;
+/* This value is the size of the L2 cache lines as understood by the
+ * VPU firmware, which determines the required alignment of the
+ * offsets/sizes in pagelists.
+ *
+ * Modern VPU firmware looks for a DT "cache-line-size" property in
+ * the VCHIQ node and will overwrite it with the actual L2 cache size,
+ * which the kernel must then respect.  That property was rejected
+ * upstream, so we have to use the VPU firmware's compatibility value
+ * of 32.
+ */
+static unsigned int g_cache_line_size = 32;
+static struct dma_pool *g_dma_pool;
+static unsigned int g_use_36bit_addrs = 0;
+static unsigned int g_fragments_size;
+static char *g_fragments_base;
+static char *g_free_fragments;
+static struct semaphore g_free_fragments_sema;
+static struct device *g_dev;
+static struct device *g_dma_dev;
+
+static DEFINE_SEMAPHORE(g_free_fragments_mutex);
+
+static irqreturn_t
+vchiq_doorbell_irq(int irq, void *dev_id);
+
+static struct vchiq_pagelist_info *
+create_pagelist(char *buf, char __user *ubuf, size_t count, unsigned short type);
+
+static void
+free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
+	      int actual);
+
 static enum vchiq_status
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 	unsigned int size, enum vchiq_bulk_dir dir);
 
+int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
+{
+	struct device *dev = &pdev->dev;
+	struct device *dma_dev = NULL;
+	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
+	struct rpi_firmware *fw = drvdata->fw;
+	struct vchiq_slot_zero *vchiq_slot_zero;
+	void *slot_mem;
+	dma_addr_t slot_phys;
+	u32 channelbase;
+	int slot_mem_size, frag_mem_size;
+	int err, irq, i;
+
+	/*
+	 * VCHI messages between the CPU and firmware use
+	 * 32-bit bus addresses.
+	 */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
+	if (err < 0)
+		return err;
+
+	g_cache_line_size = drvdata->cache_line_size;
+	g_fragments_size = 2 * g_cache_line_size;
+
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
+	/* Allocate space for the channels in coherent memory */
+	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
+	frag_mem_size = PAGE_ALIGN(g_fragments_size * MAX_FRAGMENTS);
+
+	slot_mem = dmam_alloc_coherent(dev, slot_mem_size + frag_mem_size,
+				       &slot_phys, GFP_KERNEL);
+	if (!slot_mem) {
+		dev_err(dev, "could not allocate DMA memory\n");
+		return -ENOMEM;
+	}
+
+	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
+	channelbase = slot_phys;
+
+	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
+	if (!vchiq_slot_zero)
+		return -EINVAL;
+
+	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
+		channelbase + slot_mem_size;
+	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_COUNT_IDX] =
+		MAX_FRAGMENTS;
+
+	g_fragments_base = (char *)slot_mem + slot_mem_size;
+
+	g_free_fragments = g_fragments_base;
+	for (i = 0; i < (MAX_FRAGMENTS - 1); i++) {
+		*(char **)&g_fragments_base[i*g_fragments_size] =
+			&g_fragments_base[(i + 1)*g_fragments_size];
+	}
+	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
+	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
+
+	if (vchiq_init_state(state, vchiq_slot_zero) != VCHIQ_SUCCESS)
+		return -EINVAL;
+
+	g_regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(g_regs))
+		return PTR_ERR(g_regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
+	err = devm_request_irq(dev, irq, vchiq_doorbell_irq, IRQF_IRQPOLL,
+			       "VCHIQ doorbell", state);
+	if (err) {
+		dev_err(dev, "failed to register irq=%d\n", irq);
+		return err;
+	}
+
+	/* Send the base address of the slots to VideoCore */
+	err = rpi_firmware_property(fw, RPI_FIRMWARE_VCHIQ_INIT,
+				    &channelbase, sizeof(channelbase));
+	if (err || channelbase) {
+		dev_err(dev, "failed to set channelbase\n");
+		return err ? : -ENXIO;
+	}
+
+	g_dev = dev;
+	g_dma_dev = dma_dev ?: dev;
+	g_dma_pool = dmam_pool_create("vchiq_scatter_pool", dev,
+				      VCHIQ_DMA_POOL_SIZE, g_cache_line_size,
+				      0);
+	if (!g_dma_pool) {
+		dev_err(dev, "failed to create dma pool");
+		return -ENOMEM;
+	}
+
+	vchiq_log_info(vchiq_arm_log_level,
+		"vchiq_init - done (slots %pK, phys %pad)",
+		vchiq_slot_zero, &slot_phys);
+
+	vchiq_call_connected_callbacks();
+
+	return 0;
+}
+
+enum vchiq_status
+vchiq_platform_init_state(struct vchiq_state *state)
+{
+	enum vchiq_status status = VCHIQ_SUCCESS;
+	struct vchiq_2835_state *platform_state;
+
+	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	if (!state->platform_state)
+		return VCHIQ_ERROR;
+
+	platform_state = (struct vchiq_2835_state *)state->platform_state;
+
+	platform_state->inited = 1;
+	status = vchiq_arm_init_state(state, &platform_state->arm_state);
+
+	if (status != VCHIQ_SUCCESS)
+		platform_state->inited = 0;
+
+	return status;
+}
+
+struct vchiq_arm_state*
+vchiq_platform_get_arm_state(struct vchiq_state *state)
+{
+	struct vchiq_2835_state *platform_state;
+
+	platform_state   = (struct vchiq_2835_state *)state->platform_state;
+
+	WARN_ON_ONCE(!platform_state->inited);
+
+	return &platform_state->arm_state;
+}
+
+void
+remote_event_signal(struct remote_event *event)
+{
+	wmb();
+
+	event->fired = 1;
+
+	dsb(sy);         /* data barrier operation */
+
+	if (event->armed)
+		writel(0, g_regs + BELL2); /* trigger vc interrupt */
+}
+
+enum vchiq_status
+vchiq_prepare_bulk_data(struct vchiq_bulk *bulk, void *offset,
+			void __user *uoffset, int size, int dir)
+{
+	struct vchiq_pagelist_info *pagelistinfo;
+
+	pagelistinfo = create_pagelist(offset, uoffset, size,
+				       (dir == VCHIQ_BULK_RECEIVE)
+				       ? PAGELIST_READ
+				       : PAGELIST_WRITE);
+
+	if (!pagelistinfo)
+		return VCHIQ_ERROR;
+
+	bulk->data = pagelistinfo->dma_addr;
+
+	/*
+	 * Store the pagelistinfo address in remote_data,
+	 * which isn't used by the slave.
+	 */
+	bulk->remote_data = pagelistinfo;
+
+	return VCHIQ_SUCCESS;
+}
+
+void
+vchiq_complete_bulk(struct vchiq_bulk *bulk)
+{
+	if (bulk && bulk->remote_data && bulk->actual)
+		free_pagelist((struct vchiq_pagelist_info *)bulk->remote_data,
+			      bulk->actual);
+}
+
+int vchiq_dump_platform_state(void *dump_context)
+{
+	char buf[80];
+	int len;
+
+	len = snprintf(buf, sizeof(buf),
+		"  Platform: 2835 (VC master)");
+	return vchiq_dump(dump_context, buf, len + 1);
+}
+
+/*
+ * Local functions
+ */
+
+static irqreturn_t
+vchiq_doorbell_irq(int irq, void *dev_id)
+{
+	struct vchiq_state *state = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int status;
+
+	/* Read (and clear) the doorbell */
+	status = readl(g_regs + BELL0);
+
+	if (status & 0x4) {  /* Was the doorbell rung? */
+		remote_event_pollall(state);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static void
+cleanup_pagelistinfo(struct vchiq_pagelist_info *pagelistinfo)
+{
+	if (pagelistinfo->scatterlist_mapped) {
+		dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
+			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	}
+
+	if (pagelistinfo->pages_need_release)
+		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
+
+	if (pagelistinfo->is_from_pool) {
+		dma_pool_free(g_dma_pool, pagelistinfo->pagelist,
+			      pagelistinfo->dma_addr);
+	} else {
+		dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
+				  pagelistinfo->pagelist,
+				  pagelistinfo->dma_addr);
+	}
+}
+
+/* There is a potential problem with partial cache lines (pages?)
+ * at the ends of the block when reading. If the CPU accessed anything in
+ * the same line (page?) then it may have pulled old data into the cache,
+ * obscuring the new data underneath. We can solve this by transferring the
+ * partial cache lines separately, and allowing the ARM to copy into the
+ * cached area.
+ */
+
+static struct vchiq_pagelist_info *
+create_pagelist(char *buf, char __user *ubuf,
+		size_t count, unsigned short type)
+{
+	struct pagelist *pagelist;
+	struct vchiq_pagelist_info *pagelistinfo;
+	struct page **pages;
+	u32 *addrs;
+	unsigned int num_pages, offset, i, k;
+	int actual_pages;
+	bool is_from_pool;
+	size_t pagelist_size;
+	struct scatterlist *scatterlist, *sg;
+	int dma_buffers;
+	dma_addr_t dma_addr;
+
+	if (count >= INT_MAX - PAGE_SIZE)
+		return NULL;
+
+	if (buf)
+		offset = (uintptr_t)buf & (PAGE_SIZE - 1);
+	else
+		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
+	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
+
+	if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
+			 sizeof(struct vchiq_pagelist_info)) /
+			(sizeof(u32) + sizeof(pages[0]) +
+			 sizeof(struct scatterlist)))
+		return NULL;
+
+	pagelist_size = sizeof(struct pagelist) +
+			(num_pages * sizeof(u32)) +
+			(num_pages * sizeof(pages[0]) +
+			(num_pages * sizeof(struct scatterlist))) +
+			sizeof(struct vchiq_pagelist_info);
+
+	/* Allocate enough storage to hold the page pointers and the page
+	 * list
+	 */
+	if (pagelist_size > VCHIQ_DMA_POOL_SIZE) {
+		pagelist = dma_alloc_coherent(g_dev,
+					       pagelist_size,
+					       &dma_addr,
+					       GFP_KERNEL);
+		is_from_pool = false;
+	} else {
+		pagelist = dma_pool_alloc(g_dma_pool, GFP_KERNEL, &dma_addr);
+		is_from_pool = true;
+	}
+
+	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
+
+	if (!pagelist)
+		return NULL;
+
+	addrs		= pagelist->addrs;
+	pages		= (struct page **)(addrs + num_pages);
+	scatterlist	= (struct scatterlist *)(pages + num_pages);
+	pagelistinfo	= (struct vchiq_pagelist_info *)
+			  (scatterlist + num_pages);
+
+	pagelist->length = count;
+	pagelist->type = type;
+	pagelist->offset = offset;
+
+	/* Populate the fields of the pagelistinfo structure */
+	pagelistinfo->pagelist = pagelist;
+	pagelistinfo->pagelist_buffer_size = pagelist_size;
+	pagelistinfo->dma_addr = dma_addr;
+	pagelistinfo->is_from_pool = is_from_pool;
+	pagelistinfo->dma_dir =  (type == PAGELIST_WRITE) ?
+				  DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	pagelistinfo->num_pages = num_pages;
+	pagelistinfo->pages_need_release = 0;
+	pagelistinfo->pages = pages;
+	pagelistinfo->scatterlist = scatterlist;
+	pagelistinfo->scatterlist_mapped = 0;
+
+	if (buf) {
+		unsigned long length = count;
+		unsigned int off = offset;
+
+		for (actual_pages = 0; actual_pages < num_pages;
+		     actual_pages++) {
+			struct page *pg =
+				vmalloc_to_page((buf +
+						 (actual_pages * PAGE_SIZE)));
+			size_t bytes = PAGE_SIZE - off;
+
+			if (!pg) {
+				cleanup_pagelistinfo(pagelistinfo);
+				return NULL;
+			}
+
+			if (bytes > length)
+				bytes = length;
+			pages[actual_pages] = pg;
+			length -= bytes;
+			off = 0;
+		}
+		/* do not try and release vmalloc pages */
+	} else {
+		actual_pages = pin_user_pages_fast(
+					  (unsigned long)ubuf & PAGE_MASK,
+					  num_pages,
+					  type == PAGELIST_READ,
+					  pages);
+
+		if (actual_pages != num_pages) {
+			vchiq_log_info(vchiq_arm_log_level,
+				       "%s - only %d/%d pages locked",
+				       __func__, actual_pages, num_pages);
+
+			/* This is probably due to the process being killed */
+			if (actual_pages > 0)
+				unpin_user_pages(pages, actual_pages);
+			cleanup_pagelistinfo(pagelistinfo);
+			return NULL;
+		}
+		 /* release user pages */
+		pagelistinfo->pages_need_release = 1;
+	}
+
+	/*
+	 * Initialize the scatterlist so that the magic cookie
+	 *  is filled if debugging is enabled
+	 */
+	sg_init_table(scatterlist, num_pages);
+	/* Now set the pages for each scatterlist */
+	for (i = 0; i < num_pages; i++)	{
+		unsigned int len = PAGE_SIZE - offset;
+
+		if (len > count)
+			len = count;
+		sg_set_page(scatterlist + i, pages[i], len, offset);
+		offset = 0;
+		count -= len;
+	}
+
+	dma_buffers = dma_map_sg(g_dma_dev,
+				 scatterlist,
+				 num_pages,
+				 pagelistinfo->dma_dir);
+
+	if (dma_buffers == 0) {
+		cleanup_pagelistinfo(pagelistinfo);
+		return NULL;
+	}
+
+	pagelistinfo->scatterlist_mapped = 1;
+
+	/* Combine adjacent blocks for performance */
+	k = 0;
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
+	}
+
+	/* Partial cache lines (fragments) require special measures */
+	if ((type == PAGELIST_READ) &&
+		((pagelist->offset & (g_cache_line_size - 1)) ||
+		((pagelist->offset + pagelist->length) &
+		(g_cache_line_size - 1)))) {
+		char *fragments;
+
+		if (down_interruptible(&g_free_fragments_sema)) {
+			cleanup_pagelistinfo(pagelistinfo);
+			return NULL;
+		}
+
+		WARN_ON(!g_free_fragments);
+
+		down(&g_free_fragments_mutex);
+		fragments = g_free_fragments;
+		WARN_ON(!fragments);
+		g_free_fragments = *(char **) g_free_fragments;
+		up(&g_free_fragments_mutex);
+		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
+			(fragments - g_fragments_base) / g_fragments_size;
+	}
+
+	return pagelistinfo;
+}
+
+static void
+free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
+	      int actual)
+{
+	struct pagelist *pagelist = pagelistinfo->pagelist;
+	struct page **pages = pagelistinfo->pages;
+	unsigned int num_pages = pagelistinfo->num_pages;
+
+	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
+			__func__, pagelistinfo->pagelist, actual);
+
+	/*
+	 * NOTE: dma_unmap_sg must be called before the
+	 * cpu can touch any of the data/pages.
+	 */
+	dma_unmap_sg(g_dma_dev, pagelistinfo->scatterlist,
+		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	pagelistinfo->scatterlist_mapped = 0;
+
+	/* Deal with any partial cache lines (fragments) */
+	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
+		char *fragments = g_fragments_base +
+			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
+			g_fragments_size;
+		int head_bytes, tail_bytes;
+
+		head_bytes = (g_cache_line_size - pagelist->offset) &
+			(g_cache_line_size - 1);
+		tail_bytes = (pagelist->offset + actual) &
+			(g_cache_line_size - 1);
+
+		if ((actual >= 0) && (head_bytes != 0)) {
+			if (head_bytes > actual)
+				head_bytes = actual;
+
+			memcpy((char *)kmap(pages[0]) +
+				pagelist->offset,
+				fragments,
+				head_bytes);
+			kunmap(pages[0]);
+		}
+		if ((actual >= 0) && (head_bytes < actual) &&
+			(tail_bytes != 0)) {
+			memcpy((char *)kmap(pages[num_pages - 1]) +
+				((pagelist->offset + actual) &
+				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
+				fragments + g_cache_line_size,
+				tail_bytes);
+			kunmap(pages[num_pages - 1]);
+		}
+
+		down(&g_free_fragments_mutex);
+		*(char **)fragments = g_free_fragments;
+		g_free_fragments = fragments;
+		up(&g_free_fragments_mutex);
+		up(&g_free_fragments_sema);
+	}
+
+	/* Need to mark all the pages dirty. */
+	if (pagelist->type != PAGELIST_WRITE &&
+	    pagelistinfo->pages_need_release) {
+		unsigned int i;
+
+		for (i = 0; i < num_pages; i++)
+			set_page_dirty(pages[i]);
+	}
+
+	cleanup_pagelistinfo(pagelistinfo);
+}
+
 #define VCHIQ_INIT_RETRIES 10
 enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
 {
-- 
2.25.1

