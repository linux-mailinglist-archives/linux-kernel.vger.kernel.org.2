Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD7416A26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbhIXCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbhIXCus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D98F61090;
        Fri, 24 Sep 2021 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632451756;
        bh=h9Ozz3onH53Wx9sbbp5hIuCfRgkzuUNhUWFdHodSYZQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WsVVVdUfq7kYVuyeI9RYbZ0bYrV8v67rjnjdFiP0UzUxbE/+KrpwB1+KZ0Ji0likR
         FS/zeyDY2WmIj4NY8MTC1wQ9R3bzjRuTkgorFfY6ddX77rMN1qGjVbm1kYCBNiTeYB
         7YdeVpsQ6e1qCldh0hbA6QKVyuVbotcW+0+uZuOqdk61kO3vwzGehZHBrY3tKrinSp
         VUNKsPkSvy7Lb+mfbN7DbBqxgebTvO9eRLWoxPani00QvsfNkLcUgBFsWl1QODjaBy
         FvRDLbMYEG83xn+mrrC84ZFX09P7moYk+aS1HLjt55vhCtWOwmNA+iKEiJvvloQeNc
         2LYwiv4qZEgpA==
Subject: Re: [PATCH v2] clocksource: arc_timer: eliminate redefined macro
 error
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
References: <20210924020825.20317-1-rdunlap@infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <1557caaa-9f90-7613-4627-5c5f59d047fa@kernel.org>
Date:   Thu, 23 Sep 2021 19:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924020825.20317-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 7:08 PM, Randy Dunlap wrote:
> In drivers/clocksource/, 3 drivers use "TIMER_CTRL_IE" with 3 different
> values.  Two of them (mps2-timer.c and timer-sp804.c/timer-sp.h) are
> localized and left unmodifed.
>
> One of them uses a shared header file (<soc/arc/timers.h>), which is
> what is causing the "redefined" warnings, so change the macro name in
> that driver only. Also change the TIMER_CTRL_NH macro name.
> Both macro names are prefixed with "ARC_" to reduce the likelihood
> of future name collisions.
>
> In file included from ../drivers/clocksource/timer-sp804.c:24:
> ../drivers/clocksource/timer-sp.h:25: error: "TIMER_CTRL_IE" redefined [-Werror]
>     25 | #define TIMER_CTRL_IE           (1 << 5)        /*   VR */
> ../include/soc/arc/timers.h:20: note: this is the location of the previous definition
>     20 | #define TIMER_CTRL_IE           (1 << 0) /* Interrupt when Count reaches limit */
>
> Fixes: b26c2e3823ba ("ARC: breakout timer include code into separate header")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shahab Vahedi <Shahab.Vahedi@synopsys.com>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet

> ---
> v2: prefix both TIMER_CTRL_xx macros with ARC_ (suggested by
>      Shahab Vahedi <Shahab.Vahedi@synopsys.com>
>
>   drivers/clocksource/arc_timer.c |    6 +++---
>   include/soc/arc/timers.h        |    4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- linux-next-20210917.orig/include/soc/arc/timers.h
> +++ linux-next-20210917/include/soc/arc/timers.h
> @@ -17,8 +17,8 @@
>   #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
>   
>   /* CTRL reg bits */
> -#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
> -#define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
> +#define ARC_TIMER_CTRL_IE	(1 << 0) /* Interrupt when Count reaches limit */
> +#define ARC_TIMER_CTRL_NH	(1 << 1) /* Count only when CPU NOT halted */
>   
>   #define ARC_TIMERN_MAX		0xFFFFFFFF
>   
> --- linux-next-20210917.orig/drivers/clocksource/arc_timer.c
> +++ linux-next-20210917/drivers/clocksource/arc_timer.c
> @@ -225,7 +225,7 @@ static int __init arc_cs_setup_timer1(st
>   
>   	write_aux_reg(ARC_REG_TIMER1_LIMIT, ARC_TIMERN_MAX);
>   	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
> -	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
> +	write_aux_reg(ARC_REG_TIMER1_CTRL, ARC_TIMER_CTRL_NH);
>   
>   	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
>   
> @@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsign
>   	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
>   	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
>   
> -	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
> +	write_aux_reg(ARC_REG_TIMER0_CTRL, ARC_TIMER_CTRL_IE | ARC_TIMER_CTRL_NH);
>   }
>   
>   
> @@ -294,7 +294,7 @@ static irqreturn_t timer_irq_handler(int
>   	 *      explicitly clears IP bit
>   	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
>   	 */
> -	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
> +	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | ARC_TIMER_CTRL_NH);
>   
>   	evt->event_handler(evt);
>   

