Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E222F40DBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhIPNyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhIPNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0BC0613E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j6so5981615pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqRNOri396qVGI8Drv9BL2167qBW7PZton2b/SSrCrU=;
        b=2kJaAcBoYzi6fqMoyRdw1+AjsWMsTyGBQy7Hm71Due/Dq+2fhnE+Tsm9dpkwmuKRBh
         JMxcMEQmjWJfV81NQNe0RR++yf/2ED9Ng8Oqo1vcyLxobv0UXI+/ERUtF3d1VaJH772L
         AskxBx0CSNYzk5s6qYuFljJL9swhxrugGy/xPy4u0UgTxcbq9nXOedVcgWkFdnT84TGu
         RFK68oGYvbh0QAM/b/DrhgDqBIwwfI5nOtihvToD8ikCGQmmksCkIFkXrdNRQjQeSROT
         HCWR/m2E/xZQ8J91hVD+v9R8MXiusoDjrI1zfCPzqb/XCzmzYBgHWzAjwJgrocJKwrtD
         muJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqRNOri396qVGI8Drv9BL2167qBW7PZton2b/SSrCrU=;
        b=SHY3hvVb8xB6HjV5lV4lGDCxN5iW3HgcyblRmlH1k0Hd3mxK5Zrwx4xzoNr/ZvjBa3
         a640CZdH9jAYP0kChSlwFJv0HtexzA5fibMZXQm/5u/mzWYGbE1B9Mb50t5Xhyftiyp/
         10COeX7gOnJXCEaRNZkjdSeyTRsGXQCzAUxU3xR1cdiPPC0Uh251iXsle3wpkhthkEv4
         AAgnuA8r/Mc3f/N81Gpx1oHAggnob4XuHBJ3yP5doV9zwawqwfrp1e5H1VnBCpHf6GuZ
         tX1GfT06xeAwe5FSvUeI0vFauVfSbBG0jPNpbUMu9ZVfkh9az+KuQ2Ysy9xWjDJglaGA
         tPiA==
X-Gm-Message-State: AOAM531SYYgjmIRofnWsSorKmWWF6ykcwapIC69AJVPQfNnDRKHh8KGJ
        f5dRkLoFQdxhSbkU99wN16ZVnQ==
X-Google-Smtp-Source: ABdhPJzAK19Z2U3CeVnflfe4LQQJJPRoJrF0z9YnW5hMuY00wkZvM9UnIjFhxbQu5cpipON9b6hLTw==
X-Received: by 2002:a62:dd94:0:b0:442:bb03:9663 with SMTP id w142-20020a62dd94000000b00442bb039663mr2523613pff.0.1631800370277;
        Thu, 16 Sep 2021 06:52:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:49 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 07/13] mm: thp: make split queue lock safe when LRU pages reparented
Date:   Thu, 16 Sep 2021 21:47:42 +0800
Message-Id: <20210916134748.67712-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to lruvec lock, we use the same approach to make the split
queue lock safe when LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9d8dfa82991a..12950d4988e6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -535,9 +535,22 @@ static struct deferred_split *split_queue_lock(struct page *head)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = page_split_queue(head);
 	spin_lock(&queue->split_queue_lock);
 
+	if (unlikely(split_queue_memcg(queue) != page_memcg(head))) {
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
 
@@ -546,9 +559,19 @@ split_queue_lock_irqsave(struct page *head, unsigned long *flags)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = page_split_queue(head);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(split_queue_memcg(queue) != page_memcg(head))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in split_queue_lock(). */
+	rcu_read_unlock();
+
 	return queue;
 }
 
-- 
2.11.0

