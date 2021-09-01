Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E03FE513
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhIAVub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhIAVu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:50:29 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:49:32 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s16so771521ilo.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vcgS+hcrgfO3SRo6YAvjtrGWuBUKWLMcX0rbxzFDas=;
        b=T9JBlfYbYH+xAwEpJSgGrx1v6dAJCKRR0isXSU0LUpdPiBs4qyNZVyP9L5B6rpiwqC
         w2hv+agTuTNFY5yL5iejk3kumsOTzQ/yuOZ5wga0DK9Os+HZAUsPwDmaN3kenfnRr1yO
         eaNF8N1rlz8wqFgk2Q48EXeyjXv+ycUN7AgBQ2nXza2g+YnFFpnmPZEfoHR2ev1OVbYj
         UxqP+yujrbJfI4xXS9vjazUgYmWO4E2LS+I+Rvqciz6MGkfOugR1WVD6ZMSODx2ENmXq
         mCXl+B8MIyjdJyDMuojaQqxO5mmAY94VaMixD99IZwgbAeUFyBEv1neAJRqdxzT5CrOR
         5K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vcgS+hcrgfO3SRo6YAvjtrGWuBUKWLMcX0rbxzFDas=;
        b=XVTrah6hv7pBirOvX+Wb8jr+CCcAjueWfsaSuI96tfoBXZ0SsG94ofgTRGl4ereiio
         mn32FubAbZvW8TP3uUMS4qLB9hroY11MygGiifLUKUaz97yCBjSSVuJCs7UoDCX9pEoV
         D3fodOk4LHxdNXbRRFLAxAFKEdgbQ5J5jXV/y+0V9ZEJQGx3s5kJlMoib21V7yYo5w+V
         RjvbjF1QNee31/NQl4mdOHSEj75KcpbIYe206dIsRVoGQq03m82pget6+uC/Ci0EFhEl
         GIMOb5mPPqh2zy1GLg5d2OtI7qEDsHd3EAPapojDa+/RKK+0xQ1LfI27scpYNBjEr1kU
         WY4g==
X-Gm-Message-State: AOAM531yDMscrTXstLSOi5/t5f3RhaF5em28Id7/B6g87px01Bu5G4vv
        3IttJaq8MYtPj8YEFGYCvdFn7L6EcCfRVhJYVFZRAQ==
X-Google-Smtp-Source: ABdhPJwbczxunW48/7yrWaaT2VzPWO7NdmVc8dCnDzsQhqJbBoa9m05tpPfxGLBgpfN3kSgKHSD+lNKWYP53UBhSs+s=
X-Received: by 2002:a05:6e02:5aa:: with SMTP id k10mr1100592ils.301.1630532971871;
 Wed, 01 Sep 2021 14:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210901205622.6935-1-peterx@redhat.com> <20210901205622.6935-2-peterx@redhat.com>
In-Reply-To: <20210901205622.6935-2-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 1 Sep 2021 14:48:53 -0700
Message-ID: <CAJHvVchpEGvgLGpH7NrSUKLbuur55x+YEm_5y_y0YT7H9yYrng@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:56 PM Peter Xu <peterx@redhat.com> wrote:
>
> It was conditionally done previously, as there's one shmem special case that we
> use SetPageDirty() instead.  However that's not necessary and it should be
> easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
>
> The most recent discussion about this is here, where Hugh explained the history
> of SetPageDirty() and why it's possible that it's not required at all:
>
> https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/

Thanks for the cleanup Peter!

I think the discussion of whether or not the data can be marked dirty
below is correct, and the code change looks good as well. But, I think
we're missing an explanation why Hugh's concern is indeed not a
problem?

Specifically, this question:

"Haha: I think Andrea is referring to exactly the dirty_accountable
code in change_pte_protection() which worried me above. Now, I think
that will turn out okay (shmem does not have a page_mkwrite(), and
does not participate in dirty accounting), but you will have to do
some work to assure us all of that, before sending in a cleanup
patch."

Do we have more evidence that this is indeed fine, vs. what we had
when discussing this before? If so, we should talk about it explicitly
in this commit message, I think.

(Sorry if you've covered this and it's just going over my head. ;) )

>
>
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
> it's merely 100% sure the page is dirty after all, so should not make a real
> difference either.
>
> This should make it much easier to follow on which case will set dirty for
> uffd, as we'll simply set it all now for all uffd related ioctls.  Meanwhile,
> no special handling of SetPageDirty() if there's no need.
>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/shmem.c       | 1 -
>  mm/userfaultfd.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index dacda7463d54..3f91c8ce4d02 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2437,7 +2437,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>         shmem_recalc_inode(inode);
>         spin_unlock_irq(&info->lock);
>
> -       SetPageDirty(page);
>         unlock_page(page);
>         return 0;
>  out_delete_from_cache:
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0e2132834bc7..b30a3724c701 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -69,10 +69,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>         pgoff_t offset, max_off;
>
>         _dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> +       _dst_pte = pte_mkdirty(_dst_pte);
>         if (page_in_cache && !vm_shared)
>                 writable = false;
> -       if (writable || !page_in_cache)
> -               _dst_pte = pte_mkdirty(_dst_pte);
>         if (writable) {
>                 if (wp_copy)
>                         _dst_pte = pte_mkuffd_wp(_dst_pte);
> --
> 2.31.1
>
