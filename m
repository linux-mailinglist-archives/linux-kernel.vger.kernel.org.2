Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319B33C1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCOPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:52:04 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:58606 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhCOPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:51:44 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 11:51:43 EDT
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id D957C3C04C0;
        Mon, 15 Mar 2021 16:44:58 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CN18AV6ZaDqd; Mon, 15 Mar 2021 16:44:53 +0100 (CET)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 929E73C04C1;
        Mon, 15 Mar 2021 16:44:51 +0100 (CET)
Received: from lxhi-065.192.168.1.1 (10.72.94.10) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 15 Mar
 2021 16:44:47 +0100
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
Subject: [PATCH] softirq: Be more verbose on t->state BUG()
Date:   Mon, 15 Mar 2021 16:44:21 +0100
Message-ID: <20210315154421.11463-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.94.10]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

In case this BUG() is hit, it helps debugging a lot to get an idea
what tasklet is the root cause. So, be slightly more verbose here.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 kernel/softirq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4a9bfe..a6b602ad48d6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -550,9 +550,13 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+					if (t->use_callback)
+						pr_emerg("tasklet failed, cb: %pS\n", t->callback);
+					else
+						pr_emerg("tasklet failed, func: %pS\n", t->func);
 					BUG();
+				}
 				if (t->use_callback)
 					t->callback(t);
 				else
-- 
2.29.0

