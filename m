Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11803676AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhDVBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbhDVBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619054064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLVtPj/45zM2G9C/26CT0fpGSfwrADy0f7rNvTfjv+0=;
        b=P7ojV/Ph+ec8Gz3agpBWjsEg4VekwFeyRE/5Yq4HEelfRiX6YvyH1KxN5Elh/FnWO2PgnC
        cDPvf+gUkigfLiiZWEktoDtndMlK0kUmSq4u9u4oEaqhB3oYg5mXdrR3fhi89CV4/ezy9V
        HMtUxvETdVbI8VQSIIiwrgwT3XovVNg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Kt7sfD9XNhGZ-h5LhdYUqQ-1; Wed, 21 Apr 2021 21:14:22 -0400
X-MC-Unique: Kt7sfD9XNhGZ-h5LhdYUqQ-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8cb02902e028cc62baso10877156qkh.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLVtPj/45zM2G9C/26CT0fpGSfwrADy0f7rNvTfjv+0=;
        b=KhntjgsaHYs3jOyw0iFnUpNNZaRQB7cCjpc/05mO606Lw0RBPIW+0vZaOIUW4xQyg8
         0ejxqZdBasxiBOg1WO8JgOYoxjCZflfKb8FjiET7mWj0yAqPKKYLp1GnRm1f44CDTEVb
         jdmP/qJaYcw27T3dfPg3SloDPX/KRbyhSbUali453PSx/8vQb/0h2se8ah3MaLljZywz
         s4NuAF7tHHh4xLLMxTjiFpzJZBG0Q2fLOp7kM0re4VlxcuLQYWWewiZvlSq/It2LxswZ
         4Wbg9QSHXDMyJlBuigR7Lez6nkk7iGnySeE3ze+9cXZmGVydBp3R7l04RhtgAra1cUbq
         AtTQ==
X-Gm-Message-State: AOAM532wLq0fVed5jePd0JU1dfS/CtFmho/IDRPwNcHAo63pNPLqeFtS
        aS/1MZriEBHsZZNyes8G7zgFweNZx9fFQBnUVwj3ZpSmhVaa0PKxfiZEDd37id0d+gmRN76iZWM
        04MQ9PGBtpIF7qCVqHBk9bZwl
X-Received: by 2002:a05:622a:54a:: with SMTP id m10mr663940qtx.298.1619054061623;
        Wed, 21 Apr 2021 18:14:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCK758gphDbR24tZioQqHw55MiJJBQ7WK82zYZIkEtlaRN0cz+laOGqlqHggbfKBHykdpekw==
X-Received: by 2002:a05:622a:54a:: with SMTP id m10mr663919qtx.298.1619054061263;
        Wed, 21 Apr 2021 18:14:21 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id d201sm1092271qkc.98.2021.04.21.18.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 18:14:20 -0700 (PDT)
Date:   Wed, 21 Apr 2021 21:14:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/23] hugetlb/userfaultfd: Take care of
 UFFDIO_COPY_MODE_WP
Message-ID: <20210422011419.GB6404@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-17-peterx@redhat.com>
 <3cde4e9c-6887-6ded-2f34-2d031569badf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cde4e9c-6887-6ded-2f34-2d031569badf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:06:39PM -0700, Mike Kravetz wrote:
> On 3/22/21 5:49 PM, Peter Xu wrote:
> > Firstly, pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout
> > the stack.  Then, apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with
> > UFFDIO_COPY.  Introduce huge_pte_mkuffd_wp() for it.
> > 
> > Note that similar to how we've handled shmem, we'd better keep setting the
> > dirty bit even if UFFDIO_COPY_MODE_WP is provided, so that the core mm will
> > know this page contains valid data and never drop it.
> 
> There is nothing wrong with setting the dirty bit in this manner to be
> consistent.  But, since hugetlb pages are only managed by hugetlbfs, the
> core mm will not drop them.

Right, for this paragraph, how about I rephrase it as below?

  Hugetlb pages are only managed by hugetlbfs, so we're safe even without
  setting dirty bit in the huge pte if the page is installed as read-only.
  However we'd better still keep the dirty bit set for a read-only UFFDIO_COPY
  pte (when UFFDIO_COPY_MODE_WP bit is set), not only to match what we do with
  shmem, but also because the page does contain dirty data that the kernel just
  copied from the userspace.

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/asm-generic/hugetlb.h |  5 +++++
> >  include/linux/hugetlb.h       |  6 ++++--
> >  mm/hugetlb.c                  | 22 +++++++++++++++++-----
> >  mm/userfaultfd.c              | 12 ++++++++----
> >  4 files changed, 34 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> > index 8e1e6244a89d..548212eccbd6 100644
> > --- a/include/asm-generic/hugetlb.h
> > +++ b/include/asm-generic/hugetlb.h
> > @@ -27,6 +27,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
> >  	return pte_mkdirty(pte);
> >  }
> >  
> > +static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
> > +{
> > +	return pte_mkuffd_wp(pte);
> > +}
> > +
> 
> Just want to verify that userfaultfd wp support is only enabled for
> x86_64 now?  I only ask because there are arch specific hugetlb pte
> manipulation routines for some architectures. 

Yes it's x86_64 only, as we have:

	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD

Here the helper defines the huge pte uffd-wp bit to be the same as the pte
level bit, across all archs.  However should be fine since for any arch that
does not support uffd-wp, it'll be no-op:

static __always_inline pte_t pte_mkuffd_wp(pte_t pte)
{
	return pte;
}

Meanwhile it shouldn't be called anywhere as well.

Here I can also define __HAVE_ARCH_HUGE_PTE_MKUFFD_WP, however I didn't do so
as I thought above should be enough.  Then we can define it when really
necessary.

> 
> >  static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
> >  {
> >  	return pte_modify(pte, newprot);
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index a7f7d5f328dc..ef8d2b8427b1 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -141,7 +141,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
> >  				unsigned long dst_addr,
> >  				unsigned long src_addr,
> >  				enum mcopy_atomic_mode mode,
> > -				struct page **pagep);
> > +				struct page **pagep,
> > +				bool wp_copy);
> >  #endif /* CONFIG_USERFAULTFD */
> >  bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
> >  						struct vm_area_struct *vma,
> > @@ -321,7 +322,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  						unsigned long dst_addr,
> >  						unsigned long src_addr,
> >  						enum mcopy_atomic_mode mode,
> > -						struct page **pagep)
> > +						struct page **pagep,
> > +						bool wp_copy)
> >  {
> >  	BUG();
> >  	return 0;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index def2c7ddf3ae..f0e55b341ebd 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4725,7 +4725,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  			    unsigned long dst_addr,
> >  			    unsigned long src_addr,
> >  			    enum mcopy_atomic_mode mode,
> > -			    struct page **pagep)
> > +			    struct page **pagep,
> > +			    bool wp_copy)
> >  {
> >  	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> >  	struct address_space *mapping;
> > @@ -4822,17 +4823,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
> >  	}
> >  
> > -	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
> > -	if (is_continue && !vm_shared)
> > +	/*
> > +	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
> > +	 * with wp flag set, don't set pte write bit.
> > +	 */
> > +	if (wp_copy || (is_continue && !vm_shared))
> >  		writable = 0;
> >  	else
> >  		writable = dst_vma->vm_flags & VM_WRITE;
> >  
> >  	_dst_pte = make_huge_pte(dst_vma, page, writable);
> > -	if (writable)
> > -		_dst_pte = huge_pte_mkdirty(_dst_pte);
> > +	/*
> > +	 * Always mark UFFDIO_COPY page dirty; note that this may not be
> > +	 * extremely important for hugetlbfs for now since swapping is not
> > +	 * supported, but we should still be clear in that this page cannot be
> > +	 * thrown away at will, even if write bit not set.
> 
> As mentioned earlier there should not be any issue with hugetlb pages
> being thrown away without dirty set.  Perhaps, the comment should
> reflect that this is mostly for consistency.

Yes, functional-wise it seems not necessary, however I also think it's a bit
more than being consistency with what we do with shmem (as also rephrased in
above commit message): UFFDIO_COPY page should be marked as dirty by the
definition of "dirty bit", imho, since the data is indeed dirty (kernel copied
that data from userspace)?

> 
> Note to self: this may help when I get back to hugetlb soft dirty
> support.
> 
> Other than that, patch looks good.

Thanks!

-- 
Peter Xu

