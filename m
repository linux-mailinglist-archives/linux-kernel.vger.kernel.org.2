Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9B41D0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbhI3Bcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhI3Bcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:32:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2260F615A4;
        Thu, 30 Sep 2021 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632965449;
        bh=wbV6F8K1YktqcMeI72zuNPMPZDIFwa82A8AaD7ODLuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXjfarfg3fUv2muoaPe42X68dGkHzYxP7+Rx+dfcEIwPVEEXYb3YujSrGkuwYaEyR
         RBviPEQVigL46cTnV30o1q9UuVwTnlEwM80bxFwI0dOYDPqd5h7OeNGds+KwCdHbth
         aNRhbH1JLXBtYJx+1W0V35Y7MM53cDmE0dhYqLU+DoKzLo9As2V6bZ62L1VPBx0oeB
         TpDkkGOxFvmsRoFajPHO+DBJGWr3puqmzrHfMTxvzzZXwnPUNwr3MxrXFqkgyrJk4J
         4Lxnxb5c3SAbWRdBXITuXM7EnTl92PVstb9AIKyQn9fbKOLR2V3j1XNg6flwXR2eTU
         t0TgXntvfJYTw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] dma-mapping: remove bogus test for pfn_valid from dma_map_resource
Date:   Thu, 30 Sep 2021 04:30:38 +0300
Message-Id: <20210930013039.11260-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930013039.11260-1-rppt@kernel.org>
References: <20210930013039.11260-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
However, pfn_valid() only checks for availability of the memory map for a
PFN but it does not ensure that the PFN is actually backed by RAM.

As dma_map_resource() is the only method in DMA mapping APIs that has this
check, simply drop the pfn_valid() test from dma_map_resource().

Link: https://lore.kernel.org/all/20210824173741.GC623@arm.com/
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 kernel/dma/mapping.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 06fec5547e7c..dda8d8b84a55 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -296,10 +296,6 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return DMA_MAPPING_ERROR;
 
-	/* Don't allow RAM to be mapped */
-	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
-		return DMA_MAPPING_ERROR;
-
 	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 	else if (ops->map_resource)
-- 
2.28.0

