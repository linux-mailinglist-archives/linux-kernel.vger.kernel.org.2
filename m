Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76F453D99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhKQBYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhKQBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:05 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF1C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:07 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo22so829521qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=itHiYOWCJUb0nrp2FwmrOfYUVUksojP1AIObWh9UO1s=;
        b=Amxwjgr/bi/cfwPexyIKSzy+cWQQa/FPLHp93s1kSUq0trv4NSPC1wYWiQsx6H6dod
         osfcMRXdqSomprDLvNprMq2ZO2tfPAs6GYlmnCTVq2MtJ0iOq3gwL+h8XCvJczhjYvDf
         tAxz/DpFCDrWKaB/61E83dSASNK8NuApouoburnZs8adqi0b+LV/BNqEuvRHPbtkdsT6
         nmTvRuC1eD0VC1m+saF2HfeCjbkaA3XJfWGslibsaaLCebExLQNcTBNNVo74MI6/da2r
         IALeDG9/ImWlbzeMm68HZHcuVx8M40TSq6V4CNxISpzdhadHVF2tEAjmIo7+/QEF6Rdz
         Ybnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itHiYOWCJUb0nrp2FwmrOfYUVUksojP1AIObWh9UO1s=;
        b=PwgXwgqJra+xqSXNc1qMSMg1NQmIptjX2KIRwJmz3Ay+xKYY4ARYa3yPqXDG0qHvux
         7hto/w7kckkwDZSQJOo6or6h5tCf86wGzS2NpvzqEKd9h9I3C37yBbfn+ISA4U+mWfTH
         ZzsqbMsX8Iz9hanHQft3IQzAxu5QepV8XNVnpK8PUtlrCOYpuFFjzgc6L4TcnMPgyogP
         4peQnNWMCk60+s5gBx2TT10bWvb4jDY6eDKgTOvrVTR/lVmsD67FG4ev7iCWXDj/ZA0x
         8K+9N85Blqky2gJLE0V1fLybieQvJfk9CSugeZfrihIdozKe30yTUACzdi12EQdxUAAB
         YPrA==
X-Gm-Message-State: AOAM530pGAbmqgtGPOIEzzm3clOE/X0udFSVAXWI/xoS4AV02adYqEc0
        YBTa687vUxw28MqVmLCPRNgjmA==
X-Google-Smtp-Source: ABdhPJzmFAbbdMELzTH4m6zNqKMVAm1xIDyKURFrCR6PoeYAmy5SHEKE8sKURnOBTW/Ye7sxdr9bjg==
X-Received: by 2002:a05:6214:29c3:: with SMTP id gh3mr23597620qvb.30.1637112066871;
        Tue, 16 Nov 2021 17:21:06 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:06 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [RFC v2 06/10] mm: rename init_page_count() -> page_ref_init()
Date:   Wed, 17 Nov 2021 01:20:55 +0000
Message-Id: <20211117012059.141450-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that set_page_count() is not called from outside anymore and about
to be removed, init_page_count() is the only function that is going to
be used to unconditionally set _refcount, however it is restricted to set
it only to 1.

Make init_page_count() aligned with the other page_ref_*
functions by renaming it.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/motorola.c  |  2 +-
 include/linux/mm.h       |  2 +-
 include/linux/page_ref.h | 10 +++++++---
 mm/page_alloc.c          |  2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 2b05bb2bac00..e81ecafedff3 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -133,7 +133,7 @@ void __init init_pointer_table(void *table, int type)
 
 	/* unreserve the page so it's possible to free that page */
 	__ClearPageReserved(PD_PAGE(dp));
-	init_page_count(PD_PAGE(dp));
+	page_ref_init(PD_PAGE(dp));
 
 	return;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..736bf16e7104 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2506,7 +2506,7 @@ extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 static inline void free_reserved_page(struct page *page)
 {
 	ClearPageReserved(page);
-	init_page_count(page);
+	page_ref_init(page);
 	__free_page(page);
 	adjust_managed_page_count(page, 1);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 27880aca2e2f..ff946d753df8 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -107,10 +107,14 @@ static inline void folio_set_count(struct folio *folio, int v)
 }
 
 /*
- * Setup the page count before being freed into the page allocator for
- * the first time (boot or memory hotplug)
+ * Setup the page refcount to one before being freed into the page allocator.
+ * The memory might not be initialized and therefore there cannot be any
+ * assumptions about the current value of page->_refcount. This call should be
+ * done during boot when memory is being initialized, during memory hotplug
+ * when new memory is added, or when a previous reserved memory is unreserved
+ * this is the first time kernel take control of the given memory.
  */
-static inline void init_page_count(struct page *page)
+static inline void page_ref_init(struct page *page)
 {
 	set_page_count(page, 1);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 217c0c9fa25b..fc828dfde4fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1555,7 +1555,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 {
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
-	init_page_count(page);
+	page_ref_init(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
-- 
2.34.0.rc1.387.gb447b232ab-goog

