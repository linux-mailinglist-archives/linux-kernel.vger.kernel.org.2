Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4D400AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhIDKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:53:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59828 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351154AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73405226A3;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ime3x2lj2MOgr3oHMSc5CXs9wlGouwatOfwI8ckMnLg=;
        b=l/h5S0Tzw82raud2Cto9UcG5h9t8KUOWUD2lDa2rL8Ty1Xa+g/EM6ZuP0aWDg85v4v+ryP
        DnzuxAw1XJuC+obJOOdhRw2wh/4HaiBaLsEpUd0WWUuO+O7w1XIxzkOpzDPztByFOGx9QY
        9hlWc97cTKR7ufc9X+T3WtOXzEwlMt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ime3x2lj2MOgr3oHMSc5CXs9wlGouwatOfwI8ckMnLg=;
        b=Y4fw0QTUZvGWMJNVmAxwsoRtl6qze+L6rdP/4a0hRauvr3LaE/9+ICKGwjgtQsWEsq2bzy
        EjhtxASnhczYEyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B0D413A2C;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SHu8EWZPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:14 +0000
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
Subject: [PATCH v6 29/33] mm: slub: make object_map_lock a raw_spinlock_t
Date:   Sat,  4 Sep 2021 12:49:59 +0200
Message-Id: <20210904105003.11688-30-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=vbabka@suse.cz; h=from:subject; bh=2/8u3UH5En3AyznTWqpc4cL+b7AuqqKzQa93bRzqE7A=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09Pf1VeinWtUFeSCTnH3nZhlj6Wr8HzOQ3KMWZ7 xmNb/bKJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPTwAKCRDgIcpz8YmpEPKfB/ 0TnPZL0UUrCRyKA60dWdmDV6d2u+fC/GWjzEF8xEjTExfmEVDS1nERDrZm+2LZLm6wcf7J5xAwr85/ F+KdZk7ratV3QSOQEGIbCa4umGO+Mt3C7bTuRe6Y755IzvcBq/IE5/UlzNZ1XXGp/iotTjEWkXoM/S Lcs6DbyK6mlRiPVKKHFXEGLQA10yJ347Sry1av6y8RektgBUBSvUL0conZ39EwzvkpieZG5NUs7bHq NET+bNFKes768IP7uri2+kMK8076o9EwZLV9L4EabGdJSHF40kqv73BXWgOpF8U79dpOLo5ALBjRD/ Pw3rL18n3jmAsJk8ARATI9xzMhNc/K
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index b7f8b9d34e46..76e56ce55d21 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -452,7 +452,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_SPINLOCK(object_map_lock);
+static DEFINE_RAW_SPINLOCK(object_map_lock);
 
 static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 		       struct page *page)
@@ -497,7 +497,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 {
 	VM_BUG_ON(!irqs_disabled());
 
-	spin_lock(&object_map_lock);
+	raw_spin_lock(&object_map_lock);
 
 	__fill_map(object_map, s, page);
 
@@ -507,7 +507,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 static void put_map(unsigned long *map) __releases(&object_map_lock)
 {
 	VM_BUG_ON(map != object_map);
-	spin_unlock(&object_map_lock);
+	raw_spin_unlock(&object_map_lock);
 }
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
-- 
2.33.0

