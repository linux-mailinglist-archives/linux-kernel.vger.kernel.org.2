Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBC3F4BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhHWN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237256AbhHWN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9B9061373;
        Mon, 23 Aug 2021 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629725125;
        bh=43OttOoA+izE3bbLjhYbj+Uvn2nbLJSqbfY6UbauX60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwBAEvyYU68YR66QYkCvLp/UcpgFL3duRG70qZ2A4lA8BrU0x6jHAZYeGgp1amwqu
         afOnmIVmw98H4hHFdzx0IreEinrtA8UTYsAlnSQViHjCXz2yviZvTKEKJpFxuD8HkT
         DRO0N4Q6aJkHGldSsy95NrvKdouarsTMvULBQRvqt7tkskWClXqogS0ETI8k0v7fzB
         sEYDY1eBvfyo/fYeHuOmZU0DxvDFUmBojV6bgIMo5mrifSvG0eXqaOJ1uA1CPIOdSA
         q7JwncGNNyTNTOoV0OBGpIoVYmKUuP8wzh8hOe+DdeZ4fXgacQecZRDykl+utC4mov
         pERKRUDFUM6wg==
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
Subject: [RFC PATCH 1/4] list: Support getting most recent element in list_lru
Date:   Mon, 23 Aug 2021 16:25:10 +0300
Message-Id: <20210823132513.15836-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210823132513.15836-1-rppt@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

In future patches, some functionality will use list_lru that also needs
to keep track of the most recently used element on a node. Since this
information is already contained within list_lru, add a function to get
it so that an additional list is not needed in the caller.

Do not support memcg aware list_lru's since it is not needed by the
intended caller.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/list_lru.h | 13 +++++++++++++
 mm/list_lru.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 1b5fceb565df..08e07c19fd13 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -103,6 +103,19 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
+/**
+ * list_lru_get_mru: gets and removes the tail from one of the node lists
+ * @list_lru: the lru pointer
+ * @nid: the node id
+ *
+ * This function removes the most recently added item from one of the node
+ * id specified. This function should not be used if the list_lru is memcg
+ * aware.
+ *
+ * Return value: The element removed
+ */
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid);
+
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
  * @lru: the lru pointer.
diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..c1bec58168e1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -156,6 +156,34 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_del);
 
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid)
+{
+	struct list_lru_node *nlru = &lru->node[nid];
+	struct list_lru_one *l = &nlru->lru;
+	struct list_head *ret;
+
+	/* This function does not attempt to search through the memcg lists */
+	if (list_lru_memcg_aware(lru)) {
+		WARN_ONCE(1, "list_lru: %s not supported on memcg aware list_lrus", __func__);
+		return NULL;
+	}
+
+	spin_lock(&nlru->lock);
+	if (list_empty(&l->list)) {
+		ret = NULL;
+	} else {
+		/* Get tail */
+		ret = l->list.prev;
+		list_del_init(ret);
+
+		l->nr_items--;
+		nlru->nr_items--;
+	}
+	spin_unlock(&nlru->lock);
+
+	return ret;
+}
+
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
 	list_del_init(item);
-- 
2.28.0

