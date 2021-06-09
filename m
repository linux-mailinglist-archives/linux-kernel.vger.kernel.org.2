Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89C3A12EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhFILli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4A19219BC;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEDtjsnB/VDzYc0ii5k8c4+YLz6GPrWXLWLa4QOy8Fg=;
        b=IN8TwQl/nBF3IjB1x1wI2UnNVr4f2PMGC+TK64rkhGBc2qSF8AFsivay09xFcheo9OVNnb
        EyLzyuilsT1tTjlp2yyxsvWQb58GMdNR+OwaJ0TRA1eK8O/e7IFrccI/kDY37vtaVHZwGL
        s8ecWHWDT7kuc2g2E1LONThysPQHrZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEDtjsnB/VDzYc0ii5k8c4+YLz6GPrWXLWLa4QOy8Fg=;
        b=d08Kapwu2aJQczRX1Wiq9dop5yCfAX59yWf5r9X5g8KMXpk96Xqof3b8tqDspWR+X5J7f/
        8lm2LZHonHT3E8Cw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7022111A98;
        Wed,  9 Jun 2021 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEDtjsnB/VDzYc0ii5k8c4+YLz6GPrWXLWLa4QOy8Fg=;
        b=IN8TwQl/nBF3IjB1x1wI2UnNVr4f2PMGC+TK64rkhGBc2qSF8AFsivay09xFcheo9OVNnb
        EyLzyuilsT1tTjlp2yyxsvWQb58GMdNR+OwaJ0TRA1eK8O/e7IFrccI/kDY37vtaVHZwGL
        s8ecWHWDT7kuc2g2E1LONThysPQHrZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEDtjsnB/VDzYc0ii5k8c4+YLz6GPrWXLWLa4QOy8Fg=;
        b=d08Kapwu2aJQczRX1Wiq9dop5yCfAX59yWf5r9X5g8KMXpk96Xqof3b8tqDspWR+X5J7f/
        8lm2LZHonHT3E8Cw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id WLXrGnOowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:31 +0000
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
Subject: [RFC v2 01/34] mm, slub: don't call flush_all() from list_locations()
Date:   Wed,  9 Jun 2021 13:38:30 +0200
Message-Id: <20210609113903.1421-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_locations() can only be called on caches with SLAB_STORE_USER flag and as
with all slub debugging flags, such caches avoid cpu or percpu partial slabs
altogether, so there's nothing to flush.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3f96e099817a..f928607230b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4839,8 +4839,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 			     GFP_KERNEL)) {
 		return sysfs_emit(buf, "Out of memory\n");
 	}
-	/* Push back cpu slabs */
-	flush_all(s);
 
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long flags;
-- 
2.31.1

