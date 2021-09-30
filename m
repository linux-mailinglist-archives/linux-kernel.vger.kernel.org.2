Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DE41D281
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbhI3EtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhI3EtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:49:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC11AC06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:47:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo5-20020a17090b1c8500b0019e585e8f6fso6490621pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3wCSVYwLyxFTgw/NEPcqwwI1Bpk2vqRKGXaqYC4gfms=;
        b=DtSDabIIC+wI82CTcYe7egJAGdF/UFE2BKRj3Yae1ZQd2V54f2o78Q4UrdWf6YKqcr
         0wFzisOz2LGitNBfKkvecCzJqQWOrcIwALJwdVcDjpLyGBqXFuE0neUoeoIzr6FbF6Hc
         o/GZeEV5sqXh12jPc516sCjkzUNl/KaC1jmlcnsR9DUHvLoRX28wrFdu2nAtyXi95Hvj
         JXk4dtsivlft9MddRs1ZmyQrGJBxpzcG4/4iyfcnmAPPSQJWjr2je++2ppdKs91qx7mk
         9KqgdC5GaMuCyA5Bb8eMtD1wBT82M0MOUL3kW3ohFKxivrEagmT9gRJhVace95S4FYHx
         tzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3wCSVYwLyxFTgw/NEPcqwwI1Bpk2vqRKGXaqYC4gfms=;
        b=boajYCcGwI1jr8an2zNDC0A0QnhlhVc6h4Z6+gDx5BAt2bZ94UfTmi8b1MeK2XAp9H
         71LOWRZIokqbPFT5qOHkoiUN9y8rQfu7e9vOlWMCkpM41PUnX+0zlloK6S7BLgUY5P4L
         NZzLG1uopM9aOu6WdSXdFlVrjSdnHN1NQ4XMqkCvDPpWBv3W7+uYHIRCbsvijeEj09Yf
         g1G/LzqbjexFjL3Q/GbG3l1IBtzSJ/4zWDMpp68nI/SVAQ31ovGPBDsnWbY5q4nkMHAA
         CkgcK3cgQCt4fIujMm197ERWYiV7SnBTwHO1Si+VD8ROJC0jc13G6Aumomdiad1VWn/y
         SMZQ==
X-Gm-Message-State: AOAM533Gm7k1hnHgGnwmXHFIXxmxKd1Va5lWtf0Csyd/XOPAWYQDJHJW
        HVM0nCFLBBs5FFJ3TkjZdFgKs5u4xSh6bA==
X-Google-Smtp-Source: ABdhPJyzzSFOJ25gEBsJ3rGoOkoxHHAwcnvoxBWUw9cUHF51oByMunT/xnn7z63a888V1JleYEgftdTbWgb12w==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:4f8a:fdf0:d4ae:6a30])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:8b89:: with SMTP id
 z9mr4151194pjn.89.1632977258242; Wed, 29 Sep 2021 21:47:38 -0700 (PDT)
Date:   Wed, 29 Sep 2021 21:47:11 -0700
In-Reply-To: <20210930044711.2892660-1-shakeelb@google.com>
Message-Id: <20210930044711.2892660-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210930044711.2892660-1-shakeelb@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 2/2] memcg: unify memcg stat flushing
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg stats can be flushed in multiple context and potentially in
parallel too. For example multiple parallel user space readers for memcg
stats will contend on the rstat locks with each other. There is no need
for that. We just need one flusher and everyone else can benefit. In
addition after aa48e47e3906 ("memcg: infrastructure to flush memcg
stats") the kernel periodically flush the memcg stats from the root, so,
the other flushers will potentially have much less work to do.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 933dde29c67b..688c891448dd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1425,7 +1425,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 *
 	 * Current memory state:
 	 */
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -3529,8 +3529,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		/* mem_cgroup_threshold() calls here from irqsafe context */
-		cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
+		mem_cgroup_flush_stats();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
@@ -3911,7 +3910,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -3983,7 +3982,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4486,7 +4485,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -5354,12 +5353,14 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 static void __mem_cgroup_flush_stats(void)
 {
-	if (!spin_trylock(&stats_flush_lock))
+	unsigned long flag;
+
+	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
 		return;
 
 	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock(&stats_flush_lock);
+	spin_unlock_irqrestore(&stats_flush_lock, flag);
 }
 
 void mem_cgroup_flush_stats(void)
@@ -6391,7 +6392,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
-- 
2.33.0.685.g46640cef36-goog

