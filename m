Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3884230A7C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBAMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBAMiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:38:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C24BD64E9B;
        Mon,  1 Feb 2021 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612183094;
        bh=pfakIwjEwnl7kFHeDar1bWjCsnRKW0H3yTWq/+gkELA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkRYwG/yxhHg68HdUeQpU9BI5s5BJTjaD21fgtVJO4WIpD2ocU4xrAL4sdzL0WZO1
         Q7+p/BYPKcbPPC/FxU6hM7jRIu3ehjsmEnpRsyWCVhRAwsWk2ZO5RwD51wnwpV1bwl
         W2YEgtPYESafH+AHdIMhr5DPsEiJngeDKEEt8N6gI9atF8WfPVDo2F+Fix2NeXOAZW
         Pe3Mpt+XrfensiC3BzaJE8IA3fkVo0mN3n6IuRFSkyF2QGi8urQVFQ33xXF8z8jClb
         9VWsiM6zjFO6sKXAgH1QEkO0ICbNk0QdCUQ7LK3yWx2MwCLVhOxn8U37PFXkIi0/sw
         B04P8m6V8wZYw==
Date:   Mon, 1 Feb 2021 13:38:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     chenshiyan <chenshiyan@linux.alibaba.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] nohz: Restart tick before do softirq
Message-ID: <20210201123811.GA41955@lothringen>
References: <1612151143-72242-1-git-send-email-chenshiyan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612151143-72242-1-git-send-email-chenshiyan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a bit confused with the changelog, let's try to clarify:

On Mon, Feb 01, 2021 at 11:45:43AM +0800, chenshiyan wrote:
> When the cpu is continuously idle, tick_irq_exit() will count next tick
> expiry

What do you mean by counting next tick expiry here? Is is when
tick_nohz_full_update_tick() reprogramms the next tick?

> with maybe several periodic ticks

you mean that perhaps it's not going to stop it right now?


> but if it enters softirq before next tick

Not sure what you mean here.

> invoke_softirq() is called before tick_irq_exit(),
> there will be no ticks during softirq.

Ok the issue happens when an IRQ fires while the tick is stopped, right?


> So with sched_clock_irqtime
> closing, sirq is very low in nohz idle even if the softirq costs much
> time beause of the sampling ticks missing(sirq will be much higher and
> seem exact if the cpu is busy).

But this only happens when sched_clock() is based on jiffies, right?
Are you working on an architecture that doesn't implement it?

Thanks.

> 
> Signed-off-by: chenshiyan <chenshiyan@linux.alibaba.com>
> ---
>  kernel/softirq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9d71046..8f3f71b9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -210,6 +210,7 @@ static inline void invoke_softirq(void)
>  		return;
>  
>  	if (!force_irqthreads) {
> +		tick_nohz_idle_restart_tick();
>  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
>  		/*
>  		 * We can safely execute softirq on the current stack if
> -- 
> 1.8.3.1
> 
