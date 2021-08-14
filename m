Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3D3EC0AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhHNF0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbhHNF0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B60C061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so8463924pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGMUDL+X4tm/vJIxNFScO4bfVyq5TxNYHUST0OzJycs=;
        b=Awt006hzmvp3826E028AW54ZQdcH/iHJCFQh7D9WUYxFSVFbozsLRpX7pQ6JEIbg9W
         s4SyjyqL9SpQNj5AOBfRol+2Kcok6r9Fmk4sH07/7Rxg6R8djmoy6Rc0pKWV+wPdbKBq
         QkaIJ9bx9o5fdhBlierm42heq3f4pVeSrmi2XaepkVDKf6KsaxR/iom6ChVarEzFNycO
         TgxgCEjhQw+v9g3ClTw9De3JOtcS0gkL1Oxwz2orY/wTPDBR3qCjPMc8ZJRo9PYZ+rYA
         dNi8x/tbixxIlvFIaMh6OyuxbSDVbh/X3m8LKHGD15HXOdaD9NlcclnMEcybsIXFNapR
         CAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGMUDL+X4tm/vJIxNFScO4bfVyq5TxNYHUST0OzJycs=;
        b=ABPDSrd2aA9Fqf2UyYV0MnI2hzdd77wF8y+hoLvsUYfIUz+lprtfB3peyzuUnKK9V3
         ENqf3hU8j0wTLaNDF29uo43KFDZNJ/WYwJrrw9Mj65rydSM1D62w6+aynlo43HqB5xjE
         JlhslcL09AUV+lFqZ84eOuaieYjEKMfXHEWmugwLWQnuqmT0t+j9e4cya0ZBPrP7FQYQ
         hAMj1wyJzBSi8lzkC+JNJAEnqEMhUaQiuybCQMicGwBWEHsa81ySnP/DSRl/r54tNKlk
         sGztvSO0Hu1Syq7L1haEZmlJ8ypkhD9omslFiWBjDQDwD4+nrdYVYy9BhtIwkuCqs8hO
         ldGw==
X-Gm-Message-State: AOAM530QQduOMse+WfIWl65NtN0BvYbIB9aZYhj8jsTZA+UkU5W5MkXW
        Zor+eUdFCnX/Bkh+B/LYelRUfg==
X-Google-Smtp-Source: ABdhPJxAx+pnIIz1Pwn50bFJeyyCUDyRI7YRH37fF9YnbX2dv1IvGhcPf/LkKmZqfJrEz5hhj6s9pg==
X-Received: by 2002:a63:5153:: with SMTP id r19mr5516505pgl.56.1628918767822;
        Fri, 13 Aug 2021 22:26:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 06/12] mm: thp: make split queue lock safe when LRU pages are reparented
Date:   Sat, 14 Aug 2021 13:25:13 +0800
Message-Id: <20210814052519.86679-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the lruvec lock, we use the same approach to make the split
queue lock safe when LRU pages are reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c49ef28e48c1..22fbf2c74d49 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -535,9 +535,22 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock(&queue->split_queue_lock);
 
+	if (unlikely(split_queue_memcg(queue) != folio_memcg(folio))) {
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
 
@@ -546,9 +559,19 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(split_queue_memcg(queue) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in folio_split_queue_lock(). */
+	rcu_read_unlock();
+
 	return queue;
 }
 
-- 
2.11.0

