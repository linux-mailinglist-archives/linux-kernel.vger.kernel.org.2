Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E311040EAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhIPTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhIPTpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5337261212;
        Thu, 16 Sep 2021 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631821454;
        bh=48MaZserzpuIZcXtFDW9D0xKDZ69TZAefHpwT3WYzsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBXk+yeR3GPWNvj/FDJ4O+9Bcyy+ApJLHN6H3HGaRc2BL04tMp4+kas6XxpGMN9DR
         IYILgJp9w0LeHsWqD0IzZTZKDBehsdAyRhTcoldfNLfaOFsHekJxy17c0lyTY2P+XZ
         W5yWrMLcMGn2+EYe81stDOO1l1zGkHEDw1qaW0Ig=
Date:   Thu, 16 Sep 2021 12:44:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jinhui Guo <guojinhui@huawei.com>
Cc:     <pmladek@suse.com>, <peterz@infradead.org>,
        <valentin.schneider@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] watchdog/softlockup: Fix softlockup_stop_all()
 hungtask bug
Message-Id: <20210916124413.89735fd447667b627552df55@linux-foundation.org>
In-Reply-To: <20210916175650.1380-1-guojinhui@huawei.com>
References: <20210916175650.1380-1-guojinhui@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 01:56:50 +0800 Jinhui Guo <guojinhui@huawei.com> wrote:

> If NR_CPUS equal to 1, it would trigger hungtask, it can be
> triggered by follow command:
> 	echo 0 > /proc/sys/kernel/watchdog
> 	echo 1 > /proc/sys/kernel/watchdog
> The hungtask stack:
> 	__schedule
> 	schedule
> 	schedule_timeout
> 	__wait_for_common
> 	softlockup_stop_fn
> 	lockup_detector_reconfigure
> 	proc_watchdog_common
> 	proc_watchdog
> 	proc_sys_call_handler
> 	vfs_write
> 	ksys_write
> The watchdog_allowed_mask is completely cleared when the
> watchdog is disabled. But the macro for_each_cpu() assume
> all masks are "1" when macro NR_CPUS equal to 1. It makes
> watchdog_allowed_mask not work at all.
> 
> ...
>
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -175,10 +175,11 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
>  	return cpumask_first(srcp);
>  }
>  
> +/* It should check cpumask in some special case, such as watchdog */
>  #define for_each_cpu(cpu, mask)			\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> +	for ((cpu) = 0; (cpu) < 1 && test_bit(0, cpumask_bits(mask)); (cpu)++)
>  #define for_each_cpu_not(cpu, mask)		\
> -	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> +	for ((cpu) = 0; (cpu) < 1 && !test_bit(0, cpumask_bits(mask)); (cpu)++)
>  #define for_each_cpu_wrap(cpu, mask, start)	\
>  	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
>  #define for_each_cpu_and(cpu, mask1, mask2)	\

x86_64 allnoconfig:

ld: arch/x86/kernel/cpu/cacheinfo.o: in function `populate_cache_leaves':
cacheinfo.c:(.text+0xa27): undefined reference to `cpu_llc_shared_map'
ld: cacheinfo.c:(.text+0xa49): undefined reference to `cpu_llc_shared_map'

Because the new for_each_cpu() now references `mask' and some code isn't
able to handle that change.  There are probably other instances of this
across all our architectures and configs.

