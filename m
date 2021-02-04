Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24C30E8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhBDAqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:46:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhBDApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:45:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140R0it034606;
        Thu, 4 Feb 2021 00:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=YqQuEM1hEpwjjKLavPiJuNZ9hUSimNjCzuZ0/wDmZgw=;
 b=KzzX61wHbFgON14gSgaGdC7Kyh8/rGSyduN4IGebL07dCnnquz0lo0xgfqWegdyrJoOE
 WZvFRlMA21oQTZoQb+37+EafAkkrld7Fm89druu3KVk16zd9USUrjVKfWqFMM7VbuhFD
 dkJOF8MxmXc+lnWH2smIupqVvrEcaelRfI5uDXWKMBmuJ6J0sSn6vaD/XDqV8LOZalXS
 h6ltfhN9Zx3OTJkhkSzFbu6Fo7q7RBBHbmCJcdz/XxpIQwoeHXqu0gwkfsIcq7MYRbkf
 uEtEDJ0zObwBNdi+1TvxcKkaHzgFd5/YbK24b9DWwiwyx5qEA1HB5y7/OzZMDzd2HAzY Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm2v5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:44:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140QGFd100665;
        Thu, 4 Feb 2021 00:44:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 36dh7ucqqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:44:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1140iTWd159077;
        Thu, 4 Feb 2021 00:44:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by userp3020.oracle.com with ESMTP id 36dh7ucqq6-1;
        Thu, 04 Feb 2021 00:44:29 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     saeed.mirzamohammadi@oracle.com, john.p.donnelly@oracle.com,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] kernel/crash_core: Add crashkernel=auto for vmcore creation
Date:   Wed,  3 Feb 2021 16:43:45 -0800
Message-Id: <20210204004347.41918-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040000
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
 Documentation/admin-guide/kdump/kdump.rst |  5 +++++
 arch/Kconfig                              | 24 +++++++++++++++++++++++
 kernel/crash_core.c                       |  7 +++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 75a9dd98e76e..f95a2af64f59 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -285,7 +285,12 @@ This would mean:
     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
     3) if the RAM size is larger than 2G, then reserve 128M
 
+Or you can use crashkernel=auto if you have enough memory. The threshold
+is 1G on x86_64 and arm64. If your system memory is less than the threshold,
+crashkernel=auto will not reserve memory. The size changes according to
+the system memory size like below:
 
+    x86_64/arm64: 1G-64G:128M,64G-1T:256M,1T-:512M
 
 Boot into System Kernel
 =======================
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..a772eb397d73 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -14,6 +14,30 @@ menu "General architecture-dependent options"
 config CRASH_CORE
 	bool
 
+if CRASH_CORE
+
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
+endif # CRASH_CORE
+
 config KEXEC_CORE
 	select CRASH_CORE
 	bool
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..ab0a2b4b1ffa 100644
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

