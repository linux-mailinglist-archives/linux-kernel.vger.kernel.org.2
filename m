Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7740D79B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIPKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbhIPKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:43:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114C7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jRgfonC5L8Exw5nctbhCYQZiAxmOo4AgrBv5+sphGzg=; b=NwZHjarP7QJKUupGM1W+XL4ziw
        K2RIaRzj/GCTicJKzcoMdGcGDPOJC+vfUwdqaRyzBkJRr5DZEFS4HtPCTYkNr0rfbKj3j8Qiyjckw
        XMuzj2iOO+X4ugeBgEqDS7Jmq9HrPBNRNYvuhyVxUNZtSbOerDBluwcU+kxCbMaPQISjZpCnP9jzH
        4ExIl66QuAM1Gr46y7UFL3I1uhg4j9jbisn6PnWJiQVdupzenDVwH7Pt7bZNDUgokaKe9+FIRCol8
        9lcbY97k/nlpR85tnIhoTqexIqx6u7LFH2EO9S9BCYF10Ke1uxiyx3BYl71e8bSw0vd6EgYwiChPs
        fyHwIxig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQoq6-003dAr-Aw; Thu, 16 Sep 2021 10:41:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33FCD300238;
        Thu, 16 Sep 2021 12:41:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB5092CCDF680; Thu, 16 Sep 2021 12:41:56 +0200 (CEST)
Date:   Thu, 16 Sep 2021 12:41:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>
Cc:     andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
        keescook@chromium.org
Subject: [PATCH] mm/vmalloc: Don't allow VM_NO_GUARD on vmap()
Message-ID: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The vmalloc guard pages are added on top of each allocation, thereby
isolating any two allocations from one another. The top guard of the
lower allocation is the bottom guard guard of the higher allocation
etc.

Therefore VM_NO_GUARD is dangerous; it breaks the basic premise of
isolating separate allocations.

There are only two in-tree users of this flag, neither of which use it
through the exported interface. Ensure it stays this way.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/vmalloc.h | 2 +-
 mm/vmalloc.c            | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 671d402c3778..10e9571ff0b2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -22,7 +22,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_USERMAP		0x00000008	/* suitable for remap_vmalloc_range */
 #define VM_DMA_COHERENT		0x00000010	/* dma_alloc_coherent */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
-#define VM_NO_GUARD		0x00000040      /* don't add guard page */
+#define VM_NO_GUARD		0x00000040      /* ***DANGEROUS*** don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..01927ebea267 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2743,6 +2743,13 @@ void *vmap(struct page **pages, unsigned int count,
 
 	might_sleep();
 
+	/*
+	 * Your top guard is someone else's bottom guard. Not having a top
+	 * guard compromises someone else's mappings too.
+	 */
+	if (WARN_ON_ONCE(flags & VM_NO_GUARD))
+		flags &= ~VM_NO_GUARD;
+
 	if (count > totalram_pages())
 		return NULL;
 
