Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1C3E17C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhHEPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:20:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhHEPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46AA922265;
        Thu,  5 Aug 2021 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7lcHvz2wxot78fAXYZZGgIHA3RNATzZgJpPr7GkMjA=;
        b=pdVTFR6ecAh7/qzsJbXbpIZqrml+LmDXp67p9JqTxcd9mH/9N+mAeEpSTxCjxuCcBspXfl
        XhHiFnvnLTqfQYXDiXbjEEMdFbbtaGs7qN/OwPc/qLoVGF6t3ZBgfKO2OntFE293Ew04ac
        Ei9j4ZKBiePxnrdHj32AtmSOakCmxmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7lcHvz2wxot78fAXYZZGgIHA3RNATzZgJpPr7GkMjA=;
        b=rynZoRPJ8RqseTqTmF1MUqsbHlpS1ayCD1kiAgs8V+xg2dzwnnn4HH8vW3nI+jrlCgUCbF
        3m+mfwGEIyZkPICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E5B913DAC;
        Thu,  5 Aug 2021 15:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHytAqQBDGFDdQAAMHmgww
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
Subject: [PATCH v4 01/35] mm, slub: don't call flush_all() from slab_debug_trace_open()
Date:   Thu,  5 Aug 2021 17:19:26 +0200
Message-Id: <20210805152000.12817-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
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
index af984e4990e8..f5908e6b6fb1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5822,9 +5822,6 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL))
 		return -ENOMEM;
 
-	/* Push back cpu slabs */
-	flush_all(s);
-
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long flags;
 		struct page *page;
-- 
2.32.0

