Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE16D34B8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 19:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhC0SWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 14:22:17 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35226 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhC0SVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:21:55 -0400
Received: by sf.home (Postfix, from userid 1000)
        id A29665A22061; Sat, 27 Mar 2021 18:21:50 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>, linux-mm@kvack.org
Subject: [PATCH v2] mm: page_alloc: ignore init_on_free=1 for debug_pagealloc=1
Date:   Sat, 27 Mar 2021 18:21:44 +0000
Message-Id: <20210327182144.3213887-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210327180348.137d8fe2@sf>
References: <20210327180348.137d8fe2@sf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On !ARCH_SUPPORTS_DEBUG_PAGEALLOC (like ia64) debug_pagealloc=1
implies page_poison=on:

    if (page_poisoning_enabled() ||
         (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
          debug_pagealloc_enabled()))
            static_branch_enable(&_page_poisoning_enabled);

page_poison=on needs to init_on_free=1.

Before the change id happened too late for the following case:
- have PAGE_POISONING=y
- have page_poison unset
- have !ARCH_SUPPORTS_DEBUG_PAGEALLOC arch (like ia64)
- have init_on_free=1
- have debug_pagealloc=1

That way we get both keys enabled:
- static_branch_enable(&init_on_free);
- static_branch_enable(&_page_poisoning_enabled);

which leads to poisoned pages returned for __GFP_ZERO pages.

After the change we execute only:
- static_branch_enable(&_page_poisoning_enabled);
and ignore init_on_free=1.

CC: Vlastimil Babka <vbabka@suse.cz>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org
CC: David Hildenbrand <david@redhat.com>
CC: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lkml.org/lkml/2021/3/26/443
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 mm/page_alloc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d57d9b4f7089..10a8a1d28c11 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -764,32 +764,36 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
  */
 void init_mem_debugging_and_hardening(void)
 {
+	bool page_poison_requested = page_poisoning_enabled();
+
+#ifdef CONFIG_PAGE_POISONING
+	/*
+	 * Page poisoning is debug page alloc for some arches. If
+	 * either of those options are enabled, enable poisoning.
+	 */
+	if (page_poisoning_enabled() ||
+	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
+	      debug_pagealloc_enabled())) {
+		static_branch_enable(&_page_poisoning_enabled);
+		page_poison_requested = true;
+	}
+#endif
+
 	if (_init_on_alloc_enabled_early) {
-		if (page_poisoning_enabled())
+		if (page_poison_requested)
 			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
 				"will take precedence over init_on_alloc\n");
 		else
 			static_branch_enable(&init_on_alloc);
 	}
 	if (_init_on_free_enabled_early) {
-		if (page_poisoning_enabled())
+		if (page_poison_requested)
 			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
 				"will take precedence over init_on_free\n");
 		else
 			static_branch_enable(&init_on_free);
 	}
 
-#ifdef CONFIG_PAGE_POISONING
-	/*
-	 * Page poisoning is debug page alloc for some arches. If
-	 * either of those options are enabled, enable poisoning.
-	 */
-	if (page_poisoning_enabled() ||
-	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
-	      debug_pagealloc_enabled()))
-		static_branch_enable(&_page_poisoning_enabled);
-#endif
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;
-- 
2.31.0

