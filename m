Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C003534AB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCZPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhCZPgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:36:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616772962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5KU6VylMRMyZvTyqPo/BHGYNwWheIqROBxQ4/DH4+8=;
        b=Y3ouveCx9Q+ASuaEpDN67hcpfdPanfqzzoghiKgdifFuk0NGyc7ynIPTnhYmNm5H2ouZyF
        QqaTv6fuxtmBOkrziGCtakHrFA2Z405U45W9qp38NhOVs3CL+s2ts7G/DvU9OldkwxnYGm
        j9OVL85tEnC4zxCm5yEtQbPGMyOzy0I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20121AC6A;
        Fri, 26 Mar 2021 15:36:02 +0000 (UTC)
Date:   Fri, 26 Mar 2021 16:36:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
 <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-03-21 11:22:54, Aaron Tomlin wrote:
[...]
> > Both reclaim and compaction maintain their own retries counters as they
> > are targeting a different operation. Although the compaction really
> > depends on the reclaim to do some progress.
> 
> Yes. Looking at should_compact_retry() if the last known compaction result
> was skipped i.e. suggesting there was not enough order-0 pages to support
> compaction, so assistance is needed from reclaim
> (see __compaction_suitable()).
> 
> I noticed that the value of compaction_retries, compact_result and
> compact_priority was 0, COMPACT_SKIPPED and 1 i.e. COMPACT_PRIO_SYNC_LIGHT,
> respectively.
> 
> > OK, this sound unexpected as it indicates that the reclaim is able to
> > make a forward progress but compaction doesn't want to give up and keeps
> > retrying. Are you able to reproduce this or could you find out which
> > specific condition keeps compaction retrying? I would expect that it is
> > one of the 3 conditions before the max_retries is checked.
> 
> Unfortunately, I have been told it is not entirely reproducible.
> I suspect it is the following in should_compact_retry() - as I indicated
> above the last known value stored in compaction_retries was 0:
> 
> 
>         if (order > PAGE_ALLOC_COSTLY_ORDER)
>                 max_retries /= 4;
>         if (*compaction_retries <= max_retries) {
>                 ret = true;
>                 goto out;
>         }

OK, I kinda expected this would be not easily reproducible. The reason I
dislike your patch is that it addes yet another criterion for oom while
we already do have 2 which doesn't make the resulting code easier to
reason about. We should be focusing on the compaction retry logic and
see whether we can have some "run away" scenarios there. Seeing so many
retries without compaction bailing out sounds like a bug in that retry
logic. Vlastimil is much more familiar with that.
-- 
Michal Hocko
SUSE Labs
