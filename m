Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB9416AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbhIXD6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbhIXD6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:58:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:56:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 138so26296991qko.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=T5ADzI1en+YNAAEohrN23QUrZld4cBrYp9ozDzunpR4=;
        b=NnJX5JHW9yz4l0kRzGcspC0ezBt/AAfd1RF760dKV1skI7k4vUi3HnJRseYnNU7N2z
         yW/wNZVO9qdllvrtpr/g3Fswl67xuUfnNAqSJwuC84/bOUdGV8KW2fXm8UQaBeXj0zl3
         +dT1tunmrfdARc1CYn5P3DmGFTOpHFTh0I4Z3H6j0dVQpc3qHVZ1xWbyNJP0yEDAru3C
         QEE7EAfKyPdKJuZ92W1oaZ34kNNkBgccIrUYsKGYJDd0ADs7d2v2Xx0+oaw0i0C9rBZu
         NaBgEBSMkAmtA3nGUKu7rfShAYpuEIcrJ9RDAX5H/02zkKF4hx1nZowupUkH2SBf7PoR
         qsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=T5ADzI1en+YNAAEohrN23QUrZld4cBrYp9ozDzunpR4=;
        b=nKgqm/Gv7Yx04IjS7yUDamdYbWKVjJ/cMQlUJvSJxvOH8n2eMSiEuMQNU3BPRinwiB
         39mxYsjwhZ8MUTLgg1hjORrZmVfpGx5A2j4VpJH9XQPmrUZdZ8LD+htSYRy2hBbyInn3
         JD70dcL6+n7e+2N4l+L+lLAoMG65R+FwrpS/B09p3tPnWz1ap9CwwKwQAAIEMjlfyB/O
         9zmk5DEaVQf2cbVmd74weo4gVlRDz7nVGNNK0gG3Nk+w9zz54RnMeA5Eq2gyTRnWB1lw
         VJISMzclmb00MiX76lFjhZDlLna0qIBwWa0Mu5v7e8iX5mzhjynKa42pt5toRUogm7Ml
         RbWg==
X-Gm-Message-State: AOAM5328CV7BnZLw54Nu8jtjarlaofIrsPwY1h4p4zRGEsl4dq7n/RSA
        TI2xFVn7cikSu4rUHmeqYTOXzw==
X-Google-Smtp-Source: ABdhPJwxCwPy6uCxI8Dl35dqUTg1+YhaXVWGZRboWOidkejvRGBO6taET3IT+SOPd4hc8zg2BvHbaQ==
X-Received: by 2002:a37:b94:: with SMTP id 142mr8461074qkl.390.1632455804912;
        Thu, 23 Sep 2021 20:56:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u13sm5281885qki.38.2021.09.23.20.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 20:56:44 -0700 (PDT)
Date:   Thu, 23 Sep 2021 20:56:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
In-Reply-To: <20210915181456.10739-2-peterx@redhat.com>
Message-ID: <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
References: <20210915181456.10739-1-peterx@redhat.com> <20210915181456.10739-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Peter Xu wrote:

> It was conditionally done previously, as there's one shmem special case that we
> use SetPageDirty() instead.  However that's not necessary and it should be
> easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> 
> The most recent discussion about this is here, where Hugh explained the history
> of SetPageDirty() and why it's possible that it's not required at all:
> 
> https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> 
> Currently mfill_atomic_install_pte() has three callers:
> 
>         1. shmem_mfill_atomic_pte
>         2. mcopy_atomic_pte
>         3. mcontinue_atomic_pte
> 
> After the change: case (1) should have its SetPageDirty replaced by the dirty
> bit on pte (so we unify them together, finally), case (2) should have no
> functional change at all as it has page_in_cache==false, case (3) may add a
> dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
> it's merely 100% sure the page is dirty after all because UFFDIO_CONTINUE
> normally requires another process to modify the page cache and kick the faulted
> thread, so should not make a real difference either.
> 
> This should make it much easier to follow on which case will set dirty for
> uffd, as we'll simply set it all now for all uffd related ioctls.  Meanwhile,
> no special handling of SetPageDirty() if there's no need.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I'm not going to NAK this, but you and I have different ideas of
"very nice cleanups".  Generally, you appear (understandably) to be
trying to offload pieces of work from your larger series, but often
I don't see the sense of them, here in isolation anyway.

Is this a safe transformation of the existing code? Yes, I believe so
(at least until someone adds some PTESAN checker which looks to see
if any ptes are dirty in vmas to which user never had write access).
But it took quite a lot of lawyering to arrive at that conclusion.

Is this a cleanup? No, it's a dirtyup.

shmem_mfill_atomic_pte() does SetPageDirty (before unlocking page)
because that's where the page contents are made dirty.  You could
criticise it for doing SetPageDirty even in the zeropage case:
yes, we've been lazy there; but that's a different argument.

If someone is faulting this page into a read-only vma, it's
surprising to make the pte dirty there.  What would be most correct
would be to keep the SetPageDirty in shmem_mfill_atomic_pte()
(with or without zeropage optimization), and probably SetPageDirty
in some other places in mm/userfaultfd.c (I didn't look where) when
the page is filled with supplied data, and mfill_atomic_install_pte()
only do that pte_mkdirty() when it's serving a FAULT_FLAG_WRITE.

I haven't looked again (I have a pile of mails to respond to!),
but when I looked before I think I found that the vmf flags are
not available to the userfaultfd ioctler.  If so, then it would
be more appropriate to just leave the mkdirty to the hardware on
return from fault (except - and again I cannot spend time researching
this - perhaps I'm too x86-centric, and there are other architectures
on which the software *must* do the mkdirty fixup to avoid refaulting
forever - though probably userfaultfd state would itself prevent that).

But you seem to think that doing the dirtying in an unnatural place
helps somehow; and for all I know, that may be so in your larger
series, though this change certainly raises suspicions of that.

I'm sorry to be so discouraging, but you have asked for my opinion,
and here at last you have it.  Not a NAK, but no enthusiasm at all.

Hugh

> ---
>  mm/shmem.c       | 1 -
>  mm/userfaultfd.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88742953532c..96ccf6e941aa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2424,7 +2424,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  
> -	SetPageDirty(page);
>  	unlock_page(page);
>  	return 0;
>  out_delete_from_cache:
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7a9008415534..caf6dfff2a60 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -69,10 +69,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	pgoff_t offset, max_off;
>  
>  	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> +	_dst_pte = pte_mkdirty(_dst_pte);
>  	if (page_in_cache && !vm_shared)
>  		writable = false;
> -	if (writable || !page_in_cache)
> -		_dst_pte = pte_mkdirty(_dst_pte);
>  	if (writable) {
>  		if (wp_copy)
>  			_dst_pte = pte_mkuffd_wp(_dst_pte);
> -- 
> 2.31.1
