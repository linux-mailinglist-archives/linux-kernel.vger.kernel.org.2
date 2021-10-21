Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2528435D37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhJUIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:46:39 -0400
Received: from mx22.baidu.com ([220.181.50.185]:48282 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231556AbhJUIqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:46:33 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id DF4969DB59ED37AA494A;
        Thu, 21 Oct 2021 16:44:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:44:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:44:15 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:44:13 +0800
Message-ID: <20211021084414.2713-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 arch/x86/kernel/apm_32.c   | 3 +--
 arch/x86/mm/pat/cpa-test.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 241dda687eb9..0bc62af68ac5 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2347,7 +2347,7 @@ static int __init apm_init(void)
 
 	proc_create_single("apm", 0, NULL, proc_apm_show);
 
-	kapmd_task = kthread_create(apm, NULL, "kapmd");
+	kapmd_task = kthread_run(apm, NULL, "kapmd");
 	if (IS_ERR(kapmd_task)) {
 		pr_err("disabled - Unable to start kernel thread\n");
 		err = PTR_ERR(kapmd_task);
@@ -2355,7 +2355,6 @@ static int __init apm_init(void)
 		remove_proc_entry("apm", NULL);
 		return err;
 	}
-	wake_up_process(kapmd_task);
 
 	if (num_online_cpus() > 1 && !smp) {
 		printk(KERN_NOTICE
diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 0612a73638a8..8022a5769a45 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -266,10 +266,8 @@ static int start_pageattr_test(void)
 {
 	struct task_struct *p;
 
-	p = kthread_create(do_pageattr_test, NULL, "pageattr-test");
-	if (!IS_ERR(p))
-		wake_up_process(p);
-	else
+	p = kthread_run(do_pageattr_test, NULL, "pageattr-test");
+	if (IS_ERR(p))
 		WARN_ON(1);
 
 	return 0;
-- 
2.25.1

