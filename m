Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13C43E5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1QVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1QVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:21:40 -0400
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94400C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:19:13 -0700 (PDT)
Date:   Fri, 29 Oct 2021 00:19:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635437951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKnFFiMfY0GxswzJmBjzLfl2Fj5DavTAFzb8a7nWObQ=;
        b=IMBJdvx4lTA/0WJec4tnZEwkaCDtgWkK6vn7ZWf+VhH4bFLgkkGfrYY2Eb/yg2GWRxuNdI
        WQX41RpqvbTCU/OcCdkcZy+JU7Z5BztpoBWQhr7cAhMGejXHNxq7R3QaPi2J9wEFo323yU
        jI1+q8H5txYSq6+eCyKpY4xGNpOYBlk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <YXrNfHcfhp2LutiL@geo.homenetwork>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
 <20211028094834.1312-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028094834.1312-2-mgorman@techsingularity.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, Oct 28, 2021 at 10:48:33AM +0100, Mel Gorman wrote:

> @@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct *p)
>  	}
>  
>  	if (current->last_wakee != p) {
> +		int min = __this_cpu_read(sd_llc_size) << 1;
> +		/*
> +		 * Couple the wakee flips to the waker for the case where it
> +		 * doesn't accrue flips, taking care to not push the wakee
> +		 * high enough that the wake_wide() heuristic fails.
> +		 */
> +		if (current->wakee_flips > p->wakee_flips * min)
> +			p->wakee_flips++;
>  		current->last_wakee = p;
>  		current->wakee_flips++;
>  	}
> @@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
>  
>  	if (master < slave)
>  		swap(master, slave);
> -	if (slave < factor || master < slave * factor)
> +	if ((slave < factor && master < (factor>>1)*factor) || master < slave * factor)

So, the check like this include the above range:

  if ((slave < factor && master < slave * factor) ||
       master < slave * factor)

That "factor>>1" filter some.

If "slave < factor" is true and "master < (factor>>1)*factor" is false,
then we check "master < slave * factor".(This is one path added by the
check "&&  master < (factor>>1)*factor").
In the latter check "slave < factor" must be true, the result of this
check depend on slave in the range [factor, factor>>1] if there is possibility
that "master < slave * factor". If slave in [factor>>1, 0], the check of
"master < slave * factor" is absolutly false and this can be filtered if
we use a variable to load the result of master < (factor>>1)*factor.

My random random inputs and continue confusing to move on.



Thanks,
Tao
