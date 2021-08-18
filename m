Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9712F3F0596
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhHROEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHROED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:04:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE07C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:03:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f3so1884759plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyfgTz31jIoE/VzeLJ6bbGKKwb7DabZop86TVccOrFg=;
        b=f9XBD3jCZEJ2rtp4sCp1JGj839FtMrospr+c3s+/a9f65fHGyfnfO+ghnkWiPtKIUB
         bcpoE+lJi9CZwzlbLFuC5a8mwQCKoCoiLBxefg6pIWUIohSFC4v9vHuKUcNZw5tR/Tjj
         ypW2NH2xpOe3hp18dfl0b8EQ9tQymWX1HvD4AM6aX4pwLIFuwEj5qbwrcypveVb6Bo0o
         SC8EGwDqHwkP52w+h4FR2xvm0B/uRDcZ/nxzh/Jxx/AuSjQHisrWGRcVzi1A7ON4xLMZ
         i8ghLc7ep4D90NyVUQ6LxL2S7syPck2/ScmY/8IcgTj1svtwXHoNsvQjuy6Mv0hmV+Om
         dRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyfgTz31jIoE/VzeLJ6bbGKKwb7DabZop86TVccOrFg=;
        b=KqV6/kb3QC0W5keqf0eCT+fo/5JDzl6PeDPd6kovFBV84873SWCUbQWen5FvAdsHXi
         7xyz1/bCHWyeLFTJsvtcCVI7vk7u/g/mAw1C7NKd3Sec1Ktcs6CyWDPma74ex887ZFm8
         TgzhgBPN9jX1ZtrjaY9M06gWMzoz+EKyZc6UOZG8MXpE9NjeUZqtzhAa0ivLTNvSSXKH
         uCEKs26kcGk3yU0puaEzp/mVX1uNOWCws4VbHtIZdUDBHDkWa12FvupVbeX01EL5Axl+
         P7K74ErbshUkLZvU3HjL7X+lrfrrOAOBXK9bikESRJHVTQCKV+sdGPc3RwIAzS6hE7BE
         uhSA==
X-Gm-Message-State: AOAM531rGxBP7nHAA1zRgbLmYSkJnkXAX6mh9nVwcHVlnCRCZExZwbGh
        5IbYcGgzj74aZKIu7EWmd6ymlgOt5PhD4DvXS29JWw==
X-Google-Smtp-Source: ABdhPJxGN+ErQhya2YsMZ8CPa5uh9a1MQuh9q6ZDiRbcl3dBImZP6mWT2c0ZBA0Ixmae+dv4bqmJOjkYbIfKNjrt0L8=
X-Received: by 2002:a17:90a:eb17:: with SMTP id j23mr9533359pjz.229.1629295408051;
 Wed, 18 Aug 2021 07:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210815061034.84309-1-yanghui.def@bytedance.com>
 <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org> <YRsULowKJtUKJhJ+@casper.infradead.org>
In-Reply-To: <YRsULowKJtUKJhJ+@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Aug 2021 22:02:46 +0800
Message-ID: <CAMZfGtVNJxTw-TPXHGF0kCwYMQK8hVG6=Z+hE3yuQRZh6ak-mw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and mpol_rebind_task
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        yanghui <yanghui.def@bytedance.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 9:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 16, 2021 at 05:59:52PM -0700, Andrew Morton wrote:
> > On Sun, 15 Aug 2021 14:10:34 +0800 yanghui <yanghui.def@bytedance.com> wrote:
> >
> > > Servers happened below panic:
> > > Kernel version:5.4.56
> > > BUG: unable to handle page fault for address: 0000000000002c48
> > > RIP: 0010:__next_zones_zonelist+0x1d/0x40
> > > [264003.977696] RAX: 0000000000002c40 RBX: 0000000000100dca RCX: 0000000000000014
> > > [264003.977872] Call Trace:
> > > [264003.977888]  __alloc_pages_nodemask+0x277/0x310
> > > [264003.977908]  alloc_page_interleave+0x13/0x70
> > > [264003.977926]  handle_mm_fault+0xf99/0x1390
> > > [264003.977951]  __do_page_fault+0x288/0x500
> > > [264003.977979]  ? schedule+0x39/0xa0
> > > [264003.977994]  do_page_fault+0x30/0x110
> > > [264003.978010]  page_fault+0x3e/0x50
> > >
> > > The reason of panic is that MAX_NUMNODES is passd in the third parameter
> > > in function __alloc_pages_nodemask(preferred_nid). So if to access
> > > zonelist->zoneref->zone_idx in __next_zones_zonelist the panic will happen.
> > >
> > > In offset_il_node(), first_node() return nid from pol->v.nodes, after
> > > this other threads may changed pol->v.nodes before next_node().
> > > This race condition will let next_node return MAX_NUMNODES.So put
> > > pol->nodes in a local variable.
> > >
> > > The race condition is between offset_il_node and cpuset_change_task_nodemask:
> > > CPU0:                                     CPU1:
> > > alloc_pages_vma()
> > >   interleave_nid(pol,)
> > >     offset_il_node(pol,)
> > >       first_node(pol->v.nodes)            cpuset_change_task_nodemask
> > >                       //nodes==0xc          mpol_rebind_task
> > >                                               mpol_rebind_policy
> > >                                                 mpol_rebind_nodemask(pol,nodes)
> > >                       //nodes==0x3
> > >       next_node(nid, pol->v.nodes)//return MAX_NUMNODES
> > >
> > >
> > > ...
> > >
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -1965,17 +1965,26 @@ unsigned int mempolicy_slab_node(void)
> > >   */
> > >  static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
> > >  {
> > > -   unsigned nnodes = nodes_weight(pol->nodes);
> > > -   unsigned target;
> > > +   nodemask_t nodemask = pol->nodes;
> >
> > Ouch.  nodemask_t can be large - up to 128 bytes I think.  This looks
> > like an expensive thing to be adding to fast paths (alloc_pages_vma()).
>
> Copying a fixed-size 128 bytes to the stack isn't going to be _that_
> expensive.
>
> > Plus it consumes a lot of stack.
>
> alloc_pages_vma() tends to be a leaf function, so not that bad.
>
> > > +   unsigned int target, nnodes;
> > >     int i;
> > >     int nid;
> > > +   /*
> > > +    * The barrier will stabilize the nodemask in a register or on
> > > +    * the stack so that it will stop changing under the code.
> > > +    *
> > > +    * Between first_node() and next_node(), pol->nodes could be changed
> > > +    * by other threads. So we put pol->nodes in a local stack.
> > > +    */
> > > +   barrier();
>
> I think this could be an smp_rmb()?

Hi Matthew,

I have a question. Why is barrier() not enough?

Thanks.

>
> > > +   nnodes = nodes_weight(nodemask);
> > >     if (!nnodes)
> > >             return numa_node_id();
> > >     target = (unsigned int)n % nnodes;
> > > -   nid = first_node(pol->nodes);
> > > +   nid = first_node(nodemask);
> > >     for (i = 0; i < target; i++)
> > > -           nid = next_node(nid, pol->nodes);
> > > +           nid = next_node(nid, nodemask);
> > >     return nid;
> > >  }
> >
> > The whole idea seems a bit hacky and fragile to be.  We're dealing with
> > a potentially stale copy of the nodemask, yes?
>
> Correct.  Also potentially a nodemask in the middle of being changed,
> so it may be some unholy amalgam of previous and next.
>
> > Ordinarily this is troublesome because there could be other problems
> > caused by working off stale data and a better fix would be to simply
> > avoid using stale data!
> >
> > But I guess that if the worst case is that once in a billion times,
> > interleaving hands out a page which isn't on the intended node then we
> > can live with that.
> >
> > And if this guess is correct and it is indeed the case that this is the
> > worst case, can we please spell all this out in the changelog.
>
> I think that taking a lock here is worse than copying to the stack.
> But that seems like the kind of thing that could be measured?
>
> I don't think that working off stale / amalgam data is a bad thing,
> we only need consistency.  This is, after all, interleaved allocation.
> The user has asked for us, more or less, to choose a node at random to
> allocate from.
>
> What ruffles my feathers more is that we call next_node() up to n-2 times,
> and on average (n-1)/2 times (where n is the number of permitted nodes).
> I can't help but feel that we could do better to randomly distribute
> pages between nodes.  Even having a special case for all-bits-set or
> n-contiguous-bits-set-and-all-other-bits-clear would go a long way to
> speed this up.
>
> I don't know if anyone has a real complaint about how long this takes
> to choose a node, though.  I'm loathe to optimise this without data.
