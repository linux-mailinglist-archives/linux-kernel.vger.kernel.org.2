Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9C37A524
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhEKKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhEKKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:54:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034EAC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:53:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so82549pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=mWGtONSkiGQTSidIKAiOi86zc4lRvtDLkmgp92k6lwi/xWGV6Z8f0RmEfk8KHxrylw
         FNPkkF7D8R4f7sQBN6KwptrKBO64QIShh6wCISgF9YAPhO1VikQ5gMpRU5yW8aukjolB
         A1px8LnZpEbJGzGpYNIdzONxb+IKCWIDi84djEbcyXDYA1TVWv2ZOWSRwRtFYBtjGf3y
         7eE+HNX5kRHnpECIc7KcTnaNoFO4qNHgLIZefQfQXXAGKA5D9uhlBZjegq9AsdII25jI
         vlklpo3owHbENwSAAAdfKR+cYydbp5MD/DVz+oSKyzNJY2FcTlKYiKeTT7MZziTOrvzJ
         dMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7N2ct9tvwpvEjrUOuEEAnTDqNZXNpAiEvvqkroYr+g=;
        b=krorAPTAmJ6O/X+VxC3hZQVfbJWG8BWn+0kHIPdaLBNasvBZpIU0N758/C1JCwxwDo
         3oEkPMXN62ufqpZuWgc+7e7sTMIL9QTKtnw8Nhar44b8HeqPkAi61Yq+yKHR6r+fcoPm
         XZ8ioKvdGAmMwyZjLS/swZF9Ywi5nppuasriE1XSChW71391tP0qL1Fk/h5ptDNmWYzT
         nyacwxvXugIKvWWVfjA57J2rd4zweKEjX6yHly4p3d5mHgycsTpsDdR1gD4vN7j9q5ms
         OdM4tuqO46xU8DQeOpNgePm5wmTK7kT3+hlEOm7JSQMhfy6OR+uhlah2ShXdy/QpqTF0
         sdKQ==
X-Gm-Message-State: AOAM531fxegQqJ1qT8pP6dolLCr5kIs4O8KzQBOlGCNLaO2keXKIw95u
        JfUGGKZ2d1XQdxjt7fMiPBvfww==
X-Google-Smtp-Source: ABdhPJwOJA2BD0y65E44ULMn40Js/gJ8kg9txboXr5CMo2V3MkRk4Nj+rr9hq45AQ03KLQl8ug0oQA==
X-Received: by 2002:a17:903:3106:b029:e9:15e8:250e with SMTP id w6-20020a1709033106b02900e915e8250emr29193253plc.33.1620730379548;
        Tue, 11 May 2021 03:52:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:52:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 14/17] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
Date:   Tue, 11 May 2021 18:46:44 +0800
Message-Id: <20210511104647.604-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to add the allocated objects to its list_lru, we should use
kmem_cache_alloc_lru() to allocate objects. So intruduce
nfs4_xattr_entry_cachep which is used to allocate nfs4_xattr_entry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/nfs42xattr.c | 95 ++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 1c4d2a05b401..5b7af9080db0 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -81,7 +81,7 @@ struct nfs4_xattr_entry {
 	struct hlist_node hnode;
 	struct list_head lru;
 	struct list_head dispose;
-	char *xattr_name;
+	const char *xattr_name;
 	void *xattr_value;
 	size_t xattr_size;
 	struct nfs4_xattr_bucket *bucket;
@@ -98,6 +98,7 @@ static struct list_lru nfs4_xattr_entry_lru;
 static struct list_lru nfs4_xattr_large_entry_lru;
 
 static struct kmem_cache *nfs4_xattr_cache_cachep;
+static struct kmem_cache *nfs4_xattr_entry_cachep;
 
 /*
  * Hashing helper functions.
@@ -177,49 +178,27 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
 {
 	struct nfs4_xattr_entry *entry;
 	void *valp;
-	char *namep;
-	size_t alloclen, slen;
-	char *buf;
-	uint32_t flags;
+	const char *namep;
+	uint32_t flags = len > PAGE_SIZE ? NFS4_XATTR_ENTRY_EXTVAL : 0;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | GFP_NOFS;
+	struct list_lru *lru;
 
 	BUILD_BUG_ON(sizeof(struct nfs4_xattr_entry) +
 	    XATTR_NAME_MAX + 1 > PAGE_SIZE);
 
-	alloclen = sizeof(struct nfs4_xattr_entry);
-	if (name != NULL) {
-		slen = strlen(name) + 1;
-		alloclen += slen;
-	} else
-		slen = 0;
-
-	if (alloclen + len <= PAGE_SIZE) {
-		alloclen += len;
-		flags = 0;
-	} else {
-		flags = NFS4_XATTR_ENTRY_EXTVAL;
-	}
-
-	buf = kmalloc(alloclen, GFP_KERNEL_ACCOUNT | GFP_NOFS);
-	if (buf == NULL)
+	lru = flags & NFS4_XATTR_ENTRY_EXTVAL ? &nfs4_xattr_large_entry_lru :
+	      &nfs4_xattr_entry_lru;
+	entry = kmem_cache_alloc_lru(nfs4_xattr_entry_cachep, lru, gfp);
+	if (!entry)
 		return NULL;
-	entry = (struct nfs4_xattr_entry *)buf;
-
-	if (name != NULL) {
-		namep = buf + sizeof(struct nfs4_xattr_entry);
-		memcpy(namep, name, slen);
-	} else {
-		namep = NULL;
-	}
-
-
-	if (flags & NFS4_XATTR_ENTRY_EXTVAL) {
-		valp = kvmalloc(len, GFP_KERNEL_ACCOUNT | GFP_NOFS);
-		if (valp == NULL) {
-			kfree(buf);
-			return NULL;
-		}
-	} else if (len != 0) {
-		valp = buf + sizeof(struct nfs4_xattr_entry) + slen;
+	namep = kstrdup_const(name, gfp);
+	if (!namep && name)
+		goto free_buf;
+
+	if (len != 0) {
+		valp = kvmalloc(len, gfp);
+		if (!valp)
+			goto free_name;
 	} else
 		valp = NULL;
 
@@ -232,23 +211,23 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
 
 	entry->flags = flags;
 	entry->xattr_value = valp;
-	kref_init(&entry->ref);
 	entry->xattr_name = namep;
 	entry->xattr_size = len;
-	entry->bucket = NULL;
-	INIT_LIST_HEAD(&entry->lru);
-	INIT_LIST_HEAD(&entry->dispose);
-	INIT_HLIST_NODE(&entry->hnode);
 
 	return entry;
+free_name:
+	kfree_const(namep);
+free_buf:
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
+	return NULL;
 }
 
 static void
 nfs4_xattr_free_entry(struct nfs4_xattr_entry *entry)
 {
-	if (entry->flags & NFS4_XATTR_ENTRY_EXTVAL)
-		kvfree(entry->xattr_value);
-	kfree(entry);
+	kvfree(entry->xattr_value);
+	kfree_const(entry->xattr_name);
+	kmem_cache_free(nfs4_xattr_entry_cachep, entry);
 }
 
 static void
@@ -289,7 +268,7 @@ nfs4_xattr_alloc_cache(void)
 {
 	struct nfs4_xattr_cache *cache;
 
-	cache = kmem_cache_alloc(nfs4_xattr_cache_cachep,
+	cache = kmem_cache_alloc_lru(nfs4_xattr_cache_cachep, &nfs4_xattr_cache_lru,
 	    GFP_KERNEL_ACCOUNT | GFP_NOFS);
 	if (cache == NULL)
 		return NULL;
@@ -992,6 +971,17 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
+static void nfs4_xattr_entry_init_once(void *p)
+{
+	struct nfs4_xattr_entry *entry = p;
+
+	kref_init(&entry->ref);
+	entry->bucket = NULL;
+	INIT_LIST_HEAD(&entry->lru);
+	INIT_LIST_HEAD(&entry->dispose);
+	INIT_HLIST_NODE(&entry->hnode);
+}
+
 int __init nfs4_xattr_cache_init(void)
 {
 	int ret = 0;
@@ -1003,6 +993,13 @@ int __init nfs4_xattr_cache_init(void)
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
 
+	nfs4_xattr_entry_cachep = kmem_cache_create("nfs4_xattr_entry",
+			sizeof(struct nfs4_xattr_entry), 0,
+			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+			nfs4_xattr_entry_init_once);
+	if (!nfs4_xattr_entry_cachep)
+		goto out5;
+
 	ret = list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
 	    &nfs4_xattr_large_entry_shrinker);
 	if (ret)
@@ -1040,6 +1037,8 @@ int __init nfs4_xattr_cache_init(void)
 out3:
 	list_lru_destroy(&nfs4_xattr_large_entry_lru);
 out4:
+	kmem_cache_destroy(nfs4_xattr_entry_cachep);
+out5:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 
 	return ret;
-- 
2.11.0

