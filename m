Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7C38CB2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhEUQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhEUQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:39:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IHfNDbo3bgzbKAqWdiJLeIIrKO4kOIvM8kvSz8Cnzsw=; b=JQnU7VbOuBaqcY8oa/BCFtn2i0
        eO7El38EC0NTQ+zUXRUmgrb+knNgQ/AF4b+oeht46HjPQxN50qRVf+8ZJnnhWhtbKFgCUKK7uLNES
        Gxu1gabrjdq072pcaBp/ojNpQOQwisMS4bb2eQ8I9nkW8rcAA7vjFEz2JmioPcKML56DTvtVGQPhQ
        qaQ+Mxa4G4TY/Kld1HBjbTqmQ4yuY430pMJaA/ckTo9mflYbpgMr+uJ3fPDyPsGDWzF2hJqvUagz0
        zZOd/vzSHYBRBhqy2zHdMO+n12BNXVl83utKCH+DLJyF6EOdeJd/8UK5JESPCCDdDD86i5AkmVx4X
        vbIJF1IQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk89f-00HHdy-GA; Fri, 21 May 2021 16:37:43 +0000
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
To:     chenguanyou <chenguanyou9338@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
References: <20210521132503.19740-1-chenguanyou@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2421c8ea-de79-90df-08b6-51f15e859657@infradead.org>
Date:   Fri, 21 May 2021 09:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521132503.19740-1-chenguanyou@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 6:25 AM, chenguanyou wrote:
> Some kernel threads are always in D state, when we enable hung_task,
> it will misjudge, we should skip these to narrow the scope.
> 
> exp mtk mobilephone:
> root            420   420      2       0      0 kwdt_thread         0 D wdtk-0
> root            421   421      2       0      0 kwdt_thread         0 D wdtk-1
> root            422   422      2       0      0 kwdt_thread         0 D wdtk-2
> root            423   423      2       0      0 kwdt_thread         0 D wdtk-3
> root            424   424      2       0      0 kwdt_thread         0 D wdtk-4
> root            425   425      2       0      0 kwdt_thread         0 D wdtk-5
> root            426   426      2       0      0 kwdt_thread         0 D wdtk-6
> root            427   427      2       0      0 kwdt_thread         0 D wdtk-7
> root            435   435      2       0      0 mtk_lpm_monitor_thread 0 D LPM-0
> root            436   436      2       0      0 mtk_lpm_monitor_thread 0 D LPM-1
> root            437   437      2       0      0 mtk_lpm_monitor_thread 0 D LPM-2
> root            438   438      2       0      0 mtk_lpm_monitor_thread 0 D LPM-3
> root            439   439      2       0      0 mtk_lpm_monitor_thread 0 D LPM-4
> root            440   440      2       0      0 mtk_lpm_monitor_thread 0 D LPM-5
> root            441   441      2       0      0 mtk_lpm_monitor_thread 0 D LPM-6
> root            442   442      2       0      0 mtk_lpm_monitor_thread 0 D LPM-7
> 
> Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
> ---
>  include/linux/sched/sysctl.h |  4 ++++
>  kernel/hung_task.c           | 17 +++++++++++++++++
>  kernel/sysctl.c              | 16 ++++++++++++++++
>  lib/Kconfig.debug            | 24 ++++++++++++++++++++++++
>  4 files changed, 61 insertions(+)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 3c31ba88aca5..e8a9a28215bf 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -14,11 +14,15 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
>  #define sysctl_hung_task_all_cpu_backtrace 0
>  #endif /* CONFIG_SMP */
>  
> +#define TASK_COMM_LEN 16
> +
>  extern int	     sysctl_hung_task_check_count;
>  extern unsigned int  sysctl_hung_task_panic;
>  extern unsigned long sysctl_hung_task_timeout_secs;
>  extern unsigned long sysctl_hung_task_check_interval_secs;
>  extern int sysctl_hung_task_warnings;
> +extern unsigned int sysctl_hung_task_filter_kthread;
> +extern char sysctl_hung_task_check_comm[TASK_COMM_LEN];
>  int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos);
>  #else
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 396ebaebea3f..e018563d4882 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched/sysctl.h>
>  
>  #include <trace/events/sched.h>
> +#include <linux/string.h>
>  
>  /*
>   * The number of tasks checked:
> @@ -48,6 +49,16 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
>   */
>  unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>  
> +/*
> + * Non zero means no checking kthread

      Non-zero

(also mentioned in v1 review, whereas this is v2, I guess, although
it doesn't say that it is v2, but it should say that.)

> + */
> +unsigned int __read_mostly sysctl_hung_task_filter_kthread = CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD;
> +
> +/*
> + * Only one
> + */
> +char __read_mostly sysctl_hung_task_check_comm[TASK_COMM_LEN] = CONFIG_DEFAULT_HUNG_TASK_CHECK_COMM;
> +
>  int __read_mostly sysctl_hung_task_warnings = 10;
>  
>  static int __read_mostly did_panic;
> @@ -88,6 +99,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
>  	unsigned long switch_count = t->nvcsw + t->nivcsw;
>  
> +	if (unlikely(strlen(sysctl_hung_task_check_comm) && !strstr(t->comm, sysctl_hung_task_check_comm)))
> +		return;
> +
> +	if (unlikely(sysctl_hung_task_filter_kthread && t->flags & PF_KTHREAD))
> +		return;
> +
>  	/*
>  	 * Ensure the task is not frozen.
>  	 * Also, skip vfork and any other user process that freezer should skip.
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09b5dc1..1daede87c88d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2519,6 +2519,22 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &neg_one,
>  	},
> +	{
> +		.procname	= "hung_task_filter_kthread",
> +		.data		= &sysctl_hung_task_filter_kthread,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "hung_task_check_comm",
> +		.data		= &sysctl_hung_task_check_comm,
> +		.maxlen		= TASK_COMM_LEN,
> +		.mode		= 0644,
> +		.proc_handler	= proc_dostring,
> +	},

(copy-paste from v1 review:)

These new sysctls should be documented in Documentation/admin-guide/sysctl/kernel.rst.


>  #endif
>  #ifdef CONFIG_RT_MUTEXES
>  	{
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2c7f46b366f1..6eab8cf0c37f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1101,6 +1101,30 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>  	  A timeout of 0 disables the check.  The default is two minutes.
>  	  Keeping the default should be fine in most cases.
>  
> +config DEFAULT_HUNG_TASK_FILTER_KTHREAD
> +	int "Default filter kthread for hung task"
> +	depends on DETECT_HUNG_TASK
> +	range 0 1
> +	default 0
> +	help
> +	  This option controls filter kthread used to determine when

(again:)
	                                      uses

> +	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skip.

(again:)
	                                                                      skipped.

> +
> +	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
> +	  sysctl or by writing a value to
> +	  /proc/sys/kernel/hung_task_filter_kthread.
> +
> +	  A filter of 1 disables the check

(again:)
	                             check.

> +
> +config DEFAULT_HUNG_TASK_CHECK_COMM
> +	string "Default check only one comm"
> +	depends on DETECT_HUNG_TASK
> +	default ""
> +	help
> +	  It can be adjusted at runtime via the kernel.hung_task_check_comm
> +	  sysctl or by writing a value to
> +	  /proc/sys/kernel/hung_task_check_comm.
> +

(again:)
That help text doesn't tell how the Kconfig symbol is used.

>  config BOOTPARAM_HUNG_TASK_PANIC
>  	bool "Panic (Reboot) On Hung Tasks"
>  	depends on DETECT_HUNG_TASK
> 


-- 
~Randy
