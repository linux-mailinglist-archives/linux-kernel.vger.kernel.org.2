Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94B34A311
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:16:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:46416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhCZIQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:16:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616746576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wWiCP2GdmHrn2OrTkc2vGMcI3kl/aA9xBCE5d/QgWs=;
        b=pKRnzBkIj9hAOyLkdwfof7uhc6UajPRLCJeaiP3d8e6Jc3hLh4cT7Z0COqjq+Z0Uaz2o95
        zQUSvDSwpKzExw42dnH7xFq+SQi7jZ7Ym0RNJS8ow2ea8vAgX1WZlw3jauiWibb8iSFfIJ
        FaQcL6N/ktz2N+ofK+Yd7esWrrGkpxE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE2CEADDD;
        Fri, 26 Mar 2021 08:16:15 +0000 (UTC)
Date:   Fri, 26 Mar 2021 09:16:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Vlastimil]

On Thu 25-03-21 21:01:59, Aaron Tomlin wrote:
> On Mon 2021-03-22 11:47 +0100, Michal Hocko wrote:
> > Costly orders already do have heuristics for the retry in place. Could
> > you be more specific what kind of problem you see with those?
> 
> If I understand correctly, when the gfp_mask consists of
> GFP_KERNEL | __GFP_RETRY_MAYFAIL in particular, an allocation request will
> fail, if and only if reclaim is unable to make progress.
> 
> The costly order allocation retry logic is handled primarily in
> should_reclaim_retry(). Looking at should_reclaim_retry() we see that the
> no progress counter value is always incremented in the costly order case
> even when "some" progress has been made which is represented by the value
> stored in did_some_progress.
> 
>         if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
>                 goto nopage;
> 
>         if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
>                                  did_some_progress > 0, &no_progress_loops))
>                 goto retry;
> 
> I think after we have tried MAX_RECLAIM_RETRIES in a row without success
> and the last known compaction attempt was "skipped", perhaps it would be
> better to try and use the OOM killer or fail the allocation attempt?

The oom killer is never triggered for costly allocation request. Both
reclaim and compaction maintain their own retries counters as they are
targeting a different operation. Although the compaction really depends
on the reclaim to do some progress.

> I encountered a situation when the value of no_progress_loops was found to
> be 31,611,688 i.e. significantly over MAX_RECLAIM_RETRIES; the allocation
> order was 5. The gfp_mask contained the following:

OK, this sound unexpected as it indicates that the reclaim is able to
make a forward progress but compaction doesn't want to give up and keeps
retrying. Are you able to reproduce this or could you find out which
specific condition keeps compaction retrying? I would expect that it is
one of the 3 conditions before the max_retries is checked.

>      #define ___GFP_HIGHMEM          0x02
>      #define ___GFP_IO               0x40
>      #define ___GFP_FS               0x80
>      #define ___GFP_NOWARN           0x200
>      #define ___GFP_RETRY_MAYFAIL    0x400
>      #define ___GFP_COMP             0x4000
>      #define ___GFP_HARDWALL         0x20000
>      #define ___GFP_DIRECT_RECLAIM   0x200000
>      #define ___GFP_KSWAPD_RECLAIM   0x400000
> 
> 
> 
> -- 
> Aaron Tomlin
> 

-- 
Michal Hocko
SUSE Labs
