Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0625E33EE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCQKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:21:59 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36684 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhCQKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:21:34 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0DF8B3C0597;
        Wed, 17 Mar 2021 11:21:33 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1TpZrAOB8lFo; Wed, 17 Mar 2021 11:21:26 +0100 (CET)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0E5253C0579;
        Wed, 17 Mar 2021 11:20:44 +0100 (CET)
Received: from lxhi-065.192.168.1.1 (10.72.94.36) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 17 Mar
 2021 11:20:42 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiafei Pan <Jiafei.Pan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>
CC:     Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v2] softirq: s/BUG/WARN_ONCE/ on tasklet SCHED state not set
Date:   Wed, 17 Mar 2021 11:20:12 +0100
Message-ID: <20210317102012.32399-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.94.36]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Replace BUG() with WARN_ONCE() on wrong tasklet state, in order to:
 * increase the verbosity / aid in debugging
 * avoid fatal/unrecoverable state

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---

Changes since v1:
 * Factored out the change into a separate function
 * Replaced BUG with WARN_ONCE
 * Fixed 'checkpatch --strict' errors
 * v1: https://lore.kernel.org/lkml/20210315154421.11463-1-erosca@de.adit-jv.com/

 kernel/softirq.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4a9bfe..17a93d47b9a1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -531,6 +531,18 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
+static bool tasklet_should_run(struct tasklet_struct *t)
+{
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+		return true;
+
+	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
+		  t->use_callback ? "callback" : "func",
+		  t->use_callback ? (void *)t->callback : (void *)t->func);
+
+	return false;
+}
+
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
@@ -550,13 +562,12 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
-				if (t->use_callback)
-					t->callback(t);
-				else
-					t->func(t->data);
+				if (tasklet_should_run(t)) {
+					if (t->use_callback)
+						t->callback(t);
+					else
+						t->func(t->data);
+				}
 				tasklet_unlock(t);
 				continue;
 			}
-- 
2.29.0

