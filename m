Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8534B9B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhC0V5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 17:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230423AbhC0V5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616882230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bj/1bcBSUwlXPODMgK+7TR54EtYdkqxCKK5SCH5Eb+k=;
        b=HaD9iRHXo09pLHyQLdwTFyKM40yqsusnhnpAVPFSQsQqPBTAyR583obI2/KXbAP7J59l3h
        zv6rx7JKgk94J/xEF5DtWW7zu5IkxCCZo3xeohggusTDH3tGn7KlkOE3MzI5+vZzl8qwEH
        aYjMkvEYYVCMxr7AD8sby498MEwTjUs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-IyNwY2c9OhKMpllgWqIncg-1; Sat, 27 Mar 2021 17:57:08 -0400
X-MC-Unique: IyNwY2c9OhKMpllgWqIncg-1
Received: by mail-qk1-f197.google.com with SMTP id h19so9074008qkk.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bj/1bcBSUwlXPODMgK+7TR54EtYdkqxCKK5SCH5Eb+k=;
        b=aapn7UG8u+mXhcHcVuMOD7q+Y2XgY7N08z0cqt/iyy+YCiGhEnfOW2x+TWqlLQWb6m
         OCsUPP+8mylkV+SYmc6Jr2w9Ou/77kydXxzzxisqVktGX5kLhlX5iE+xCQ5Ob/C+e6CX
         PbTVJWYUtD2L6kd04FyUyoQxRGbbEfoHFIj/ibVQQ03fR9U52AuROCYDTFxwarO0ck1T
         hsEy5KnxcBbRvsocOFSGSP3fZ2KGoBZmpf5NvZV4Bf0rZ18JAw+QpCNMj7Hjvi1tnhS4
         3SSFzGkvnteW2tTeN4ECqeOB7MRjZqzKM0508H45hO9bzLQPD6HlusC1TVGVLZxWoLJp
         Yayg==
X-Gm-Message-State: AOAM5307GF1ssB5rmpUfEPSOMt/dYL+I4wQOHZsOLJy0f9ylO3Iqfm4g
        CHzpmpANiJo5RnYjRzAO+PxRNJcz+rhI5PGP01gRTuSQaxmQvD8adKuT7TrcyyTJvfbnyyhakpg
        jGaDBoY0HLFJvn/2UUoiqpHUr
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr19301668qkm.355.1616882227417;
        Sat, 27 Mar 2021 14:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCJKaSGSlzQNoXwiiYL1bXbPYCri/xP97a1UnyExgW9n9/TCZ5ehH0OYORnNJ3nuDDuOgj8A==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr19301653qkm.355.1616882227094;
        Sat, 27 Mar 2021 14:57:07 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id t24sm8185897qto.23.2021.03.27.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:57:06 -0700 (PDT)
Date:   Sat, 27 Mar 2021 17:57:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE error
 handling + accounting
Message-ID: <20210327215703.GA429942@xz-x1>
References: <20210325231027.3402321-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325231027.3402321-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel,

On Thu, Mar 25, 2021 at 04:10:27PM -0700, Axel Rasmussen wrote:
> Previously, in the error path, we unconditionally removed the page from
> the page cache. But in the continue case, we didn't add it - it was
> already there because the page is used by a second (non-UFFD-registered)
> mapping. So, in that case, it's incorrect to remove it as the other
> mapping may still use it normally.
> 
> For this error handling failure, trivially exercise it in the
> userfaultfd selftest, to detect this kind of bug in the future.
> 
> Also, we previously were unconditionally calling shmem_inode_acct_block.
> In the continue case, however, this is incorrect, because we would have
> already accounted for the RAM usage when the page was originally
> allocated (since at this point it's already in the page cache). So,
> doing it in the continue case causes us to double-count.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/shmem.c                               | 15 ++++++++++-----
>  tools/testing/selftests/vm/userfaultfd.c | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d2e0e81b7d2e..5ac8ea737004 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2379,9 +2379,11 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	int ret;
>  	pgoff_t offset, max_off;
>  
> -	ret = -ENOMEM;
> -	if (!shmem_inode_acct_block(inode, 1))

IMHO a better change here is to only touch this line into:

        if (!is_continue && !shmem_inode_acct_block(inode, 1))

Then you don't need to touch any other line, also you can drop line [1] below
too as a side benefit.

> -		goto out;
> +	if (!is_continue) {
> +		ret = -ENOMEM;
> +		if (!shmem_inode_acct_block(inode, 1))
> +			goto out;
> +	}
>  
>  	if (is_continue) {
>  		ret = -EFAULT;
> @@ -2389,6 +2391,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  		if (!page)
>  			goto out_unacct_blocks;
>  	} else if (!*pagep) {
> +		ret = -ENOMEM;

[1]

>  		page = shmem_alloc_page(gfp, info, pgoff);
>  		if (!page)
>  			goto out_unacct_blocks;
> @@ -2486,12 +2489,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  out_release_unlock:
>  	pte_unmap_unlock(dst_pte, ptl);
>  	ClearPageDirty(page);

Should this be conditional too?  IIUC this will clear dirty for the page cache
even if it was dirty.  I'm not sure whether it'll cause data loss.

> -	delete_from_page_cache(page);
> +	if (!is_continue)
> +		delete_from_page_cache(page);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
>  out_unacct_blocks:
> -	shmem_inode_unacct_blocks(inode, 1);
> +	if (!is_continue)
> +		shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }

Besides the error handling, I looked at the function again and I have another
two thoughts:

1. IMHO in shmem_mcopy_atomic_pte() we should also conditionally call
   pte_mkwrite() just like the hugetlb code too, so as to keep W bit clear when
   !VM_SHARED.

2. I see even more "if (!is_continue)" here.. I'm thinking whether we can
   simply jump to pte installation "if (is_continue)" instead, because
   uffdio-continue shoiuld really be a lightweight operation.

   E.g., most of the things at the middle of the function is not relevant to
   uffd-continue.  To be explicit:

	ret = -EFAULT;
	offset = linear_page_index(dst_vma, dst_addr);
	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
	if (unlikely(offset >= max_off))
		goto out_release;

   These chunk can be put into !is_continue too, then if you see you're
   bypassing mostly everything.  Then error handling of uffdio-continue would
   be simple too, since it could only fail if either page cache not exist, or
   pte changed.  Nothing else could happen.

For above point (1), I even start to doubt whether we should conditionally
grant the write bit for normal uffdio_copy case only if both WRITE|SHARED set
for the vma flags. E.g., shmem_mcopy_atomic_pte() of a normal uffdio-copy will
fill in the page cache into pte, however what if this mapping is privately
mapped?  IMHO we can't apply write bit otherwise the process will be writting
to the page cache directly.

However I think that question will be irrelevant to this patch.

Thanks,

-- 
Peter Xu

