Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985A7414C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhIVOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:33:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46560 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhIVOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:33:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F3B220205;
        Wed, 22 Sep 2021 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632321126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DfbelqaIvrfCHqJ2q9QkG7wzQP9mxVq4ZLiWSI9B2x4=;
        b=ezOa7kllnezuOqhsTrVEX08AXRkLHvu4t0vCJ8v71cYkJSPHRzmSLVn58x0R7WP9ulIIZT
        XnP2Puh0GgbHXavl64ETquwqJ6zO8xEa4fgkWOv/V9T3qaqPZIeZktlIcP85mnI6fFCYFp
        ffwafpF89inMdQFCj1oAUU/RM4PqBZ0=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A3E0A3BA0;
        Wed, 22 Sep 2021 14:32:06 +0000 (UTC)
Date:   Wed, 22 Sep 2021 16:32:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jinhui Guo <guojinhui@huawei.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/softlockup: Fix softlockup_stop_all() hungtask
 bug
Message-ID: <20210922143206.GA21336@pathway.suse.cz>
References: <20210922095202.1655-1-guojinhui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922095202.1655-1-guojinhui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-09-22 17:52:02, Jinhui Guo wrote:
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
> Fixes: be45bf5395e0 ("watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug")
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jinhui Guo <guojinhui@huawei.com>
> ---
>  arch/x86/include/asm/smp.h | 5 +++++
>  include/linux/cpumask.h    | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 630ff08532be..f5d3ca5696b3 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -21,7 +21,12 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  
>  static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  {
> +#ifdef CONFIG_SMP
>  	return per_cpu(cpu_llc_shared_map, cpu);
> +#else
> +	/* cpu_llc_shared_map is not defined while !CONFIG_SMP */
> +	return cpu_all_mask;
> +#endif

This looks dangerous. The cpumask returned can be modified,
for example, in

static void remove_siblinginfo(int cpu)
{
[...]
	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
[...]
	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
[...]
}

With you patch, this code would clear "cpu_all_mask" which
is wrong!

We need to fix this another way. I see few possibilities:

1. Define cpu_llc_shared_map even with NR_CPUS == 1.

2. Do not compile the problematic code with NR_CPUS == 1.
   It seems to be needed for CPU hotplug so it does not
   make sense to have it.

3. Define for_each_cpu_optimized() that would behave the same
   way as the non-patched for_each_cpu(). It can be
   used in remove_siblinginfo().

4. Do not patch for_each_cpu(). Instead, add for_each_cpu_safe()
   that would work correctly even with NR_CPUS == 1.
   It can than be used in watchdog.c.


IMHO, the 2nd solution would be the best if the change
is simple.

The 3rd solution is my other favorite. It would keep
the default for_each_cpu() safe. People might use
for_each_cpu_optimized() only when they know what
they are doing. It will be easy to find these
locations.

Best Regards,
Petr
