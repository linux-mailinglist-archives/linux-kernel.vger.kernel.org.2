Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F03B1636
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFWIwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:52:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tpY7ZJfQv1M//nCf3suckiVtk/GSAXGbw4FxDg1kHDs=; b=oaEet3qcBIKu9mVF4070Wv30iA
        c/3oX4VuCncfMTXKhXKh01+t178xPSWw+ySlTQQp3Q3TVIXKL0EERgW63HtuRuEfgKaQqsUf0tcGE
        4j53AbTArjIjlFL/WEuxm1lfkM8MKwAoPnwdPWO4P+YcIrPooqz8d0M0nS5d1TiIaQ1UZ4ZzmAWqH
        5YGuyz/gvb4g0g5x3RPbwlk7QiS8ochOFVqjbO42zVy9N/JsLoEHPabT6wp37JWkSD1xR9On8iW6M
        5T5k15opJfZS8sjForCPJ9PNREVt9Sl40zukVi3zB+7Ul8ysPEVeBjC27UNqCGfoo+7Lgp6uFzodK
        8Ikw4FYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyY2-00FECb-4m; Wed, 23 Jun 2021 08:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62BDA30005A;
        Wed, 23 Jun 2021 10:47:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D41E2C6EF008; Wed, 23 Jun 2021 10:47:45 +0200 (CEST)
Date:   Wed, 23 Jun 2021 10:47:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tommaso.cucinotta@santannapisa.it,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YNL1MWe3PzD4YGAr@hirez.programming.kicks-ass.net>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
 <CAFpoUr1Q-DuvXhPtX=bNdjg6xVcyBF=Qm8kz+HG7pGtNtu9X4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpoUr1Q-DuvXhPtX=bNdjg6xVcyBF=Qm8kz+HG7pGtNtu9X4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 05:27:30PM +0200, Odin Ugedal wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfaa6e1f6067..ab809bd11785 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5277,6 +5277,7 @@ static enum hrtimer_restart
> sched_cfs_period_timer(struct hrtimer *timer)
>                         if (new < max_cfs_quota_period) {
>                                 cfs_b->period = ns_to_ktime(new);
>                                 cfs_b->quota *= 2;
> +                               cfs_b->burst *= 2;
> 
>                                 pr_warn_ratelimited(
>         "cfs_period_timer[cpu%d]: period too short, scaling up (new
> cfs_period_us = %lld, cfs_quota_us = %lld)\n",

Thanks, folded that.
