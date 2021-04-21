Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD653665FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhDUHCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhDUHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5433C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o16so7493815plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5fl1hFUuv3DCtKbM5f1nutVnvGFt8a4G+iL+Kk5mXk=;
        b=cp0+p5CgXQjn3nK6FkTIdj6ffZFLcfA64UNFiG4+B9XxSa/L46Z8Ty47tZ5El5/VVX
         h4Q4furWaCjgJYFpAxrVKO1xvk/7ViBeOTY9IRV8MSSjGCKsaAsQFOjDH5IQD5jYc/BN
         JTUdIWgYPi71758YMJPrPD/Ugc6R5XXLxmnhkdzS/GFQ9Pr4cTFEzptduklI7LnHplis
         6a4DwShMYQG/eEjE/uXqIrRM+KZIEQYZusvh6uwjLQNNu8KyubIIuR48Ead76z9Y8yFO
         nlGB0gaDQ99jOUajP3RwBXRRLZSqrePWGL6vU8IlN1ORjh9d0qXsJrB5pUNkurvCi9OP
         ZB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5fl1hFUuv3DCtKbM5f1nutVnvGFt8a4G+iL+Kk5mXk=;
        b=KwcX61tDzLeTHmJzYnuSiV1+WAhfRRO9iopVDEix7oaJSwPSfBysw8aJG04d6HLD6/
         9ctohkVcZXNOl+K59kIJvqhZCAASxSn/6m/sXdNW8Y99eAeazIWkRA53k5AiMJxneanM
         Mr1oRCjba9KCjU/dyoClFPWSS6UEY/ATVk5UwcjqpCLkIByY/U0bzwuHW8N8i87zrZPb
         qVzbPAOs5A+SN/c8i28SierQdwBPCX2MH6U+zeHsAhqfJdwMV2BvTz0g4veYXIQH3ZfD
         2MwKxYyW0+CfLkvB6nDzk8jE2LopKfUv+czfnZPAKFct85vqZx1QQhJ44hUCehZW/36p
         TR4w==
X-Gm-Message-State: AOAM533K3VjwRQDiZWfx+2t0Du2kvFL0D8H4caHJhM3s2at8aqd/Q8ig
        HB9xrYOAmDby9U8rwJ/LzQxC6A==
X-Google-Smtp-Source: ABdhPJwjpIMC9vb5Pt4w8iw3nZk9uRy6IoD/4vdQEcqphO5TogxAIorC7KgeVY48PxyjM8VMRe3ZTg==
X-Received: by 2002:a17:902:9a0a:b029:e6:bf00:8a36 with SMTP id v10-20020a1709029a0ab02900e6bf008a36mr32868861plp.51.1618988512434;
        Wed, 21 Apr 2021 00:01:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 06/12] mm: thp: make deferred split queue lock safe when the LRU pages reparented
Date:   Wed, 21 Apr 2021 15:00:53 +0800
Message-Id: <20210421070059.69361-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index 05ef9e8f9af5..25025bf988f8 100644
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

