Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B727E34E55B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhC3KW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC3KWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t20so5916481plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35PJPimaboX0f0GU6NT304tFzSCBj6gk52k3CNbuEN0=;
        b=k0pCcjq+CZH6CkeB7OZseO3R0aoXsvjx6Oxds9wSe0FcNtTLNcBYwf/eApXmFxW3DE
         mq4oUwM8ddJlOXfU2bjf+jON7bXFz0ciEk/omi+H0Ge+W1gyu8H7gtDPNeWxqVk4kkax
         8O9fmWu+ics5JjV26PspctzHvzQZvS67iRBvMSGw7sglb7RpAryMK5ZKC2OS148Ex75J
         HjHhEjEKzNLCT48TIWPJBwVXsktvFsRXXJ1l0T9dia74Xt0Whr06FVLmTNvC1tmZd3y/
         LyowX64eomXd4tilg5Y+Lcv7QV/EJuKgOc6XLz3G7x6byAy+ULDiudYEZYWfJrNfGetW
         m1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35PJPimaboX0f0GU6NT304tFzSCBj6gk52k3CNbuEN0=;
        b=YJeOIGWI6s9S1FRwNDD+jwTdtYJH5gcoqZDc6ZHnsM2mCynYDNXJ54frw+5WnnRcKh
         7H6j0xXDMIEmPOuM5SVQVQahBPs4ACtUpL9hdo4d7P84jNzLDXpdx89V80pb9vxlXmZR
         3TTCbyutNhEY9EggpTFFf5BlAp8/7rc11FNhTMYxVd1tME9l+dUEzuEo2EJDvfQhoUJO
         QMy4Ux7x7Ejmvqjx72z0Ow57pQNeNBiadij2Eh69nqrQKsOLd0/zOIyDOhyQNia5aY1j
         JsS1+0XN3bKKn7hRgc/DRFHvWz9hdUUi/gWqjcw6UtAAdI+Z+gPElMv00C1VuWAK7t8W
         X9OQ==
X-Gm-Message-State: AOAM5323nx3Fwbceo5j7i1eosL5MkXkCm8nnhFUeOAhUK9hm1VRXlW48
        ffiN9B6GQ4NA+T+tt7PcJz1L/Q==
X-Google-Smtp-Source: ABdhPJyrZ53j9C5rLFjTDQpQ/1eARR63PEdeQ3l5NphxlX8LYCZtDeAcNu6lfko9ahvLOeA5KbhfSA==
X-Received: by 2002:a17:90a:f286:: with SMTP id fs6mr3663311pjb.183.1617099753361;
        Tue, 30 Mar 2021 03:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.22.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 10/15] mm: thp: make deferred split queue lock safe when the LRU pages reparented
Date:   Tue, 30 Mar 2021 18:15:26 +0800
Message-Id: <20210330101531.82752-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to lruvec lock, we use the same approach to make the lock safe
when the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 186dc11e8992..434cc7283a64 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -496,6 +496,8 @@ static struct deferred_split *lock_split_queue(struct page *page)
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -503,6 +505,17 @@ static struct deferred_split *lock_split_queue(struct page *page)
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
 
@@ -512,6 +525,8 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 	struct deferred_split *queue;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+retry:
 	memcg = page_memcg(compound_head(page));
 	if (memcg)
 		queue = &memcg->deferred_split_queue;
@@ -519,6 +534,17 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 		queue = &NODE_DATA(page_to_nid(page))->deferred_split_queue;
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(memcg != page_memcg(page))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
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
 #else
-- 
2.11.0

