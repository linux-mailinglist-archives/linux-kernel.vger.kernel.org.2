Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231C34F29B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhC3Uzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232622AbhC3Uz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617137724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRvNsBmljdgCvcSL+wgK07oVws9y42KLzeTSspwyxR0=;
        b=KObBOUVWzsP9hJcRiLlijafSyaxTJFm1nOxW0K8Ajtfss+lSArytK7e+75PqCzitXoVUq4
        Y0S2HAvaaBJ6YwAn1ZgYKF+yyq7+F+EuzTNr/UGmnyzU5ozsRJ9Wko2uOcp4l/OnKKkv3D
        eFAJqIWdZeer9+RJIS6Wb+5yyVDjfhU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-DzV_qgC3Puy-eZKDKUvTsg-1; Tue, 30 Mar 2021 16:55:23 -0400
X-MC-Unique: DzV_qgC3Puy-eZKDKUvTsg-1
Received: by mail-qk1-f200.google.com with SMTP id o70so15253064qke.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRvNsBmljdgCvcSL+wgK07oVws9y42KLzeTSspwyxR0=;
        b=VTEm/LDMIJDcHSJF90rqAtDH9P1DP/wi+kYL6/+qwRot6K0WxMdB1Glp/s2MVPAFJJ
         cEO0CtRXPZk4JG+A9C59up81zik3JDShVg4mxAK694MjDiLUEJAsIPJWI1ncivWC/Fw2
         8MjfkIcE9C6WSkquzzCshtpHK/xgi96liWPcRqYWF+53BoqeGXyEScJ4AfhW8ComUtFf
         3g1div0i5qEMJdRS1VxKV8vaVIbcyWM29vEMgWdTZszvgBixv2MdUZ1O1OYVx10lCg+P
         s0TsmPL1r3Wuf+v4elVsS7Mh+Wu5/I0xnuKr+5PAc6m34ByPsgqfn59FPAmsLO11vGnF
         pYzg==
X-Gm-Message-State: AOAM530ExSMSiO+kyEImXEA25EvsFdJRsQxBddErt04Hn2qZkPRg3Yzv
        oXFGjgu9G1qb68GO/W2wWTQg9pofaxMZVLB5kP/S/eJ+oaVCyRHXx9VQcEG50DBjKP3OFY1EVjo
        duOdmWxeWuAG2f5vTftntdKOX
X-Received: by 2002:a37:88d:: with SMTP id 135mr165753qki.132.1617137722211;
        Tue, 30 Mar 2021 13:55:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2Kog/qZQ7R1BmLPSOVMdEexOnqLe6WiVlBhyu9SYLj1PvmW487eU+osVI2uYtZQ4Jhzi0NA==
X-Received: by 2002:a37:88d:: with SMTP id 135mr165724qki.132.1617137721817;
        Tue, 30 Mar 2021 13:55:21 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id d24sm16158741qkl.49.2021.03.30.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:55:20 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:55:19 -0400
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
Subject: Re: [PATCH v3] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE behavior
Message-ID: <20210330205519.GK429942@xz-x1>
References: <20210329234131.304999-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329234131.304999-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:41:31PM -0700, Axel Rasmussen wrote:
> Previously, we shared too much of the code with COPY and ZEROPAGE, so we
> manipulated things in various invalid ways:
> 
> - Previously, we unconditionally called shmem_inode_acct_block. In the
>   continue case, we're looking up an existing page which would have been
>   accounted for properly when it was allocated. So doing it twice
>   results in double-counting, and eventually leaking.
> 
> - Previously, we made the pte writable whenever the VMA was writable.
>   However, for continue, consider this case:
> 
>   1. A tmpfs file was created
>   2. The non-UFFD-registered side mmap()-s with MAP_SHARED
>   3. The UFFD-registered side mmap()-s with MAP_PRIVATE
> 
>   In this case, even though the UFFD-registered VMA may be writable, we
>   still want CoW behavior. So, check for this case and don't make the
>   pte writable.
> 
> - The initial pgoff / max_off check isn't necessary, so we can skip past
>   it. The second one seems likely to be unnecessary too, but keep it
>   just in case. Modify both checks to use pgoff, as offset is equivalent
>   and not needed.
> 
> - Previously, we unconditionally called ClearPageDirty() in the error
>   path. In the continue case though, since this is an existing page, it
>   might have already been dirty before we started touching it. It's very
>   problematic to clear the bit incorrectly, but not a problem to leave
>   it - so, just omit the ClearPageDirty() entirely.
> 
> - Previously, we unconditionally removed the page from the page cache in
>   the error path. But in the continue case, we didn't add it - it was
>   already there because the page is present in some second
>   (non-UFFD-registered) mapping. So, removing it is invalid.
> 
> Because the error handling issues are easy to exercise in the selftest,
> make a small modification there to do so.
> 
> Finally, refactor shmem_mcopy_atomic_pte a bit. By this point, we've
> added a lot of "if (!is_continue)"-s everywhere. It's cleaner to just
> check for that mode first thing, and then "goto" down to where the parts
> we actually want are. This leaves the code in between cleaner.
> 
> Changes since v2:
> - Drop the ClearPageDirty() entirely, instead of trying to remember the
>   old value.
> - Modify both pgoff / max_off checks to use pgoff. It's equivalent to
>   offset, but offset wasn't initialized until the first check (which
>   we're skipping).
> - Keep the second pgoff / max_off check in the continue case.
> 
> Changes since v1:
> - Refactor to skip ahead with goto, instead of adding several more
>   "if (!is_continue)".
> - Fix unconditional ClearPageDirty().
> - Don't pte_mkwrite() when is_continue && !VM_SHARED.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/shmem.c                               | 60 +++++++++++++-----------
>  tools/testing/selftests/vm/userfaultfd.c | 12 +++++
>  2 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d2e0e81b7d2e..fbcce850a16e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2377,18 +2377,22 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	struct page *page;
>  	pte_t _dst_pte, *dst_pte;
>  	int ret;
> -	pgoff_t offset, max_off;
> -
> -	ret = -ENOMEM;
> -	if (!shmem_inode_acct_block(inode, 1))
> -		goto out;
> +	pgoff_t max_off;
> +	int writable;

Nit: can be bool.

[...]

> +install_ptes:
>  	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> -	if (dst_vma->vm_flags & VM_WRITE)
> +	/* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
> +	writable = is_continue && !(dst_vma->vm_flags & VM_SHARED)
> +		? 0
> +		: dst_vma->vm_flags & VM_WRITE;

Nit: this code is slightly hard to read..  I'd slightly prefer "if
(is_continue)...".  But more below.

> +	if (writable)
>  		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
>  	else {
>  		/*
> @@ -2455,7 +2458,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  
>  	ret = -EFAULT;
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -	if (unlikely(offset >= max_off))
> +	if (unlikely(pgoff >= max_off))
>  		goto out_release_unlock;
>  
>  	ret = -EEXIST;
> @@ -2485,13 +2488,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	return ret;
>  out_release_unlock:
>  	pte_unmap_unlock(dst_pte, ptl);
> -	ClearPageDirty(page);
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

If you see we still have tons of "if (!is_continue)".  Those are the places
error prone.. even if not in this patch, could be in the patch when this
function got changed again.

Sorry to say this a bit late: how about introduce a helper to install the pte?
Pesudo code:

int shmem_install_uffd_pte(..., bool writable)
{
	...
	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
	if (dst_vma->vm_flags & VM_WRITE)
		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
	else
		set_page_dirty(page);

	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
	if (!pte_none(*dst_pte)) {
		pte_unmap_unlock(dst_pte, ptl);
		return -EEXIST;
	}

	inc_mm_counter(dst_mm, mm_counter_file(page));
	page_add_file_rmap(page, false);
	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);

	/* No need to invalidate - it was non-present before */
	update_mmu_cache(dst_vma, dst_addr, dst_pte);
	pte_unmap_unlock(dst_pte, ptl);
	return 0;
}

Then at the entry of shmem_mcopy_atomic_pte():

	if (is_continue) {
		page = find_lock_page(mapping, pgoff);
		if (!page)
                    return -EFAULT;
                ret = shmem_install_uffd_pte(...,
                        is_continue && !(dst_vma->vm_flags & VM_SHARED));
                unlock_page(page);
                if (ret)
                    put_page(page);
                return ret;
        }

Do you think this would be cleaner?

-- 
Peter Xu

