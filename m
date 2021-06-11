Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84F3A3FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFKJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:58:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A892C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:55:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m21so7671045lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6Nq/3eMJ61O2ppaiV+K5WCKa4wxPQ8pA+EactXa5/Q=;
        b=ph/XomxAPqIvxyU2lBvMH35+Kz6l15GgxHvCZPiV1EKnsNbwv18k8r3CfcXnDTadvY
         0HnwK+tCN0fm+FLw08qSlxbWGgLd6GqEV8gP9+/y3mC8mcoEseYaHD7LCYroqq3CWIuc
         rvV1kJGEsSsa+H0Bu3TBsRdiyQHI4toAKrUIEEeDeNkbUJRQmjgiwHPiHMItUrOZc1Jp
         W4prezTF9Lefwdpg90MeiDy/5zo0TrVfeIoYveukEK7APT3Exak8EMxXVAcMlp+QDfko
         P6XaKRDFXiSX8yq0rw+oLRrog118hw6/Wc5k0gg7+VdGPRxrUvhmGPfxUDfyLjcQfPpN
         E6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6Nq/3eMJ61O2ppaiV+K5WCKa4wxPQ8pA+EactXa5/Q=;
        b=NRKZXVBIW0VF7RwfAA0KpK34/UQf/1JHBiTIS0bE4uZll6xY2qvo1EvZ01S9/5jtRo
         qmvWL2jgVVgSM6/nVv/66jLeZxqdOal3/NgQeZ9UdQN1k0nR2R3vtwVnobGSkCGXTW4d
         /pDHhUVMoOiiW/SZMZGLk1p6XPfjlhUg7j04/J5XK0IeSLHnWXRO55EJD/tOw1HpAgYv
         nETJoGJ1WasEuhtn+HfOmRkfi4spNkTPS+WpLdWe8LK7fkhYdhEYtx5ZmR9fGkowkJwv
         miwWm6ITpMt9krIu9kicVSdIqu6BzrHqsCOts3U2+f57FwemmKNkm5XsCSB8jo4XhxVz
         Yr5Q==
X-Gm-Message-State: AOAM5325lRHJrNV0sL/e9t+pGPvqrZRI4mLf0eeltS2SQh2hpFncqN0Z
        Zp6YZDlpNCeOCxU5vUMmFJ4=
X-Google-Smtp-Source: ABdhPJy8EDHCE1f4s4ZC6KDj2A/UHmJhDH+REBsIFZnu4F/CM9rWslxdJXdDy1hMj7lLIs/rkF7G0w==
X-Received: by 2002:a19:dc02:: with SMTP id t2mr2158836lfg.261.1623405347760;
        Fri, 11 Jun 2021 02:55:47 -0700 (PDT)
Received: from localhost ([178.151.124.169])
        by smtp.gmail.com with ESMTPSA id r17sm651828ljp.40.2021.06.11.02.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:55:47 -0700 (PDT)
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
Subject: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
Date:   Fri, 11 Jun 2021 12:55:28 +0300
Message-Id: <20210611095528.9230-1-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is dedicated to fix incorrect convertion from
cpu_addr to page address in cases when we get virtual
address which allocated throught xen_swiotlb_alloc_coherent()
and can be mapped in the vmalloc range.
As the result, virt_to_page() cannot convert this address
properly and return incorrect page address.

Need to detect such cases and obtains the page address using
vmalloc_to_page() instead.

The reference code was copied from kernel/dma/ops_helpers.c
and modified to provide additional detections as described
above.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
Reviewed-by: Andrii Anisov <andrii_anisov@epam.com>

---
Also, I have observed that the original common code didn't 
make additional checks about contiguity of the memory region
represented by cpu_addr and size

May be, this means that these functions can get only physically 
contiguous memory.
Is this correct?

Cheers!

---
 drivers/xen/swiotlb-xen.c | 51 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..f99c98472927 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -563,6 +563,53 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
+static int
+xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+	struct page *page;
+
+	if (is_vmalloc_addr(cpu_addr))
+		page = vmalloc_to_page(cpu_addr);
+	else
+		page = virt_to_page(cpu_addr);
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return -ENXIO;
+
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(page) + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
+}
+
+static int
+xen_swiotlb_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
+{
+	struct page *page;
+	int ret;
+
+	if (is_vmalloc_addr(cpu_addr))
+		page = vmalloc_to_page(cpu_addr);
+	else
+		page = virt_to_page(cpu_addr);
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
+}
+
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -575,8 +622,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.mmap = dma_common_mmap,
-	.get_sgtable = dma_common_get_sgtable,
+	.mmap = xen_swiotlb_dma_mmap,
+	.get_sgtable = xen_swiotlb_dma_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
-- 
2.27.0

