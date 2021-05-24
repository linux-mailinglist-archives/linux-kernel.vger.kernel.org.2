Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725638F668
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEXXoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:44:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhEXXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=op7fjoPtUEPr3ctFy+oe8fOC8FmEaHNINBmfV/1aXJA=;
        b=j5CrEwlsrJ97eI7Q/RnlCCVX0h2O6pGXZM2B5dR0ojnjGzy7U6d2dOldaQ8rJhxJsXpLqQ
        JXUGR2u3a1uTkaws8Q2smsz50395pxrSVcVaB/Lu2aq51gSuFkuhaU34tXe6xpwkpeYu1G
        5p8hrzf31ehPMkgSpetskqpAgVf4Mu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=op7fjoPtUEPr3ctFy+oe8fOC8FmEaHNINBmfV/1aXJA=;
        b=9AvNRWnIj2pXJNZYmJPqNKbMhCG+4woX0Bxur60VVtdBkzhuL50yg+ZedmgWqslu8IHFko
        Skfp93IfQ25rSTBg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C257CAF52;
        Mon, 24 May 2021 23:40:49 +0000 (UTC)
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
Subject: [RFC 24/26] mm, slub: don't disable irqs in slub_cpu_dead()
Date:   Tue, 25 May 2021 01:39:44 +0200
Message-Id: <20210524233946.20352-25-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
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
index aee83758bbc4..bfa5e7c4da1b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2515,14 +2515,10 @@ static void flush_all(struct kmem_cache *s)
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
2.31.1

