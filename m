Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54F357327
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbhDGR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243605AbhDGR0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:26:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DA706121E;
        Wed,  7 Apr 2021 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617816404;
        bh=xxAF7GHeBxkoT1bP5pdr71a5gAYBafBiXk5AmPplAhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iy1Snv0d8wa9Gx1CvzBU2QHXvg8HODrh4v4kHJw7ZBX7JL8xaqXRB590SqXs+CNjH
         pE+eXk32d7FQN0cilfmOLn/BiBgI4xxnT5vA1vamqzxfPPqaBSQ7ky+6eoHoLVHxfi
         fJuctfoSQCEPlOYxGLFtRDzcLVCfJfSk36KTpMzaBgRggsblH19R+FRS4TeUdv6YKL
         sqeiXzMD1RR9vaK6fpsm5SLMvGrG7tvvH3osMJZRxFPFIqOyEaophkqlUuWP7gJzer
         xvDCHS7iIleB3TtvhZRzHq4WXb98Bhy8xnYKYTRneTHaWYyzZaquXwDXqH61lzpao2
         fVLczihgwKJNw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved pages
Date:   Wed,  7 Apr 2021 20:26:05 +0300
Message-Id: <20210407172607.8812-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210407172607.8812-1-rppt@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The struct pages representing a reserved memory region are initialized
using reserve_bootmem_range() function. This function is called for each
reserved region just before the memory is freed from memblock to the buddy
page allocator.

The struct pages for MEMBLOCK_NOMAP regions are kept with the default
values set by the memory map initialization which makes it necessary to
have a special treatment for such pages in pfn_valid() and
pfn_valid_within().

Split out initialization of the reserved pages to a function with a
meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
reserved regions and mark struct pages for the NOMAP regions as
PageReserved.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..6b7ea9d86310 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2002,6 +2002,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	return end_pfn - start_pfn;
 }
 
+static void __init memmap_init_reserved_pages(void)
+{
+	struct memblock_region *region;
+	phys_addr_t start, end;
+	u64 i;
+
+	/* initialize struct pages for the reserved regions */
+	for_each_reserved_mem_range(i, &start, &end)
+		reserve_bootmem_region(start, end);
+
+	/* and also treat struct pages for the NOMAP regions as PageReserved */
+	for_each_mem_region(region) {
+		if (memblock_is_nomap(region)) {
+			start = region->base;
+			end = start + region->size;
+			reserve_bootmem_region(start, end);
+		}
+	}
+}
+
 static unsigned long __init free_low_memory_core_early(void)
 {
 	unsigned long count = 0;
@@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_range(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	memmap_init_reserved_pages();
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
-- 
2.28.0

