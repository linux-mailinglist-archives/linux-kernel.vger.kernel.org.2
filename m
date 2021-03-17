Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3234B33ECEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCQJZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Mar 2021 05:25:14 -0400
Received: from mx1.emlix.com ([136.243.223.33]:43622 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhCQJYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:24:55 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 1348760151;
        Wed, 17 Mar 2021 10:24:52 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] typo: kthead -> kthread
Date:   Wed, 17 Mar 2021 10:24:51 +0100
Message-ID: <2268277.hsbtYad1Uq@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 mm/oom_kill.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d603771c7dc..5f22869d7c66 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1861,7 +1861,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthead if needed, either due to it
+ * Awaken the no-CBs grace-period kthread if needed, either due to it
  * legitimately being asleep or due to overload conditions.
  *
  * If warranted, also wake up the kthread servicing this CPUs queues.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9efaf430cfd3..cd7f9ac48746 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -922,7 +922,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			continue;
 		}
 		/*
-		 * No kthead_use_mm() user needs to read from the userspace so
+		 * No kthread_use_mm() user needs to read from the userspace so
 		 * we are ok to reap it.
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
-- 
2.30.2

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



