Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7044C1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKJNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhKJNTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:19:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B84F61107;
        Wed, 10 Nov 2021 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636550183;
        bh=7rx1dmvlEOjFTEd/aBQFfM7ZdEvL6pnd5/H4ff/lqzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Z1InjpUCfsgx59mG67L6AmWPpl+SWCeQjlUS9w4FjZknj9teUe4TbGB2A6KMKgiX+
         obJLUvwr3NiHspqBn65tFTgRc094+ISarDC+ChBYRRCwqculyxCtcSgl8PGHwPAzM/
         YYMrl6Bl0Y2fAcwnpBzRGEPY/hk3Y/OQIbeZVq+AE+Xp4cWmAqgSdrSuViSK32hI6k
         Z3fhhJ2M25VqdriNYKe7dA7fKytPF823F2GDgrcPsOdJKZTi5JelRMG0Kjqf/53aqr
         1YfqmKcIesdsXApQb+dDWvvXyE2FqkkQcvi98zcxiysA031HX/AtZXTyWfA977pTGD
         4cyDN1WJSTnVA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon: Add 'age' of region tracepoint support
Date:   Wed, 10 Nov 2021 13:16:21 +0000
Message-Id: <20211110131621.18221-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <df8d52f1fb2f353a62ff34dc09fe99e32ca1f63f.1636546262.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 20:13:14 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In patch "mm/damon: add a tracepoint", it adds a
> tracepoint for DAMON, it can monitor each region
> for each aggregation interval, Now the region add
> a new 'age' variable, some primitive would calculate
> the priority of each region as a weight, there put it
> into tracepoint, so we can easily track the change of
> its value through perf or damon-tools.

DAMON calculates the age using the address range and nr_accesses of the region,
which are already in the tracepoint.  In other words, user space can calculate
the age on their own.  Therefore I thought putting age in the tracepoint as
adding unnecessary information, at the moment of the implementation.

Of course, I would missing some use cases that need this information in the
tracepoint.  Furthermore, adding just one more value in the tracepoint wouldn't
incur a real issue.  But, I'd like to know why this is necessary and how much
benefit it provides.  Xin, could you please share that?


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/trace/events/damon.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 2f422f4f1fb9..99ffa601e351 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -22,6 +22,7 @@ TRACE_EVENT(damon_aggregated,
>  		__field(unsigned long, start)
>  		__field(unsigned long, end)
>  		__field(unsigned int, nr_accesses)
> +		__field(unsigned int, age)
>  	),
>  
>  	TP_fast_assign(
> @@ -30,11 +31,13 @@ TRACE_EVENT(damon_aggregated,
>  		__entry->start = r->ar.start;
>  		__entry->end = r->ar.end;
>  		__entry->nr_accesses = r->nr_accesses;
> +		__entry->age = r->age;
>  	),
>  
> -	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
> +	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
>  			__entry->target_id, __entry->nr_regions,
> -			__entry->start, __entry->end, __entry->nr_accesses)
> +			__entry->start, __entry->end,
> +			__entry->nr_accesses, __entry->age)
>  );
>  
>  #endif /* _TRACE_DAMON_H */
> -- 
> 2.31.0
