Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949037C075
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhELOnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:43:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhELOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:43:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620830541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/FBaaUrcpeBw1z8WTREnKbTYrdVj+tsIwJFqKWNnfI=;
        b=BOadud88kio+9lWZ6KKx0f6S/pO2QfnwHxw/kD3Y7yFMGlHoRd1qlpAbFfQq+Gq/xyMnUm
        DHpVr1E+OEixWy7K8vN4doQ3vlD98ovOSriltoeSiMGZx67T5U1XhUZysXzpzZq53u2w9N
        W6HXs1pBU+eStAJk0vvnyItqx57kfzl2jSe2kFGkRiSqQGDdqqZzqPyL8j5X3K9gHCO9B/
        zxhuJZCB7hJjdY0K6+ObO0AY48a/+1N70Dc69XraDZ2w8fpYLcgNS7uDkRkRX6XpDKar6k
        VoK0MYR1mvmLxO53JHe4t7vA5I8YAi4cGEgY44/rlR6J96VD4i6w1TAhutfkLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620830541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/FBaaUrcpeBw1z8WTREnKbTYrdVj+tsIwJFqKWNnfI=;
        b=IXI8ND1yak9Vi3x3K0TZuKIaE94HFH4LjhauBQa/17UtMIhQr9zZwJiUUz4d5uthwfQdfa
        HCj2pkKQjhEhS6AA==
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com
Subject: Re: [RFC PATCH] timer: Fix bucket_expiry calculation
In-Reply-To: <1620821729-40694-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1620821729-40694-1-git-send-email-wangxiongfeng2@huawei.com>
Date:   Wed, 12 May 2021 16:42:21 +0200
Message-ID: <87y2ckdnea.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiongfeng,

On Wed, May 12 2021 at 20:15, Xiongfeng Wang wrote:
> When I use schedule_timeout(5) to put a process into sleep on my machine
> with HZ = 100. It always sleep about 60ms. I enable the timer trace and
> find out, when the timer_list expires, 'now' is always equal to
> 'expires + 1'. I print 'base->next_expiry' in '__run_timers' and find out
> 'next_expiry' is always equal to 'expires + 1';
>
> It is because we use the following equation to calculate bucket_expiry.
>
>   bucket_expiry = ((expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)
>
> 'bucket_expiry' is equal to 'expires + 1' when lvl = 0. So modify the
> equation as follows to fix the issue.
>
>   bucket_expiry = ((expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)

That's wrong because you move the expiry of each timer one jiffie ahead,
which violates the guarantee that a timer sleeps at least for one jiffie
for real and not measured in jiffies.

  jiffies = 0
  schedule_timeout(1)

   local_irq_disable()
			  -> timer interrupt is raised in HW
   timer->expires = jiffies + 1 <- 1
   add_timer(timer)
   local_irq_enable()
   timer interrupt
      jiffies++;
      softirq()
	  expire(timer); -> timer is expired immediately       

So the off by one has a reason and is required to prevent too short
timeouts. There is nothing you can do about that because that's a
property of low granularity tick based timer wheels.

That's even documented in the comment above the code you modified:

	/*
	 * The timer wheel has to guarantee that a timer does not fire
	 * early. Early expiry can happen due to:
	 * - Timer is armed at the edge of a tick
	 * - Truncation of the expiry time in the outer wheel levels
	 *
	 * Round up with level granularity to prevent this.
	 */

Thanks,

	  tglx
