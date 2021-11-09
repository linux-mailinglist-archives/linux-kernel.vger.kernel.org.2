Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725744AD08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhKIL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhKIL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:59:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE7C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LVklNhRF/3j2kC2mLLZWGPLsPt9am8QB+t55FPCukuA=; b=VKdBnYoDP/E3Q5QpO1Av0Jpdq/
        hyCJ+d/e3FnANP7TU9CbZBGeMaW3XG9V9agjwqabKl4WUlF7xnIHkqbXIQvubA9O66r85kWwrNVVf
        Tg8ST/XQbAJOIEkMKcDdabJMK0lr+LMurNP2jFpIYTq6GaZY/1GmxVHUyth3aehkC33aZ4r3eRYwQ
        +hQv2R1mSP7E2eh+At3jmFcXca/ho6pTlmELGan/jAWE3pnjbHrAXSnc1ahcFy60UqaX2vvH5oMOW
        tfDVOxvwHGANi5obBC8PdMsZR2uWZPMXbZFm8H3vimib2ghLUlROFk+7NVXkcxLzVH6800bfFlYbM
        IsKv6WxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkPk7-00F3bl-0G; Tue, 09 Nov 2021 11:56:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C42A030003C;
        Tue,  9 Nov 2021 12:56:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A10D62D5E4E89; Tue,  9 Nov 2021 12:56:44 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:56:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <YYph/EuzlGr/3vG/@hirez.programming.kicks-ass.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
 <20211021145603.5313-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021145603.5313-2-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:56:02PM +0100, Mel Gorman wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..d00af3b97d8f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
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

It's a bit odd that the above uses min for llc_size, while the below:

> @@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
>  
>  	if (master < slave)
>  		swap(master, slave);
> -	if (slave < factor || master < slave * factor)
> +	if ((slave < factor && master < (factor>>1)*factor) || master < slave * factor)
>  		return 0;
>  	return 1;
>  }

has factor.

Now:

	!(slave < factor || master < slave * factor)

  !(x || y) == !x && !y, gives:

	slave >= factor && master >= slave * factor

  subst lhr in rhs:

	master >= factor * factor


your extra term:

	!((slave < factor && master < (factor*factor)/2) || master < slave * factor)

changes that how? AFAICT it's a nop.

