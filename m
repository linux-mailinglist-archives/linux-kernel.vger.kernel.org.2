Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8F31EFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhBRTZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhBRSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:34:22 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C77C0611C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:32:36 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o7so2356207ils.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASJfbMESWoJh/HQsMW7Q3UKMpf/MfugaFVT8oj4WLmg=;
        b=ryCJHtpSF1ypfE4YKHb5dWe5u3MHqsEwaEb86TPt1EPl6gh2KYJ445RXpgLxv4Hxo5
         SI8cver45q3N02qNa4nG2bpG99XCwT0u9VJiSrCw2RN8twvMjSsTZrnu6RgQW/lAQBBo
         96yqOc/zXHlKVeqzMlp++IMC6pd1isZABQAMn+4270ssbBkolJpt99LBVV+9MX439rxx
         +xAOZ6oxmoK3QESndmnAbLlK8wxrAa7YURMzc2vDoGzTdX7Fahd/7T4JmYNofBmVrKNX
         Ys9Y4XQRw0x7y5WEWO87oKDhpjFBnVBxWG54QmZrMT+re7WY+aXQuseBUadBpIJr5zEK
         PAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASJfbMESWoJh/HQsMW7Q3UKMpf/MfugaFVT8oj4WLmg=;
        b=iYuibLLeEG13rALwO0nC8QdGNRVHvlnA0IL/D3rMe0BY9uGz+WBTHy9ww7JeRbVogB
         +ox7thoSjdgaCv++S2eNDVvczqcLrtNiiyuoUWUVovrmW4x0v15AR0ZzcAibRR6kB+3c
         Hh/Wn+6CZ7n9IISA8zL+wYZr1O748V6wzRa9w1TczoCaXGajAa7ES6K6UpN01oNXB1pq
         DkksnZ/M2LVLmeioRZGQYQd/juS+nFgg1OePLinRxi6/n5pDFUMIsdzWdh6xMcv7a3uT
         TcoqnwTAO1vWbCcCtPU2Xv6FfAoQ13aPNtMNut4QWZh+Ij8BUDYnY4MZxL/Yv9UAjhb4
         c7GA==
X-Gm-Message-State: AOAM531Kj0ib6zExKZAkBS2KeX0hiCuPxaWO10SrpvNq+bovtvg7/c+O
        ++OVqI+na32iDfOX1QReL39vIAG6ZhGgdEWNwv9UaLxRK+jrLQ==
X-Google-Smtp-Source: ABdhPJxN7VuxhWkGQJ+OPNAsI1XMlP8fqswa88PjUGdgrl0cSBm2dVVLaUGfCOtoI2FWS+lI1yoLHRzD23Q5kDVMGes=
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr394834ill.301.1613673155515;
 Thu, 18 Feb 2021 10:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20210217204418.54259-1-peterx@redhat.com> <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com>
In-Reply-To: <20210217204619.54761-3-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 Feb 2021 10:32:00 -0800
Message-ID: <CAJHvVchtVtDHE2iJRAmraL+kbTezgfck0Mgj7xM+7U5yaJ5aCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 12:46 PM Peter Xu <peterx@redhat.com> wrote:
>
> Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
>
> Walk the hugetlb range and unshare all such mappings if there is, right before
> UFFDIO_REGISTER will succeed and return to userspace.
>
> This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> is completely disabled for userfaultfd-wp registered range.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c        |  4 ++++
>  include/linux/hugetlb.h |  1 +
>  mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 894cc28142e7..e259318fcae1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -15,6 +15,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
> @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>                 vma->vm_flags = new_flags;
>                 vma->vm_userfaultfd_ctx.ctx = ctx;
>
> +               if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> +                       hugetlb_unshare_all_pmds(vma);

This line yields the following error, if building with:
# CONFIG_CMA is not set

./fs/userfaultfd.c:1459: undefined reference to `hugetlb_unshare_all_pmds'

> +
>         skip:
>                 prev = vma;
>                 start = vma->vm_end;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3b4104021dd3..97ecfd4c20b2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -188,6 +188,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>                 unsigned long address, unsigned long end, pgprot_t newprot);
>
>  bool is_hugetlb_entry_migration(pte_t pte);
> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>
>  #else /* !CONFIG_HUGETLB_PAGE */
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f53a0b852ed8..83c006ea3ff9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5723,4 +5723,55 @@ void __init hugetlb_cma_check(void)
>         pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
>  }
>
> +/*
> + * This function will unconditionally remove all the shared pmd pgtable entries
> + * within the specific vma for a hugetlbfs memory range.
> + */
> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +{
> +       struct hstate *h = hstate_vma(vma);
> +       unsigned long sz = huge_page_size(h);
> +       struct mm_struct *mm = vma->vm_mm;
> +       struct mmu_notifier_range range;
> +       unsigned long address, start, end;
> +       spinlock_t *ptl;
> +       pte_t *ptep;
> +
> +       if (!(vma->vm_flags & VM_MAYSHARE))
> +               return;
> +
> +       start = ALIGN(vma->vm_start, PUD_SIZE);
> +       end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
> +
> +       if (start >= end)
> +               return;
> +
> +       /*
> +        * No need to call adjust_range_if_pmd_sharing_possible(), because
> +        * we're going to operate on the whole vma
> +        */
> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> +                               vma->vm_start, vma->vm_end);
> +       mmu_notifier_invalidate_range_start(&range);
> +       i_mmap_lock_write(vma->vm_file->f_mapping);
> +       for (address = start; address < end; address += PUD_SIZE) {
> +               unsigned long tmp = address;
> +
> +               ptep = huge_pte_offset(mm, address, sz);
> +               if (!ptep)
> +                       continue;
> +               ptl = huge_pte_lock(h, mm, ptep);
> +               /* We don't want 'address' to be changed */
> +               huge_pmd_unshare(mm, vma, &tmp, ptep);
> +               spin_unlock(ptl);
> +       }
> +       flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
> +       i_mmap_unlock_write(vma->vm_file->f_mapping);
> +       /*
> +        * No need to call mmu_notifier_invalidate_range(), see
> +        * Documentation/vm/mmu_notifier.rst.
> +        */
> +       mmu_notifier_invalidate_range_end(&range);
> +}
> +
>  #endif /* CONFIG_CMA */
> --
> 2.26.2
>
