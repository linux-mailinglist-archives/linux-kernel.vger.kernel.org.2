Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78A40A868
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhINHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhINHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:45:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC5C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c4so6056186pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=cxJV9i43g6uZ64FMZlPy6vGws06VDwvTYOU9J60k2oXFzhujZG9VoAPuhPBT9r/YiN
         Ab4AAog0W/jtZekEXv66wyjDw/oUvI6mkO/SwrMoxubzvfuSs5P3/mKXw5Ff1Qv1lf5e
         wGbXHU8HJ++y2FEg8o0rWeAje5ppyGGqA+8+Qj7gMUt8/QY/Twi8JOWRYK231oLK0Dbr
         6UC70hV6iVuq0zR8hkLYicw2UTucdi71woBs/u4D5EMK5j2JkEiT2CIcRJNdGWq1OJgm
         wdfAiWYT1P8R0LwJqfenct+YSLo6jk7+r2UgPIqEnNhykvt01imNPXAoq1BZ5CYBeLac
         2otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=yZYkCuzCdng3j/cc/ypDtZBv7bsRGY2W8rnwXYUeSadUFxLysY8JS5Eo+3B7NWHfLm
         sSKn3hM/oxmZ2oqL7XSLSaiingVzsdtkFS9qlAXwWIUF9IkMesFqJNCcFhyumfdHjWh8
         VDsyWJhQPKwjcpLenX3X/G8LyxgBos3Ls7SpT+7mAzKh1Wq51hyI6Nal9YyFXXIdZIO/
         tyCwO7fDaTU/xebyUfYpEd57bQxyYbW55hNbUSEFrs/ixbwLpPgdTCz2Hja82RRrQd2K
         VNW5qfM7gwpuZWQrNc+QI24PNAI6o5Bm2f3QRugPl7XXiCFfvX7UVqJkgMTsCARdR8Yr
         27cA==
X-Gm-Message-State: AOAM5330C02Tnr0wnoQ0DPepmME0mBiytriXITAYpC8LHFfRiaezcgYm
        lvk07AfwHF4dvBoaS1O+JFCxcg==
X-Google-Smtp-Source: ABdhPJwYxpqxp3oj2dLcwakc4I2z7loWq7/YRxBwPe8CJLXtMsP9qjDSPfIdzINHdcZRHHPu0VRRwA==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr605394pjb.78.1631605264454;
        Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 68/76] xarray: use kmem_cache_alloc_lru to allocate xa_node
Date:   Tue, 14 Sep 2021 15:29:30 +0800
Message-Id: <20210914072938.6440-69-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workingset will add the xa_node to the shadow_nodes list. So the
allocation of xa_node should be done by kmem_cache_alloc_lru(). The
workingset can use xas_set_lru() to pass the list_lru.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/xarray.h |  9 ++++++++-
 lib/xarray.c           | 10 +++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..31f3e5ef3c7b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1317,6 +1317,7 @@ struct xa_state {
 	struct xa_node *xa_node;
 	struct xa_node *xa_alloc;
 	xa_update_node_t xa_update;
+	struct list_lru *xa_lru;
 };
 
 /*
@@ -1336,7 +1337,8 @@ struct xa_state {
 	.xa_pad = 0,					\
 	.xa_node = XAS_RESTART,				\
 	.xa_alloc = NULL,				\
-	.xa_update = NULL				\
+	.xa_update = NULL,				\
+	.xa_lru = NULL,					\
 }
 
 /**
@@ -1613,6 +1615,11 @@ static inline void xas_set_update(struct xa_state *xas, xa_update_node_t update)
 	xas->xa_update = update;
 }
 
+static inline void xas_set_lru(struct xa_state *xas, struct list_lru *lru)
+{
+	xas->xa_lru = lru;
+}
+
 /**
  * xas_next_entry() - Advance iterator to next present entry.
  * @xas: XArray operation state.
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..e9b818abc823 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -302,7 +302,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 		gfp |= __GFP_ACCOUNT;
-	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	if (!xas->xa_alloc)
 		return false;
 	xas->xa_alloc->parent = NULL;
@@ -334,10 +334,10 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 		gfp |= __GFP_ACCOUNT;
 	if (gfpflags_allow_blocking(gfp)) {
 		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		xas_lock_type(xas, lock_type);
 	} else {
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	}
 	if (!xas->xa_alloc)
 		return false;
@@ -371,7 +371,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 			gfp |= __GFP_ACCOUNT;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node) {
 			xas_set_err(xas, -ENOMEM);
 			return NULL;
@@ -1014,7 +1014,7 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		void *sibling = NULL;
 		struct xa_node *node;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
 		node->array = xas->xa;
-- 
2.11.0

