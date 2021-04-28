Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA836DC40
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbhD1PqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241496AbhD1Poo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:44:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B61C0612AC;
        Wed, 28 Apr 2021 08:39:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q2so12049059pfk.9;
        Wed, 28 Apr 2021 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fdQ6mtwPVeGREgtHEwqkJNzQ1V/fit6k42a1rYIg3q0=;
        b=mzniNHUfc1nOG+ti98K/mrPtMSoZvgnfG4tlaMCp370Ft7CUpb3mEyJE75JOLEKeJe
         mHe/buO7oXHo8KcEjEvyi5zaOVM+FxC6GyZ3kOjrF65L/c4zGGHCzkhqpLKio8orJHIB
         PjB9Mq5pJItF6CVIB81gMrv1MsiEIYEgzBpxP/zY+U8FT+uNXPa7srXoaaUS3h8EWSAI
         cmqPhNIHOtoXTt8WpI9YOwfaW+RZBMqwQFsQ9HY/+bQkq7ODhKXzS7zM4AfhF9ji3unI
         JAY4cHY1PfTr3eTIYunc4t2iSXJ8zPgicQ2SdKoAX+VQXQTUXu6PFNh0M0TRVypQoxlD
         J3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fdQ6mtwPVeGREgtHEwqkJNzQ1V/fit6k42a1rYIg3q0=;
        b=AnUZ4CAF37EA2ir9wZHRXYn4zcDp4K0pj0blV4ESUDn815fyR3G5/WmkQEfbSGOrjB
         AkMEoPChh5I91fUZ7ZbLZ/dnRq2eM2+lqU6/Rfbb9peK+ZbMQiWJPDw+Ou3a/y5uRuv1
         +o/3Ch+L7BboIni27RiUn0+LX+K6QwQsMb2e0Rpsr+tniUZLa5HLgzlfhs/eXfGTen+J
         AWBMKHlkLFyl4dKKBn6bITZ1YYejtOPM2nUeIbuYzSbwPGxoQrWBHPbEy1fi1FF0cFX5
         IReX55WyykAUm81Kzjr7Kq5+0V4aMIIATtqm7U6fzIStvHKCUKs56Pm0DgEmfXSUF2o5
         xaIA==
X-Gm-Message-State: AOAM530ulsOX6jkJJRzgTCksXHg0YKNyfwHDCX/oQ6AvtkNSjgoobj4n
        Yb0rXHDzk+wJ9bjiVeyfKA2vESqIGFaKtH4f
X-Google-Smtp-Source: ABdhPJx61oOlYsuRsg8P/Ar5DdJxDI1EUSr1yeJRLgiKPcDSNmL2JgVqK/1DfjS4gEwHgu4TB1hk5w==
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id g136-20020a62528e0000b02901f5c5eea487mr28007099pfb.7.1619624391158;
        Wed, 28 Apr 2021 08:39:51 -0700 (PDT)
Received: from localhost ([157.45.42.123])
        by smtp.gmail.com with ESMTPSA id a27sm129483pfl.64.2021.04.28.08.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 08:39:50 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:09:42 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     James.Bottomley@HansenPartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: parisc: ccio-dma.c: Added tab insead of spaces
Message-ID: <20210428153942.uyips5a3osoz3nju@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single space has been removed.
It has been replaced with tabs.
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/parisc/ccio-dma.c | 88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index b5f9ee81a46c..9b777357e8cb 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -111,29 +111,29 @@
 #define CMD_TLB_PURGE        33         /* IO_COMMAND to Purge I/O TLB entry */
 
 struct ioa_registers {
-        /* Runway Supervisory Set */
-        int32_t    unused1[12];
-        uint32_t   io_command;             /* Offset 12 */
-        uint32_t   io_status;              /* Offset 13 */
-        uint32_t   io_control;             /* Offset 14 */
-        int32_t    unused2[1];
-
-        /* Runway Auxiliary Register Set */
-        uint32_t   io_err_resp;            /* Offset  0 */
-        uint32_t   io_err_info;            /* Offset  1 */
-        uint32_t   io_err_req;             /* Offset  2 */
-        uint32_t   io_err_resp_hi;         /* Offset  3 */
-        uint32_t   io_tlb_entry_m;         /* Offset  4 */
-        uint32_t   io_tlb_entry_l;         /* Offset  5 */
-        uint32_t   unused3[1];
-        uint32_t   io_pdir_base;           /* Offset  7 */
-        uint32_t   io_io_low_hv;           /* Offset  8 */
-        uint32_t   io_io_high_hv;          /* Offset  9 */
-        uint32_t   unused4[1];
-        uint32_t   io_chain_id_mask;       /* Offset 11 */
-        uint32_t   unused5[2];
-        uint32_t   io_io_low;              /* Offset 14 */
-        uint32_t   io_io_high;             /* Offset 15 */
+	/* Runway Supervisory Set */
+	int32_t    unused1[12];
+	uint32_t   io_command;             /* Offset 12 */
+	uint32_t   io_status;              /* Offset 13 */
+	uint32_t   io_control;             /* Offset 14 */
+	int32_t    unused2[1];
+
+	/* Runway Auxiliary Register Set */
+	uint32_t   io_err_resp;            /* Offset  0 */
+	uint32_t   io_err_info;            /* Offset  1 */
+	uint32_t   io_err_req;             /* Offset  2 */
+	uint32_t   io_err_resp_hi;         /* Offset  3 */
+	uint32_t   io_tlb_entry_m;         /* Offset  4 */
+	uint32_t   io_tlb_entry_l;         /* Offset  5 */
+	uint32_t   unused3[1];
+	uint32_t   io_pdir_base;           /* Offset  7 */
+	uint32_t   io_io_low_hv;           /* Offset  8 */
+	uint32_t   io_io_high_hv;          /* Offset  9 */
+	uint32_t   unused4[1];
+	uint32_t   io_chain_id_mask;       /* Offset 11 */
+	uint32_t   unused5[2];
+	uint32_t   io_io_low;              /* Offset 14 */
+	uint32_t   io_io_high;             /* Offset 15 */
 };
 
 /*
@@ -198,7 +198,7 @@ struct ioa_registers {
 ** In order for a Runway address to reside within GSC+ extended address space:
 **	Runway Address [0:7]    must identically compare to 8'b11111111
 **	Runway Address [8:11]   must be equal to IO_IO_LOW(_HV)[16:19]
-** 	Runway Address [12:23]  must be greater than or equal to
+**	Runway Address [12:23]  must be greater than or equal to
 **	           IO_IO_LOW(_HV)[20:31] and less than IO_IO_HIGH(_HV)[20:31].
 **	Runway Address [24:39]  is not used in the comparison.
 **
@@ -226,10 +226,10 @@ struct ioc {
 	struct ioa_registers __iomem *ioc_regs;  /* I/O MMU base address */
 	u8  *res_map;	                /* resource map, bit == pdir entry */
 	u64 *pdir_base;	                /* physical base address */
-	u32 pdir_size; 			/* bytes, function of IOV Space size */
-	u32 res_hint;	                /* next available IOVP - 
+	u32 pdir_size;			/* bytes, function of IOV Space size */
+	u32 res_hint;			/* next available IOVP -
 					   circular search */
-	u32 res_size;		    	/* size of resource map in bytes */
+	u32 res_size;			/* size of resource map in bytes */
 	spinlock_t res_lock;
 
 #ifdef CCIO_COLLECT_STATS
@@ -249,7 +249,7 @@ struct ioc {
 	unsigned short cujo20_bug;
 
 	/* STUFF We don't need in performance path */
-	u32 chainid_shift; 		/* specify bit location of chain_id */
+	u32 chainid_shift;		/* specify bit location of chain_id */
 	struct ioc *next;		/* Linked list of discovered iocs */
 	const char *name;		/* device name from firmware */
 	unsigned int hw_path;           /* the hardware path this ioc is associatd with */
@@ -293,7 +293,7 @@ static int ioc_count;
 ** cause the kernel to panic anyhow.
 */
 #define CCIO_SEARCH_LOOP(ioc, res_idx, mask, size)  \
-       for(; res_ptr < res_end; ++res_ptr) { \
+	for (; res_ptr < res_end; ++res_ptr) { \
 		int ret;\
 		unsigned int idx;\
 		idx = (unsigned int)((unsigned long)res_ptr - (unsigned long)ioc->res_map); \
@@ -303,15 +303,15 @@ static int ioc_count;
 			res_idx = idx;\
 			ioc->res_hint = res_idx + (size >> 3); \
 			goto resource_found; \
-		} \
+		  \
 	}
 
 #define CCIO_FIND_FREE_MAPPING(ioa, res_idx, mask, size) \
        u##size *res_ptr = (u##size *)&((ioc)->res_map[ioa->res_hint & ~((size >> 3) - 1)]); \
        u##size *res_end = (u##size *)&(ioc)->res_map[ioa->res_size]; \
-       CCIO_SEARCH_LOOP(ioc, res_idx, mask, size); \
-       res_ptr = (u##size *)&(ioc)->res_map[0]; \
-       CCIO_SEARCH_LOOP(ioa, res_idx, mask, size);
+	CCIO_SEARCH_LOOP(ioc, res_idx, mask, size); \
+	res_ptr = (u##size *)&(ioc)->res_map[0]; \
+	CCIO_SEARCH_LOOP(ioa, res_idx, mask, size);
 
 /*
 ** Find available bit in this ioa's resource map.
@@ -348,9 +348,9 @@ ccio_alloc_range(struct ioc *ioc, struct device *dev, size_t size)
 	
 	BUG_ON(pages_needed == 0);
 	BUG_ON((pages_needed * IOVP_SIZE) > DMA_CHUNK_SIZE);
-     
-	DBG_RES("%s() size: %d pages_needed %d\n", 
-		__func__, size, pages_needed);
+
+	DBG_RES("%s() size: %d pages_needed %d\n",
+			__func__, size, pages_needed);
 
 	/*
 	** "seek and ye shall find"...praying never hurts either...
@@ -416,7 +416,7 @@ ccio_alloc_range(struct ioc *ioc, struct device *dev, size_t size)
 #define CCIO_FREE_MAPPINGS(ioc, res_idx, mask, size) \
         u##size *res_ptr = (u##size *)&((ioc)->res_map[res_idx]); \
         BUG_ON((*res_ptr & mask) != mask); \
-        *res_ptr &= ~(mask);
+	*res_ptr &= ~(mask);
 
 /**
  * ccio_free_range - Free pages from the ioc's resource map.
@@ -845,7 +845,7 @@ static void *
 ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
 		unsigned long attrs)
 {
-      void *ret;
+	void *ret;
 #if 0
 /* GRANT Need to establish hierarchy for non-PCI devs as well
 ** and then provide matching gsc_map_xxx() functions for them as well.
@@ -856,7 +856,7 @@ ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
 		return 0;
 	}
 #endif
-        ret = (void *) __get_free_pages(flag, get_order(size));
+	ret = (void *) __get_free_pages(flag, get_order(size));
 
 	if (ret) {
 		memset(ret, 0, size);
@@ -1022,8 +1022,8 @@ static const struct dma_map_ops ccio_ops = {
 	.free =			ccio_free,
 	.map_page =		ccio_map_page,
 	.unmap_page =		ccio_unmap_page,
-	.map_sg = 		ccio_map_sg,
-	.unmap_sg = 		ccio_unmap_sg,
+	.map_sg =		ccio_map_sg,
+	.unmap_sg =		ccio_unmap_sg,
 	.get_sgtable =		dma_common_get_sgtable,
 	.alloc_pages =		dma_common_alloc_pages,
 	.free_pages =		dma_common_free_pages,
@@ -1080,7 +1080,7 @@ static int ccio_proc_info(struct seq_file *m, void *p)
 		max = ioc->usingle_pages - ioc->usg_pages;
 		seq_printf(m, "pci_unmap_single: %8ld calls  %8ld pages (avg %d/1000)\n",
 			   min, max, (int)((max * 1000)/min));
- 
+
 		seq_printf(m, "pci_map_sg()    : %8ld calls  %8ld pages (avg %d/1000)\n",
 			   ioc->msg_calls, ioc->msg_pages,
 			   (int)((ioc->msg_pages * 1000)/ioc->msg_calls));
@@ -1169,7 +1169,7 @@ void __init ccio_cujo20_fixup(struct parisc_device *cujo, u32 iovp)
 	idx = PDIR_INDEX(iovp) >> 3;
 
 	while (idx < ioc->res_size) {
- 		res_ptr[idx] |= 0xff;
+		res_ptr[idx] |= 0xff;
 		idx += PDIR_INDEX(CUJO_20_STEP) >> 3;
 	}
 }
@@ -1297,7 +1297,7 @@ ccio_ioc_init(struct ioc *ioc)
 	DBG_INIT(" base %p\n", ioc->pdir_base);
 
 	/* resource map size dictated by pdir_size */
- 	ioc->res_size = (ioc->pdir_size / sizeof(u64)) >> 3;
+	ioc->res_size = (ioc->pdir_size / sizeof(u64)) >> 3;
 	DBG_INIT("%s() res_size 0x%x\n", __func__, ioc->res_size);
 	
 	ioc->res_map = (u8 *)__get_free_pages(GFP_KERNEL, 
-- 
2.17.1

