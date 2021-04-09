Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95E35925D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhDIDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhDIDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:01:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34617C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=V3VRfrnkYj9HdoNk8dH+7FgliMSQTq2r/OIZmu9ntio=; b=Cx+xO01O/KuRiCTpgf3L/IesKS
        Xw2Hz1a/KEPVCiH7jZTx0ZhQSCdH26ugiMo7i0yanBQ5edfKIONrRIy0aKc31tVU2yNfJ+cYCeuYK
        eh7wDNkvnipcccO4JeXTpoT7wQDtPV3IKKR6OcR2H/GTtlfTYHeQVlvIC0bBc5V2j2ipoPv/aXtsx
        DwswymrTFz4ibiQzI2ohuWs5qJ/T1F/HbeWVy+Mt1LM07asXR7LfU1HjvafxDZjmcK5j/z99+yA67
        VNQtuGV8+1cJ0KnxgRG8h94zsvBEVWo9kidXwNdotywsJ6PiU8AsOY02NstBT7Ho4YmDpnkEm/xOv
        VWRA8g3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhN4-00HGxU-Q8; Fri, 09 Apr 2021 02:59:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] slub: Add slab_page_lock
Date:   Fri,  9 Apr 2021 03:51:28 +0100
Message-Id: <20210409025131.4114078-15-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track slub's page bit spin lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/slub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9c0e26ddf300..2ed2abe080ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -346,19 +346,21 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 	return x.x & OO_MASK;
 }
 
+static DEFINE_SPLIT_LOCK(slab_page_lock);
+
 /*
  * Per slab locking using the pagelock
  */
 static __always_inline void slab_lock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	bit_spin_lock(PG_locked, &page->flags);
+	bit_spin_lock(PG_locked, &page->flags, &slab_page_lock);
 }
 
 static __always_inline void slab_unlock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	__bit_spin_unlock(PG_locked, &page->flags);
+	__bit_spin_unlock(PG_locked, &page->flags, &slab_page_lock);
 }
 
 /* Interrupts must be disabled (for the fallback code to work right) */
-- 
2.30.2

