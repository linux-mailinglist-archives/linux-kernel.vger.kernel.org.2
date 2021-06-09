Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F83A12F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhFILmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54710 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbhFILla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB664219E6;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMqHwk78Ooa/tKgDwDLFTYj62DqSJ+/+iH5D+PQaTw=;
        b=xNml2b/xZFeXKSMw0bboB495jc9H0LIgaPrTmQ9wZF7BL6+w/h/ygalY3Wp7yJNfhg0Rp9
        /G25JBQFDmIoLqMT1lYUlmtnvPoKOYrIOyA+3ecwHSqOI3OBYztII5j0U1u7b2F3R5fA/9
        2gi40po9/AlLuEJT4DTgFLOsCnL3pps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMqHwk78Ooa/tKgDwDLFTYj62DqSJ+/+iH5D+PQaTw=;
        b=aRLQO7bhseIQlT/OaIBIyWHymfr1355G1zpwuBu8to6DqC5r/TZte6vvrjL93BAKyBoCjs
        ZJcw9FQY0eSgBBAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7C72F11A98;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMqHwk78Ooa/tKgDwDLFTYj62DqSJ+/+iH5D+PQaTw=;
        b=xNml2b/xZFeXKSMw0bboB495jc9H0LIgaPrTmQ9wZF7BL6+w/h/ygalY3Wp7yJNfhg0Rp9
        /G25JBQFDmIoLqMT1lYUlmtnvPoKOYrIOyA+3ecwHSqOI3OBYztII5j0U1u7b2F3R5fA/9
        2gi40po9/AlLuEJT4DTgFLOsCnL3pps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMqHwk78Ooa/tKgDwDLFTYj62DqSJ+/+iH5D+PQaTw=;
        b=aRLQO7bhseIQlT/OaIBIyWHymfr1355G1zpwuBu8to6DqC5r/TZte6vvrjL93BAKyBoCjs
        ZJcw9FQY0eSgBBAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kDrlHXeowGD6XgAALh3uQQ
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
Subject: [RFC v2 21/34] mm, slub: call deactivate_slab() without disabling irqs
Date:   Wed,  9 Jun 2021 13:38:50 +0200
Message-Id: <20210609113903.1421-22-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is now safe to be called with irqs enabled, so move the calls
outside of irq disabled sections.

When called from ___slab_alloc() -> flush_slab() we have irqs disabled, so to
reenable them before deactivate_slab() we need to open-code flush_slab() in
___slab_alloc() and reenable irqs after modifying the kmem_cache_cpu fields.
But that means a IRQ handler meanwhile might have assigned a new page to
kmem_cache_cpu.page so we have to retry the whole check.

The remaining callers of flush_slab() are the IPI handler which has disabled
irqs anyway, and slub_cpu_dead() which will be dealt with in the following
patch.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bba18146def6..a99a254f2410 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2706,8 +2706,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	freelist = c->freelist;
 	c->page = NULL;
 	c->freelist = NULL;
-	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
+	deactivate_slab(s, page, freelist);
 
 new_slab:
 
@@ -2775,18 +2775,32 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+retry_load_page:
+
 	local_irq_save(flags);
-	if (unlikely(c->page))
-		flush_slab(s, c);
+	if (unlikely(c->page)) {
+		void *flush_freelist = c->freelist;
+		struct page *flush_page = c->page;
+
+		c->page = NULL;
+		c->freelist = NULL;
+		c->tid = next_tid(c->tid);
+
+		local_irq_restore(flags);
+
+		deactivate_slab(s, flush_page, flush_freelist);
+
+		stat(s, CPUSLAB_FLUSH);
+
+		goto retry_load_page;
+	}
 	c->page = page;
 
 	goto load_freelist;
 
 return_single:
 
-	local_irq_save(flags);
 	deactivate_slab(s, page, get_freepointer(s, freelist));
-	local_irq_restore(flags);
 	return freelist;
 }
 
-- 
2.31.1

