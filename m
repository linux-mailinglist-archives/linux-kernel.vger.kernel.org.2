Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06B3DA3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhG2NWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38294 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhG2NVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 071E6223CC;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZhF1PoKDcAHUg2BUQlLKxId7rBMVaNlF9MbtSxA/L0=;
        b=Wbuab2oWnt/xpz3SwxFERuyaXwpJPRwD9cdpr9jnWjgiod7OoAKJGkjVdNNgkZEDWgURfn
        PFY9nLc2xX5Bu+lq4lYmGEeANJNn7AVKi56KJg5gGX3Gnd9k9sel6BS95S3PDR7BMEQIR4
        /NaIcutAWzgjX2VyP+MGn8LsPR5NJ6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZhF1PoKDcAHUg2BUQlLKxId7rBMVaNlF9MbtSxA/L0=;
        b=nBf3DmjEKWtjYF17EmB+4BDkxG0b4gSbiYjBgVp1/mrm+ZCKsRhKkW7ZCzJLynTqj691pa
        myogqIEi78D7FPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA79D13AE9;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6DPMMGSrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:40 +0000
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
Subject: [PATCH v3 04/35] mm, slub: don't disable irq for debug_check_no_locks_freed()
Date:   Thu, 29 Jul 2021 15:21:01 +0200
Message-Id: <20210729132132.19691-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index 743c6b7f8bb1..0f08b64e2fd1 100644
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

