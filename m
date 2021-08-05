Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F333E1699
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbhHEOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:11:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49102 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbhHEOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:11:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A07ED223A5;
        Thu,  5 Aug 2021 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628172687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cac2K7UyIrNiZxU9wp02mcCd//sOnFqsP30dJ/UcrhA=;
        b=nRzdXtEEFavfgJz3zKm8R4Kzg+rvMW+39U5hi4lsROR++ngJCWqK+6OMTFRLE9GpOP+ok7
        XBEn5fyktWZlW2LKTSmiDUCeyWfXeox66QOxmTnNUmM32JNv7XWCw1vyBvHX3buggnrm+5
        zuvctQ0jQR4EsVa/1fgA2BomGpAmBFM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9FEFA3D3E;
        Thu,  5 Aug 2021 14:11:26 +0000 (UTC)
Date:   Thu, 5 Aug 2021 16:11:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, lukas.bulwahn@gmail.com, vbabka@suse.cz,
        gpiccoli@canonical.com, chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH v2] hungtask: add filter kthread
Message-ID: <YQvxf0KqvlVSO+R5@dhcp22.suse.cz>
References: <20210805134747.29621-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805134747.29621-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-08-21 21:47:47, chenguanyou wrote:
> Some kernel threads are always in D state, when we enable hung_task,
> it will misjudge, we should skip these to narrow the scope.
> 
> exp mediatek:
> root            435   435      2       0      0 mtk_lpm_monitor_thread 0 D LPM-0
> root            436   436      2       0      0 mtk_lpm_monitor_thread 0 D LPM-1
> root            437   437      2       0      0 mtk_lpm_monitor_thread 0 D LPM-2
> root            438   438      2       0      0 mtk_lpm_monitor_thread 0 D LPM-3
> root            439   439      2       0      0 mtk_lpm_monitor_thread 0 D LPM-4
> root            440   440      2       0      0 mtk_lpm_monitor_thread 0 D LPM-5
> root            441   441      2       0      0 mtk_lpm_monitor_thread 0 D LPM-6
> root            442   442      2       0      0 mtk_lpm_monitor_thread 0 D LPM-7

A similar approch has been proposed in the past (sorry I do not have
links handy) and always deemed a wrong way to approach the problem.
Either those kernel threads should be fixed to use less sleep or
annotate the sleep properly (TASK_IDLE).

> Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 10 ++++++++++
>  include/linux/sched/sysctl.h                |  1 +
>  kernel/hung_task.c                          |  8 ++++++++
>  kernel/sysctl.c                             |  9 +++++++++
>  lib/Kconfig.debug                           | 15 +++++++++++++++
>  5 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 68b21395a743..3c7c74b26d95 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -405,6 +405,16 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>  
>  -1: report an infinite number of warnings.
>  
> +hung_task_filter_kthread
> +========================
> +
> +We should skip kthread when a hung task is detected.
> +This file shows up if ``CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD`` is enabled.
> +
> += =========================================================
> +0 Not skip detect kthread.
> +1 Skip detect kthread.
> += =========================================================
>  
>  hyperv_record_panic_msg
>  =======================
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index db2c0f34aaaf..2b8b01b57559 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -19,6 +19,7 @@ extern unsigned int  sysctl_hung_task_panic;
>  extern unsigned long sysctl_hung_task_timeout_secs;
>  extern unsigned long sysctl_hung_task_check_interval_secs;
>  extern int sysctl_hung_task_warnings;
> +extern unsigned int sysctl_hung_task_filter_kthread;
>  int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos);
>  #else
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 396ebaebea3f..74ad75c2dde8 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -48,6 +48,11 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
>   */
>  unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>  
> +/*
> + * Non-zero means no checking kthread
> + */
> +unsigned int __read_mostly sysctl_hung_task_filter_kthread = CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD;
> +
>  int __read_mostly sysctl_hung_task_warnings = 10;
>  
>  static int __read_mostly did_panic;
> @@ -88,6 +93,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
>  	unsigned long switch_count = t->nvcsw + t->nivcsw;
>  
> +	if (unlikely(sysctl_hung_task_filter_kthread && t->flags & PF_KTHREAD))
> +		return;
> +
>  	/*
>  	 * Ensure the task is not frozen.
>  	 * Also, skip vfork and any other user process that freezer should skip.
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index d4a78e08f6d8..62067b9db486 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2513,6 +2513,15 @@ static struct ctl_table kern_table[] = {
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
>  #endif
>  #ifdef CONFIG_RT_MUTEXES
>  	{
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..d7063f955987 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1110,6 +1110,21 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>  	  A timeout of 0 disables the check.  The default is two minutes.
>  	  Keeping the default should be fine in most cases.
>  
> +config DEFAULT_HUNG_TASK_FILTER_KTHREAD
> +	int "Default filter kthread for hung task"
> +	depends on DETECT_HUNG_TASK
> +	range 0 1
> +	default 0
> +	help
> +	  This option controls filter kthread uses to determine when
> +	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skipped.
> +
> +	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
> +	  sysctl or by writing a value to
> +	  /proc/sys/kernel/hung_task_filter_kthread.
> +
> +	  A filter of 1 disables the check.
> +
>  config BOOTPARAM_HUNG_TASK_PANIC
>  	bool "Panic (Reboot) On Hung Tasks"
>  	depends on DETECT_HUNG_TASK
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
