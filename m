Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7540845A59F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhKWOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:30:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45678 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhKWOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:30:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0B681FD5A;
        Tue, 23 Nov 2021 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637677636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nY7Gs9iD2o4pmGT+rV7UrKH6+E5aLaBuNjkn+nr25hg=;
        b=J+NynC9FfeJtcWC9+9tpS5mbUkh4xiJqF8Iz4DA2GKgbkEI3dzEJ22KdejigsrgJ+0TTGA
        v2gok0L/FiGw6tq1uAQ0i+KhLWDVYiY7q9Hsx5U5UTZrnudyy19+2YTD9uU2PcUBevEMp6
        ExDfZXHCytViU1FzXuJYn6kuirqS1B8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3188A3B85;
        Tue, 23 Nov 2021 14:27:16 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:27:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZz6QWlk/ZMzC4DG@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZUBIbALcSHn4Rub@casper.infradead.org>
 <163727727803.13692.15470049610672496362@noble.neil.brown.name>
 <YZewStgII83phKtA@casper.infradead.org>
 <163740548025.13692.6428652897557849182@noble.neil.brown.name>
 <YZvLQyjIyBafYEPV@dhcp22.suse.cz>
 <163764092051.7248.17895085691664185172@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163764092051.7248.17895085691664185172@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-11-21 15:15:20, Neil Brown wrote:
> On Tue, 23 Nov 2021, Michal Hocko wrote:
[...]
> > Both __GFP_DIRECT_RECLAIM and __GFP_KSWAPD_RECLAIM are way too lowlevel
> > but historically we've had requests to inhibit kswapd for a particular
> > requests because that has led to problems - fun reading caf491916b1c1.
> 
> Unfortunately that commit doesn't provide any reasoning, just an
> assertion.
> The best reasoning I could find was in caf491916b1c1 which was the initial
> revert.  There the primary reasoning was "there is a bug that we don't
> have time for a proper fix before the next release, so let's just use
> this quick fix".
> ...  and maybe "the quick fix" was "the right fix", but I cannot tell from
> the commit logs :-(

Yeah, that was not entirely fair from me but I just found it a nice
example of how fun our process around gpf has been historically.
A more fair would be to point you at 32dba98e085f ("thp: _GFP_NO_KSWAPD")
which has introduced for THP use. Mostly as a workaround to existing
reclaim problems because THPs have been enabled by default for everybody
and that had backfired. Rik has tried to remove the flag c654345924f7
("mm: remove __GFP_NO_KSWAPD") because most problems had been fixed - he
believed. But that has turned out to be not the case 82b212f40059
("Revert "mm: remove __GFP_NO_KSWAPD"") and swap storms triggered by THP
peak loads were still observed.

THP still seem to remain to be the biggest user of the flag (read only
to care to not have the flag. Maybe another round of the check whether
we need it...

> > __GFP_ALLOW_BLOCKING would make a lot of sense but I am not sure it
> > would be a good match to __GFP_KSWAPD_RECLAIM.
> 
> So? __GFP_ALLOW_BLOCKING makes it clear what is, or is not, acceptable
> to the caller.  How much reclaim, or other activity, alloc_page()
> engages in is largely irrelevant to the caller as lock as it doesn't
> block if asked not to (and doesn't enter an FS if asked not to, etc).

Hmm, maybe you are right.
 
> > > Actually ... I take it back about __GFP_NOWARN.  That probably shouldn't
> > > exist at all.  Warnings should be based on how stressed the mm system is,
> > > not on whether the caller wants thinks failure is manageable.
> > 
> > Unless we change the way when allocation warnings are triggered then we
> > really need this. There are many opportunistic allocations with a
> > fallback behavior which do not want to swamp kernel logs with failures
> > that are of no use. Think of a THP allocation that really want to be
> > just very quick and falls back to normal base pages otherwise. Deducing
> > context which is just fine to not report failures is quite tricky and it
> > can get wrong easily. Callers should know whether warning can be of any
> > use in many cases.
> 
> "Unless" being the key work.
> It makes sense to warn when a __GFP_HIGH or __GFP_MEMALLOC allocation
> fails,  because they are clearly important.
>
> It makes sense to warning if direct reclaim and retrying were enabled,
> as then alloc_page() has tried really hard, but failed anyway.  Thought
> maybe if COSTLY_ORDER is exceeded, then the warning is unlikely to be
> interesting.

For "normal" small allocations we usually get an OOM report if the
memory is depleted. That will provide quite a lot of potentially useful
context to debug memory usage. Non reclaiming allocations can be just
opportunistic that choose to not reclaim with an other approach as a
fallback but there are others that really cannot reclaim because they
are in an atomic context. I do not see an easy way to tell one from the
other. Simirarly for higher order allocations it can be useful to see
whether the memory is depletely or just fragmented.

> But does it ever make sense to warn if either of
> __GFP_RETRY_MAYFAIL __GFP_NORETRY are present?

> If we always suppressed warning when those flags were present, then many
> (most?) uses for __GFP_NOWARN can be discarded.

Yes __GFP_NORETRY is mostly (maybe always) used with __GFP_NOWARN.
Coccinelle would be a good way to check. I do remember MAYFAIL is used
for page migration to allocate target memory. It is often useful to see
that the migration is failing because of lack of memory.
 
> I can see that some of the __GFP flags are designed to each perform a
> single well-defined function and internally to mm/ that makes sense.
> But exposing those flags to all users appears to be a recipe for
> trouble.  Hiding them all behind "__" doesn't stop people from using and
> misusing them.  Others are externally meaningful.  Making them visually
> similar to the ones we want to hide isn't helping anyone.

I do agree here.
-- 
Michal Hocko
SUSE Labs
