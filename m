Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1638C649
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhEUMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhEUMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:12:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q5so20845494wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lbm/0t9Bcu3Cc8VRMspsd0pyAsMK2XlLm2WMFLI7zWA=;
        b=hlnntsX9ad1YyLSBCI1T17JeaeDbO2WE6dtl4tSyo6dhGchUBQVGcm84pk/uQf/p09
         iNoaJrNgyn8sCOF1NaKspMgkoY8BVZmwR4BJHPB5/IKvQVor2trKnN21fnkJntsOuOX5
         euy/S0w8NylWqWHMXOa9am4zAdXPcHE/ockzPhkztubNKwtqv/7UN9v5TNzP1Ey2xwsM
         +uoNzKdBlZkG/Xc3HdcAjCIRKVrjDAQ1SnaYg3aHg5pu7WkObeeBPlEXE+aabFvXaaWG
         tXtrTKBRff8rdfP25lzAL21sJ4ApzTE/aj4r3Yhcqf4SejJqxvSYOm+EcpiZ/jOleA/b
         VZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lbm/0t9Bcu3Cc8VRMspsd0pyAsMK2XlLm2WMFLI7zWA=;
        b=uNcAjHCfmvDgy1bOUpyuc4vYNJB5uD5fAm0dm/YF3BuTjh8nx9ITlAVWeUl8shsY5+
         inFGJaNHTQQXHUJU0nI8MT1hAnvA7rvBRl/ieqsQ79060IXREMmPuU/24KPcy+veY6E5
         sq0O0IxvipNIt7lgo1nakBqkbZGhPSwWh9hIKGGi3HVwTq/dbK7SNt9+neRX3LetHpZp
         s12pdWib6nu4nzjRp++WnF6dO6sYyu7Ob4gEmjSy5NCl0g61yJyYfAgwBkvRgxGjQnK7
         puoZJfMfs+046bt48Uq7CQf9NQ6JNunYx5WsxO6PHbPqwLgapyimc/aBfNQzT9OGX+43
         OZYA==
X-Gm-Message-State: AOAM5329WD1LIh7HYnybwN5xI+QFEKj2jFC0C8cKnu0x2XXHT2vwdYAH
        nHZ9xN4UkAUmJ4TNgp4XGu0=
X-Google-Smtp-Source: ABdhPJx3mGLz96WGyH/ZEKPgbc9Yi3dVaGFE671uNkJOblMcn4pHukqz79gEYYJOBMYbDsWGyjwj/w==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr9111832wrm.369.1621599091815;
        Fri, 21 May 2021 05:11:31 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:e010:8b67:85b8:dc89])
        by smtp.gmail.com with ESMTPSA id c64sm3339401wma.15.2021.05.21.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:11:31 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org, Oliver Glitta <glittao@gmail.com>
Subject: [RFC 3/3] mm/slub: add all_objects implementation in debugfs
Date:   Fri, 21 May 2021 14:11:27 +0200
Message-Id: <20210521121127.24653-3-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210521121127.24653-1-glittao@gmail.com>
References: <20210521121127.24653-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Add all_objects implementation to debugfs to print information
about all objects in slub cache.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 mm/slub.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 247983d647cd..885d0b074e31 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4789,6 +4789,17 @@ struct loc_track {
 	struct location *loc;
 };
 
+enum slub_list_field { PARTIAL_LIST, FULL_LIST };
+
+struct slab_debug_private {
+	struct inode *inode;
+	struct kmem_cache_node *node;
+	unsigned long nid;
+	long slabs_remaining;
+	enum slub_list_field field;
+	unsigned long *map;
+};
+
 static struct dentry *slab_debugfs_root;
 struct loc_track t = { 0, 0, NULL };
 
@@ -5809,6 +5820,216 @@ static int debugfs_slab_alias(struct kmem_cache *s, const char *name)
 	return 0;
 }
 
+static struct kmem_cache_node *find_node(struct kmem_cache *s, unsigned long *nid)
+{
+	struct kmem_cache_node *node = NULL;
+
+	while (*nid < nr_node_ids) {
+		node = s->node[*nid];
+		++*nid;
+		if (!node || !atomic_long_read(&node->nr_slabs))
+			node = NULL;
+		else
+			break;
+	}
+	return node;
+}
+
+static bool next_page_new_node(struct slab_debug_private *priv)
+{
+	struct kmem_cache_node *node;
+	struct kmem_cache *s = priv->inode->i_private;
+
+	node = find_node(s, &priv->nid);
+
+	if (!node)
+		return false;
+
+	priv->node = node;
+
+	if (node->nr_partial > 0) {
+		priv->field = PARTIAL_LIST;
+		priv->slabs_remaining = node->nr_partial;
+	} else if (atomic_long_read(&node->nr_slabs) > 0) {
+		priv->field = FULL_LIST;
+		priv->slabs_remaining = atomic_long_read(&node->nr_slabs);
+	}
+
+	return priv->slabs_remaining;
+}
+
+static struct page *next_page(struct slab_debug_private *priv)
+{
+	struct page *page = NULL;
+	struct kmem_cache *s = priv->inode->i_private;
+	struct kmem_cache_node *node;
+	unsigned long flags;
+
+redo:
+	node = priv->node;
+	if (priv->slabs_remaining > 0) {
+		struct list_head *head;
+		void *p, *addr;
+
+		--priv->slabs_remaining;
+
+		if (priv->field == PARTIAL_LIST)
+			head = &node->partial;
+		else
+			head = &node->full;
+
+		spin_lock_irqsave(&node->list_lock, flags);
+		page = list_first_entry(head, struct page, slab_list);
+		if (page) {
+			get_page(page);
+			slab_lock(page);
+			addr = page_address(page);
+			bitmap_zero(priv->map, page->objects);
+
+			for (p = page->freelist; p; p = get_freepointer(s, p))
+				set_bit(__obj_to_index(s, addr, p), priv->map);
+			slab_unlock(page);
+		}
+		list_rotate_left(head);
+		spin_unlock_irqrestore(&node->list_lock, flags);
+
+	} else if ((priv->field == PARTIAL_LIST)
+			&& (atomic_long_read(&node->nr_slabs) != node->nr_partial)) {
+
+		priv->field = FULL_LIST;
+		priv->slabs_remaining = atomic_long_read(&node->nr_slabs) - node->nr_partial;
+
+		goto redo;
+	} else {
+		if (next_page_new_node(priv))
+			goto redo;
+	}
+
+	return page;
+}
+
+static int debugfs_all_objects_show(struct seq_file *seq, void *v)
+{
+	struct slab_debug_private *priv = seq->private;
+	struct kmem_cache *s = priv->inode->i_private;
+	struct page *page = v;
+	void *addr = page_address(page);
+	void *p;
+	unsigned long *map = priv->map;
+	struct track *track;
+	depot_stack_handle_t handle;
+	unsigned long *entries;
+	unsigned int nr_entries, j;
+
+	for_each_object(p, s, addr, page->objects) {
+		seq_printf(seq, "Object: %pK ", p);
+		if (!test_bit(__obj_to_index(s, addr, p), map))
+			seq_puts(seq, "allocated\n");
+		else
+			seq_puts(seq, "free\n");
+
+		track = get_track(s, p, TRACK_ALLOC);
+		seq_printf(seq, "Last allocated: %pS age=%ld pid=%d cpu=%u\n",
+			(void *)track->addr, jiffies - track->when, track->pid, track->cpu);
+
+#ifdef CONFIG_STACKDEPOT
+			handle = READ_ONCE(track->handle);
+			if (handle) {
+				nr_entries = stack_depot_fetch(handle, &entries);
+				for (j = 0; j < nr_entries; j++)
+					seq_printf(seq, "\t%pS\n", (void *)entries[j]);
+			}
+#endif
+
+			track = get_track(s, p, TRACK_FREE);
+			seq_printf(seq, "Last free: %pS age=%ld pid=%d cpu=%u\n",
+				(void *)track->addr, jiffies - track->when, track->pid, track->cpu);
+
+#ifdef CONFIG_STACKDEPOT
+			handle = READ_ONCE(track->handle);
+			if (handle) {
+				nr_entries = stack_depot_fetch(handle, &entries);
+				for (j = 0; j < nr_entries; j++)
+					seq_printf(seq, "\t%pS\n", (void *)entries[j]);
+			}
+#endif
+			seq_puts(seq, "\n");
+	}
+	return 0;
+}
+
+static void *debugfs_all_objects_start(struct seq_file *m, loff_t *ppos)
+{
+	struct slab_debug_private *priv = m->private;
+	struct kmem_cache *s = priv->inode->i_private;
+	struct page *page;
+
+	priv->map = kmalloc(BITS_TO_LONGS(MAX_OBJS_PER_PAGE), GFP_KERNEL);
+
+	if (!priv->map)
+		return NULL;
+
+	if (!(s->flags & SLAB_STORE_USER))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	page = next_page(priv);
+	return page;
+}
+
+static void *debugfs_all_objects_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	struct slab_debug_private *priv = m->private;
+	struct page *page;
+
+	if (v)
+		put_page(v);
+
+	++*ppos;
+	page = next_page(priv);
+
+	return page;
+}
+
+static void debugfs_all_objects_stop(struct seq_file *m, void *v)
+{
+	struct slab_debug_private *priv = m->private;
+	struct kmem_cache *s = priv->inode->i_private;
+
+	kfree(priv->map);
+
+	if (v && (s->flags & SLAB_STORE_USER))
+		put_page(v);
+}
+
+static const struct seq_operations debugfs_all_objects_ops = {
+	.start	= debugfs_all_objects_start,
+	.next	= debugfs_all_objects_next,
+	.stop	= debugfs_all_objects_stop,
+	.show	= debugfs_all_objects_show
+};
+
+static int debugfs_all_objects_open(struct inode *inode, struct file *file)
+{
+	struct slab_debug_private *priv = __seq_open_private(file,
+			&debugfs_all_objects_ops, sizeof(struct slab_debug_private));
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->inode = inode;
+	priv->nid = 0;
+	priv->field = FULL_LIST;
+
+	return 0;
+}
+
+static const struct file_operations debugfs_all_objects_fops = {
+	.open    = debugfs_all_objects_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release_private,
+};
+
 static int slab_debugfs_show(struct seq_file *seq, void *v)
 {
 	struct location *l;
@@ -6018,6 +6239,10 @@ static void debugfs_slab_add(struct kmem_cache *s)
 	debugfs_create_file("free_traces", 0400,
 		slab_cache_dir, s, &slab_debugfs_fops);
 
+	debugfs_create_file("all_objects", 0400,
+		slab_cache_dir, s, &debugfs_all_objects_fops);
+
+
 	if (!unmergeable)
 		/* Setup first alias */
 		debugfs_slab_alias(s, s->name);
-- 
2.31.1.272.g89b43f80a5

