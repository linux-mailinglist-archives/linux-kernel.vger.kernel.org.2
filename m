Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE593CD4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhGSLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236936AbhGSLvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A5E6115B;
        Mon, 19 Jul 2021 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626697916;
        bh=vCpUosll3mRPKbzIGfrfbIiMPp8FsRjwLd4omMzxTK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRF74qG/2JxqaWKlodJ79rBfg/t782v7e7VYxc5S+tDqKbIqarvtwpEhZCF9KD4+H
         qUdXdyTKYRvRPG3WmJK+pPWNMWKDzDVigSH/F5mlKL8xmzFV/ZA3WZ7ZTG/+GWB4QY
         1auRvkArtMEreIyftYBDNKbr8FRKZT0Gf55B9gLk3tbuNQ9fQACGbKzSTsrh2mJurE
         5rRpdsWJ305tsAyQBzPeEqPDAqEpT7ehQUSBo8e0Z0As7KNKeeo47qNYmeDXCuzgSv
         i0Tq/h4YNjD4D1GxcIR8778Ar9btWxCoNmJ7v81fOor+NKCRan0ZeT3O/OOYxZHi1a
         rnBWrLYYnXy+Q==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5/5] swiotlb: Free tbl memory in swiotlb_exit()
Date:   Mon, 19 Jul 2021 13:30:54 +0100
Message-Id: <20210719123054.6844-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719123054.6844-1-will@kernel.org>
References: <20210719123054.6844-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although swiotlb_exit() frees the 'slots' metadata array referenced by
'io_tlb_default_mem', it leaves the underlying buffer pages allocated
despite no longer being usable.

Extend swiotlb_exit() to free the buffer pages as well as the slots
array.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b3c793ed9e64..87c40517e822 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -328,18 +328,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 void __init swiotlb_exit(void)
 {
-	size_t size;
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long tbl_vaddr;
+	size_t tbl_size, slots_size;
 
 	if (!mem->nslabs)
 		return;
 
 	pr_info("tearing down default memory pool\n");
-	size = array_size(sizeof(*mem->slots), mem->nslabs);
-	if (mem->late_alloc)
-		free_pages((unsigned long)mem->slots, get_order(size));
-	else
-		memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
+	tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
+	tbl_size = PAGE_ALIGN(mem->end - mem->start);
+	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
+
+	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	if (mem->late_alloc) {
+		free_pages(tbl_vaddr, get_order(tbl_size));
+		free_pages((unsigned long)mem->slots, get_order(slots_size));
+	} else {
+		memblock_free_late(mem->start, tbl_size);
+		memblock_free_late(__pa(mem->slots), slots_size);
+	}
+
 	memset(mem, 0, sizeof(*mem));
 }
 
-- 
2.32.0.402.g57bb445576-goog

