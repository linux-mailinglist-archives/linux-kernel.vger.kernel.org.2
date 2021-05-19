Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE82389077
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354124AbhESORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354100AbhESOQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEC186135F;
        Wed, 19 May 2021 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621433685;
        bh=qrNdjflpUvLivu9UtSwHedId14adKJHrYDNOU0/V3Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twpD1awFlktxWTVN0ZSO9g/5G2LwDY1xG5cwscVPLce3W4s8JvjuQTEtxOKugVKdV
         PoIcsIY2p9KwnI/fNJM6xY4k4SzRIx/o66q8/QgWfHGwLO4H2gs3f3nuXxnDgVXbXt
         DaDuYo2Um8m9zvB85WrNU9tb/Abg2ST94m6QQURW/9Affw1kJLbj4T3bGB7I3I1JEN
         +HhLr67wiekH6h2K30YEM6PPLRaDxgy1E7R4I6u5u35EPGCk4IRIEkx1ZHbcMgMscb
         zUrxAn+0elcSRvMzBfGNTB4LAWlIFM4ywTs2gCCuhV5cSqg7wP7NgcJ1/idK6FIhKK
         7VooDZZF8gTyw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/3] memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
Date:   Wed, 19 May 2021 17:14:34 +0300
Message-Id: <20210519141436.11961-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210519141436.11961-1-rppt@kernel.org>
References: <20210519141436.11961-1-rppt@kernel.org>
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

