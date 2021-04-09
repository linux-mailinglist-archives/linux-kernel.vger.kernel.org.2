Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB09C359EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhDIMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDIMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06399C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o123so4140609pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9NIkXZwJeY9BQLxm990Xgq1YToY0Mf1xe3y5CNo8RM=;
        b=dWLsY0ngeunr+RBAQqGR3+j09UWL24EWktFKSEr2lPA6XTiDQKIyljEVbo5IBZlfcN
         hh0/A+QYSyBTRemQpl6h3FbGw+F4QoKwlEka9laHMra79GO3ehEVfXd/OPYjjfgqmHh6
         5cuu66zgfbvgQsvPJDBaeT4msGnSgSbJzyuSK/9oKN5/HIgUgZX3ZzkgptKktQLPFkd3
         HWQZV4Fl6i+cP4j+vuC7yagM+MsNjGfjSoZSFazuvj6+rOVpVGcwI+WaQp2ZjajKbLxp
         2OKYmK7RQZP8QET12ph3+aBXmJ+2zSYfsrjuvBhvGI0yQTNg2Y2ci9vii51pT9jYJ/uq
         1YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9NIkXZwJeY9BQLxm990Xgq1YToY0Mf1xe3y5CNo8RM=;
        b=q3ipsKW3IO+MiwXsDIB5NY5NUEMCnnzyTSDPSTs/qsOL9ov99SAyUs0h5SuDlhPL1t
         7qD3zjFQLCBLcCK3KFJayS6+o9OJJLL4gDZEBa7s+o8cY70b8KO7idOIpTGg4cctvYKf
         3vaXhgPD6qttFeyD3ECLDVeF6Ktt/4s2YTPipaLNjdPB1ipd5fBs8NOs8mlxkHE4Shht
         xEwniV2Xudj4hhgyNKDSionctAAFefDwiTc52DLRetOpzwA4v460baN08TrHWYnGjh5j
         DTUoXShyC6Wc9QjZHrssLw2+sDD0qEkjWOZ3AP3qqJ3zZ7ujLahnaVPwqawv1JRJGcDM
         rGFg==
X-Gm-Message-State: AOAM533+VGA/Avav70hUp+7nooTxO3ReY06T/TqRZSf/V8fEY/Ta34Ha
        VZ658RmjCdR0gcFxQIccVnkxKQ==
X-Google-Smtp-Source: ABdhPJw2Tlg+r26vZ/OCGVh9R4wuT2N9krnWh5Kx9mLeDdbRUiSlS3AB3sGs5cMhLUf+moBk1Yuw6w==
X-Received: by 2002:a63:134c:: with SMTP id 12mr13085716pgt.124.1617971535653;
        Fri, 09 Apr 2021 05:32:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 04/18] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Date:   Fri,  9 Apr 2021 20:29:45 +0800
Message-Id: <20210409122959.82264-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a helper lruvec_memcg() to get the memcg from lruvec, we
do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
to simplify the code. We can have a single definition for this function
that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
CONFIG_MEMCG.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4f49865c9958..38b8d3fb24ff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -755,22 +755,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return mem_cgroup_lruvec(memcg, pgdat);
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
-{
-	pg_data_t *pgdat = page_pgdat(page);
-	const struct mem_cgroup *memcg;
-	struct mem_cgroup_per_node *mz;
-
-	if (mem_cgroup_disabled())
-		return lruvec == &pgdat->__lruvec;
-
-	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = page_memcg(page) ? : root_mem_cgroup;
-
-	return lruvec->pgdat == pgdat && mz->memcg == memcg;
-}
-
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
@@ -1229,14 +1213,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 	return &pgdat->__lruvec;
 }
 
-static inline bool lruvec_holds_page_lru_lock(struct page *page,
-					      struct lruvec *lruvec)
-{
-	pg_data_t *pgdat = page_pgdat(page);
-
-	return lruvec == &pgdat->__lruvec;
-}
-
 static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 {
 }
@@ -1518,6 +1494,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
 	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
 }
 
+static inline bool lruvec_holds_page_lru_lock(struct page *page,
+					      struct lruvec *lruvec)
+{
+	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
+	       lruvec_memcg(lruvec) == page_memcg(page);
+}
+
 /* Don't lock again iff page's lruvec locked */
 static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
 		struct lruvec *locked_lruvec)
-- 
2.11.0

