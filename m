Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A939A3A458C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFKPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFKPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:38:15 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA584C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:36:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id if15so5902919qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYz+byHAg1NfkBBmWuvvkWkOfDn/CAEoGh0i1+r52sY=;
        b=RxQeiRBmOklcMO2BUA5T8SEz1vqkrVcfDtBFUbfzE75RNRMdBFypif8bHqukYEjMfM
         atllDOu9QPU+90QvDW367SAsk0Kld7MXlpcOKvVLxZoIK+1yIPYM8J0r0eif7BF55hD1
         GJ7qJEO4QwaR/uVFv0/BEVNxGFmWA0mAXbWkTiYJqv8NxOFygOUSIQ5EQY8tYdWLHiF8
         osK8Yak+L3HDjJ4AD4w6NoVjgRFNBLSfJL5NH5nU4kmgCzapEzRulY3wvLlZbdHSGdHi
         ZfTPlXcgxHFG4xlB6yHWv7AgHJcIqRMgvDPENFCfZJg1apX8nLQQoZCWpZ5F1v6JUAgD
         NiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYz+byHAg1NfkBBmWuvvkWkOfDn/CAEoGh0i1+r52sY=;
        b=ArZxoPGulNQhN+ARz2krbOzwNDot/Gv9i7ZuA7d8QhQEJxVyuJWSfwVxPkUPWtvXar
         Dhu9Nqbfff4g7ef8479evdLvfeEgsRYGpOBq/tx2QKh9gBlalLxMmUNG+rpKFEtA9puE
         TfDe6Xq29hJhzkeevVlfiBI4nZgTyfD++2nP7JUykWO9UQZmMJgCsVod8Qt9yGsU5c79
         OIlYfi99rM2AB4B5OfwVg8P5FRCSx1n2Hr2EOsLW3tqPO/BXeHYzI360MDVrXYLGao6s
         d6oqO1Lg1lWjmFmwapOJBCTyRIokehDHu9mZ+L0kWLTor8AGvBdLFLF1P937Qjkru4fx
         D0Eg==
X-Gm-Message-State: AOAM531s8WbtSeuW0a3i0upiXdEjJB9kbD2/eJeRDAzuM5as4hhdXvbD
        jx3h9Mc81EMge5iaHKctQSIlQA==
X-Google-Smtp-Source: ABdhPJye4JbJa1YdHgmmyau+DxkNMr+dwnJJWd4sFy797NKlsOyH3lH1diBEwixHn4LWtep2TtDa8w==
X-Received: by 2002:a05:6214:20c1:: with SMTP id 1mr5343085qve.53.1623425775000;
        Fri, 11 Jun 2021 08:36:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id z136sm4718335qkb.34.2021.06.11.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 08:36:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lrjCf-005fgL-JG; Fri, 11 Jun 2021 12:36:13 -0300
Date:   Fri, 11 Jun 2021 12:36:13 -0300
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
Message-ID: <20210611153613.GR1096940@ziepe.ca>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
 <20210610121542.GQ1096940@ziepe.ca>
 <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:37:14PM -0700, Hugh Dickins wrote:
> On Thu, 10 Jun 2021, Jason Gunthorpe wrote:
> > On Thu, Jun 10, 2021 at 12:06:17PM +0300, Kirill A. Shutemov wrote:
> > > On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> > > > page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> > > > instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> > > > have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> > > > 
> > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > Cc: <stable@vger.kernel.org>
> > > >  mm/page_vma_mapped.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > index 7c0504641fb8..973c3c4e72cc 100644
> > > > +++ b/mm/page_vma_mapped.c
> > > > @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > >  	pud = pud_offset(p4d, pvmw->address);
> > > >  	if (!pud_present(*pud))
> > > >  		return false;
> > > > +
> > > >  	pvmw->pmd = pmd_offset(pud, pvmw->address);
> > > >  	/*
> > > >  	 * Make sure the pmd value isn't cached in a register by the
> > > >  	 * compiler and used as a stale value after we've observed a
> > > >  	 * subsequent update.
> > > >  	 */
> > > > -	pmde = READ_ONCE(*pvmw->pmd);
> > > > +	pmde = pmd_read_atomic(pvmw->pmd);
> > > > +	barrier();
> > > > +
> > > 
> > > Hm. It makes me wounder if barrier() has to be part of pmd_read_atomic().
> > > mm/hmm.c uses the same pattern as you are and I tend to think that the
> > > rest of pmd_read_atomic() users may be broken.
> > > 
> > > Am I wrong?
> > 
> > I agree with you, something called _atomic should not require the
> > caller to provide barriers.
> > 
> > I think the issue is simply that the two implementations of
> > pmd_read_atomic() should use READ_ONCE() internally, no?
> 
> I've had great difficulty coming up with answers for you.
> 
> This patch was based on two notions I've had lodged in my mind
> for several years:
> 
> 1) that pmd_read_atomic() is the creme-de-la-creme for reading a pmd_t
> atomically (even if the pmd_t spans multiple words); but reading again
> after all this time the comment above it, it seems to be more specialized
> than I'd thought (biggest selling point being for when you want to check
> pmd_none(), which we don't).  And has no READ_ONCE() or barrier() inside,
> so really needs that barrier() to be as safe as the previous READ_ONCE().

IMHO it is a simple bug that the 64 bit version of this is not marked
with READ_ONCE() internally. It is reading data without a lock, AFAIK
our modern understanding of the memory model is that requires
READ_ONCE().

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index e896ebef8c24cb..0bf1fdec928e71 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -75,7 +75,7 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
 	pmdval_t ret;
-	u32 *tmp = (u32 *)pmdp;
+	u32 *tmp = READ_ONCE((u32 *)pmdp);
 
 	ret = (pmdval_t) (*tmp);
 	if (ret) {
@@ -84,7 +84,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 		 * or we can end up with a partial pmd.
 		 */
 		smp_rmb();
-		ret |= ((pmdval_t)*(tmp + 1)) << 32;
+		ret |= READ_ONCE((pmdval_t)*(tmp + 1)) << 32;
 	}
 
 	return (pmd_t) { ret };
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 46b13780c2c8c9..c8c7a3307d2773 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1228,7 +1228,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 	 * only going to work, if the pmdval_t isn't larger than
 	 * an unsigned long.
 	 */
-	return *pmdp;
+	return READ_ONCE(*pmdp);
 }
 #endif
 

> 2) the barrier() in mm_find_pmd(), that replaced an earlier READ_ONCE(),
> because READ_ONCE() did not work (did not give the necessary guarantee? or
> did not build?) on architectures with multiple word pmd_ts e.g. i386 PAE.

This is really interesting, the git history e37c69827063 ("mm: replace
ACCESS_ONCE with READ_ONCE or barriers") says the READ_ONCE was
dropped here "because it doesn't work on non-scalar types" due to a
(now 8 year old) gcc bug.

According to the gcc bug READ_ONCE() on anything that is a scalar
sized struct triggers GCC to ignore the READ_ONCEyness. To work around
this bug then READ_ONCE can never be used on any of the struct
protected page table elements. While I am not 100% sure, it looks like
this is a pre gcc 4.9 bug, and since gcc 4.9 is now the minimum
required compiler this is all just cruft. Use READ_ONCE() here too...

> But I've now come across some changes that Will Deacon made last year:
> the include/asm-generic/rwonce.h READ_ONCE() now appears to allow for
> native word type *or* type sizeof(long long) (e.g. i386 PAE) - given
> "a strong prevailing wind" anyway :)  And 8e958839e4b9 ("sparc32: mm:
> Restructure sparc32 MMU page-table layout") put an end to sparc32's
> typedef struct { unsigned long pmdv[16]; } pmd_t.

Indeed, that is good news

> As to your questions about pmd_read_atomic() usage elsewhere:
> please don't force me to think so hard!  (And you've set me half-
> wondering, whether there are sneaky THP transitions, perhaps of the
> "unstable" kind, that page_vma_mapped_walk() should be paying more
> attention to: but for sanity's sake I won't go there, not now.)

If I recall, (and I didn't recheck this right now) the only thing
pmd_read_atomic() provides is the special property that if the pmd's
flags are observed to point to a pte table then pmd_read_atomic() will
reliably return the pte table pointer.

Otherwise it returns the flags and a garbage pointer because under the
THP protocol a PMD pointing at a page can be converted to a PTE table
if you hold the mmap sem in read mode. Upgrading a PTE table to a PMD
page requires mmap sem in write mode so once a PTE table is observed
'locklessly' the value is stable.. Or at least so says the documentation

pmd_read_atomic() is badly named, tricky to use, and missing the
READ_ONCE() because it is so old..

As far as is page_vma_mapped_walk correct.. Everything except
is_pmd_migration_entry() is fine to my eye, and I simply don't know
the rules aroudn migration entries to know right/wrong.

I suspect it probably is required to manipulate a migration entry
while holding the mmap_sem in write mode??

There is some list of changes to the page table that require holding
the mmap sem in write mode that I've never seen documented for..

Jason
