Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAB38FD28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEYIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhEYIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:51:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB20C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IhdHrejb8oP7HF4BNxg6AJ7gMSwQljwx5iokXE2ziC4=; b=cy0uh2bIPIFr31viFMsd92QWSP
        5pMGGmATdtpyOqUvZBOLOiCLjFreEzr3N/nUL+X/UJibma/Wq/0td38d7ia13EV/DxEZh43VYz9fg
        vHHh6dkDXVwGk06Hqv5TKDyw1D/caBlVb17fPRPyB7LHOosThekDOlRPMJ4Of4pDjlW1DNg5tmVrV
        W0gwLsMpogo9lxr7m3hy6lxW4h/pk1NpJWfFMlHj+3oJPbGdKLgbfi6WBvE3KAWh/IBPWO+oqjf/I
        5we70QHyUS6sc2bZAISaEjO301ngOJVOqYBP8PZU5XZIBR/0KoNSM46tq1O+0eah0DahOOSX6hQmD
        6f0pTglg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llSjj-003IaJ-Vf; Tue, 25 May 2021 08:48:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E486730022A;
        Tue, 25 May 2021 10:48:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C823C30EA6427; Tue, 25 May 2021 10:48:23 +0200 (CEST)
Date:   Tue, 25 May 2021 10:48:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 05:54:24PM +0100, Vincent Donnefort wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4f09afd..5a91a2b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -10,6 +10,7 @@
>  
>  #include "sched.h"
>  
> +#include <linux/energy_model.h>
>  #include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>  
> @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  
>  	freq = map_util_freq(util, freq, max);
>  
> +	/* Avoid inefficient performance states */
> +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> +
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  

This seems somewhat unfortunate, it adds a loop over the OPPs only to
then call into cpufreq to do the exact same thing again :/
