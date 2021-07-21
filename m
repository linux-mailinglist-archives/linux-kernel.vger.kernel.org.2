Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B763D0ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhGULxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:53:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236298AbhGULwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:52:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LC3mLm012369;
        Wed, 21 Jul 2021 08:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=PbT95ZRFv3qZ2pi+TN0Wqa8myY66C8oJrzpgQ0Bfl/E=;
 b=PjLS4lWJFGcHFwGKfkaKKJg/PJj9nypPkiALTWWcmWzVfvkZ5TyaGGVJeaB8crj5nxTL
 3GbEDOQXFNLpC28rKbPVJ/s5OEOpOLzvC06nKuTdpxY3TE42G4F0R85OTltp9lWnTqRz
 G619AIhyw0P25uDKBjH6g9CG5VQkN8se4n0GH6Okp9kUB0GogN8B0sehtST/Y+oS+qzQ
 wSanbNZFhE1OByoRyYoTgq1c1Ub/NvlZpp/U+A9/snEAXZGzwlFIBtR1KWZg4saifF9q
 lBmfWti5AUzZQ1JxUYhSVeMYP+WWmkcWiMtFUWaCtSyYkVujTx++d9BJsy2ZM/c5kHop CQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xk7g8uhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 08:32:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LCUBGc029801;
        Wed, 21 Jul 2021 12:32:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39xhx4823b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 12:32:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LCUClY31588862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 12:30:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34AF42049;
        Wed, 21 Jul 2021 12:32:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7774842045;
        Wed, 21 Jul 2021 12:32:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jul 2021 12:32:38 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucounts: add missing data type changes
References: <20210721115800.910778-1-svens@linux.ibm.com>
        <20210721122749.64igxvumy652uaby@example.org>
Date:   Wed, 21 Jul 2021 14:32:38 +0200
In-Reply-To: <20210721122749.64igxvumy652uaby@example.org> (Alexey Gladkov's
        message of "Wed, 21 Jul 2021 14:27:49 +0200")
Message-ID: <yt9dtuknaluh.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dLqVZioVOsADmM3pycPioT0eSHPY206F
X-Proofpoint-GUID: dLqVZioVOsADmM3pycPioT0eSHPY206F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_08:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Wed, Jul 21, 2021 at 01:58:00PM +0200, Sven Schnelle wrote:
>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>> changed the data type of ucounts/ucounts_max to long, but missed to
>> adjust a few other places. This is noticeable on big endian platforms
>> from user space because the /proc/sys/user/max_*_names files all
>> contain 0.
>
> I didn't increase them because I didn't want to increase the maximum
> number of namespaces.
>
> Your patch not only fixes the described problem, but also increases the
> maximum number of namespaces.
>
>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  fs/notify/fanotify/fanotify_user.c | 11 +++++++----
>>  kernel/ucount.c                    | 18 ++++++++++--------
>>  kernel/user_namespace.c            |  2 +-
>>  3 files changed, 18 insertions(+), 13 deletions(-)
>> 
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index 64864fb40b40..995379ddce86 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -54,22 +54,25 @@ static int fanotify_max_queued_events __read_mostly;
>>  
>>  #include <linux/sysctl.h>
>>  
>> +static unsigned long long_max = LONG_MAX;
>
> I think this should be INT_MAX.

Thanks. I'll change the code to use SYSCTL_INT_MAX instead and send a
v2.

>>  struct ctl_table fanotify_table[] = {
>>  	{
>>  		.procname	= "max_user_groups",
>>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
>> -		.maxlen		= sizeof(int),
>> +		.maxlen		= sizeof(long),
>>  		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> +		.proc_handler	= proc_doulongvec_minmax,
>>  		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= &long_max,
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
>> +		.extra2		= &long_max,
>>  	},
>>  	{
>>  		.procname	= "max_queued_events",
>> diff --git a/kernel/ucount.c b/kernel/ucount.c
>> index 87799e2379bd..681ea1b1a06f 100644
>> --- a/kernel/ucount.c
>> +++ b/kernel/ucount.c
>> @@ -58,14 +58,16 @@ static struct ctl_table_root set_root = {
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
>> +static unsigned long long_max = LONG_MAX;
>> +
>> +#define UCOUNT_ENTRY(name)					\
>> +	{							\
>> +		.procname	= name,				\
>> +		.maxlen		= sizeof(long),			\
>> +		.mode		= 0644,				\
>> +		.proc_handler	= proc_doulongvec_minmax,	\
>> +		.extra1		= SYSCTL_ZERO,			\
>> +		.extra2		= &long_max,			\
>>  	}
>>  static struct ctl_table user_table[] = {
>>  	UCOUNT_ENTRY("max_user_namespaces"),
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index ef82d401dde8..d8ad4c261253 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -120,7 +120,7 @@ int create_user_ns(struct cred *new)
>>  	ns->group = group;
>>  	INIT_WORK(&ns->work, free_user_ns);
>>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
>> -		ns->ucount_max[i] = INT_MAX;
>> +		ns->ucount_max[i] = LONG_MAX;

Guess this should also stay at INT_MAX?

>>  	}
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
>> -- 
>> 2.25.1
>> 
