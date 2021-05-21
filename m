Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5238BCFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbhEUDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236995AbhEUDeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:34:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12E64AB64;
        Fri, 21 May 2021 03:32:50 +0000 (UTC)
Date:   Thu, 20 May 2021 20:32:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 01/22] mm: Add vma_lookup()
Message-ID: <20210521033232.dyams2dziycp4hv7@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
 <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Liam Howlett wrote:

>Many places in the kernel use find_vma() to get a vma and then check the
>start address of the vma to ensure the next vma was not returned.
>
>Other places use the find_vma_intersection() call with add, addr + 1 as
>the range; looking for just the vma at a specific address.
>
>The third use of find_vma() is by developers who do not know that the
>function starts searching at the provided address upwards for the next
>vma.  This results in a bug that is often overlooked for a long time.
>
>Adding the new vma_lookup() function will allow for cleaner code by
>removing the find_vma() calls which check limits, making
>find_vma_intersection() calls of a single address to be shorter, and
>potentially reduce the incorrect uses of find_vma().
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>---
> include/linux/mm.h | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 25b9041f9925..5f2a15e702ff 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -2689,6 +2689,24 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
>	return vma;
> }

While at it can we clean up find_vma_intersection? I'm not particularly
user/fan of checkpatch.pl, but this one is kind of ridiculous.

Thanks,
Davidlohr

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..16eddedf783f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2678,9 +2678,14 @@ extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long add
  extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
					     struct vm_area_struct **pprev);

-/* Look up the first VMA which intersects the interval start_addr..end_addr-1,
-   NULL if none.  Assume start_addr < end_addr. */
-static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
+/*
+ * Look up the first VMA which intersects the interval start_addr..end_addr-1,
+ * NULL if none.  Assume start_addr < end_addr.
+ */
+static inline
+struct vm_area_struct *find_vma_intersection(struct mm_struct * mm,
+                                            unsigned long start_addr,
+                                            unsigned long end_addr)
  {
	struct vm_area_struct * vma = find_vma(mm,start_addr);
