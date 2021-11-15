Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FC451DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352307AbhKPAbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761FC06BCE8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h63so8499657pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkZwS8vDT7uRdINCU8D9UvCZGIRIwIQc1XPDfLaq/tc=;
        b=ID+pjGn9EI+5i9DzY7oraYWEDBEyS4qP50y8Lkb3ajNkoHifRj/HHAtvYL9u1VX44D
         drIlHbZdVckM9/q44Cp1KQqtmgU+RhbmA8YWJZuFJZv2sRbr7eony6wddip6RSJfO/06
         3xyvaQqlMNTZhfyk2Xo72fYJ69qEtOZK4knIhJzDFMzUcTtFRZ0w5mWie96UlDmpAq9/
         UxeJTQzkwqbBNO1xZXcBdTf2Moju+wBPB4y3Ma4OH7AJzTjcKeS7sNsM8y2EYnH4K2r/
         554PYK+N6apvMfA8x75n6JxLmGuvYz1jjpysB6EXt/DO1ZVPG8KhhP7guvwLXstwFenP
         sApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bkZwS8vDT7uRdINCU8D9UvCZGIRIwIQc1XPDfLaq/tc=;
        b=r0NyPvcS3RVS/qiICv8Z0GGUyVCujQb/QR8g4yi+yiJP1E5efDKMINoaLPQBvrXB4U
         /yLQEoJjg1CVlXavffwpsKW4hPy/hmjCRE+ivCDcAeAtfuEYlDFwpZEavTyGeHeWVNmz
         qkEvh92E0qhIZ2NcEvpkxU5Vg+AgYb2g2RB8K2uyazQsW3xqeqk7fwn78nhvIyt/hH1d
         NTqJM6QfXjju+g2ZMFK76vfZDL3uQNRThhCbpGkMkueTaXjZ3HJlcq97E4op/SwY+9tW
         fLgOUlCooKcVCF3P9YqMR5vZPcvIaaGgaYqsXiJhyXTW4ni55J4b0bFIbt4ip4KdqcEp
         s4Og==
X-Gm-Message-State: AOAM533dn+VKRZa7DAACMYJ/Y6HTswBxtF2oScAscjoubpdJCcf7uCTd
        GSjFaGFAuNAj3mP6hWjRPw8=
X-Google-Smtp-Source: ABdhPJwR04xuNImDuDENYg/S2BKdzT/IVQQJy9hJxt242TMObRPK9EwYVpUkWoWWtDxueOE2ZRucyg==
X-Received: by 2002:aa7:9e9c:0:b0:49f:c7cf:ff5 with SMTP id p28-20020aa79e9c000000b0049fc7cf0ff5mr34844423pfq.62.1637002756146;
        Mon, 15 Nov 2021 10:59:16 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 3/9] zsmalloc: decouple class actions from zspage works
Date:   Mon, 15 Nov 2021 10:59:03 -0800
Message-Id: <20211115185909.3949505-4-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves class stat update out of obj_malloc since
it's not related to zspage operation.
This is a preparation to introduce new lock scheme in next
patch.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c149ccf734ba..7a14090e4a53 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1360,17 +1360,19 @@ size_t zs_huge_class_size(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
-static unsigned long obj_malloc(struct size_class *class,
+static unsigned long obj_malloc(struct zs_pool *pool,
 				struct zspage *zspage, unsigned long handle)
 {
 	int i, nr_page, offset;
 	unsigned long obj;
 	struct link_free *link;
+	struct size_class *class;
 
 	struct page *m_page;
 	unsigned long m_offset;
 	void *vaddr;
 
+	class = pool->size_class[zspage->class];
 	handle |= OBJ_ALLOCATED_TAG;
 	obj = get_freeobj(zspage);
 
@@ -1394,7 +1396,6 @@ static unsigned long obj_malloc(struct size_class *class,
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-	class_stat_inc(class, OBJ_USED, 1);
 
 	obj = location_to_obj(m_page, obj);
 
@@ -1433,10 +1434,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj = obj_malloc(class, zspage, handle);
+		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
+		class_stat_inc(class, OBJ_USED, 1);
 		spin_unlock(&class->lock);
 
 		return handle;
@@ -1451,7 +1453,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	}
 
 	spin_lock(&class->lock);
-	obj = obj_malloc(class, zspage, handle);
+	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	set_zspage_mapping(zspage, class->index, newfg);
@@ -1459,6 +1461,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	atomic_long_add(class->pages_per_zspage,
 				&pool->pages_allocated);
 	class_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, OBJ_USED, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1468,7 +1471,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
 
-static void obj_free(struct size_class *class, unsigned long obj)
+static void obj_free(int class_size, unsigned long obj)
 {
 	struct link_free *link;
 	struct zspage *zspage;
@@ -1478,7 +1481,7 @@ static void obj_free(struct size_class *class, unsigned long obj)
 	void *vaddr;
 
 	obj_to_location(obj, &f_page, &f_objidx);
-	f_offset = (class->size * f_objidx) & ~PAGE_MASK;
+	f_offset = (class_size * f_objidx) & ~PAGE_MASK;
 	zspage = get_zspage(f_page);
 
 	vaddr = kmap_atomic(f_page);
@@ -1489,7 +1492,6 @@ static void obj_free(struct size_class *class, unsigned long obj)
 	kunmap_atomic(vaddr);
 	set_freeobj(zspage, f_objidx);
 	mod_zspage_inuse(zspage, -1);
-	class_stat_dec(class, OBJ_USED, 1);
 }
 
 void zs_free(struct zs_pool *pool, unsigned long handle)
@@ -1513,7 +1515,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	class = zspage_class(pool, zspage);
 
 	spin_lock(&class->lock);
-	obj_free(class, obj);
+	obj_free(class->size, obj);
+	class_stat_dec(class, OBJ_USED, 1);
 	fullness = fix_fullness_group(class, zspage);
 	if (fullness != ZS_EMPTY) {
 		migrate_read_unlock(zspage);
@@ -1671,7 +1674,7 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		}
 
 		used_obj = handle_to_obj(handle);
-		free_obj = obj_malloc(class, get_zspage(d_page), handle);
+		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
 		/*
@@ -1683,7 +1686,7 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		free_obj |= BIT(HANDLE_PIN_BIT);
 		record_obj(handle, free_obj);
 		unpin_tag(handle);
-		obj_free(class, used_obj);
+		obj_free(class->size, used_obj);
 	}
 
 	/* Remember last position in this iteration */
-- 
2.34.0.rc1.387.gb447b232ab-goog

