Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4133E4453F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDNij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhKDNic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 377C561108;
        Thu,  4 Nov 2021 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636032954;
        bh=OfNAx9rQwiK+QscXJpdjavO2stFix0dG6j0x3xEKe1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=RVwruqXOchb8HPnX9zYesjc5taffYzUjt7Ru/SD0ohD4UwUbooowtwoIEJPTiuRIV
         IKwwp2rfndBuNSLtgY/JjNhXQCExn0GZRbkzR+l30BdDCOOTJG0kHY0iqqYiHWJSNg
         GvgTwB99X/O68fnjRVr9IMIrHSBO0b9xG2WcXLBr3mkZ0t/Byfce148xWoj6fHuCWL
         8XawY1nWvhDKfpPaNCakCh1OTddYg8NaMxoBoTpMcEkeSguYgDDoBD/pLAZoVIYajs
         /5CNVLT0BdybSBmlu0SzRe7GCGlRV6go/ehR2J2mm1y6x4VwjdB1p71cTfOLE0biVg
         NxcuD+n38m5Zg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chen Wandun <chenwandun@huawei.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmap: avoid -Wsequence-point warning
Date:   Thu,  4 Nov 2021 14:35:40 +0100
Message-Id: <20211104133549.1150058-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about potentially undefined behavior in an array index:

mm/vmalloc.c: In function 'vmap_pfn_apply':
mm/vmalloc.c:2800:58: error: operation on 'data->idx' may be undefined [-Werror=sequence-point]
 2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
      |                                                 ~~~~~~~~~^~
arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
   25 | #define __pte(x)        ((pte_t) { (x) } )
      |                                     ^
arch/arm64/include/asm/pgtable.h:80:15: note: in expansion of macro '__phys_to_pte_val'
   80 |         __pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
      |               ^~~~~~~~~~~~~~~~~
mm/vmalloc.c:2800:30: note: in expansion of macro 'pfn_pte'
 2800 |         *pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
      |                              ^~~~~~~

This only appeared in one randconfig build so far, and I don't know
what caused it, but moving the index increment out of the expression
at least addresses the warning.

Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if it's worth doing a deeper analysis of how the compiler
thinks this might go wrong, it would appear that it thinks 'pte'
might be an alias for 'data' here, but only in some configurations.

If you want to try reproducing it, the .config that triggered it is
https://pastebin.com/caeKD1Wv
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..cdac02aab6b1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2797,7 +2797,9 @@ static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
 
 	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
 		return -EINVAL;
-	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx], data->prot));
+	data->idx++;
+
 	return 0;
 }
 
-- 
2.29.2

