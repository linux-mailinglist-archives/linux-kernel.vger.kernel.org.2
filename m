Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77243B84B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhJZRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbhJZRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:40:53 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD0C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:29 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w8so14280565qts.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=amB34lO2XSg7TLKdijE9Lv8Nvadz5QaO2Wd8mVuWFPM=;
        b=UvkQGJH2xUki3bT8TP/u4V57Jx6YNVYOhlR8XwaZpYU/cLXky/a+Odx+QEHRAwKZP4
         5tYqZn2x2c5ykd+SfCswrBnOWsUHwScQRSclAnkFdKauHvPc8cXV75EtqNhxHJh3Ny3W
         S4u8E/0j9mKiuFwnUwWYcXrYRTeBBH7FDBt6kOs6nbtiGvYM6ImHoN7ldfieIWTYdpto
         /NTuu9yahMryb90AwSlKtEWgljomhEWbYV4oPPdWqDEzilTmSlUfS1wkPQeX0mzI9hJK
         VSHT9awQHLM4F3LDCBqavcVaebKl0cwF4q1bd6Xp7W5xDDtd7NyQmlbXOrG8KiagHBqH
         Nj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amB34lO2XSg7TLKdijE9Lv8Nvadz5QaO2Wd8mVuWFPM=;
        b=5PDJ2ineey+3rKPHh1mLFcyXI5D32LHX81dlzTUyc3Fr2IRVpKhnn03Aed17Yw3kty
         0MH/LG327cN24swNUH8zS464uYIiSkwsItfgQh2H45o8n9zM3G+fbQrMGJvQlP71I92X
         3loa8CeYkyIQrJY5sRYkfQxCULFPwq+2o06D1Q8v3lunK/hhipzokgMucBA8P/W5eVTf
         4DNrCxvMmSnz3QI9Cir+S4bPZmHrcQQVZ13y6Ts+oymdII94p6Na1Mz9tg4IAnzyHg50
         rNhboYkWmcX17opfI38UKYNQzd6ws9XR0vDUf8ZfJRPQpJjjSEHkrIxT7uhCQw9Nsu08
         8ARg==
X-Gm-Message-State: AOAM530aKEEGcxFqvdKaEzwuwO+IHnQO9xTTb1ZCxbn8kVGzpYO1N5Rc
        mkaqlD0qNLi0n7vKqlQeGYJiSg==
X-Google-Smtp-Source: ABdhPJyVeZK2MwFq2jYs4GVzJmbEbYXlrpRJehMXT5vxhwOW3NH+YWuXHJQV1KbM6WrKRXcAWA05mw==
X-Received: by 2002:ac8:584d:: with SMTP id h13mr26002147qth.41.1635269908771;
        Tue, 26 Oct 2021 10:38:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id bj37sm11001939qkb.49.2021.10.26.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:38:28 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: [RFC 4/8] mm: remove set_page_count() from page_frag_alloc_align
Date:   Tue, 26 Oct 2021 17:38:18 +0000
Message-Id: <20211026173822.502506-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026173822.502506-1-pasha.tatashin@soleen.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_count() unconditionally resets the value of _ref_count and that
is dangerous, as it is not programmatically verified. Instead we rely on
comments like: "OK, page count is 0, we can safely set it".

Add a new refcount function: page_ref_add_return() to return the new
refcount value after adding to it. Use the return value to verify that
the _ref_count was indeed what we expected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 13 +++++++++++++
 mm/page_alloc.c          |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index b3ec2b231fc7..db7ccb461c3e 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -88,6 +88,19 @@ static inline void init_page_count(struct page *page)
 	set_page_count(page, 1);
 }
 
+static inline int page_ref_add_return(struct page *page, int nr)
+{
+	int ret;
+
+	VM_BUG_ON(nr <= 0);
+	ret = atomic_add_return(nr, &page->_refcount);
+	VM_BUG_ON_PAGE(ret <= 0, page);
+
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, nr, ret);
+	return ret;
+}
+
 static inline void page_ref_add(struct page *page, int nr)
 {
 	int ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..6af4596bddc2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5510,6 +5510,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
+	int refcnt;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -5548,8 +5549,9 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 		/* if size can vary use size else just use PAGE_SIZE */
 		size = nc->size;
 #endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		/* page count is 0, set it to PAGE_FRAG_CACHE_MAX_SIZE + 1 */
+		refcnt = page_ref_add_return(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		VM_BUG_ON_PAGE(refcnt != PAGE_FRAG_CACHE_MAX_SIZE + 1, page);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-- 
2.33.0.1079.g6e70778dc9-goog

