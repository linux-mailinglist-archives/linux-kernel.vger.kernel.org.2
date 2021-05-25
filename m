Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4C38FF82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhEYKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhEYKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:49:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED2C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kIlqXG4mzpF8kuUvhtnEEvK4Ewcs8NIwl3xb4LOQl/8=; b=EGdqySZJVv63v+zSdlDGsWVXtd
        DFWrJNTl1FEo9YrOiO+HGX90X5nWvoe8PMhgAClHFoZKGUsI4H0qwTf8d3n6hMVRutRgztmX/fuKg
        lxrjAocet7/4KPqBq33GS0fBItr8ysvhvpA4ZFPoyp067wHGvo1Np5Dybgbd0qdTxTE3Ag8mkCtLh
        dAxHDmDLC0FGzEEbLxuZCkpVaJiQErZlKv95ZuVXO7ybWfidhG9zqQT0fCysyNceNoMQc9gSMRz4T
        LWhtq4x45FfFUWlcd/71wWFrFmqRFVgk1nIz8n1N97C0HksTeRIBnUD5CfDflb4gRZlgRbcnLKa8D
        mYBkOsUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llUaj-0002Hn-4L; Tue, 25 May 2021 10:47:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E5D53001E4;
        Tue, 25 May 2021 12:47:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B15220299B4D; Tue, 25 May 2021 12:47:23 +0200 (CEST)
Date:   Tue, 25 May 2021 12:47:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YKzVu2cOYRN9TZD3@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
 <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:42:03PM +0800, changhuaixin wrote:

> >> static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> >> @@ -4651,6 +4666,9 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
> >> 	if (cfs_b->quota == RUNTIME_INF)
> >> 		amount = min_amount;
> >> 	else {
> >> +		if (!cfs_b->period_active)
> >> +			__refill_cfs_bandwidth_runtime(cfs_b);
> > 
> > Why this call?
> 
> As the cfs bandwidth timer stops on idle with runtime unfilled, refill runtime when it restarts to make
> use of the underrun when period timer stops. Another way to do this might be:
> 
>         throttled = !list_empty(&cfs_b->throttled_cfs_rq);
>         cfs_b->nr_periods += overrun;
> 
> +       __refill_cfs_bandwidth_runtime(cfs_b);
> +
>         /*
>          * idle depends on !throttled (for the case of a large deficit), and if
>          * we're going inactive then everything else can be deferred
>          */
>         if (cfs_b->idle && !throttled)
>                 goto out_deactivate;
> 
> -       __refill_cfs_bandwidth_runtime(cfs_b);
> -
>         if (!throttled) {
> 

Ben, do you have a preference?
