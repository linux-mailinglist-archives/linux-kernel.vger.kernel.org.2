Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED43310FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhBEQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhBEQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:48:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A6C0611BC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:28:36 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 19so7891616qkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkGochaaRcmTlyZxkCgRxNgKhbX45qwASpGU1xNehx0=;
        b=0F6KH20bviGrQNM9hbNvSXi7Vk/KA9cDm/VECQSQnHEPGSsqEZRI0RBWRVQ6p7HnxD
         kC8C0UB7VSTJzFNjkBOtg4VH27hzXIAf2zYhcPeZ+v+UP273dW65hwzx7s1q0zHV9zuE
         6vfEBaxgqx27Nni6gCcAWoGeoPzLDvXiXlOZTA9n3Z6qpCthBOX9QIdwNhwPDX36/zpY
         bL4fcNoSLRdYjOitEDTdeTKEkerao0KI7iYwRLfbfjEzu0FaMeyPFq93DsS1foVkMa5C
         iVzRPcKT76qsfJIiN0d/uMOZ0uR77juU+76rJpaWEPDpmJM4ewdbqq1FxIf6bknXkOCX
         bD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkGochaaRcmTlyZxkCgRxNgKhbX45qwASpGU1xNehx0=;
        b=Fai6i75TJ1cQLyBZFNZ47BjMlUbu91lftSzF4imLEhS0rUkhKkqFX+55WBJn6MoPen
         JH/DraO6Cdbh1/SXU+NAHbheuuBlzxYsVEtCA2DFcB5t6IocQ3wKYrLxEhiS8FI4ZdEa
         NSLwsGNCw30R/PdpzHHDw2Kz1ApKyUZJg5us4OomWod2LQrQTsxKuwuYF6Y2bDOneNtG
         YiPAGoXLcj6oFVAEo+Nk+DAQ/lQ03Hmihfol05MGbBwsneq8lnXm3llDiZAlQTZFckkr
         LztFMxJW8W+GUDT9RlaXtDn1Vpq6xZBtK0sm5ANZMIxknW7PgHMBOcVWc/Z8YFSMf7XM
         sMGQ==
X-Gm-Message-State: AOAM530La3xUI2CVsqeq4M1b5IMi+QDLQ6bOFfM7/mP8Z78kQk3qQOLR
        ZW7Opc9Ajfd4rJ6RXEwc8eUndA==
X-Google-Smtp-Source: ABdhPJwOCyzi6wMCfUG8t5Uh5azCf+Qr016KkMDhRws7YkXV+J/NqxYYWdgO7dds/64Fu1/bKXhz0g==
X-Received: by 2002:a37:9c94:: with SMTP id f142mr5628212qke.388.1612549715911;
        Fri, 05 Feb 2021 10:28:35 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q92sm8919874qtd.92.2021.02.05.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:35 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
Date:   Fri,  5 Feb 2021 13:28:05 -0500
Message-Id: <20210205182806.17220-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two functions to flush the per-cpu data of an lruvec into
the rest of the cgroup tree: when the cgroup is being freed, and when
a CPU disappears during hotplug. The difference is whether all CPUs or
just one is being collected, but the rest of the flushing code is the
same. Merge them into one function and share the common code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 74 +++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5dc0bd53b64a..490357945f2c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2410,39 +2410,39 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
-static int memcg_hotplug_cpu_dead(unsigned int cpu)
+static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
 {
-	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg;
-
-	stock = &per_cpu(memcg_stock, cpu);
-	drain_stock(stock);
+	int nid;
 
-	for_each_mem_cgroup(memcg) {
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		unsigned long stat[NR_VM_NODE_STAT_ITEMS];
+		struct batched_lruvec_stat *lstatc;
 		int i;
 
+		lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			int nid;
+			stat[i] = lstatc->count[i];
+			lstatc->count[i] = 0;
+		}
 
-			for_each_node(nid) {
-				struct batched_lruvec_stat *lstatc;
-				struct mem_cgroup_per_node *pn;
-				long x;
+		do {
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
+		} while ((pn = parent_nodeinfo(pn, nid)));
+	}
+}
 
-				pn = memcg->nodeinfo[nid];
-				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
+static int memcg_hotplug_cpu_dead(unsigned int cpu)
+{
+	struct memcg_stock_pcp *stock;
+	struct mem_cgroup *memcg;
 
-				x = lstatc->count[i];
-				lstatc->count[i] = 0;
+	stock = &per_cpu(memcg_stock, cpu);
+	drain_stock(stock);
 
-				if (x) {
-					do {
-						atomic_long_add(x, &pn->lruvec_stat[i]);
-					} while ((pn = parent_nodeinfo(pn, nid)));
-				}
-			}
-		}
-	}
+	for_each_mem_cgroup(memcg)
+		memcg_flush_lruvec_page_state(memcg, cpu);
 
 	return 0;
 }
@@ -3636,27 +3636,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
-{
-	int node;
-
-	for_each_node(node) {
-		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
-		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0 };
-		struct mem_cgroup_per_node *pi;
-		int cpu, i;
-
-		for_each_online_cpu(cpu)
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				stat[i] += per_cpu(
-					pn->lruvec_stat_cpu->count[i], cpu);
-
-		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
-	}
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -5192,12 +5171,15 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	int cpu;
+
 	memcg_wb_domain_exit(memcg);
 	/*
 	 * Flush percpu lruvec stats to guarantee the value
 	 * correctness on parent's and all ancestor levels.
 	 */
-	memcg_flush_lruvec_page_state(memcg);
+	for_each_online_cpu(cpu)
+		memcg_flush_lruvec_page_state(memcg, cpu);
 	__mem_cgroup_free(memcg);
 }
 
-- 
2.30.0

