Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840ED34EE10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhC3Qig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhC3QiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:38:03 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22291C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:38:02 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id a65so703381wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SNuqqyD1tP1LYYPE4x3JSrsZ8EwStb88MAUaMmFkoIk=;
        b=THEbeG6qdl3QydVONL/rXH5xUys8SIgs+UvdH2PXVDfddWMvAEBD2x5vBMOWd6Bqnm
         RjfJ+oYMixbdPBEqra1jLDaZp2YPaJ0eOh3eUmXnAN568jGyzsrT55L0/Z9do/Ec3z8J
         PnXHcNm6ejCaqXAckgEcwv0iQgYRGpZiscydfXvEic7YmUcbQfybYjKK0pGsw9f4pSQP
         Dg8I/jHDePk0Im2VBiJ0wodJPyOaJi5Z7TmbEClgoCB+y4zSWJ8HuiCkc4C84TYe26pk
         ndCD4suL+LYX/sh8dmZC5nkIY5eu9vunB91LSMdOCD+gNcvuDVTznP8vmz7vo9lxgF5D
         Nt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SNuqqyD1tP1LYYPE4x3JSrsZ8EwStb88MAUaMmFkoIk=;
        b=EC6L8IQcVWf2khIXVvBtEMtPKmWAAJ1KzcMZ/bu6LYqPtGYH3pVSU/aWhH6FIIUM9R
         TZfujWKLN/hySbdIWbsnZrbE0bKqSpi7f4vva6GcYWstHkdqWoiKl1n+gkO7NRO/ktRF
         nyoEBL/F8w+Iw+g2QqttIohCL5gAry/wLPkhLVUxXCC1JaYoU7Aw4JoGiy8nMhPGlA1m
         S89GNIHUhMZDdb/1hrrxmMZBVDEKXhOpJWKxWySYBXpEiK7MqEsbK1KJUQ1fHYNLZiUp
         J3EjNL/A7Qzz8cLhynH4I9s44EcP53hbd2Deh7uxGyCGHf8XSGps/v/bKeLSJz+wGxyE
         Uscg==
X-Gm-Message-State: AOAM5330Qh8oHI4IaQ6BJgYzkzznifz72sGEmFgvpWJJj6/kZZXw8cmd
        /i7Vzy9i1UjOpmCUQ9ZDv3RiR+ZAOQNNl33c
X-Google-Smtp-Source: ABdhPJzSw0mO64h44KApJp+BDWP571t6gBuceBI8pSQDIyJx1vO3lgBzlHb5UwsYOy9HH2XMf0nxyNoQtiAw05H6
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:f567:b52b:fb1e:b54e])
 (user=andreyknvl job=sendgmr) by 2002:a1c:1f4a:: with SMTP id
 f71mr4905469wmf.101.1617122280880; Tue, 30 Mar 2021 09:38:00 -0700 (PDT)
Date:   Tue, 30 Mar 2021 18:37:36 +0200
Message-Id: <65b6028dea2e9a6e8e2cb779b5115c09457363fc.1617122211.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH mm v2] mm, kasan: fix for "integrate page_alloc init with HW_TAGS"
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
to complaints from the page unpoisoning code, as the poison pattern gets
overwritten for __GFP_ZERO allocations.

Fix by restoring the initial order. Also add a warning comment.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 033bd92e8398..d2c020563c0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2328,6 +2328,13 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
 
+	/*
+	 * Page unpoisoning must happen before memory initialization.
+	 * Otherwise, the poison pattern will be overwritten for __GFP_ZERO
+	 * allocations and the page unpoisoning code will complain.
+	 */
+	kernel_unpoison_pages(page, 1 << order);
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_alloc_pages and kernel_init_free_pages must be
@@ -2338,7 +2345,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	if (init && !kasan_has_integrated_init())
 		kernel_init_free_pages(page, 1 << order);
 
-	kernel_unpoison_pages(page, 1 << order);
 	set_page_owner(page, order, gfp_flags);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

