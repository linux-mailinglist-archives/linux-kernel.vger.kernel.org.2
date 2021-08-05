Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56B3E17EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhHEPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbhHEPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C589C1FE6C;
        Thu,  5 Aug 2021 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FuCguIw3y1xLD9yHceZ5J55RGlWV/2iWhn/MaGBC+0=;
        b=bDrdzJtqn2NeXguHYpQPeyawckT9NFqHEqsUTafXcYCtQnISdN/R7E8ptmff1GxKbrOTzu
        aUugOzNmtjBKoMiVgsvdiPs+skCxQDTqLKW2nZakJ0fv50tkL3ghsB20AQlJ/L4UexWO9g
        2+RjMTEkN28tAsrn+F1JhVwtASaMR7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FuCguIw3y1xLD9yHceZ5J55RGlWV/2iWhn/MaGBC+0=;
        b=hk4BD/AuvOtCAaHSpbeeXav7yciHJ+gdfePS7DN6T76pCPGCKkbXBT7zb0rxqoW3r7IHFv
        DhDnLMme7ezSF8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 997B113DA8;
        Thu,  5 Aug 2021 15:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qCjnJKkBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:09 +0000
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
Subject: [PATCH v4 30/35] mm: slub: Make object_map_lock a raw_spinlock_t
Date:   Thu,  5 Aug 2021 17:19:55 +0200
Message-Id: <20210805152000.12817-31-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The variable object_map is protected by object_map_lock. The lock is always
acquired in debug code and within already atomic context

Make object_map_lock a raw_spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index da48ada3d17f..9cb58d884c58 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -438,7 +438,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_SPINLOCK(object_map_lock);
+static DEFINE_RAW_SPINLOCK(object_map_lock);
 
 static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 		       struct page *page)
@@ -483,7 +483,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 {
 	VM_BUG_ON(!irqs_disabled());
 
-	spin_lock(&object_map_lock);
+	raw_spin_lock(&object_map_lock);
 
 	__fill_map(object_map, s, page);
 
@@ -493,7 +493,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 static void put_map(unsigned long *map) __releases(&object_map_lock)
 {
 	VM_BUG_ON(map != object_map);
-	spin_unlock(&object_map_lock);
+	raw_spin_unlock(&object_map_lock);
 }
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
-- 
2.32.0

