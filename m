Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC233D477
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCPM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhCPM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:57:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:57:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so1324167pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBApo0Sx/AlIIiA35NhGMVol5VGFpeyIdijCuf/iNHM=;
        b=ilox2ATAXdavbkJoa7rggl+BZOsqMq3xubCyIls26h5gJ0gLspKAyurQr60q6Tfmpv
         lOHta7U2CerfwIOuHh9CBwbPZ2vebRCi7sswW0WeVJKErAZVTtnEoLnD8+AAVnS8Dxqp
         bLgyIA69B+z2qxIeaZq1Z/AG4slV1wA0hQI4wIFIDqWwKzfmaRrv/aHAGyq/5JxDOlma
         Pa79SYfJvot+A7+emiHrxjU1EeAChoUbGE+M/AeDonfk5KpO8PDOQVj/+SB8cPpG7cDx
         H5ur2XLoFLkvo1UZ7erRy1MZw5c4aVBovTZY3Ja/T2C3zINur1wwL4+Q8UQm8y/rjGvG
         P+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBApo0Sx/AlIIiA35NhGMVol5VGFpeyIdijCuf/iNHM=;
        b=BsRs1eJehp6hq5mKySeNnEBjEQSHk9nDNsOh5a8JzkjNNtE01PxYmUTUsRGnhVd+rY
         RfdoFFWdAjdd3tl2xCwy0u3tvX28gaJ2GFNQIpriZ/b3vTKi3fV/KFoCF9syTgt9x1Gi
         sFwDB6AKB/Tx3szbbXpvnAACRz4Y7yC7yJyZ2oNlZ+lQhJffzIRy4A1l4l4ahQFQU5CF
         DaPB7oBFLJhFjgVVKv8xrvDQhMgMaRf90TWWvw1JsPFeocxDld+eiLfKret+njjE03V0
         c3BiPngmlEdrbyzDBOCscrq+ObvBH5q6nKBrIeA2QOlPFF+JnkB9gM4148zeSxgvCsy6
         If2A==
X-Gm-Message-State: AOAM530oAszsEQ2Mj0yhCDK+q61fqZrTFwG17g6nGI+yUm+OiLgutY7X
        GssYpH2bQzQeGkGsuxl4UGI=
X-Google-Smtp-Source: ABdhPJxnSqFvjcMMrrVzE3Ar67QffDypvwTQwux100b2QVcdmhuzGBZLcZfZu4J7f77ndgDuvZirSw==
X-Received: by 2002:a17:90a:3902:: with SMTP id y2mr4835090pjb.202.1615899473495;
        Tue, 16 Mar 2021 05:57:53 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id x4sm16059955pfn.134.2021.03.16.05.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:57:53 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] kernel:kprobe: Fix typo issue
Date:   Tue, 16 Mar 2021 20:57:51 +0800
Message-Id: <20210316125751.11023-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'immmediately' to 'immediately'
change 'quiesence' to 'quiescence'
change 'unneed' to 'unneeded'
change 'sinec' to 'since
change 'sefe' to 'safe''
change 'And' to 'At the'
change 'buy' to 'but'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 kernel/kprobes.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..ae3a22d2099b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -506,7 +506,7 @@ static void do_optimize_kprobes(void)
 	/*
 	 * The optimization/unoptimization refers online_cpus via
 	 * stop_machine() and cpu-hotplug modifies online_cpus.
-	 * And same time, text_mutex will be held in cpu-hotplug and here.
+	 * At the same time, text_mutex will be held in cpu-hotplug and here.
 	 * This combination can cause a deadlock (cpu-hotplug try to lock
 	 * text_mutex but stop_machine can not be done because online_cpus
 	 * has been changed)
@@ -592,12 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
 
 	/*
 	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
-	 * kprobes before waiting for quiesence period.
+	 * kprobes before waiting for quiescence period.
 	 */
 	do_unoptimize_kprobes();
 
 	/*
-	 * Step 2: Wait for quiesence period to ensure all potentially
+	 * Step 2: Wait for quiescence period to ensure all potentially
 	 * preempted tasks to have normally scheduled. Because optprobe
 	 * may modify multiple instructions, there is a chance that Nth
 	 * instruction is preempted. In that case, such tasks can return
@@ -607,10 +607,10 @@ static void kprobe_optimizer(struct work_struct *work)
 	 */
 	synchronize_rcu_tasks();
 
-	/* Step 3: Optimize kprobes after quiesence period */
+	/* Step 3: Optimize kprobes after quiescence period */
 	do_optimize_kprobes();
 
-	/* Step 4: Free cleaned kprobes after quiesence period */
+	/* Step 4: Free cleaned kprobes after quiescence period */
 	do_free_cleaned_kprobes();
 
 	mutex_unlock(&text_mutex);
@@ -631,7 +631,7 @@ void wait_for_kprobe_optimizer(void)
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
 
-		/* this will also make optimizing_work execute immmediately */
+		/* this will also make optimizing_work execute immediately */
 		flush_delayed_work(&optimizing_work);
 		/* @optimizing_work might not have been queued yet, relax */
 		cpu_relax();
@@ -1057,7 +1057,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 
 err_ftrace:
 	/*
-	 * At this point, sinec ops is not registered, we should be sefe from
+	 * At this point, since ops is not registered, we should be safe from
 	 * registering empty filter.
 	 */
 	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
@@ -1712,7 +1712,7 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 			/*
 			 * If kprobes_all_disarmed is set, orig_p
 			 * should have already been disarmed, so
-			 * skip unneed disarming process.
+			 * skip unneeded disarming process.
 			 */
 			if (!kprobes_all_disarmed) {
 				ret = disarm_kprobe(orig_p, true);
@@ -2424,7 +2424,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 			     within_module_core((unsigned long)p->addr, mod))) {
 				/*
 				 * The vaddr this probe is installed will soon
-				 * be vfreed buy not synced to disk. Hence,
+				 * be vfreed but not synced to disk. Hence,
 				 * disarming the breakpoint isn't needed.
 				 *
 				 * Note, this will also move any optimized probes
-- 
2.25.1

