Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A5B322FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhBWRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:45:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBWRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:44:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHeVhb176420;
        Tue, 23 Feb 2021 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=IyUlhk3AQQFwYAAWr8SNBNU6VGlgvbB1uytdVra3niw=;
 b=ND1wUxekMtD4MuhCkV3V9qeoilWF8eys357ctXWavxlvEu13VVSqJSxveEtIie9YN6wQ
 5XPBgE1KGO7OXwUC3WF8tF410ym6QcQ6eq6lV/T5CgZuSyEu0I0YHTCFmQF8HFAkzol8
 TyOFbitxpEv5N6X/014mrdEg2gd7EwrLQowf7GQIFvsMbBmkrjRr+rQA3hR67Cw9dXR/
 BvNuMZPmfynGSzA2vEh+6QqflKNGozP5Ihw2VAj3ZOf5RFn2hIE4GFtnVM4xPU3hkdWI
 oOr4dNZoBOCLb8DpNd/Awuxwqw60VaSn5tYICdCsZLFm5+gAvHU0CAq1SNQEbWbUSd1p NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3f4k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 17:43:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHeR1V096692;
        Tue, 23 Feb 2021 17:43:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 36v9m4w9xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 17:43:16 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11NHedQK097929;
        Tue, 23 Feb 2021 17:43:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by aserp3030.oracle.com with ESMTP id 36v9m4w9vs-1;
        Tue, 23 Feb 2021 17:43:15 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     saeed.mirzamohammadi@oracle.com,
        John Donnelly <john.p.donnelly@oracle.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] kernel/crash_core: Add crashkernel=auto for vmcore creation
Date:   Tue, 23 Feb 2021 09:41:50 -0800
Message-Id: <20210223174153.72802-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230148
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds crashkernel=auto feature to configure reserved memory for
vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
different kernel distributions and different archs based on their
needs.

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
---
 Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 arch/Kconfig                                  | 20 +++++++++++++++++++
 kernel/crash_core.c                           |  7 +++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..ae030111e22a 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -285,7 +285,8 @@ This would mean:
     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
     3) if the RAM size is larger than 2G, then reserve 128M
 
-
+Or you can use crashkernel=auto to choose the crash kernel memory size
+based on the recommended configuration set for each arch.
 
 Boot into System Kernel
 =======================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e3cdb271d06..a5deda5c85fe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -747,6 +747,12 @@
 			a memory unit (amount[KMG]). See also
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
+	crashkernel=auto
+			[KNL] This parameter will set the reserved memory for
+			the crash kernel based on the value of the CRASH_AUTO_STR
+			that is the best effort estimation for each arch. See also
+			arch/Kconfig for further details.
+
 	crashkernel=size[KMG],high
 			[KNL, X86-64] range could be above 4G. Allow kernel
 			to allocate physical memory region from top, so could
diff --git a/arch/Kconfig b/arch/Kconfig
index 24862d15f3a3..23d047548772 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -14,6 +14,26 @@ menu "General architecture-dependent options"
 config CRASH_CORE
 	bool
 
+config CRASH_AUTO_STR
+	string "Memory reserved for crash kernel"
+	depends on CRASH_CORE
+	default "1G-64G:128M,64G-1T:256M,1T-:512M"
+	help
+	  This configures the reserved memory dependent
+	  on the value of System RAM. The syntax is:
+	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+	              range=start-[end]
+
+	  For example:
+	      crashkernel=512M-2G:64M,2G-:128M
+
+	  This would mean:
+
+	      1) if the RAM is smaller than 512M, then don't reserve anything
+	         (this is the "rescue" case)
+	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
+	      3) if the RAM size is larger than 2G, then reserve 128M
+
 config KEXEC_CORE
 	select CRASH_CORE
 	bool
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..90f9e4bb6704 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+#ifdef CONFIG_CRASH_AUTO_STR
+	if (strncmp(ck_cmdline, "auto", 4) == 0) {
+		ck_cmdline = CONFIG_CRASH_AUTO_STR;
+		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
+	}
+#endif
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
-- 
2.27.0

