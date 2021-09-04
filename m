Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E03400AFB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbhIDKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:53:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59902 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351138AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 176812269F;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXXtQUpt+s21y+aXf3Lfke9xhArxmbVP1MBx9NrA+G4=;
        b=EJWqLj8c0M0IC2tME6FdUCWusxOL4ynR7llUMhYbugE9zdlNzdt9l5LvNx8X7zkgdPiVRs
        ouLoLvpZsiVWbhvrkZYnY4IKoyI5CnV6CMF/VvYW2PV7DkKHHTND7yGv+2CF2RLYWPiT7X
        kNlnYaPEKVeLQh8atpD8PxiFFBenAOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXXtQUpt+s21y+aXf3Lfke9xhArxmbVP1MBx9NrA+G4=;
        b=DC3qiUe3uRkEwh4Mb6bdlX+FrTAlhpqZ5GYNBFGZMg2qQQqVS9N9rkE/OtMjFZAS816nRy
        tEGHp7nfZw3bmACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3BAD13A2C;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +IzzNmRPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:12 +0000
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
Subject: [PATCH v6 21/33] mm, slub: move irq control into unfreeze_partials()
Date:   Sat,  4 Sep 2021 12:49:51 +0200
Message-Id: <20210904105003.11688-22-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; h=from:subject; bh=KkFM/bBAlZPKKs90R9QA+BXAm0w82nhYdh6z2WNGHns=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08790U8BrvrgoyAYQSbpj8zCYtLbEiWDjoZ/Uif r2IaOp2JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPOwAKCRDgIcpz8YmpEK18B/ 9PlC/xFu4tBBEX4KV/RM/FO7ZsUoXJe4tEJkDBWs2Du9N8kTgVCBeodPqqUZ1Q9wKPobVDUdoS/kQl /yxJqUKFHx+g7buJKuyBrki0dh8WtI9hfMXKlyPgJn8w4zqJiFr0pv1oNgYV7tn/XQxiTr1LNMYUh1 ZLKxedf6EgtgtG+nt9J8+VF9nORfyCgs4nP6wBHFe/uSHgQttuWFnSMYAgKf/60TpZZtcmUawPkyvK klouB+7v8rtcRwHFubNyNoLISHq3ojwOG7L2J7ZFYB+YSNm+BUUZN+ylcIWZDm09G7ti0Pg2gTcJ65 9azNw7915a2SEZnuoJ8aUkEFcooqSY
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unfreeze_partials() can be optimized so that it doesn't need irqs disabled for
the whole time. As the first step, move irq control into the function and
remove it from the put_cpu_partial() caller.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index cb12a077c61c..1c4bd45d66a1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2350,9 +2350,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 /*
  * Unfreeze all the cpu partial slabs.
  *
- * This function must be called with interrupts disabled
- * for the cpu using c (or some other guarantee must be there
- * to guarantee no concurrent accesses).
+ * This function must be called with preemption or migration
+ * disabled with c local to the cpu.
  */
 static void unfreeze_partials(struct kmem_cache *s,
 		struct kmem_cache_cpu *c)
@@ -2360,6 +2359,9 @@ static void unfreeze_partials(struct kmem_cache *s,
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	while ((page = slub_percpu_partial(c))) {
 		struct page new;
@@ -2412,6 +2414,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+
+	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
@@ -2439,14 +2443,11 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
 			if (drain && pobjects > slub_cpu_partial(s)) {
-				unsigned long flags;
 				/*
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				local_irq_save(flags);
 				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-				local_irq_restore(flags);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
-- 
2.33.0

