Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB8459347
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhKVQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:46:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKVQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:46:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2419F1FD39;
        Mon, 22 Nov 2021 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637599414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIkJYdNyfdkaPaDy9R4nQfQdmmgHCH9vNQA4fsbQjFw=;
        b=cGZefgA0WGWcPBgMQqXdMf3Lxo7T8hzTTz6UNDZ6ZofCAsSfzmOnUnAZ+dwFHh6/KwCYHG
        oennkooysXTRDDE3tMI0zi7W6FCRCZznhvToIMh+EbWpBckHLLUC75Wc5KCjzD03yet92p
        xyJbFGhnGY5Gw4Q3i23wn8v76jYeU4o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9900A3B85;
        Mon, 22 Nov 2021 16:43:33 +0000 (UTC)
Date:   Mon, 22 Nov 2021 17:43:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZvItUOgTgD11etC@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-11-21 15:39:30, Neil Brown wrote:
> 
> __GFP_ATOMIC serves little purpose.
> It's main effect is to set ALLOC_HARDER which adds a few little boosts to
> increase the chance of an allocation succeeding, one of which is to
> lower the water-mark at which it will succeed.
> 
> It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> adjusts this watermark.  It is probable that other users of __GFP_HIGH
> should benefit from the other little bonuses that __GFP_ATOMIC gets.

While I like to see __GFP_ATOMIC going away I am not really sure about
this particular part. We have 3 ways to get to memory reserves. One of
thme is directly controlable by __GFP_HIGH and two are internal to the
allocator to handle different situations - ALLOC_OOM is to help the oom
victim to make a fwd progress and ALLOC_HARDER should be for contexts
which cannot rely on the memory reclaim to continue.

What is the point of having ALLOC_HIGH and ALLOC_HARDER if you just
add both of them for __GFP_HIGH? I think you should be instead really
get back to pre d0164adc89f6b and allow ALLOC_HARDER for requests which
have neither of the reclaim allowed. That would require tweaking
GFP_ATOMIC as well I suspect and drop __GFP_KSWAPD_RECLAIM. Or do
something else.
 
> __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> There is little point to this.  We already get a might_sleep() warning
> if __GFP_DIRECT_RECLAIM is set.

I believe the point of the warning was to stop any abuse of an
additional memory reserves for context which can reclaim and to spare
those to interrupt handlers - which usually use GFP_ATOMIC. A lack of
any reports suggests this hasn't happened and the warning can be
dropped. Would be worth a patch on its own with this explanation.
 
> __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> probable that testing ALLOC_HARDER is a better fit here.

This has been introduced by f80b08fc44536 but I have to say that I
haven't understood why this couldn't check for __GFP_DIRECT_RECLAIM
or one ALLOC_$FOO boosters rather than __GFP_ATOMIC. Again something for
a separate patch.
 
> __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> sleep.  This should test __GFP_DIRECT_RECLAIM instead.

Willy has already proposed a better alternative.

Thanks!
-- 
Michal Hocko
SUSE Labs
