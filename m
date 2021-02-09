Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9934315CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhBJCGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:06:37 -0500
Received: from mail.windriver.com ([147.11.1.11]:59128 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhBJAvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:51:13 -0500
X-Greylist: delayed 6077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 19:43:53 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 119N0cHd018641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 15:00:43 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:22 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:21 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 8/8] rcu: deprecate "all" option to rcu_nocbs=
Date:   Tue, 9 Feb 2021 17:59:07 -0500
Message-ID: <20210209225907.78405-9-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the core bitmap support now accepting "N" as a placeholder for
the end of the bitmap, "all" can be represented as "0-N" and has the
advantage of not being specific to RCU (or any other subsystem).

So deprecate the use of "all" by removing documentation references
to it.  The support itself needs to remain for now, since we don't
know how many people out there are using it currently, but since it
is in an __init area anyway, it isn't worth losing sleep over.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +---
 kernel/rcu/tree_plugin.h                        | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..a116c0ff0a91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4037,9 +4037,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7e291ce0a1d6..56788dfde922 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1463,14 +1463,12 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
 		cpumask_setall(rcu_nocb_mask);
 	else
 		if (cpulist_parse(str, rcu_nocb_mask)) {
-- 
2.17.1

