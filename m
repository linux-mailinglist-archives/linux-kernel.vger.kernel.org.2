Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F8369C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhDWW2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:28:04 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44884 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhDWW2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:28:03 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 18:28:03 EDT
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4FRpdv5nyvzDqBg;
        Fri, 23 Apr 2021 15:20:51 -0700 (PDT)
X-Riseup-User-ID: 642403C05CFDE3C37CAC4EB595E778DFD32671E922EA2254C5D7B65EEF383282
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4FRpdq4jrkz5vY3;
        Fri, 23 Apr 2021 15:20:47 -0700 (PDT)
Subject: Re: [patch 6/6] futex: Provide FUTEX_LOCK_PI2 to support clock
 selection
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
        Kurt Kanzenbach <kurt@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, kernel@collabora.com
References: <20210422194417.866740847@linutronix.de>
 <20210422194705.440773992@linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
Message-ID: <606120ab-ef46-fa87-5f2c-d480de9ed2c8@riseup.net>
Date:   Fri, 23 Apr 2021 19:20:44 -0300
MIME-Version: 1.0
In-Reply-To: <20210422194705.440773992@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Às 16:44 de 22/04/21, Thomas Gleixner escreveu:
> The FUTEX_LOCK_PI futex operand uses a CLOCK_REALTIME based absolute
> timeout since it was implemented, but it does not require that the
> FUTEX_CLOCK_REALTIME flag is set, because that was introduced later.
> 
> In theory as none of the user space implementations can set the
> FUTEX_CLOCK_REALTIME flag on this operand, it would be possible to
> creatively abuse it and make the meaning invers, i.e. select CLOCK_REALTIME
> when not set and CLOCK_MONOTONIC when set. But that's a nasty hackery.
> 
> Another option would be to have a new FUTEX_CLOCK_MONOTONIC flag only for
> FUTEX_LOCK_PI, but that's also awkward because it does not allow libraries
> to handle the timeout clock selection consistently.
> 
> So provide a new FUTEX_LOCK_PI2 operand which implements the timeout
> semantics which the other operands use and leave FUTEX_LOCK_PI alone.
> 
> Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/uapi/linux/futex.h |    1 +
>   kernel/futex.c             |    6 +++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -21,6 +21,7 @@
>   #define FUTEX_WAKE_BITSET	10
>   #define FUTEX_WAIT_REQUEUE_PI	11
>   #define FUTEX_CMP_REQUEUE_PI	12
> +#define FUTEX_LOCK_PI2		13
>   
>   #define FUTEX_PRIVATE_FLAG	128
>   #define FUTEX_CLOCK_REALTIME	256

To keep consistency with other operations, maybe add a 
FUTEX_LOCK_PI2_PRIVATE?

> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3711,7 +3711,8 @@ long do_futex(u32 __user *uaddr, int op,
>   
>   	if (op & FUTEX_CLOCK_REALTIME) {
>   		flags |= FLAGS_CLOCKRT;
> -		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI)
> +		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
> +		    cmd != FUTEX_LOCK_PI2)
>   			return -ENOSYS;
>   	}

As FUTEX_LOCK_PI, FUTEX_LOCK_PI2 also requires FUTEX_CMPXCHG right? 
Then, add it here:

	switch (cmd) {
	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
	case FUTEX_UNLOCK_PI:
	case FUTEX_TRYLOCK_PI:
	case FUTEX_WAIT_REQUEUE_PI:
	case FUTEX_CMP_REQUEUE_PI:
  		if (!futex_cmpxchg_enabled)
  			return -ENOSYS;
  	}

>   
> @@ -3744,6 +3745,8 @@ long do_futex(u32 __user *uaddr, int op,
>   		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
>   	case FUTEX_LOCK_PI:
>   		flags |= FLAGS_CLOCKRT;
> +		fallthrough;
> +	case FUTEX_LOCK_PI2:
>   		return futex_lock_pi(uaddr, flags, timeout, 0);
>   	case FUTEX_UNLOCK_PI:
>   		return futex_unlock_pi(uaddr, flags);
> @@ -3764,6 +3767,7 @@ static inline bool futex_cmd_has_timeout
>   	switch (cmd) {
>   	case FUTEX_WAIT:
>   	case FUTEX_LOCK_PI:
> +	case FUTEX_LOCK_PI2:
>   	case FUTEX_WAIT_BITSET:
>   	case FUTEX_WAIT_REQUEUE_PI:
>   		return true;
> 

Thanks,
	André
