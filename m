Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8269314958
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBIHPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhBIHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:15:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B708C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:14:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fa16so1052978pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBi5D+BcqC5w/vq5VvVkaslOyGiJz1EHhIgcUpjbi0Q=;
        b=BL0h6myr34yFEmCYtuUdSVq9+3H2/eP1C6OpijptdQDhO2pG/Uj83tfPwnfLNrTNxq
         8ezswyqe0RaR3HBzhwUKV/wyhHk3KlLMZpqzr7U7mBZFT30s0rA30YNkbyCFKgjTvyiU
         5NFUJQC+XH2GvVZrQmaChwHKuWD95Icxnjry1owNbw/2BQpPx1Xvc2b8o3ULHWSPouCN
         QMTku6oVAcB+yEgiLZJDfr8Khi6rtyYBgPSGYikYkwzhlZZLD3t6uDdq3jwur/NmlLD+
         7M/7ALiJHesP+Hd8MBn4TTuW9/Txtf/kxHsk3WYK3h+F0wMWiU5k4a7X6h80IrmtmoNn
         OUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBi5D+BcqC5w/vq5VvVkaslOyGiJz1EHhIgcUpjbi0Q=;
        b=tUr86rlyJmmHo3FZZEdcxnnvNdBGPsARNUuoiZjY6EqtmsDFUryLO67v2Bm19NdnpL
         psqqWIAWauKt5pDejDU8PK5z27MGrleSGwuarw3WUMtqB5ipYYBHuQVbqoaYp22hTrKn
         CUHEZZ3dNdAtcZB+KGjU8JQ8g+8PUXfi/nP+ytxFFCAyQ2LxHa/GwR2XvhP2eWH7NtO5
         qQtksfFaGA5NEbBvHydVBWDwI3aNylt63yjkZUObT9psT31BfkaN9+p/5Go0kwkXoo66
         Mw7QXJHjDQmoXNioyHE0Jc+Ptn8qQ+ErfoyT9fTy5sfeSzWhzU2b6+IY6qdREcjm9G13
         0kSg==
X-Gm-Message-State: AOAM5306IvWTE2fTmA0b2Hmb8tGn5AD/NkGsIVrmXRl8MQcLeZljlmvx
        aR5iwI40GqLTSS9lJxALv0CqNQ==
X-Google-Smtp-Source: ABdhPJz4BL8QnIz6e+6qcyl4Wn9CEFfGHJjwLwaX05eTxO7L102m1zjekPaVp6n2v4hOnsPuhjfEzA==
X-Received: by 2002:a17:902:d48b:b029:e1:f87:265d with SMTP id c11-20020a170902d48bb02900e10f87265dmr20438658plg.1.1612854861095;
        Mon, 08 Feb 2021 23:14:21 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id v126sm19091245pfv.163.2021.02.08.23.14.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 23:14:20 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH] psi: Optimize task switch inside shared cgroups
Date:   Tue,  9 Feb 2021 15:14:13 +0800
Message-Id: <20210209071413.17097-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
cgroups") only update cgroups whose state actually changes during a
task switch only in task preempt case, not in task sleep case.

We actually don't need to clear and set TSK_ONCPU state for common cgroups
of next and prev task in sleep case, that can save many psi_group_change
especially when most activity comes from one leaf cgroup.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c   | 27 +++++++++++++++++----------
 kernel/sched/stats.h | 17 +++--------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 6e46d9eb279b..6061e87089ac 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -836,20 +836,27 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		}
 	}
 
-	/*
-	 * If this is a voluntary sleep, dequeue will have taken care
-	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
-	 * only need to deal with it during preemption.
-	 */
-	if (sleep)
-		return;
-
 	if (prev->pid) {
-		psi_flags_change(prev, TSK_ONCPU, 0);
+		int clear = 0, set = 0;
+
+		if (sleep) {
+			clear |= TSK_RUNNING;
+			if (prev->in_iowait)
+				set |= TSK_IOWAIT;
+		}
+
+		psi_flags_change(prev, clear | TSK_ONCPU, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
+			psi_group_change(group, cpu, clear | TSK_ONCPU, set, true);
+
+		if (sleep) {
+			while (group) {
+				psi_group_change(group, cpu, clear, set, true);
+				group = iterate_groups(prev, &iter);
+			}
+		}
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 9e4e67a94731..2d92c8467678 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -84,28 +84,17 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING, set = 0;
-
 	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!sleep) {
+		int clear = TSK_RUNNING;
+
 		if (p->in_memstall)
 			clear |= TSK_MEMSTALL;
-	} else {
-		/*
-		 * When a task sleeps, schedule() dequeues it before
-		 * switching to the next one. Merge the clearing of
-		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
-		 * psi_task_change() call in psi_sched_switch().
-		 */
-		clear |= TSK_ONCPU;
 
-		if (p->in_iowait)
-			set |= TSK_IOWAIT;
+		psi_task_change(p, clear, 0);
 	}
-
-	psi_task_change(p, clear, set);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
-- 
2.11.0

