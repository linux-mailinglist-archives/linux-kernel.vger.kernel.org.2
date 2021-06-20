Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0693ADE35
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFTLqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFTLqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:46:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:44:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i24so4307578edx.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNS466MM1+gmAZ7m5R3iU35irMmXL7Fyl0Gd5MfDyU0=;
        b=V8xhXvADThnRUl5Z/GN4V7kkWVMOh21CEhMCxPhPk4pXpdj2pBkXN64CNh0jfRqWa+
         TQNkMLrqkB97dWasSKYAK0qyI7S4qFanRdOk+ceL7C1ppmTbU1IGd+5qrw1t1tMlbImv
         e1aSkBkhsg2npBnTSUrnko9JPp1TsWbR94GBB1F9RdsXC/X41VM2epBeXK7I0LDpPlPX
         ndG0+CC6y3a1iQbj+vaDRtz9bsGv6BIBTCXOf6BSyZ3Bnp/3kJ4kZl7Ful4oOAanVxc2
         olTBuT9h3GZ43bnCbok7n39Tnr5BY/+tPd5I4gE4MVBpn6R78S/c/ayN4yw52l0OHg1A
         qlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNS466MM1+gmAZ7m5R3iU35irMmXL7Fyl0Gd5MfDyU0=;
        b=dZ14qknpafdw3uvIwD0wrNS6P0+tY1CRuOtHCuP4chfcqJznTuvZe87O7+BkDuFGQU
         +FyiUVJOxP6Q9ctQPOez1HZOvidIJ/kbYesASMwXQpfWCxG6x0m+tAna8XAl1B5CIa3P
         TybVQ+SlIf1bOFIsHWXm2lMNXGD9UXTIviHe15mQLTyVebpIXJc37iig0M3BzwP9G38g
         qZ8esGRr9z15fBPxh14s3y9E/17Rb4q7Mf27FGfUbYswbYtaBKBaKARWwXLhaTY25nqk
         XX+6FaLmEQvSE7zl1pI4XCK0QDQ4Fu7ELt277O6wUraavScQ4my7z6ZUKRvMXCPL9YGV
         pIxg==
X-Gm-Message-State: AOAM530mXhi70JBw8hV+gpkdgdb2F59kLcgIKqashTRGsCmNs7fxk1KJ
        8SHMOI3SmvONdGZm8TKSjKFLrK6hfGBbsnRzdAwUonXez7E=
X-Google-Smtp-Source: ABdhPJwZjNrZTIvdI6NdVI0nQr4uYCujxGI5gRMvVK3EfKSSc6HFukplCGZSgfO7e4M8bVEaHDNoRjvVYb/P55Iq9mY=
X-Received: by 2002:a05:6402:1d11:: with SMTP id dg17mr2680200edb.30.1624189476065;
 Sun, 20 Jun 2021 04:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210617081330.98629-1-dja@axtens.net>
In-Reply-To: <20210617081330.98629-1-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Jun 2021 14:44:17 +0300
Message-ID: <CA+fCnZcV3F5xMtvu6n=w9PKRfuJf5v80M8kenkmMv4gb5+btnQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: unbreak kasan vmalloc support
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:13 AM Daniel Axtens <dja@axtens.net> wrote:
>
> In commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> __vmalloc_node_range was changed such that __get_vm_area_node was no
> longer called with the requested/real size of the vmalloc allocation, but
> rather with a rounded-up size.
>
> This means that __get_vm_area_node called kasan_unpoision_vmalloc() with
> a rounded up size rather than the real size. This led to it allowing
> access to too much memory and so missing vmalloc OOBs and failing the
> kasan kunit tests.
>
> Pass the real size and the desired shift into __get_vm_area_node. This
> allows it to round up the size for the underlying allocators while
> still unpoisioning the correct quantity of shadow memory.
>
> Adjust the other call-sites to pass in PAGE_SHIFT for the shift value.
>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213335
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  mm/vmalloc.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index aaad569e8963..3471cbeb083c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2362,15 +2362,16 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
>  }
>
>  static struct vm_struct *__get_vm_area_node(unsigned long size,
> -               unsigned long align, unsigned long flags, unsigned long start,
> -               unsigned long end, int node, gfp_t gfp_mask, const void *caller)
> +               unsigned long align, unsigned long shift, unsigned long flags,
> +               unsigned long start, unsigned long end, int node,
> +               gfp_t gfp_mask, const void *caller)
>  {
>         struct vmap_area *va;
>         struct vm_struct *area;
>         unsigned long requested_size = size;
>
>         BUG_ON(in_interrupt());
> -       size = PAGE_ALIGN(size);
> +       size = ALIGN(size, 1ul << shift);
>         if (unlikely(!size))
>                 return NULL;
>
> @@ -2402,8 +2403,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
>                                        unsigned long start, unsigned long end,
>                                        const void *caller)
>  {
> -       return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
> -                                 GFP_KERNEL, caller);
> +       return __get_vm_area_node(size, 1, PAGE_SHIFT, flags, start, end,
> +                                 NUMA_NO_NODE, GFP_KERNEL, caller);
>  }
>
>  /**
> @@ -2419,7 +2420,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
>   */
>  struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
>  {
> -       return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> +       return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> +                                 VMALLOC_START, VMALLOC_END,
>                                   NUMA_NO_NODE, GFP_KERNEL,
>                                   __builtin_return_address(0));
>  }
> @@ -2427,7 +2429,8 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
>  struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
>                                 const void *caller)
>  {
> -       return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> +       return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> +                                 VMALLOC_START, VMALLOC_END,
>                                   NUMA_NO_NODE, GFP_KERNEL, caller);
>  }
>
> @@ -2949,9 +2952,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>         }
>
>  again:
> -       size = PAGE_ALIGN(size);
> -       area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
> -                               vm_flags, start, end, node, gfp_mask, caller);
> +       area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> +                                 VM_UNINITIALIZED | vm_flags, start, end, node,
> +                                 gfp_mask, caller);
>         if (!area) {
>                 warn_alloc(gfp_mask, NULL,
>                         "vmalloc error: size %lu, vm_struct allocation failed",
> @@ -2970,6 +2973,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>          */
>         clear_vm_uninitialized_flag(area);
>
> +       size = PAGE_ALIGN(size);
>         kmemleak_vmalloc(area, size, gfp_mask);
>
>         return addr;
> --
> 2.30.2
>

This fixes the vmalloc_oob test for me. Thank you, Daniel!

Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
