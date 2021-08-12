Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF83EA533
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhHLNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:10:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:10594 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhHLNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:10:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210812130946euoutp021d42809f3a58c134ccb5a982487f0495~akSEJHpdJ1759917599euoutp02h
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210812130946euoutp021d42809f3a58c134ccb5a982487f0495~akSEJHpdJ1759917599euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628773786;
        bh=GLFb05jS4ir6uR4QUPEXPyqLsR6cczyiIFRKZvLZ2tk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BczaGPP7VVmWHaEm2qdRlPmkzi4f12ZaQSEPGYsEfyJMMs2/ptLHoqd42j33ecs/V
         +xhlA3yctXQiXRSYkZAR7PufEz+qphWnIAc4QkAD+xy/pgRLXpnDnPr5/y3Fmnc7O1
         q32tBYaIHQoLZRLeooSROJmHxYONF4svDSodlri8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210812130945eucas1p2816f44cc28356c67e1944c8a66a622c7~akSDz6euO1983919839eucas1p24;
        Thu, 12 Aug 2021 13:09:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.45.56448.99D15116; Thu, 12
        Aug 2021 14:09:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210812130945eucas1p117fc1e90f31c8d9fd177932cd1a18512~akSDcs5A20283102831eucas1p1Z;
        Thu, 12 Aug 2021 13:09:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210812130945eusmtrp12b4ab36ca3f1f095465f5e591ee9e780~akSDb8LOA2752927529eusmtrp1d;
        Thu, 12 Aug 2021 13:09:45 +0000 (GMT)
X-AuditID: cbfec7f5-d53ff7000002dc80-ad-61151d9947ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.39.31287.99D15116; Thu, 12
        Aug 2021 14:09:45 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210812130945eusmtip151a55ce4b3552d3271224e9817a4aa02~akSC-wzVB0878308783eusmtip1S;
        Thu, 12 Aug 2021 13:09:45 +0000 (GMT)
Subject: Re: [patch V2 02/10] hrtimer: Consolidate reprogramming code
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <aa9eb756-b802-6dcc-c74c-425e732aee46@samsung.com>
Date:   Thu, 12 Aug 2021 15:09:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210713135158.054424875@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87ozZUUTDXb0mVu8u7CczWJB015W
        i8u75rBZbOyZxGpxvPcAk8XmTVOZHdg8Nq/Q8ti0qpPN4925c+we7/ddZfP4vEkugDWKyyYl
        NSezLLVI3y6BK+P9zktMBR8NK/59Xs7WwHhVo4uRk0NCwERi7dFvjF2MXBxCAisYJS7ev8ME
        4XxhlOhaeoYFwvnMKHFszV8WmJa//xYzQySWM0r0f25hh3A+Mkr0rHvADFIlLOAqMaFhAxOI
        LSLgL/GsuR+sm1lgHaPElW9CIDabgKFE19suNhCbV8BO4vPldjCbRUBVouf9KzBbVCBZYuKT
        SawQNYISJ2c+AZvDKWAqMWXVejaImfISzVtnM0PY4hK3nswH+0FC4AqHREvrYSaIs10kzs37
        yg5hC0u8Or4FypaROD25hwWioZlR4uG5tewQTg+jxOWmGYwQVdYSd879AlrHAbRCU2L9Ln2I
        sKPEhpXHGEHCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJeQKj0iwkr81C
        8s4sJO/MQti7gJFlFaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmDqOf3v+NcdjCtefdQ7
        xMjEwXiIUYKDWUmEd6ecUKIQb0piZVVqUX58UWlOavEhRmkOFiVx3l1b18QLCaQnlqRmp6YW
        pBbBZJk4OKUamIqynm28YlN8bIOAxS7nbflx4bsnnCuRDsickFrTZXf0q9eX7KPND82net7n
        u9b37/lBuU2+H+z/ef9cfHO5cVTzN/elSxfFFIcflf9nVPDoYETSnktcbH6X5vxY9oY3JyT5
        0UWPHRz1mdP9PUpuKlttX+j1WOZb8u8YXl6/Kzsffmu091p2MKh1T9n+S0JHbv9eN09QI8Nz
        wnwOjRn373BuPbBv58yl2s43Fm8LcrrVWrzo+IqtcZ2modyXGnYG3CuOWfpH1cGtyCt2zR7j
        iBCPr1d7Cx627b97q311W/OxPvXjHz6kN5/fdnOhW4bPjX75h+lZ7m2ij2zrrhm9EXhmfXkn
        V+9JsT0GbyYaRC9QYinOSDTUYi4qTgQAp32+5KwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7ozZUUTDRofy1m8u7CczWJB015W
        i8u75rBZbOyZxGpxvPcAk8XmTVOZHdg8Nq/Q8ti0qpPN4925c+we7/ddZfP4vEkugDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P9zktMBR8N
        K/59Xs7WwHhVo4uRk0NCwETi77/FzF2MXBxCAksZJY6d+84IkZCRODmtgRXCFpb4c62LDaLo
        PaNE/49nzCAJYQFXiQkNG5hAbBEBX4mm3gWsIEXMAhsYJea9fwCWEBKIl+hcPhXMZhMwlOh6
        CzKJk4NXwE7i8+V2MJtFQFWi5/0rMFtUIFniw+mlrBA1ghInZz5hAbE5BUwlpqxaD1bDLGAm
        MW/zQ2YIW16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07M
        LS7NS9dLzs/dxAiMtW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeHfKCSUK8aYkVlalFuXHF5Xm
        pBYfYjQF+mcis5Rocj4w2vNK4g3NDEwNTcwsDUwtzYyVxHm3zl0TLySQnliSmp2aWpBaBNPH
        xMEp1cAUqFUe/M/cwvVQ7fODOSazd7t8itnHEHBctyDThuPR3F1/T71aonyq/tia1W12mcu2
        nVx+W8Zq5geLba+WbQvZ8nvbyr/7eTb6FXOdCIj5GxOxSc/h0b7zzTNWXX3Cy3hf4fde73fF
        6i8yk/ZoK2ZcqVjm+ev5g9byvw57RXJeHP43q5HTIOXBkSAL5VSllB89R9Ves8YXrZ7y/Hws
        j2CXxcxvH1PKBO4Fm/Z9/ffI+wOfwu6bX6Z9kXg8v7KRYWGU3QPlM67XJp7efOh8tPsDRgUr
        dvvoVbarbrqUs3kySJ07vPfDjzX/QxnVJX4p7exxNFCzuZLFdzj2avSS3ppJU5n9WkrP8707
        wS34U+SQqhJLcUaioRZzUXEiAADc2LE+AwAA
X-CMS-MailID: 20210812130945eucas1p117fc1e90f31c8d9fd177932cd1a18512
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210812130945eucas1p117fc1e90f31c8d9fd177932cd1a18512
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210812130945eucas1p117fc1e90f31c8d9fd177932cd1a18512
References: <20210713133945.063650594@linutronix.de>
        <20210713135158.054424875@linutronix.de>
        <CGME20210812130945eucas1p117fc1e90f31c8d9fd177932cd1a18512@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.07.2021 15:39, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> This code is mostly duplicated. The redudant store in the force reprogram
> case does no harm and the in hrtimer interrupt condition cannot be true for
> the force reprogram invocations.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/time/hrtimer.c |   72 ++++++++++++++++++++------------------------------
>   1 file changed, 29 insertions(+), 43 deletions(-)
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This patch landed in today's linux-next (next-20210812) as commit 
b14bca97c9f5 ("hrtimer: Consolidate reprogramming code"). It breaks 
booting of many of my test machines: ARM 32bit Exynos based boards, ARM 
64bit QEmu virt machine or ARM64 Qualcomm DragonBoard410c board.

I've managed to catch the following log on QEmu's virt ARM64 machine:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     0-...!: (0 ticks this GP) idle=330/0/0x0 softirq=42/42 fqs=0  
(false positive?)
  (detected by 1, t=6502 jiffies, g=-1091, q=115)

============================================
WARNING: possible recursive locking detected
5.14.0-rc5+ #10668 Not tainted
--------------------------------------------
swapper/1/0 is trying to acquire lock:
ffffbb9c1e4ca1d8 (rcu_node_0){-.-.}-{2:2}, at: 
rcu_dump_cpu_stacks+0x68/0x1c4

but task is already holding lock:
ffffbb9c1e4ca1d8 (rcu_node_0){-.-.}-{2:2}, at: 
rcu_sched_clock_irq+0x83c/0x1778

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(rcu_node_0);
   lock(rcu_node_0);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

1 lock held by swapper/1/0:
  #0: ffffbb9c1e4ca1d8 (rcu_node_0){-.-.}-{2:2}, at: 
rcu_sched_clock_irq+0x83c/0x1778

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-rc5+ #10668
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x0/0x1d0
  show_stack+0x14/0x20
  dump_stack_lvl+0x88/0xb0
  dump_stack+0x14/0x2c
  __lock_acquire+0x17a4/0x1840
  lock_acquire+0x130/0x3e8
  _raw_spin_lock_irqsave+0x78/0x148
  rcu_dump_cpu_stacks+0x68/0x1c4
  rcu_sched_clock_irq+0x11e8/0x1778
  update_process_times+0x88/0xd0
  tick_sched_handle.isra.19+0x30/0x50
  tick_sched_timer+0x48/0x98
  __hrtimer_run_queues+0x380/0x5b0
  hrtimer_interrupt+0xe4/0x240
  arch_timer_handler_virt+0x30/0x40
  handle_percpu_devid_irq+0xc0/0x3d0
  handle_domain_irq+0x58/0x88
  gic_handle_irq+0xa8/0xc8
  call_on_irq_stack+0x28/0x38
  do_interrupt_handler+0x54/0x60
  el1_interrupt+0x2c/0x108
  el1h_64_irq_handler+0x14/0x20
  el1h_64_irq+0x74/0x78
  arch_cpu_idle+0x14/0x20
  default_idle_call+0x88/0x390
  do_idle+0x200/0x290
  cpu_startup_entry+0x20/0x80
  secondary_start_kernel+0x1c0/0x1f0
  __secondary_switched+0x7c/0x80

I hope it helps fixing the issue.

> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -652,21 +652,24 @@ static inline int hrtimer_hres_active(vo
>   	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
>   }
>   
> -/*
> - * Reprogram the event source with checking both queues for the
> - * next event
> - * Called with interrupts disabled and base->lock held
> - */
>   static void
> -hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
> +__hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
> +		    struct hrtimer *next_timer, ktime_t expires_next)
>   {
> -	ktime_t expires_next;
> +	/*
> +	 * If the hrtimer interrupt is running, then it will reevaluate the
> +	 * clock bases and reprogram the clock event device.
> +	 */
> +	if (cpu_base->in_hrtirq)
> +		return;
>   
> -	expires_next = hrtimer_update_next_event(cpu_base);
> +	if (expires_next > cpu_base->expires_next)
> +		return;
>   
>   	if (skip_equal && expires_next == cpu_base->expires_next)
>   		return;
>   
> +	cpu_base->next_timer = next_timer;
>   	cpu_base->expires_next = expires_next;
>   
>   	/*
> @@ -689,7 +692,23 @@ hrtimer_force_reprogram(struct hrtimer_c
>   	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
>   		return;
>   
> -	tick_program_event(cpu_base->expires_next, 1);
> +	tick_program_event(expires_next, 1);
> +}
> +
> +/*
> + * Reprogram the event source with checking both queues for the
> + * next event
> + * Called with interrupts disabled and base->lock held
> + */
> +static void
> +hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
> +{
> +	ktime_t expires_next;
> +
> +	expires_next = hrtimer_update_next_event(cpu_base);
> +
> +	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
> +			    expires_next);
>   }
>   
>   /* High resolution timer related functions */
> @@ -835,40 +854,7 @@ static void hrtimer_reprogram(struct hrt
>   	if (base->cpu_base != cpu_base)
>   		return;
>   
> -	/*
> -	 * If the hrtimer interrupt is running, then it will
> -	 * reevaluate the clock bases and reprogram the clock event
> -	 * device. The callbacks are always executed in hard interrupt
> -	 * context so we don't need an extra check for a running
> -	 * callback.
> -	 */
> -	if (cpu_base->in_hrtirq)
> -		return;
> -
> -	if (expires >= cpu_base->expires_next)
> -		return;
> -
> -	/* Update the pointer to the next expiring timer */
> -	cpu_base->next_timer = timer;
> -	cpu_base->expires_next = expires;
> -
> -	/*
> -	 * If hres is not active, hardware does not have to be
> -	 * programmed yet.
> -	 *
> -	 * If a hang was detected in the last timer interrupt then we
> -	 * do not schedule a timer which is earlier than the expiry
> -	 * which we enforced in the hang detection. We want the system
> -	 * to make progress.
> -	 */
> -	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
> -		return;
> -
> -	/*
> -	 * Program the timer hardware. We enforce the expiry for
> -	 * events which are already in the past.
> -	 */
> -	tick_program_event(expires, 1);
> +	__hrtimer_reprogram(cpu_base, true, timer, expires);
>   }
>   
>   /*
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

