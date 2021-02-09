Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBD3148D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBIG26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhBIGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:23:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA70C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:22:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cv23so972160pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUcKCdqxUtmE3c3/sCLCFX58+aEPLItGYu5wwEcivTc=;
        b=NhEm9T2AwADa9VsvefRZO3hJf81eglORlqEc/M/a8rR0kuSIY5UrlWGbaksqIVirGr
         J6QDJ3CyNkeplzaOrje+vpzgt129yWbwHTzlb+beGZFWZQ8LQ0tH754TJy6h0q3jS8jo
         cGxvFhbRKlBHTIBko/408oiJovV3JTKwJW8QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUcKCdqxUtmE3c3/sCLCFX58+aEPLItGYu5wwEcivTc=;
        b=gaAuqdADbjDoMeeSmzfMBCF30dmCQXNoTcO8Ft5rtYaE9gbF9FOQLYqPeDhyd2A4oh
         in10i7J3wpXG1meASmB+GG2zYyLo33qM53khZLgEOe0Unv2Pm88TnYSXD+8GGCZDcXNc
         DWpjI29A70fAQ9kCoauu7pq990isqQ1kr4hYuTlSjzN3xxJLG+tsUy3vIiLdUC+xgIpc
         j6/iewT4k6CrVrsXcX5dNlBoG39M4x+dOmexEKZt1oNtHiSvzidaf3LPOPJ6rV0h+oh7
         TUvLtBE7UKpFjpoetbZffOsh7F7zuU2Y7B88FZSIX7z+duzH2u4o7P3qVOBBfmzmSMns
         IJ1w==
X-Gm-Message-State: AOAM532By1Y9+8iSSOlHiDjwWELbyCp5DDlkG8GpNnvLVDIp0gbQVT6l
        peL+Efpmw0D55+Enw7ciELvigg==
X-Google-Smtp-Source: ABdhPJxTkbyFhURADasjsjB42g8YIEdg4z+Ug1Qla2hS5HdHoxmM0uHRHvdpONYXgEmtPzgr5O1D4Q==
X-Received: by 2002:a17:90a:49c4:: with SMTP id l4mr2647464pjm.33.1612851760260;
        Mon, 08 Feb 2021 22:22:40 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id x14sm20837364pfj.15.2021.02.08.22.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:22:39 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH v4 08/14] swiotlb: Use restricted DMA pool if available
Date:   Tue,  9 Feb 2021 14:21:25 +0800
Message-Id: <20210209062131.2300005-9-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of swiotlb setting, the restricted DMA pool is preferred if
available.

The restricted DMA pools provide a basic level of protection against the
DMA overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system
needs to provide a way to lock down the memory access, e.g., MPU.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 13 +++++++++++++
 kernel/dma/direct.h     |  2 +-
 kernel/dma/swiotlb.c    | 20 +++++++++++++++++---
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f13a52a97382..76f86c684524 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -71,6 +71,15 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+bool is_swiotlb_force(struct device *dev);
+#else
+static inline bool is_swiotlb_force(struct device *dev)
+{
+	return unlikely(swiotlb_force == SWIOTLB_FORCE);
+}
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
+
 bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
@@ -80,6 +89,10 @@ phys_addr_t get_swiotlb_start(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long new_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
+static inline bool is_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 7b83b1595989..b011db1b625d 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,7 +87,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+	if (is_swiotlb_force(dev))
 		return swiotlb_map(dev, phys, size, dir, attrs);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e22e7ae75f1c..6fdebde8fb1f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -40,6 +40,7 @@
 #include <linux/debugfs.h>
 #endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -109,6 +110,10 @@ static struct swiotlb default_swiotlb;
 
 static inline struct swiotlb *get_swiotlb(struct device *dev)
 {
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (dev && dev->dev_swiotlb)
+		return dev->dev_swiotlb;
+#endif
 	return &default_swiotlb;
 }
 
@@ -508,7 +513,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
 	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, swiotlb->start);
 	unsigned long flags;
 	phys_addr_t tlb_addr;
@@ -519,7 +524,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	unsigned long max_slots;
 	unsigned long tmp_io_tlb_used;
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (no_iotlb_memory && !hwdev->dev_swiotlb)
+#else
 	if (no_iotlb_memory)
+#endif
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
@@ -641,7 +650,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, size_t alloc_size,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
 	unsigned long flags;
 	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
@@ -689,7 +698,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
 	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = swiotlb->orig_addr[index];
 
@@ -801,6 +810,11 @@ late_initcall(swiotlb_create_default_debugfs);
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
+bool is_swiotlb_force(struct device *dev)
+{
+	return unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dev_swiotlb;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.30.0.478.g8a0d178c01-goog

