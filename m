Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCF3D925E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhG1PyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbhG1PyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:54:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:54:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f62-20020a17090a28c4b02901733dbfa29cso7305821pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nks6a/t+MySx7OFBPCEcNNVwXnFiVMAiOmt6uCggBWY=;
        b=kSAACNtPnggfD+XKxBN1GwQwowtS+CCiZGRw8Mp/udN5Pg5m1sMoJsMguCP1jV2RQJ
         e9hNinUoyttZFC3LfPFEDjt+MXRSiomKz+Ma2ZeyVDp/WPJFuxpBWIRWP1LDukzvm4MQ
         808xP8Mpg3MxY3l7Vhx/YM3wgvk+j5JLC6plyumEdPC/+2+IUMmqWd3BTlxlQyl2shZC
         O1O19eZZ9mG7hwP1aJIteGpcc9WpHpAHTY+wbgd6lPEXoyEpIrCwDaqgCOvAl0eY44GH
         aimMV8khBJQ92dvidm/qtCpkWFpSst1z8268pZMYjpEtxxHVohvB0R9YqHpn5WrS/3Z/
         nbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nks6a/t+MySx7OFBPCEcNNVwXnFiVMAiOmt6uCggBWY=;
        b=bc8fdN6kdXgKgWR9H+ch895Xi+tFG8dZAKmccvhij04UYRzOK2cqxiCj02ETSf6S4g
         ehiZti8iVWetuu2eylrJgTgmmy2kg5I3Vtv7gc53hSkMuVZak14g7q5eKu27Iiz09yCb
         eYr0Hd5IiBmLniT/ozC2szRiPyMeAbbjFaLAyY4u51Pz6Ou1ZYfQgNoMIFiG46nI0wfn
         AjK1oae0Q7j78YBkt3FtYtNp1sbYrlC0RXFmR4D+B90FRo0Kv2lY+j5JPRMMC6hytw41
         2tsHafsIc/GiB5+ZxC1yLgMVOLbfb5MlvWzioPHdX+R7PHCakRNMPVM7bVZoq8oZIvfR
         oKsQ==
X-Gm-Message-State: AOAM5339/YMgWa/daR+JBFwjjiK4GqcOeIny/UIU8HbwQOf97pm71gMB
        VzJ5f2SlqyUuGy0mQYWitpseaPyScBIgpQ==
X-Google-Smtp-Source: ABdhPJy81kAiCqDg7f4ohI21A479NHMS9MXo6F2Sa6SsRdueNdiHFvczQs1Aoq8fzudRQEaEmqG51unyCHMjmA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:3056:c181:ea4:1833])
 (user=shakeelb job=sendgmr) by 2002:a65:5083:: with SMTP id
 r3mr446248pgp.161.1627487645326; Wed, 28 Jul 2021 08:54:05 -0700 (PDT)
Date:   Wed, 28 Jul 2021 08:53:54 -0700
Message-Id: <20210728155354.3440560-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] slub: fix unreclaimable slab stat for bulk free
From:   Shakeel Butt <shakeelb@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB uses page allocator for higher order allocations and update
unreclaimable slab stat for such allocations. At the moment, the bulk
free for SLUB does not share code with normal free code path for these
type of allocations and have missed the stat update. So, fix the stat
update by common code. The user visible impact of the bug is the
potential of inconsistent unreclaimable slab stat visible through
meminfo and vmstat.

Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slub.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6dad2b6fda6f..03770291aa6b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3238,6 +3238,16 @@ struct detached_freelist {
 	struct kmem_cache *s;
 };
 
+static inline void free_nonslab_page(struct page *page)
+{
+	unsigned int order = compound_order(page);
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	kfree_hook(page_address(page));
+	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
+	__free_pages(page, order);
+}
+
 /*
  * This function progressively scans the array with free objects (with
  * a limited look ahead) and extract objects belonging to the same
@@ -3274,9 +3284,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	if (!s) {
 		/* Handle kalloc'ed objects */
 		if (unlikely(!PageSlab(page))) {
-			BUG_ON(!PageCompound(page));
-			kfree_hook(object);
-			__free_pages(page, compound_order(page));
+			free_nonslab_page(page);
 			p[size] = NULL; /* mark object processed */
 			return size;
 		}
@@ -4252,13 +4260,7 @@ void kfree(const void *x)
 
 	page = virt_to_head_page(x);
 	if (unlikely(!PageSlab(page))) {
-		unsigned int order = compound_order(page);
-
-		BUG_ON(!PageCompound(page));
-		kfree_hook(object);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-				      -(PAGE_SIZE << order));
-		__free_pages(page, order);
+		free_nonslab_page(page);
 		return;
 	}
 	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
-- 
2.32.0.432.gabb21c7263-goog

