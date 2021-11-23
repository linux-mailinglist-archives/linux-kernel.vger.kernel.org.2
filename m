Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0FD459B44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhKWEge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:36:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34336 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWEgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:36:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59A1121910;
        Tue, 23 Nov 2021 04:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637642005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNhro/fY/bHRbePhmc84FJKb9ZECaq8qjIDmklZKfc4=;
        b=16K3rMJGAtPhVyNf+ZvZHuScKNDVPuTASppchF5lsQ4LfiYLir6awDZS37UQvkXsW7WCHB
        2cqsonrY0uE6mes+zhiAU3ALR1Onh+QLnHjFFrmv8Yz6DAvDihNkzzw3Lue8EGYexN4j/X
        4zshssnJjqrXwvKMzfNzesw8US/QuFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637642005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNhro/fY/bHRbePhmc84FJKb9ZECaq8qjIDmklZKfc4=;
        b=OztC3REAmg1hzgcwLtUcXxYRZr2Ri/rgQx+uDUf36KHixxA6CGgEEzIVHiZKdPrVXB7c7Y
        PrNK3yRVgXmm7qAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C574F134CE;
        Tue, 23 Nov 2021 04:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZdeGHxJvnGHzKgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 04:33:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Mel Gorman" <mgorman@suse.de>,
        "Vlastimil Babka" <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
In-reply-to: <YZvItUOgTgD11etC@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>,
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
Date:   Tue, 23 Nov 2021 15:33:19 +1100
Message-id: <163764199967.7248.2528204111227925210@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021, Michal Hocko wrote:
> On Wed 17-11-21 15:39:30, Neil Brown wrote:
> > 
> > __GFP_ATOMIC serves little purpose.
> > It's main effect is to set ALLOC_HARDER which adds a few little boosts to
> > increase the chance of an allocation succeeding, one of which is to
> > lower the water-mark at which it will succeed.
> > 
> > It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> > adjusts this watermark.  It is probable that other users of __GFP_HIGH
> > should benefit from the other little bonuses that __GFP_ATOMIC gets.
> 
> While I like to see __GFP_ATOMIC going away I am not really sure about
> this particular part. We have 3 ways to get to memory reserves. One of
> thme is directly controlable by __GFP_HIGH and two are internal to the
> allocator to handle different situations - ALLOC_OOM is to help the oom
> victim to make a fwd progress and ALLOC_HARDER should be for contexts
> which cannot rely on the memory reclaim to continue.

ALLOC_OOM certainly makes sense.

> 
> What is the point of having ALLOC_HIGH and ALLOC_HARDER if you just
> add both of them for __GFP_HIGH? I think you should be instead really
> get back to pre d0164adc89f6b and allow ALLOC_HARDER for requests which
> have neither of the reclaim allowed. That would require tweaking
> GFP_ATOMIC as well I suspect and drop __GFP_KSWAPD_RECLAIM. Or do
> something else.

NONONONO.  Tying ALLOC_HARDER to "no reclaim" is a mistake.  From the
caller's perspective they are very different statements, which might
sometimes go together (and GFP_ATOMIC is exactly where they go
together).

"no reclaim" is a question "am I willing to pay the price of performing
reclaim", and there might be various different reasons for choosing not
to.

"ALLOC_HARDER" is a question of "can I justify imposing on other threads
by taking memory that they might want".  Again there may be different
reasons, but they will not always align with the first set.

With my patch there is still a difference between ALLOC_HIGH and
ALLOC_HARDER, but not much.
__GFP_HIGH combined with __GFP_NOMEMALLOC - which could be seen as "high
priority, but not too high" delivers ALLOC_HIGH without ALLOC_HARDER.
It may not be a useful distinction, but it seems to preserve most of
what I didn't want to change.

>  
> > __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> > There is little point to this.  We already get a might_sleep() warning
> > if __GFP_DIRECT_RECLAIM is set.
> 
> I believe the point of the warning was to stop any abuse of an
> additional memory reserves for context which can reclaim and to spare
> those to interrupt handlers - which usually use GFP_ATOMIC. A lack of
> any reports suggests this hasn't happened and the warning can be
> dropped. Would be worth a patch on its own with this explanation.
>  
> > __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> > probable that testing ALLOC_HARDER is a better fit here.
> 
> This has been introduced by f80b08fc44536 but I have to say that I
> haven't understood why this couldn't check for __GFP_DIRECT_RECLAIM
> or one ALLOC_$FOO boosters rather than __GFP_ATOMIC. Again something for
> a separate patch.

Yes - the commit description contrasts "atomic" with "sleepable"
allocations.  Given that, __GFP_DIRECT_RECLAIM would make make sense.

>  
> > __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> > sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> 
> Willy has already proposed a better alternative.

I'm happy to resend the patch with this change (despite it seeming like
a bandaid on a blowhole).

Thanks for the thorough review!!

NeilBrown

> 
> Thanks!
> -- 
> Michal Hocko
> SUSE Labs
> 
> 
