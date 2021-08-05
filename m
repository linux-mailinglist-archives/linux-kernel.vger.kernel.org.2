Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038863E17C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbhHEPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:21:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59128 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbhHEPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3BD11FE6B;
        Thu,  5 Aug 2021 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTsDSIorHtI/bRezBrdulDQrR5vC48QgDFFiQA8tLvI=;
        b=3JaHwK4hvn8kZijvccNuzHpUhUr6A8OrzNP/9YhEhV2mePIOzf2BGS1VNDb4MTDEu9hjLt
        LgonWKEWRfaGH06p3iwj9ujITvyu1YM2DZCcY4JMrA/SGnmHCEwbVUYgdT0Hm7G/6ROOiN
        20szfMxMdgUzSBfwK+z5k/4w6/7ymYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTsDSIorHtI/bRezBrdulDQrR5vC48QgDFFiQA8tLvI=;
        b=1OgaD/IaAqPOkdKXCXYFXhYYnwlN9B9rn7CkGZHZ9TciG2VICAIOpXZ10R6iKWw1OX+Xse
        k9OVrpNB2xmmPlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A661C13DA8;
        Thu,  5 Aug 2021 15:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gBX8J6QBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:04 +0000
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
Subject: [PATCH v4 04/35] mm, slub: don't disable irq for debug_check_no_locks_freed()
Date:   Thu,  5 Aug 2021 17:19:29 +0200
Message-Id: <20210805152000.12817-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
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
index e1889b26a889..4ac4ad021fca 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1588,20 +1588,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
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
2.32.0

