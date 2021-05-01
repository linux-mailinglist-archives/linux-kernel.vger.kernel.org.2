Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD73705B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 07:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhEAFOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 01:14:20 -0400
Received: from server.lespinasse.org ([63.205.204.226]:38817 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEAFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 01:14:19 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619846010; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=y5NDAMNkqEQN+DhaIS4czZiHJbkGLVl9eO9bf3NbPes=;
 b=d26776rJ7CxLjaYFLa39ODat8Cb2o45ViKsb9LZHM/qVaC2LiL4y7mGErDo4zpHsOoDLo
 T7RjmfCbqlcUbvZAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619846010; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=y5NDAMNkqEQN+DhaIS4czZiHJbkGLVl9eO9bf3NbPes=;
 b=J2N9FzB4wMBqJXqsTSk+YJm0WKiz+StpiFOA3Q59lYNrNNWBwjP15sLL/PZUp6uhNROY9
 PKBXHL5hoPJ3S/OyIKAQZM52pbZAA+J1ydTwLQl3mDynHDwk9zmYb+zvP2AknPL9/mGs7ie
 JAjTbp0REjFl7rctEh9C/AyZyDT2xwKC/jOqnX09ijjIs1V4daIauq07JgA7NOxDlXzgm8W
 7DCQixl2vcjP8VDy3R+2MjRHPce/RDMl7AdfIc1UyUHVGlOXEobA4z2D+WebNfgEmcf8qSQ
 9uIrdSnjxqIIYwOOyLTs27+IsxVYroeoF1WclQ45epZURRNNr3m3xV6rIWCg==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 4E71D160324; Fri, 30 Apr 2021 22:13:30 -0700 (PDT)
Date:   Fri, 30 Apr 2021 22:13:30 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma
 is known
Message-ID: <20210501051330.GC5188@lespinasse.org>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:36:08PM +0000, Liam Howlett wrote:
> When a vma is known, avoid calling mm_populate to search for the vma to
> populate.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/gup.c      | 20 ++++++++++++++++++++
>  mm/internal.h |  4 ++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3a17b189064..48fe98ab0729 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1468,6 +1468,26 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>  				NULL, NULL, locked);
>  }
>  
> +/*
> + * mm_populate_vma() - Populate a single range in a single vma.
> + * @vma: The vma to populate.
> + * @start: The start address to populate
> + * @end: The end address to stop populating
> + *
> + * Note: Ignores errors.
> + */
> +void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
> +		unsigned long end)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int locked = 1;
> +
> +	mmap_read_lock(mm);
> +	populate_vma_page_range(vma, start, end, &locked);
> +	if (locked)
> +		mmap_read_unlock(mm);
> +}
> +

This seems like a nonsensical API at first glance - VMAs that are found
in the vma tree might be modified, merged, split, or freed at any time
if the mmap lock is not held, so the API can not be safely used. I think
this applies to maple tree vmas just as much as it did for rbtree vmas ?

--
Michel "walken" Lespinasse
