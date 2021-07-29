Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316EA3DA0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhG2KU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhG2KUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:20:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PlYGQRE8nU6cBMMIO1sSgVGJquY2xkxVIjdVP19CHqk=; b=osdUaJK8nuI8R9RmGnF8nG6CSO
        LPaZYpdWu28DWbWljhilnGKStZ+rZylsMEvbKwPAk4tHDqqAdx7cweSeCFmSf2cTQzf7bwpQhr9mw
        4pMxfES9c3H6dumTUsbI1vcqYMoXEVh/ajPfEmpRqNWCwGVGrDF1URVj+k4BrFkMrT0MtollFCiIC
        akMVg4a3fkaZlTydugjUFuwJZK8uarHhtizN9L7q6JWlCCSrr/mnTfuHYIpydcEr/Zu31V13Rl5qf
        rXY60CWHzNVPDrcegX2ESN39JXHYDh8rmQVrebATyekQRJbSRjAp+OkByt2xcOxCqAgKr+Fis1lJm
        F6ChIPlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m938x-003wPM-KN; Thu, 29 Jul 2021 10:20:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9061B30005A;
        Thu, 29 Jul 2021 12:19:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50DE22999722D; Thu, 29 Jul 2021 12:19:57 +0200 (CEST)
Date:   Thu, 29 Jul 2021 12:19:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.co, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH][RFC] sched/cpuacct: Fix cpuacct charge
Message-ID: <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
References: <20210720060441.22550-1-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720060441.22550-1-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:04:41PM +0800, Li RongQing wrote:
> get_irq_regs only work for current running cpu, but the task, whose
> cpuacct will be charged, maybe run different cpu, like Cpu 2 wake
> up a kernel thread to CPU 3, cause CPU 3 task are charged with the
> following stack
> 
>   cpuacct_charge+0xd8/0x100
>   update_curr+0xe1/0x1e0
>   enqueue_entity+0x144/0x6e0
>   enqueue_task_fair+0x93/0x900
>   ttwu_do_activate+0x4b/0x90
>   try_to_wake_up+0x20b/0x530
>   ? update_dl_rq_load_avg+0x10f/0x210
>   swake_up_locked.part.1+0x13/0x40
>   swake_up_one+0x27/0x40
>   rcu_process_callbacks+0x484/0x4f0
>   ? run_rebalance_domains_bt+0x5a/0x180
>   __do_softirq+0xe3/0x308
>   irq_exit+0xf0/0x100
>   smp_apic_timer_interrupt+0x74/0x160
>   apic_timer_interrupt+0xf/0x20
>   </IRQ>
>  RIP: 0033:0x456947
> 
> so define a get_irq_regs_cpu which returns the required cpu irq registers
> 
> BUT it should be not safe, and do not know what it should be like in MIPS?
> 
> Fixes: dbe9337109c2 "(sched/cpuacct: Fix charge cpuacct.usage_sys)"
> Co-developed-by: Zhao Jie <zhaojie17@baidu.com>
> Signed-off-by: Zhao Jie <zhaojie17@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/asm-generic/irq_regs.h | 5 +++++
>  kernel/sched/cpuacct.c         | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/irq_regs.h b/include/asm-generic/irq_regs.h
> index 2e7c6e8..93e2579 100644
> --- a/include/asm-generic/irq_regs.h
> +++ b/include/asm-generic/irq_regs.h
> @@ -21,6 +21,11 @@ static inline struct pt_regs *get_irq_regs(void)
>  	return __this_cpu_read(__irq_regs);
>  }
>  
> +static inline struct pt_regs *get_irq_regs_cpu(int cpu)
> +{
> +	return per_cpu(__irq_regs, cpu);
> +}

This primitive just cannot be right... it'll get you some random data.
