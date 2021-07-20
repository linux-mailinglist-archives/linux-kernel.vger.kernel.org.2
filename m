Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4878F3D0381
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhGTURS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbhGTUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:08:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E12C061768
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:49:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nd37so36284054ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AboetzlMBZEQFYyVq02sIsGWJx/JjBRI37re6kVn+AM=;
        b=WMiyPulpA0yNVIE1CU5GjpG4+1PLhkQ2dzox7fjiM1rGEzfYvvYzfYmhMjS3f8ShbR
         RW3oSaI6QVNXk+ziX7uVpMO49OSf0jnwHct3788yjnSeaF5SgdtIqIqdX4djCsK4i2Sy
         5mr7RJyXNjiARSzGBqzk5l+/zblMhQgdhHjdLBfRtZJgra+oP7SRcUXwauR8fj0UYpR8
         F7V0Eg/+zQpz/bmaQvXE10l0O+2flHYzD2SbH34ufoT6HQu2l7jhlMbHfe5CCmn5e2gO
         MR2vnmxX9PZpbRsVTvUAqCegWibE2VGFJsDYJNWGCMyRDbJSTVmTZX3vnoly40YwxVTT
         GXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AboetzlMBZEQFYyVq02sIsGWJx/JjBRI37re6kVn+AM=;
        b=fAjf1CaEnU9P1ek/isupV5AJfsnguegPreqdgTu9vTdWYLkWOBT9LlaW4ewfauLJuS
         hB+cn543/IeEDC4oxDD16QrNRc3m314jG4RZgfA5PHSbCOhBH7jzSJPcHHLTxQoCJw6e
         MxHp5uNMMisW/tXIsPW2m5EUc8Y5ySjJo5w20qAZbfPXCHGki391oFR5xi2nwkKHSs56
         jisjbqADlVxSyvO+h8pVQLE21w4rJX6e33gUc29HoZcgv5NZ7zn+w7g3tZ/f4R3e8Cjx
         UXnmp3+ti7mq07lbJkIjGljuGrz5V6NlBH4t26DqrNttaNXgtyUTgoL3qKA3/Q/MpDPB
         bgUA==
X-Gm-Message-State: AOAM532S5+ul2715DcSZsCb6cbz6mcb8DS1bW7v+SN3X8n8TyBra7HnW
        b3L/j/HuQzQfrM6nSHy8VS/FVM26ydY/fylzdVpUsuus6STS1Q==
X-Google-Smtp-Source: ABdhPJz0PQe4hlWMAq/5Aby4AGhK3rR89n4lgC8rV+phSIG7e85X5lT4q7jq1tMnWMvwv7BlD++GL+GLIVwq45qY3co=
X-Received: by 2002:a17:907:20c6:: with SMTP id qq6mr10939524ejb.25.1626814140990;
 Tue, 20 Jul 2021 13:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210720065529.716031-1-ying.huang@intel.com>
In-Reply-To: <20210720065529.716031-1-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Jul 2021 13:48:47 -0700
Message-ID: <CAHbLzkrKZNT1MwrCp0SOzZ43C12DZzNmPKXLwxKZ=j+YgOaW=g@mail.gmail.com>
Subject: Re: [PATCH] mm,do_huge_pmd_numa_page: remove unnecessary TLB flushing code
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mel Gorman <mgorman@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:56 PM Huang Ying <ying.huang@intel.com> wrote:
>
> Before the commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> handling"), the TLB flushing is done in do_huge_pmd_numa_page() itself
> via flush_tlb_range().
>
> But after commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> handling"), the TLB flushing is done in migrate_pages() as in the
> following code path anyway.
>
> do_huge_pmd_numa_page
>   migrate_misplaced_page
>     migrate_pages
>
> So now, the TLB flushing code in do_huge_pmd_numa_page() becomes
> unnecessary.  So the code is deleted in this patch to simplify the
> code.  This is only code cleanup, there's no visible performance
> difference.

Yes, there is tlb flush in try_to_migrate(), but it seems mmu notifier
invalidate is missed for the THP migration case. I'm not quite sure
why it is not needed, maybe just missed?

So, you may need the below change too:

diff --git a/mm/rmap.c b/mm/rmap.c
index 2d29a57d29e8..e1c8b654563d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1749,6 +1749,8 @@ static bool try_to_migrate_one(struct page
*page, struct vm_area_struct *vma,
                                       !PageTransCompound(page), page);

                        set_pmd_migration_entry(&pvmw, page);
+                       mmu_notifier_invalidate_range(mm, range.start,
+                                                     range.end);
                        continue;
                }
 #endif

>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index afff3ac87067..9f21e44c9030 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1440,32 +1440,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>                 goto out;
>         }
>
> -       /*
> -        * Since we took the NUMA fault, we must have observed the !accessible
> -        * bit. Make sure all other CPUs agree with that, to avoid them
> -        * modifying the page we're about to migrate.
> -        *
> -        * Must be done under PTL such that we'll observe the relevant
> -        * inc_tlb_flush_pending().
> -        *
> -        * We are not sure a pending tlb flush here is for a huge page
> -        * mapping or not. Hence use the tlb range variant
> -        */
> -       if (mm_tlb_flush_pending(vma->vm_mm)) {
> -               flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
> -               /*
> -                * change_huge_pmd() released the pmd lock before
> -                * invalidating the secondary MMUs sharing the primary
> -                * MMU pagetables (with ->invalidate_range()). The
> -                * mmu_notifier_invalidate_range_end() (which
> -                * internally calls ->invalidate_range()) in
> -                * change_pmd_range() will run after us, so we can't
> -                * rely on it here and we need an explicit invalidate.
> -                */
> -               mmu_notifier_invalidate_range(vma->vm_mm, haddr,
> -                                             haddr + HPAGE_PMD_SIZE);
> -       }
> -
>         pmd = pmd_modify(oldpmd, vma->vm_page_prot);
>         page = vm_normal_page_pmd(vma, haddr, pmd);
>         if (!page)
> --
> 2.30.2
>
