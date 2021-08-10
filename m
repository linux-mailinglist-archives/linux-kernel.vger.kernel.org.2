Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4313E566C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhHJJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhHJJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:11:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780CC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:11:20 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:11:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NFXJfNn781XNNVDcY5kUpqlmjTmkBhNdsu8RS8eZUYc=;
        b=1guZWw5kFpOzLe9CgCu9Zwsqj8kUc41QwCHJy7YPmgJkMTTQFUXVf3IasaC4Se5BbCYzGX
        D3OwY8QES86guIIomKZTddoSUwy7kdfMY51JMbsLABiarGLNj7tE4K7/fsqHP+jeSOBCwf
        5hENPIU3kd4mgMRMI1b/ShTipJd1A2i9rGs6TOKmpnXa8aRN8DATvIg1IUpGekx9uNlFkH
        6qeh66Ufs4f9H81W0cw7BRtXSsbh6myBDpDphR579FJS/jgaEzjEdsHw+E7wLT+0J6K+kP
        Kj2ChoE5NPePQCFrwmmylAaPUpn2n1bvCr7rxT4Ty6Kxy3ZLaFtUYSlUH9Jiag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NFXJfNn781XNNVDcY5kUpqlmjTmkBhNdsu8RS8eZUYc=;
        b=SjgUvQGS5tPmr58XE+uym3eTZ1mRLA3KOSAEVet0dgwGUrkcbqHcfwf5AuGgRDJwBd6bhq
        /x1RrHLi6CdAGzCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] highmem: Don't disable preemption on RT in kmap_atomic()
Message-ID: <20210810091116.pocdmaatdcogvdso@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() disables preemption and pagefaults for historical
reasons. The conversion to kmap_local(), which only disables
migration, cannot be done wholesale because quite some call sites need
to be updated to accommodate with the changed semantics.

On PREEMPT_RT enabled kernels the kmap_atomic() semantics are
problematic due to the implicit disabling of preemption which makes it
impossible to acquire 'sleeping' spinlocks within the kmap atomic
sections.

PREEMPT_RT replaces the preempt_disable() with a migrate_disable() for
more than a decade. It could be argued that this is a justification to
do this unconditionally, but PREEMPT_RT covers only a limited number of
architectures and it disables some functionality which limits the
coverage further.

Limit the replacement to PREEMPT_RT for now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/highmem-internal.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 7902c7d8b55f9..4aa1031d3e4c3 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -90,7 +90,11 @@ static inline void __kunmap_local(void *vaddr)
 
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
-	preempt_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+
 	pagefault_disable();
 	return __kmap_local_page_prot(page, prot);
 }
@@ -102,7 +106,11 @@ static inline void *kmap_atomic(struct page *page)
 
 static inline void *kmap_atomic_pfn(unsigned long pfn)
 {
-	preempt_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+
 	pagefault_disable();
 	return __kmap_local_pfn_prot(pfn, kmap_prot);
 }
@@ -111,7 +119,10 @@ static inline void __kunmap_atomic(void *addr)
 {
 	kunmap_local_indexed(addr);
 	pagefault_enable();
-	preempt_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
 }
 
 unsigned int __nr_free_highpages(void);
@@ -179,7 +190,10 @@ static inline void __kunmap_local(void *addr)
 
 static inline void *kmap_atomic(struct page *page)
 {
-	preempt_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
 	pagefault_disable();
 	return page_address(page);
 }
@@ -200,7 +214,10 @@ static inline void __kunmap_atomic(void *addr)
 	kunmap_flush_on_unmap(addr);
 #endif
 	pagefault_enable();
-	preempt_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
 }
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
-- 
2.32.0

