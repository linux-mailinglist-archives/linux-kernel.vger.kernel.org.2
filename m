Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A953F4BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhHWN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhHWN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:26:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91480613B3;
        Mon, 23 Aug 2021 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629725128;
        bh=UwkfhY8SJENE/3Lw6o/UNr99bPnMhT2qywo7ZC7jJ0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQFYCpzYlt6wfhC07qVjVyQ26BGSfkzav/X2l3c4xoJUQKTk+i9m4hGIOnLQo/EiA
         bp2iQFFiJYYwQDBU4R8w5ffo/DANj5ZNHYrDa0kvJYoF8GXLSBcd2aY4oFe7oZpBzr
         oCzpZju4iPm6OakMMeTi9OGmNANojNoKq3/E5dahg6GJbZYpNZO2986JM9oLQiW1Mn
         WSq8x09c/u08Hpne4ir8wELaj3TROdnH9WI3sxcifTS73TfZLi+W55cHEN28a4PLDk
         1M++HnIxZnSO7tmqsxgKgVxpWCZ3rLnWHV2I0XhA94B8oI39cN/sMjRFIh6SGySAom
         WEQOAusF3NVHw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] list: Support list head not in object for list_lru
Date:   Mon, 23 Aug 2021 16:25:11 +0300
Message-Id: <20210823132513.15836-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210823132513.15836-1-rppt@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

In future patches, there will be a need to keep track of objects with
list_lru where the list_head is not in the object (will be in struct
page). Since list_lru automatically determines the node id from the
list_head, this will fail when using struct page.

So create a new function in list_lru, list_lru_add_node(), that allows
the node id of the item to be passed in. Otherwise it behaves exactly
like list_lru_add().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/list_lru.h | 13 +++++++++++++
 mm/list_lru.c            | 10 ++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 08e07c19fd13..42c22322058b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -90,6 +90,19 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
 
+/**
+ * list_lru_add_node: add an element to the lru list's tail
+ * @list_lru: the lru pointer
+ * @item: the item to be added.
+ * @nid: the node id of the item
+ *
+ * Like list_lru_add, but takes the node id as parameter instead of
+ * calculating it from the list_head passed in.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool list_lru_add_node(struct list_lru *lru, struct list_head *item, int nid);
+
 /**
  * list_lru_del: delete an element to the lru list
  * @list_lru: the lru pointer
diff --git a/mm/list_lru.c b/mm/list_lru.c
index c1bec58168e1..f35f11ada8a1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -112,9 +112,8 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-bool list_lru_add(struct list_lru *lru, struct list_head *item)
+bool list_lru_add_node(struct list_lru *lru, struct list_head *item, int nid)
 {
-	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
@@ -134,6 +133,13 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
+
+bool list_lru_add(struct list_lru *lru, struct list_head *item)
+{
+	int nid = page_to_nid(virt_to_page(item));
+
+	return list_lru_add_node(lru, item, nid);
+}
 EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_del(struct list_lru *lru, struct list_head *item)
-- 
2.28.0

