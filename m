Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F11400ADF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbhIDKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351037AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 094B320042;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKjA7zkK2CiQbcxckmj6PgA4IP+98uIsMfY09GmbqeY=;
        b=Ub8G6DjjBlfkUZvruB3E0xZAbPTLfniYqZgTDMuIsL7fWRgBgMeS4PtBsYgEd9BuqUO7/5
        +CKUTgr83ZtXodhDyGTWRT6RkO6qjehA+sTRu9QbBwWmQ0OPNiC8IgiCtVSWApppM65SWZ
        EBeigD9mB/h4iX16yfLvqgnJIA1QahE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKjA7zkK2CiQbcxckmj6PgA4IP+98uIsMfY09GmbqeY=;
        b=JxOTilqiqRzEvNls77I9hgHMMomSg/ByI6XF8u+gaUF9R7M1dEy8NNRniwW+lo4DvJpGCP
        36DXZkYg4SP/HsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0FF31348A;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MEA/MmFPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:09 +0000
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
Subject: [PATCH v6 04/33] mm, slub: don't disable irq for debug_check_no_locks_freed()
Date:   Sat,  4 Sep 2021 12:49:34 +0200
Message-Id: <20210904105003.11688-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; h=from:subject; bh=Vn7eJ9KAIZUTN+3Dx8m9mW+i4oc+6Mw3YYkJSqJhCjU=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08PgOrLSR+eZW5rSb1I27grjcg4iQU56SPcFqkq KfGE8WSJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPDwAKCRDgIcpz8YmpEAhKCA CWVTGnWCC2oYF/FiXhqxyhSflb1q6SrhG+lT0vwOkheMrNWQPDhOcPra7CpT4vPJmJxMJT8lG8AKY/ axMlGEg60GXL+e/GrPfaRKnRBecEgEDkQhw5RdzE4ISSkIFABdNRy2SzgPJ7Um1C9u8IQVNmxm4d9R vf+L9BZpTW4cIbLkSHpqrujwU/lHx1zHGui9Bfuiq2xyw2wi3wI3mEyNsSTgpykr0c0aoqysYcwM9c s14gQ/a3uZwVUj4ucC8+3cuK0LKKKSIXmjyHvI57yP1a+CkNTvSN0lHoD1xBPYpIpqR8ZxhzpPcysU 8BTWTSJI8ueyMiuFNIMC5rTd7D5aFQ
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index 4697280130f2..fee093db2bfd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1591,20 +1591,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
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
2.33.0

