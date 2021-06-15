Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821A23A87FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFORrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhFORq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:46:59 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C529C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:44:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v19-20020a0ce1d30000b02902187ed4452eso115057qvl.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Iz29C08sFJm0taW2hiHDiec7o6H7fLe3J2KrZkSw4Wg=;
        b=tTnedSnwGXolczu44KDqPFYzqUhFG0Wfi6rTaBDUakFr3yiBFcBdAiG2yl48Dj/0TT
         PIASE5VNvQzGGumlUkwgy7qHxEFNiof1XX8Zzygi2ufxh9tS3vC83PdFfIt6kagXcJ7J
         XVyk4y2+4bWvYs6DN/mqlg9MxaJaBU98PI+7PChmapHsOl7F/Kui8Jb7npr1Fn/ck9ce
         zy/zNnetTlXf2jLLCF/Z1zWGeegyrUOEiLUSYsD58bqx6JM+YfsoTwwlgZUx0XfxNsxl
         atdHQ8ebsTUCq64FQEZd3/HcuYlIAlyORh53Rk3bQpGFM7RovXaARV3vOBDPiVb+SKz0
         r8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iz29C08sFJm0taW2hiHDiec7o6H7fLe3J2KrZkSw4Wg=;
        b=lXuQE7hi9qWFLBoiB9prvKtvL0RiHsqvaoxwqhiiJz2br82HhornbdgxD4OSJ7qwH0
         jwexehfeOW76zec6RtJdXElgquidwgTOCGQNUAWrqs0Jtf7XBJxTq98PYpX2JslbA6n4
         nRolx+XisMYoyyFMcWWxmcvCxKTbWL8DkYhSRRTxvxTVStTSf6pvTb8OLOCuC+l5CHeG
         T8DvJLTqw4PPBT+filjDoxic5Jozbh81dsbTUHeGMQTfZwcKAmEgBv8ufdkj4HuG+4XY
         ELqv1Afdev5bCB6tkfRFb+lTRn7h5i2XICGvT0jy5iwC5Mkfi1Br0mY5rByIJ3kQEb1X
         SVFA==
X-Gm-Message-State: AOAM531EWCARAnK0Mg154PJ75WZS3+SU6YcHsgfvGEcxKZE/s6+EMKIi
        a8wrZmQrUuC2IaNkppZ+EQfbIGgy4Bmeug==
X-Google-Smtp-Source: ABdhPJyFzjQESlViPskRerATPZ7JDg0A4sdXnLQRMhiPcO3tV6YS+CvI4rOWOOZlFz/96Qio2VI9e23HetYs2A==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:5fdb:fdf0:b7e3:fb19])
 (user=shakeelb job=sendgmr) by 2002:a05:620a:142f:: with SMTP id
 k15mr795933qkj.45.1623779092427; Tue, 15 Jun 2021 10:44:52 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:44:35 -0700
In-Reply-To: <20210615174435.4174364-1-shakeelb@google.com>
Message-Id: <20210615174435.4174364-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210615174435.4174364-1-shakeelb@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 2/2] memcg: periodically flush the memcg stats
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment memcg stats are read in four contexts:

1. memcg stat user interfaces
2. dirty throttling
3. page fault
4. memory reclaim

Currently the kernel flushes the stats for first two cases. Flushing the
stats for remaining two casese may have performance impact. Always
flushing the memcg stats on the page fault code path may negatively
impacts the performance of the applications. In addition flushing in the
memory reclaim code path, though treated as slowpath, can become the
source of contention for the global lock taken for stat flushing because
when system or memcg is under memory pressure, many tasks may enter the
reclaim path.

Instead of synchronously flushing the stats, this patch adds support of
asynchronous periodic flushing of the memcg stats. For now the flushing
period is hardcoded to 2*HZ but that can be changed later through maybe
sysctl if need arise.

This patch does add the explicit flushing in the kswapd thread as the
number of kswapd threads which corresponds to the number of nodes on
realistic machines are usually low.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- use system_unbound_wq for flushing the memcg stats

 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 14 ++++++++++++++
 mm/vmscan.c                |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0bfa0409af22..f34214382a1c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -991,6 +991,12 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
+static inline void mem_cgroup_flush_stats(void)
+{
+	if (!mem_cgroup_disabled())
+		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+}
+
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
@@ -1400,6 +1406,10 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline void mem_cgroup_flush_stats(void)
+{
+}
+
 static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 					    enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6e24fd8c5301..5910658bac84 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -97,6 +97,10 @@ bool cgroup_memory_noswap __ro_after_init;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
+/* Periodically flush memcg and lruvec stats. */
+static void flush_memcg_stats(struct work_struct *w);
+static DECLARE_DEFERRABLE_WORK(stats_flush, flush_memcg_stats);
+
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
@@ -5248,6 +5252,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
+
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		queue_delayed_work(system_unbound_wq, &stats_flush, 2UL*HZ);
+
 	return 0;
 }
 
@@ -5339,6 +5347,12 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
+static void flush_memcg_stats(struct work_struct *w)
+{
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	queue_delayed_work(system_unbound_wq, &stats_flush, 2UL*HZ);
+}
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7602f71ec04..7bf9a4241dd9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3893,6 +3893,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		sc.may_writepage = !laptop_mode && !nr_boost_reclaim;
 		sc.may_swap = !nr_boost_reclaim;
 
+		/*
+		 * Flush the memory cgroup stats, so that we read accurate
+		 * per-memcg lruvec stats for heuristics later.
+		 */
+		mem_cgroup_flush_stats();
+
 		/*
 		 * Do some background aging of the anon list, to give
 		 * pages a chance to be referenced before reclaiming. All
-- 
2.32.0.272.g935e593368-goog

