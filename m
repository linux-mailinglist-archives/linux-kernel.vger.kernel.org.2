Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EB394449
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhE1Ojn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:39:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhE1Ojm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:39:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F3CB218B3;
        Fri, 28 May 2021 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622212686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzREePWPek7xbQooscouTLGKXsYpABXEKB69ilAutZ4=;
        b=GCYu/8YI40f/UjSWypYlhNAsp6tqcZwSHL2Dyj7PgMJmx7o1hLgJMGWYYMW5tbPeq6P5Dg
        U6lKizf45Isn8gHkB/HdzVzzQpLYTVU/RH1Mltyjs4Vba3QUtl75kgfbOwWwm3zQpI44aI
        k2OlhlgfDxvu4kcOzrupUGA99QQUtuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622212686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzREePWPek7xbQooscouTLGKXsYpABXEKB69ilAutZ4=;
        b=+XkhBEbaAic5hiU6fcz3speKi9SedkZPv/mki141EIMM1Lv4mye9MSvV1oEw0dQkVBP9JB
        CKN4iRiph2FVAsBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 58E2C11A98;
        Fri, 28 May 2021 14:38:06 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3CMuFU4AsWBncAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 14:38:06 +0000
Subject: Re: [PATCH 6/6] mm/page_alloc: Introduce
 vm.percpu_pagelist_high_fraction
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-7-mgorman@techsingularity.net>
 <018c4b99-81a5-bc12-03cd-662a938ef05a@suse.cz>
 <20210528125334.GP30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3a6670d3-63eb-f97a-62a0-ec752d933a13@suse.cz>
Date:   Fri, 28 May 2021 16:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528125334.GP30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 2:53 PM, Mel Gorman wrote:
> On Fri, May 28, 2021 at 01:59:37PM +0200, Vlastimil Babka wrote:
>> On 5/25/21 10:01 AM, Mel Gorman wrote:
>> > This introduces a new sysctl vm.percpu_pagelist_high_fraction. It is
>> > similar to the old vm.percpu_pagelist_fraction. The old sysctl increased
>> > both pcp->batch and pcp->high with the higher pcp->high potentially
>> > reducing zone->lock contention. However, the higher pcp->batch value also
>> > potentially increased allocation latency while the PCP was refilled.
>> > This sysctl only adjusts pcp->high so that zone->lock contention is
>> > potentially reduced but allocation latency during a PCP refill remains
>> > the same.
>> > 
>> >   # grep -E "high:|batch" /proc/zoneinfo | tail -2
>> >               high:  649
>> >               batch: 63
>> > 
>> >   # sysctl vm.percpu_pagelist_high_fraction=8
>> >   # grep -E "high:|batch" /proc/zoneinfo | tail -2
>> >               high:  35071
>> >               batch: 63
>> > 
>> >   # sysctl vm.percpu_pagelist_high_fraction=64
>> >               high:  4383
>> >               batch: 63
>> > 
>> >   # sysctl vm.percpu_pagelist_high_fraction=0
>> >               high:  649
>> >               batch: 63
>> > 
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
> 
> Thanks.
> 
>> Documentation nit below:
>> 
>> > @@ -789,6 +790,25 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
>> >  why oom happens. You can get snapshot.
>> >  
>> >  
>> > +percpu_pagelist_high_fraction
>> > +=============================
>> > +
>> > +This is the fraction of pages in each zone that are allocated for each
>> > +per cpu page list.  The min value for this is 8.  It means that we do
>> > +not allow more than 1/8th of pages in each zone to be allocated in any
>> > +single per_cpu_pagelist.
>> 
>> This, while technically correct (as an upper limit) is somewhat misleading as
>> the limit for a single per_cpu_pagelist also considers the number of local cpus.
>> 
>> >  This entry only changes the value of hot per
>> > +cpu pagelists. User can specify a number like 100 to allocate 1/100th
>> > +of each zone to each per cpu page list.
>> 
>> This is worse. Anyone trying to reproduce this example on a system with multiple
>> cpus per node and checking the result will be puzzled.
>> So I think the part about number of local cpus should be mentioned to avoid
>> confusion.
>> 
> 
> Is this any better?

Ack, thanks

> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index e85c2f21d209..2da25735a629 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -793,15 +793,16 @@ why oom happens. You can get snapshot.
>  percpu_pagelist_high_fraction
>  =============================
>  
> -This is the fraction of pages in each zone that are allocated for each
> -per cpu page list.  The min value for this is 8.  It means that we do
> -not allow more than 1/8th of pages in each zone to be allocated in any
> -single per_cpu_pagelist.  This entry only changes the value of hot per
> -cpu pagelists. User can specify a number like 100 to allocate 1/100th
> -of each zone to each per cpu page list.
> -
> -The batch value of each per cpu pagelist remains the same regardless of the
> -value of the high fraction so allocation latencies are unaffected.
> +This is the fraction of pages in each zone that are can be stored to
> +per-cpu page lists. It is an upper boundary that is divided depending
> +on the number of online CPUs. The min value for this is 8 which means
> +that we do not allow more than 1/8th of pages in each zone to be stored
> +on per-cpu page lists. This entry only changes the value of hot per-cpu
> +page lists. A user can specify a number like 100 to allocate 1/100th of
> +each zone between per-cpu lists.
> +
> +The batch value of each per-cpu page list remains the same regardless of
> +the value of the high fraction so allocation latencies are unaffected.
>  
>  The initial value is zero. Kernel uses this value to set the high pcp->high
>  mark based on the low watermark for the zone and the number of local
> 

