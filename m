Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0653314458
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBHXzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhBHXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612828456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hEEOuDz0qaViW1EeHUlbDM3oSPv21a1byvV4vjjMF0=;
        b=e4ZEPrTgnLdU5ToWBgtcfdQRoV73CwW3l2/rWAzG9LwKNZvuxqa8/ejXprUT6aTUX1unDe
        EdkkCawB9B8Ty9Dh4tkH+les94DWa2qJh8E5kO2QeLIUiY19pZoXsPMw9s861mfqLJ4T17
        oh/HYsz56zg/0j2cV1MB0YEqyOnoPzE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-YbfJYME6PmmmDgCfi-86Qg-1; Mon, 08 Feb 2021 18:54:15 -0500
X-MC-Unique: YbfJYME6PmmmDgCfi-86Qg-1
Received: by mail-qt1-f199.google.com with SMTP id v65so10885746qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hEEOuDz0qaViW1EeHUlbDM3oSPv21a1byvV4vjjMF0=;
        b=QhgPbDnd+x61Mcq21hPW/zMhwpgPDdRP9yBeosgQfkvItQATtZuxQsNMqeSudl3lmm
         H2n4JPG4k/RMcLc1TIeNOiOV8vOtoZKdUGdmug6866XNiJM5M5TLLHp6LNMf9tiwc1re
         t/iYXWCDiPhaeSyhoYBw31AFHLtyGg+v/Lns0DLd+Tg1nR//5Mc1GhDikTCcJ0CqqZJ4
         mlJPBhnTU2kMf4OukAwmWGHSup8ivavElKg/Y07u8jb7g78jZIHlvPuSg5pfbIwY1nAQ
         yyD4EE0aKO3AZF9Ye0aQ+p4mRt3R9CDdpCiLBZz/L0HWSsYIHsnwWVx756O3AqcqQLt6
         eSpA==
X-Gm-Message-State: AOAM532mBnV1ILsSQFJmAuB4cHXtB+eMiKgpQK0AYgDMdEb59fP9nG6w
        eqbh4gCQWuWoXdfS+gAxFr8FUYNMIiVbnvIJ4igJ7ZF4eP4irdUl7RgQR0t8+ILW4RvtHYJzipo
        el/Pfk5nCjN0NU+awxDc/CRZK
X-Received: by 2002:a05:622a:347:: with SMTP id r7mr16405659qtw.279.1612828454459;
        Mon, 08 Feb 2021 15:54:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5G5F7gFkOpiOmlbgcsIGD0kBV6CtIU06iqhH3Ng182T8B2jcc3fwAHv3zd0PCraTxLi/PxQ==
X-Received: by 2002:a05:622a:347:: with SMTP id r7mr16405638qtw.279.1612828454188;
        Mon, 08 Feb 2021 15:54:14 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 11sm18825424qkm.25.2021.02.08.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 15:54:13 -0800 (PST)
Date:   Mon, 8 Feb 2021 18:54:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 08/10] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210208235411.GC71523@xz-x1>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-9-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204183433.1431202-9-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:34:31AM -0800, Axel Rasmussen wrote:
> +enum mcopy_atomic_mode {
> +	/* A normal copy_from_user into the destination range. */
> +	MCOPY_ATOMIC_NORMAL,
> +	/* Don't copy; map the destination range to the zero page. */
> +	MCOPY_ATOMIC_ZEROPAGE,
> +	/* Just setup the dst_vma, without modifying the underlying page(s). */

"setup the dst_vma" sounds odd.  How about "install pte with the existing page
in the page cache"?

> +	MCOPY_ATOMIC_CONTINUE,
> +};

[...]

> @@ -4749,22 +4754,27 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>  	}
>  
> -	_dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);
> -	if (dst_vma->vm_flags & VM_WRITE)
> +	dst_pte_flags = dst_vma->vm_flags & VM_WRITE;
> +	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
> +	if (mode == MCOPY_ATOMIC_CONTINUE && !vm_shared)
> +		dst_pte_flags &= ~VM_WRITE;

I agree it should work but it's odd to explicitly remove a VM_WRITE bit, since
imho what we want to do is not changing vma or vma flags but deciding whether
to keep the write bit in the ptes.  How about as simple as:

        bool writable;

        if (mode == MCOPY_ATOMIC_CONTINUE && !vm_shared)
            writable = false;
        else
            writable = dst_vma->vm_flags & VM_WRITE;

        _dst_pte = make_huge_pte(dst_vma, page, writable);
        if (writable)
        	_dst_pte = huge_pte_mkdirty(_dst_pte);

?

> +	_dst_pte = make_huge_pte(dst_vma, page, dst_pte_flags);
> +	if (dst_pte_flags & VM_WRITE)
>  		_dst_pte = huge_pte_mkdirty(_dst_pte);
>  	_dst_pte = pte_mkyoung(_dst_pte);
>  
>  	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>  
>  	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
> -					dst_vma->vm_flags & VM_WRITE);
> +					 dst_pte_flags);
>  	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
>  
>  	/* No need to invalidate - it was non-present before */
>  	update_mmu_cache(dst_vma, dst_addr, dst_pte);
>  
>  	spin_unlock(ptl);
> -	set_page_huge_active(page);
> +	if (mode != MCOPY_ATOMIC_CONTINUE)
> +		set_page_huge_active(page);

This has been changed to SetHPageMigratable(page) in akpm-next by Mike's new
series.  So maybe it's time to rebase your series to that starting from the
next post.

>  	if (vm_shared)
>  		unlock_page(page);

After removing the shared restriction, I think we need:

        if (vm_shared || (mode == MCOPY_ATOMIC_CONTINUE))
        	unlock_page(page);

Since we seem to check (mode == MCOPY_ATOMIC_CONTINUE) a lot, maybe we can
introduce a temp var for that too.

>  	ret = 0;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index b2ce61c1b50d..7bf83ffa456b 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -207,7 +207,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      bool zeropage)
> +					      enum mcopy_atomic_mode mode)
>  {
>  	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
> @@ -227,7 +227,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	 * by THP.  Since we can not reliably insert a zero page, this
>  	 * feature is not supported.
>  	 */
> -	if (zeropage) {
> +	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
>  		mmap_read_unlock(dst_mm);
>  		return -EINVAL;
>  	}
> @@ -273,8 +273,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	}
>  
>  	while (src_addr < src_start + len) {
> -		pte_t dst_pteval;
> -
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
> @@ -297,16 +295,17 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  			goto out_unlock;
>  		}
>  
> -		err = -EEXIST;
> -		dst_pteval = huge_ptep_get(dst_pte);
> -		if (!huge_pte_none(dst_pteval)) {
> -			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -			i_mmap_unlock_read(mapping);
> -			goto out_unlock;
> +		if (mode != MCOPY_ATOMIC_CONTINUE) {
> +			if (!huge_pte_none(huge_ptep_get(dst_pte))) {

Maybe merge the two "if"s?

> +				err = -EEXIST;
> +				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +				i_mmap_unlock_read(mapping);
> +				goto out_unlock;
> +			}
>  		}
>  
>  		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> -						dst_addr, src_addr, &page);
> +					       dst_addr, src_addr, mode, &page);
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		i_mmap_unlock_read(mapping);
> @@ -408,7 +407,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  				      unsigned long dst_start,
>  				      unsigned long src_start,
>  				      unsigned long len,
> -				      bool zeropage);
> +				      enum mcopy_atomic_mode mode);
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> @@ -417,10 +416,14 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  						unsigned long dst_addr,
>  						unsigned long src_addr,
>  						struct page **page,
> -						bool zeropage,
> +						enum mcopy_atomic_mode mode,
>  						bool wp_copy)
>  {
>  	ssize_t err;
> +	bool zeropage = (mode == MCOPY_ATOMIC_ZEROPAGE);
> +
> +	if (mode == MCOPY_ATOMIC_CONTINUE)
> +		return -EINVAL;

So you still passed in the mode into mfill_atomic_pte() just to make sure
CONTINUE is not called there.  It's okay, but again I think it's not extremely
necessary: we should make sure to fail early at the entry of uffdio_continue()
by checking against the vma type to be hugetlb, rather than reaching here.

Thanks,

-- 
Peter Xu

