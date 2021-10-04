Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48297420AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJDMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:34:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37034 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:34:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D9CF01FFE8;
        Mon,  4 Oct 2021 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633350770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XiD+afiiLyuhyLeHqpR6VFM9oAVsKc1mquERPqNQV1s=;
        b=fUySvCnaU5OayYMjijzgKvZtS6YVpcj7fAqjvUviE8RPJUntQhxX9YTK/KdQ5S8KBPXEJf
        +nBLN2SrYjAszjqUQz92phaXTgt3CogjM/g8iwfaINFeemWhiGiz0DP+s/rYSt4HLhEzMG
        drvbNJqgdzfFBcC7sClw3lV57CAJIHE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2339A3B8A;
        Mon,  4 Oct 2021 12:32:49 +0000 (UTC)
Date:   Mon, 4 Oct 2021 14:32:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/4] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YVr0bwfDZQFbBCFG@alley>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923140951.35902-3-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-23 22:09:49, Pingfan Liu wrote:
> As for the context, there are two arguments to change
> debug_smp_processor_id() to is_percpu_thread().
> 
>   -1. watchdog_ev is percpu, and migration will frustrate the attempt
> which try to bind a watchdog_ev to a cpu by protecting this func inside
> the pair of preempt_disable()/preempt_enable().
> 
>   -2. hardlockup_detector_event_create() indirectly calls
> kmem_cache_alloc_node(), which is blockable.
> 
> So here, spelling out the really planned context "is_percpu_thread()".

The description is pretty hard to understand. I would suggest
something like:

Subject: kernel/watchdog_hld: Ensure CPU-bound context when creating
hardlockup detector event

hardlockup_detector_event_create() should create perf_event on the
current CPU. Preemption could not get disabled because
perf_event_create_kernel_counter() allocates memory. Instead,
the CPU locality is achieved by processing the code in a per-CPU
bound kthread.

Add a check to prevent mistakes when calling the code in another
code path.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Qing <wangqing@vivo.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Santosh Sivaraj <santosh@fossix.org>
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/watchdog_hld.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..df010df76576 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  
>  static int hardlockup_detector_event_create(void)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu;
>  	struct perf_event_attr *wd_attr;
>  	struct perf_event *evt;
>  
> +	/* This function plans to execute in cpu bound kthread */

This does not explain why it is needed. I suggest something like:

	/*
	 * Preemption is not disabled because memory will be allocated.
	 * Ensure CPU-locality by calling this in per-CPU kthread.
	 */


> +	WARN_ON(!is_percpu_thread());
> +	cpu = raw_smp_processor_id();
>  	wd_attr = &wd_hw_attr;
>  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
>  

Othrewise the change looks good to me.

Best Regards,
Petr
