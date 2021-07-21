Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AB3D0ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhGULr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237005AbhGULrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:47:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38B906120C;
        Wed, 21 Jul 2021 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626870473;
        bh=bhTgQiY6L87tA/0NIg2YzKqPLhvZDTIOkWJ8TbxNY8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3ddeiS691deDPY+CSxWdn/ghNmONxBjq9WLp+2K/wGsmWkuKOUtZ/WAtM/j2CPzt
         Q207PT6tU7HmHGPGbaS1rp5HhIzEsmQ6JxdJ4p2EE7vVrRrt8QXb28BS/TRGZKcdos
         Jv2KwwyOtXUT558YbY8rCYTgApjJoOnfw/SThFebXYJgJYquK0lsYSQXbSn3hoQxta
         VcyeSNVDlG9oyqMrK7bAn3nE4x66KCbPUvgENDgLd44SEX3tXUwDWgYqQ1xeFpEkX/
         dcBBA84mSqQlNAWVEnMbqbLzZqlKFEh/X62DqrLLH+/lBLZiz5F06EHtJUbNXaF7uq
         uXvsENWMXkLBw==
Date:   Wed, 21 Jul 2021 14:27:49 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucounts: add missing data type changes
Message-ID: <20210721122749.64igxvumy652uaby@example.org>
References: <20210721115800.910778-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721115800.910778-1-svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 01:58:00PM +0200, Sven Schnelle wrote:
> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> changed the data type of ucounts/ucounts_max to long, but missed to
> adjust a few other places. This is noticeable on big endian platforms
> from user space because the /proc/sys/user/max_*_names files all
> contain 0.

I didn't increase them because I didn't want to increase the maximum
number of namespaces.

Your patch not only fixes the described problem, but also increases the
maximum number of namespaces.

> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 11 +++++++----
>  kernel/ucount.c                    | 18 ++++++++++--------
>  kernel/user_namespace.c            |  2 +-
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 64864fb40b40..995379ddce86 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -54,22 +54,25 @@ static int fanotify_max_queued_events __read_mostly;
>  
>  #include <linux/sysctl.h>
>  
> +static unsigned long long_max = LONG_MAX;

I think this should be INT_MAX.

>  struct ctl_table fanotify_table[] = {
>  	{
>  		.procname	= "max_user_groups",
>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_doulongvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &long_max,
>  	},
>  	{
>  		.procname	= "max_user_marks",
>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_doulongvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &long_max,
>  	},
>  	{
>  		.procname	= "max_queued_events",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 87799e2379bd..681ea1b1a06f 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -58,14 +58,16 @@ static struct ctl_table_root set_root = {
>  	.permissions = set_permissions,
>  };
>  
> -#define UCOUNT_ENTRY(name)				\
> -	{						\
> -		.procname	= name,			\
> -		.maxlen		= sizeof(int),		\
> -		.mode		= 0644,			\
> -		.proc_handler	= proc_dointvec_minmax,	\
> -		.extra1		= SYSCTL_ZERO,		\
> -		.extra2		= SYSCTL_INT_MAX,	\
> +static unsigned long long_max = LONG_MAX;
> +
> +#define UCOUNT_ENTRY(name)					\
> +	{							\
> +		.procname	= name,				\
> +		.maxlen		= sizeof(long),			\
> +		.mode		= 0644,				\
> +		.proc_handler	= proc_doulongvec_minmax,	\
> +		.extra1		= SYSCTL_ZERO,			\
> +		.extra2		= &long_max,			\
>  	}
>  static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_user_namespaces"),
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index ef82d401dde8..d8ad4c261253 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -120,7 +120,7 @@ int create_user_ns(struct cred *new)
>  	ns->group = group;
>  	INIT_WORK(&ns->work, free_user_ns);
>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
> -		ns->ucount_max[i] = INT_MAX;
> +		ns->ucount_max[i] = LONG_MAX;
>  	}
>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> -- 
> 2.25.1
> 

-- 
Rgrds, legion

