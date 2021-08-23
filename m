Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9663F4CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhHWPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhHWO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDB1720004;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9Aax1xAX/lIZ7n9V7DeQp+Agrk+E4PnVKMelQniC1U=;
        b=2RPx+VvXIoxEVKn0tXJh2WFy7W1dV9eLwbIb36F3xZ/qdHtjkc/+1XBncqOrPKfslocZMW
        8l87TKxqiHkPInRgfVVyXpVcqGsVUyLxfBtl/ts5htS1uxRnWgj27C9hkIzOxObrNYqDh/
        9YqzzOS7Kz+ihdm1MhTPlUQK+hL4liQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9Aax1xAX/lIZ7n9V7DeQp+Agrk+E4PnVKMelQniC1U=;
        b=aWEdQNtklePCjM42r4NmJgl5K4OQb1p7YdsjUtS5s7Ymf0NK65f1dQFLRrio8VP0T85qYz
        3wbJ0SJz5LkDqkDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4E3B13BE0;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wMyJL6G3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:41 +0000
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
Subject: [PATCH v5 24/35] mm, slub: detach whole partial list at once in unfreeze_partials()
Date:   Mon, 23 Aug 2021 16:58:15 +0200
Message-Id: <20210823145826.3857-25-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating through the live percpu partial list, detach it from the
kmem_cache_cpu at once. This is simpler and will allow further optimization.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 240b22328212..d8bfc41dc1f0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2344,16 +2344,20 @@ static void unfreeze_partials(struct kmem_cache *s,
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct page *page, *discard_page = NULL;
+	struct page *page, *partial_page, *discard_page = NULL;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	while ((page = slub_percpu_partial(c))) {
+	partial_page = slub_percpu_partial(c);
+	c->partial = NULL;
+
+	while (partial_page) {
 		struct page new;
 		struct page old;
 
-		slub_set_percpu_partial(c, page);
+		page = partial_page;
+		partial_page = page->next;
 
 		n2 = get_node(s, page_to_nid(page));
 		if (n != n2) {
-- 
2.32.0

