Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DA38F660
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEXXnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhEXXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5QSAKwogWxiihbFPOl0HVlMof8QL2JF10nKieb0JlE=;
        b=mYMOGIMkYBZS2dqEnwu7v4VwPr8L5qdfFRH1Au4jNyg5hhYxkozBUQVtmLuBXMILltE7SS
        0xov9E2ugEBQWIfl0/yh7ypvMIiLAjLlw1Y7DVl3VlqUh89jjVMlVlUZc+qABkuaKIDy6V
        kL4YdysgJAQ4umo8VioOpFwisLYnqBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5QSAKwogWxiihbFPOl0HVlMof8QL2JF10nKieb0JlE=;
        b=RvHe4x13YTAy3y2hzKOWFdxfidOnlP0m+M7I/MHXjxm8KmLql1wtJs0OuAhgT3/Ry3bVhx
        qXI8N+bOg9fJOxAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E51D6AF59;
        Mon, 24 May 2021 23:40:49 +0000 (UTC)
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
Subject: [RFC 25/26] mm, slub: use migrate_disable() in put_cpu_partial()
Date:   Tue, 25 May 2021 01:39:45 +0200
Message-Id: <20210524233946.20352-26-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In put_cpu_partial, we need a stable cpu, but being preempted is not an issue.
So, disable migration instead of preemption.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bfa5e7c4da1b..8818c210cb97 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2417,7 +2417,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	int pages;
 	int pobjects;
 
-	preempt_disable();
+	migrate_disable();
 	do {
 		pages = 0;
 		pobjects = 0;
@@ -2451,7 +2451,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	if (unlikely(!slub_cpu_partial(s)))
 		unfreeze_partials(s);
 
-	preempt_enable();
+	migrate_enable();
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-- 
2.31.1

