Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4338FEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhEYKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhEYKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:25:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53367C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:24:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s4so14565740plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cLiMXok1HQJuL5Rj9yY5lszCyh+gFs0zLJeC+o5z94c=;
        b=Bz/nbq1oGbrrm56CB2fKjHBESrj31Ydsy8kYssPxnd2xlnyPBFUjqX2y+LTxZ7PIy0
         CGD4x4VnX8nEIFkdchkIVMwA8L7MPOUal2+95/85OEhUORReDUcoC5KnflVcvAWEQOh1
         ecgmGIn4sqKtzH9/kGCwhAQQMBwTBSXwGxZqOPI/D5ULYR24NH7odd5panmBf70BITxz
         NEE/3mSPUMgjnNGRSiG2JhhhMJ3ERwuLi/9tFgeg9EzgUuNZJZua4/WbQ6MuITqKED6X
         DrB5QgR+f6L6SQU+0fzqbcRTz4k7SC8eg4KWGE5RiaVPFETbVhGB1QD+jLqwzdyFgefq
         FLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cLiMXok1HQJuL5Rj9yY5lszCyh+gFs0zLJeC+o5z94c=;
        b=CfW7nRw2anEfbygH/RSNut6co6mB26bB0EgoiPZLG/3Ly14WXI173Z0becZY2KTywq
         ZrMNPtZaMQOqb2tNSnfWsbuft6W4O9M/CP5JWBY98uGivtjubxBu5KvwMpgI9B2M3jyE
         BuYDFHsKAnToX4a3qZJyx+2sLt7Rg+TDA37JA1V6xdvPOP4LOYdwWfUz5yxBVgL+0can
         lgkE6PKJIls2jjPml1r1fJ47Fyrsh6JnTt41OR2xOVLB1F8vOjFUARTpB4AQnvT8hHWZ
         50Hlsj46jhERsgcu9o2fayq3Ze1nSQWRXFa6le6Y4ILCW///edEiHi8o+K8xhaQBjPk4
         rq6w==
X-Gm-Message-State: AOAM531KyCS97Cmpdh6vzNDG9xh79VEB7wWOOjJtZUSSLD7e1QcK4ERD
        dBUuKBB5OoMnUHjUA4okhJM=
X-Google-Smtp-Source: ABdhPJzOZGCs1ZL8oOqgsUOzWd1lleLZnaW16A6bNlsH1nuPaSnQ7ZNdEQWKMV8FvjR1cce1QrCQVg==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr29636485pjb.57.1621938256939;
        Tue, 25 May 2021 03:24:16 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id x187sm7821229pfc.104.2021.05.25.03.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 03:24:16 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH 2/2] mm: slub: use DEFINE_RAW_SPINLOCK init object_map_lock
Date:   Tue, 25 May 2021 18:23:55 +0800
Message-Id: <1621938235-11947-2-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621938235-11947-1-git-send-email-yejunedeng@gmail.com>
References: <1621938235-11947-1-git-send-email-yejunedeng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_RAW_SPINLOCK instead of DEFINE_SPINLOCK object_map_lock
that won't be preempted on mainline and PREEMPT_RT kernels.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c2f63c3..995f3d0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -445,7 +445,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
-static DEFINE_SPINLOCK(object_map_lock);
+static DEFINE_RAW_SPINLOCK(object_map_lock);
 
 #if IS_ENABLED(CONFIG_KUNIT)
 static bool slab_add_kunit_errors(void)
@@ -481,7 +481,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 
 	VM_BUG_ON(!irqs_disabled());
 
-	spin_lock(&object_map_lock);
+	raw_spin_lock(&object_map_lock);
 
 	bitmap_zero(object_map, page->objects);
 
@@ -494,7 +494,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 static void put_map(unsigned long *map) __releases(&object_map_lock)
 {
 	VM_BUG_ON(map != object_map);
-	spin_unlock(&object_map_lock);
+	raw_spin_unlock(&object_map_lock);
 }
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
-- 
2.7.4

