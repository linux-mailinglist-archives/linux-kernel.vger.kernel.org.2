Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A683D0EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhGUMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhGUMC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B498E6023B;
        Wed, 21 Jul 2021 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626871384;
        bh=MfGRjvO8Z9rlDyAymbCsP9rnH/CsA8/20EHxRZ7Z2Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcSHIkZsiFPaphwmQn9Tbf+FhayR2T4vNJ6vKkTh7BZlFZko0UqwWf3txJ/7m0DJT
         v31YJllmL5Ua80XIUPLUD29NdzIuYDEofai8YAc1rOPwEsyVRSJUK+C0vR64Ru/Wfe
         t9QoRurpoa+Jio1s/bJl8qRgLGZaiJNhAQehLPRDbPozcQ+dC0BjYM14jP7kDCP3v+
         /9ErQ6DSoCdNqSC7yg2pXW/tLsVIXnNOQ5DC2l/W7KxRD0hai9IyDxJp0FvyLQp6m0
         fk0rdCtRojFqk3EgyuPw5WMySAtA4avQHb6SBCD2wGY94xI5UFroxXIF1gbkE5wfRa
         Q36bcMWsVqWLA==
Date:   Wed, 21 Jul 2021 14:43:01 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucounts: add missing data type changes
Message-ID: <20210721124301.btbciip4biph2cxd@example.org>
References: <20210721115800.910778-1-svens@linux.ibm.com>
 <20210721122749.64igxvumy652uaby@example.org>
 <yt9dtuknaluh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dtuknaluh.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 02:32:38PM +0200, Sven Schnelle wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
> > On Wed, Jul 21, 2021 at 01:58:00PM +0200, Sven Schnelle wrote:
> >> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> >> changed the data type of ucounts/ucounts_max to long, but missed to
> >> adjust a few other places. This is noticeable on big endian platforms
> >> from user space because the /proc/sys/user/max_*_names files all
> >> contain 0.
> >
> > I didn't increase them because I didn't want to increase the maximum
> > number of namespaces.
> >
> > Your patch not only fixes the described problem, but also increases the
> > maximum number of namespaces.
> >
> >> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >>  fs/notify/fanotify/fanotify_user.c | 11 +++++++----
> >>  kernel/ucount.c                    | 18 ++++++++++--------
> >>  kernel/user_namespace.c            |  2 +-
> >>  3 files changed, 18 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> >> index 64864fb40b40..995379ddce86 100644
> >> --- a/fs/notify/fanotify/fanotify_user.c
> >> +++ b/fs/notify/fanotify/fanotify_user.c
> >> @@ -54,22 +54,25 @@ static int fanotify_max_queued_events __read_mostly;
> >>  
> >>  #include <linux/sysctl.h>
> >>  
> >> +static unsigned long long_max = LONG_MAX;
> >
> > I think this should be INT_MAX.
> 
> Thanks. I'll change the code to use SYSCTL_INT_MAX instead and send a
> v2.
> 
> >>  struct ctl_table fanotify_table[] = {
> >>  	{
> >>  		.procname	= "max_user_groups",
> >>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
> >> -		.maxlen		= sizeof(int),
> >> +		.maxlen		= sizeof(long),
> >>  		.mode		= 0644,
> >> -		.proc_handler	= proc_dointvec_minmax,
> >> +		.proc_handler	= proc_doulongvec_minmax,
> >>  		.extra1		= SYSCTL_ZERO,
> >> +		.extra2		= &long_max,
> >>  	},
> >>  	{
> >>  		.procname	= "max_user_marks",
> >>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
> >> -		.maxlen		= sizeof(int),
> >> +		.maxlen		= sizeof(long),
> >>  		.mode		= 0644,
> >> -		.proc_handler	= proc_dointvec_minmax,
> >> +		.proc_handler	= proc_doulongvec_minmax,
> >>  		.extra1		= SYSCTL_ZERO,
> >> +		.extra2		= &long_max,
> >>  	},
> >>  	{
> >>  		.procname	= "max_queued_events",
> >> diff --git a/kernel/ucount.c b/kernel/ucount.c
> >> index 87799e2379bd..681ea1b1a06f 100644
> >> --- a/kernel/ucount.c
> >> +++ b/kernel/ucount.c
> >> @@ -58,14 +58,16 @@ static struct ctl_table_root set_root = {
> >>  	.permissions = set_permissions,
> >>  };
> >>  
> >> -#define UCOUNT_ENTRY(name)				\
> >> -	{						\
> >> -		.procname	= name,			\
> >> -		.maxlen		= sizeof(int),		\
> >> -		.mode		= 0644,			\
> >> -		.proc_handler	= proc_dointvec_minmax,	\
> >> -		.extra1		= SYSCTL_ZERO,		\
> >> -		.extra2		= SYSCTL_INT_MAX,	\
> >> +static unsigned long long_max = LONG_MAX;
> >> +
> >> +#define UCOUNT_ENTRY(name)					\
> >> +	{							\
> >> +		.procname	= name,				\
> >> +		.maxlen		= sizeof(long),			\
> >> +		.mode		= 0644,				\
> >> +		.proc_handler	= proc_doulongvec_minmax,	\
> >> +		.extra1		= SYSCTL_ZERO,			\
> >> +		.extra2		= &long_max,			\
> >>  	}
> >>  static struct ctl_table user_table[] = {
> >>  	UCOUNT_ENTRY("max_user_namespaces"),
> >> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> >> index ef82d401dde8..d8ad4c261253 100644
> >> --- a/kernel/user_namespace.c
> >> +++ b/kernel/user_namespace.c
> >> @@ -120,7 +120,7 @@ int create_user_ns(struct cred *new)
> >>  	ns->group = group;
> >>  	INIT_WORK(&ns->work, free_user_ns);
> >>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
> >> -		ns->ucount_max[i] = INT_MAX;
> >> +		ns->ucount_max[i] = LONG_MAX;
> 
> Guess this should also stay at INT_MAX?

Yes.

> >>  	}
> >>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> >>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> >> -- 
> >> 2.25.1
> >> 
> 

-- 
Rgrds, legion

