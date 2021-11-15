Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC82C451D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbhKPAbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E793C06BCEA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:19 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 200so15402195pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWDMmjqynWZEAd9h9yKAs1pSujUR3PfRIBQcnnobkdE=;
        b=cGyp/bWHN50rNMxDmiuZEHaXRJEeRkWOdSakIX0N4UwOYhdSBFeMyR0uyEDlXphM2V
         uZ5ciB4CuOVSOnKC9vu6SGqyw+eQG8q+KwyQO6om8iGrVik95do8EHG79t/NCWMn05A6
         QXT/CDwlhsUjgTaWjT2ZqzCa49XdfHK1fmkMOYFrc+CXuqAZ7S6l20qrwJaTd1l2tZtE
         WmqS4Kz9lSOOuefNctrbvZFvM9/CxCQU1tk+vNieCFdA7tTKXuIB62uB6WMGshNf0IiX
         +YQPmi/1UoUzPUeW7+mE4oMkKnQCvuG6xA1XOY2q1DiURcBes1WKse1rUCCnEP2UON5w
         0mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BWDMmjqynWZEAd9h9yKAs1pSujUR3PfRIBQcnnobkdE=;
        b=Q3SY+CbUgqSNA+AzEjDfD189DTQi1AukVCEMDaO2Pd3YpuhhZmDak2vLjA/Ng+hy0U
         u50J1oen2Gc5OW1Ggs81E8fY5zv/jIz9Uuj4AhqFjKNOG96hiXlvMmBqKCMgny5Fy3sB
         zh0Wl8MdnxQxFffZCpRNWXSeAu3Vkhrjunx+a8ys0SOlfjWuyXRIYWtV2KcFOgEqQcXw
         hcslcuKFbdbAsTHkK3/JXpE/pgfBpczQMIL458w/CDsV9ul4ydnxMCMxwotsbgt3jk0V
         eqTe6VSgyKwkDx7P4LTDW8qx+sqHFUhCf21Hh+kwu+b+f0yMGP/eNzABC+Vd4PSGP/Hc
         JgUw==
X-Gm-Message-State: AOAM532680ykIgJrWykJejX857LTIxIvMSV7QSg/2UbVVfA4tB6Vm9vP
        S6M+qI9u8lvSiyFlMg0OP0Q=
X-Google-Smtp-Source: ABdhPJxRww3aWuI1I1XEJ4dSrjY48BDA9+C8l/r6j0Lk5KgQVsKDok4BYLh5U2AamCmcsl+iYK4QyQ==
X-Received: by 2002:a63:7cd:: with SMTP id 196mr747749pgh.224.1637002758896;
        Mon, 15 Nov 2021 10:59:18 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 5/9] zsmalloc: move huge compressed obj from page to zspage
Date:   Mon, 15 Nov 2021 10:59:05 -0800
Message-Id: <20211115185909.3949505-6-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the flag aims for zspage, not per page. Let's move it to zspage.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6ca130c0f7dc..26e571cc354e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -121,6 +121,7 @@
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
+#define HUGE_BITS	1
 #define FULLNESS_BITS	2
 #define CLASS_BITS	8
 #define ISOLATED_BITS	3
@@ -213,22 +214,6 @@ struct size_class {
 	struct zs_size_stat stats;
 };
 
-/* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
-static void SetPageHugeObject(struct page *page)
-{
-	SetPageOwnerPriv1(page);
-}
-
-static void ClearPageHugeObject(struct page *page)
-{
-	ClearPageOwnerPriv1(page);
-}
-
-static int PageHugeObject(struct page *page)
-{
-	return PageOwnerPriv1(page);
-}
-
 /*
  * Placed within free objects to form a singly linked list.
  * For every zspage, zspage->freeobj gives head of this list.
@@ -278,6 +263,7 @@ struct zs_pool {
 
 struct zspage {
 	struct {
+		unsigned int huge:HUGE_BITS;
 		unsigned int fullness:FULLNESS_BITS;
 		unsigned int class:CLASS_BITS + 1;
 		unsigned int isolated:ISOLATED_BITS;
@@ -298,6 +284,17 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+/* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
+static void SetZsHugePage(struct zspage *zspage)
+{
+	zspage->huge = 1;
+}
+
+static bool ZsHugePage(struct zspage *zspage)
+{
+	return zspage->huge;
+}
+
 #ifdef CONFIG_COMPACTION
 static int zs_register_migration(struct zs_pool *pool);
 static void zs_unregister_migration(struct zs_pool *pool);
@@ -830,7 +827,9 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	if (unlikely(PageHugeObject(page)))
+	struct zspage *zspage = get_zspage(page);
+
+	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
 
 	return page->freelist;
@@ -880,8 +879,9 @@ static unsigned long handle_to_obj(unsigned long handle)
 static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
 {
 	unsigned long handle;
+	struct zspage *zspage = get_zspage(page);
 
-	if (unlikely(PageHugeObject(page))) {
+	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_page(page), page);
 		handle = page->index;
 	} else
@@ -920,7 +920,6 @@ static void reset_page(struct page *page)
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
 	page_mapcount_reset(page);
-	ClearPageHugeObject(page);
 	page->freelist = NULL;
 }
 
@@ -1062,7 +1061,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
-				SetPageHugeObject(page);
+				SetZsHugePage(zspage);
 		} else {
 			prev_page->freelist = page;
 		}
@@ -1307,7 +1306,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 
 	ret = __zs_map_object(area, pages, off, class->size);
 out:
-	if (likely(!PageHugeObject(page)))
+	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
 
 	return ret;
@@ -1395,7 +1394,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	vaddr = kmap_atomic(m_page);
 	link = (struct link_free *)vaddr + m_offset / sizeof(*link);
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
-	if (likely(!PageHugeObject(m_page)))
+	if (likely(!ZsHugePage(zspage)))
 		/* record handle in the header of allocated chunk */
 		link->handle = handle;
 	else
@@ -1496,7 +1495,10 @@ static void obj_free(int class_size, unsigned long obj)
 
 	/* Insert this object in containing zspage's freelist */
 	link = (struct link_free *)(vaddr + f_offset);
-	link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
+	if (likely(!ZsHugePage(zspage)))
+		link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
+	else
+		f_page->index = 0;
 	kunmap_atomic(vaddr);
 	set_freeobj(zspage, f_objidx);
 	mod_zspage_inuse(zspage, -1);
@@ -1867,7 +1869,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 	create_page_chain(class, zspage, pages);
 	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
-	if (unlikely(PageHugeObject(oldpage)))
+	if (unlikely(ZsHugePage(zspage)))
 		newpage->index = oldpage->index;
 	__SetPageMovable(newpage, page_mapping(oldpage));
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

