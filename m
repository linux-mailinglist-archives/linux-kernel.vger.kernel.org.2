Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314CE3A1303
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhFILmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhFILlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 269E3219EB;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+kXFJUxiAt8nF/gFOeGLQ15QjX96rJgGO1xp0O5Hkw=;
        b=EZ1sKebsm1bY5kIaC7UF9DQ1G7UTyLUSr9XMyF5zYN+EANnQpxhQm1tfdWkXRzv30znYUQ
        e2SXselrS/jgk97AcPczw3+LhCZJhHsIaF93qGh7JBJZJviOst6a3gCaRPF+ca4dF6YusJ
        Uuo9uoa4l0+l44z3JCV12cZIzfG1Rbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+kXFJUxiAt8nF/gFOeGLQ15QjX96rJgGO1xp0O5Hkw=;
        b=43aWP7ErEcQ8m4WYdN2jnhMk19VRL9YgzR8Ujy/uFvzbExDd59EeIRYYvZPn/LjgCnkLnc
        htaDRTjM5wTNlBDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E6952118DD;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+kXFJUxiAt8nF/gFOeGLQ15QjX96rJgGO1xp0O5Hkw=;
        b=EZ1sKebsm1bY5kIaC7UF9DQ1G7UTyLUSr9XMyF5zYN+EANnQpxhQm1tfdWkXRzv30znYUQ
        e2SXselrS/jgk97AcPczw3+LhCZJhHsIaF93qGh7JBJZJviOst6a3gCaRPF+ca4dF6YusJ
        Uuo9uoa4l0+l44z3JCV12cZIzfG1Rbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+kXFJUxiAt8nF/gFOeGLQ15QjX96rJgGO1xp0O5Hkw=;
        b=43aWP7ErEcQ8m4WYdN2jnhMk19VRL9YgzR8Ujy/uFvzbExDd59EeIRYYvZPn/LjgCnkLnc
        htaDRTjM5wTNlBDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4CbVN3iowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:36 +0000
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
Subject: [RFC v2 28/34] mm, slab: make flush_slab() possible to call with irqs enabled
Date:   Wed,  9 Jun 2021 13:38:57 +0200
Message-Id: <20210609113903.1421-29-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently flush_slab() is always called with disabled IRQs if it's needed, but
the following patches will change that, so add a parameter to control IRQ
disabling within the function, which only protects the kmem_cache_cpu
manipulation and not the call to deactivate_slab() which doesn't need it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 12d35d6a6eaa..5c70fc17e9be 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2438,16 +2438,28 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      bool lock)
 {
-	void *freelist = c->freelist;
-	struct page *page = c->page;
+	unsigned long flags;
+	void *freelist;
+	struct page *page;
+
+	if (lock)
+		local_irq_save(flags);
+
+	freelist = c->freelist;
+	page = c->page;
 
 	c->page = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	deactivate_slab(s, page, freelist);
+	if (lock)
+		local_irq_restore(flags);
+
+	if (page)
+		deactivate_slab(s, page, freelist);
 
 	stat(s, CPUSLAB_FLUSH);
 }
@@ -2457,7 +2469,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials_cpu(s, c);
 }
@@ -2473,7 +2485,7 @@ static void flush_cpu_slab(void *d)
 	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials(s);
 }
-- 
2.31.1

