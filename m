Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27F356882
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbhDGJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhDGJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:55:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B066C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUV9gzaEqSL588esULqOCO/pkpJA1yvEQI+xvdfazJo=; b=rR/oliWLbXwCjURymy5uXzA9qi
        MvgMdU4dxnUsk87Ouax18EuA4nwdWEKCeytIFE1X3Vv8qf8+/+TKuCJUUrz72p5AGUXybmYiMocEb
        h1qX3rPXOOl4pD6mNeJHs52k6wxGSQJ1KYHQSC/Wocb4g6WAlBosh30MB63aUr4lGsE+EyX+Njdp6
        RKf3FmPpt7rsfGA+ohbpFVEXtY/jbv0oMvNXV+hXiHCfRtuZ90fyo/9BMlMXmW1eO2ls0P07zdG5n
        voc7c30xZF8MgvXzXJt/DHpKkLH73y1N2Y9emB7IFiQfeO2AcARCjKpDIJKDewbKwj/5pejzn5ffn
        IJgnM6bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU4tR-00EGwl-H1; Wed, 07 Apr 2021 09:54:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D2C030005A;
        Wed,  7 Apr 2021 11:54:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1118B2BE1CA0B; Wed,  7 Apr 2021 11:54:37 +0200 (CEST)
Date:   Wed, 7 Apr 2021 11:54:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
 <20210407094217.GA2926@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407094217.GA2926@vingu-book>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:42:17AM +0200, Vincent Guittot wrote:
> I would really prefer to keep that out of select_idle_cpu which aims to merge in one
> single loop the walk through sd_llc. In the case of select_idle_smt, this is done outside
> the loop:

Fair enough.

> @@ -6317,11 +6339,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  		}
>  	}
>  
> +	if (static_branch_likely(&sched_smt_present)) {
> +		smt = test_idle_cores(target, false);
> +		if (!smt && cpus_share_cache(prev, target)) {
> +			/* No idle core. Check if prev has an idle sibling. */
> +			i = select_idle_smt(p, sd, prev);
> +			if ((unsigned int)i < nr_cpumask_bits)
> +				return i;
> +		}
> +	}
> +
>  	sd = rcu_dereference(per_cpu(sd_llc, target));
>  	if (!sd)
>  		return target;

It needs to be here, otherwise you're using @sd uninitialized.

> -	i = select_idle_cpu(p, sd, target);
> +	i = select_idle_cpu(p, sd, smt, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;

Let me have another poke at it.
