Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A963A1308
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhFILnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbhFILlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A313219EE;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JMzciOjrM3f4PogJGc8S9HpllJu3Zah47/BJwa+Z4I=;
        b=HYimdiD0q/CIzWg6N9+ODMNUwd1vmK+xrYk38BNgyoP2eyp47gLB4RUh4/zYQD6PlFUxA5
        LesyH/UW9lDttTY/jfpkBfcrWgskHewsYMPdpsNFOwWXZhmbK+9pBhc7JeD8meX6A5lLcA
        JSK8Xngjf3KQesVaKqF7iL7BWvNBKQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JMzciOjrM3f4PogJGc8S9HpllJu3Zah47/BJwa+Z4I=;
        b=TikwQrejxZogM6sx8B9yhQLZFAqtzGFd6WvhKx8ugT1es4FCY/FZ93O8YnSXGrvUHti8CX
        1DZ8SCb1IKNlXhCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5902A118DD;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JMzciOjrM3f4PogJGc8S9HpllJu3Zah47/BJwa+Z4I=;
        b=HYimdiD0q/CIzWg6N9+ODMNUwd1vmK+xrYk38BNgyoP2eyp47gLB4RUh4/zYQD6PlFUxA5
        LesyH/UW9lDttTY/jfpkBfcrWgskHewsYMPdpsNFOwWXZhmbK+9pBhc7JeD8meX6A5lLcA
        JSK8Xngjf3KQesVaKqF7iL7BWvNBKQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JMzciOjrM3f4PogJGc8S9HpllJu3Zah47/BJwa+Z4I=;
        b=TikwQrejxZogM6sx8B9yhQLZFAqtzGFd6WvhKx8ugT1es4FCY/FZ93O8YnSXGrvUHti8CX
        1DZ8SCb1IKNlXhCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 8GQ7FXmowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:37 +0000
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
Subject: [RFC v2 30/34] mm: slub: Make object_map_lock a raw_spinlock_t
Date:   Wed,  9 Jun 2021 13:38:59 +0200
Message-Id: <20210609113903.1421-31-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 6e747e0d7dcd..cfd5a7660375 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -432,7 +432,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_SPINLOCK(object_map_lock);
+static DEFINE_RAW_SPINLOCK(object_map_lock);
 
 static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 		       struct page *page)
@@ -457,7 +457,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 {
 	VM_BUG_ON(!irqs_disabled());
 
-	spin_lock(&object_map_lock);
+	raw_spin_lock(&object_map_lock);
 
 	__fill_map(object_map, s, page);
 
@@ -467,7 +467,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 static void put_map(unsigned long *map) __releases(&object_map_lock)
 {
 	VM_BUG_ON(map != object_map);
-	spin_unlock(&object_map_lock);
+	raw_spin_unlock(&object_map_lock);
 }
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
-- 
2.31.1

