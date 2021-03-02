Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2540E32A3D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382635AbhCBJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382323AbhCBJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:25:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74057C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:24:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so1563754pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaaHr1FdPfn0LfAliQ+IVMh6j7CV9vE3i1cYH9AA51s=;
        b=1DKygOG8TqNSv78Da7/e2WKSu8WpZGVF1E9BqtDer81jwFyIJSY+s2obSBjq67ht+O
         +XpcPvQB8M+CdbjJEE40t1lfaA34KTYoI3dSllo6XX0WwasqE2SGbBZiebUsfDzk6pwT
         QoXRd/DgtdW3gNpK9gINpv0ItpNIr4bE6+v+ZgRr4uvsOjZ/yllkB48vMtr5hcjr6hxX
         HSRBwMX/s4jIXlVRUPLhBXKBxKj6NgJSSSm5e10oUwR2POOHbu3+BT6BIlAMlPEYBHbh
         S7PsshZ+W15WpqEsB/e6pqC2pXIdtIBoyI9CxYgNqapOgNU1jKSesuY1I9VIj1bsoRk7
         KQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaaHr1FdPfn0LfAliQ+IVMh6j7CV9vE3i1cYH9AA51s=;
        b=JTCcT0MB9Ftii3f2aofovQeJ2XjYPu6oqVfe28TJsq4iGn4F3ZbqdB13rG0odMI7s+
         RlXFGhedaI6CD49SLX4evp7C7WgPY7MfPRvwjsIPLxBL+bvlrBdgypfguwvekP6r7j0v
         Q7VH7nUS5RpS8781pegIHbdq4bVlnVHXswp1jhFZNTmifTo0LwSA+01AqtL6APY+/skT
         NT3IBO5yo8c9eVqDEtqNgs1QczIwJSofXV6LmwPlimHQjy4k2D/8jdCj3wHiHBstZixN
         8/NMoy7OemcU7ejRaXFoDFPYEh1MRo8WLuQWnX0iFlEZg0dLUoJIjkPhspVyGr8ilBV9
         YpOQ==
X-Gm-Message-State: AOAM5329uugveG0XQooWEoKxljJlu1bppxxuGwCTg3TAE5wf8Xn8YK0h
        TQcnVdLhSbf2PttKeg5I6ina17WCdGw//cH/QvXNSg==
X-Google-Smtp-Source: ABdhPJyJedaY846+qySN+sLQwRjoChumrNaJQgiaLavT8dqrelfnh0ydhHPI9JFjS+Tf9QI6CyZZ3FeaHAm3Lz7dyy4=
X-Received: by 2002:a17:902:e54e:b029:e3:9f84:db8e with SMTP id
 n14-20020a170902e54eb02900e39f84db8emr2686501plf.24.1614677059972; Tue, 02
 Mar 2021 01:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20210302073733.8928-1-songmuchun@bytedance.com> <YD36+i1PZX/CH1jf@dhcp22.suse.cz>
In-Reply-To: <YD36+i1PZX/CH1jf@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 2 Mar 2021 17:23:42 +0800
Message-ID: <CAMZfGtX=EmE8iOLfO3duCyMWOmu-OYra9Rk4mKsknds+5MueMg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix kernel stack account
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

On Tue, Mar 2, 2021 at 4:44 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 02-03-21 15:37:33, Muchun Song wrote:
> > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> > mod_lruvec_page_state() for each page one by one.
>
> What is the actual problem you are trying to address by this patch?
> 991e7673859e has deliberately dropped the per page accounting. Can you
> explain why that was incorrect? There surely is some imprecision
> involved but does it matter and is it even observable?

When I read the code of account_kernel_stack(), I see a comment that
says "All stack pages are in the same node". I am confused about this.
IIUC, there is no guarantee about this. Right? Yeah, imprecision may
not be a problem. But if this is what we did deliberately, I think that
it is better to add a comment there. Thanks.

>
> > Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
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
