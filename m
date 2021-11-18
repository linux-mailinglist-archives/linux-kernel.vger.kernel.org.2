Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F94554F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbhKRG5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbhKRG4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:56:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF15C061766
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:53:55 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x9-20020a056a00188900b0049fd22b9a27so3009707pfh.18
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gqma2pWdNr7xdLS7T1V9DQe179q0YDzZTbjqjZXlV0o=;
        b=HbN3FLE40/IRvRc1oUsvv83AnEx3cTy8FUmt1YKuGn+CdySMi7r7n1WB32cyzurnem
         6UQrs9TCkeOGsd+i+5WJsvqUyl/ORgAD4YnYPB2YfWiXhElbH3Hf7G64RXKsrr91B05H
         qEkv5UVvocjv0ct742vQRIU5Nk16nukGBhgU0a1qvW1TI8A5tRvbhTSY19lj5HCodBs9
         oHeN6jPtK50uTctPvTSSUt9j48EgI1Ey9sLP/MSH1wNLp78N87bHkvLJ3g4usImymHkY
         yDCL9+v+SzTms7fiKiv39bm9gytpi9C1KEEnlcAla3hokHKuspYTljc/q4IlW80K2Vkv
         Dpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gqma2pWdNr7xdLS7T1V9DQe179q0YDzZTbjqjZXlV0o=;
        b=Eg+27u3exBUWz+npSHhBGUOcCauV+mjKowBwfK+9iKOgxBTACd19xeqvd8ua7daLQy
         ppRUEtT/ukUeP7hbEGgo25YYEuchCPB4xmLQNFjyoTOmwE3rySKovRzXhxCp5dV2Gp/i
         Vp143LsxA7PzjQUEVhcnfnUJNh1LBecLTRJBQfeygljkLEU1sbiBGBKgraGVodL1Dpnw
         wgJsbKx9JKXIX6IYo1FqILLjU4B8pZQRizD1Tt+D3zUXz4DufDZ9BI4RSE4dp58K6gDT
         u2WyADZ+p8N3PnJZPGezz9LTU7SBSSKGmytsRLZ/VGsmJksN2PB6rskpMDshSo1zNqO1
         a02g==
X-Gm-Message-State: AOAM5303Qp5MzAdNEQmAQAHKZzdRYJF3umXNYtOL/GSxh0DNC8jpeT4V
        9vKjlpnk911nkHTgXw9oBXPriQ60fpawaA==
X-Google-Smtp-Source: ABdhPJxjuLAWkPLRGxQBAq8gzZIgv3ll3UCcW09rwWPbGZA/IrFbHxFox4B0xY4NKYVZGRnNAkzggRcBpuTapQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1f92:79a2:910:cfc8])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1a86:: with SMTP id
 ng6mr7771396pjb.142.1637218434751; Wed, 17 Nov 2021 22:53:54 -0800 (PST)
Date:   Wed, 17 Nov 2021 22:53:50 -0800
Message-Id: <20211118065350.697046-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] memcg: better bounds on the memcg stats updates
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 11192d9c124d ("memcg: flush stats only if updated") added
tracking of memcg stats updates which is used by the readers to flush
only if the updates are over a certain threshold. However each
individual update can corresponds to a large value change for a given
stat. For example adding or removing a hugepage to an LRU changes the
stat by thp_nr_pages (512 on x86_64). Treating the update related to THP
as one can keep the stat off, in theory, by (thp_nr_pages * nr_cpus *
CHARGE_BATCH) before flush.

To handle such scenarios, this patch adds consideration of the stat
update value as well instead of just the update event. In addition let
the asyn flusher unconditionally flush the stats to put time limit on
the stats skew and hopefully a lot less readers would need to flush.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..a8f07540d4b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -629,11 +629,17 @@ static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 
-static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
+static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	unsigned int x;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
-	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
-		atomic_inc(&stats_flush_threshold);
+
+	x = __this_cpu_add_return(stats_updates, abs(val));
+	if (x > MEMCG_CHARGE_BATCH) {
+		atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
+		__this_cpu_write(stats_updates, 0);
+	}
 }
 
 static void __mem_cgroup_flush_stats(void)
@@ -656,7 +662,7 @@ void mem_cgroup_flush_stats(void)
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
-	mem_cgroup_flush_stats();
+	__mem_cgroup_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
 }
 
@@ -672,7 +678,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, val);
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -705,7 +711,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, val);
 }
 
 /**
@@ -807,7 +813,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
-	memcg_rstat_updated(memcg);
+	memcg_rstat_updated(memcg, count);
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
-- 
2.34.0.rc1.387.gb447b232ab-goog

