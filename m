Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B70451DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbhKPAby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FB6C06BCE6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so13647368pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvggfUleMqIfDPHbdwrJ/rWz4NRzcNXyUdl0j9jqldo=;
        b=VSTuDWnE3YRnE2mo0qcaOFmFewKDjQHZIgJsskhO499xUejBnEwrQiw3cNkas9zUfQ
         cDKPMVzKPRmxt5YS/adj/jZlRW8bRqWbXIEfWsECt8itJVvIkCCfptRhneJj8NCnYyLr
         7ElRZBaZHM1SFt7HZX0RPX9EXwluOIIt83lNe8zbZfolfcfJgy6VUs6uXTPUfVCfyDlk
         a/80R2hnai2hm50AINISvZT1Z2kQAsruVGCk4I1eMDmT0razTooXS0Eq9gwwwrhrfQke
         WD/bSSucwJVymECs3yNYAvy6DHc+v+V0iejYDg/lOw6hZUNDTtTCmq3ZN+91+Rems0ob
         M11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZvggfUleMqIfDPHbdwrJ/rWz4NRzcNXyUdl0j9jqldo=;
        b=iwaoeI3qlORMcPr3S1UtMX7g+I9aOyN5DfDMVlpifafNrmCX+Dz+pgkY2YkJuOHr4x
         dPgy+YHDVliiYARTq8Ei6z+CgT7mQ8FuT+srMummsx5P8hRyenkWg+dI70x73v0cPLO1
         oV4rrBavRrmz5Kz9H2E2D9Kzc0ixgzbYulTezjOV3iHYlSyFRcNxZzI7I5pmmt5lqKs8
         2Rklcs2fcsKNv69aONtkmTO9hD9uLjgN4donw9W7ZN4trbwwG/iqY+ZScxTPOU5T0iwu
         e99gC+7KoSO/HqG296mbpTvQKHYl3FsSn0j/NRHLHC4IMV4NxlwjYYxuawDoxjJyPn12
         l8Ng==
X-Gm-Message-State: AOAM530OAsmsAnTc7TnVRd0yfZDea9rUGjJg5ZdKpIHC1HE4tBmE14R2
        efNi69s+BAbxemN96hKoJOJiyJkg2dk=
X-Google-Smtp-Source: ABdhPJzIvEAbNi9+kGaMo8OsM7Fdz8XMbJ/zryCLDttdb7o0g8LqlsHwPGanI3Nax1fd2VwyMqhRww==
X-Received: by 2002:a17:902:784c:b0:138:f4e5:9df8 with SMTP id e12-20020a170902784c00b00138f4e59df8mr38105810pln.14.1637002754026;
        Mon, 15 Nov 2021 10:59:14 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:13 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/9] zsmalloc: introduce some helper functions
Date:   Mon, 15 Nov 2021 10:59:01 -0800
Message-Id: <20211115185909.3949505-2-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_zspage_mapping returns fullness as well as class_idx. However,
the fullness is usually not used since it could be stale in some
contexts. It causes misleading as well as unnecessary instructions
so this patch introduces zspage_class.

obj_to_location also produces page and index but we don't need
always the index, either so this patch introduces obj_to_page.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 54 ++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b897ce3b399a..f8c63bacd22e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -517,6 +517,12 @@ static void get_zspage_mapping(struct zspage *zspage,
 	*class_idx = zspage->class;
 }
 
+static struct size_class *zspage_class(struct zs_pool *pool,
+					     struct zspage *zspage)
+{
+	return pool->size_class[zspage->class];
+}
+
 static void set_zspage_mapping(struct zspage *zspage,
 				unsigned int class_idx,
 				enum fullness_group fullness)
@@ -844,6 +850,12 @@ static void obj_to_location(unsigned long obj, struct page **page,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
+static void obj_to_page(unsigned long obj, struct page **page)
+{
+	obj >>= OBJ_TAG_BITS;
+	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+}
+
 /**
  * location_to_obj - get obj value encoded from (<page>, <obj_idx>)
  * @page: page object resides in zspage
@@ -1246,8 +1258,6 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
-	unsigned int class_idx;
-	enum fullness_group fg;
 	struct size_class *class;
 	struct mapping_area *area;
 	struct page *pages[2];
@@ -1270,8 +1280,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	/* migration cannot move any subpage in this zspage */
 	migrate_read_lock(zspage);
 
-	get_zspage_mapping(zspage, &class_idx, &fg);
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
 	area = &get_cpu_var(zs_map_area);
@@ -1304,16 +1313,13 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
-	unsigned int class_idx;
-	enum fullness_group fg;
 	struct size_class *class;
 	struct mapping_area *area;
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
-	get_zspage_mapping(zspage, &class_idx, &fg);
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
 	area = this_cpu_ptr(&zs_map_area);
@@ -1491,8 +1497,6 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	struct zspage *zspage;
 	struct page *f_page;
 	unsigned long obj;
-	unsigned int f_objidx;
-	int class_idx;
 	struct size_class *class;
 	enum fullness_group fullness;
 	bool isolated;
@@ -1502,13 +1506,11 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 
 	pin_tag(handle);
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &f_page, &f_objidx);
+	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
 
 	migrate_read_lock(zspage);
-
-	get_zspage_mapping(zspage, &class_idx, &fullness);
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 
 	spin_lock(&class->lock);
 	obj_free(class, obj);
@@ -1866,8 +1868,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
-	int class_idx;
-	enum fullness_group fullness;
 	struct zspage *zspage;
 	struct address_space *mapping;
 
@@ -1880,15 +1880,10 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 
 	zspage = get_zspage(page);
 
-	/*
-	 * Without class lock, fullness could be stale while class_idx is okay
-	 * because class_idx is constant unless page is freed so we should get
-	 * fullness again under class lock.
-	 */
-	get_zspage_mapping(zspage, &class_idx, &fullness);
 	mapping = page_mapping(page);
 	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
+
+	class = zspage_class(pool, zspage);
 
 	spin_lock(&class->lock);
 	if (get_zspage_inuse(zspage) == 0) {
@@ -1907,6 +1902,9 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 * size_class to prevent further object allocation from the zspage.
 	 */
 	if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
+		enum fullness_group fullness;
+		unsigned int class_idx;
+
 		get_zspage_mapping(zspage, &class_idx, &fullness);
 		atomic_long_inc(&pool->isolated_pages);
 		remove_zspage(class, zspage, fullness);
@@ -1923,8 +1921,6 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 {
 	struct zs_pool *pool;
 	struct size_class *class;
-	int class_idx;
-	enum fullness_group fullness;
 	struct zspage *zspage;
 	struct page *dummy;
 	void *s_addr, *d_addr, *addr;
@@ -1949,9 +1945,8 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 	/* Concurrent compactor cannot migrate any subpage in zspage */
 	migrate_write_lock(zspage);
-	get_zspage_mapping(zspage, &class_idx, &fullness);
 	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 	offset = get_first_obj_offset(page);
 
 	spin_lock(&class->lock);
@@ -2049,8 +2044,6 @@ static void zs_page_putback(struct page *page)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
-	int class_idx;
-	enum fullness_group fg;
 	struct address_space *mapping;
 	struct zspage *zspage;
 
@@ -2058,10 +2051,9 @@ static void zs_page_putback(struct page *page)
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	get_zspage_mapping(zspage, &class_idx, &fg);
 	mapping = page_mapping(page);
 	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 
 	spin_lock(&class->lock);
 	dec_zspage_isolation(zspage);
-- 
2.34.0.rc1.387.gb447b232ab-goog

