Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12E0362BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhDPXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhDPXRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:17:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/qqs9tp+kiyQL1m0mXkIuqlBljhf16wBFlxJh1VptKw=; b=Z8EtYV1GqOIkMgD7iPf3L8u+Nw
        JnuFNauyEgqd9NsaDMbyVbkUcfMwd169BGAgIWsNBncjVuVFdBd8uEnj/JR/MwksytXhO5PPVtaTw
        mAFs/j2EulB4QzhHB/NcdcsJp6OqPoqgB5YlsOuW2zF0fyXYGUQ/Yx1tEvvZeYkda5iVghGSR3jBj
        y5sLZ6jLU4SRx9p/TMjXnfahlQD4k/eoQsgDSgEqfjjbUsasLCXppuIhViW6sVFaQfBW9x5hi3Qve
        TnUM3Y5lrYpyWZby6QeTr4boNPxI9Nb5HrKPyBtuJymhnfxQrIkSX1Y9UVmgaVZgPhqGoGkU7Hd5o
        Wt4kEXHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXhL-00AZzb-4N; Fri, 16 Apr 2021 23:16:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: Make compound_head const-preserving
Date:   Sat, 17 Apr 2021 00:15:29 +0100
Message-Id: <20210416231531.2521383-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you pass a const pointer to compound_head(), you get a const pointer
back; if you pass a mutable pointer, you get a mutable pointer back.
Also remove an unnecessary forward definition of struct page; we're about
to dereference page->compound_head, so it must already have been defined.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..d8e26243db25 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -177,17 +177,17 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-struct page;	/* forward declaration */
-
-static inline struct page *compound_head(struct page *page)
+static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
 	if (unlikely(head & 1))
-		return (struct page *) (head - 1);
-	return page;
+		return head - 1;
+	return (unsigned long)page;
 }
 
+#define compound_head(page)	((typeof(page))_compound_head(page))
+
 static __always_inline int PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1;
-- 
2.30.2

