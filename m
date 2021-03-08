Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41BB33191F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCHVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCHVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:11:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C1C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:11:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d3so23291665lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5NhGk9Ze+SQuaoK4vhROcGQTDpMP/SN4w2gJyziaiY=;
        b=QqI8pLqRynx4LJTYrKtttzBwMys2s8NV+Q05Mdn2do/eFnqWkiYXU9aAux/oSxBh00
         kCtcRrWovvyfev3yY8Ax6y7EcxMeQRRLm5cWV9+wckxu+xyWHO7E62N+KFS68jkWyvC+
         q6LcES7tS87j7CAWXnpsEWZJciZVVXhD8bc+6sz4GHtflsys1rX1v7g0wEUAhPTxCkEr
         nxIOWtyXlQIYUnMjG/JAkilvn/LeZPFaDtO8VClOeh3G1qXs1RAKEsDSorVbSUreI0+t
         J4nsJYoc/fpUfLXDXTEETYEs7j/Kwm0h/toueZtbyfBHdx3/vUwAczsvZXuSvAFvaypw
         nB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5NhGk9Ze+SQuaoK4vhROcGQTDpMP/SN4w2gJyziaiY=;
        b=fV2p689xUXgpLyXEDOD6AXLAe0Kku3vMVdfSks6UaPq1VL5Y6WIV3jZ3N+4TGoTqGO
         plQNQtICzEZEww4vYILn2Rvyh0MWxFGQFRg6tRsyRewkqiagBkdV/Nu7ds7xGxbIR0+2
         g8ovcebRj7c1TGpQkxnJrauDUI7sjuw1l0TMV+mAy/dv2XGU1vX8JmjTEq+4cJHpyDjj
         I8OfQSTC0sAIuRd3NAuZGRWCi07TR8FEPNiglwktjczqJGIncPdbUQFYfD0pMSTDRWu0
         2Ntbx785fOgaKXZ08SuffcdUcFV1/wNrBIg3XZmuX4qjKDIO9Jy/861uVhPX/ro7nGKY
         TySQ==
X-Gm-Message-State: AOAM533SRk+r8fbEjuTZ+3DBtIbd+mSE5QPW4ww8Ml8jw2Q2t94wA5du
        DcCBsAGS7ud58/rvF4xsZaIpvl4To2dlhWUfjQ2dLw==
X-Google-Smtp-Source: ABdhPJy9O6D6xeUx2gKio0xVXoVq5jK1dTwDHx9t1Qg5OnfI5dRQjBSQvmy/loj2IBoqOUXpmd9OOwNLkFvmQuB9SpQ=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr15152395lff.347.1615237909692;
 Mon, 08 Mar 2021 13:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-6-shy828301@gmail.com>
 <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
 <YEZVhNhGqV33lPo9@carbon.dhcp.thefacebook.com> <CAHbLzkr2KWZA2e34DNjqnK6H-Ai8ox-f7iOET6OumZArYTB8JQ@mail.gmail.com>
In-Reply-To: <CAHbLzkr2KWZA2e34DNjqnK6H-Ai8ox-f7iOET6OumZArYTB8JQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 8 Mar 2021 13:11:35 -0800
Message-ID: <CALvZod4bG4kbg9s2qKELMYL4OSs34hT16meazxMBFu5zywXupw@mail.gmail.com>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, paulmck@kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Mon, Mar 8, 2021 at 12:22 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Mar 8, 2021 at 8:49 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Sun, Mar 07, 2021 at 10:13:04PM -0800, Shakeel Butt wrote:
> > > On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> > > > We don't have to define a dedicated callback for call_rcu() anymore.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  mm/vmscan.c | 7 +------
> > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 2e753c2516fa..c2a309acd86b 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
> > > >         return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
> > > >  }
> > > >
> > > > -static void free_shrinker_map_rcu(struct rcu_head *head)
> > > > -{
> > > > -       kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > > > -}
> > > > -
> > > >  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > > >                                    int size, int old_size)
> > > >  {
> > > > @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > > >                 memset((void *)new->map + old_size, 0, size - old_size);
> > > >
> > > >                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > > > -               call_rcu(&old->rcu, free_shrinker_map_rcu);
> > > > +               kvfree_rcu(old);
> > >
> > > Please use kvfree_rcu(old, rcu) instead of kvfree_rcu(old). The single
> > > param can call synchronize_rcu().
> >
> > Oh, I didn't know about this difference. Thank you for noticing!
>
> BTW, I think I could keep you and Kirill's acked-by with this change
> (using two params form kvfree_rcu) since the change seems trivial.

Once you change, you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
