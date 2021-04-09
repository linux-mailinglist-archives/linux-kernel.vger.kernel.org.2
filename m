Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B14359EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhDIMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhDIMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE3C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:33:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b17so3787397pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoY+xVUIMEYkMAOym+tsxa0CiEBJagAGYOcFqP2KHJM=;
        b=DsZMvhHWm4mrMrUgLxwe8rmKzWWGxf5n4KDgWVqWnWqFoXsMw/R6RWat4E5ynjciPk
         NX5/37x4XChb5bZbcKFnhd74XnMGTkmeesqaXJ+BjFZb1cs8nHlEo3NLugIlnUtS6ZqN
         RdbYWTmfPloA5h6gYb7ly2Ifp6esesBHDsIvYDowG1iBHvQ4hVO49/SnUyuKyxqNvkO/
         7bmPHKo9m7QPwRqWseQOIAxd4MGTZlmLswvyk2BFfbviZMyEFVdeUl6FforiFvqPCaTw
         Fcp6aBUn08w1ytjHCZGWAmPz6KeBflhR4bSL3oJKjbuBmiurrVlzQ6wjdAxEaE/0722/
         OHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoY+xVUIMEYkMAOym+tsxa0CiEBJagAGYOcFqP2KHJM=;
        b=J+fwoU0WNihvfQus/YrqxxxwgUtKlDsNyFQVfCyAz/zku60VlDj5dBdKfV9YZipcU8
         mCsSCvimF6HZWR9f1SXSGE4P05tN+pqUcFr/KTwv49ffU6VltwTBbPD0Z9RnNzGgtuj2
         C3er7bH1Z5KuDvXncpFGY+UI2wPT2PYvZKosIP0u9503BGn0fHfKzFv15ichKl4p6m+5
         JIHyT3QuNWpM8S7+NJFN/Plaz7c49R1sSgv8oDkNXcmtOlYOVQqq0gaz1XoBJ1J1X4ns
         ztcdgBRxT4lA6NkWBWEfjVzGtNsl5RFj+0N5WMqdkLM8ik84vZAU6lYIHLNsO35yckMe
         JODA==
X-Gm-Message-State: AOAM530nSgVL6Luj6L35H44WfAkB7nL1jgSP8T/KphynkmqOJNL3Q/bt
        jG5PyO2NbEBPzN5TtISPfv1I24umWsAZ7INM
X-Google-Smtp-Source: ABdhPJw4jPv7cP2XDcv6q3vNe4wcTSoEXR3244myJw8jkKChOcifNjx+92CtSjt4a7uK5qWlSjnRNg==
X-Received: by 2002:a05:6a00:1e:b029:241:72c2:695e with SMTP id h30-20020a056a00001eb029024172c2695emr12073445pfk.17.1617971581010;
        Fri, 09 Apr 2021 05:33:01 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:33:00 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 12/18] mm: thp: make deferred split queue lock safe when the LRU pages reparented
Date:   Fri,  9 Apr 2021 20:29:53 +0800
Message-Id: <20210409122959.82264-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to lruvec lock, we use the same approach to make the lock safe
when the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 275dbfc8b2ae..aa5d7b72d5fc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -497,6 +497,8 @@ static struct deferred_split *lock_split_queue(struct page *page)
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -504,6 +506,17 @@ static struct deferred_split *lock_split_queue(struct page *page)
 		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
 	spin_lock(&queue->split_queue_lock);
 
+	if (unlikely(memcg != page_memcg(page))) {
+		spin_unlock(&queue->split_queue_lock);
+		goto retry;
+	}
+
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
+
 	return queue;
 }
 
@@ -513,6 +526,8 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -520,6 +535,14 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(memcg != page_memcg(page))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in lock_split_queue(). */
+	rcu_read_unlock();
+
 	return queue;
 }
 #else
-- 
2.11.0

