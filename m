Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5083A996D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFPLpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFPLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:45:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F94C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:43:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e25so3420934ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nQgkz7v7kjXkgg5q9M0yPzBFdiLLV6nxJ8RkjNgpeA=;
        b=aDPrdhEfh1kFSt/STcDHzzby2mSMyRVLn2/IHyVKerpOr7l762ZRsl4B8m+uIlcDi3
         YarS0JqZSnkfgGWTjhBS33bwVvWwsN9nS6HTbF06IdrjyF0I+4ErUV0d4n3oQwSBWmRP
         dj+YSl8fn58koBvmMomHtj+y335nmWnHTHraIFK6AntfuXyCET5STmdVe2XbvZl7nFhp
         BO6DQqYEqPgl4aaK7NM2AXkY++fkunJiXeaavy0hWBed6lC73frJYMnYO1aVCTLtlrF1
         +S4ovABSl4rLVsvoQQEbRdYYJjfqE1/WP2IX9ovrmrc8rEP1iDam+gsllSJ/H1DQHFmm
         O1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nQgkz7v7kjXkgg5q9M0yPzBFdiLLV6nxJ8RkjNgpeA=;
        b=Wq3jCRGIhRC0ssJrCJtpLFWzhcyh9b8Dv0yQp3IAZT4YpP+5o9K1T3H20rg0x1r3Sp
         401fSGKYhmOJniP0czP1px9RbT0DWxvyz8QEo4JiZCQwPiQGVnIvdwd3/ahxF6qsrRh0
         e+5MqGldjMfFzoTaAyEV4V6OZPT7sott3+B9C7qt4WirIknZ5VTeovMwzR6RIANCQ+em
         SESPHGrAZUP0UxTQ+bD6sa1m4bHbd8clIBaGX48WZ4OP8Q7bsMWsYsQojdvKhAbwaU3y
         //dzphp3EK0SUMSE6gFefQU1DS9WWOR2Xh/wBIJ21WOVt87TbzUUMtiyCtf7d824DZHN
         mZLg==
X-Gm-Message-State: AOAM533fe3yPAat5WdDtiUSRdd9JrxY/SPX+O7967znCTVVE5rIkxcMX
        JrWvRV/DTo5PvME/MpBn7MohLIEBnJF5Lgns
X-Google-Smtp-Source: ABdhPJy8y+YAcCkoYKQg66iG8xEkfr5244XcQiy8PJossc/WgLE8Gd946VbZxMMUHzTiblQoWh+b7A==
X-Received: by 2002:a2e:b0eb:: with SMTP id h11mr2037701ljl.350.1623843794328;
        Wed, 16 Jun 2021 04:43:14 -0700 (PDT)
Received: from localhost ([178.151.124.169])
        by smtp.gmail.com with ESMTPSA id m18sm239190ljg.105.2021.06.16.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:43:14 -0700 (PDT)
From:   Roman Skakun <rm.skakun@gmail.com>
X-Google-Original-From: Roman Skakun <roman_skakun@epam.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <rm.skakun@gmail.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Subject: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable dma ops
Date:   Wed, 16 Jun 2021 14:42:05 +0300
Message-Id: <20210616114205.38902-2-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616114205.38902-1-roman_skakun@epam.com>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <20210616114205.38902-1-roman_skakun@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is dedicated to fix incorrect conversion from
cpu_addr to page address in cases when we get virtual
address which allocated through xen_swiotlb_alloc_coherent()
and can be mapped in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

The reference code for mmap() and get_sgtable() was copied
from kernel/dma/ops_helpers.c and modified to provide
additional detections as described above.

In order to simplify code there was added a new
dma_cpu_addr_to_page() helper.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
---
 drivers/xen/swiotlb-xen.c | 42 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 90bc5fc321bc..9331a8500547 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -118,6 +118,14 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+static struct page *cpu_addr_to_page(void *cpu_addr)
+{
+	if (is_vmalloc_addr(cpu_addr))
+		return vmalloc_to_page(cpu_addr);
+	else
+		return virt_to_page(cpu_addr);
+}
+
 static int
 xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
@@ -337,7 +345,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
-	struct page *page;
+	struct page *page = cpu_addr_to_page(vaddr);
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -349,11 +357,6 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (is_vmalloc_addr(vaddr))
-		page = vmalloc_to_page(vaddr);
-	else
-		page = virt_to_page(vaddr);
-
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
 	    TestClearPageXenRemapped(page))
@@ -573,7 +576,23 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		     unsigned long attrs)
 {
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+	struct page *page = cpu_addr_to_page(cpu_addr);
+	int ret;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(page) + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
 
 /*
@@ -585,7 +604,14 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 			void *cpu_addr, dma_addr_t handle, size_t size,
 			unsigned long attrs)
 {
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+	struct page *page = cpu_addr_to_page(cpu_addr);
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
-- 
2.25.1

