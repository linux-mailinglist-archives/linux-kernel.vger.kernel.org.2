Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EE3894D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhESRzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhESRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:55:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADDCC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=X4Hjh8DAldf0KF0BZ3r+rJd5h6X3daTeunVEqLN2aOY=; b=VKu4j6ySattnmgf/ug/DKGTKGh
        VIPX6HQu4JFxcu7SCloAaxz9CIK5VSBfJnGrNuyJ+YmDNgChvw1lxbEY0tzVqQPcT8S4SbOV5Qsiz
        hprwBBPantKxBssxjagNMtX6l/yNRQNjcALvR1XrE5HUSPW6wGc2qdHtfjSTQQZji7HpRJYvcG10L
        M+65e/ZxPyWYwpMvT8hn4J25XTdxUftLbqpOR7myz6USDIkS4A3p62RipcE65LmR52Vuymk5XG1EB
        AONrxJ/nCKaNg1SuuO8pMNzWBiCpa2EYG5hBA1v4JX3/FX5FUHvOR6rfWvR3ivLE7NKQHBXWz99Fy
        +sEWbQZQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljQOH-00Fftn-BA; Wed, 19 May 2021 17:53:53 +0000
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
To:     chenguanyou <chenguanyou9338@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
References: <20210519121325.22083-1-chenguanyou@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <26c6c7a7-4c85-7487-6dd6-1e66b41a2a27@infradead.org>
Date:   Wed, 19 May 2021 10:53:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519121325.22083-1-chenguanyou@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Along with what Micahl has said, please see below.

On 5/19/21 5:13 AM, chenguanyou wrote:
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
>  kernel/sysctl.c              | 15 +++++++++++++++
>  lib/Kconfig.debug            | 23 +++++++++++++++++++++++
>  4 files changed, 59 insertions(+)
> 

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

These new sysctls should be documented in Documentation/admin-guide/sysctl/kernel.rst.

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

	                                      uses

> +	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skip.

	                                                                      skipped.

> +
> +	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
> +	  sysctl or by writing a value to
> +	  /proc/sys/kernel/hung_task_filter_kthread.
> +
> +	  A filter of 1 disables the check

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

That help text doesn't tell how the Kconfig symbol is used.

> +
>  config BOOTPARAM_HUNG_TASK_PANIC
>  	bool "Panic (Reboot) On Hung Tasks"
>  	depends on DETECT_HUNG_TASK
> 


thanks.
-- 
~Randy

