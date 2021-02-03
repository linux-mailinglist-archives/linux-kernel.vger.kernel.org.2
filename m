Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B490E30E1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBCSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhBCR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:59:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:59:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so254096wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTjQz8Dnxjan8mjD0lOv8/iSRasIU/sl1+6PEFzSC+s=;
        b=S5C59m6h1Oc8GkHH2GhqYZkWHmJW37xp9kEpauQgpbfeh+E4cIsbyhOmzSYomsDe4m
         g1UMjkezFIEuhJv5QpSzqi+1tTDr+gaE4CLbXrW3haS8vj2PfqElxjdKnh7kz1F3RTaI
         ncOwqhMELit/5LxlPYT1yEAqyIDJpuQjaJyhPSCJ2gn526sM13LIlbKDBKMMi1pTDsG/
         R0SxNjvCq4cVebnoY/A0//sVfhVQB/SR+zKu3LM1DECVMCOceHqy1IAVOvwyVjsF2e7t
         vZ63QAyeJIuzluKW4XCL2w1amZ9KcaHsB9rOLZQwKt10hm9y2Gfhblsj78htqHLOPrDo
         WMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTjQz8Dnxjan8mjD0lOv8/iSRasIU/sl1+6PEFzSC+s=;
        b=Ft5ruw8aDzYvHsa1T1TC09npjD9alqcPOM1UcnuZkAKClp1PLEqCfLBM9Yu1knxCGs
         FMzPt/1r7javIR9QbMeIgfiUEdzt4D45Ge+jcvSpt7aTrLUAPO8OuOOrXo/IwD0w6QK6
         +yPSOeYHhnYtNEvEgXg0pRSTSuT3RZbvrobBLCjNZ/zSeJIdF6P7pdzs/8xZnR87M1Pt
         RxLzXepuOZNhaHwZSgMbHQqWUqWxMu9zUTYwuQ346KJOZOQcw1FncfI+UIPM+WQbpySa
         RpFzfB+aevz5Be6q+jbBAvwdUzT7AwdZGQJTZXtW2jV7Hz9+pIS05Izxhjg0QFCXs2q4
         E/Gg==
X-Gm-Message-State: AOAM532JKSXFZ2OhCvV3lT6XJveRBFwf1R9aAA6lWd9/PSLri6BCL5P8
        IQoRApMtVmQOZ1g8fexKZ4o79A==
X-Google-Smtp-Source: ABdhPJxNrJ1EWAksIvhKUYtOPTUyO7RzR8zWAGRNz/pNQUsNnFiTKb+WjhMBxzuVsyevVnthpGFcGw==
X-Received: by 2002:adf:fd52:: with SMTP id h18mr4911860wrs.295.1612375147252;
        Wed, 03 Feb 2021 09:59:07 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m10sm4741832wro.7.2021.02.03.09.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 09:59:06 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     vbabka@suse.cz, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v2] mm/page_owner: Record the timestamp of all pages during free
Date:   Wed,  3 Feb 2021 19:59:05 +0200
Message-Id: <20210203175905.12267-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect the time when each allocation is freed, to help with memory
analysis with kdump/ramdump. Add the timestamp also in the page_owner
debugfs file and print it in dump_page().

Having another timestamp when we free the page helps for debugging
page migration issues. For example both alloc and free timestamps
being the same can gave hints that there is an issue with migrating
memory, as opposed to a page just being dropped during migration.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
 * Don't reset the time of previous free when page is reallocated. (Vlastimil)
 * Add the timestamp in the page_owner file and dump_page(). (Vlastimil)

v1: https://lore.kernel.org/r/20210129234548.10054-1-georgi.djakov@linaro.org

 Documentation/vm/page_owner.rst |  2 +-
 mm/page_owner.c                 | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 4e67c2e9bbed..2175465c9bf2 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -47,7 +47,7 @@ size change due to this facility.
 
    text    data     bss     dec     hex filename
    48800   2445     644   51889    cab1 mm/page_alloc.o
-   6574     108      29    6711    1a37 mm/page_owner.o
+   6662     108      29    6799    1a8f mm/page_owner.o
    1025       8       8    1041     411 mm/page_ext.o
 
 Although, roughly, 8 KB code is added in total, page_alloc.o increase by
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d15c7c4994f5..9ceae81ba7b8 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -27,6 +27,7 @@ struct page_owner {
 	depot_stack_handle_t handle;
 	depot_stack_handle_t free_handle;
 	u64 ts_nsec;
+	u64 free_ts_nsec;
 	pid_t pid;
 };
 
@@ -148,6 +149,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle = 0;
 	struct page_owner *page_owner;
+	u64 free_ts_nsec = local_clock();
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 
@@ -158,6 +160,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
+		page_owner->free_ts_nsec = free_ts_nsec;
 		page_ext = page_ext_next(page_ext);
 	}
 }
@@ -243,6 +246,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
+	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 
 	/*
 	 * We don't clear the bit on the oldpage as it's going to be freed
@@ -356,10 +360,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = snprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
-			page_owner->ts_nsec);
+			page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	if (ret >= count)
 		goto err;
@@ -435,9 +439,9 @@ void __dump_page_owner(struct page *page)
 	else
 		pr_alert("page_owner tracks the page as freed\n");
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu\n",
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu, free_ts %llu\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
-		 page_owner->pid, page_owner->ts_nsec);
+		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle) {
