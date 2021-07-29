Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD63DA3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhG2NX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:23:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38450 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhG2NVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17961223E4;
        Thu, 29 Jul 2021 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Spnm0O6n64qhlr2XGPvA2PUtVAcdwbpZIioj6ZLdH58=;
        b=FhpC21ruGcT/IIFipPswb67TUkBPRFQKtDqt+2V1cqXwJHfTIsA0PAJdbjMTaHvp5xEwhO
        aY6EzGwLIVLmbfaocrGWjx5dq+iD9i1JqmoYuGLa1rI2GCzXM/YR0lPcEt0jug0wMy4dUJ
        YLzKT0YymdBo9KxBaZuq3W6axxP4X0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Spnm0O6n64qhlr2XGPvA2PUtVAcdwbpZIioj6ZLdH58=;
        b=+mZHWZCfs53I6rkudWs7kJsjE+ppto48K/GH4/OLzxwP9fpW+fkVHE4oQBRFslcreip6cR
        CEswKUxpUc2uC0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA0CB13AE9;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOWmNGmrAmF9AwAAMHmgww
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
Subject: [PATCH v3 30/35] mm: slub: Make object_map_lock a raw_spinlock_t
Date:   Thu, 29 Jul 2021 15:21:27 +0200
Message-Id: <20210729132132.19691-31-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index dbb74dbe1c1e..1ee3ef7a1d3b 100644
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

