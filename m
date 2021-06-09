Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261CE3A1300
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhFILmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbhFILlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A74A1FD6D;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GjVus2UBVIbubovFl8dtg2IvpbcICqCbHPjVLJTVoM=;
        b=o04cHXUdiGCGIfGonPs5+wcwkDX3KOGSlylgZ92FJt2EYgD7mTURBu8qyVVHAsNEAOWE4V
        q6drLCxA1yHq6/mHC8Wc7O3Mq5HVmLcYrSj81I7/VxeSDHhFvL8Mw6wOOmtTTDtbZOIL3t
        wRZmDqZHGINPKmx251+9SDrtFPMn+AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GjVus2UBVIbubovFl8dtg2IvpbcICqCbHPjVLJTVoM=;
        b=dfQb9bfoXcUTIavFmii6oJq++Hz+Aiv806ScHsu2USbjV7fDeKJt559qCUdaPGWsXHtY8e
        gz/V/lU1wR5fqpBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1BE6D118DD;
        Wed,  9 Jun 2021 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GjVus2UBVIbubovFl8dtg2IvpbcICqCbHPjVLJTVoM=;
        b=o04cHXUdiGCGIfGonPs5+wcwkDX3KOGSlylgZ92FJt2EYgD7mTURBu8qyVVHAsNEAOWE4V
        q6drLCxA1yHq6/mHC8Wc7O3Mq5HVmLcYrSj81I7/VxeSDHhFvL8Mw6wOOmtTTDtbZOIL3t
        wRZmDqZHGINPKmx251+9SDrtFPMn+AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GjVus2UBVIbubovFl8dtg2IvpbcICqCbHPjVLJTVoM=;
        b=dfQb9bfoXcUTIavFmii6oJq++Hz+Aiv806ScHsu2USbjV7fDeKJt559qCUdaPGWsXHtY8e
        gz/V/lU1wR5fqpBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KDVWBniowGD6XgAALh3uQQ
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
Subject: [RFC v2 24/34] mm, slub: detach whole partial list at once in unfreeze_partials()
Date:   Wed,  9 Jun 2021 13:38:53 +0200
Message-Id: <20210609113903.1421-25-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index dcbc5baea702..3e0ec7211d55 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2298,16 +2298,20 @@ static void unfreeze_partials(struct kmem_cache *s,
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
2.31.1

