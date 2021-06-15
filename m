Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A403A764F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 07:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFOFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:17:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 22:15:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o20so10331119qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0wAP9EOwe53ziCwYyTPzQod1ybR+EAoh8nvLC2RE/U=;
        b=pyJzjUWHLEKplY05J/dGDBz62Lc4PMwKMUaIZMtL9LDPVwMQgadZl6Ew84ERUTqCkK
         L3rIUagVLAKyKm99kmfxOJtY1iWAy4nq8ac2zt9sYSwWoK086GipVkVfZkoA2QS7q2PU
         914/S4AUq1CFHUD7tgIXS9ugUZXrFo97MmixGNKzBJjWtQolgQCQx+AiiaKzq4GFKWKy
         jgYCZuADfMBD/+RDBf9qoOqLy95Tf6x98N3Z/adzjuoJ2dV7WwUvXM2Kmr8MVEi1yFcV
         x26fYXTQsxGeh/GC79wR+t+jE8bkKiVwx5c0me8gLsDgv7Y+Xq0xuyzYzCX5BkK9TbfV
         /NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0wAP9EOwe53ziCwYyTPzQod1ybR+EAoh8nvLC2RE/U=;
        b=Q8lmnO85Bms6jJVCo3sEInCpfbUnU/FKUlcCbxdA0yi3rXvnVFJbbS9hw3OPLmow6Z
         rB8UV54GiR5nS6TAq5e+2muBBNYhso6VlOsr7NhAhcSQdKEc99ulB1mJKUqmgaO2r8gp
         vtlvsvLbiBNSjfEVq8PhdnAVN2RE7AfXqbgkirh1lPiWxTg0deC+12K7egRJOwEQV9sq
         c9x45+fRu3+qee/Mg9GRdzTp9RAWZTf6yfprcc+ngwkDRvUy9zlDyWD9MVBvWrDE90I2
         hLRbk7cEPnkob4wdvj5LMHRooZa5Y8YQdA+E93bv/OELa3ZA8e2T3brAlQr5OPnGUci8
         K2Jg==
X-Gm-Message-State: AOAM530Vp7Nbq28P0GobgBhcfgNesiA11WfOl79XaJ0G12PC1ll0DkGm
        VuMwd3kvpCW1ETliV6+2aIEaMiS+kcshrTKutwCyesbigd1ZQA==
X-Google-Smtp-Source: ABdhPJyVp5fM6tkAzUnPPlLhc3CK5IVsP8w1kRWIvqxqM1LK2gcvuvzu58pgFfNGUkXfSRlqPbIV0KYnUTd4dIoBl5U=
X-Received: by 2002:ac8:5949:: with SMTP id 9mr2405020qtz.67.1623734135120;
 Mon, 14 Jun 2021 22:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <YMe8ktUsdtwFKHuF@nuc10>
In-Reply-To: <YMe8ktUsdtwFKHuF@nuc10>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Jun 2021 07:15:24 +0200
Message-ID: <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
Subject: Re: kmemleak memory scanning
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
>
> hello Catalin, Andrew!
>
> while troubleshooting a false positive syzbot kmemleak report i have
> noticed an interesting behavior in kmemleak and i wonder whether it is
> behavior by design and should be documented, or maybe something to
> improve.
> apologies if some of the questions do not make sense, i am still going
> through kmemleak code..
>
> a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> the actual contents (page_address(page)) of the page.
> if we allocate an object with kmalloc(), then allocate page with
> alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> kmemleak will report kmalloc pointer as a false positive.
> should we improve kmemleak and make it scan page contents?
> or will this bring too many false negatives?

Hi Rustam,

Nice debugging!
I assume lots of pages are allocated for slab and we don't want to
scan the whole page if only a few slab objects are alive on the page.
However alloc_pages() can be called by end kernel code as well.
I grepped for any kmemleak annotations around existing calls to
alloc_pages, but did not find any...
Does it require an explicit kmemleak_alloc() after allocating the page
and kmemleak_free () before freeing the page?
If there are more than one use case for this, I guess we could add
some GFP flag for this maybe.





> b) when kmemleak object gets created (kmemleak.c:598) it gets checksum
> of 0, by the time user requests kmemleak "scan" via debugfs the pointer
> will be most likely changed to some value by the kernel and during
> first scan kmemleak won't report the object as orphan even if it did not
> find any reference to it, because it will execute update_checksum() and
> after that will proceed to updating object->count (kmemleak.c:1502).
> and so the user will have to initiate a second "scan" via debugfs and
> only then kmemleak will produce the report.
> should we document this?
>
> below i am attaching a simplified reproducer for the false positive
> kmemleak report (a).
> i could have done it in the module, but i found it to be easier and
> faster to test when done in a syscall, so that i did not have to
> modprobe/modprobe -r.
>
> tyvm!
>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  include/linux/syscalls.h               |  1 +
>  mm/Makefile                            |  2 +-
>  mm/kmemleak_test.c                     | 45 ++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 mm/kmemleak_test.c
>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index ce18119ea0d0..da967a87eb78 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332    common  statx                   sys_statx
>  333    common  io_pgetevents           sys_io_pgetevents
>  334    common  rseq                    sys_rseq
> +335    common  kmemleak_test           sys_kmemleak_test
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424    common  pidfd_send_signal       sys_pidfd_send_signal
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 050511e8f1f8..0602308aabf4 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1029,6 +1029,7 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
>                           unsigned mask, struct statx __user *buffer);
>  asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
>                          int flags, uint32_t sig);
> +asmlinkage long sys_kmemleak_test()
>  asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
>  asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
>                                int to_dfd, const char __user *to_path,
> diff --git a/mm/Makefile b/mm/Makefile
> index bf71e295e9f6..878783838fa1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -97,7 +97,7 @@ obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
>  obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
>  obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
> -obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
> +obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o kmemleak_test.o
>  obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
>  obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
>  obj-$(CONFIG_PAGE_OWNER) += page_owner.o
> diff --git a/mm/kmemleak_test.c b/mm/kmemleak_test.c
> new file mode 100644
> index 000000000000..828246e20b7f
> --- /dev/null
> +++ b/mm/kmemleak_test.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/sched.h>
> +#include <linux/syscalls.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +
> +struct kmemleak_check {
> +       unsigned long canary;
> +       struct work_struct work;
> +       struct page **pages;
> +};
> +
> +static void work_func(struct work_struct *work)
> +{
> +       struct page **pages;
> +       struct kmemleak_check *ptr;
> +
> +       set_current_state(TASK_INTERRUPTIBLE);
> +       schedule_timeout(3600*HZ);
> +
> +       ptr = container_of(work, struct kmemleak_check, work);
> +       pages = ptr->pages;
> +       __free_page(pages[0]);
> +       kvfree(pages);
> +}
> +
> +SYSCALL_DEFINE0(kmemleak_test)
> +{
> +       struct page **pages, *page;
> +       struct kmemleak_check *ptr;
> +
> +       pages = kzalloc(sizeof(*pages), GFP_KERNEL);
> +       page = alloc_page(GFP_KERNEL);
> +       pages[0] = page;
> +       ptr = page_address(page);
> +       ptr->canary = 0x00FF00FF00FF00FF;
> +       ptr->pages = pages;
> +       pr_info("DEBUG: pages %px page %px ptr %px\n", pages, page, ptr);
> +
> +       INIT_WORK(&ptr->work, work_func);
> +       schedule_work(&ptr->work);
> +
> +       return 0;
> +}
> --
> 2.30.2
>
