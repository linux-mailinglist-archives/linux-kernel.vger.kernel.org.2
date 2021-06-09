Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5431C3A130F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhFILne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47170 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhFILld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:33 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B42731FD6F;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyVMd6JuJll2CSwZVtypUoJOKYt0RuiadUow3LJITGI=;
        b=K9O/gGfopsAbKUt5QoB/ur6B/XWNA+WamO+Tjd+gPPbho3pCYARNDp9aMd4AkxtiKpi5Ho
        CoP6+KqI4DpOC6prRlGDaOx+ewgETUeIN4lv3ZYe2ZIqpPY2egb93A7YJ8lCnw0e2zyEtZ
        Xgq9+5FFac3bkwvlt58AX11q59y1ni0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyVMd6JuJll2CSwZVtypUoJOKYt0RuiadUow3LJITGI=;
        b=sHNNiLfzjvpwDljIQ60meButSP0QmB0R/YE2ciWU7SwTf853LSAJMxDxQXgzVDIcjGgsML
        8xgYX5GqnfTakBCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 82B51118DD;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyVMd6JuJll2CSwZVtypUoJOKYt0RuiadUow3LJITGI=;
        b=K9O/gGfopsAbKUt5QoB/ur6B/XWNA+WamO+Tjd+gPPbho3pCYARNDp9aMd4AkxtiKpi5Ho
        CoP6+KqI4DpOC6prRlGDaOx+ewgETUeIN4lv3ZYe2ZIqpPY2egb93A7YJ8lCnw0e2zyEtZ
        Xgq9+5FFac3bkwvlt58AX11q59y1ni0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyVMd6JuJll2CSwZVtypUoJOKYt0RuiadUow3LJITGI=;
        b=sHNNiLfzjvpwDljIQ60meButSP0QmB0R/YE2ciWU7SwTf853LSAJMxDxQXgzVDIcjGgsML
        8xgYX5GqnfTakBCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gI9xH3iowGD6XgAALh3uQQ
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
Subject: [RFC v2 26/34] mm, slub: only disable irq with spin_lock in __unfreeze_partials()
Date:   Wed,  9 Jun 2021 13:38:55 +0200
Message-Id: <20210609113903.1421-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 0867801e3086..5a81189608e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2292,9 +2292,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 {
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
-	unsigned long flags;
-
-	local_irq_save(flags);
+	unsigned long flags = 0;
 
 	while (partial_page) {
 		struct page new;
@@ -2306,10 +2304,10 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
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
@@ -2338,9 +2336,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
 	}
 
 	if (n)
-		spin_unlock(&n->list_lock);
-
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 
 	while (discard_page) {
 		page = discard_page;
-- 
2.31.1

