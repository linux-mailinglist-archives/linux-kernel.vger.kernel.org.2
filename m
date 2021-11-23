Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6416645AA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhKWRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbhKWRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:50:12 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5AC06175D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:47:02 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso1707953pjf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=087vQaZWUKxRpGonVzwMVh0M7VkYLkSnxisBZd5obmA=;
        b=tCDZYtDjA+pqhy7EApb9w2YUe6thqQz8V9NYf8eIZXyF6AeYq3rWG2LRFBcFCsTQiR
         kneeeh4myslIyFGROJFluwIntriat5jZ2FTqFTKKTlC8BO0VCZNEJpFrT2d53G6fcq+M
         CFklWxtwSQMwS6ZAhddWeOpW2iPsP/u1yWs1Q5UONrn9RlxZUZIkrvEGpKphszkdUjYQ
         JLCbL7JC2OII02WEOG9fo1MHmtHnCCJ5m9CdTEQwUtBwS5Kc6UpXOegyHFKzKmSCWg0X
         pLVpqN70jYM1mpkkFeUMNNtHejmGKZpcPl2IymdGZy5hQ0PAMOi6+3knDRJAmsNYP6wE
         GSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=087vQaZWUKxRpGonVzwMVh0M7VkYLkSnxisBZd5obmA=;
        b=Mu6+Ewzrmg+FVCC+6wF/y2CdGwbo4WI2I+9nn0KVK+QeAZ6CNkP4zj+dAlh0A0XRYo
         j2YZpXqmG1Ee1NFwqsqYZhcDbeWVYvE4nmoiaC05myTQeqeAdK0J012vvAEV5yQ4EKqk
         ADe2n/GN4SMYHJlVNWlwtPKlfGXF7eB2fn5PFz8+tF99qelkzsf2zbyjD43fXp4WA+iT
         W0KbyzeGYayvn/nTm4vwqYrrWWyZsC7g2BY4KjHeGHqG+GIlazxdpCeJBA7vxDuss7R6
         KZZaeGfRU5RPqlLkhIXTo0LHdcjH9pk3w3UJWehsRZ4Yad8Rwo8+kIxtjulB8bd9vOX4
         mlUA==
X-Gm-Message-State: AOAM532Iwsw7Z2n+iBfsTmEbEfE74/7FGGyBLjpd0t+f+7RGKaDZerPR
        wAsQ8ED/3Vou6qylE8ThSgcHK7nE6F4uzA==
X-Google-Smtp-Source: ABdhPJwwKdrF+f/Ep44GPc4Dd3kMsoZXb+lKE1IEUG8p4nTJN1mOX8PuRqG+EzEyn8M5gOBj3prjDolC99pwHA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:bda6:1a8e:6bfd:ec0c])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1812:: with SMTP id
 lw18mr5227173pjb.196.1637689621682; Tue, 23 Nov 2021 09:47:01 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:46:58 -0800
Message-Id: <20211123174658.1728753-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] mm: thp: update split_queue_len correctly
From:   Shakeel Butt <shakeelb@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deferred THPs are split on memory pressure through shrinker
callback and splitting of THP during reclaim can fail for several
reasons like unable to lock the THP, under writeback or unexpected
number of pins on the THP. Such pages are put back on the deferred split
list for consideration later. However kernel does not update the
deferred queue size on putting back the pages whose split was failed.
This patch fixes that.

Fixes: 364c1eebe453 ("mm: thp: extract split_queue_* into a struct")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..4fff9584815b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2809,7 +2809,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
 	struct page *page;
-	int split = 0;
+	unsigned long split = 0, num = 0;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
@@ -2823,6 +2823,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		page = compound_head(page);
 		if (get_page_unless_zero(page)) {
 			list_move(page_deferred_list(page), &list);
+			num++;
 		} else {
 			/* We lost race with put_compound_page() */
 			list_del_init(page_deferred_list(page));
@@ -2847,6 +2848,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	list_splice_tail(&list, &ds_queue->split_queue);
+	ds_queue->split_queue_len += (num - split);
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	/*
-- 
2.34.0.rc2.393.gf8c9666880-goog

