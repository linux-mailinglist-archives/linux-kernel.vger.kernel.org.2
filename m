Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485A3E19D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhHEQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:49:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36082 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhHEQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:49:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:57788)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBgYg-00ABB9-Dj; Thu, 05 Aug 2021 10:49:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42762 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBgYf-00FT5v-4E; Thu, 05 Aug 2021 10:49:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210730062854.3601635-1-svens@linux.ibm.com>
        <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain> <875ywlat5e.fsf@disp2133>
        <94478003-8259-4b57-6d93-5a07e0750946@kernel.org>
Date:   Thu, 05 Aug 2021 11:48:43 -0500
In-Reply-To: <94478003-8259-4b57-6d93-5a07e0750946@kernel.org> (Nathan
        Chancellor's message of "Wed, 4 Aug 2021 13:27:08 -0700")
Message-ID: <87v94jalck.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mBgYf-00FT5v-4E;;;mid=<87v94jalck.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/tcQBGG4D+OO8lCnuXPrF8Pc6wuKFJrlU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords,
        XM_B_SpammyWords2 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nathan Chancellor <nathan@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 574 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.30
        (0.2%), extract_message_metadata: 6 (1.0%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 4.1 (0.7%), tests_pri_-950: 1.41 (0.2%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 83 (14.4%), check_bayes:
        81 (14.2%), b_tokenize: 11 (1.9%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 3.2 (0.6%), b_tok_touch_all: 52 (9.1%), b_finish: 0.83
        (0.1%), tests_pri_0: 446 (77.8%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 0.93 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] ucounts: add missing data type changes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> Hi Eric,
>
> On 8/4/2021 12:47 PM, Eric W. Biederman wrote:
>> Nathan Chancellor <nathan@kernel.org> writes:
>>
>>> On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
>>>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>>>> changed the data type of ucounts/ucounts_max to long, but missed to
>>>> adjust a few other places. This is noticeable on big endian platforms
>>>> from user space because the /proc/sys/user/max_*_names files all
>>>> contain 0.
>>>>
>>>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>>
>>> This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
>>> changes") causes Windows Subsystem for Linux to fail to start:
>>>
>>> [error 0x8007010b when launching `wsl.exe -d Arch'] Could not access starting
>>> directory "\\wsl$\Arch\home\nathan"
>>>
>>> Specifically, it is the change to max_user_watches in
>>> fs/notify/inotify/inotify_user.c, as the below diff gets me back to working.
>>> Unfortunately, I have no additional information to offer beyond that as WSL's
>>> init is custom and closed source (as far as I am aware) and there are no real
>>> debugging utilities.
>>
>> Could you try this patch and tell us what value is being set?
>>
>> The only think I can imagine is that someone wants unlimited watches and
>> sets the value to a ridiculously large value and the interpretation of
>> that value winds up being different between int and long.
>>
>> This should allow you to read either dmesg or the kernel's log as it
>> boots up and see what value is being written.  From there it should
>> be relatively straight forward to figure out what is going on.
>
> I applied this diff on top of mine and running 'dmesg |& grep intvec' shows:
>
> [    0.282500] intvec: dmesg_restrict <- 0
> [    0.282510] intvec: max_user_watches <- 524288
>
> This seems much smaller than INT_MAX so I am not sure how the value could be
> different between int and long but I am not at all familiar with the sysctl
> code.
>
> More than happy to continue to test debug patches or provide any additional
> information as I can.

Yes.  Very strange.

Could you perhaps try the instrumenting proc_doulongvec_minmax the same
way and see what is written in the failing case?

While looking at the code I did see one other serious bug.  The min and
max values are int constants intstead of long constants.

Could you test the change below and see if it makes a difference?

Eric


diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6576657a1a25..28b67cb9458d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -54,6 +54,9 @@ static int fanotify_max_queued_events __read_mostly;
 
 #include <linux/sysctl.h>
 
+static long ft_zero = 0;
+static long ft_int_max = INT_MAX;
+
 struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
@@ -61,8 +64,8 @@ struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.extra1		= &ft_zero,
+		.extra2		= &ft_int_max,
 	},
 	{
 		.procname	= "max_user_marks",
@@ -70,8 +73,8 @@ struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.extra1		= &ft_zero,
+		.extra2		= &ft_int_max,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 55fe7cdea2fb..62051247f6d2 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -55,6 +55,9 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 #include <linux/sysctl.h>
 
+static long it_zero = 0;
+static long it_int_max = INT_MAX;
+
 struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
@@ -62,8 +65,8 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.extra1		= &it_zero,
+		.extra2		= &it_int_max,
 	},
 	{
 		.procname	= "max_user_watches",
@@ -71,8 +74,8 @@ struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.extra1		= &it_zero,
+		.extra2		= &it_int_max,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 260ae7da815f..bb51849e6375 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,14 +58,17 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
+static long ue_zero = 0;
+static long ue_int_max = INT_MAX;
+
 #define UCOUNT_ENTRY(name)					\
 	{							\
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
 		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= SYSCTL_ZERO,			\
-		.extra2		= SYSCTL_INT_MAX,		\
+		.extra1		= &ue_zero,			\
+		.extra2		= &ue_int_max,			\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),



