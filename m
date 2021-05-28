Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9950394240
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhE1MBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:01:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhE1MBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:01:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B95181FD2E;
        Fri, 28 May 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622203177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyj9l9ik9fiIzg7ahnLVcj3TFNtj4jX5IrQ8z2cWPgA=;
        b=sdVeV8ySnJTQu+Ca7f81XuRHK4s3f4zOZkd7iI2juhIk9CE0wSMoVODxn2zP5huAUkhyDs
        lWghtWP1rCAZ2VLjJNPEum/30qcBNpgGe3Or9Lj0Y+YNRxd43BbljEREkEdN3mK8ce9uNI
        ppVP+Q7TTCc+55a/Czu3plq3vwkrNfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622203177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyj9l9ik9fiIzg7ahnLVcj3TFNtj4jX5IrQ8z2cWPgA=;
        b=6xtxs6wu8gQnc+RhFPNUB1RttB7BEmlJBYfrKl9wxIEnVMnLk5lKDRaXX8KQAd1oWknvVq
        ImgSg2IQ6sEZm/Cw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A0CEE11A98;
        Fri, 28 May 2021 11:59:37 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id tAS5JinbsGCJGAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 11:59:37 +0000
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6/6] mm/page_alloc: Introduce
 vm.percpu_pagelist_high_fraction
Message-ID: <018c4b99-81a5-bc12-03cd-662a938ef05a@suse.cz>
Date:   Fri, 28 May 2021 13:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> This introduces a new sysctl vm.percpu_pagelist_high_fraction. It is
> similar to the old vm.percpu_pagelist_fraction. The old sysctl increased
> both pcp->batch and pcp->high with the higher pcp->high potentially
> reducing zone->lock contention. However, the higher pcp->batch value also
> potentially increased allocation latency while the PCP was refilled.
> This sysctl only adjusts pcp->high so that zone->lock contention is
> potentially reduced but allocation latency during a PCP refill remains
> the same.
> 
>   # grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  649
>               batch: 63
> 
>   # sysctl vm.percpu_pagelist_high_fraction=8
>   # grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  35071
>               batch: 63
> 
>   # sysctl vm.percpu_pagelist_high_fraction=64
>               high:  4383
>               batch: 63
> 
>   # sysctl vm.percpu_pagelist_high_fraction=0
>               high:  649
>               batch: 63
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Documentation nit below:

> @@ -789,6 +790,25 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
>  why oom happens. You can get snapshot.
>  
>  
> +percpu_pagelist_high_fraction
> +=============================
> +
> +This is the fraction of pages in each zone that are allocated for each
> +per cpu page list.  The min value for this is 8.  It means that we do
> +not allow more than 1/8th of pages in each zone to be allocated in any
> +single per_cpu_pagelist.

This, while technically correct (as an upper limit) is somewhat misleading as
the limit for a single per_cpu_pagelist also considers the number of local cpus.

>  This entry only changes the value of hot per
> +cpu pagelists. User can specify a number like 100 to allocate 1/100th
> +of each zone to each per cpu page list.

This is worse. Anyone trying to reproduce this example on a system with multiple
cpus per node and checking the result will be puzzled.
So I think the part about number of local cpus should be mentioned to avoid
confusion.

> +The batch value of each per cpu pagelist remains the same regardless of the
> +value of the high fraction so allocation latencies are unaffected.
> +
> +The initial value is zero. Kernel uses this value to set the high pcp->high
> +mark based on the low watermark for the zone and the number of local
> +online CPUs.  If the user writes '0' to this sysctl, it will revert to
> +this default behavior.
> +
> +
