Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EB361921
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhDPFQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhDPFQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D87C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i190so17574775pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUAxTMYGPKcXUKklEvyCvysOG+ZnpjCi0FGjCzotqSU=;
        b=sKTfHmqSsWDRGf9SVi9pCO6Hmse+SZHM+tv3/GJl2rgPhf5LhsNUzYPF8GIbtfPjmi
         RLQSfJGWAZtFFG5WKBMO/UEP4u+7lJ86fcGy3qMcMBQRs16QYPNN4osVE2B7q3wPm3IM
         6k/5JyFHsfTjzDmOAZ2WZ21L69Y6as0JcteWUeVjQxAJsR7i3UC4Bj6clihPikjYzYdB
         MkpMLzKj7ZirphY+yFO6Wt5BcH6ICOyYy2mJsVMItKl0chzciFMZA+B16wt9PEMImgIe
         0mu9QbgV/a2EWzTQvbMRBfNglm3uT3KAt50tf3sstmbeqzHvrmzQeC+1dNyS4ySuO74L
         kJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUAxTMYGPKcXUKklEvyCvysOG+ZnpjCi0FGjCzotqSU=;
        b=euFrNMLaLIlMQ7EgkYPxuATEVD/zl43+rrcOmPIGyWJJNHtJOonwJNlqd7PAvM+krK
         W1TW+FNDR5+VTWkENnFqdHEEHAHV9Xqv55HCErAGM8LTJzw4ptUT6IqKwk6y9YzoD70R
         ALpnkH5Jf8sG0JaQxDqrjsHVQrKBuhnsnu0uzjjPpm5s1NquUNF6jYuReLvskBfnD4XR
         rHRHwE/F9kQq1pzv28TUiPzhR+x0mP1skSZWLk38EbsnQM5Jy17VtRtfJqOnwWXd4uGD
         5uSbKFMfluYworHph6fGiZi0ct4cwrb5pdIoxkGRpbgL5XyhZHBqEwF97dFIACVmKFIc
         N8AA==
X-Gm-Message-State: AOAM531R5fIj/X9mNBfgRLKKROWocHHGdS6UjwB/WHYEpXIXfViqqQl2
        LwUNm18QkIky6cLi7Pc6+LSLUQ==
X-Google-Smtp-Source: ABdhPJylZLX97P+G2iOwpp72wGJA5EJe8joOYASW+03d0LyiRtMtN0GtaCcX9czglyk4+IJR8Rxong==
X-Received: by 2002:a62:6883:0:b029:220:4426:449c with SMTP id d125-20020a6268830000b02902204426449cmr6160037pfc.14.1618550153443;
        Thu, 15 Apr 2021 22:15:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.15.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:15:53 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 3/8] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
Date:   Fri, 16 Apr 2021 13:14:02 +0800
Message-Id: <20210416051407.54878-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
as the 2nd parameter to it (except isolate_migratepages_block()). But
for isolate_migratepages_block(), the page_pgdat(page) is also equal
to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
need the pgdat parameter. Just remove it to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/compaction.c            |  2 +-
 mm/memcontrol.c            |  9 +++------
 mm/swap.c                  |  2 +-
 mm/workingset.c            |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..f2a5aaba3577 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -743,13 +743,12 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 /**
  * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
  * @page: the page
- * @pgdat: pgdat of the page
  *
  * This function relies on page->mem_cgroup being stable.
  */
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
-						struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
+	pg_data_t *pgdat = page_pgdat(page);
 	struct mem_cgroup *memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
@@ -1221,9 +1220,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	return &pgdat->__lruvec;
 }
 
-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
-						    struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
+	pg_data_t *pgdat = page_pgdat(page);
+
 	return &pgdat->__lruvec;
 }
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 8c5028bfbd56..1c500e697c88 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -994,7 +994,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lruvec = mem_cgroup_page_lruvec(page);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 50e3cf1e263e..caf193088beb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1181,9 +1181,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 struct lruvec *lock_page_lruvec(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1194,9 +1193,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
 	lruvec_memcg_debug(lruvec, page);
@@ -1207,9 +1205,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
 	struct lruvec *lruvec;
-	struct pglist_data *pgdat = page_pgdat(page);
 
-	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
 	lruvec_memcg_debug(lruvec, page);
diff --git a/mm/swap.c b/mm/swap.c
index a75a8265302b..e0d5699213cc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -313,7 +313,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
-	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
+	lru_note_cost(mem_cgroup_page_lruvec(page),
 		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index b7cdeca5a76d..4f7a306ce75a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -408,7 +408,7 @@ void workingset_activation(struct page *page)
 	memcg = page_memcg_rcu(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	lruvec = mem_cgroup_page_lruvec(page);
 	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 out:
 	rcu_read_unlock();
-- 
2.11.0

