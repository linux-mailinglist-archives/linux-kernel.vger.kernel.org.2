Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D33400AF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhIDKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4288E22683;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbwAVP1gRCr+Fegb8ErzK7CCg9eoi361RZEwCJgWDAE=;
        b=Lgk0gyGMjGP28untHwJScNULUtuUOxmd06IfHqo0JJYeEjsB13k9plDw0Xf7JzdAwKiqt7
        S3HFpF9/HiVZR1BHfN6cwGRnJXDs7gN0fg80j5hhzcYDNF5DndaVlYfQ6p0SoZ982IkalI
        Fua5UwSsspvYoUemIsIijDKW+7CiZog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbwAVP1gRCr+Fegb8ErzK7CCg9eoi361RZEwCJgWDAE=;
        b=2VZ1ADBE17+h0UlqHzEHIUrcjW9/WkJwDduICcn+ntZsPcdcptC+3gBefM9Jh8iqgQDWDE
        ecvQrzF/UG0P75AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19A801348A;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPmmBWVPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:13 +0000
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
Subject: [PATCH v6 22/33] mm, slub: discard slabs in unfreeze_partials() without irqs disabled
Date:   Sat,  4 Sep 2021 12:49:52 +0200
Message-Id: <20210904105003.11688-23-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; h=from:subject; bh=qMOksVc/ZBsogN3BJEaa8Rh+CsPdbzIGLdMT/tX9B4c=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08+UFzmEo89ZxUCUT/1qc1fiI/E3ozWSbtyc8d/ ixSjyGeJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPPgAKCRDgIcpz8YmpEOuuB/ 9Ypx+ux9Tl4YipCWRiww2UPEMMGRV4zH3aP1zM5BnQ04Tq4ixOf0TM8V4Ic/b4iH1htQcxPEWixlll mqVHvLye8GDXa0jxV744njG+dllXZ2qmFRzjve70ETmyWLUi45oFsSaj+XU7Sd/NNTEkELK5HwONbu vcNM17bXXwupGvAt0C1XVKPK3G1RXyHGN+r9vQCtj4C1G2Wa0Zuyl50yZyrCT97emuWTSZ1rZosmkE qYu7NCCDjIPqWmOHOHRsqC5OYcEr7kC933u/W6PaGS8wvQ9DBTEYbypFAx0ezzP9exOW/Q5KcFdCXb Vp4gmjuTTkbcmN8tG+TsS/dJvh+qzN
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for disabled irqs when discarding slabs, so restore them before
discarding.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1c4bd45d66a1..0a1e048d0db7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2406,6 +2406,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 	if (n)
 		spin_unlock(&n->list_lock);
 
+	local_irq_restore(flags);
+
 	while (discard_page) {
 		page = discard_page;
 		discard_page = discard_page->next;
@@ -2415,7 +2417,6 @@ static void unfreeze_partials(struct kmem_cache *s,
 		stat(s, FREE_SLAB);
 	}
 
-	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-- 
2.33.0

