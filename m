Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A53A493B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFKTIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhFKTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:07:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819ADC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:05:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u14so14197295qvq.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/zrF75/uxcA4NNdCHOkjV1ZhBblSrjqxA/PxWAd4YWw=;
        b=PKQJ6RNgx94fxXwnRsnb+cYtac6RdFgaNnfaNj2S4a0zeNoZUPxjIbPvETF6fDJ2SY
         KZL/2ZhY/02lDIJQgkc3QaLJ6+YpVtxAVj7Wy1cOvMGdHufFwRLvHMNl5ty0g9N9gitT
         eVPdYFfedV77brOmesbsftgajEnT/93GgFzLK1Pyf/vVVQsJLxTqo9TBQ7aPNLStNwje
         HSAKkWB5BtAxT5a9vNTZ9zDzxT3rRyBXAcqaotsgg7/awpB0MhceV7lBSf1DpIC7FrNA
         JaTaZrVTO96r46jcPZJG3L64T5Ro05oZeOFE2+vL3g5kFS2+UkgogGFhDSqtDBf2Vik8
         Ap0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/zrF75/uxcA4NNdCHOkjV1ZhBblSrjqxA/PxWAd4YWw=;
        b=XeorK0Yh69U/NSAU4f/ZhS0mquqcvYwq/VGWcuZjfX+MXHHt5ETFmnArAllSE6wohc
         Q2i/ventzJfPgj3T+OCO3sxJqZCKupWp+p0K+Xm/SevTgjdxoBuydhaG1IYJnQ4hrUpS
         cEQFmxpGAez2TP63brvMh2bIVyuUdhIaapYiKYGmlrJbIcHhLOmV1i73vfJ3eLqR9t/j
         NzBC7AiNfXAaqPV2rovvSB3RoYIlxsVsy+ShWF3pgG+GUFz7XKbpemPdeUEN4lwDK5FK
         glHbUzpPh1U0VhOWa+7v3aFyeg2ccpDmRlRgZyMtuf/9wwZUXdZ5wNSlckuiTLocF+l0
         qZHg==
X-Gm-Message-State: AOAM533ghTsOzlSU/h6RvndmTDQQOwgew3o8LloulUXzrvnfvgs1wJcl
        f3q3gmgDHzyyZZupLDn5KZWKxQ==
X-Google-Smtp-Source: ABdhPJyDlAgB04Vzuybk3Okbqd7IrunFh8Az+kMbi27KbewxaJtpXVE7tB+c/1UiJtS7sYpYeARlgQ==
X-Received: by 2002:ad4:4e62:: with SMTP id ec2mr6399901qvb.19.1623438345304;
        Fri, 11 Jun 2021 12:05:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a128sm5086313qkc.15.2021.06.11.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:05:44 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:05:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use
 pmd_read_atomic()
In-Reply-To: <20210611153613.GR1096940@ziepe.ca>
Message-ID: <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <594c1f0-d396-5346-1f36-606872cddb18@google.com> <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name> <20210610121542.GQ1096940@ziepe.ca> <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 11:37:14PM -0700, Hugh Dickins wrote:
> > On Thu, 10 Jun 2021, Jason Gunthorpe wrote:
> > > On Thu, Jun 10, 2021 at 12:06:17PM +0300, Kirill A. Shutemov wrote:
> > > > On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> > > > > page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> > > > > instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> > > > > have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> > > > > 
> > > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > > Cc: <stable@vger.kernel.org>
> > > > >  mm/page_vma_mapped.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > > index 7c0504641fb8..973c3c4e72cc 100644
> > > > > +++ b/mm/page_vma_mapped.c
> > > > > @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > > >  	pud = pud_offset(p4d, pvmw->address);
> > > > >  	if (!pud_present(*pud))
> > > > >  		return false;
> > > > > +
> > > > >  	pvmw->pmd = pmd_offset(pud, pvmw->address);
> > > > >  	/*
> > > > >  	 * Make sure the pmd value isn't cached in a register by the
> > > > >  	 * compiler and used as a stale value after we've observed a
> > > > >  	 * subsequent update.
> > > > >  	 */
> > > > > -	pmde = READ_ONCE(*pvmw->pmd);
> > > > > +	pmde = pmd_read_atomic(pvmw->pmd);
> > > > > +	barrier();
> > > > > +
> > > > 
> > > > Hm. It makes me wounder if barrier() has to be part of pmd_read_atomic().
> > > > mm/hmm.c uses the same pattern as you are and I tend to think that the
> > > > rest of pmd_read_atomic() users may be broken.
> > > > 
> > > > Am I wrong?
> > > 
> > > I agree with you, something called _atomic should not require the
> > > caller to provide barriers.
> > > 
> > > I think the issue is simply that the two implementations of
> > > pmd_read_atomic() should use READ_ONCE() internally, no?
> > 
> > I've had great difficulty coming up with answers for you.
> > 
> > This patch was based on two notions I've had lodged in my mind
> > for several years:
> > 
> > 1) that pmd_read_atomic() is the creme-de-la-creme for reading a pmd_t
> > atomically (even if the pmd_t spans multiple words); but reading again
> > after all this time the comment above it, it seems to be more specialized
> > than I'd thought (biggest selling point being for when you want to check
> > pmd_none(), which we don't).  And has no READ_ONCE() or barrier() inside,
> > so really needs that barrier() to be as safe as the previous READ_ONCE().
> 
> IMHO it is a simple bug that the 64 bit version of this is not marked
> with READ_ONCE() internally. It is reading data without a lock, AFAIK
> our modern understanding of the memory model is that requires
> READ_ONCE().
> 
> diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> index e896ebef8c24cb..0bf1fdec928e71 100644
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -75,7 +75,7 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
>  static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
>  {
>  	pmdval_t ret;
> -	u32 *tmp = (u32 *)pmdp;
> +	u32 *tmp = READ_ONCE((u32 *)pmdp);
>  
>  	ret = (pmdval_t) (*tmp);
>  	if (ret) {
> @@ -84,7 +84,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
>  		 * or we can end up with a partial pmd.
>  		 */
>  		smp_rmb();
> -		ret |= ((pmdval_t)*(tmp + 1)) << 32;
> +		ret |= READ_ONCE((pmdval_t)*(tmp + 1)) << 32;
>  	}

Maybe that.  Or maybe now (since Will's changes) it can just do
one READ_ONCE() of the whole, then adjust its local copy.

>  
>  	return (pmd_t) { ret };
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 46b13780c2c8c9..c8c7a3307d2773 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1228,7 +1228,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
>  	 * only going to work, if the pmdval_t isn't larger than
>  	 * an unsigned long.
>  	 */
> -	return *pmdp;
> +	return READ_ONCE(*pmdp);
>  }
>  #endif

And it should now be possible to delete the #ifdef THP barrier() in
function_with_long_name_I_didn't_look_up() which calls pmd_read_atomic().

>  
> 
> > 2) the barrier() in mm_find_pmd(), that replaced an earlier READ_ONCE(),
> > because READ_ONCE() did not work (did not give the necessary guarantee? or
> > did not build?) on architectures with multiple word pmd_ts e.g. i386 PAE.
> 
> This is really interesting, the git history e37c69827063 ("mm: replace
> ACCESS_ONCE with READ_ONCE or barriers") says the READ_ONCE was
> dropped here "because it doesn't work on non-scalar types" due to a
> (now 8 year old) gcc bug.
> 
> According to the gcc bug READ_ONCE() on anything that is a scalar
> sized struct triggers GCC to ignore the READ_ONCEyness. To work around
> this bug then READ_ONCE can never be used on any of the struct
> protected page table elements. While I am not 100% sure, it looks like
> this is a pre gcc 4.9 bug, and since gcc 4.9 is now the minimum
> required compiler this is all just cruft. Use READ_ONCE() here too...

Oh, thanks particularly for looking into the gcc end of it:
I never knew that part of the story.

> 
> > But I've now come across some changes that Will Deacon made last year:
> > the include/asm-generic/rwonce.h READ_ONCE() now appears to allow for
> > native word type *or* type sizeof(long long) (e.g. i386 PAE) - given
> > "a strong prevailing wind" anyway :)  And 8e958839e4b9 ("sparc32: mm:
> > Restructure sparc32 MMU page-table layout") put an end to sparc32's
> > typedef struct { unsigned long pmdv[16]; } pmd_t.
> 
> Indeed, that is good news
> 
> > As to your questions about pmd_read_atomic() usage elsewhere:
> > please don't force me to think so hard!  (And you've set me half-
> > wondering, whether there are sneaky THP transitions, perhaps of the
> > "unstable" kind, that page_vma_mapped_walk() should be paying more
> > attention to: but for sanity's sake I won't go there, not now.)
> 
> If I recall, (and I didn't recheck this right now) the only thing
> pmd_read_atomic() provides is the special property that if the pmd's
> flags are observed to point to a pte table then pmd_read_atomic() will
> reliably return the pte table pointer.

I expect your right, I haven't rechecked.  But it does also provide that
special guarantee on matching pmd_none() when half matches pmd_none():
which one or more callers want, but irrelevant where I added it.

> 
> Otherwise it returns the flags and a garbage pointer because under the
> THP protocol a PMD pointing at a page can be converted to a PTE table
> if you hold the mmap sem in read mode. Upgrading a PTE table to a PMD
> page requires mmap sem in write mode so once a PTE table is observed
> 'locklessly' the value is stable.. Or at least so says the documentation
> 
> pmd_read_atomic() is badly named, tricky to use, and missing the
> READ_ONCE() because it is so old..

I think yes to each of those three points.

> 
> As far as is page_vma_mapped_walk correct.. Everything except
> is_pmd_migration_entry() is fine to my eye, and I simply don't know
> the rules aroudn migration entries to know right/wrong.

So long as the swap "type" is entirely in the same word as the pte
flags would be, I think is_pmd_migration_entry() should be fine.
There it's just looking for a hint, is it worth taking pmd_lock()
to obtain a reliable pmde.

> 
> I suspect it probably is required to manipulate a migration entry
> while holding the mmap_sem in write mode??

I don't think in terms of mmap_sem/mmap_lock here: this is on the
rmap lookup path, and typically mmap_lock is not held (whereas I
was surprised to find the comment above pmd_read_atomic() saying a
lot about it - another reason it's inappropriate in pvmw I guess).

The important lock here is pmd_lock() a.k.a. pmd_trans_huge_lock():
get it when it's necessary, but (the tricky part) try to avoid the
overhead and contention in getting it when not necessary.  Before
THP it was easy, but various THP transitions make it hard.

> 
> There is some list of changes to the page table that require holding
> the mmap sem in write mode that I've never seen documented for..

That is a subtler subject than I dare get into at the moment.
But if you're just doing lookups, pmd_lock() is enough.

I'll direct a further mail in this thread to Andrew now,
asking him to drop this patch, when convenient.

Hugh
