Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB63153F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhBIQel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhBIQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:34:09 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61FC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:33:29 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so8356649qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=uUoTNOiklG6u2aW1knB5j/h/924xUJpKPs57Dj8b9JUhO6eDFx4f+sK/hI+2XkfU7w
         qZ9iFDMaTnN42JrNKnouJvy6aVioYi1JQfidV0ejnNRSJ8lDP65Q8cd/Umnq57IjhMDz
         QMo9O0APPGpcdTdqthVXAvueK4C0BCEq0bKUbV/4UnwOswcBsHhYOVZ2QpOYL5kbkT3e
         e5XCOROPJWvDpgQzIUkA3f70l2e8sBRCrbe/P9JqzBGB3Vn8Rs06NRenB4XWIWYV994O
         BXhLDRbV5+P10DPS+ALOu/znxLWZYPgRfWOlFdPuTy2WZgK3Yzsv8WwBHW2ZbFnGGy+6
         6wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=GzfZbq+4hqUzvTOFQUwEMX9BCKu8DzB0um8TZbNa09ujytJFaXKj6zWADVL8/x7tbI
         s063Lnq62FbumKqUHr4/ok6O9C1yyyZEBLwIle9gKStLwq5DCuEIrBEr5w3koQlRxINo
         FTwU218fbvSrSz+KzouDHM1kbtbeblucrShww4R8NfiGJBA0BzeV746UfslqHW4M04v/
         Odp4SJFsG2DpDnzNx7aQsTfmBoET7/qIUug5kbqAA2ypkCemTfO/7YcVM9mAzRrZqveY
         jGPuvx6kfEDIdYOPARbyjcKLi+D9fXW8nv5THL3eep9Yx6+VagbbRi1DxkALYfS0vBuG
         m48g==
X-Gm-Message-State: AOAM531+m8VU3y0MlaagUdSsgQzUwSCsDpeeDxv7QAnMKASUerqd4SgZ
        bkziBSKt4RJxNX36IR8+JhKsKw==
X-Google-Smtp-Source: ABdhPJwDoRY7xAR2fOrTYv8xy1rPzMuRpJIsFN/IiiPrGYPncEiYJ12mhSRV/4f71WsmFZmNOxOXeA==
X-Received: by 2002:a37:54b:: with SMTP id 72mr8006905qkf.338.1612888409122;
        Tue, 09 Feb 2021 08:33:29 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 18sm15860050qtw.70.2021.02.09.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:28 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 1/8] mm: memcontrol: fix cpuhotplug statistics flushing
Date:   Tue,  9 Feb 2021 11:32:57 -0500
Message-Id: <20210209163304.77088-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg hotunplug callback erroneously flushes counts on the local
CPU, not the counts of the CPU going away; those counts will be lost.

Flush the CPU that is actually going away.

Also simplify the code a bit by using mod_memcg_state() and
count_memcg_events() instead of open-coding the upward flush - this is
comparable to how vmstat.c handles hotunplug flushing.

Fixes: a983b5ebee572 ("mm: memcontrol: fix excessive complexity in memory.stat reporting")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..8120d565dd79 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2411,45 +2411,52 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg, *mi;
+	struct mem_cgroup *memcg;
 
 	stock = &per_cpu(memcg_stock, cpu);
 	drain_stock(stock);
 
 	for_each_mem_cgroup(memcg) {
+		struct memcg_vmstats_percpu *statc;
 		int i;
 
+		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
+
 		for (i = 0; i < MEMCG_NR_STAT; i++) {
 			int nid;
-			long x;
 
-			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmstats[i]);
+			if (statc->stat[i]) {
+				mod_memcg_state(memcg, i, statc->stat[i]);
+				statc->stat[i] = 0;
+			}
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
 
 			for_each_node(nid) {
+				struct batched_lruvec_stat *lstatc;
 				struct mem_cgroup_per_node *pn;
+				long x;
 
 				pn = mem_cgroup_nodeinfo(memcg, nid);
-				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
-				if (x)
+				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
+
+				x = lstatc->count[i];
+				lstatc->count[i] = 0;
+
+				if (x) {
 					do {
 						atomic_long_add(x, &pn->lruvec_stat[i]);
 					} while ((pn = parent_nodeinfo(pn, nid)));
+				}
 			}
 		}
 
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-			long x;
-
-			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmevents[i]);
+			if (statc->events[i]) {
+				count_memcg_events(memcg, i, statc->events[i]);
+				statc->events[i] = 0;
+			}
 		}
 	}
 
-- 
2.30.0

