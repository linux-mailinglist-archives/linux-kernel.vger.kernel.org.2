Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABB3BADBC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGDQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGDQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 12:02:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6ACC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 09:00:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j199so13693745pfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSyqk9omaA/4JjeB7/q7pkhUw7/am/ig2g3n4bB7ol4=;
        b=SRB1hItEu8RfUNFe3wGGF1ZWgOcARNOCDFXbAQCWYCWI5dL6gYGusLSB9efhXjtgKx
         74AicD51rRJoRfiG8OdpJwFmE4v40O2akY7TaAaBcTmcToBoFK0au6Z5ibG2i1fosRgF
         ZyES6vecToRpqi/rf6K3EjM0hMkYmQGJvQpOBgjbY2BB73bPzVQwWfcvGZUeFR46Gk+e
         XTP0s9rpAfZ9uPlCXqGY3Xvmr6BNT8ctoy1Dw31Q6r2P/E4ooqTQ9ggEh0CtUk0d33R4
         B91GCUAbdbwKo45EG/G1wlbXPtlfSpUe1T2WPs/UgDx6GUcmUY2ZdEjIGgU5wWbHTAXK
         0ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSyqk9omaA/4JjeB7/q7pkhUw7/am/ig2g3n4bB7ol4=;
        b=WvMwIjA0Navo3fVlDDL0iAgFdALq9J4ASpfcTvPlhbGSaAyPbqSJIdVsspWQ6b+3p+
         odcmE3nq70vxfkWFbC+AqfJdAr6lSv5kwDettOabH7Lb4O2q4XiIJPVhRLmiCY25948x
         ibC5jv7fkTCW9WfqKvE079WKMlZ6OiM5wdQY4n6r5Izw2ZgWS3rH3Mc2tnGQNj9axiHH
         brrP0NUHG3oib6uldCeTYP85GnXOv4Q6WvxEHe+fbHCsjdnfxu0F0o5K5tuyKvcEQFib
         NDE/LMQ9mIK28LWl0TpsFXzY2FFRekLsTRBXjePwF6wGnuydmNTAqEqYG5W/9la5j9Dc
         ddXQ==
X-Gm-Message-State: AOAM531xb1noppUX4TdO3ehUszQvHfOGsTPso/Yy0CKmg7poCaCl3M6x
        6C5axpJ44BmDR7UDIZqA5LU=
X-Google-Smtp-Source: ABdhPJx8AlOT2xLM7oVM8iFC91LzfOYpXURdEbvRN0l/cmtpTR2DNGnwTMWfOlrVLrkJp+hRAfPsUg==
X-Received: by 2002:aa7:8b4c:0:b029:314:5619:d317 with SMTP id i12-20020aa78b4c0000b02903145619d317mr10283734pfd.60.1625414406475;
        Sun, 04 Jul 2021 09:00:06 -0700 (PDT)
Received: from ojas ([182.69.223.21])
        by smtp.gmail.com with ESMTPSA id 92sm19088967pjv.29.2021.07.04.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 09:00:06 -0700 (PDT)
Date:   Sun, 4 Jul 2021 21:29:56 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, stefan.wahren@i2se.com, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] staging: vchiq: Combine vchiq platform code into
 single file
Message-ID: <b2e9eaee3e6d8f278a3277aaa284c5ca8b76d756.1625401928.git.ojaswin98@gmail.com>
References: <cover.1625401927.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625401927.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the vchiq platform initialization code into a single file by
merging vchiq_2835_arm.c into vchiq_arm.c

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Makefile        |   1 -
 .../interface/vchiq_arm/vchiq_2835_arm.c      | 564 ------------------
 .../interface/vchiq_arm/vchiq_arm.c           | 549 +++++++++++++++++
 3 files changed, 549 insertions(+), 565 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 0a04338fc962..1fd191e2e2a5 100644
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
index 30d6f1a404ba..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ /dev/null
@@ -1,564 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/pagemap.h>
-#include <linux/dma-mapping.h>
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
-#define ARM_DS_ACTIVE	BIT(2)
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
-static unsigned int g_fragments_size;
-static char *g_fragments_base;
-static char *g_free_fragments;
-static struct semaphore g_free_fragments_sema;
-static struct device *g_dev;
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
-
-	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
-	if (!vchiq_slot_zero)
-		return -EINVAL;
-
-	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
-		(int)slot_phys + slot_mem_size;
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
-	err = vchiq_init_state(state, vchiq_slot_zero);
-	if (err)
-		return err;
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
-	channelbase = slot_phys;
-	err = rpi_firmware_property(fw, RPI_FIRMWARE_VCHIQ_INIT,
-				    &channelbase, sizeof(channelbase));
-	if (err || channelbase) {
-		dev_err(dev, "failed to set channelbase\n");
-		return err ? : -ENXIO;
-	}
-
-	g_dev = dev;
-	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq_init - done (slots %pK, phys %pad)",
-		vchiq_slot_zero, &slot_phys);
-
-	vchiq_call_connected_callbacks();
-
-	return 0;
-}
-
-int
-vchiq_platform_init_state(struct vchiq_state *state)
-{
-	struct vchiq_2835_state *platform_state;
-
-	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
-	if (!state->platform_state)
-		return -ENOMEM;
-
-	platform_state = (struct vchiq_2835_state *)state->platform_state;
-
-	platform_state->inited = 1;
-	vchiq_arm_init_state(state, &platform_state->arm_state);
-
-	return 0;
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
-int
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
-		return -ENOMEM;
-
-	bulk->data = pagelistinfo->dma_addr;
-
-	/*
-	 * Store the pagelistinfo address in remote_data,
-	 * which isn't used by the slave.
-	 */
-	bulk->remote_data = pagelistinfo;
-
-	return 0;
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
-	if (status & ARM_DS_ACTIVE) {  /* Was the doorbell rung? */
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
-		dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
-			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
-	}
-
-	if (pagelistinfo->pages_need_release)
-		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
-
-	dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
-			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
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
-	pagelist = dma_alloc_coherent(g_dev, pagelist_size, &dma_addr,
-				      GFP_KERNEL);
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
-	dma_buffers = dma_map_sg(g_dev,
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
-	for_each_sg(scatterlist, sg, dma_buffers, i) {
-		u32 len = sg_dma_len(sg);
-		u32 addr = sg_dma_address(sg);
-
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
-	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
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
index 0f2de571eba7..9057d01ffd48 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -25,15 +25,32 @@
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
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
+#define ARM_DS_ACTIVE	BIT(2)
+
 /* Override the default prefix, which would be vchiq_arm (from the filename) */
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX DEVICE_NAME "."
@@ -59,10 +76,542 @@ static struct vchiq_drvdata bcm2836_drvdata = {
 	.cache_line_size = 64,
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
+static unsigned int g_fragments_size;
+static char *g_fragments_base;
+static char *g_free_fragments;
+static struct semaphore g_free_fragments_sema;
+static struct device *g_dev;
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
+
+	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
+	if (!vchiq_slot_zero)
+		return -EINVAL;
+
+	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
+		(int)slot_phys + slot_mem_size;
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
+	err = vchiq_init_state(state, vchiq_slot_zero);
+	if (err)
+		return err;
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
+	channelbase = slot_phys;
+	err = rpi_firmware_property(fw, RPI_FIRMWARE_VCHIQ_INIT,
+				    &channelbase, sizeof(channelbase));
+	if (err || channelbase) {
+		dev_err(dev, "failed to set channelbase\n");
+		return err ? : -ENXIO;
+	}
+
+	g_dev = dev;
+	vchiq_log_info(vchiq_arm_log_level,
+		"vchiq_init - done (slots %pK, phys %pad)",
+		vchiq_slot_zero, &slot_phys);
+
+	vchiq_call_connected_callbacks();
+
+	return 0;
+}
+
+int
+vchiq_platform_init_state(struct vchiq_state *state)
+{
+	struct vchiq_2835_state *platform_state;
+
+	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	if (!state->platform_state)
+		return -ENOMEM;
+
+	platform_state = (struct vchiq_2835_state *)state->platform_state;
+
+	platform_state->inited = 1;
+	vchiq_arm_init_state(state, &platform_state->arm_state);
+
+	return 0;
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
+int
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
+		return -ENOMEM;
+
+	bulk->data = pagelistinfo->dma_addr;
+
+	/*
+	 * Store the pagelistinfo address in remote_data,
+	 * which isn't used by the slave.
+	 */
+	bulk->remote_data = pagelistinfo;
+
+	return 0;
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
+	if (status & ARM_DS_ACTIVE) {  /* Was the doorbell rung? */
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
+		dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
+			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	}
+
+	if (pagelistinfo->pages_need_release)
+		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
+
+	dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
+			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
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
+	pagelist = dma_alloc_coherent(g_dev, pagelist_size, &dma_addr,
+				      GFP_KERNEL);
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
+	dma_buffers = dma_map_sg(g_dev,
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
+	for_each_sg(scatterlist, sg, dma_buffers, i) {
+		u32 len = sg_dma_len(sg);
+		u32 addr = sg_dma_address(sg);
+
+		/* Note: addrs is the address + page_count - 1
+		 * The firmware expects blocks after the first to be page-
+		 * aligned and a multiple of the page size
+		 */
+		WARN_ON(len == 0);
+		WARN_ON(i && (i != (dma_buffers - 1)) && (len & ~PAGE_MASK));
+		WARN_ON(i && (addr & ~PAGE_MASK));
+		if (k > 0 &&
+		    ((addrs[k - 1] & PAGE_MASK) +
+		     (((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT))
+		    == (addr & PAGE_MASK))
+			addrs[k - 1] += ((len + PAGE_SIZE - 1) >> PAGE_SHIFT);
+		else
+			addrs[k++] = (addr & PAGE_MASK) |
+				(((len + PAGE_SIZE - 1) >> PAGE_SHIFT) - 1);
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
+	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
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
 int vchiq_initialise(struct vchiq_instance **instance_out)
 {
-- 
2.25.1

