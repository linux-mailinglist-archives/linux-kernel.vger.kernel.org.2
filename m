Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8342A661
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJLNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:49:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbhJLNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:48:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E69C122181;
        Tue, 12 Oct 2021 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634046414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWB9as3njuiRUp5p4yQLhJSRq0L5YpGkz9E3SAiNSvQ=;
        b=Im9hePUbyiv0XEEfaBzv9KjQkKwrdsX1aihHCSQHrWpiCL5icg1Y/SjGq/nj3YvDwy0xf1
        6xzJbG1cnArKFC+PgZkXxdgwZ9MR01jaTE6AvjvDDKGbGs6pFumtcEwbLCCJ8cVn7E7Mu6
        CNclZpKZCqolvVJMXKL1pXF5OFZB0oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634046414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWB9as3njuiRUp5p4yQLhJSRq0L5YpGkz9E3SAiNSvQ=;
        b=EZcrisBhN9K0rAKry/d4rbhVkI79rY9LbXffdfu7e2pOJDS8+PS8hLtMmqhPrDAGX36iGU
        64kmQxDxSXF9kEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C26E513E43;
        Tue, 12 Oct 2021 13:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2CrTLs6RZWFvcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Oct 2021 13:46:54 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 2/2] mm/slub: increase default cpu partial list sizes
Date:   Tue, 12 Oct 2021 15:46:51 +0200
Message-Id: <20211012134651.11258-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012134651.11258-1-vbabka@suse.cz>
References: <20211012134651.11258-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; h=from:subject; bh=BOTRawnUs1b5HELHjjcvUVINWviomd1o1dsmM7cd0bA=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhZZHJgnJdeKM1b8Jm7MtIG89xZzMCSoaZP+zcncOw juuzJSWJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYWWRyQAKCRDgIcpz8YmpEIPnB/ 496I4Z0eEdFp26TBWN55hbiS43GJl0Bngj8yOyd/YrmMzUWuX1R7fku8JrMHw7Mv5BHOCGR3MhUfq7 uOfhNDNFf9f7ND8n9nj7pdhDjbocq6qsY53doHi+qnsS2snHCyPkBRWKdt7ym9FxpNwx0Es3SU+gJu Q20K9a/lV8lg5kZLjYh5DRFvV/rwYQ66RVStvyslPI3ABxYxbERdgyUow4JU6JTAJ/s+Caey2xrtq/ YLbB0aWfKtrk2VdemQckBZ9drKXfYuVKX936Y7f4WDVdj+l3VoCO9qCmQhnUXM6FWlbaCcp+wJE5Ih Qo7hc317NGpW6Hg4gdy1RKiyqmUJpU
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defaults are determined based on object size and can go up to 30 for
objects smaller than 256 bytes. Before the previous patch changed the
accounting, this could have made cpu partial list contain up to 30 pages.
After that patch, only up to 2 pages with default allocation order.

Very short lists limit the usefulness of the whole concept of cpu partial
lists, so this patch aims at a more reasonable default under the new
accounting. The defaults are quadrupled, except for object size >= PAGE_SIZE
where it's doubled. This makes the lists grow up to 10 pages in practice.

A quick test of booting a kernel under virtme with 4GB RAM and 8 vcpus shows
the following slab memory usage after boot:

Before previous patch (using page->pobjects):
Slab:              36732 kB
SReclaimable:      14836 kB
SUnreclaim:        21896 kB

After previous patch (using page->pages):
Slab:              34720 kB
SReclaimable:      13716 kB
SUnreclaim:        21004 kB

After this patch (using page->pages, higher defaults):
Slab:              35252 kB
SReclaimable:      13944 kB
SUnreclaim:        21308 kB

In the same setup, I also ran 5 times:
hackbench -l 16000 -g 16

Differences in time were in the noise, we can compare slub stats as given by
slabinfo -r skbuff_head_cache (the other cache heavily used by hackbench,
kmalloc-cg-512 looks similar). Negligible stats left out for brevity.

Before previous patch (using page->pobjects):

Objects: 1408, Memory Total:  401408 Used :  304128

Slab Perf Counter       Alloc     Free %Al %Fr
--------------------------------------------------
Fastpath             469952498  5946606  91   1
Slowpath             42053573 506059465   8  98
Page Alloc              41093    41044   0   0
Add partial                18 21229327   0   4
Remove partial       20039522    36051   3   0
Cpu partial list      4686640 24767229   0   4
RemoteObj/SlabFrozen       16 124027841   0  24
Total                512006071 512006071
Flushes       18

Slab Deactivation             Occurrences %
-------------------------------------------------
Slab empty                       4993    0%
Deactivation bypass           24767229   99%
Refilled from foreign frees   21972674   88%

After previous patch (using page->pages):

Objects: 480, Memory Total:  131072 Used :  103680

Slab Perf Counter       Alloc     Free %Al %Fr
--------------------------------------------------
Fastpath             473016294  5405653  92   1
Slowpath             38989777 506600418   7  98
Page Alloc              32717    32701   0   0
Add partial                 3 22749164   0   4
Remove partial       11371127    32474   2   0
Cpu partial list     11686226 23090059   2   4
RemoteObj/SlabFrozen        2 67541803   0  13
Total                512006071 512006071
Flushes        3

Slab Deactivation             Occurrences %
-------------------------------------------------
Slab empty                        227    0%
Deactivation bypass           23090059   99%
Refilled from foreign frees   27585695  119%

After this patch (using page->pages, higher defaults):

Objects: 896, Memory Total:  229376 Used :  193536

Slab Perf Counter       Alloc     Free %Al %Fr
--------------------------------------------------
Fastpath             473799295  4980278  92   0
Slowpath             38206776 507025793   7  99
Page Alloc              32295    32267   0   0
Add partial                11 23291143   0   4
Remove partial        5815764    31278   1   0
Cpu partial list     18119280 23967320   3   4
RemoteObj/SlabFrozen       10 76974794   0  15
Total                512006071 512006071
Flushes       11

Slab Deactivation             Occurrences %
-------------------------------------------------
Slab empty                        989    0%
Deactivation bypass           23967320   99%
Refilled from foreign frees   32358473  135%

As expected, memory usage dropped significantly with change of accounting,
increasing the defaults increased it, but not as much. The number of page
allocation/frees dropped significantly with the new accounting, but didn't
increase with the higher defaults.
Interestingly, the number of fasthpath allocations increased, as well
as allocations from the cpu partial list, even though it's shorter.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3757f31c5d97..a3b12fe2c50d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4019,13 +4019,13 @@ static void set_cpu_partial(struct kmem_cache *s)
 	if (!kmem_cache_has_cpu_partial(s))
 		nr_objects = 0;
 	else if (s->size >= PAGE_SIZE)
-		nr_objects = 2;
-	else if (s->size >= 1024)
 		nr_objects = 6;
+	else if (s->size >= 1024)
+		nr_objects = 24;
 	else if (s->size >= 256)
-		nr_objects = 13;
+		nr_objects = 52;
 	else
-		nr_objects = 30;
+		nr_objects = 120;
 
 	slub_set_cpu_partial(s, nr_objects);
 #endif
-- 
2.33.0

