Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C823F4CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhHWPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:00:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60428 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhHWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A42A62000B;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfX3OJcpF9lgWvGTfESbjHgUsXzUh/4iljhPiE3BQOs=;
        b=GlmdbXPEdTL2v0QndCPAdwHYA1nZbkpRnlqF0yV4Kh7Wqk1bHzed01kpJXbKxxDYN45CKQ
        QSKGi3iVcy/XDr6E3QfmDHsvfnPgKkin10HGH8QXitBtjgfTceG03fRI0bjs416cgLkfdd
        otGFFWi3MkC54h9Z0oExfh2dQZ9ZJ2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfX3OJcpF9lgWvGTfESbjHgUsXzUh/4iljhPiE3BQOs=;
        b=52L3J+CBIg2qir5WbixNo6cvqeUsQErSmTJjDypkRpwhyTjTXqldsS8qVzmhl0I+NI6Lw9
        SwykgWqL/fNkw7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 781FD13BE1;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIbQHJ+3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:39 +0000
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
Subject: [PATCH v5 11/35] mm, slub: simplify kmem_cache_cpu and tid setup
Date:   Mon, 23 Aug 2021 16:58:02 +0200
Message-Id: <20210823145826.3857-12-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In slab_alloc_node() and do_slab_free() fastpaths we need to guarantee that
our kmem_cache_cpu pointer is from the same cpu as the tid value. Currently
that's done by reading the tid first using this_cpu_read(), then the
kmem_cache_cpu pointer and verifying we read the same tid using the pointer and
plain READ_ONCE().

This can be simplified to just fetching kmem_cache_cpu pointer and then reading
tid using the pointer. That guarantees they are from the same cpu. We don't
need to read the tid using this_cpu_read() because the value will be validated
by this_cpu_cmpxchg_double(), making sure we are on the correct cpu and the
freelist didn't change by anyone preempting us since reading the tid.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b13424444cae..1f65d75077ce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2868,15 +2868,14 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	 * reading from one cpu area. That does not matter as long
 	 * as we end up on the original cpu again when doing the cmpxchg.
 	 *
-	 * We should guarantee that tid and kmem_cache are retrieved on
-	 * the same cpu. It could be different if CONFIG_PREEMPTION so we need
-	 * to check if it is matched or not.
+	 * We must guarantee that tid and kmem_cache_cpu are retrieved on the
+	 * same cpu. We read first the kmem_cache_cpu pointer and use it to read
+	 * the tid. If we are preempted and switched to another cpu between the
+	 * two reads, it's OK as the two are still associated with the same cpu
+	 * and cmpxchg later will validate the cpu.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/*
 	 * Irqless object alloc/free algorithm used here depends on sequence
@@ -3150,11 +3149,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	 * data is retrieved via this pointer. If we are on the same cpu
 	 * during the cmpxchg then the free will succeed.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
-- 
2.32.0

