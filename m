Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE63E32A7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839524AbhCBQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbhCBOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:11:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17CC0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:02:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q23so24050825lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GuKfB6VrIFzx0x2SM7SwFm03Ow2RDJwKRM+LEP4l/M=;
        b=Gu2DKChT3WpQASidqhk6P6Xr8vXUHC2t9v+bDGwlpA0n9fNIdsd9l+AihpBjywgMrl
         IEY/NeWktRbr7HoYpV/7yRH64DiFv/QbO6CFlzy0dfaS/LLwp+yKX/GjHG0Mx6uHFvCf
         CTLu0smjMYPDhzuAmZtGevSPlqyw8twxkqrKm6n+EtLfK9Rx01IJI0jeZd9qi+dDcZel
         uzmDGFyeLyzaTtpu2r7+iDLkmyHYVCa4eYnTs4qafO9AcNCmFuS3Vi5GEc2PioW0tqgA
         b60x8u93g2oYCRKFtGSnXGUbAOatkz3OloSUfyHY2QOxp/hV7o1BQgUI8pggzAm1sm8m
         afkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GuKfB6VrIFzx0x2SM7SwFm03Ow2RDJwKRM+LEP4l/M=;
        b=gocANgTQocvqwUnZS8peQOmF84iKdwHRIEANTVDjOiwN5Bv7mk7zNiVu8kSH4+RNhr
         XhXlX9YJywL1pPkzh4g5zzGGLoZBtQoAVLbra5LAENtWZTDpta40ZBUNHptFvuPvTtXn
         Xaax6P1G8wNMjifWxJK5pzC/OtIEToY7+KE0OErEFXFZLIs8WdbRU7TrZ6cxhUCirEho
         GWWdmk/IhXjEGwabjMRG62r8Q0uxxZpnErirpa/CuipSfT3CSxyi1NYUsg2gtS7a5Kqz
         wgK+cqv056SRjr5Mr58GRz6OxoWaxWiCeGaEhbEixxcSNDSHfvz1u9Ocp9EApIVqHwl0
         AvAg==
X-Gm-Message-State: AOAM531hboxipIL55wrX5vvVTH3KBcQEnoS/0Bg8MWespyN4tPXIZ3um
        5vMKiIwNeAmkdARMh+OmMBPV8fgSAxYmNl4j0Ske9g==
X-Google-Smtp-Source: ABdhPJz5wc4+6ewbi0o1MoTMX7hrvfY52o5zB/bj47oH7eR8wYl8CEFdM7rERXtqnVxXNG9pNXBtxAWA1qDSsWbZqk0=
X-Received: by 2002:a2e:8984:: with SMTP id c4mr6920315lji.456.1614693746481;
 Tue, 02 Mar 2021 06:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20210302073733.8928-1-songmuchun@bytedance.com>
In-Reply-To: <20210302073733.8928-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Mar 2021 06:02:14 -0800
Message-ID: <CALvZod6Aqq_yCjfdbgKb1=Ocd04O=X_tNJ81kzyX77wHzBKBwA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 11:52 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> __GFP_THISNODE to __vmalloc_node_range().

Instead of __GFP_THISNODE, mention that the kernel_clone() passes
NUMA_NO_NODE which is being used for __vmalloc_node_range().

> Fix it by caling

calling

> mod_lruvec_page_state() for each page one by one.
>
> Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Please follow Michal's suggestion to update the commit message.

After that:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  kernel/fork.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211..6e2201feb524 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>         void *stack = task_stack_page(tsk);
>         struct vm_struct *vm = task_stack_vm_area(tsk);
>
> +       if (vm) {
> +               int i;
>
> -       /* All stack pages are in the same node. */
> -       if (vm)
> -               mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> -                                     account * (THREAD_SIZE / 1024));
> -       else
> +               BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> +
> +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +                       mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
> +                                             account * (PAGE_SIZE / 1024));
> +       } else {
> +               /* All stack pages are in the same node. */
>                 mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>                                       account * (THREAD_SIZE / 1024));
> +       }
>  }
>
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> --
> 2.11.0
>
