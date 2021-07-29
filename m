Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704B63DA3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbhG2NXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:23:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhG2NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E5CC20046;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCRvNmYTXzwVx2zN3G7egJq3iEgZTeKmgY0mKHij5oY=;
        b=jV7ZmEth17/M0jQrh+A3WNaW9ChfaIrQUrO/4Z1haS8ob0g+g0R0e8jt9n140mXy+31Hqs
        SGMHI9npLyFBPFjh6WfBZ2ALRguFm6ogAq2dhkqEuC3raH6Gk+Vt4jv0wPTw7KSLklC+ki
        504SkYCDz7enr4kvbKRsXhQYfQykpj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCRvNmYTXzwVx2zN3G7egJq3iEgZTeKmgY0mKHij5oY=;
        b=CAgV1bKU//9vc7qkdskRfaxiWw1Wyac3ArroWBcyvPFJjintXsnANABjwW27P/FpMJK0jd
        4Ch0lIMvycOne7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5336013AF4;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aBekE2mrAmF9AwAAMHmgww
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
Subject: [PATCH v3 27/35] mm, slub: don't disable irqs in slub_cpu_dead()
Date:   Thu, 29 Jul 2021 15:21:24 +0200
Message-Id: <20210729132132.19691-28-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slub_cpu_dead() cleans up for an offlined cpu from another cpu and calls only
functions that are now irq safe, so we don't need to disable irqs anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2208be8af7a5..edda419ec260 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2537,14 +2537,10 @@ static void flush_all(struct kmem_cache *s)
 static int slub_cpu_dead(unsigned int cpu)
 {
 	struct kmem_cache *s;
-	unsigned long flags;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list) {
-		local_irq_save(flags);
+	list_for_each_entry(s, &slab_caches, list)
 		__flush_cpu_slab(s, cpu);
-		local_irq_restore(flags);
-	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
-- 
2.32.0

