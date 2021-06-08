Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7439F5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhFHMGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhFHMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:06:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0197561360;
        Tue,  8 Jun 2021 12:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623153893;
        bh=uB4SVFjKL8Ntldu4qxsd+Po8QLCTsFR/FDLapR2UJHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLVDcTPu8X/b9+2ewnDs1ULXq1z3p5+6TaFNwjtTZ4GoyzgkPJE9m1tZpEL3oojEL
         iug3Ssnc8gMtPy5jo3wP/79yDfoGFO/VDOurxFU4r5xB/j8yVcKmya7HrIfBUksi5P
         fUzC1qCrCH8qPUgKlY7QDBytmDRZo9xfPwyO6qp3MnnGDBqGSFp+Ov0knbEAhM9KBc
         oEl8tWyjwFPIiSt5IgnGp2A3cY5Voo19O+o1x7gcmmw6UsNsW3tKou8JS3r8Ta1wqi
         IFWUe17xRTRKm/9M0XtrLM7mPZTawq2v6Citp2xy1oZ/VonZHpbI3p4pAfxAxpFgBT
         pYykcRyWq3YCw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/2] sched: Always print out preempt dynamic state
Date:   Tue,  8 Jun 2021 14:04:42 +0200
Message-Id: <20210608120442.93587-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608120442.93587-1-frederic@kernel.org>
References: <20210608120442.93587-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the preempt dynamic mode wasn't printed out if it wasn't
overriden with the "preempt=" boot option.

But now that the default preempt dynamic behaviour can be selected at
Kconfig time, we can't assume anymore that preempt=full is the default.
The only way to retrieve that information is to browse the kernel config
file.

Better print it out unconditionally then.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df47a8275c37..6b883adad8f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6262,6 +6262,21 @@ int sched_dynamic_mode(const char *str)
 
 void sched_dynamic_update(int mode)
 {
+	switch (mode) {
+		case preempt_dynamic_none:
+			pr_info("Dynamic Preempt: none\n");
+			break;
+		case preempt_dynamic_voluntary:
+			pr_info("Dynamic Preempt: voluntary\n");
+			break;
+		case preempt_dynamic_full:
+			pr_info("Dynamic Preempt: full\n");
+			break;
+		default:
+			pr_info("Dynamic Preempt: incorrect\n");
+			return;
+	}
+
 	if (preempt_dynamic_mode == mode)
 		return;
 
@@ -6282,7 +6297,6 @@ void sched_dynamic_update(int mode)
 		static_call_update(preempt_schedule, NULL);
 		static_call_update(preempt_schedule_notrace, NULL);
 		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
@@ -6291,7 +6305,6 @@ void sched_dynamic_update(int mode)
 		static_call_update(preempt_schedule, NULL);
 		static_call_update(preempt_schedule_notrace, NULL);
 		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
@@ -6300,7 +6313,6 @@ void sched_dynamic_update(int mode)
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
 
@@ -6323,8 +6335,7 @@ __setup("preempt=", setup_preempt_mode);
 
 static void __init init_preempt(void)
 {
-	if (preempt_dynamic_mode_init != preempt_dynamic_full)
-		sched_dynamic_update(preempt_dynamic_mode_init);
+	sched_dynamic_update(preempt_dynamic_mode_init);
 }
 #else
 static inline void init_preempt(void) { }
-- 
2.25.1

