Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68359361922
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhDPFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhDPFQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE468C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p67so12636862pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EITONQXFUiMqxrQ5NUsYlzJaHXQ6TTbcz+uz38aCyj8=;
        b=SuUeEWi3hkyym9C+nZPi7l4X3qRxD6TQytpUw/1EHGepojFemgYBIwmEu4XWEYjzRU
         an93ortrd6A7N9bn9ygLjYAeG6tEhXijd+Gp2dFmewjtt8Y1BXdbX0UYctCOSDbYaGJe
         b9hQRoOKYWATBes4K+Q4crKShSdfA1/k3ry8JPuwHhRcJ2oFjLBYQDL3wGIYmxrBe8Jg
         V9+K60ehr1o+PctGj1dJdVcEYAsvz0WkuOBMUBhiriTc1dXJcLyKJdTLeV1uBVAUYxh+
         J2vGVMqehdk5QvqMcgGo39GgUTujIeA5A48sPaQtouMdkT2OTMa0pXP76k7LVxBXs+23
         +VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EITONQXFUiMqxrQ5NUsYlzJaHXQ6TTbcz+uz38aCyj8=;
        b=hr34EsPQPb+OmcDRnQVa5vCbDxst8Rfsjrwpc4K7bxNBSvyBA3ljfwR4xCt6/M8ehQ
         0NaGKfzWFEmCnBmJMf2zJB9vgnvV2EOsOuEfnpIAXeJhQEm6gKQ1632l+kT2ZodAFDCC
         XZrpHYl/mf6gipNIJ0ljiITfdxiwycbQpKZkdDhA65cqrLeJYfq9VssXrLN2QyZi7r81
         OtAVYYUM4S/bnolymuJQ6g5evuUzrTHaB/Dg926FVSkqexek17w8rtT9NNtMRS6vKy/H
         2/LZWi4qmreeuONMbGGSOTH+KzUNYfbQlR9cjA8hlpa1fr07mkoN1Tdp1DsRM4QAI6Lw
         Ysgg==
X-Gm-Message-State: AOAM533eh92f8gzKKR8BLPlAFSc95/F8Y58st6IOyqFQEM5JTBOnkWNf
        SWVcE++SZ+prNc1iQW00VIsNgg==
X-Google-Smtp-Source: ABdhPJxQ15461bx5MeGSdaLrFIJ1l7r1oqawxEatcnKC8zUEEH8blyrZiTvRaboYm6nB5iYTJ3lp/g==
X-Received: by 2002:aa7:8593:0:b029:259:c31b:945b with SMTP id w19-20020aa785930000b0290259c31b945bmr2025912pfn.27.1618550159354;
        Thu, 15 Apr 2021 22:15:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:15:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 4/8] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Date:   Fri, 16 Apr 2021 13:14:03 +0800
Message-Id: <20210416051407.54878-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f2a5aaba3577..2fc728492c9b 100644
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
@@ -1227,14 +1211,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
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
@@ -1516,6 +1492,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
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

