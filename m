Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562AC334980
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhCJVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhCJVIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD161C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:08:37 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e2so27466057ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cACQQWqG6uSUB0AGVgSEUJ4B4wJ68O5aodDpa+9zBtE=;
        b=TD528uq6ivKl36WWTHHJw/09uqZOROwIWdNmdS7C/SQIUBmkTfKhrO3WhbTLpi33Yd
         vuzVI3zn01/vbNvVSS7s3JCGNhdSLUnX4pS92ZzArfy2HjSDolAGYai4Jowj8xedrtfs
         eitt16XYmZB2QuyFScmS+Csnw4EKgfOJHbj1r3zXYVHmlKWe1KBfJuluPCM6x6k7jZeq
         lgJmr+miho41dvdhpIhRa74hCa1QCr43YSd3z2Y3mnLiQwIidUERKBWZ+yb/ADP6nUrs
         wAcohDBJp8TJG4bfM3LEzMEhLB6H+lFG2/I4WxbkON4RTUt5666MAekU7kQdmpUNO6Yp
         nhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cACQQWqG6uSUB0AGVgSEUJ4B4wJ68O5aodDpa+9zBtE=;
        b=O0rEj0ad5c+1LWso/j01E3WCKjhtH1uFVZOnujFdDK8sn/cY1i9tO4oGeTuaI4588i
         Ivdu5svvFctSSEoPcVoPK3PLLz/bJA/ubcoXEjzlOUnlouvdplZZsisJ1IQikFcXzwzQ
         o2MhAiUHR4R7mFxrYC8AO6BMxYf/VgS8pW46oGEYW3lSuMNlN4j6INz4P5EFuCMLY6vu
         lwRUs6YjT+LTRPuHQG7qZuCMw5fDmeMn9rpdup0/Ro4jwo74MkvlUdiJ4gZBIIlmA7PB
         DP8zpl42J5waqM3wKtA1zTYvmatj1QQzT/+tnECGj/dp9AIMp1gX7F+L/wb4x5N8BMeR
         97Ug==
X-Gm-Message-State: AOAM531W5o2TQ23tkazczVSk5yVY6km1IJPv2/Ah0rrE9B8C8RqyMrkg
        cXKOVkExB88AicLIt8ftWYVKqqKww5O74oeDhsrs7Q==
X-Google-Smtp-Source: ABdhPJziZrjBJ9Z8nbqy4riATwMtJzR2H3vO3xCUy6/+X/e3KusmZB2RF4BFcfabm3GgOq/lDz2ZuH4ze1WXtxxMN9U=
X-Received: by 2002:a2e:8984:: with SMTP id c4mr2796500lji.456.1615410516228;
 Wed, 10 Mar 2021 13:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
 <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com> <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com>
In-Reply-To: <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Mar 2021 13:08:24 -0800
Message-ID: <CALvZod4hSCBsXPisPT_Tai3kHW1Oo5k8z2ihbSgmLsMTAqWGHg@mail.gmail.com>
Subject: Re: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:54 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 10:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > The number of deferred objects might get windup to an absurd number, and it
> > > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> > >
> > > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > > of cache items.
> > >
> > > The idea is borrowed from Dave Chinner's patch:
> > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> > >
> > > Tested with kernel build and vfs metadata heavy workload in our production
> > > environment, no regression is spotted so far.
> >
> > Did you run both of these workloads in the same cgroup or separate cgroups?
>
> Both are covered.
>

Have you tried just this patch i.e. without the first 12 patches?
