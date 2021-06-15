Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5C3A7B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFOJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231214AbhFOJst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF9E46143D;
        Tue, 15 Jun 2021 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623750405;
        bh=Q4s9x4X/axe/W24+TWRuk/HxGxn+2TZijoQqtBdwBVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F51nHnqNF5lzBBA9V3adfbhtW0cgxcadpe1e/aIV0ONTdKx/yImRdFUtaAiN9l4B0
         AYtxDe4VSjXZDTUN6cxeMVpVoE18nqH9FJn0Yd3ufJ9JrKrn5ZhCu80rfJmZQUl/6C
         yCCqMMze3Zv6pSMFQ1rW5AjKc79NpvsSTp5CiA9eQX4RVO6VeiX8/sfOP9RpNF5S+f
         Ynou70nSy+uK8Vj/6QbbTF0jVGfWB2RiPLVhwB5HsdHw+RJou/JFycIVgQQN4HbaXZ
         aabHr9m1ja+uN0EjRrhfgCX1xnvjN+BaDVSv5i3daMMP3JDDmvUMu8Pm8q7DiF42xw
         4sNTaai8ibW/A==
Date:   Tue, 15 Jun 2021 10:46:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210615094639.GC19878@willie-the-truck>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
 <20210610121542.GQ1096940@ziepe.ca>
 <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
 <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
 <20210611194249.GS1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611194249.GS1096940@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:42:49PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 11, 2021 at 12:05:42PM -0700, Hugh Dickins wrote:
> > > diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> > > index e896ebef8c24cb..0bf1fdec928e71 100644
> > > +++ b/arch/x86/include/asm/pgtable-3level.h
> > > @@ -75,7 +75,7 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
> > >  static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> > >  {
> > >  	pmdval_t ret;
> > > -	u32 *tmp = (u32 *)pmdp;
> > > +	u32 *tmp = READ_ONCE((u32 *)pmdp);
> > >  
> > >  	ret = (pmdval_t) (*tmp);
> > >  	if (ret) {
> > > @@ -84,7 +84,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> > >  		 * or we can end up with a partial pmd.
> > >  		 */
> > >  		smp_rmb();
> > > -		ret |= ((pmdval_t)*(tmp + 1)) << 32;
> > > +		ret |= READ_ONCE((pmdval_t)*(tmp + 1)) << 32;
> > >  	}
> > 
> > Maybe that.  Or maybe now (since Will's changes) it can just do
> > one READ_ONCE() of the whole, then adjust its local copy.
> 
> I think the smb_rmb() is critical here to ensure a PTE table pointer
> is coherent, READ_ONCE is not a substitute, unless I am miss
> understanding what Will's changes are???

Yes, I agree that the barrier is needed here for x86 PAE. I would really
have liked to enforce native-sized access in READ_ONCE(), but unfortunately
there is plenty of code out there which is resilient to a 64-bit access
being split into two separate 32-bit accesses and so I wasn't able to go
that far.

That being said, pmd_read_atomic() probably _should_ be using READ_ONCE()
because using it inconsistently can give rise to broken codegen, e.g. if
you do:

	pmdval_t x, y, z;

	x = *pmdp;			// Invalid
	y = READ_ONCE(*pmdp);		// Valid
	if (pmd_valid(y))
		z = *pmdp;		// Invalid again!

Then the compiler can allocate the same register for x and z, but will
issue an additional load for y. If a concurrent update takes place to the
pmd which transitions from Invalid -> Valid, then it will look as though
things went back in time, because z will be stale. We actually hit this
on arm64 in practice [1].

Will

[1] https://lore.kernel.org/lkml/20171003114244.430374928@linuxfoundation.org/
