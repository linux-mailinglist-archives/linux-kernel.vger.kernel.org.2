Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB543D2728
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhGVPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:18:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:59:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5780717otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFoiqBuewKwLijpRlkePQSSHPtlNuZZX3ekB9lmCZZI=;
        b=BpR31SsuvCrbfJ6UE8IP8oUtk+Qz7dxKXqfvXMUkSKRkIjT1dE8pKOdTHpWw0fkdVy
         j7ulxIZZ5yjJDUhQ/GaezCTwgPEAEb/o5Oy3oTqM7RXw05DhLvqJwxfT4S3t5jHUiEUY
         W0W4QiUpIMwNzOf0tQlPujKwtwK+WjVgRu9HLQYTjtZw3MrGX7IP/FMecjzifKZ/Ws26
         gybGSIn6daT1xw7tQDOECNLs8k1xhbLqeF3cTCaIL2fNymV6j+hYFtbIq/2u3E9bftXb
         jrd3H0t6nkJ2+QxX7mE9r0SIQLxL70VInTV8BPUoqb4Tyrfb7rb2NbtsYon0bz9yUce2
         YGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFoiqBuewKwLijpRlkePQSSHPtlNuZZX3ekB9lmCZZI=;
        b=BbhAbIfgk8RJv+YrsX3WAOJeRMeus6fW58SLMrSWYCtcqEPfdFf5FUxzJbbw/l+v79
         a5jIUd7fE0Cs5iCNL+Y9ztSem51xsfXFN451jB9piKSkR+oMZwEmfpBiCu7nKENLdpvj
         4fgIPlzHT7KMWFDm1MTbRQ+J0ukdk4n47xcWV6WKYn9AqFQ5AdpmgtxcX4L3z6jYZTFx
         kUOw9TCP2mhwHlTVbi+A/EsObac2KuzpADMOSbcxO3PMZ/7P1w48Yt1L3Hhtp97jrGjJ
         WH9L5LLYxc5ZiZFse+9gzyWhc9NwHO7ryTqNkON5sA06Ij7wsmJweec/jKXOPBceboVz
         ynLQ==
X-Gm-Message-State: AOAM531x8ImoIqMq7BcZeGPPJv+IwegwbqoK3pxiSZ0Fn5bRGIpghjB+
        PGgnnhUpOO2bzdbn5nJWCuo480XzoM2kNoJG+GBk5A==
X-Google-Smtp-Source: ABdhPJyRII4uOIv+Cd6Exsrc94DyHrLNwd6D1HNT8vXcWs33ZanyQ0fA0NOFwpGfnN+/FFxsuia1SF/8phqkODMAuok=
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr296363otq.86.1626969558998;
 Thu, 22 Jul 2021 08:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210721131320.522061-1-dima@arista.com>
In-Reply-To: <20210721131320.522061-1-dima@arista.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 22 Jul 2021 11:58:42 -0400
Message-ID: <CADyq12z+VCyx3ibBfrN-xveHgXQf4PbVRrVb_Ui_EE5y7qk+gw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mremap: Don't account pages in vma_to_resize()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:13 AM Dmitry Safonov <dima@arista.com> wrote:
>
> All this vm_unacct_memory(charged) dance seems to complicate the life
> without a good reason. Furthermore, it seems not always done right on
> error-pathes in mremap_to().
> And worse than that: this `charged' difference is sometimes
> double-accounted for growing MREMAP_DONTUNMAP mremap()s in move_vma():
> : if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
>
> Let's not do this.
> Account memory in mremap() fast-path for growing VMAs or in move_vma()
> for actually moving things. The same simpler way as it's done by
> vm_stat_account(), but with a difference to call
> security_vm_enough_memory_mm() before copying/adjusting VMA.
>
> Originally noticed by Chen Wandun:
> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Wandun <chenwandun@huawei.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  mm/mremap.c | 50 ++++++++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5989d3990020..b90c8e732e29 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -565,6 +565,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>                 bool *locked, unsigned long flags,
>                 struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
>  {
> +       long to_account = new_len - old_len;
>         struct mm_struct *mm = vma->vm_mm;
>         struct vm_area_struct *new_vma;
>         unsigned long vm_flags = vma->vm_flags;
> @@ -583,6 +584,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>         if (mm->map_count >= sysctl_max_map_count - 3)
>                 return -ENOMEM;
>
> +       if (unlikely(flags & MREMAP_DONTUNMAP))
> +               to_account = new_len;
> +
>         if (vma->vm_ops && vma->vm_ops->may_split) {
>                 if (vma->vm_start != old_addr)
>                         err = vma->vm_ops->may_split(vma, old_addr);
> @@ -604,8 +608,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>         if (err)
>                 return err;
>
> -       if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT)) {
> -               if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
> +       if (vm_flags & VM_ACCOUNT) {
> +               if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
>                         return -ENOMEM;
>         }
>
> @@ -613,8 +617,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>         new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
>                            &need_rmap_locks);
>         if (!new_vma) {
> -               if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT))
> -                       vm_unacct_memory(new_len >> PAGE_SHIFT);
> +               if (vm_flags & VM_ACCOUNT)
> +                       vm_unacct_memory(to_account >> PAGE_SHIFT);
>                 return -ENOMEM;
>         }
>
> @@ -708,8 +712,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  }
>
>  static struct vm_area_struct *vma_to_resize(unsigned long addr,
> -       unsigned long old_len, unsigned long new_len, unsigned long flags,
> -       unsigned long *p)
> +       unsigned long old_len, unsigned long new_len, unsigned long flags)
>  {
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma;
> @@ -768,13 +771,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>                                 (new_len - old_len) >> PAGE_SHIFT))
>                 return ERR_PTR(-ENOMEM);
>
> -       if (vma->vm_flags & VM_ACCOUNT) {
> -               unsigned long charged = (new_len - old_len) >> PAGE_SHIFT;
> -               if (security_vm_enough_memory_mm(mm, charged))
> -                       return ERR_PTR(-ENOMEM);
> -               *p = charged;
> -       }
> -
>         return vma;
>  }
>
> @@ -787,7 +783,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma;
>         unsigned long ret = -EINVAL;
> -       unsigned long charged = 0;
>         unsigned long map_flags = 0;
>
>         if (offset_in_page(new_addr))
> @@ -830,7 +825,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>                 old_len = new_len;
>         }
>
> -       vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
> +       vma = vma_to_resize(addr, old_len, new_len, flags);
>         if (IS_ERR(vma)) {
>                 ret = PTR_ERR(vma);
>                 goto out;
> @@ -853,7 +848,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>                                 ((addr - vma->vm_start) >> PAGE_SHIFT),
>                                 map_flags);
>         if (IS_ERR_VALUE(ret))
> -               goto out1;
> +               goto out;
>
>         /* We got a new mapping */
>         if (!(flags & MREMAP_FIXED))
> @@ -862,12 +857,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>         ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
>                        uf_unmap);
>
> -       if (!(offset_in_page(ret)))
> -               goto out;
> -
> -out1:
> -       vm_unacct_memory(charged);
> -
>  out:
>         return ret;
>  }
> @@ -899,7 +888,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma;
>         unsigned long ret = -EINVAL;
> -       unsigned long charged = 0;
>         bool locked = false;
>         bool downgraded = false;
>         struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> @@ -981,7 +969,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         /*
>          * Ok, we need to grow..
>          */
> -       vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
> +       vma = vma_to_resize(addr, old_len, new_len, flags);
>         if (IS_ERR(vma)) {
>                 ret = PTR_ERR(vma);
>                 goto out;
> @@ -992,10 +980,18 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         if (old_len == vma->vm_end - addr) {
>                 /* can we just expand the current mapping? */
>                 if (vma_expandable(vma, new_len - old_len)) {
> -                       int pages = (new_len - old_len) >> PAGE_SHIFT;
> +                       long pages = (new_len - old_len) >> PAGE_SHIFT;
> +
> +                       if (vma->vm_flags & VM_ACCOUNT) {
> +                               if (security_vm_enough_memory_mm(mm, pages)) {
> +                                       ret = -ENOMEM;
> +                                       goto out;
> +                               }
> +                       }

Wasn't this whole check already performed in vma_to_resize()?

>
>                         if (vma_adjust(vma, vma->vm_start, addr + new_len,
>                                        vma->vm_pgoff, NULL)) {
> +                               vm_unacct_memory(pages);
>                                 ret = -ENOMEM;
>                                 goto out;
>                         }
> @@ -1034,10 +1030,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>                                &locked, flags, &uf, &uf_unmap);
>         }
>  out:
> -       if (offset_in_page(ret)) {
> -               vm_unacct_memory(charged);
> +       if (offset_in_page(ret))
>                 locked = false;
> -       }
>         if (downgraded)
>                 mmap_read_unlock(current->mm);
>         else
> --
> 2.32.0
>
