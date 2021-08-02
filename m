Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FC3DE061
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhHBUF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:05:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A5C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 13:05:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p38so20914356lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HB3dfAanD6v/DibZ+Kd9MP5PZZX+18PKh7cDBPxAeHs=;
        b=ptyOG8hVKeJFevLxjCDUGzEhuSpZVEdMhDg+ywQnIWCracEKgYNJi9MyuD507zg3Eq
         doKw0YYpy3+9o+JFlSBQTwidtTbAq/pCC0+1OUtEuGXvon5JYsygoPX6N6QUxPNwLecd
         dGRPriNZp5jImD5F5U8MlOwLn3i0kGKTMQu8TVzPmTftKU/9lo7bbqVTkkpuKAx/PUSW
         jiBeP+zM1R/b4geXHK+h+upY1oHpTKGY01BvxD0hnkWN9TGqJgSlpJHuDvg7R3BlOky5
         4GgMumBWGK6P4QfI9acGmi0hXOcdxN3Gy+//oD79tKf96Yi5qkwrLtvtQy4dYRne726K
         qBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB3dfAanD6v/DibZ+Kd9MP5PZZX+18PKh7cDBPxAeHs=;
        b=VZA2ELGLaz98TEcP4vEXvZc2jsanJzfGbDRx3921khSnP/0WFMXyXLpgvKS7ocZVG1
         4r0yPsVEYRSTKmnyrwJh1LBFElG2Dcz84uCF6TXyq9J1qTRS6joQVGYL0y9Xe9ucGIhs
         tdwzcb7cdzjJA8Z7z7Rvg7quVVN0haluuSEWfqmvjaI8fETa3jM6qeSA7da27F1l1+Ve
         bj8mceRE6CZP+3iiEFaq+n9/hA4qjQ1PMVTROPSL6XVtfTJx0cRfaCL1CRVlRJSzJgf+
         FerBQ2OMbAI5GuY9RVjgR4B9pMSJH6JYIRyQggwjWkPu5VRBY2Q7vvxeF4tdux0BUKtQ
         9EJg==
X-Gm-Message-State: AOAM53149FEbOfv3mzL+WOI31/8vj5Cw7aUyp/EQe67/3hMLaUTfiG9e
        01lFYPn0RSnZDh+vpJNdz+CPKfkC3+pZnZObHz/CVQ==
X-Google-Smtp-Source: ABdhPJw8jY5UdHR872LonjGRIaliKSNWHXm1Rd2gXr1lTdg2PAg9+PKcz61b46s8PaG0GQQyveidYUX3SYA87Pal2eA=
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr14088907lfu.299.1627934714208;
 Mon, 02 Aug 2021 13:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com>
 <YP5jyLeYsN3JtdX8@dhcp22.suse.cz> <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
 <CAJuCfpHObuK7jOcqdme9fU5=zFoteaY+5f2_uKdW0VQJa6H7OQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHObuK7jOcqdme9fU5=zFoteaY+5f2_uKdW0VQJa6H7OQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Aug 2021 13:05:03 -0700
Message-ID: <CALvZod7-0zra65jTUUYx6Oi17GPbRtHpAtVysiTX4_=bfqthPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 12:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Jul 26, 2021 at 6:44 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > [...]
> > >
> > > Is process_mrelease on all of them really necessary? I thought that the
> > > primary reason for the call is to guarantee a forward progress in cases
> > > where the userspace OOM victim cannot die on SIGKILL. That should be
> > > more an exception than a normal case, no?
> > >
> >
> > I am thinking of using this API in this way: On user-defined OOM
> > condition, kill a job/cgroup and unconditionally reap all of its
> > processes. Keep monitoring the situation and if it does not improve go
> > for another kill and reap.
> >
> > I can add additional logic in between kill and reap to see if reap is
> > necessary but unconditionally reaping is more simple.
> >
> > >
> > > > An alternative would be to have a cgroup specific interface for
> > > > reaping similar to cgroup.kill.
> > >
> > > Could you elaborate?
> > >
> >
> > I mentioned this in [1] where I was thinking if it makes sense to
> > overload cgroup.kill to also add the SIGKILLed processes in
> > oom_reaper_list. The downside would be that there will be one thread
> > doing the reaping and the syscall approach allows userspace to reap in
> > multiple threads. I think for now, I would go with whatever Suren is
> > proposing and we can always add more stuff if need arises.
> >
> > [1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/
>
> Hi Folks,
> So far I don't think there was any request for further changes.
> Anything else you would want me to address or are we in a good shape
> wrt this feature?
> If so, would people who had a chance to review this patchset be
> willing to endorse it with their Reviewed-by or Acked-by?

I think with Michal's suggestion to use a killable mmap lock, at least
I am good with the patch.
