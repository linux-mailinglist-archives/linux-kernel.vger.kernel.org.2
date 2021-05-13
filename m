Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4E37F51C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhEMJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhEMJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:56:30 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 02:55:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o21so23997221iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQjtHIN8DD1GRyqL6npu5iRZFcZfv7jbqOPudBmj234=;
        b=KR571OjfjGRU7EPduxHdCzsp8zyXDadZglBKAgsHugklZvh6uUF7ETCczN0zdkkLFb
         FJtsw+mH+T8jpmA2TqknhDcWZ7+SPVrJWD73+fzpLLWX9xczUI0VlzIcEerqooXWRK0V
         jtkw0tPtkvr2i6ej6/OdYtMibeM+JcFoX2SgDRW17xL/WNjNFFrdaYe/N/mD7twyZCCX
         n1ViNvLlMoTu8K3V4a/r44c3DRDruPlw0ont/lm3+CwzgK+nsqABFhF2ESe86ueelit8
         nqQ60ovdw7PPXPSYVweTvqacqRxGnO1hjWNEHbg4slc7dx4e1ERA0yrwtEiZIJAyR9w6
         7QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQjtHIN8DD1GRyqL6npu5iRZFcZfv7jbqOPudBmj234=;
        b=qca2MPZdiQMPBIjcQ25G0iY4Q3iTFXVzMUxxGXIlQIERj/4VZxJhyL6B9nnKT2adr1
         Vq4U5vjUYjYhylcO7i162UcPC+wu99Pr5fph6SUC4c98dkqNxiGkLf6iSAQgbL6aeewf
         OScdYdZni6X4VjM2W3lDsJVwpewCxF67sdn4XijIBWMicJIoplATRuU/NzIXqPlp272T
         i4a+2K+kEPmShSQu9HEUslmdSP6E4cVm+SAbXNHIZUHIe7p7kbVtPF4YFGXTNE79t3Gj
         7lbO4QfwHLcVBeMEJZD4AtObCxyHHrvEFScCSVOymnLQMgp972boF4In7aGk0aayXrG8
         Z6fw==
X-Gm-Message-State: AOAM531kOplZnozlwt72vUiAczFZsmX3xezyennsZ7M1nEu93ZLKbtZv
        AILDTi/Yi9LafT/RzE77OmDcK9Oc/nq14ykINVY=
X-Google-Smtp-Source: ABdhPJytuc/g1Ce6PPopObf0K4vYWWrUyaS/62Xlt/kuREkWqv+7arg44dPMsMv5HP9fCA4606DhLa26FZGnJPQjJs8=
X-Received: by 2002:a5d:8506:: with SMTP id q6mr13633247ion.11.1620899719619;
 Thu, 13 May 2021 02:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210513064837.3949064-1-ying.huang@intel.com> <176421ba-77d9-8422-21e0-b5e2951533bd@huawei.com>
In-Reply-To: <176421ba-77d9-8422-21e0-b5e2951533bd@huawei.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 13 May 2021 17:54:42 +0800
Message-ID: <CAPSr9jEtdSgr5kDX=ESUrVtbuonUNEeFsOHpYYoFxD3PQ20C2A@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in swap_type_to_swap_info()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 5:11 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/5/13 14:48, Huang Ying wrote:
> > Before commit c10d38cc8d3e ("mm, swap: bounds check swap_info array
> > accesses to avoid NULL derefs"), the typical code to reference the
> > swap_info[] is as follows,
> >
> >   type = swp_type(swp_entry);
> >   if (type >= nr_swapfiles)
> >           /* handle invalid swp_entry */;
> >   p = swap_info[type];
> >   /* access fields of *p.  OOPS! p may be NULL! */
> >
> > Because the ordering isn't guaranteed, it's possible that "p" is read
> > before checking "type".  And that may result in NULL pointer
> > dereference.
> >
> > So in commit c10d38cc8d3e, the code becomes,
> >
> >   struct swap_info_struct *swap_type_to_swap_info(int type)
> >   {
> >         if (type >= READ_ONCE(nr_swapfiles))
> >                 return NULL;
> >         smp_rmb();
> >         return READ_ONCE(swap_info[type]);
> >   }
> >
> >   /* users */
> >   type = swp_type(swp_entry);
> >   p = swap_type_to_swap_info(type);
> >   if (!p)
> >         /* handle invalid swp_entry */;
> >   /* access fields of *p */
> >
> > Because "p" is checked to be non-zero before dereference, smp_rmb()
> > isn't needed anymore.
> >
> > We still need to guarantee swap_info[type] is read before dereference.
> > That can be satisfied via the data dependency ordering of
> > READ_ONCE(swap_info[type]).  The corresponding smp_wmb() is adjusted
> > in alloc_swap_info() too.
> >
> > And, we don't need to read "nr_swapfiles" too.  Because if
> > "type >= nr_swapfiles", swap_info[type] will be NULL.  We just need
> > to make sure we will not access out of the boundary of the array.
> > With that change, nr_swapfiles will only be accessed with swap_lock
> > held, except in swapcache_free_entries().  Where the absolute
> > correctness of the value isn't needed, as described in the comments.
> >
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/swapfile.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 2aad85751991..4c1fb28bbe0e 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
> >
> >  static struct swap_info_struct *swap_type_to_swap_info(int type)
> >  {
> > -     if (type >= READ_ONCE(nr_swapfiles))
> > +     if (type >= MAX_SWAPFILES)
> >               return NULL;
> >
> > -     smp_rmb();      /* Pairs with smp_wmb in alloc_swap_info. */
> > +     /*
> > +      * The data dependency ordering from the READ_ONCE() pairs
> > +      * with smp_wmb() in alloc_swap_info() to guarantee the
> > +      * swap_info_struct fields are read after swap_info[type].
> > +      */
> >       return READ_ONCE(swap_info[type]);
> >  }
> >
> > @@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
> >       }
> >       if (type >= nr_swapfiles) {
> >               p->type = type;
> > -             WRITE_ONCE(swap_info[type], p);
> > -             /*
> > -              * Write swap_info[type] before nr_swapfiles, in case a
> > -              * racing procfs swap_start() or swap_next() is reading them.
> > -              * (We never shrink nr_swapfiles, we never free this entry.)
> > -              */
> > +             /* Paired with READ_ONCE() in swap_type_to_swap_info() */
> >               smp_wmb();
>
> Many thank for your patch. The patch looks fine to me. There is one question:
>
> There is no smp_rmb() paired with above smp_wmb(). What is this smp_wmb() used for ?
> Could you please have a explanation ?

The comment is very clear, it matches READ_ONCE() which implies a
data dependence barrier on some archs.

Thanks.

>
> Thanks again!
>
> > -             WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> > +             WRITE_ONCE(swap_info[type], p);
> > +             nr_swapfiles++;
> >       } else {
> >               defer = p;
> >               p = swap_info[type];
> >
>
