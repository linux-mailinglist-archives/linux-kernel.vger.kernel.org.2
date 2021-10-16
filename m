Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207D42FFCC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 04:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhJPDAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236923AbhJPDAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAA8861214;
        Sat, 16 Oct 2021 02:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634353119;
        bh=D4kIgZbs8kCfWbV0F4ekpMVNuf0wAaJd9KI7A+0C9WI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CrgGt8Ns1FnRIaBmvBUZnFbbpb2xBZVS2k4jMmxbVuQ9JQyL0ADglaflJ6XG+Bgdn
         zoeOSrDw5k7ixknnQLtxyS0/aEGw2tVvNJnwIykPKtXnTbcvaf3kdmG+y1VIPMuU17
         SE9Jrj6VrZSlWIu6iLUvVa0aHeOUXpGDu6XLjwts=
Date:   Fri, 15 Oct 2021 19:58:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-Id: <20211015195837.4b26e56f984aaa1383ea0335@linux-foundation.org>
In-Reply-To: <CAGWkznGt=9HznGA6R15z=QVZmnk9rGvQ77gN_G9UZk-XqzpF1g@mail.gmail.com>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
        <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
        <CAGWkznGt=9HznGA6R15z=QVZmnk9rGvQ77gN_G9UZk-XqzpF1g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 10:28:54 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> On Sat, Oct 16, 2021 at 4:00 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 15 Oct 2021 14:15:29 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Sibling thread of the same process could refault the reclaimed pages
> > > in the same time, which would be typical in None global reclaim and
> > > introduce thrashing.
> >
> > "None" -> "node", I assume?
> >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > >                               sc->memcg_low_skipped = 1;
> > >                               continue;
> > >                       }
> > > +                     /*
> > > +                      * Don't bother current when its memcg is below low
> > > +                      */
> >
> > The comment explains what the code is doing, but the code itself
> > already does this.  Please can we have a comment that explains *why*
> > the code is doing this?
> We find that the patch help direct reclaiming bail out early and
> eliminate page thrashing for some scenarios(etc APP start on android).
> The case could be worse if each APP possess a unique memcg(pages on
> current's lru are reclaimed more than global reclaim)

What I meant was: please redo the patch with a comment which explains
"why the code does this", rather than "what the code does".

Also, as this is a performance enhancement, it is preferred to have
some performance testing results in the changelog.

