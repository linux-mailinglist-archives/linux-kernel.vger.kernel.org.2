Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC52C3E8F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhHKLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhHKLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:20:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA6C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:19:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso4186870pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h4Wq4WVTOOeJx+RzOswhDqKF1DUaEGegOy7F0dkRvE=;
        b=B8uEqYdmRmZlEanQQBrCNBCPYJkOMIGNJ0mW0sRzLFr9GPpAliH8iWvdLmvgdVpyWT
         XKjyUfWSF0goQFCRsGQU5ngo0ed1UFcDsVIx6J04x+JH2rWD/71IfZ2vvyKK5E0YIsoZ
         lgFK1LprWcuJ9wXESVpcORfAtf+dTwKfr9OFYmqvi66b2XcwtUSr0eqbSVLzRwPTisXM
         UMnTrlo1hjPmD24ohuBYuQ8TzZvq+LbWNGTa2W9YdAFWgXLaNLRkgv6gbPNheRS0+GMJ
         M8qudheAgejiyybBxy+PaycHQXjgLhIWXNwxZqN0T1gEErKIhOoaR4eRyqKEJ1hiWKud
         nA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h4Wq4WVTOOeJx+RzOswhDqKF1DUaEGegOy7F0dkRvE=;
        b=HG0WnlXWuoqN8sNnWt65x0JTJwmFeY0J6CSJ6Jq9sNWNAWAu6fP0YtlkZjwJYzSK3j
         xsSvxvFfvUg/kRemJ6bZKPxgh16CJk1o12c6s9Nv/N22KDCjT29YkayKDueENQ5AJukj
         CGCpbLPkUkpviID5a4IEWeLH9BuiH04uk8FpE7sWpIzeviHiMzIGh/DqYwOYpYk/QQC+
         Gd7FPkvuz5os8urXDyPNE4G1Ymv7tu7JI0CimfYwqDFeYCrfWDdTpGefz3VFSYPLT6wo
         Sptp8bK+aWJ6bzKaptx/CKX7oc83kvfUHDNRGZ5Tq622znnby63F2wxMdshCOpgyTB+t
         OR8A==
X-Gm-Message-State: AOAM531LksUDpi+J5NvZTZYvxKvmQII09XlToJQrii9Qt1RXPX+Rj2xn
        njdKBKNoraCg/bVaMLGSF4ev2w==
X-Google-Smtp-Source: ABdhPJwLELgl8PGluKN2j8VbvfrKC5mcL7kRCPM8aNxsfRPcorY+7MfMCQekejL4aCi6R2gEJkVQ3Q==
X-Received: by 2002:aa7:9d84:0:b029:3c5:72a7:bb08 with SMTP id f4-20020aa79d840000b02903c572a7bb08mr33450794pfq.45.1628680790655;
        Wed, 11 Aug 2021 04:19:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id o9sm29513925pfh.217.2021.08.11.04.19.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 04:19:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: slub: remove preemption disabling from put_cpu_partial
Date:   Wed, 11 Aug 2021 19:19:21 +0800
Message-Id: <20210811111921.85999-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d6e0b7fa1186 ("slub: make dead caches discard free slabs
immediately") introduced those logic to speed up the destruction of
per-memcg kmem caches, because kmem caches created for a memory
cgroup are only destroyed after the last page charged to the cgroup
is freed at that time. But since commit 9855609bde03 ("mm: memcg/slab:
use a single set of kmem_caches for all accounted allocations), we
do not have per-memcg kmem caches anymore. Are those code pointless?
No, the kmem_cache->cpu_partial can be set to zero by 'echo 0 > /sys/
kernel/slab/*/cpu_partial'. In this case, the slab page will be put
into cpu partial list and then moved to node list (because
slub_cpu_partial() returns zero). However, we can skip putting the
slab page to cpu partial list and just move it to node list directly.
We can adjust the condition of kmem_cache_has_cpu_partial() to
slub_cpu_partial() in __slab_free() and remove those code from
put_cpu_partial() for simplification.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slub.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b6c5205252eb..69c8ada322a0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2438,7 +2438,6 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	int pages;
 	int pobjects;
 
-	preempt_disable();
 	do {
 		pages = 0;
 		pobjects = 0;
@@ -2470,16 +2469,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 		page->pobjects = pobjects;
 		page->next = oldpage;
 
-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
-								!= oldpage);
-	if (unlikely(!slub_cpu_partial(s))) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-		local_irq_restore(flags);
-	}
-	preempt_enable();
+	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page) != oldpage);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
@@ -3059,9 +3049,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		was_frozen = new.frozen;
 		new.inuse -= cnt;
 		if ((!new.inuse || !prior) && !was_frozen) {
-
-			if (kmem_cache_has_cpu_partial(s) && !prior) {
-
+			if (slub_cpu_partial(s) && !prior) {
 				/*
 				 * Slab was on no list before and will be
 				 * partially empty
@@ -3069,9 +3057,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 				 * freeze it.
 				 */
 				new.frozen = 1;
-
 			} else { /* Needs to be taken off a list */
-
 				n = get_node(s, page_to_nid(page));
 				/*
 				 * Speculatively acquire the list_lock.
@@ -3082,17 +3068,14 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 				 * other processors updating the list of slabs.
 				 */
 				spin_lock_irqsave(&n->list_lock, flags);
-
 			}
 		}
-
 	} while (!cmpxchg_double_slab(s, page,
 		prior, counters,
 		head, new.counters,
 		"__slab_free"));
 
 	if (likely(!n)) {
-
 		if (likely(was_frozen)) {
 			/*
 			 * The list lock was not taken therefore no list
@@ -3118,7 +3101,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	 * Objects left in the slab. If it was not on the partial list before
 	 * then add it.
 	 */
-	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
+	if (unlikely(!prior)) {
 		remove_full(s, n, page);
 		add_partial(n, page, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
-- 
2.11.0

