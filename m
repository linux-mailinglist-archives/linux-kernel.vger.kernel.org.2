Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D03090BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhA2Xqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 18:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2Xqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 18:46:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ADCC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 15:45:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g10so10463114wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tw1Hp7aX/S0VjTJJRisCjf0Avfnwz4zJamKEdO13Ig=;
        b=ezvP0/016Ph5ZYnfV3u4UGjyoaDOxwpS+sXs/4ixvS88CT/B7PjjFHHij3nwLfOwVK
         3qxpGR8l/UDiab0txk+CbJgw26ZUC5nx5lQlxGdc8FhoQuciqgO7abXBo3CrBkGAbmPR
         xMleYfmOt6LJaBdAeWo9aZiUdj7x3L8UNmHwnpx6aoN4MfQ38PqkLVvwqn1glaTbwihc
         NfNwuHDwz1B0Q+LB1guWnkcDxE6G6OeAh+HZdPZyt/rSlz2MDVBkhDCPDFAZHaZztLTq
         2dD95NDRZtjjIiniw56Ryrpts0VtXjXnowPLVANUs3zm223hXzaWTsxkwjK2DqavU+mi
         +J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tw1Hp7aX/S0VjTJJRisCjf0Avfnwz4zJamKEdO13Ig=;
        b=QkgpQSbAG46ve++pqEk1JYDFMm+8EWW6V82OhFRj2ROV9V/GlZA5+nq+qVrsotyRF0
         1yUhhNC3FmbeEIHTcM5vZtIrbbbyNJ/AGzSYaXw8LQM9noi4nVE9l2ABUZccOX/xgVbx
         hRXYOfaVXr3h+RTJhPD3W7xTMRvloa8eU7egKfDec9Yg/V23W32ZiYtGF8sqb8oV3ruc
         l78CJFuGNiD57dNge6te5rj8rcZ8t2HHgWODJBzdi5yPF5M94jLFFnw1YX5qjMC8w5Mo
         3REijo8piyOsLruBPqnWkkaQhMSuVC5pkcYv8rt6e/tOTJ38MRduZzF5K33KXu2VyzAR
         /HNw==
X-Gm-Message-State: AOAM531r0WQcsDYwM71M9kQkHZnUB5W1UJZyGXx98HYfsuMO+W0C1eNX
        LcezhQrJ8ETBP2DzZs2BgB+3cw==
X-Google-Smtp-Source: ABdhPJwSrmsBUw0JVsO4Dn8CSCcWHNv+NHGbSr63pqQM0s1AODOPZTrqR81CgfE40eZthHDWMmFqeA==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr6963326wrj.225.1611963951497;
        Fri, 29 Jan 2021 15:45:51 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x1sm12376230wmi.14.2021.01.29.15.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2021 15:45:50 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     vbabka@suse.cz, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mm/page_owner: Record the timestamp of all pages during free
Date:   Sat, 30 Jan 2021 01:45:48 +0200
Message-Id: <20210129234548.10054-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect the time when each allocation is freed, to help with memory
analysis with kdump/ramdump.

Having another timestamp when we free the page helps for debugging
page migration issues. For example both alloc and free timestamps
being the same can gave hints that there is an issue with migrating
memory, as opposed to a page just being dropped during migration.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/vm/page_owner.rst | 2 +-
 mm/page_owner.c                 | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 4e67c2e9bbed..5d7a62c2be28 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -47,7 +47,7 @@ size change due to this facility.
 
    text    data     bss     dec     hex filename
    48800   2445     644   51889    cab1 mm/page_alloc.o
-   6574     108      29    6711    1a37 mm/page_owner.o
+   6644     108      29    6777    1a79 mm/page_owner.o
    1025       8       8    1041     411 mm/page_ext.o
 
 Although, roughly, 8 KB code is added in total, page_alloc.o increase by
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d15c7c4994f5..fbdf064e7494 100644
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
@@ -177,6 +180,7 @@ static inline void __set_page_owner_handle(struct page *page,
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->ts_nsec = local_clock();
+		page_owner->free_ts_nsec = 0;
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
@@ -243,6 +247,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
+	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 
 	/*
 	 * We don't clear the bit on the oldpage as it's going to be freed
