Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CFA369C20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhDWVlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbhDWVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:41:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:40:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id AB8A91F40FD7
Subject: Re: [patch 3/6] futex: Get rid of the val2 conditional dance
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, kernel@collabora.com
References: <20210422194417.866740847@linutronix.de>
 <20210422194705.125957049@linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <f8cda7fa-46e9-5add-ccb6-441323ba2042@collabora.com>
Date:   Fri, 23 Apr 2021 18:40:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210422194705.125957049@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Às 16:44 de 22/04/21, Thomas Gleixner escreveu:
> There is no point in checking which FUTEX operand treats the utime pointer
> as 'val2' argument because that argument to do_futex() is only used by
> exactly these operands.
> 
> So just handing it in unconditionally is not making any difference, but
> removes a lot of pointless gunk.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/futex.c |   16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3765,7 +3765,6 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
>   {
>   	struct timespec64 ts;
>   	ktime_t t, *tp = NULL;
> -	u32 val2 = 0;
>   	int cmd = op & FUTEX_CMD_MASK;
>   
>   	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
> @@ -3785,15 +3784,8 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
>   			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
>   		tp = &t;
>   	}
> -	/*
> -	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
> -	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
> -	 */
> -	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
> -	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
> -		val2 = (u32) (unsigned long) utime;
>   
> -	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
> +	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);

Given do_futex()'s type signature, I think it makes more sense to cast 
utime to u32.

>   }
>   
>   #ifdef CONFIG_COMPAT
> @@ -3961,7 +3953,6 @@ SYSCALL_DEFINE6(futex_time32, u32 __user
>   {
>   	struct timespec64 ts;
>   	ktime_t t, *tp = NULL;
> -	int val2 = 0;
>   	int cmd = op & FUTEX_CMD_MASK;
>   
>   	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
> @@ -3979,11 +3970,8 @@ SYSCALL_DEFINE6(futex_time32, u32 __user
>   			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
>   		tp = &t;
>   	}
> -	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
> -	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
> -		val2 = (int) (unsigned long) utime;
>   
> -	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
> +	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);

Same here.

>   }
>   #endif /* CONFIG_COMPAT_32BIT_TIME */
>   
> 
