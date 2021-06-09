Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9365F3A12ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhFILll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CD57219DC;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoOHiL7Kvc+iNuZbvKQCtrRD3qZokJ4ArXlEsxyEuKw=;
        b=UJ0symXRAnt3IWMogw5ez7B8HoZD9xhnBulyzyFv4vHSMLWvwXCmlmOeEYQ8RSFLUIoh3Q
        yhq5azcwdMvLlfV1T6WsE9P1fc22ViVWkrx0oWQvDRtJw5mVzm4HbTBGkZqgOKY2T3ZS1s
        aSxcv8e0eSuEt8bhe5Uts2TkKx4od+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoOHiL7Kvc+iNuZbvKQCtrRD3qZokJ4ArXlEsxyEuKw=;
        b=NdAvi3bIF8OZl40iBlJF/XsvpwTRCUi1nP6B0ZSa0AjDiEltwOlRwE+ie1ErbtF8dL8fuG
        dfIrpcGEbKUPk8DQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1EBEF118DD;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoOHiL7Kvc+iNuZbvKQCtrRD3qZokJ4ArXlEsxyEuKw=;
        b=UJ0symXRAnt3IWMogw5ez7B8HoZD9xhnBulyzyFv4vHSMLWvwXCmlmOeEYQ8RSFLUIoh3Q
        yhq5azcwdMvLlfV1T6WsE9P1fc22ViVWkrx0oWQvDRtJw5mVzm4HbTBGkZqgOKY2T3ZS1s
        aSxcv8e0eSuEt8bhe5Uts2TkKx4od+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoOHiL7Kvc+iNuZbvKQCtrRD3qZokJ4ArXlEsxyEuKw=;
        b=NdAvi3bIF8OZl40iBlJF/XsvpwTRCUi1nP6B0ZSa0AjDiEltwOlRwE+ie1ErbtF8dL8fuG
        dfIrpcGEbKUPk8DQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id wJwKB3SowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:32 +0000
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
Subject: [RFC v2 04/34] mm, slub: don't disable irq for debug_check_no_locks_freed()
Date:   Wed,  9 Jun 2021 13:38:33 +0200
Message-Id: <20210609113903.1421-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In slab_free_hook() we disable irqs around the debug_check_no_locks_freed()
call, which is unnecessary, as irqs are already being disabled inside the call.
This seems to be leftover from the past where there were more calls inside the
irq disabled sections. Remove the irq disable/enable operations.

Mel noted:
> Looks like it was needed for kmemcheck which went away back in 4.15

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5a940bd3cebb..2953f6e43cae 100644
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

