Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E211C437079
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhJVD3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232606AbhJVD3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3D38619BB;
        Fri, 22 Oct 2021 03:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634873214;
        bh=dzVTEjYRvmGezdHFFYtBNFqE16zf9YNbNz8le8VBIjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qdc4pnTlrUjTjgzU9JkiOX5K4g7nVlz54G5x2dfMNCsUi4hCl90buh+usFnbV1R2F
         CrfX+ZulE3uxYnvhDwezjEltulhqzRqs2LAI7LRWlnrfMObRLBTbMeQy3n8U+oVTIR
         gAErfhkmBP0FJcCoSvVeWEhOksaf2C+dFRRxpfGY=
Date:   Thu, 21 Oct 2021 20:26:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <npiggin@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <shakeelb@google.com>, <urezki@gmail.com>
Subject: Re: [PATCH v3 2/2] mm/vmalloc: introduce
 alloc_pages_bulk_array_mempolicy to accelerate memory allocation
Message-Id: <20211021202652.ff8568bd5d58fbcf32946f83@linux-foundation.org>
In-Reply-To: <20211021080744.874701-3-chenwandun@huawei.com>
References: <20211021080744.874701-1-chenwandun@huawei.com>
        <20211021080744.874701-3-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 16:07:44 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> It

What is "it"?

> will cause significant performance regressions in some situations
> as Andrew mentioned in [1]. The main situation is vmalloc, vmalloc
> will allocate pages with NUMA_NO_NODE by default, that will result
> in alloc page one by one;
> 
> In order to solve this, __alloc_pages_bulk and mempolicy should be
> considered at the same time.
> 
> 1) If node is specified in memory allocation request, it will alloc
> all pages by __alloc_pages_bulk.
> 
> 2) If interleaving allocate memory, it will cauculate how many pages
> should be allocated in each node, and use __alloc_pages_bulk to alloc
> pages in each node.

This v3 patch didn't incorporate my two fixes, below.  It is usual to
incorporate such fixes prior to resending.  I have retained those two
fixes, now against v3.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix

make two functions static

Cc: Chen Wandun <chenwandun@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mempolicy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/mempolicy.c~mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix
+++ a/mm/mempolicy.c
@@ -2196,7 +2196,7 @@ struct page *alloc_pages(gfp_t gfp, unsi
 }
 EXPORT_SYMBOL(alloc_pages);
 
-unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
+static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
@@ -2231,7 +2231,7 @@ unsigned long alloc_pages_bulk_array_int
 	return total_allocated;
 }
 
-unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
+static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
_




From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix-2

fix CONFIG_NUMA=n build.  alloc_pages_bulk_array_mempolicy() was undefined

Cc: Chen Wandun <chenwandun@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmalloc.c~mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix-2
+++ a/mm/vmalloc.c
@@ -2860,7 +2860,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * otherwise memory may be allocated in only one node,
 			 * but mempolcy want to alloc memory by interleaving.
 			 */
-			if (nid == NUMA_NO_NODE)
+			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
 				nr = alloc_pages_bulk_array_mempolicy(gfp,
 							nr_pages_request,
 							pages + nr_allocated);
_

