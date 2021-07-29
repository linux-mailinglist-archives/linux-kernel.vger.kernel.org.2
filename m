Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A213DA3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhG2NXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:23:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhG2NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51E7D223CE;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2azoHU0llGNdleUCDO+FUVB6LKtlo/CQvtZYYgr7n0=;
        b=nlMMFYkcDSjCg5wIpz5/hvs13e9BT2lHYHhKBxEA49e9oEJJ9+rO5fL5vdB3/Mj8KXiA6j
        U3l/MrmyD9icTM81yZh0sAbfs7Z32wf9Lmzdse5xxq87mzowDGBb73nSt9aZjpkkipWfyT
        f97/8ZUsB8//6JxW606fSBRM2nkDHGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2azoHU0llGNdleUCDO+FUVB6LKtlo/CQvtZYYgr7n0=;
        b=g0V9Hr+4NmiqPtz3EyAy7p+nPFhD7GN37mdIE910tLNjE88ZeTp5LY4VZlGfLUqXMd720e
        PnYWc9zlo050cXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 259D013AE9;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OJt+CGmrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:45 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 26/35] mm, slub: only disable irq with spin_lock in __unfreeze_partials()
Date:   Thu, 29 Jul 2021 15:21:23 +0200
Message-Id: <20210729132132.19691-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__unfreeze_partials() no longer needs to have irqs disabled, except for making
the spin_lock operations irq-safe, so convert the spin_locks operations and
remove the separate irq handling.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dba13cd8ca1c..2208be8af7a5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2335,9 +2335,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 {
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
-	unsigned long flags;
-
-	local_irq_save(flags);
+	unsigned long flags = 0;
 
 	while (partial_page) {
 		struct page new;
@@ -2349,10 +2347,10 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 		n2 = get_node(s, page_to_nid(page));
 		if (n != n2) {
 			if (n)
-				spin_unlock(&n->list_lock);
+				spin_unlock_irqrestore(&n->list_lock, flags);
 
 			n = n2;
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 
 		do {
@@ -2381,9 +2379,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 	}
 
 	if (n)
-		spin_unlock(&n->list_lock);
-
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 
 	while (discard_page) {
 		page = discard_page;
-- 
2.32.0

