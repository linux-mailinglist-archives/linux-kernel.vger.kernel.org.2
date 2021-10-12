Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5986742AB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhJLSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:59 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B576C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o12so147936qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIQ3XB2hRjxutOXFzANVm4hFlprKhy5560F/z1rM1rA=;
        b=lGVH1y+a9cFDJqGIq5ZIU7pxSbOjZgxVsVpH3EeNfdNc9s2Vk+TWGrZcVHRdgO0L9y
         mYi/q0IsMML8uZBfPR7nR4KRN+4T8MCDXSc0NFImIK2u0iAo3UFG1pexA2BqiKErNUGx
         e8mpkqXXF5mzFiNINkf8NDcJqwyCQ83VR8istJXW110leDrBuk/fDyerrNNw68S/QaYN
         boGMZ4gFu3KkAqquhkrXlA+sR/+XsSAtI7PBg39+ATPS6bqQd57T2sf/u9ABk6ehlyz/
         p30ZG12lzmBiFszdQ34vQRLklLf2G6aSG84DOBJSmuHKgiKLMdZqwDF12oQ9kd6ObmB0
         +eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIQ3XB2hRjxutOXFzANVm4hFlprKhy5560F/z1rM1rA=;
        b=RtfS+xQpXqKcaNLfzJWzMJHGMzp6KuGOXbCOS1R+3Ro2GNzP8Bp8TEZYKhJbH4lrrm
         aCHnBr75TXqVWHcrYqwu/sQexQfs3OJsgCjNohjAmM51BU1SAvHRGw0D10VGVdu/BtiS
         y5lXtUjJ6IJOfAH1UIJ4PBRWqmW9+YZp8hoasKGa43xPj9OTjwOWr82aOTYgT3SRkUvL
         nYRiKxMdTgzN/Q1wfE3ytxm7JGr69rbJasuJCjZy45bpPOT4e2J0l38+74YNA7dm9R37
         f/Iqoy56lYvq/++1gJaXQLw27iGU96gMZY4eZZmRgeB3NwRlMB8WfgNYeitfMER4lev+
         SR2g==
X-Gm-Message-State: AOAM533vcOOwkQZuayPu9kNc4PR0HoHpiFqgAGdMl+P++CBpZA1ooZ50
        Z38emPWLwBEBrlGT6rm5l62ZJg==
X-Google-Smtp-Source: ABdhPJwsgMHV/mOuI2+fp4J9rrrUqJwZVRic6cwsPkyPIm+tLDhrpKr8zek80w4mZnoRaY0jtif5tg==
X-Received: by 2002:ac8:5a41:: with SMTP id o1mr23493208qta.21.1634061716703;
        Tue, 12 Oct 2021 11:01:56 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id n79sm6172567qke.97.2021.10.12.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:56 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/11] PageSlab: eliminate unnecessary compound_head() calls in mm/kasan
Date:   Tue, 12 Oct 2021 14:01:42 -0400
Message-Id: <20211012180148.1669685-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All tested pages come from virt_to_head_page(): either directly or
through kasan_addr_to_page(). Remove the redundant compound_head()
calls. Rename the helper to kasan_addr_to_head_page() to clarify.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/kasan/common.c      | 4 ++--
 mm/kasan/generic.c     | 4 ++--
 mm/kasan/kasan.h       | 2 +-
 mm/kasan/report.c      | 6 +++---
 mm/kasan/report_tags.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b5e81273fc6b..2baf121fb8c5 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -411,7 +411,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	 * !PageSlab() when the size provided to kmalloc is larger than
 	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
 	 */
-	if (unlikely(!PageSlab(compound_head(page)))) {
+	if (unlikely(!PageSlab(page))) {
 		if (____kasan_kfree_large(ptr, ip))
 			return;
 		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE, false);
@@ -575,7 +575,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	page = virt_to_head_page(object);
 
 	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
-	if (unlikely(!PageSlab(compound_head(page))))
+	if (unlikely(!PageSlab(page)))
 		return __kasan_kmalloc_large(object, size, flags);
 	else
 		return ____kasan_kmalloc(page->slab_cache, object, size, flags);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 94c0c86c79d9..d4303a6722ab 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -330,12 +330,12 @@ DEFINE_ASAN_SET_SHADOW(f8);
 
 void kasan_record_aux_stack(void *addr)
 {
-	struct page *page = kasan_addr_to_page(addr);
+	struct page *page = kasan_addr_to_head_page(addr);
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
 
-	if (is_kfence_address(addr) || !(page && PageSlab(compound_head(page))))
+	if (is_kfence_address(addr) || !(page && PageSlab(page)))
 		return;
 
 	cache = page->slab_cache;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8bf568a80eb8..fe39eeee6b59 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -249,7 +249,7 @@ bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
-struct page *kasan_addr_to_page(const void *addr);
+struct page *kasan_addr_to_head_page(const void *addr);
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7cdcf968f43f..405ecf3c9301 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -151,7 +151,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 	}
 }
 
-struct page *kasan_addr_to_page(const void *addr)
+struct page *kasan_addr_to_head_page(const void *addr)
 {
 	if ((addr >= (void *)PAGE_OFFSET) &&
 			(addr < high_memory))
@@ -251,12 +251,12 @@ static inline bool init_task_stack_addr(const void *addr)
 
 static void print_address_description(void *addr, u8 tag)
 {
-	struct page *page = kasan_addr_to_page(addr);
+	struct page *page = kasan_addr_to_head_page(addr);
 
 	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
-	if (page && PageSlab(compound_head(page))) {
+	if (page && PageSlab(page)) {
 		struct kmem_cache *cache = page->slab_cache;
 		void *object = nearest_obj(cache, page,	addr);
 
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 32f955d98e76..5ae9df06ed44 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -20,8 +20,8 @@ const char *kasan_get_bug_type(struct kasan_access_info *info)
 
 	tag = get_tag(info->access_addr);
 	addr = kasan_reset_tag(info->access_addr);
-	page = kasan_addr_to_page(addr);
-	if (page && PageSlab(compound_head(page))) {
+	page = kasan_addr_to_head_page(addr);
+	if (page && PageSlab(page)) {
 		cache = page->slab_cache;
 		object = nearest_obj(cache, page, (void *)addr);
 		alloc_meta = kasan_get_alloc_meta(cache, object);
-- 
2.32.0

