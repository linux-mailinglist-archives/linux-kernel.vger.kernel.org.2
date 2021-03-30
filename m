Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6134EC85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhC3PcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhC3Pb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:31:58 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D512C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:31:58 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c9so630393wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3cy7QAZwcM0qFIMC//13hJw8FRpw0MBxMbErk7zBrt4=;
        b=hTB5eRLtCe5NqZk2lmE+RtfJKTufqW8xwNBuVspthnS2F1BfGX4jeWY2GkXPEnMBSw
         80L6q4iQDtV36/tBpGpoCepa+EjvAWAWapt1w53TW9phkLZtiN4eum+tYuVjvYPQCclf
         zQLNuDknXSsBTO4dVduFRu8ugjcSjJiciIOqcagk7Rwh54lrN3wlUz9b1PBadZmyUHZ9
         hUF8tIkLxgvgGxPpannVnFuCuAx0H3fLDs9jb2/GEQDv+sbKzyIFstT0gIvIxjaz37G8
         Wq5FVgkWFQZW5w8F/Ahmde0ZHveN9hpTvN1n1UtGFbkNkP/A+wfycovKPvYNmgA6qSrL
         QwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3cy7QAZwcM0qFIMC//13hJw8FRpw0MBxMbErk7zBrt4=;
        b=Ll4HcdI85t11tPl+tpwIvC73db62d4q43ZEhWl2IavJjS9GLd/daO0h5XdhAn3nFe6
         /WVIPh6lA20vZUGxflcjNcUODmG3UE4mOgY42/tQdMjMS5bptEqnylDeXLef/oEys8oG
         AhEp6jmsReev9XgqFqsMv583j9kMAkzwfE9p0vLlI/Q+SIE/ZB4fNeWGMJdutt/UScxm
         IkW4J+wLlA3MZc6PGA3Pwtd8Ur/o1u7JthQGNAjZFp0a1FprlNLs3bFmtHd0e8t4BByJ
         1imi48eF0jxiD8c2uIgjP4EEmJjUQ7W6baWXK1SKEY3zb5gdCjNNLXKYZbU40/aC2kUe
         qBVA==
X-Gm-Message-State: AOAM532l80HpuYiY/Xz20blEfvxZT6XlGtkt1Y/Y0nn3yexHR8C3bX85
        SomKDaUrPGB1ylEhFvCSj6BE9mb6EdIMhHFl
X-Google-Smtp-Source: ABdhPJw0vSXe4Xw64WO8uJrYsy7s7rzJcu18Vn5SMJYlS+KZ3mLl65FDIFCfjsv0oByaw6aiJVEWtthfNGpvlg45
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:f567:b52b:fb1e:b54e])
 (user=andreyknvl job=sendgmr) by 2002:a7b:ce06:: with SMTP id
 m6mr4526147wmc.38.1617118316958; Tue, 30 Mar 2021 08:31:56 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:31:54 +0200
Message-Id: <2e5e80481533e73876d5d187d1f278f9656df73a.1617118134.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH mm] mm, kasan: fix for "integrate page_alloc init with HW_TAGS"
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My commit "integrate page_alloc init with HW_TAGS" changed the order of
kernel_unpoison_pages() and kernel_init_free_pages() calls. This leads
to __GFP_ZERO allocations being incorrectly poisoned when page poisoning
is enabled.

Fix by restoring the initial order. Also add a warning comment.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 033bd92e8398..1fc5061f8ca1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2328,6 +2328,12 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
 
+	/*
+	 * Page unpoisoning must happen before memory initialization.
+	 * Otherwise, a __GFP_ZERO allocation will not be initialized.
+	 */
+	kernel_unpoison_pages(page, 1 << order);
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_alloc_pages and kernel_init_free_pages must be
@@ -2338,7 +2344,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	if (init && !kasan_has_integrated_init())
 		kernel_init_free_pages(page, 1 << order);
 
-	kernel_unpoison_pages(page, 1 << order);
 	set_page_owner(page, order, gfp_flags);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

