Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720FD3A498A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFKTpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhFKTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:45:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:42:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e18so17146856qvm.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+K2iGT2tTrXlnkQPc8dMF2iq9ISKMJ538uqmeEiM0vQ=;
        b=NUENxrM3+YCvLHbuZH+yAkyLyaqnPxxEohVuawqnjs2bkkKgboOHKSZYzGgpmU+U6K
         EtS4pWHpAGOhRD1ixuLVwqRtr1i/nugrt6Sck5i5ZSJwBd64EGUPC/HVXuPG4grLT+LZ
         3j1HSsQ2Kconpi8njRG3WzqDVbRPi7pCkUm2VM+JmYvbEPTysbE16lrs+9IpNT0mLxXv
         wpBKEzy5YaiOPAg98+GY798hibfRTEkWjy+CX7q+Ta/59PXf64YJNMsFyBgb+Rtm7wzo
         DLiZpvelWH8fx65AAu6TDMrZWFuCllOBsaqE7jhte63tzIVKUjQV4DJJbBb9DO8FZ24b
         3Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+K2iGT2tTrXlnkQPc8dMF2iq9ISKMJ538uqmeEiM0vQ=;
        b=f3dO+qkOgDnAbrhiT0qSD4XbNl30Yer8uaEaU7nqzwomqXXyJulJzBkACgmuVO+FZE
         fJWohkod5DzuwkOf9L8nbXeIrXkDoSFH/9osv9O3EYmKrziEX9xtuskKtyZpXYooZhnm
         ev2ri3bmS9ZMuF6ezTiE8oVQGCFih7HWNsnmzIOnlE1tCXlVe/Fd3WwJhuGV8U4/PvFT
         rGRSGpJv+ZX4TD+yIm4S+hgtsx9gkVBQoaQtgWM3wVn1sR+hnSwbe3qLFmSPmifdSKnv
         iY1t9xUnJFhPNPwXMzqFrW1pUgDewRJxQd3qcVhY7hXidlFJfWXZbLibXUehSyKaDvz2
         nflg==
X-Gm-Message-State: AOAM530FLheeIMadFH58tXFsUTmAcRo6Gv187N5WWHdMfv1dSWEF8snF
        xWcCxzYymVgUL1Pf2TMVTt4jGg==
X-Google-Smtp-Source: ABdhPJw7H+/rT7xPaHf3J8Gh3w/f1j8LCaTWAnnw/6UZRM5GZuro5cP9bUT20J2Ul41onsJHOEYM0w==
X-Received: by 2002:a05:6214:252a:: with SMTP id gg10mr6529444qvb.17.1623440570120;
        Fri, 11 Jun 2021 12:42:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id a134sm5127030qkg.114.2021.06.11.12.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:42:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lrn3J-005jfD-2b; Fri, 11 Jun 2021 16:42:49 -0300
Date:   Fri, 11 Jun 2021 16:42:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210611194249.GS1096940@ziepe.ca>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
 <20210610121542.GQ1096940@ziepe.ca>
 <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
 <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:05:42PM -0700, Hugh Dickins wrote:
> > diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> > index e896ebef8c24cb..0bf1fdec928e71 100644
> > +++ b/arch/x86/include/asm/pgtable-3level.h
> > @@ -75,7 +75,7 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
> >  static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> >  {
> >  	pmdval_t ret;
> > -	u32 *tmp = (u32 *)pmdp;
> > +	u32 *tmp = READ_ONCE((u32 *)pmdp);
> >  
> >  	ret = (pmdval_t) (*tmp);
> >  	if (ret) {
> > @@ -84,7 +84,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> >  		 * or we can end up with a partial pmd.
> >  		 */
> >  		smp_rmb();
> > -		ret |= ((pmdval_t)*(tmp + 1)) << 32;
> > +		ret |= READ_ONCE((pmdval_t)*(tmp + 1)) << 32;
> >  	}
> 
> Maybe that.  Or maybe now (since Will's changes) it can just do
> one READ_ONCE() of the whole, then adjust its local copy.

I think the smb_rmb() is critical here to ensure a PTE table pointer
is coherent, READ_ONCE is not a substitute, unless I am miss
understanding what Will's changes are???

> > @@ -1228,7 +1228,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> >  	 * only going to work, if the pmdval_t isn't larger than
> >  	 * an unsigned long.
> >  	 */
> > -	return *pmdp;
> > +	return READ_ONCE(*pmdp);
> >  }
> >  #endif
> 
> And it should now be possible to delete the #ifdef THP barrier() in
> function_with_long_name_I_didn't_look_up() which calls pmd_read_atomic().

Yes - I think I know what you mean :)
 
> > If I recall, (and I didn't recheck this right now) the only thing
> > pmd_read_atomic() provides is the special property that if the pmd's
> > flags are observed to point to a pte table then pmd_read_atomic() will
> > reliably return the pte table pointer.
> 
> I expect your right, I haven't rechecked.  But it does also provide that
> special guarantee on matching pmd_none() when half matches pmd_none():
> which one or more callers want, but irrelevant where I added it.

Ah, this I don't know much about.. Hum, I'd have to think about it way
too much to have an opinion if the races around pmd_none are
meaningful enough to resolve with _atomic vs READ_ONCE()

> > As far as is page_vma_mapped_walk correct.. Everything except
> > is_pmd_migration_entry() is fine to my eye, and I simply don't know
> > the rules aroudn migration entries to know right/wrong.
> 
> So long as the swap "type" is entirely in the same word as the pte
> flags would be, I think is_pmd_migration_entry() should be fine.
> There it's just looking for a hint, is it worth taking pmd_lock()
> to obtain a reliable pmde.

I wonder if anyone knows to guarantee that in the arches?

> > I suspect it probably is required to manipulate a migration entry
> > while holding the mmap_sem in write mode??
> 
> I don't think in terms of mmap_sem/mmap_lock here: this is on the
> rmap lookup path, and typically mmap_lock is not held (whereas I
> was surprised to find the comment above pmd_read_atomic() saying a
> lot about it - another reason it's inappropriate in pvmw I guess).

Ah.. Honestly I'm not familiar with all the ways to lock a VMA so that
the page tables it spans are guaranteed not to be freed.

I just saw the _offset() ladder without any page table spinlocks and
knew this was one of the lockless walkers that, somehow, relies on
another lock to ensure the page table level memory is not concurrently
freed.

In that case I take it back, I have no idea if this is correct or not
because it calls map_pte() which does pte_offset_map() based on that
READ_ONCE.

pte_offset_map() without holding the pmd_lock is only OK if you know
that the pmd can't be upgraded to a THP - and the only locking for
that I have memorized is the mmap lock :\ 

I can't tell what other lock is protecting the page tables here or if
that lock is held during the THP upgrade process.. Sorry

> > There is some list of changes to the page table that require
> > holding the mmap sem in write mode that I've never seen documented
> > for..
>
> That is a subtler subject than I dare get into at the moment.
> But if you're just doing lookups, pmd_lock() is enough.

It is enough if you take it, I don't see page_vma_mapped_walk() taking
it in the map_pte() flow :\

Jason
