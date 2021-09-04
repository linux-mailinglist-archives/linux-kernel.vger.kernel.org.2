Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E0400AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351320AbhIDKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351137AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C09CC2004B;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLZjps6qsHnkQd8MKKPHUpdM48DhlTXIcN04wp1onHo=;
        b=lWYuxDojkyLvbHEdbjFSfsoVFd1BtlY4ARpUFx9Sj3vBZsNl/DxQbBQpsMfLqRsl60duLg
        wu1FeHAFZ8o5HpuIHOw5glweMhtjL37F20v0CajjftfFt8H1yX1u6oWLWThOiQWADYfVfG
        ArzLF2m3PGaHHYFjoqCIF/aANO0BxAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLZjps6qsHnkQd8MKKPHUpdM48DhlTXIcN04wp1onHo=;
        b=p113BWTzRY4Dt/cTSKH3YGeg9myD/A9rgXxfuQ/5QMo5Bh3jQ1nr0shllJWP8sSQc4O5bz
        z+6qglECztsJl4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973B013A2C;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SIdIJGVPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:13 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 25/33] mm, slub: only disable irq with spin_lock in __unfreeze_partials()
Date:   Sat,  4 Sep 2021 12:49:55 +0200
Message-Id: <20210904105003.11688-26-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; h=from:subject; bh=J6MiPgyr3U7UknxlUI6wxC6xKvFmM74NQO//TSdXAaQ=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09FFtb3tbRk/8aA6Az37s6mztYCdW9au+0O5nVb mGOuX9KJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPRQAKCRDgIcpz8YmpEH+ICA Cs8VLTCfStKj6o3WzCKTScuQDEYA6oOlVtj9XOCRC6qsikU1epWQ7sojAVQFo4GPZtf06/aCfzkXzN hjSA+YUbnZPENv/j3HRL7I0Q6T1gbm5thGDm3O86foORzhIlEx6Z+DK5tG9Ujd7oyK8P6eUKn1ukqr hfrZ3+bnxzwnKFL+taupueiL2osARWHX8Ne89qumnuNi72EIdc3OhcYL3kNsbM18X+BB6yLdFhWXBW LyXizUkbo8Stlokk/zeb4lvCzZmsDXWi706l4cL8psPrx2PPxBVZjDFS5psMMUkAqL2U8cts6uZEJd 2L3D2Qrc/4F3wmFtUZG7H20ejrJL+q
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index 9b46d9b9c879..c5766e504e73 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2352,9 +2352,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 {
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
-	unsigned long flags;
-
-	local_irq_save(flags);
+	unsigned long flags = 0;
 
 	while (partial_page) {
 		struct page new;
@@ -2366,10 +2364,10 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
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
@@ -2398,9 +2396,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 	}
 
 	if (n)
-		spin_unlock(&n->list_lock);
-
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 
 	while (discard_page) {
 		page = discard_page;
-- 
2.33.0

