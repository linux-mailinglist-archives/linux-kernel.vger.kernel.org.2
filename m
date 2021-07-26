Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF03D6780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhGZSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:51:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhGZSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:51:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86KE-004I5V-Rg; Mon, 26 Jul 2021 13:31:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41882 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86KD-001MOi-TC; Mon, 26 Jul 2021 13:31:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210726190619.kcks2gst562blvr4@example.org> (Alexey Gladkov's
        message of "Mon, 26 Jul 2021 21:06:19 +0200")
References: <20210721125233.1041429-1-svens@linux.ibm.com>
        <20210726190619.kcks2gst562blvr4@example.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 26 Jul 2021 14:31:35 -0500
Message-ID: <87mtq8kh2g.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m86KD-001MOi-TC;;;mid=<87mtq8kh2g.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+2xVkXWy/PLvuACN9xPhSjvwgZXCYTDOE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4282]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 355 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (3.6%), b_tie_ro: 11 (3.1%), parse: 0.97
        (0.3%), extract_message_metadata: 4.1 (1.2%), get_uri_detail_list:
        1.80 (0.5%), tests_pri_-1000: 4.0 (1.1%), tests_pri_-950: 1.74 (0.5%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 63 (17.8%), check_bayes:
        61 (17.1%), b_tokenize: 11 (3.1%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 2.0 (0.6%), b_tok_touch_all: 36 (10.3%), b_finish: 1.32
        (0.4%), tests_pri_0: 248 (69.9%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.1 (0.9%), poll_dns_idle: 1.20 (0.3%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ucounts: add missing data type changes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Wed, Jul 21, 2021 at 02:52:33PM +0200, Sven Schnelle wrote:
>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>> changed the data type of ucounts/ucounts_max to long, but missed to
>> adjust a few other places. This is noticeable on big endian platforms
>> from user space because the /proc/sys/user/max_*_names files all
>> contain 0.
>> 
>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
> Acked-by: Alexey Gladkov <legion@kernel.org>
>
> Eric, what do you think ?

At a quick skim it looks good.  I was to swamped last week to pick it
up, but I plan on picking this up and getting it to Linus before
the next -rc release.

Eric

>> ---
>>  fs/notify/fanotify/fanotify_user.c | 10 ++++++----
>>  kernel/ucount.c                    | 16 ++++++++--------
>>  2 files changed, 14 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index 64864fb40b40..6576657a1a25 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -58,18 +58,20 @@ struct ctl_table fanotify_table[] = {
>>  	{
>>  		.procname	= "max_user_groups",
>>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
>> -		.maxlen		= sizeof(int),
>> +		.maxlen		= sizeof(long),
>>  		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> +		.proc_handler	= proc_doulongvec_minmax,
>>  		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_INT_MAX,
>>  	},
>>  	{
>>  		.procname	= "max_user_marks",
>>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
>> -		.maxlen		= sizeof(int),
>> +		.maxlen		= sizeof(long),
>>  		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> +		.proc_handler	= proc_doulongvec_minmax,
>>  		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_INT_MAX,
>>  	},
>>  	{
>>  		.procname	= "max_queued_events",
>> diff --git a/kernel/ucount.c b/kernel/ucount.c
>> index 87799e2379bd..f852591e395c 100644
>> --- a/kernel/ucount.c
>> +++ b/kernel/ucount.c
>> @@ -58,14 +58,14 @@ static struct ctl_table_root set_root = {
>>  	.permissions = set_permissions,
>>  };
>>  
>> -#define UCOUNT_ENTRY(name)				\
>> -	{						\
>> -		.procname	= name,			\
>> -		.maxlen		= sizeof(int),		\
>> -		.mode		= 0644,			\
>> -		.proc_handler	= proc_dointvec_minmax,	\
>> -		.extra1		= SYSCTL_ZERO,		\
>> -		.extra2		= SYSCTL_INT_MAX,	\
>> +#define UCOUNT_ENTRY(name)					\
>> +	{							\
>> +		.procname	= name,				\
>> +		.maxlen		= sizeof(long),			\
>> +		.mode		= 0644,				\
>> +		.proc_handler	= proc_doulongvec_minmax,	\
>> +		.extra1		= SYSCTL_ZERO,			\
>> +		.extra2		= SYSCTL_INT_MAX,		\
>>  	}
>>  static struct ctl_table user_table[] = {
>>  	UCOUNT_ENTRY("max_user_namespaces"),
>> -- 
>> 2.25.1
>> 
