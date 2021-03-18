Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58C340C10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhCRRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCRRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:45:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67527C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:45:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id m7so4687011qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cC0KVk2XWbXM3Otj4QsoyPSVbzBYQOGnqzN6CjxIbE=;
        b=FeXkUZk/+jDkciewd2ndeEV3yUAZPtXfx1KYDp4l1woVuAd0/6XTG7mKJI2sKXW/Ix
         fLQvPaJaIYLZvRE3U8DS4bIWeV132hq3TBcWMF/PyfxbqjcANpCVVc+amyvqYMp43ONv
         I/xsmzk8GXlHC1vjq+FQfsWJpcYAkU71FxL2bXyFU7PQ6pXxcYQ83nfdGCO4Vm/Xl84Z
         VkZyKl8IUEPgKrE0/hsbVeirVo5i6VtmEox3I7aRFOn4FlR1g3ymDhIKOBMxQZrf/tdx
         OZaLvT1uw3fy05pZI8twJusIBMaEq0DUhFGV3Fkq/pf2jh4iFNsyC8khGrztvBUPaVGs
         bIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cC0KVk2XWbXM3Otj4QsoyPSVbzBYQOGnqzN6CjxIbE=;
        b=g3vkVvE3goBX9X6h8p8rYpkPnHHg0aUn5yOVkFOUBPoYu60hdlFxDROQYDJpju1yNY
         2xEjFFdJI+FoDZEYAUYvZLcB5xn1R/R4cRfbBjOxcZTtm6fZTIrn0Q7JsCwDk8VibCvZ
         dPXmosOD//rFwCcDj+gO9gPHVE4T7fvF7SMgHQg85I1QyRs0zA9N8vhdSOQ5OKuj03+V
         m7jDVrMc66wFslGBP188Z+kZiZYfCnnt1oQcYY3cOJuyJMux7MhMFsr4MHrrYI0gWVbM
         X1NV7x3GKbxCSTrtfxbwzGw94ywq+bijjwopqTWd3nb1TmW2M94SJJrwfIBLcUq3/Rdb
         5ycA==
X-Gm-Message-State: AOAM5320k3coCr05I4270h8MvXauwAS/XzmKJUpO9xR8EHYf7fFoa3DK
        dNjtpUALuEQQ9eFDRghi+S4=
X-Google-Smtp-Source: ABdhPJx31EWK5tF+LMBJ3oGxSWTZDfT1fmQiRJmKhZA0zRDBYCRb6cKfB1Sb7CHi9VbuDVEDPmwMDA==
X-Received: by 2002:ac8:7776:: with SMTP id h22mr4998624qtu.325.1616089500685;
        Thu, 18 Mar 2021 10:45:00 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com (179-125-249-210.dynamic.desktop.com.br. [179.125.249.210])
        by smtp.gmail.com with ESMTPSA id p8sm1940785qtu.8.2021.03.18.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:45:00 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs
Date:   Thu, 18 Mar 2021 14:44:14 -0300
Message-Id: <20210318174414.684630-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both iommu_alloc_coherent() and iommu_free_coherent() align the
desired allocation size to PAGE_SIZE, and gets system pages and IOMMU
mappings (TCEs) for that value.

When IOMMU_PAGE_SIZE < PAGE_SIZE, this behavior may cause unnecessary
TCEs to be created for mapping the whole system page.

Example:
- PAGE_SIZE = 64k, IOMMU_PAGE_SIZE() = 4k
- iommu_alloc_coherent() is called for 128 bytes
- 1 system page (64k) is allocated
- 16 IOMMU pages (16 x 4k) are allocated (16 TCEs used)

It would be enough to use a single TCE for this, so 15 TCEs are
wasted in the process.

Update iommu_*_coherent() to make sure the size alignment happens only
for IOMMU_PAGE_SIZE() before calling iommu_alloc() and iommu_free().

Also, on iommu_range_alloc(), replace ALIGN(n, 1 << tbl->it_page_shift)
with IOMMU_PAGE_ALIGN(n, tbl), which is easier to read and does the
same.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5b69a6a72a0e..3329ef045805 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -851,6 +851,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	unsigned int order;
 	unsigned int nio_pages, io_order;
 	struct page *page;
+	size_t size_io = size;
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
@@ -877,8 +878,9 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	nio_pages = size >> tbl->it_page_shift;
-	io_order = get_iommu_order(size, tbl);
+	size_io = IOMMU_PAGE_ALIGN(size_io, tbl);
+	nio_pages = size_io >> tbl->it_page_shift;
+	io_order = get_iommu_order(size_io, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
 			      mask >> tbl->it_page_shift, io_order, 0);
 	if (mapping == DMA_MAPPING_ERROR) {
@@ -893,10 +895,9 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	if (tbl) {
-		unsigned int nio_pages;
+		size_t size_io = IOMMU_PAGE_ALIGN(size, tbl);
+		unsigned int nio_pages = size_io >> tbl->it_page_shift;
 
-		size = PAGE_ALIGN(size);
-		nio_pages = size >> tbl->it_page_shift;
 		iommu_free(tbl, dma_handle, nio_pages);
 		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
-- 
2.29.2

