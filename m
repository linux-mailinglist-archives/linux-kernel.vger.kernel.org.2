Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56A400ADB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351112AbhIDKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 747E122683;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kvmkd4Q4DBA+81R5ppIXUcDQcJXQz0IDCyEAsW4y0NA=;
        b=M82h5xU9rz0Kaj1hMPpuKir09OA9oEVxcG4azJpbzdHzGtZ1byg6b/h9hM+0MoUyqgVFei
        ev3PLB8k6ehLbQZptaRbgFEd1XRrDAq7I249+lwmhMVyYw96A520VXSBM4EU0mIhpxS09N
        vfZC6Bv1Jmxd/Ewhnr/jUJxa7tBbHyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kvmkd4Q4DBA+81R5ppIXUcDQcJXQz0IDCyEAsW4y0NA=;
        b=pgamaKZVi5EQ9iXiEKbbACo8dfVZ0PYvGmxR4/JMrJ00SyggyPWgBpphevEyknZCgqeRBG
        BlrXn1KOlBTtNWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A4A713A2C;
        Sat,  4 Sep 2021 10:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qNmAEWFPM2HoUQAAMHmgww
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
Subject: [PATCH v6 01/33] mm, slub: don't call flush_all() from slab_debug_trace_open()
Date:   Sat,  4 Sep 2021 12:49:31 +0200
Message-Id: <20210904105003.11688-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; h=from:subject; bh=pGY7AAbRUOvOaavAoErs6AM4Lcn1GBH3g1REQDNPySM=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM07+JEDh7KnXxzJDU+VcTlsdKd7YjMnZfSqC6qP3 1n0GgYOJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNO/gAKCRDgIcpz8YmpEN5pCA C5y7vGRR+edojJ+ajf1PpoAHz/WLaF8X/4mzl0yr10YYirJtFBTUKHt3beNcMeqLbqUyhB82kB3pni 481iN6OX4N5eGd0DTfs5q7VyskBd6M4RhE0XRv3Xly/40AOMyWf0OWqr7utIXEoSL+XOTjw21He5dC /GBcBqktbFTBa4CZlaEQr+UZX3C7ZGHRC/8JV7n8TFSxv7F4Q03aCsHFTOiEDPW9qldFZe6ia6LJJj TRg+gxR2J8ailfVtkP5RRlAJxRfbbF5iVjp1yzSjyo5fRbdo2f1euzCDE9Y9LxMUG2I69Cdoyi4xVT 6EF+sumhuJVZdxV4GNwA+E75+Kc0I6
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slab_debug_trace_open() can only be called on caches with SLAB_STORE_USER flag
and as with all slub debugging flags, such caches avoid cpu or percpu partial
slabs altogether, so there's nothing to flush.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
---
 mm/slub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f77d8cd79ef7..f6063ec97a55 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5825,9 +5825,6 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL))
 		return -ENOMEM;
 
-	/* Push back cpu slabs */
-	flush_all(s);
-
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long flags;
 		struct page *page;
-- 
2.33.0

