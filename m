Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24C41519D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhIVUvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhIVUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:51:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:50:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h129so5283526iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFMm6NiEdpDi099+JSn7qlXvpS8yt1RYEqmBc09i4cg=;
        b=iaStf23wLKtouI1H2CJCz2IVvLZdEQlSPxGZ11XDdpu7iMTPqk2j4tfSeFGBXY4pUj
         c5uS1pY1B3JpebdVIt+9ea5/J2fFDcqB4CVZX8nwPoQbFhV0rBt0iJ+uQ/p6+hSw1qOc
         xeYIU0J2DRUmawVjoEml10JTnobstgDrGFVVrndO4w2yKYkJ+XJ5H/l2wEJOgWvy5LZg
         CirTG3OmtI+nD0V1I5QLk972KwxYLmDsnn0d0EjgbVaxr013VsQv2bTPbaFZNVPctyJM
         cNKkzcDt/6N5ZHTKX2PYU42M5aEpt/Es6co/v3fRDijALtAaNDrcIROuJkpYbuqQez8H
         j6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFMm6NiEdpDi099+JSn7qlXvpS8yt1RYEqmBc09i4cg=;
        b=YnXI595I2akCog/6nY+6OpTkMX9+YYeHI6IWAJ2yJbp9hyYvaBT90QdexdINI4NCI7
         jYh6bwXNsuXLHZn4PYKPgfLr1dAMk2DrUo93kiKJ3Xn2vnmtVwevwSmMLY+Nv9yDTj+D
         uaR340/hZSwYe6Ti6sUrZI5GcSSnOl4gb009BuZuPN0V8PvN3h7Si2oupwczVcGOGRYZ
         yGRr1TuW++PH5hHemyxKY6Rs8mhtVqdKDX3gW9KYdNsXBicFk8KsiY28bGDHbThyqpco
         4HosLuSCJ2vyz70cq5n/KelHQNQQF6KIoPxsqmSd32srcyLrKUIczYx3SSDmGxWms82P
         lzCA==
X-Gm-Message-State: AOAM531gQtrGnSMDize2+E9soBR6G+d5vtJupD0dVXKOU6pc456F2j/H
        o80l5fZ6Q69e0M4u9QCY/R8DvY266HGmq/nWhqeRzg==
X-Google-Smtp-Source: ABdhPJwFrYtiaDMP+aZPQ192rNXUYiDjQGtASWTxtXyZhFXBW+hdvV5CdXj4RyKwr/dT0+z9CMuBSREkadjzFMxl/eY=
X-Received: by 2002:a5e:9810:: with SMTP id s16mr820110ioj.171.1632343819263;
 Wed, 22 Sep 2021 13:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210922175156.130228-1-peterx@redhat.com>
In-Reply-To: <20210922175156.130228-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 22 Sep 2021 13:49:42 -0700
Message-ID: <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
> scanning right after we detected a uffd-wp armed pte (either present, or swap).
>
> It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
> enabled VMAs.  Checking against the vma flag would be more efficient, and good
> enough.  To be explicit, we could still be able to merge some thps for
> VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
> ptes, however that's not a major target for thp collapse anyways.
>
> This mostly reverts commit e1e267c7928fe387e5e1cffeafb0de2d0473663a, but
> instead we do the same check at vma level, so it's not a bugfix.
>
> This also paves the way for file-backed uffd-wp support, as the VM_UFFD_WP flag
> will work for file-backed too.
>
> After this patch, the error for khugepaged for these regions will switch from
> SCAN_PTE_UFFD_WP to SCAN_VMA_CHECK.
>
> Since uffd minor mode should not allow thp as well, do the same thing for minor
> mode to stop early on trying to collapse pages in khugepaged.
>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Axel: as I asked in the other thread, please help check whether minor mode will
> work properly with shmem thp enabled.  If not, I feel like this patch could be
> part of that effort at last, but it's also possible that I missed something.

Sorry for missing the other thread.

Unfortunately, I think shmem THP *doesn't* really work with minor
faults, and what's worse, just checking the VMA flag isn't enough.

First, let me note the guarantee UFFD minor faults are trying to
provide: for a given mapping, any minor fault (that is, pte_none() but
a page is present in the page cache) must result in a minor userfault
event. Furthermore, the only way the fault may be resolved (i.e., a
PTE installed) is via a UFFDIO_CONTINUE ioctl from userspace.

A typical use case for minor faults is, we have two mappings (i.e.,
two VMAs), both pointing to the same underlying physical memory. It's
typical for both to have MAP_SHARED. It's typical for one of these
mappings to be fully faulted in (i.e., all of its PTEs exist), while
the other one has some missing PTEs. The problem is, khugepaged might
scan *either* of the two mappings. Say it picks the fully-faulted VMA:
even if we set khugepaged_max_ptes_none to zero, it will still go
ahead and collapse these pages - because *this* VMA has no missing
PTEs.

Why is this a problem? When we collapse, we install a PMD, for *all*
VMAs which reference these pages. In other words, we might install
PTEs for the other, minor-fault-registered mapping, and therefore
userfaults will never trigger for some of those regions, even though
userspace never UFFDIO_CONTINUE-ed them.

I *think* the right place to check for this and solve it is in
retract_page_tables(), and I have a patch which does this. I've been
hesitant to send it though, as due to a lack of time and the
complexity involved I haven't been able to write a clear reproducer
program, which my patch clearly fixes. :/

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/trace/events/huge_memory.h |  1 -
>  mm/khugepaged.c                    | 26 +++-----------------------
>  2 files changed, 3 insertions(+), 24 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 4fdb14a81108..53532f5925c3 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -15,7 +15,6 @@
>         EM( SCAN_EXCEED_SWAP_PTE,       "exceed_swap_pte")              \
>         EM( SCAN_EXCEED_SHARED_PTE,     "exceed_shared_pte")            \
>         EM( SCAN_PTE_NON_PRESENT,       "pte_non_present")              \
> -       EM( SCAN_PTE_UFFD_WP,           "pte_uffd_wp")                  \
>         EM( SCAN_PAGE_RO,               "no_writable_page")             \
>         EM( SCAN_LACK_REFERENCED_PAGE,  "lack_referenced_page")         \
>         EM( SCAN_PAGE_NULL,             "page_null")                    \
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 045cc579f724..3afe66d48db0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -31,7 +31,6 @@ enum scan_result {
>         SCAN_EXCEED_SWAP_PTE,
>         SCAN_EXCEED_SHARED_PTE,
>         SCAN_PTE_NON_PRESENT,
> -       SCAN_PTE_UFFD_WP,
>         SCAN_PAGE_RO,
>         SCAN_LACK_REFERENCED_PAGE,
>         SCAN_PAGE_NULL,
> @@ -467,6 +466,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>                 return false;
>         if (vma_is_temporary_stack(vma))
>                 return false;
> +       /* Don't allow thp merging for wp/minor enabled uffd regions */
> +       if (userfaultfd_wp(vma) || userfaultfd_minor(vma))
> +               return false;
>         return !(vm_flags & VM_NO_KHUGEPAGED);
>  }
>
> @@ -1246,15 +1248,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                 pte_t pteval = *_pte;
>                 if (is_swap_pte(pteval)) {
>                         if (++unmapped <= khugepaged_max_ptes_swap) {
> -                               /*
> -                                * Always be strict with uffd-wp
> -                                * enabled swap entries.  Please see
> -                                * comment below for pte_uffd_wp().
> -                                */
> -                               if (pte_swp_uffd_wp(pteval)) {
> -                                       result = SCAN_PTE_UFFD_WP;
> -                                       goto out_unmap;
> -                               }
>                                 continue;
>                         } else {
>                                 result = SCAN_EXCEED_SWAP_PTE;
> @@ -1270,19 +1263,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                                 goto out_unmap;
>                         }
>                 }
> -               if (pte_uffd_wp(pteval)) {
> -                       /*
> -                        * Don't collapse the page if any of the small
> -                        * PTEs are armed with uffd write protection.
> -                        * Here we can also mark the new huge pmd as
> -                        * write protected if any of the small ones is
> -                        * marked but that could bring unknown
> -                        * userfault messages that falls outside of
> -                        * the registered range.  So, just be simple.
> -                        */
> -                       result = SCAN_PTE_UFFD_WP;
> -                       goto out_unmap;
> -               }
>                 if (pte_write(pteval))
>                         writable = true;
>
> --
> 2.31.1
>
