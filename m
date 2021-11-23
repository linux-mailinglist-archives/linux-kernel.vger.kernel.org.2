Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B345A409
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhKWNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:44:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43120 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhKWNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:44:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 437831FD5A;
        Tue, 23 Nov 2021 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637674870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/LxEdXnM5Ugr13j6sYm/tVkCUBrZUC8yRTYLFMPAfc=;
        b=I0eKvSzPZHROoiG9bnh1w9NrFYDJCOhL+lE9cecxv5nU5EfS6WN3JGCbwvNWuDJNlrKhzg
        FX/MxsRsibCjJ3h7EaidOUeWjk8rUg6X5so3Wu3Mwa3ilpklT1P8RO4TkMnAPCpA9OIdJE
        yHVO/y985HFSuqYgoSugYoWbngFNA1A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 10EF1A3B81;
        Tue, 23 Nov 2021 13:41:10 +0000 (UTC)
Date:   Tue, 23 Nov 2021 14:41:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
 <163764199967.7248.2528204111227925210@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163764199967.7248.2528204111227925210@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-11-21 15:33:19, Neil Brown wrote:
[...]
> "ALLOC_HARDER" is a question of "can I justify imposing on other threads
> by taking memory that they might want".  Again there may be different
> reasons, but they will not always align with the first set.
> 
> With my patch there is still a difference between ALLOC_HIGH and
> ALLOC_HARDER, but not much.
> __GFP_HIGH combined with __GFP_NOMEMALLOC - which could be seen as "high
> priority, but not too high" delivers ALLOC_HIGH without ALLOC_HARDER.
> It may not be a useful distinction, but it seems to preserve most of
> what I didn't want to change.

I am not sure this is really a helpful distinction. I would even say that
an explicit use of __GFP_NOMEMALLOC | __GFP_HIGH is actively confusing
as that would mean that you do not allow access to reserves while you
want to dip into them anyway.

Anyway, I still think that ALLOC_HARDER should stay under control of the
allocator as a heuristic rather being imprinted into gfp flags
directly. Having two levels of memory reserves access is just too
complicated for users and I wouldn't be surprised if most callers would
just consider their usecase important enough to justify as much reserves
as possible.

Allocation from an interrupt context sounds like a good usecase for
ALLOC_HARDER. I am not sure about rt_task one but that one can be
reasoned about as well. All/most __GFP_HIGH allocations just look like
an overuse and conflation of the two modes. Both these were the primary
usecase for ALLOC_HARDER historically we just tried to find a way how to
express the former by gfp flags.
-- 
Michal Hocko
SUSE Labs
