Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220FB362BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhDPXSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhDPXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:18:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC438C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RXY5FTJ1nqvThpmAhIHHuvbXbki8r7wSKFoq944vSMQ=; b=Fupb4VUCIKlRD7f3HV4DpEpbaU
        JRDXCJkbxCbA9h7Vff8Wso3lFbjWxbjBq9PnaS0dLT7UNJ5Y6meOyzKl5QLSM0L0HWVPGJP3/p6Lz
        k6aR2EY1iPKYcrhjaequcIJxeQu+WXOzh9aqfg9/DCA+j2KEKLHiH4hP1SUfPBtDy1LNh35LyV3A8
        Y1kzXoZCm0XSb9lVHpJETqDKwfKP0pGzlcyh83qOX5Mq0UWH6ZlHOzkrt77mqEjyznINhU++SN6hZ
        In9fxqu5qoBVDZz5rVH/D3LJnw4KjEeIZPAQzFKBjkzn5vj4wQav+J5qUwgdQj2mSw9wXM/qZ9tqp
        UjCwhO/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXi7-00Aa34-SO; Fri, 16 Apr 2021 23:17:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: Constify page_count and page_ref_count
Date:   Sat, 17 Apr 2021 00:15:31 +0100
Message-Id: <20210416231531.2521383-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that compound_head() accepts a const struct page pointer, these two
functions can be marked as not modifying the page pointer they are passed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page_ref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index f3318f34fc54..7ad46f45df39 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -62,12 +62,12 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
 
 #endif
 
-static inline int page_ref_count(struct page *page)
+static inline int page_ref_count(const struct page *page)
 {
 	return atomic_read(&page->_refcount);
 }
 
-static inline int page_count(struct page *page)
+static inline int page_count(const struct page *page)
 {
 	return atomic_read(&compound_head(page)->_refcount);
 }
-- 
2.30.2

