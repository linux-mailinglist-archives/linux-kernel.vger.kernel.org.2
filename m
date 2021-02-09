Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD53150CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBINvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:51:14 -0500
Received: from foss.arm.com ([217.140.110.172]:51992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhBINs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:48:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E579BED1;
        Tue,  9 Feb 2021 05:47:42 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D39E3F73D;
        Tue,  9 Feb 2021 05:47:40 -0800 (PST)
Subject: Re: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on
 newly idle cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, fweisbec@gmail.com,
        tglx@linutronix.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org
Cc:     qais.yousef@arm.com
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-6-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <86be4035-9350-6cd2-9859-9444307f9033@arm.com>
Date:   Tue, 9 Feb 2021 14:47:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205114830.781-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 12:48, Vincent Guittot wrote:
> Instead of waking up a random and already idle CPU, we can take advantage
> of this_cpu being about to enter idle to run the ILB and update the
> blocked load.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/linux/sched/nohz.h |  2 ++
>  kernel/sched/fair.c        | 11 ++++++++---
>  kernel/sched/idle.c        |  6 ++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> index 6d67e9a5af6b..74cdc4e87310 100644
> --- a/include/linux/sched/nohz.h
> +++ b/include/linux/sched/nohz.h
> @@ -9,8 +9,10 @@
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  extern void nohz_balance_enter_idle(int cpu);
>  extern int get_nohz_timer_target(void);
> +extern void nohz_run_idle_balance(int cpu);
>  #else
>  static inline void nohz_balance_enter_idle(int cpu) { }
> +static inline void nohz_run_idle_balance(int cpu) { }
>  #endif

(1) Since nohz_run_idle_balance() would be an interface one sched class
(fair) exports to another (idle) I wonder if kernel/sched/sched.h would
be the more appropriate include file to export/define it?

nohz_balance_exit_idle() is exported via kernel/sched/sched.h (used only
within the scheduler) whereas nohz_balance_enter_idle() is exported via
include/linux/sched/nohz.h (used in kernel/time/tick-sched.c).

Isn't include/linux/sched/nohz.h the interface between kernel/sched/ and
kernel/time?

There is one exception already though: calc_load_nohz_remote() defined
in kernel/sched/loadavg.c and (only) used in kernel/sched/core.c.


(2) Is there a need for an extra function nohz_run_idle_balance()?
do_idle() could call nohz_idle_balance() directly in case in would be
exported instead.

[...]
