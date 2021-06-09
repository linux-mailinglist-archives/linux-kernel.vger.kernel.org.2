Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BB3A130B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbhFILn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54870 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhFILld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:33 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBBAB219F0;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIsSOg2ibGFfBt24mwRJ/OtudI5KuCKn5sZ6lfdE+UY=;
        b=SAXljtSeuHX/AHMDvIbkcGQIAoE8DuboaCglNFU8aJf5EpSJzDrROkRuBnPLJy7vOhJ6gC
        sUb5CPMdHaJHJxg9Dsq6ASLRETL+axkYEZ3k8/WQy4WRnX8WdgEhGtk3Q6lLc+6jBIii5Q
        ImYH3mQlApaHg/KxsPLT110QSUOndMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIsSOg2ibGFfBt24mwRJ/OtudI5KuCKn5sZ6lfdE+UY=;
        b=CyW5d6D60EvIJEIiToc1ZOBwDgnQZJRRu1bZVUD3cI1+z8myUsHQ/SBge2sezlGaCXJHdJ
        kzPZ4ApGO9sHxeCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BD017118DD;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIsSOg2ibGFfBt24mwRJ/OtudI5KuCKn5sZ6lfdE+UY=;
        b=SAXljtSeuHX/AHMDvIbkcGQIAoE8DuboaCglNFU8aJf5EpSJzDrROkRuBnPLJy7vOhJ6gC
        sUb5CPMdHaJHJxg9Dsq6ASLRETL+axkYEZ3k8/WQy4WRnX8WdgEhGtk3Q6lLc+6jBIii5Q
        ImYH3mQlApaHg/KxsPLT110QSUOndMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIsSOg2ibGFfBt24mwRJ/OtudI5KuCKn5sZ6lfdE+UY=;
        b=CyW5d6D60EvIJEIiToc1ZOBwDgnQZJRRu1bZVUD3cI1+z8myUsHQ/SBge2sezlGaCXJHdJ
        kzPZ4ApGO9sHxeCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id CKiuLXmowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 32/34] mm, slub: make slab_lock() disable irqs with PREEMPT_RT
Date:   Wed,  9 Jun 2021 13:39:01 +0200
Message-Id: <20210609113903.1421-33-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 6721169f816d..12e966f07f19 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -374,12 +374,12 @@ __slab_unlock(struct page *page, unsigned long *flags, bool disable_irqs)
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
@@ -422,14 +422,19 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
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
2.31.1

