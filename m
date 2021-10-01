Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82641E610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 04:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351606AbhJACod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 22:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJACob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 22:44:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5EC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9b7Y2D8y+bwLRWgPDl2sed9F2MPffsUsdfPD7nrHpcA=; b=L8hPFr3Z7+3SrGqtbww3txa5GZ
        u98C5rrfId8pWL+7SmgDI09ZodTyAVpx6TMAYILDJh1EHnsAcjLkMODKSzbqxHktWvEf29HQdtdqQ
        A/+7uexrV8VjYIo40pIZZymyEPiqx0vLCZCBvNJ0f+1Qwowno2VeD65ofDRzDc2dAFXmu3RFRJHe+
        gYrHtAA4lo/LPeNu9qLMqZG6mE6ZaB27LpfwqzLI14oR7QzB/AdHTR3k4OUpnOLzqIGRSQ9C5bZHN
        wLHAWE1y98zP1ZtFVieZ8QagKjQU9rINydtVJH1DcHEWEClYxlD+q1xtml70cw45RFCjKr4pj/GCO
        6ZAtNLbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW8U8-00DV2b-6j; Fri, 01 Oct 2021 02:41:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] kasan: Fix tag for large allocations when using CONFIG_SLAB
Date:   Fri,  1 Oct 2021 03:41:05 +0100
Message-Id: <20211001024105.3217339-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an object is allocated on a tail page of a multi-page slab, kasan
will get the wrong tag because page->s_mem is NULL for tail pages.
I'm not quite sure what the user-visible effect of this might be.

Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..41779ad109cd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,7 +298,7 @@ static inline u8 assign_tag(struct kmem_cache *cache,
 	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
 #ifdef CONFIG_SLAB
 	/* For SLAB assign tags based on the object index in the freelist. */
-	return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
+	return (u8)obj_to_index(cache, virt_to_head_page(object), (void *)object);
 #else
 	/*
 	 * For SLUB assign a random tag during slab creation, otherwise reuse
-- 
2.32.0

