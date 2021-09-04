Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F31400AEE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbhIDKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351119AbhIDKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA7FF2269C;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6OGrx6GIz3up+TR10DXhEX3qqgzgoncBND4dqx46JQ=;
        b=R/1YG4pxxmCF+V/yfa7WCiwFyBQo20Ny9YGDYZV8bneQn/MKwawoZwwVLwS3yHIpfvx72N
        6vxrODBuyOVufeH/DcY9o9rN7s6QocULpCIdjOQ3/xWsmGNxsmfrdx0u2TmAvl8inWkzM3
        t0HZZoAPL1zbIUH3BR9GySFgS2q9B4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6OGrx6GIz3up+TR10DXhEX3qqgzgoncBND4dqx46JQ=;
        b=/oDDZiF/f3RFroQeUBWyVfA2caJT7sYiXKxby/oVyDWYKFKKmWxbqaNRTD67QYNm340GCJ
        eEPmMS3xKcRpPfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9346A13A2C;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kLZZI2RPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:12 +0000
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
Subject: [PATCH v6 19/33] mm, slub: make locking in deactivate_slab() irq-safe
Date:   Sat,  4 Sep 2021 12:49:49 +0200
Message-Id: <20210904105003.11688-20-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; h=from:subject; bh=YzKb788v9/Uv70MA4Rhg3F13MEdyRR1sJKH4wo5Ptcg=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM082Dw6UQkycba/shrCzbIHxh8w0nLMMX1KTqEQs ZLqhCvmJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPNgAKCRDgIcpz8YmpEHtQB/ 9AilOZPBvAD9Ga6igYJHS3ePasiFqZE7IxQ5jt1aQ1KJZg/RLYIyAohaFk3aNzV5vAk5252TqW4FiP QDOUE0fspWrTpM2tdMkK6gpbCaMbHJnj4mgeSnguneIL/JUTk6cdMCdPSYp7Z3RvdD9Wu5waA8pdYs cjE7r9Ugyqe9XgVn8JdAVgOZtVnnu0QRSr1EEY9uX4dg7x+r6iwXX7ScU+8XTKbDU2+ieZbv2kp419 AzCGmTNLRh7Rqvkv+JQ74HhCfP80O+vID9xABa4MOfFz5RZCGRfWI7ZK98yHy9BWAwsbFXMnRg3dii 5YjPSB3PnLYDtEDLnlnfMPs3TXaLHq
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dectivate_slab() now no longer touches the kmem_cache_cpu structure, so it will
be possible to call it with irqs enabled. Just convert the spin_lock calls to
their irq saving/restoring variants to make it irq-safe.

Note we now have to use cmpxchg_double_slab() for irq-safe slab_lock(), because
in some situations we don't take the list_lock, which would disable irqs.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index cea7a2ad9e3e..6deb4080ef54 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2223,6 +2223,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
+	unsigned long flags = 0;
 	struct page new;
 	struct page old;
 
@@ -2298,7 +2299,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * that acquire_slab() will see a slab page that
 			 * is frozen
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	} else {
 		m = M_FULL;
@@ -2309,7 +2310,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * slabs from diagnostic functions will not see
 			 * any frozen slabs.
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	}
 
@@ -2326,14 +2327,14 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 
 	l = m;
-	if (!__cmpxchg_double_slab(s, page,
+	if (!cmpxchg_double_slab(s, page,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"))
 		goto redo;
 
 	if (lock)
-		spin_unlock(&n->list_lock);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 
 	if (m == M_PARTIAL)
 		stat(s, tail);
-- 
2.33.0

