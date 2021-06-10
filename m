Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2956E3A33C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFJTRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:17:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P1llf2QexIB6zftx6d6h4bt2id9V5bEpqvB36CLnZ5s=; b=pB/nSbzZ9NBklnx3gdhK/e8jb+
        3D1uWchY/ea/THpxd6LenWQHBTMN3FFZS8Rf8opsB7PRjqTsbAI7qoNQKwC/hZybPYE7PnlWLkHu9
        /eWXa5ERaqnHFUsso2TWIKRSMhpVNkdZdNJN3v3LV3QOstmb0Jy77s/EXQKUvYRJ62eRtEwj73524
        lfGBrkzDBvYoiWw3Ftbbd3iOZKQfImrvKIrAvvHVvVwN8Z9svRZt/0sgYzvOyApz1PAMxI2oEEf2i
        KHYACY/rZC+GJppDItCosv7GN6NegMQaDqekfFot/Ybg9M+0xsEjiafGKoV1D+V5jqKwNwbEe+rss
        5mgytmiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrQ9T-005bjF-N1; Thu, 10 Jun 2021 19:15:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CFEA3001E4;
        Thu, 10 Jun 2021 21:15:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61DCB200F8CB3; Thu, 10 Jun 2021 21:15:45 +0200 (CEST)
Date:   Thu, 10 Jun 2021 21:15:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YMJk4TWEAGL3EKUO@hirez.programming.kicks-ass.net>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610151306.1789549-3-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 03:13:05PM +0000, Quentin Perret wrote:
> SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
> the call must not touch scheduling parameters (nice or priority). This
> is particularly handy for uclamp when used in conjunction with
> SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
> impacts uclamp values.
> 
> However, sched_setattr always checks whether the priorities and nice
> values passed in sched_attr are valid first, even if those never get
> used down the line. This is useless at best since userspace can
> trivially bypass this check to set the uclamp values by specifying low
> priorities. However, it is cumbersome to do so as there is no single
> expression of this that skips both RT and CFS checks at once. As such,
> userspace needs to query the task policy first with e.g. sched_getattr
> and then set sched_attr.sched_priority accordingly. This is racy and
> slower than a single call.
> 
> As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
> is specified, simply inherit them in this case to match the policy
> inheritance of SCHED_FLAG_KEEP_POLICY.
> 
> Reported-by: Wei Wang <wvw@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3b213402798e..1d4aedbbcf96 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6585,6 +6585,10 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	rcu_read_unlock();
>  
>  	if (likely(p)) {
> +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS) {
> +			attr.sched_priority = p->rt_priority;
> +			attr.sched_nice = task_nice(p);
> +		}
>  		retval = sched_setattr(p, &attr);
>  		put_task_struct(p);
>  	}

I don't like this much... afaict the KEEP_PARAMS clause in
__setscheduler() also covers the DL params, and you 'forgot' to copy
those.

Can't we short circuit the validation logic?
