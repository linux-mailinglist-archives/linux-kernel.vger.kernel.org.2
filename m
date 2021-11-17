Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67A453D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhKQBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhKQBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:02 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96842C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:04 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id bu11so915302qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c6QiLmlUMu6hFkhumiDKDZu9js//szVlq6n3JHPrLXw=;
        b=gIjr1uz2nVbaDDNbcv62cKz1i9XvxH04jiXTdDCvBqGXcLc4knHK9OjnoDrQHuxS8z
         mO+/DSlRG+NS++W56RiyimLq0cozRIQIgezQX0CeTVstntyldl0vA/aZgNx9MUqLnQzK
         KggjcvZrH5MaoPi8eOb3j+rQ8kcnWuCLV7Ked5QrGdU4n3KLAkngEp5nazAhPZPHVoIN
         3/qy+TQPMTA5XZIDx8yp/Rd2gcFC4SbReflwX3pDp5h/Kb+yuN+N7xYaZL9vHNfayklL
         PTk3voko7kwpmFyQo67xBHzdfPHXSy67+GatQ75WLkT2hk/ooG/Cw9H8sCtwy5ZxNrt8
         XDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6QiLmlUMu6hFkhumiDKDZu9js//szVlq6n3JHPrLXw=;
        b=5eZZ3WWLfJyZC/sUHyvkbm2VR4i/HWm+RGhY61tLsvAptcxaIp32sk79F/QBjSkuWG
         PJyFARzJH4CdaKZAsVIJiJr4V3N6gQiXcuX3OKiygYwCNat7+pvOuUJEZpBnfjeMPdxZ
         IWgwvzU1XOttWVjEVfoTN/w2ZUdzNd0fZTaKusUVLvHuwgzgUxhM48YhuTzFtM7VLHE8
         rctC7X0ugGka5/MQwAswORBblyDlxqTZSX3uwsgkx4loeV38zqc5m8/hg86HWV2L+DMc
         Npyamh2HXEFF0C6FMPGsJFiljMGACzCQqldIIY/Ui1Q77bj962pBlgGf6ei3YHbVQ0Cs
         Uu2g==
X-Gm-Message-State: AOAM533QDipEFewCvix3mogFalQ+ZUFpicfesBGdoM5rlW4MtkT+9ss7
        zh2E0kYnyC/y7xSplzTvveaTbQ==
X-Google-Smtp-Source: ABdhPJyUqxdH9AaEaZ1fMy/a8wtsdZJ2ntRkTjxZBs8VqrqlqOZuQSUqsp7eZN7bz5P3ZRcl2KkFFQ==
X-Received: by 2002:a05:6214:e66:: with SMTP id jz6mr43785108qvb.20.1637112063694;
        Tue, 16 Nov 2021 17:21:03 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:03 -0800 (PST)
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
Subject: [RFC v2 02/10] mm: add overflow and underflow checks for page->_refcount
Date:   Wed, 17 Nov 2021 01:20:51 +0000
Message-Id: <20211117012059.141450-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117012059.141450-1-pasha.tatashin@soleen.com>
References: <20211117012059.141450-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problems with page->_refcount are hard to debug, because usually
when they are detected, the damage has occurred a long time ago. Yet,
the problems with invalid page refcount may be catastrophic and lead to
memory corruptions.

Reduce the scope of when the _refcount problems manifest themselves by
adding checks for underflows and overflows into functions that modify
_refcount.

Use atomic_fetch_* functions to get the old values of the _refcount,
and use it to check for overflow/underflow.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 59 +++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 1903af5fb087..f3c61dc6344a 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -117,7 +117,10 @@ static inline void init_page_count(struct page *page)
 
 static inline void page_ref_add(struct page *page, int nr)
 {
-	atomic_add(nr, &page->_refcount);
+	int old_val = atomic_fetch_add(nr, &page->_refcount);
+	int new_val = old_val + nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, nr);
 }
@@ -129,7 +132,10 @@ static inline void folio_ref_add(struct folio *folio, int nr)
 
 static inline void page_ref_sub(struct page *page, int nr)
 {
-	atomic_sub(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -nr);
 }
@@ -141,11 +147,13 @@ static inline void folio_ref_sub(struct folio *folio, int nr)
 
 static inline int page_ref_sub_return(struct page *page, int nr)
 {
-	int ret = atomic_sub_return(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -nr, ret);
-	return ret;
+		__page_ref_mod_and_return(page, -nr, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_sub_return(struct folio *folio, int nr)
@@ -155,7 +163,10 @@ static inline int folio_ref_sub_return(struct folio *folio, int nr)
 
 static inline void page_ref_inc(struct page *page)
 {
-	atomic_inc(&page->_refcount);
+	int old_val = atomic_fetch_inc(&page->_refcount);
+	int new_val = old_val + 1;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, 1);
 }
@@ -167,7 +178,10 @@ static inline void folio_ref_inc(struct folio *folio)
 
 static inline void page_ref_dec(struct page *page)
 {
-	atomic_dec(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -1);
 }
@@ -179,8 +193,11 @@ static inline void folio_ref_dec(struct folio *folio)
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
-	int ret = atomic_sub_and_test(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
+	int ret = new_val == 0;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -nr, ret);
 	return ret;
@@ -193,11 +210,13 @@ static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
 
 static inline int page_ref_inc_return(struct page *page)
 {
-	int ret = atomic_inc_return(&page->_refcount);
+	int old_val = atomic_fetch_inc(&page->_refcount);
+	int new_val = old_val + 1;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, 1, ret);
-	return ret;
+		__page_ref_mod_and_return(page, 1, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_inc_return(struct folio *folio)
@@ -207,8 +226,11 @@ static inline int folio_ref_inc_return(struct folio *folio)
 
 static inline int page_ref_dec_and_test(struct page *page)
 {
-	int ret = atomic_dec_and_test(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
+	int ret = new_val == 0;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -1, ret);
 	return ret;
@@ -221,11 +243,13 @@ static inline int folio_ref_dec_and_test(struct folio *folio)
 
 static inline int page_ref_dec_return(struct page *page)
 {
-	int ret = atomic_dec_return(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -1, ret);
-	return ret;
+		__page_ref_mod_and_return(page, -1, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_dec_return(struct folio *folio)
@@ -235,8 +259,11 @@ static inline int folio_ref_dec_return(struct folio *folio)
 
 static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	bool ret = atomic_add_unless(&page->_refcount, nr, u);
+	int old_val = atomic_fetch_add_unless(&page->_refcount, nr, u);
+	int new_val = old_val + nr;
+	int ret = old_val != u;
 
+	VM_BUG_ON_PAGE(ret && (unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_add_unless))
 		__page_ref_add_unless(page, nr, u, ret);
 	return ret;
-- 
2.34.0.rc1.387.gb447b232ab-goog

