Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412A73F4CED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHWPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhHWO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BBE020010;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOj9dYIIVDFZxt/Gcx+iwVlCy1GuCZGDYbzU8ga/jJI=;
        b=CzJ8lklmbjeEqaQRcdgwReztsoQa4fgA41BE5wuHUezpbgkCsOEA1q8/6uoQA6PJAZmif+
        6vIZrTs89PXkIuuw1wwhycyLpnyMfRlTrxJCtNcUPT1y5ZCjdWk7ozPlqJaSh7KECm0ZH0
        uQbGUzaSCVDLfLNwjXb3wNyQ66GLE+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOj9dYIIVDFZxt/Gcx+iwVlCy1GuCZGDYbzU8ga/jJI=;
        b=/8SG6LYhJbdnACMvgSI9mEdV1WgLMAjwIwNrBoNqQAtuDxccD1sUN7qYzCjpnegmvR6Pe9
        cgBkuPxFvIDhJvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24A4513BE0;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cNprCKK3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:42 +0000
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
Subject: [PATCH v5 26/35] mm, slub: only disable irq with spin_lock in __unfreeze_partials()
Date:   Mon, 23 Aug 2021 16:58:17 +0200
Message-Id: <20210823145826.3857-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
index 5f57e36e93ef..fc09ec3563b4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2338,9 +2338,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 {
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
-	unsigned long flags;
-
-	local_irq_save(flags);
+	unsigned long flags = 0;
 
 	while (partial_page) {
 		struct page new;
@@ -2352,10 +2350,10 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
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
@@ -2384,9 +2382,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
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

