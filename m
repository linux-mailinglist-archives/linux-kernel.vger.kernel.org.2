Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049353F4CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhHWPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhHWO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DB6A20013;
        Mon, 23 Aug 2021 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9e/Xiex0v+TPJ++MWCMDN5rlEgM+k3ntuRiZj75LWVs=;
        b=2IBQ1XKQhkGHLfig8GFt9AwfPoPzbdhWMUso1IiWOdl08AqDAndqVrtIBICdGAPGCJdwFi
        64Muk3wTjjvBnwB3vXiDd5s41xKpj7L3PpBFAEBbDDDj5A5pGhbe43hic9y1z7rUQ5UIVD
        mhxQSJ4hC7y/EBMxiTGzTl8MyQo4LFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730723;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9e/Xiex0v+TPJ++MWCMDN5rlEgM+k3ntuRiZj75LWVs=;
        b=AaImNEzUdBtFAkiAX1egEJcUlkHTrJHYjZ4RAXxGcBl6EJUsofnHcuFqlYgKS11FrCnbQv
        nqLS3e/xdtcP1jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3378C13BE0;
        Mon, 23 Aug 2021 14:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yKb4C6O3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:43 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 32/35] mm, slub: make slab_lock() disable irqs with PREEMPT_RT
Date:   Mon, 23 Aug 2021 16:58:23 +0200
Message-Id: <20210823145826.3857-33-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to disable irqs around slab_lock() (a bit spinlock) to make it
irq-safe. The calls to slab_lock() are nested under spin_lock_irqsave() which
doesn't disable irqs on PREEMPT_RT, so add explicit disabling with PREEMPT_RT.

We also distinguish cmpxchg_double_slab() where we do the disabling explicitly
and __cmpxchg_double_slab() for contexts with already disabled irqs.  However
these context are also typically spin_lock_irqsave() thus insufficient on
PREEMPT_RT. Thus, change __cmpxchg_double_slab() to be same as
cmpxchg_double_slab() on PREEMPT_RT.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 59722a4bb546..3286defe4857 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -380,12 +380,12 @@ __slab_unlock(struct page *page, unsigned long *flags, bool disable_irqs)
 static __always_inline void
 slab_lock(struct page *page, unsigned long *flags)
 {
-	__slab_lock(page, flags, false);
+	__slab_lock(page, flags, IS_ENABLED(CONFIG_PREEMPT_RT));
 }
 
 static __always_inline void slab_unlock(struct page *page, unsigned long *flags)
 {
-	__slab_unlock(page, flags, false);
+	__slab_unlock(page, flags, IS_ENABLED(CONFIG_PREEMPT_RT));
 }
 
 static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
@@ -429,14 +429,19 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
 	return false;
 }
 
-/* Interrupts must be disabled (for the fallback code to work right) */
+/*
+ * Interrupts must be disabled (for the fallback code to work right), typically
+ * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
+ * so we disable interrupts explicitly here.
+ */
 static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
 	return ___cmpxchg_double_slab(s, page, freelist_old, counters_old,
-				      freelist_new, counters_new, n, false);
+				      freelist_new, counters_new, n,
+				      IS_ENABLED(CONFIG_PREEMPT_RT));
 }
 
 static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
-- 
2.32.0

