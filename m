Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59E387217
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbhERGn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbhERGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:43:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC345C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 23:42:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so6295985pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0zGqobmE+lkmHMw08LsrZsxoikwodhRrqdMyWS0tAA=;
        b=O8aagNy7FTFrooDCYpuJrDWSCqHTLGXjKyHB+pHE3/z4xA8UjgEXEMQpyVbvLArn5p
         9RJMtnPI2hNJiJeB9uZpd77ozYEpj0B51kQWMUn421k3M3UchQ3Wf3jETisNv4LiCWmi
         FgM2BAfPUmtI31bzjXPvC0R9T3e7TB1+XP0rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0zGqobmE+lkmHMw08LsrZsxoikwodhRrqdMyWS0tAA=;
        b=QZB8M6UdcSQ7AmfZfrbVYxUwWU7Jt7nU3MLtGX4sI4Fp/efxzFRWyzLD7DMXuHQb/P
         ELFb8gQWMIAQ5q6CEd9iJEeS9Rw9LjzUXXKWSqISntqti9zpOVSInZuUFwNkp/BXiASq
         gvSC9a07Lte3KfpG1dcinSJ7LvP0NR0A2jd3OZK5ts9WxKWxTSSJXUAuIJ1nA5DELN0P
         0Z3ft0pICaqi+I1+LAs0UErM66Vds+h7auZi7xThj/pLPwMA6UwYDmathXoGwEFWu/SS
         pIq1gCDnWaAlWdGwqWFPOGc+2HsUQvEyK7akMbUSC6nPuk0P2kYkPrfQrSjSBGjGeIpn
         RtQw==
X-Gm-Message-State: AOAM530XYaCU1725ndo9LZJfG8Gs3i8/o6uOjGROlEQn23iMhSKH2p+7
        JZ6wYFPyedRFscNJ1Y9r260zyw==
X-Google-Smtp-Source: ABdhPJxbs6f1RTLLRHsqfyQiH6DipBZlDpzIt/59ehrA6/8WtAYygFAyd6CI4Mf217YDPltmWUCLBg==
X-Received: by 2002:aa7:938f:0:b029:2de:2cf2:6a27 with SMTP id t15-20020aa7938f0000b02902de2cf26a27mr2479969pfe.47.1621320158403;
        Mon, 17 May 2021 23:42:38 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id f18sm12153863pjh.55.2021.05.17.23.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:42:38 -0700 (PDT)
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
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
Date:   Tue, 18 May 2021 14:42:01 +0800
Message-Id: <20210518064215.2856977-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
initialization to make the code reusable.

Note that we now also call set_memory_decrypted in swiotlb_init_with_tbl.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..d3232fc19385 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -168,9 +168,30 @@ void __init swiotlb_update_mem_attributes(void)
 	memset(vaddr, 0, bytes);
 }
 
-int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				    unsigned long nslabs, bool late_alloc)
 {
+	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
+
+	mem->nslabs = nslabs;
+	mem->start = start;
+	mem->end = mem->start + bytes;
+	mem->index = 0;
+	mem->late_alloc = late_alloc;
+	spin_lock_init(&mem->lock);
+	for (i = 0; i < mem->nslabs; i++) {
+		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		mem->slots[i].alloc_size = 0;
+	}
+
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+	memset(vaddr, 0, bytes);
+}
+
+int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+{
 	struct io_tlb_mem *mem;
 	size_t alloc_size;
 
@@ -186,16 +207,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	if (!mem)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
-	mem->nslabs = nslabs;
-	mem->start = __pa(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
+
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
 
 	io_tlb_default_mem = mem;
 	if (verbose)
@@ -282,7 +295,6 @@ swiotlb_late_init_with_default_size(size_t default_size)
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
-	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -297,20 +309,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!mem)
 		return -ENOMEM;
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	mem->late_alloc = 1;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
-
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
 	io_tlb_default_mem = mem;
 	swiotlb_print_info();
-- 
2.31.1.751.gd2f1c929bd-goog

