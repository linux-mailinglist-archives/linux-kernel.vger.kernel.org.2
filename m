Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBF459AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhKWESi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:18:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhKWESg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:18:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74FBF1FD5B;
        Tue, 23 Nov 2021 04:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637640927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVAxSK3grGRLBZLDcWUCQtUs50ZigAJrnl+sH8kL13s=;
        b=LjPRnkeK4h/2o+Zox/L+1Zk/K6HB6bo8YQRXFvrdugcafq2rbFkGCQhNxbc7osbIi071KN
        efA7JDzPIPtK5+AxcJxv7x7GTngqP8rVDYZmuugjICKFkxx5sdHzsEid9wnxvd4919f6UL
        ujRz+9ePkM6xw9A4naI8TQNeMJW252I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637640927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVAxSK3grGRLBZLDcWUCQtUs50ZigAJrnl+sH8kL13s=;
        b=MMN/C2PHDiLhupMycjaNKhAJF62lOopMUHbjiI4KbJ7LQl4mNlIC4x+1Apu0+jJwaY1k1a
        viKJcl/D9yGMn3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7573713B58;
        Tue, 23 Nov 2021 04:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H6+rC91qnGHFJQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 04:15:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Matthew Wilcox" <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thierry Reding" <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
In-reply-to: <YZvLQyjIyBafYEPV@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>,
 <YZUBIbALcSHn4Rub@casper.infradead.org>,
 <163727727803.13692.15470049610672496362@noble.neil.brown.name>,
 <YZewStgII83phKtA@casper.infradead.org>,
 <163740548025.13692.6428652897557849182@noble.neil.brown.name>,
 <YZvLQyjIyBafYEPV@dhcp22.suse.cz>
Date:   Tue, 23 Nov 2021 15:15:20 +1100
Message-id: <163764092051.7248.17895085691664185172@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021, Michal Hocko wrote:
> On Sat 20-11-21 21:51:20, Neil Brown wrote:
> > On Sat, 20 Nov 2021, Matthew Wilcox wrote:
> > > On Fri, Nov 19, 2021 at 10:14:38AM +1100, NeilBrown wrote:
> > > > On Thu, 18 Nov 2021, Matthew Wilcox wrote:
> > > > > Surely this should be gfpflags_allow_blocking() instead of poking a=
bout
> > > > > in the innards of gfp flags?
> > > >=20
> > > > Possibly.  Didn't know about gfpflags_allow_blocking().  From a quick
> > > > grep in the kernel, a whole lot of other people don't know about it
> > > > either, though clearly some do.
> > > >=20
> > > > Maybe we should reaname "__GFP_DIRECT_RECLAIM" to
> > > > "__GFP_ALLOW_BLOCKING", because that is what most users seems to care
> > > > about.
> > >=20
> > > I tend towards the school of thought that the __GFP flags should make
> > > sense to the implementation and users should use either GFP_ or functio=
ns.
> > > When we see users adding or subtracting __GFP flags, that's a problem.
> >=20
> > Except __GFP_NOWARN of course, or __GFP_ZERO, or __GFP_NOFAIL.
> > What about __GFP_HIGHMEM?  __GFP_DMA?  __GFP_HIGH?
> >=20
> > They all seem to be quite meaningful to the caller - explicitly
> > specifying properties of the memory or properties of the service.
> > (But maybe you would prefer __GFP_HIGH be spelled "__GFP_LOW_WATERMARK"
> > so it would make more sense to the implementation).
> >=20
> > __GFP_DIRECTRECLAIM seems to me to be more the exception than the rule -
> > specifying internal implementation details.
>=20
> I do not think it is viable to fix up gfp flags to be consistent :/

You may be right :-)  Of course if we don't try - you'll definitely be right.

> Both __GFP_DIRECT_RECLAIM and __GFP_KSWAPD_RECLAIM are way too lowlevel
> but historically we've had requests to inhibit kswapd for a particular
> requests because that has led to problems - fun reading caf491916b1c1.

Unfortunately that commit doesn't provide any reasoning, just an
assertion.
The best reasoning I could find was in caf491916b1c1 which was the initial
revert.  There the primary reasoning was "there is a bug that we don't
have time for a proper fix before the next release, so let's just use
this quick fix".
...  and maybe "the quick fix" was "the right fix", but I cannot tell from
the commit logs :-(

> __GFP_ALLOW_BLOCKING would make a lot of sense but I am not sure it
> would be a good match to __GFP_KSWAPD_RECLAIM.

So? __GFP_ALLOW_BLOCKING makes it clear what is, or is not, acceptable
to the caller.  How much reclaim, or other activity, alloc_page()
engages in is largely irrelevant to the caller as lock as it doesn't
block if asked not to (and doesn't enter an FS if asked not to, etc).

>=20
> > Actually ... I take it back about __GFP_NOWARN.  That probably shouldn't
> > exist at all.  Warnings should be based on how stressed the mm system is,
> > not on whether the caller wants thinks failure is manageable.
>=20
> Unless we change the way when allocation warnings are triggered then we
> really need this. There are many opportunistic allocations with a
> fallback behavior which do not want to swamp kernel logs with failures
> that are of no use. Think of a THP allocation that really want to be
> just very quick and falls back to normal base pages otherwise. Deducing
> context which is just fine to not report failures is quite tricky and it
> can get wrong easily. Callers should know whether warning can be of any
> use in many cases.

"Unless" being the key work.
It makes sense to warn when a __GFP_HIGH or __GFP_MEMALLOC allocation
fails,  because they are clearly important.
It makes sense to warning if direct reclaim and retrying were enabled,
as then alloc_page() has tried really hard, but failed anyway.  Thought
maybe if COSTLY_ORDER is exceeded, then the warning is unlikely to be
interesting.
But does it ever make sense to warn if either of
__GFP_RETRY_MAYFAIL __GFP_NORETRY are present?

If we always suppressed warning when those flags were present, then many
(most?) uses for __GFP_NOWARN can be discarded.

I can see that some of the __GFP flags are designed to each perform a
single well-defined function and internally to mm/ that makes sense.
But exposing those flags to all users appears to be a recipe for
trouble.  Hiding them all behind "__" doesn't stop people from using and
misusing them.  Others are externally meaningful.  Making them visually
similar to the ones we want to hide isn't helping anyone.

When Willy wrote:
  > When we see users adding or subtracting __GFP flags, that's a problem.
the "problem" is not so much in the fact that they *do* but in the fact
that they *can*.

I would be greatly in favour of GFP flags which made sense to callers,
and a mapping to ALLOC_ flags in mm/ which makes sense to allocators.

I doubt anything outside mm/ cares about whether KSWAPD is woken or not.
IT probably should be for small-order allocations, and not so much for
large-order allocations.  but mm/khugepaged.c might make other decisions.

Thanks,
NeilBrown
