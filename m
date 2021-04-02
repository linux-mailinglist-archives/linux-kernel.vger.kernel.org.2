Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C265353039
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhDBUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhDBUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:22:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C56C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:22:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v15so9007972lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPp5hmBkKmG7G/BogtZYwpF2ZqC9GPGqxLj7HZ4GHEc=;
        b=C5LIGAPLdvor1WU3eE6WVYmmUsYBKDJxINoQD4JGpkc5pgEUXZO8zpbfmDxXbQgrpk
         aRJ9N6H0/mxhg4FK+gOekMOPIsJA3a0DGVIJArzCRovJK3yEldVKMdxxCjRRCdE5TGCi
         3YXGQn+SwKTpwL9I+KRk7ZaxuN606tBVFiHw5xhtS6LEL8lGMC+GyxH8zxqUaXfGuNZN
         8NASV9Q36joo2U1elr4mXSH1K4OtNBn0kZ6irL3hbQswIn4F3/Z9sqUP3xInbQLBbwds
         BL+dyWDXH2DQrpMcLP081s2ugUadzRECjpcerWAagN/0AE6cCfBTboxRuknp91B5h512
         8P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPp5hmBkKmG7G/BogtZYwpF2ZqC9GPGqxLj7HZ4GHEc=;
        b=D3cSaUqefUNoUG/ZJuC5lsoxFhf0f1BA7jgcrw0k36lTlK+xjF64sMAVk6PRTQQ4TJ
         PeTne45ora2KPoQigSos2GmDWES01yOW3V+OvYdTrVaaddCct5kjBvVkZFSh7fE3S1CZ
         hzXhmftjWrjnfCy7jOzrcnXy9kyZ1wb6Sjq2wy1baV8R+vpegSeuh32o6qYHfLrgi6pR
         mCQx6S7uNjZPWTx3EKKyNpPp1uj1SjWrhWDCA553sThZmXtoqIaPFXNE6a+bHLSz9jjQ
         vhVRqx66mNw+IL1n+GG8AyXCrNvvz4Bts5QjWAnvhE9OqutEEOJJPnk615XGW+MXQAYz
         eGUw==
X-Gm-Message-State: AOAM531Tai+VUQtesgixV5qoeX7/JrmUqz9A1qINxMUJAFZdjAG9iW9y
        8ITYD1PVUwiE1ZDQ+PziJIA=
X-Google-Smtp-Source: ABdhPJycCgbuewUDCT7jlGaEzljaZ4quXQcfLi67z6o6c8OPyv/4jUaybvTf8xE5nllI5qjrGP6i/w==
X-Received: by 2002:a05:6512:314d:: with SMTP id s13mr9436973lfi.95.1617394971196;
        Fri, 02 Apr 2021 13:22:51 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f11sm952514lfr.119.2021.04.02.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:22:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH-next 4/5] mm/vmalloc: refactor the preloading loagic
Date:   Fri,  2 Apr 2021 22:22:36 +0200
Message-Id: <20210402202237.20334-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210402202237.20334-1-urezki@gmail.com>
References: <20210402202237.20334-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of keeping open-coded style, move the code related to
preloading into a separate function. Therefore introduce the
preload_this_cpu_lock() routine that prelaods a current CPU
with one extra vmap_area object.

There is no functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 60 +++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8b564f91a610..093c7e034ca2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1430,6 +1430,29 @@ static void free_vmap_area(struct vmap_area *va)
 	spin_unlock(&free_vmap_area_lock);
 }
 
+static inline void
+preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
+{
+	struct vmap_area *va = NULL;
+
+	/*
+	 * Preload this CPU with one extra vmap_area object. It is used
+	 * when fit type of free area is NE_FIT_TYPE. It guarantees that
+	 * a CPU that does an allocation is preloaded.
+	 *
+	 * We do it in non-atomic context, thus it allows us to use more
+	 * permissive allocation masks to be more stable under low memory
+	 * condition and high memory pressure.
+	 */
+	if (!this_cpu_read(ne_fit_preload_node))
+		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
+
+	spin_lock(lock);
+
+	if (va && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, va))
+		kmem_cache_free(vmap_area_cachep, va);
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -1439,7 +1462,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask)
 {
-	struct vmap_area *va, *pva;
+	struct vmap_area *va;
 	unsigned long addr;
 	int purged = 0;
 	int ret;
@@ -1465,43 +1488,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
 retry:
-	/*
-	 * Preload this CPU with one extra vmap_area object. It is used
-	 * when fit type of free area is NE_FIT_TYPE. Please note, it
-	 * does not guarantee that an allocation occurs on a CPU that
-	 * is preloaded, instead we minimize the case when it is not.
-	 * It can happen because of cpu migration, because there is a
-	 * race until the below spinlock is taken.
-	 *
-	 * The preload is done in non-atomic context, thus it allows us
-	 * to use more permissive allocation masks to be more stable under
-	 * low memory condition and high memory pressure. In rare case,
-	 * if not preloaded, GFP_NOWAIT is used.
-	 *
-	 * Set "pva" to NULL here, because of "retry" path.
-	 */
-	pva = NULL;
-
-	if (!this_cpu_read(ne_fit_preload_node))
-		/*
-		 * Even if it fails we do not really care about that.
-		 * Just proceed as it is. If needed "overflow" path
-		 * will refill the cache we allocate from.
-		 */
-		pva = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
-
-	spin_lock(&free_vmap_area_lock);
-
-	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
-		kmem_cache_free(vmap_area_cachep, pva);
+	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
+	spin_unlock(&free_vmap_area_lock);
 
 	/*
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend);
-	spin_unlock(&free_vmap_area_lock);
-
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.20.1

