Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36038F64F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEXXmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhEXXmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUIAKZ/cgxKh9v7kIUfaOO2xqJqOf21U7OJe0EAXOps=;
        b=ukhJrKsVX0lO5Maa0Rqq3jECdBPh1ANWgBYUtl754UpwHolr/99XQKGcvV/+k0TvTDqcHT
        NRd06AldbjTjnu5dG24ssKarK6bn2C+es0ur+SqZvIPvyvFjobLvLigoOUThOFerEHcc3C
        fuFeBMz4Own93tjZDk4oGbPtVgpFNDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUIAKZ/cgxKh9v7kIUfaOO2xqJqOf21U7OJe0EAXOps=;
        b=6G9HUTbdlnVPSZDUCYmbJ+K4kG02YmmJg4J/xBsUigTbR84OJVUsk5/TqUvUBDJkG7w17k
        XSGO59Wwo9+SKhAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF4DCAF11;
        Mon, 24 May 2021 23:40:47 +0000 (UTC)
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
Subject: [RFC 03/26] mm, slub: don't disable irq for debug_check_no_locks_freed()
Date:   Tue, 25 May 2021 01:39:23 +0200
Message-Id: <20210524233946.20352-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In slab_free_hook() we disable irqs around the debug_check_no_locks_freed()
call, which is unnecessary, as irqs are already being disabled inside the call.
This seems to be leftover from the past where there were more calls inside the
irq disabled sections. Remove the irq disable/enable operations.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed0f2620b19b..83ad64c1d9da 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1545,20 +1545,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 {
 	kmemleak_free_recursive(x, s->flags);
 
-	/*
-	 * Trouble is that we may no longer disable interrupts in the fast path
-	 * So in order to make the debug calls that expect irqs to be
-	 * disabled we need to disable interrupts temporarily.
-	 */
-#ifdef CONFIG_LOCKDEP
-	{
-		unsigned long flags;
+	debug_check_no_locks_freed(x, s->object_size);
 
-		local_irq_save(flags);
-		debug_check_no_locks_freed(x, s->object_size);
-		local_irq_restore(flags);
-	}
-#endif
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
-- 
2.31.1

