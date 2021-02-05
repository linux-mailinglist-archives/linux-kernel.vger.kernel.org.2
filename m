Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F014310FF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhBEQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhBEQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:47:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0372C06121D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:28:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r20so5693582qtm.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=U4EQA/daTMWDj2KpnKM6JeOv9uy/kBDEm/uO2MZ/dYoFEl9BtZMe0u8Up1GJlOAVat
         FyUdHSnYcoLRyCDpy8I5JguO9gryQYk06pvXlFuWvP1nanx9BoVt708OpOVjX7hGp0NM
         u3CpSRjrbpoptPnLF+vCKAD0uEl8CgLgfTmhRpQRx/D7hadhMAKsjwWqjtUsOTrJBngg
         UoyMrvGzLTbhsQjBLb0Zn4ex3iUdg2hNEv85wEs/BAJ3rcBGu3oLsoIUeTYsYAC4yl/2
         Yon8QeGPR9FRKoCpxU7jZA/EY4KF58sECERo6V/grHRiHwQukuZWKSjdWkEetayENa9D
         8EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=g2sHq9KocIqX7DKGYmvKMsxyjkoetnZSecY2SiUwMvLO4XRHRKqtTQseylDSuLvunM
         5Qc5gRnGFImz19E+1a3vD5IBYMye7y7ROakNQGgmr3UrqY8WaTn72PzrQffwdUKRa65W
         8llQBMTBeZyNDUg7H5LW+Gu8NiOwz3LMESPCvOmLTNjpML4ltCTIsRm2vAk0uQgRB129
         7bdEyWDco4aaHSwso/ou/MsxQlhjdqtl+Z4BOxXbqUSOS3697cZHQMnXEC4VjVallrkt
         DQwhumzjtRX34LsHTkDwGTxuHQNaLnotdtg/zfJYN5MfoG59yCmyRbP5xG+s6SM83EB4
         vYiw==
X-Gm-Message-State: AOAM531hC0BzZoEDZyEYKls9nZdhPSfg0yMxpiT75RWzBRIYObm+SkWp
        /expnb4rrto7wTon2UBLYB5Qcw==
X-Google-Smtp-Source: ABdhPJxc7WXk4zJUXM1XvvDnCZEwxVU/BXPLAaamoPKXlLUScXsoh7UaMFIajiqR+agL6tmf/QJPQg==
X-Received: by 2002:ac8:598e:: with SMTP id e14mr5644319qte.346.1612549707014;
        Fri, 05 Feb 2021 10:28:27 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q50sm9452451qtb.32.2021.02.05.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:26 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/8] mm: memcontrol: fix cpuhotplug statistics flushing
Date:   Fri,  5 Feb 2021 13:27:59 -0500
Message-Id: <20210205182806.17220-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
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

