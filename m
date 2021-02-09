Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10C3148A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBIGXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBIGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:22:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BDC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:21:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so1038855pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQjRLnhkPorvAVKaOPejw74RXuDyQjfs10AJ4S/GkGY=;
        b=iIl5SP7dar66QYJx01a8eKBzk/OkK/x97Udeqkp8z6Zecwu6gJbtr4+R7AJhbJUsET
         mW/NYKe+92F4cTf+MWb8Kjs3DEc/fRUB2Tuk/IK9lw1i5dbH+o71qP4rUdYAStwKxzrf
         aFKGX0hir3NozqAR+M+IQwDL2zs+YG9OyvX5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQjRLnhkPorvAVKaOPejw74RXuDyQjfs10AJ4S/GkGY=;
        b=QMxZXzlzem2+oCadcNMJRljgKouFfp69ScajUhySHF/pQihVQcV6jL62Hv6Sej/Wga
         GPok2dgNeS6GTcUf5fFaA1P87HTyq44UoaMPbuxW4/uNa25pJo/oII7/bzw14X9oOpj9
         np1iBGU7BEwykuvYFVUXX+cMyRL+E3NmendU2OpDDZXOkfVlORjSQvWaKOnfTLl5hXVN
         eIhDdUAxJfodHPt+nieoHouOnh5XBez0OpOWwzgTAAbY7c3/Y2mSpudOC1EYngvdMthr
         XLbtXdSVHQD8Ytjv110KIcPOzogOGbHin16maeQVtC1Et4pKJF5HYJ6qXJH2fKOvMk6w
         UHug==
X-Gm-Message-State: AOAM532XkBJ5sL2Ulq2F24G3uhy4Z6kCgnNJrPvoUdxzrA+AMF/AXuNY
        hfWcLUUh8CSUferjobvmiXnh+A==
X-Google-Smtp-Source: ABdhPJzMs/GVP3LhI2pHnVT9gB2t4EDZQ5t7O4c7u18G3hsJLKUa+IhCtg1SpLtI9Cft7lrwlj4fPw==
X-Received: by 2002:a17:90a:ad09:: with SMTP id r9mr2555446pjq.51.1612851710886;
        Mon, 08 Feb 2021 22:21:50 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
        by smtp.gmail.com with UTF8SMTPSA id y26sm21067426pgk.42.2021.02.08.22.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 22:21:50 -0800 (PST)
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
Subject: [PATCH v4 01/14] swiotlb: Remove external access to io_tlb_start
Date:   Tue,  9 Feb 2021 14:21:18 +0800
Message-Id: <20210209062131.2300005-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function, get_swiotlb_start(), and remove external access to
io_tlb_start, so we can entirely hide struct swiotlb inside of swiotlb.c
in the following patches.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 arch/powerpc/platforms/pseries/svm.c | 4 ++--
 drivers/xen/swiotlb-xen.c            | 4 ++--
 include/linux/swiotlb.h              | 1 +
 kernel/dma/swiotlb.c                 | 5 +++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 7b739cc7a8a9..c10c51d49f3d 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -55,8 +55,8 @@ void __init svm_swiotlb_init(void)
 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
 		return;
 
-	if (io_tlb_start)
-		memblock_free_early(io_tlb_start,
+	if (vstart)
+		memblock_free_early(vstart,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	panic("SVM: Cannot allocate SWIOTLB buffer");
 }
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..91f8c68d1a9b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -192,8 +192,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	/*
 	 * IO TLB memory already allocated. Just use it.
 	 */
-	if (io_tlb_start != 0) {
-		xen_io_tlb_start = phys_to_virt(io_tlb_start);
+	if (is_swiotlb_active()) {
+		xen_io_tlb_start = phys_to_virt(get_swiotlb_start());
 		goto end;
 	}
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d9c9fc9ca5d2..83200f3b042a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -81,6 +81,7 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+phys_addr_t get_swiotlb_start(void);
 void __init swiotlb_adjust_size(unsigned long new_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7c42df6e6100..e180211f6ad9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -719,6 +719,11 @@ bool is_swiotlb_active(void)
 	return io_tlb_end != 0;
 }
 
+phys_addr_t get_swiotlb_start(void)
+{
+	return io_tlb_start;
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 static int __init swiotlb_create_debugfs(void)
--

This can be dropped if Christoph's swiotlb cleanups are landed.
https://lore.kernel.org/linux-iommu/20210207160934.2955931-1-hch@lst.de/T/#m7124f29b6076d462101fcff6433295157621da09 

2.30.0.478.g8a0d178c01-goog

