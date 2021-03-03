Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7231832BE3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbhCCRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380706AbhCCN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:29:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E5C06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:28:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s16so14029580plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDH7lgjRH5u3RTqXMq5Tl04VvG/bzdMWK3DmgGuHjNg=;
        b=bazKNP9smhGB0AaA3ZgST/1l2rLawqsYZX+v6I4r9lrS8ig/5GAQoWRLViI7EZf1sY
         y7PTVw012LS0dGujFogrqhAWzA2YAuxRwfJP4pzs+mnb/mJK/Df3OnvAd3115XKogSdv
         i4BQ92i9aL6wzN5TtptJuew9+X2mIWnnu2b3KlRnoL6azIjyUlgw1BT6AoClmmfqOWb7
         DHUhVdJJn9iwnSj951+gBTJrgMTla6tqo/rmI/NM/gtuETmNJ7TleDB8TTTzdfuUw6yn
         OaFaUMcPnyuFQgEy9QilQwkmmJnCsqRVi63N4hKP6JxiztStR28iXv8mmA8T28RcqGoN
         VxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDH7lgjRH5u3RTqXMq5Tl04VvG/bzdMWK3DmgGuHjNg=;
        b=oYhJOc8tYaRZhBxEqyqcr06y3OOzyAdmUxBDohnrC3dvIQ/ZkDpvFTbQMwAhaopKLH
         ruVQa8W3Hbt689PwZDpwozISKS0NcikaUrIFGr78SlsSUyiQAn7NR+0FcfcPJM9w/6s1
         EKy5xulVPrXJ1ovffxbxtm7ffIUjVSCWHoTKjn81nfxCeXyFJF6zCOJyclI9OVKE27Nw
         XjliqzJDlMKJloIrcDLMQDFkpSCgWsx0uL7T2BAZBXVZ9ZXw9jGZApactYou4qObaeCH
         8R38PHJ6MpVcgqRrhbWQolhrFoE1+QHZ0uokR7plDUi+wAp711cyNUWAV6NxlRR5FBU1
         NI5g==
X-Gm-Message-State: AOAM533H0YBmaeFHYTqyLQdpdlZMZd22NbGUwyWZN9pTRD72bywBmXtj
        FqZhHwkyTOyUZQFNhQkqzdZdRImDMhBTQlkr+pG8sA==
X-Google-Smtp-Source: ABdhPJw0LwArSdnvTDr+Hc6zokLHVmsmS5LG8oVeZyn9/01/gqylWDQXxsUWCHfelRedXOK5pHQY8aBf6SPZcfd4/Uw=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr9402005pjk.229.1614778081078;
 Wed, 03 Mar 2021 05:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20210303093956.72318-1-songmuchun@bytedance.com> <YD9kCLlckn9evWuw@dhcp22.suse.cz>
In-Reply-To: <YD9kCLlckn9evWuw@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 3 Mar 2021 21:27:24 +0800
Message-ID: <CAMZfGtVdU9KWD8U_0CbctMpYo5SbzJEW2pSa1Qdr9tFcwaWcoQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: fix kernel stack account
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 6:25 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 03-03-21 17:39:56, Muchun Song wrote:
> > For simplification 991e7673859e ("mm: memcontrol: account kernel stack
> > per node") has changed the per zone vmalloc backed stack pages
> > accounting to per node. By doing that we have lost a certain precision
> > because those pages might live in different NUMA nodes. In the end
> > NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
> > some nodes while underestimated on others.
> >
> > This doesn't impose any real problem to correctnes of the kernel
> > behavior as the counter is not used for any internal processing but it
> > can cause some confusion to the userspace.
>
> You have skipped over one part of the changelog I have proposed and that
> is to provide an actual data.

Because this is a problem I found by looking at the code, not a real world
problem. I do not have any actual data. :-(

>
> > Address the problem by accounting each vmalloc backing page to its own
> > node.
> >
> > Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
>
> Fixes tag might make somebody assume this is worth backporting but I
> highly doubt so.

OK. I can remove the Fixes tag.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Anyway
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for your review.

>
> as the patch is correct with one comment below
>
> > ---
> > Changelog in v2:
> >  - Rework commit log suggested by Michal.
> >
> >  Thanks to Michal and Shakeel for review.
> >
> >  kernel/fork.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index d66cd1014211..6e2201feb524 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
> >       void *stack = task_stack_page(tsk);
> >       struct vm_struct *vm = task_stack_vm_area(tsk);
> >
> > +     if (vm) {
> > +             int i;
> >
> > -     /* All stack pages are in the same node. */
> > -     if (vm)
> > -             mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> > -                                   account * (THREAD_SIZE / 1024));
> > -     else
> > +             BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
>
> I do not think we need this BUG_ON. What kind of purpose does it serve?

vm->nr_pages should be always equal to THREAD_SIZE / PAGE_SIZE
if the system is not corrupted. It makes sense to remove the BUG_ON.
I will remove it in the next version. Thanks.

>
> > +
> > +             for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +                     mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
> > +                                           account * (PAGE_SIZE / 1024));
> > +     } else {
> > +             /* All stack pages are in the same node. */
> >               mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
> >                                     account * (THREAD_SIZE / 1024));
> > +     }
> >  }
> >
> >  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
