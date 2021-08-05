Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C93E17ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbhHEPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbhHEPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A46EA20253;
        Thu,  5 Aug 2021 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaztH225Wn7qrJiwFTufe9ojID/dfd0YsuBujgpOdeQ=;
        b=iqKGhJ1ckj3UvmTddwiJk1o8SuN9grXseM10s++hLHfkDvyWec3nQnP0xRxMzIIE5phPbK
        bv5skJQNU6N0edlsmEvAiat6C9wgCWUEkKs/wP01NeqoAvndUD6C03+3sbmusczQmgpPEZ
        4wxu4Ox5KefM7LvjSi7DVngcuW5XhrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaztH225Wn7qrJiwFTufe9ojID/dfd0YsuBujgpOdeQ=;
        b=nTgTnNBM5Q+vqHUAoRPm6ZLNI6r7KsCKONIHpcbH8za0nM7+hjkmqZKb4BiZ/fhZFChk6t
        RPmPepuTLmWNx4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78E1F13DA8;
        Thu,  5 Aug 2021 15:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Cj5HKgBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:08 +0000
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
Subject: [PATCH v4 24/35] mm, slub: detach whole partial list at once in unfreeze_partials()
Date:   Thu,  5 Aug 2021 17:19:49 +0200
Message-Id: <20210805152000.12817-25-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
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
index 4d60bf482735..984173ce8465 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,16 +2341,20 @@ static void unfreeze_partials(struct kmem_cache *s,
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

