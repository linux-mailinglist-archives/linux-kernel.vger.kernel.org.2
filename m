Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26E6392ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhE0JgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhE0Jf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78781C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so3262894pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ft9WuvuTd8KuLYt2oYjvxJzc9erUDxmQq6d8Bz9BNBc=;
        b=MwXJs4szfOJmIMfrhnQvxPXKp0uPI07bWeUgOrKrSlFr+QzfhUUNksExbiD6v9pe+W
         +nbUm+i0jzvyStH4xhIZAnZS4ds37Mn/7FWXlpOZrazV9DnCc93SrT5LPK6cYyb3uRzw
         0XkqgMVdriDQpON/GUVZqX07B589O6vIpccCwFD8T6WumzCQbKmcyWZUZh6LWv4ekWnj
         lGZiVUH4OXVfg1mV6hkQmrAZDu3yDdGAVoIdJQNrs09JpNfryPP0O8WxPJgjuXMFYV+6
         rOHXzTThv9wZSBLZI2Ngnx7PGH1LStkqtp7nPEa98X1Z+PmSk6D/VxPy/J1FZrYSM149
         2uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ft9WuvuTd8KuLYt2oYjvxJzc9erUDxmQq6d8Bz9BNBc=;
        b=RlJGTcJMORyztH6zSf71qvQFgZYIBXrbDzcy6hrpGYWkp6C51e2kCdFfT9te/bU9E5
         pRvOEbGkz2LSgXZ//wjGwdxZg4n/NMKPjTqcTTxEbhtIrGUT0eraUcZnhwmavW5abhyj
         k9JzSvFm3PE8/5cDsiN/FWEZUe/OLED/LJNzvZWjU9HGWvSic3nljVGddVAM4yHrj6+B
         Re/QvOFco692SWVm7Hy7Q9zlwCZpNyLuE/7C/E6otyzaFZ9mwUiZWT81OrDtL1s6p7Sf
         QZA6egYhWwIibl3Nt6mpFzkB4D6Q8xbwPdzjL3pZvg4Ek5GaWLv1cr+sJxrikQ/7Xbpo
         A6sQ==
X-Gm-Message-State: AOAM531VE292yD5NIP3TMKVmtw5MM0ojBCB1krE90WUKe28Xp7T3+B1g
        giMl7hSRqbwA1+opTeyHpluzMA==
X-Google-Smtp-Source: ABdhPJyZzc7fWOpi0uj1AiDi2IHJ56gAWVN7hTmdPU75r/pk87l8G6wXVLzDGFYCBSD/C7vld9jtKA==
X-Received: by 2002:a63:a552:: with SMTP id r18mr2798493pgu.439.1622108066077;
        Thu, 27 May 2021 02:34:26 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 06/12] mm: thp: make deferred split queue lock safe when the LRU pages reparented
Date:   Thu, 27 May 2021 17:33:30 +0800
Message-Id: <20210527093336.14895-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
index d8590408abbb..8f0761563d46 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -506,6 +506,8 @@ static struct deferred_split *lock_split_queue(struct page *page)
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -513,6 +515,17 @@ static struct deferred_split *lock_split_queue(struct page *page)
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
 
@@ -522,6 +535,8 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -529,6 +544,14 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
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

