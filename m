Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782613A33B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFJTHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhFJTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:07:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mFeKTym8aQ6jwDN4npvrtlcNl6UMwpyxFDySILDtvN0=; b=aVnu2evswS4PudYRZJ0MHJb1rH
        D4uzsKsgdXf4FrX57s6DdhNaTJa+odv3sCjjxc7pw00x6u0y1BtTD7Uo+NEJkVpa6PS6+EOs0FWUC
        pNBBhOZ7nBXB4jWBCFuVvdpj2kCqqOwUYtDXPaVvM/ahGWCIBczdMt0wfoEbL0GjrHPAH6ewL9LwH
        3EKH/eaLvEKmgDUPbv2KWb/jdWvbiMTxVIUAHXBVGyll3sm49hyaoOQQVLUJw9f4lXmiam1qxyh+A
        6LWH1gU9m6dJb3O72lFcWg7qDiNmsipJmFmgzpHF0CwuTSnETcwyGK6AJ/1yz6rZL1z3N6619ctHw
        baJelGKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrPzN-001yzD-Fd; Thu, 10 Jun 2021 19:05:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84CB23001E3;
        Thu, 10 Jun 2021 21:05:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 633AC200F8CB3; Thu, 10 Jun 2021 21:05:12 +0200 (CEST)
Date:   Thu, 10 Jun 2021 21:05:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YMJiaO0IN2pN/EYY@hirez.programming.kicks-ass.net>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610151306.1789549-2-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 03:13:04PM +0000, Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util
> from suddenly becoming visible.
> 
> However, there is an asymmetry in how the flag is set and cleared which
> can lead to having the flag set whilst there are active tasks on the rq.
> Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
> called at enqueue time, but set in uclamp_rq_dec_id() which is called
> both when dequeueing a task _and_ in the update_uclamp_active() path. As
> a result, when both uclamp_rq_{dec,ind}_id() are called from
> update_uclamp_active(), the flag ends up being set but not cleared,
> hence leaving the runqueue in a broken state.
> 
> Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> things remain symmetrical.

The code you moved is neither in uclamp_rq_inc_id(), although
uclamp_idle_reset() is called from there, nor does it _set_ the flag.

I'm thinking it's been a long warm day? ;-)

> 
> Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
> Reported-by: Rick Yiu <rickyiu@google.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..3b213402798e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -980,6 +980,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>  	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>  		return;
>  
> +	rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
>  }
>  
> @@ -1252,10 +1253,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_inc_id(rq, p, clamp_id);
> -
> -	/* Reset clamp idle holding when there is one RUNNABLE task */
> -	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> -		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  }
>  
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> -- 
> 2.32.0.272.g935e593368-goog
> 
