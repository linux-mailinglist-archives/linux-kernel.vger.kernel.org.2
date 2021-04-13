Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F235D866
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbhDMG7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E63C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id z16so11249576pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71NH+uMXEa3vImQxjJijYTe54is/RT9JbLc/98rym48=;
        b=z6HE6C/LCwCAC+kFg3CfimNwgpDd8pULqr7veW101Uhlcp9bcab1cyTfzU/AoiTpk0
         J5OVBs/JiRbYsbs1868vdPTkjsVEttS0o2fO8GejsOngfQSqngsxc7rZ78m1cqFO/S3c
         yz78kiY6ITDzK0ujBc3k6UdwRZTBzqTrW04yJNEv/07vbdwIpXCruLI2mvCU5jydD8nz
         GoVxaDFHvHrgPM/DLJFd+9iq2ersHPph0Y9rE9MBuaC4/Iu4MrA2rXMKU1wRE31xIS9w
         HazXZrwHBpBfbMXWf/kp8Yqs9WLTG7KpaYClxNGrtSu+2VjdT1LfnT3A11Hj0/yN3lDr
         j7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71NH+uMXEa3vImQxjJijYTe54is/RT9JbLc/98rym48=;
        b=e/Lfy9A0qHpYUApUSWbef5b5KD4qgDJbXMIqToJtWn1lgnXVG+MPE1L0d6TIdfE/JC
         mW16X5Fymvv2Wzg/hbOiNt2A8jzNnNKOEvTi/kKwdg8uT985yTMCCibtTP7sXG7xQq7w
         aFmzu5KTb5vkKwSot4atY9YTdN6aY9VUGias8yr6elGSq2OJH1h5z2EYnlmLRcS2IN/m
         w5rW9EyCG4nDowlIN21Fvy7V+yyiexrLf+sA1+RtoDdKzBXbA+bT/dG6Q/qm0lH3faCu
         TU1rraR4DmzmhPHyhShu6c0b1xZJmqGh587F9P/yMH59G8BkZCz6V9sbdeM5Rfcx6fiz
         awUQ==
X-Gm-Message-State: AOAM533OsH12Fmvs6zCPzbRNrzpXkXKduYBazuOvr0GI37aiyXQe3OYl
        41kvvGH1xDqSFq1k2cypwFoyOg==
X-Google-Smtp-Source: ABdhPJy9ZkUOPYnaAFXFhbgIJ0DFD88zmBjK/GeAzc9o1siOzWhvf0y7oYEyUj4rdqxVJtsrdnW1fQ==
X-Received: by 2002:a62:ab11:0:b029:242:4c58:d46b with SMTP id p17-20020a62ab110000b02902424c58d46bmr3940418pff.15.1618297073178;
        Mon, 12 Apr 2021 23:57:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Date:   Tue, 13 Apr 2021 14:51:50 +0800
Message-Id: <20210413065153.63431-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
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

