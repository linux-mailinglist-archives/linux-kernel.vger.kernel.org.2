Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A123DA3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhG2NVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:21:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhG2NVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61EEC223BB;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yu4GEMp20ceOFGbJ9BJTsfihLRupuqVhoZuR4x2ibA=;
        b=IF9xGo3q6iXvRFTQT9/6rmuq03VzC0a4Uokr44FetMznVkdVJfsNgNh+1i2nzJeVirdeiF
        ImX/H6HvIuII5CzmKgebGRN0VOdZUsB2gLQXokgpcNWRdfJJIPfyy9c1pjXidc9707yS9A
        TKXWokaPBqy/XYKWzHmYGtJLDs3Yaag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yu4GEMp20ceOFGbJ9BJTsfihLRupuqVhoZuR4x2ibA=;
        b=7W67C/4nJbk7jGPxzddeoBTb7wpHKlcUoQmI1nOejdlsSvyIITub3EkQWVqUtotzKfIx3K
        za33H9bFV41ErZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AFA213AF4;
        Thu, 29 Jul 2021 13:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qMvcCWSrAmF9AwAAMHmgww
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
Subject: [PATCH v3 01/35] mm, slub: don't call flush_all() from slab_debug_trace_open()
Date:   Thu, 29 Jul 2021 15:20:58 +0200
Message-Id: <20210729132132.19691-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index 090fa14628f9..422a61d7bf5f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5820,9 +5820,6 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
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

