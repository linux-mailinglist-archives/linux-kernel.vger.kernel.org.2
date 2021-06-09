Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB33A12FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhFILmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbhFILlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE7951FD6C;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4H+O6ZFlXECn/j2lYWRNSXW+SmHmqvp1ZhSwxPI3Jw=;
        b=ZC9wIZSPPZ24y4U1q5vUZfHTz84l/8N5U2Ax2XOLWhjYGtaJQLC8erCQhKhO+QauwuWH5w
        dln/ljCmlVZERrlh3Pw8i2+UfrYvQzzzsCObf2uojkNZzWWAjsbFlK39FEVTjQ34JO7mXf
        bu7c3GDxUmrgXbc1O8QT+I4ocoJH/IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4H+O6ZFlXECn/j2lYWRNSXW+SmHmqvp1ZhSwxPI3Jw=;
        b=Ts2r0o78WKFso4GH8IJlkQM6/kQ01FT+XM3VFmg/VZ9SnbTug3DsK+Zog+T4ooO85T2DMh
        /SS6Ce2bcXUHYqCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AD014118DD;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4H+O6ZFlXECn/j2lYWRNSXW+SmHmqvp1ZhSwxPI3Jw=;
        b=ZC9wIZSPPZ24y4U1q5vUZfHTz84l/8N5U2Ax2XOLWhjYGtaJQLC8erCQhKhO+QauwuWH5w
        dln/ljCmlVZERrlh3Pw8i2+UfrYvQzzzsCObf2uojkNZzWWAjsbFlK39FEVTjQ34JO7mXf
        bu7c3GDxUmrgXbc1O8QT+I4ocoJH/IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4H+O6ZFlXECn/j2lYWRNSXW+SmHmqvp1ZhSwxPI3Jw=;
        b=Ts2r0o78WKFso4GH8IJlkQM6/kQ01FT+XM3VFmg/VZ9SnbTug3DsK+Zog+T4ooO85T2DMh
        /SS6Ce2bcXUHYqCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id yNy4KXeowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:35 +0000
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
Subject: [RFC v2 22/34] mm, slub: move irq control into unfreeze_partials()
Date:   Wed,  9 Jun 2021 13:38:51 +0200
Message-Id: <20210609113903.1421-23-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unfreeze_partials() can be optimized so that it doesn't need irqs disabled for
the whole time. As the first step, move irq control into the function and
remove it from the put_cpu_partial() caller.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a99a254f2410..4a3cd8174cd2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2290,9 +2290,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 /*
  * Unfreeze all the cpu partial slabs.
  *
- * This function must be called with interrupts disabled
- * for the cpu using c (or some other guarantee must be there
- * to guarantee no concurrent accesses).
+ * This function must be called with preemption or migration
+ * disabled with c local to the cpu.
  */
 static void unfreeze_partials(struct kmem_cache *s,
 		struct kmem_cache_cpu *c)
@@ -2300,6 +2299,9 @@ static void unfreeze_partials(struct kmem_cache *s,
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	while ((page = slub_percpu_partial(c))) {
 		struct page new;
@@ -2352,6 +2354,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+
+	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
@@ -2379,14 +2383,11 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
 			if (drain && pobjects > slub_cpu_partial(s)) {
-				unsigned long flags;
 				/*
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				local_irq_save(flags);
 				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-				local_irq_restore(flags);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
-- 
2.31.1

