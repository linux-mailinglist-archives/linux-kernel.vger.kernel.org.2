Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169A39F05D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:05:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4510 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhFHIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:05:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzjNX3YLPzZdk7;
        Tue,  8 Jun 2021 16:01:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:03:49 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:03:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] signal: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 16:03:42 +0800
Message-ID: <20210608080342.13226-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

sed -r -i 's/[ \t]+$//' kernel/signal.c

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 30b70829828a..9569f736eb5d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2847,7 +2847,7 @@ bool get_signal(struct ksignal *ksig)
 }
 
 /**
- * signal_delivered - 
+ * signal_delivered -
  * @ksig:		kernel signal struct
  * @stepping:		nonzero if debugger single-step or block-step in use
  *
@@ -4398,7 +4398,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 	if (!ret && oact) {
-		ret = put_user(ptr_to_compat(old_ka.sa.sa_handler), 
+		ret = put_user(ptr_to_compat(old_ka.sa.sa_handler),
 			       &oact->sa_handler);
 		ret |= put_compat_sigset(&oact->sa_mask, &old_ka.sa.sa_mask,
 					 sizeof(oact->sa_mask));
@@ -4577,7 +4577,7 @@ SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
 		return -EFAULT;
 	return sigsuspend(&newset);
 }
- 
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(rt_sigsuspend, compat_sigset_t __user *, unewset, compat_size_t, sigsetsize)
 {
-- 
2.25.1


