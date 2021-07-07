Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572D3BE269
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGGFQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:16:00 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:55138 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhGGFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:15:59 -0400
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
        by gw2.atmark-techno.com (Postfix) with ESMTP id 2314F20D27
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:13:18 +0900 (JST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 7422120D27
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:13:17 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id 11-20020a62150b0000b029031c6298f275so768126pfv.14
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 22:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/lUbYTDaeXrb/TOvjVfoe26NBjr4owCaAB/8eFrqFc=;
        b=lEAlqmJ/uvQqnmUl/laTjdFA9+/EFIhD8PzOTNrVhS5L+T+S8SRsix4yLLhYFRWfo+
         Qb/ZiZHC3Ptv91+MFgN3nihmrC7919l6wotKIONQco+EN4YQ3iJxwCxyI4vl4M4nJA5q
         1gZooJIchPX/Ybnvqv3eaJtFtLmUpkMrCsH6iElGzWcpM3jYEt2p7JbpqVuWur9c1W1x
         Py+VgHJVaJtYg41C1RnqD3Crsv+mSVOJoPoaqljZkP3VWghZL5g1A2j19qU9AWWIwMJr
         682sIpGfyU0cC7r5kK6seqHhx4eqYmXbYGIvCQldNg24WFeZvOHrKRbVHQQQvp72Ad2D
         YdTQ==
X-Gm-Message-State: AOAM531rrZk6J5G5iRn2rOsSt3ouwG8wNxCrLg836LPXMW1namiBrRRi
        8oOe6uTh53zosVWoBeUJE2LCQLIGXRUYWDe1pqI+7BqAuLU+IKjk6RaxC52Bv4fPQmwvCtnIe5b
        hzjP6BFvp/6UQio0rs1FSvIN8Lg==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr24728281pgv.225.1625634796521;
        Tue, 06 Jul 2021 22:13:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWE9lqwa5L5juVNgKdjfPF7Uy1NnEZfGHcsPDXkkvUuTeooGFCmbsKgaK9nG/PZvdNhTwfQA==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr24728260pgv.225.1625634796228;
        Tue, 06 Jul 2021 22:13:16 -0700 (PDT)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id h9sm11555634pgi.43.2021.07.06.22.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 22:13:15 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1m0zs2-008twv-8v; Wed, 07 Jul 2021 14:13:14 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        Bumyong Lee <bumyong.lee@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] swiotlb: add overflow checks to swiotlb_bounce
Date:   Wed,  7 Jul 2021 14:12:54 +0900
Message-Id: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr
when tlb_addr has offset") which fixed unaligned dma mappings,
making sure the following overflows are caught:

- offset of the start of the slot within the device bigger than
requested address' offset, in other words if the base address
given in swiotlb_tbl_map_single to create the mapping (orig_addr)
was after the requested address for the sync (tlb_offset) in the
same block:

 |------------------------------------------| block
              <----------------------------> mapped part of the block
              ^
              orig_addr
       ^
       invalid tlb_addr for sync

- if the resulting offset was bigger than the allocation size
this one could happen if the mapping was not until the end. e.g.

 |------------------------------------------| block
      <---------------------> mapped part of the block
      ^                               ^
      orig_addr                       invalid tlb_addr

Both should never happen so print a warning and bail out without trying
to adjust the sizes/offsets: the first one could try to sync from
orig_addr to whatever is left of the requested size, but the later
really has nothing to sync there...

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bumyong Lee <bumyong.lee@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
---

Hi Konrad,

here's the follow up for the swiotlb/caamjr regression I had promissed.
It doesn't really change anything, and I confirmed I don't hit either of
the warnings on our board, but it's probably best to have as either
could really happen.


 kernel/dma/swiotlb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..23f8d0b168c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -354,13 +354,27 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
-	unsigned int tlb_offset;
+	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
-	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
-		     swiotlb_align_offset(dev, orig_addr);
+	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
+	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	if (tlb_offset < orig_addr_offset) {
+		dev_WARN_ONCE(dev, 1,
+			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
+			orig_addr_offset, tlb_offset);
+		return;
+	}
+
+	tlb_offset -= orig_addr_offset;
+	if (tlb_offset > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
+			alloc_size, size, tlb_offset);
+		return;
+	}
 
 	orig_addr += tlb_offset;
 	alloc_size -= tlb_offset;
-- 
2.30.2

