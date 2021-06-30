Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4203B7DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhF3HOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhF3HOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B769161D0D;
        Wed, 30 Jun 2021 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625037141;
        bh=qrNdjflpUvLivu9UtSwHedId14adKJHrYDNOU0/V3Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUqE6XNSw7dk8e2ZILlvfQq1B44GHU4kBesWjirZ6covpZVFA40ua/1O47D6jqxSB
         iuO138aUwA+rxwY6m0o/pbHv4c8JpG3aY0jES2YDxV5hvX+//xHdMbMWnwwWqShJKM
         R01ukn142OFPS2qQRvllI/9k5GTkVukP7Mg40e1LHJkrmfnNk9FQoxHby/K8ck19NP
         CW2W3061j+8wpglgwGYglAj9DAhdB5hjUifUibLsMXrsJTaAy9l77cznRzv5hgFS5t
         hmLS3L+wmYYXh1XovlmRz8Fvb8cagnxWeEA0/Q4RqhTiTNzLRAS2U6y6J3gc0GR6E6
         ZHOo2z4dndf5g==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 1/4] memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
Date:   Wed, 30 Jun 2021 10:12:08 +0300
Message-Id: <20210630071211.21011-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210630071211.21011-1-rppt@kernel.org>
References: <20210630071211.21011-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The code that frees unused memory map uses rounds start and end of the
holes that are freed to MAX_ORDER_NR_PAGES to preserve continuity of the
memory map for MAX_ORDER regions.

Lots of core memory management functionality relies on homogeneity of the
memory map within each pageblock which size may differ from MAX_ORDER in
certain configurations.

Although currently, for the architectures that use free_unused_memmap(),
pageblock_order and MAX_ORDER are equivalent, it is cleaner to have common
notation thought mm code.

Replace MAX_ORDER_NR_PAGES with pageblock_nr_pages and update the comments
to make it more clear why the alignment to pageblock boundaries is
required.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..97fa87541b5f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1943,11 +1943,11 @@ static void __init free_unused_memmap(void)
 		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
 #else
 		/*
-		 * Align down here since the VM subsystem insists that the
-		 * memmap entries are valid from the bank start aligned to
-		 * MAX_ORDER_NR_PAGES.
+		 * Align down here since many operations in VM subsystem
+		 * presume that there are no holes in the memory map inside
+		 * a pageblock
 		 */
-		start = round_down(start, MAX_ORDER_NR_PAGES);
+		start = round_down(start, pageblock_nr_pages);
 #endif
 
 		/*
@@ -1958,11 +1958,11 @@ static void __init free_unused_memmap(void)
 			free_memmap(prev_end, start);
 
 		/*
-		 * Align up here since the VM subsystem insists that the
-		 * memmap entries are valid from the bank end aligned to
-		 * MAX_ORDER_NR_PAGES.
+		 * Align up here since many operations in VM subsystem
+		 * presume that there are no holes in the memory map inside
+		 * a pageblock
 		 */
-		prev_end = ALIGN(end, MAX_ORDER_NR_PAGES);
+		prev_end = ALIGN(end, pageblock_nr_pages);
 	}
 
 #ifdef CONFIG_SPARSEMEM
-- 
2.28.0

