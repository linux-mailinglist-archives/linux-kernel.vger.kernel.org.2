Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F533E8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCQFNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:13:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:38951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhCQFN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615957963;
        bh=ZFva9yiX882CFVe+fFagKCUaTBI6SVZhMOBEntuPmNk=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=L2DqoK3jsb/cFZxpcbbxxH4o9wp46LCEfjLZF5DfcD3m7jrWRsQRjmC1ParwOnGpK
         J+Hqxho78cC8fgiW0/ZkyTJjtb9YkzVJBIMjdRwvr8MY05RTlAc1BifFpYM/MjziqG
         86fYQ7ed8dJIuQwrftf7jH/9h+Bf5cFpoRjOi1Eo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzjt-1lBEKg1quX-00XHfR; Wed, 17
 Mar 2021 06:12:43 +0100
Message-ID: <284138d64b5010ebe5a6490402dc01d006677dd1.camel@gmx.de>
Subject: Re: [PATCH] sched: rename __prepare_to_swait() to
 add_swait_queue_locked()
From:   Mike Galbraith <efault@gmx.de>
To:     Wang Qing <wangqing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Mar 2021 06:12:41 +0100
In-Reply-To: <1615895969-3376-1-git-send-email-wangqing@vivo.com>
References: <1615895969-3376-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WuEAFbSwgJnj51UAnoueSxhykJRlwk66RtKy1eyrEG5lB/vZ8ES
 rEV1zmh3FeUcwlV6Ric+mC7qAK97+gRoxD4Nq+W4e0qScTZtSCoprIg1SPHd05Kf+TYkfR5
 PkfPq2nYys3B30omYgYhqKgXQGUzq5aI3QNoEV8xJXCSQ0wi4YWFz38aB8p6ZHB85pFW+bG
 hXcsuHBlFOQ9DvVt4A3Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JYhtEkZGRx4=:pHrGW5jOhjnBey8s3tG+Rk
 MevFzSmW5eGdMi/UIAwEsIQWUrFVZWRriCxnVulS2eN8TNn3oP+HDO03KlNKzmYv6ib/9WL3v
 4OqA1BSCV8xda9Xfgfr3GqXRNpmzvmBIp9XUUV4/bbMf3gETbb2H00XQZuqFCwC3tgP/Tla1A
 XjmXrjJ49Asu5XLcYcdq7C5ZEhaYQfMoTmUXbcLMkd5Yg8QOkPgpklVbZgLhifJNiTWpQObl6
 BhKjvDVUOzpcrhRHWqrmwC/COJedvEynb/s62heaR8pKcDOsMTUmc9IaNhacM4Q8HK5yv5hvF
 lSov742u9Jo4bbisKZZz23vfAkQkQGYc2CFpVi0FX2P52+wgUM5WXXFDj7CONV9PjCI5K/nDU
 gEVnITeFfonjAFI1OxH1i8X8H/mGjO2+864/bEN7OuHKpuW1bMS+4ojjUaXjW0kLpyhmIobkO
 5SJT2idocyT6VqhHSp9DisZ0s/UOEjM7De1n8gZqWAfiu0gdLOh9CNjdxgH52EzUnD7mJFJTY
 R0INg2Jwx6BHLqbZa3we8clXis8MhbTTQMr3067EGfIan5bp9ZHkU3LVM3pQ0gmqKkjx7nC+l
 Yq6s6tv1s8ljrxZ4bhnzbIuW+GvB4aRU84a4YkhU95Yux+3zMCAD82vgA+DoEtnO/nt5/Y8kG
 Wm0uMkGCAtddPncmxBRyVYfkrW+bHgfST/zDHt7GbxBkRRC6yq0ERPdFruOnPpLRL2qozRQa3
 qOLu9lV0oAQgWO+NdF+tDEla+nAd86aAq4h1vQY9zR26Jcxi1bsSvqCXSivOA0WDkjVmBBKOz
 pWDxf48JZ6FQN9/Ql9iv+29f9kE0QgNg+UaNVMmB52LH7nZYc2/FTuPezOvnlMtBO7ugWwnbK
 tUMGv5sjwzIu/US90LOQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-16 at 19:59 +0800, Wang Qing wrote:
> This function just puts wait into queue, and does not do an operation si=
milar
> to prepare_to_wait() in wait.c.
> And during the operation, the caller needs to hold the lock to protect.

I see zero benefit to churn like this.  You're taking a dinky little
file that's perfectly clear (and pretty), and restating the obvious.

>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  kernel/sched/completion.c | 2 +-
>  kernel/sched/sched.h      | 2 +-
>  kernel/sched/swait.c      | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index a778554..3d28a5a
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -79,7 +79,7 @@ do_wait_for_common(struct completion *x,
>  				timeout =3D -ERESTARTSYS;
>  				break;
>  			}
> -			__prepare_to_swait(&x->wait, &wait);
> +			add_swait_queue_locked(&x->wait, &wait);
>  			__set_current_state(state);
>  			raw_spin_unlock_irq(&x->wait.lock);
>  			timeout =3D action(timeout);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 10a1522..0516f50
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2719,4 +2719,4 @@ static inline bool is_per_cpu_kthread(struct task_=
struct *p)
>  #endif
>
>  void swake_up_all_locked(struct swait_queue_head *q);
> -void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue =
*wait);
> +void add_swait_queue_locked(struct swait_queue_head *q, struct swait_qu=
eue *wait);
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index 7a24925..f48a544
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -82,7 +82,7 @@ void swake_up_all(struct swait_queue_head *q)
>  }
>  EXPORT_SYMBOL(swake_up_all);
>
> -void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue =
*wait)
> +void add_swait_queue_locked(struct swait_queue_head *q, struct swait_qu=
eue *wait)
>  {
>  	wait->task =3D current;
>  	if (list_empty(&wait->task_list))
> @@ -94,7 +94,7 @@ void prepare_to_swait_exclusive(struct swait_queue_hea=
d *q, struct swait_queue *
>  	unsigned long flags;
>
>  	raw_spin_lock_irqsave(&q->lock, flags);
> -	__prepare_to_swait(q, wait);
> +	add_swait_queue_locked(q, wait);
>  	set_current_state(state);
>  	raw_spin_unlock_irqrestore(&q->lock, flags);
>  }
> @@ -114,7 +114,7 @@ long prepare_to_swait_event(struct swait_queue_head =
*q, struct swait_queue *wait
>  		list_del_init(&wait->task_list);
>  		ret =3D -ERESTARTSYS;
>  	} else {
> -		__prepare_to_swait(q, wait);
> +		add_swait_queue_locked(q, wait);
>  		set_current_state(state);
>  	}
>  	raw_spin_unlock_irqrestore(&q->lock, flags);

