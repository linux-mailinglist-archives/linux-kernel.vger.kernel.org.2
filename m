Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC63CB4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhGPImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhGPImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:42:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70224C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:39:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v20so13963794eji.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Aw+MvYuySKaeeZ9hfm0Wk5AJLKyuRLmX4WBjc8rKNo=;
        b=oUyFrqUYKdou9ruiR6KE+JMXnnLCL8dvqhN70gcyzeACf6NUw7EI0ATRz7wTttz15f
         7mOLygE4HmSHan8OZfyp5j8RPsbBrT3a0He5k0WrJB0y+5+L+NOkn9K5yvzS/pYZCO7p
         u7KZO9StVPaxTPF8Gr1jsGLQfWYOI2yH+fArBC1KqFZmKDSGTfAFVbEAaJhaz4AytnK+
         dyb74/h+h4RPLfu4yWREg9BWVCsYAyrrBgnZTYI0oQjZZZAiUpIi/RfegTpwdAhY2A7S
         DsU9Z4zG4GoeFsMnKMjo7DZYbgBHzHPJ/9lwWvF6RbJwmOcAv7hCambLdViiqWQdNc4U
         0rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Aw+MvYuySKaeeZ9hfm0Wk5AJLKyuRLmX4WBjc8rKNo=;
        b=TwmOf3o8A2ArcSldZL4p4SpBhmkHYgYmA9Juw4CRJ351xuOUymaCrxlvAX7FNimdeI
         9qnT8T2qkYeElamxIW7L8nxyD49kIc614WnCepWzM0oGd8Nz/7gO5qbjMSOk/lRt2qKg
         0XlymoSeqv+/vTlFWQ92HNel7IzAMiqnxZXlbC98Eg8Z74IVtb9pZxRnTYI6YCrah6mf
         7kK7SO/ESNCyj0STtR52I5TFWA9SWzfE8kFakpodiOCL57IpEby5r49pshFJ//rWugfz
         Tqa9mwg4JLktoyec4NvQpshM3wPzdQaakNM8lOBJWFWhXMS2klPGrA5M1QaR87rIxBVD
         24qA==
X-Gm-Message-State: AOAM533Ut7/nzuO5DJifmNRZppG3klwuAjPCxBIbPcRIyE+G9DfVNxQZ
        XRYtOJxCGs2dKHMrjIp1Cro=
X-Google-Smtp-Source: ABdhPJwfFSjxOhCm0YSnLeoEw5a02XTjG3qrNAIfyswu4/Xx0Hrjsx5GukzWb4EvgN4GswtGTuomdw==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr10449398ejb.544.1626424789035;
        Fri, 16 Jul 2021 01:39:49 -0700 (PDT)
Received: from localhost ([185.117.121.76])
        by smtp.gmail.com with ESMTPSA id p18sm3390639edu.8.2021.07.16.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 01:39:48 -0700 (PDT)
From:   Roman Skakun <rm.skakun@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Roman Skakun <rm.skakun@gmail.com>,
        Roman Skakun <Roman_Skakun@epam.com>,
        Roman Skakun <roman_skakun@epam.com>
Subject: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
Date:   Fri, 16 Jul 2021 11:39:34 +0300
Message-Id: <20210716083934.154992-1-rm.skakun@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210715170011.GA17324@lst.de>
References: <20210715170011.GA17324@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Skakun <Roman_Skakun@epam.com>

This commit is dedicated to fix incorrect conversion from
cpu_addr to page address in cases when we get virtual
address which allocated in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>
---
Hi, Christoph!
It's updated patch in accordance with your and Stefano 
suggestions. 

 drivers/xen/swiotlb-xen.c   |  7 +------
 include/linux/dma-map-ops.h |  2 ++
 kernel/dma/ops_helpers.c    | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 92ee6eea30cd..c2f612a10a95 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -337,7 +337,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	int order = get_order(size);
 	phys_addr_t phys;
 	u64 dma_mask = DMA_BIT_MASK(32);
-	struct page *page;
+	struct page *page = cpu_addr_to_page(vaddr);
 
 	if (hwdev && hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
@@ -349,11 +349,6 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
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
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..ce0edb0bb603 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -226,6 +226,8 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+struct page *cpu_addr_to_page(void *cpu_addr);
+
 #ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
 #include <asm/dma-coherence.h>
 #elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 910ae69cae77..472e861750d3 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -5,6 +5,17 @@
  */
 #include <linux/dma-map-ops.h>
 
+/*
+ * This helper converts virtual address to page address.
+ */
+struct page *cpu_addr_to_page(void *cpu_addr)
+{
+	if (is_vmalloc_addr(cpu_addr))
+		return vmalloc_to_page(cpu_addr);
+	else
+		return virt_to_page(cpu_addr);
+}
+
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
@@ -12,7 +23,7 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	struct page *page = virt_to_page(cpu_addr);
+	struct page *page = cpu_addr_to_page(cpu_addr);
 	int ret;
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
@@ -32,6 +43,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	struct page *page = cpu_addr_to_page(cpu_addr);
 	int ret = -ENXIO;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -43,7 +55,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	return remap_pfn_range(vma, vma->vm_start,
-			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
+			page_to_pfn(page) + vma->vm_pgoff,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 #else
 	return -ENXIO;
-- 
2.27.0

