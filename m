Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A397F3DBDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhG3Rwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 13:52:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36340 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhG3Rwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:52:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:42928)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m9Wgf-00EXgP-S4; Fri, 30 Jul 2021 11:52:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50768 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m9Wge-00Gws6-OK; Fri, 30 Jul 2021 11:52:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org
References: <20210730062854.3601635-1-svens@linux.ibm.com>
Date:   Fri, 30 Jul 2021 12:52:37 -0500
In-Reply-To: <20210730062854.3601635-1-svens@linux.ibm.com> (Sven Schnelle's
        message of "Fri, 30 Jul 2021 08:28:54 +0200")
Message-ID: <87sfzvbsey.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m9Wge-00Gws6-OK;;;mid=<87sfzvbsey.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+swV+BZk97MKKgbD5b/s2FwRpqY0xuoho=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4743]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Sven Schnelle <svens@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 347 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.1%), b_tie_ro: 2.7 (0.8%), parse: 0.71
        (0.2%), extract_message_metadata: 3.0 (0.9%), get_uri_detail_list:
        1.48 (0.4%), tests_pri_-1000: 2.7 (0.8%), tests_pri_-950: 1.07 (0.3%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 55 (15.7%), check_bayes:
        54 (15.4%), b_tokenize: 6 (1.8%), b_tok_get_all: 5 (1.5%),
        b_comp_prob: 1.20 (0.3%), b_tok_touch_all: 38 (11.1%), b_finish: 0.59
        (0.2%), tests_pri_0: 268 (77.1%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 1.67 (0.5%), poll_dns_idle: 0.33 (0.1%),
        tests_pri_10: 1.74 (0.5%), tests_pri_500: 5 (1.6%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v3] ucounts: add missing data type changes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> changed the data type of ucounts/ucounts_max to long, but missed to
> adjust a few other places. This is noticeable on big endian platforms
> from user space because the /proc/sys/user/max_*_names files all
> contain 0.

Applied.  Thank you.
>
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++----
>  fs/notify/inotify/inotify_user.c   | 10 ++++++----
>  kernel/ucount.c                    | 16 ++++++++--------
>  3 files changed, 20 insertions(+), 16 deletions(-)
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
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 98f61b31745a..55fe7cdea2fb 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -59,18 +59,20 @@ struct ctl_table inotify_table[] = {
>  	{
>  		.procname	= "max_user_instances",
>  		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_doulongvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname	= "max_user_watches",
>  		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
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
