Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D243D6745
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhGZSZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231548AbhGZSZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A8960F5D;
        Mon, 26 Jul 2021 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627326382;
        bh=kcebGW/2iDcLiJnhxmeQ7Ln4UyxZ0X1aSj8OE6Cq/gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHMM6PDIuNh+5pTLqNwem6faUsAwuUCyMDV218u2A27SZhcRxmeUq5/6MEKoWcl8J
         1mACc2NDCnS75u18D5mEyfHXUXik4RE7/l/1PlRIGnITF0wGkBf4v2Z93GLInxAyFT
         GgUkYVCghm3YWGmt+/9+1Hl0CPhcBOgIdGaYUwqupmvnb/1qYURmnN58h68EFKO628
         zEohNlQ+cnvjeWZ1uOvBW9me0HljKTZoWUbmMGNY5oMZRs4VS9/s0mDqvzAOcxahm+
         u+teGKcmR+3+mkvfoG1H9YvmochyfkQ85gdeTlz/eSe34KDA6sMII1v9MxsVQs89UZ
         LcE+vtKaoeipw==
Date:   Mon, 26 Jul 2021 21:06:19 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ucounts: add missing data type changes
Message-ID: <20210726190619.kcks2gst562blvr4@example.org>
References: <20210721125233.1041429-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721125233.1041429-1-svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 02:52:33PM +0200, Sven Schnelle wrote:
> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> changed the data type of ucounts/ucounts_max to long, but missed to
> adjust a few other places. This is noticeable on big endian platforms
> from user space because the /proc/sys/user/max_*_names files all
> contain 0.
> 
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Acked-by: Alexey Gladkov <legion@kernel.org>

Eric, what do you think ?

> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++----
>  kernel/ucount.c                    | 16 ++++++++--------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 64864fb40b40..6576657a1a25 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -58,18 +58,20 @@ struct ctl_table fanotify_table[] = {
>  	{
>  		.procname	= "max_user_groups",
>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_doulongvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
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
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname	= "max_queued_events",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 87799e2379bd..f852591e395c 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -58,14 +58,14 @@ static struct ctl_table_root set_root = {
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
> +#define UCOUNT_ENTRY(name)					\
> +	{							\
> +		.procname	= name,				\
> +		.maxlen		= sizeof(long),			\
> +		.mode		= 0644,				\
> +		.proc_handler	= proc_doulongvec_minmax,	\
> +		.extra1		= SYSCTL_ZERO,			\
> +		.extra2		= SYSCTL_INT_MAX,		\
>  	}
>  static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_user_namespaces"),
> -- 
> 2.25.1
> 

-- 
Rgrds, legion

