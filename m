Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422DC3EA8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhHLQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:57:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42338 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhHLQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:57:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41408)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEE0z-005Ery-UO; Thu, 12 Aug 2021 10:57:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42798 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEE0x-00ExC9-Oh; Thu, 12 Aug 2021 10:57:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Date:   Thu, 12 Aug 2021 11:57:00 -0500
Message-ID: <87a6lmeh43.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mEE0x-00ExC9-Oh;;;mid=<87a6lmeh43.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++TSNjWbloC9ucw6y9qe5B3Ylx3uB7SNI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1609 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 9 (0.6%), parse: 1.01 (0.1%),
         extract_message_metadata: 17 (1.1%), get_uri_detail_list: 4.3 (0.3%),
        tests_pri_-1000: 22 (1.4%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 100 (6.2%), check_bayes:
        94 (5.8%), b_tokenize: 12 (0.7%), b_tok_get_all: 11 (0.7%),
        b_comp_prob: 3.0 (0.2%), b_tok_touch_all: 64 (4.0%), b_finish: 0.83
        (0.1%), tests_pri_0: 1441 (89.6%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.95 (0.1%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] bigendian ucount fix for v5.14-rc
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Please pull the for-v5.14 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14

  HEAD: f153c2246783ba210493054d99c66353f56423c9 ucounts: add missing data type changes

This is on top of the previous ucount fix on top of v5.14-rc3.  This is
one change that fixes the ucount sysctls on big endian architectures.
This cycle the counts were expanded to be longs instead of ints, and it
was overlooked to update the sysctl code, so only the low 32bit were
being processed.  On litte endian just processing the low 32bits is
fine, but on 64bit big endian processing just the low 32bits results in
the high order bits instead of the low order bits being processed and
nothing works proper.

This change took a little bit to mature as we have the SYSCTL_ZERO, and
SYSCTL_INT_MAX macros that are only usable for sysctls operating on
ints, but unfortunately are not obviously broken.  Which resulted in the
versions of this change working on big endian and not on little endian,
because the int SYSCTL_ZERO when extended 64bit wound up being
0x100000000.  So we only allowed values greater than 0x100000000 and
less than 0faff.  Which unfortunately broken everything that tried
to set the sysctls. (First reported with the windows subsystem for
linux).

I have tested this on x86_64 64bit after first reproducing the problems
with the earlier version of this change, and then verifying the problems
do not exist when we use appropriate long min and max values for extra1
and extra2.

Eric

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

From f153c2246783ba210493054d99c66353f56423c9 Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@linux.ibm.com>
Date: Fri, 30 Jul 2021 08:28:54 +0200
Subject: [PATCH] ucounts: add missing data type changes

commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
changed the data type of ucounts/ucounts_max to long, but missed to
adjust a few other places. This is noticeable on big endian platforms
from user space because the /proc/sys/user/max_*_names files all
contain 0.

v4 - Made the min and max constants long so the sysctl values
     are actually settable on little endian machines.
     -- EWB

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Alexey Gladkov <legion@kernel.org>
v1: https://lkml.kernel.org/r/20210721115800.910778-1-svens@linux.ibm.com
v2: https://lkml.kernel.org/r/20210721125233.1041429-1-svens@linux.ibm.com
v3: https://lkml.kernel.org/r/20210730062854.3601635-1-svens@linux.ibm.com
Link: https://lkml.kernel.org/r/8735rijqlv.fsf_-_@disp2133
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/notify/fanotify/fanotify_user.c | 17 +++++++++++------
 fs/notify/inotify/inotify_user.c   | 17 +++++++++++------
 kernel/ucount.c                    | 19 +++++++++++--------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64864fb40b40..28b67cb9458d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -54,22 +54,27 @@ static int fanotify_max_queued_events __read_mostly;
 
 #include <linux/sysctl.h>
 
+static long ft_zero = 0;
+static long ft_int_max = INT_MAX;
+
 struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &ft_zero,
+		.extra2		= &ft_int_max,
 	},
 	{
 		.procname	= "max_user_marks",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &ft_zero,
+		.extra2		= &ft_int_max,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 98f61b31745a..62051247f6d2 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -55,22 +55,27 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 #include <linux/sysctl.h>
 
+static long it_zero = 0;
+static long it_int_max = INT_MAX;
+
 struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
 		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &it_zero,
+		.extra2		= &it_int_max,
 	},
 	{
 		.procname	= "max_user_watches",
 		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &it_zero,
+		.extra2		= &it_int_max,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 77be3bbe3cc4..bb51849e6375 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,14 +58,17 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-#define UCOUNT_ENTRY(name)				\
-	{						\
-		.procname	= name,			\
-		.maxlen		= sizeof(int),		\
-		.mode		= 0644,			\
-		.proc_handler	= proc_dointvec_minmax,	\
-		.extra1		= SYSCTL_ZERO,		\
-		.extra2		= SYSCTL_INT_MAX,	\
+static long ue_zero = 0;
+static long ue_int_max = INT_MAX;
+
+#define UCOUNT_ENTRY(name)					\
+	{							\
+		.procname	= name,				\
+		.maxlen		= sizeof(long),			\
+		.mode		= 0644,				\
+		.proc_handler	= proc_doulongvec_minmax,	\
+		.extra1		= &ue_zero,			\
+		.extra2		= &ue_int_max,			\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
-- 
2.20.1

