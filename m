Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B123148C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhBIGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBIGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:23:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3979C0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:22:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j12so11231433pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvKUPmchuhcE1zfso8bHoA3z2cJUHyqor/xynDrdSzc=;
        b=WmMoRPfwVrKkMTfzfSeApWYOsANXGiOgA3320pKWhEerXc+d04kio6kBo6Samikmhh
         dKY6FAm9apY748uamOD6+T+Q7zkEWfp30SA3fCJNtSNB7CjdS5M+/v04eEEHZ9JPhbQU
         oGnPa5k409EctotY2FmiW01VL+4N5+/MQmqlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvKUPmchuhcE1zfso8bHoA3z2cJUHyqor/xynDrdSzc=;
        b=aBOApgPCZT8FSl5XQU03FwG0TmPzYl4jvJpTVhsQiPIaTLEeXNC2VopgHHMxKWQOHW
         Bch2ROgkP0g99HdurIhgpfaYj5ifwchQMbFoWapVUhQYj3V7z+QYnMNjaRS6ueQK7R4D
         4JNMg0CmqV5sUgEe2onCeFpX/dBN/bTc8+fZFvkbTBwvbf9xGSgwozBd9ce+nPmCgP6r
         HpgMImWvXSoezSmgap4J7O2ZdMA2fXaUBknrPLXC/RJ58hppaZnW1vNdBkR5ECOgCbs3
         h+LEkRGpWsyL/tLpLApbq8McIZwP5WHt4HF0UuuMzMzAmPKbwq328RhR2KuIVhRZiNX4
         7w5A==
X-Gm-Message-State: AOAM5307ZJDQjQJ4cucx1y4UqNUjuH8V5/uzBuIZuH0KmZ3hMVjY4SOQ
        ZzF81JZqXj9PtSu0mLUSfJk8PA==
X-Google-Smtp-Source: ABdhPJwPilLMeHO4izUWlTNwHOL/6AulGQdpqWdqLrBPBm35gr6jqlo9rCgrJT+lklmP7VdqmUgqQg==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr1570888pgd.58.1612851732543;
        Mon, 08 Feb 2021 22:22:12 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id w1sm14605147pfg.116.2021.02.08.22.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:22:11 -0800 (PST)
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
Subject: [PATCH v4 04/14] swiotlb: Refactor swiotlb_late_init_with_tbl
Date:   Tue,  9 Feb 2021 14:21:21 +0800
Message-Id: <20210209062131.2300005-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor swiotlb_late_init_with_tbl to make the code reusable for
restricted DMA pool initialization.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 65 ++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 28b7bfe7a2a8..dc37951c6924 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -353,20 +353,21 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static int swiotlb_init_tlb_pool(struct swiotlb *swiotlb, phys_addr_t start,
+				size_t size)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
-	unsigned long i, bytes;
+	unsigned long i;
+	void *vaddr = phys_to_virt(start);
 
-	bytes = nslabs << IO_TLB_SHIFT;
+	size = ALIGN(size, 1 << IO_TLB_SHIFT);
+	swiotlb->nslabs = size >> IO_TLB_SHIFT;
+	swiotlb->nslabs = ALIGN(swiotlb->nslabs, IO_TLB_SEGSIZE);
 
-	swiotlb->nslabs = nslabs;
-	swiotlb->start = virt_to_phys(tlb);
-	swiotlb->end = swiotlb->start + bytes;
+	swiotlb->start = start;
+	swiotlb->end = swiotlb->start + size;
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
+	memset(vaddr, 0, size);
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -390,13 +391,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		swiotlb->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	swiotlb->index = 0;
-	no_iotlb_memory = false;
-
-	swiotlb_print_info();
 
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(swiotlb->nslabs << IO_TLB_SHIFT);
 	spin_lock_init(&swiotlb->lock);
 
 	return 0;
@@ -410,6 +405,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct swiotlb *swiotlb = &default_swiotlb;
+	unsigned long bytes = nslabs << IO_TLB_SHIFT;
+	int ret;
+
+	ret = swiotlb_init_tlb_pool(swiotlb, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	no_iotlb_memory = false;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(bytes);
+
+	return 0;
+}
+
 void __init swiotlb_exit(void)
 {
 	struct swiotlb *swiotlb = &default_swiotlb;
@@ -747,17 +763,20 @@ phys_addr_t get_swiotlb_start(void)
 }
 
 #ifdef CONFIG_DEBUG_FS
-
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct swiotlb *swiotlb, const char *name,
+				   struct dentry *node)
 {
-	struct swiotlb *swiotlb = &default_swiotlb;
-
-	swiotlb->debugfs = debugfs_create_dir("swiotlb", NULL);
+	swiotlb->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, swiotlb->debugfs, &swiotlb->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, swiotlb->debugfs, &swiotlb->used);
-	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(&default_swiotlb, "swiotlb", NULL);
+
+	return 0;
+}
 
+late_initcall(swiotlb_create_default_debugfs);
 #endif
-- 
2.30.0.478.g8a0d178c01-goog

