Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DC388CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbhESLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:30:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhESLaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:30:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4097EAF37;
        Wed, 19 May 2021 11:28:56 +0000 (UTC)
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
To:     chenguanyou <chenguanyou9338@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
References: <20210518111616.26695-1-chenguanyou@xiaomi.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e573a737-0195-aec0-032e-4a7bdb8553f7@suse.cz>
Date:   Wed, 19 May 2021 13:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518111616.26695-1-chenguanyou@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 1:16 PM, chenguanyou wrote:

The description is missing.

> Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
> ---
>  include/linux/sched/sysctl.h |  4 ++++
>  kernel/hung_task.c           | 17 +++++++++++++++++
>  kernel/sysctl.c              | 15 +++++++++++++++
>  lib/Kconfig.debug            | 23 +++++++++++++++++++++++
>  4 files changed, 59 insertions(+)
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
> index 62fbd09b5dc1..157c47a8430a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2519,6 +2519,21 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &neg_one,
>  	},
> +	{
> +		.procname	= "hung_task_filter_kthread",
> +		.data		= &sysctl_hung_task_filter_kthread,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
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
>  #endif
>  #ifdef CONFIG_RT_MUTEXES
>  	{
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2c7f46b366f1..59cfa9e230ee 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1101,6 +1101,29 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>  	  A timeout of 0 disables the check.  The default is two minutes.
>  	  Keeping the default should be fine in most cases.
>  
> +config DEFAULT_HUNG_TASK_FILTER_KTHREAD
> +	bool "Default filter kthread for hung task"
> +	depends on DETECT_HUNG_TASK
> +	default 0
> +	help
> +	  This option controls filter kthread used to determine when
> +	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skip.
> +
> +	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
> +	  sysctl or by writing a value to
> +	  /proc/sys/kernel/hung_task_filter_kthread.
> +
> +	  A filter of 1 disables the check
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
>  config BOOTPARAM_HUNG_TASK_PANIC
>  	bool "Panic (Reboot) On Hung Tasks"
>  	depends on DETECT_HUNG_TASK
> 

