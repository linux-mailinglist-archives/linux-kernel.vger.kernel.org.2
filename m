Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA238BD02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhEUDtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbhEUDtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4717DABB1;
        Fri, 21 May 2021 03:47:37 +0000 (UTC)
Date:   Thu, 20 May 2021 20:47:19 -0700
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
Subject: Re: [PATCH 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Message-ID: <20210521034719.fkaotqikwisie4kq@offworld>
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
 <20210510165839.2692974-21-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210510165839.2692974-21-Liam.Howlett@Oracle.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Liam Howlett wrote:

>Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
>will return NULL if the address is not within any VMA, the start address
>no longer needs to be validated.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>---
> mm/mremap.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 47c255b60150..04143755cd1e 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -634,10 +634,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> 	unsigned long *p)
> {
> 	struct mm_struct *mm = current->mm;
>-	struct vm_area_struct *vma = find_vma(mm, addr);
>+	struct vm_area_struct *vma = vma_lookup(mm, addr);
> 	unsigned long pgoff;
>

Nit, but could the vma_lookup() call be separate from the declaration
of vma?

	vma = find_vma();
>-	if (!vma || vma->vm_start > addr)
>+	if (!vma)
> 		return ERR_PTR(-EFAULT);

Thanks,
Davidlohr
