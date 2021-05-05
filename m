Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11553373CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhEENzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:55:12 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43662 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhEENzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:55:10 -0400
Received: by mail-wr1-f47.google.com with SMTP id s8so1934067wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eD6V+3EKLEZ2d3YHn8BHx9RbXqa4fEMUypgdABWHLlQ=;
        b=HX1cUSjrX4ONfZAVU+sQt0IFp5XLTNBN3zw9ICpiIaYxFhI8FEnWODJyDHTyH3WgGU
         3R69f2YD0NZ1q1mtJ7I9F0lQXSbeitOsxF3PUkg2GhKce0m0lOdsp7RB3pWjJdJAx0w9
         Rzg9o+CG/FGWssT23pTMqcg9npADascE6f+8tP7M7qCfLBaWhpLhmnXMoD6e8F0tQpow
         BqrtKkG4ePWfkyu1WnQ/+oCra+wCG0hWPvBauKPSYqzXiN5mUrbABdg1JMMK96/g19do
         2pdryetBaqBRPHVUKZ7bafXd1Dc30LURfy6KgX+c34MqiiCWrSmvZNFBqjg4e1P02v4K
         zVAw==
X-Gm-Message-State: AOAM532Ti52aPmuGbKQZDlF0dE+KEUy5q4cjTMJPNXpxpLKkq7iOd2E1
        xSliMr//zMwWhRONUrVLaLUzxV3J/zU=
X-Google-Smtp-Source: ABdhPJwVZr25sOlVxz+KC0N/jYPU7xFY+zxzPB82mqgCwdIP8rqEAQfOaykCOk33AL8Bw/zvDc7k/w==
X-Received: by 2002:a5d:64e5:: with SMTP id g5mr39262402wri.30.1620222853357;
        Wed, 05 May 2021 06:54:13 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-7-215.eurotel.cz. [85.160.7.215])
        by smtp.gmail.com with ESMTPSA id q12sm4893794wmj.7.2021.05.05.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 06:54:12 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Aili Yao <yaoaili@kingsoft.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] Revert "mm/gup: check page posion status for coredump."
Date:   Wed,  5 May 2021 15:54:07 +0200
Message-Id: <20210505135407.31590-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

While reviewing http://lkml.kernel.org/r/20210429122519.15183-4-david@redhat.com
I have crossed d3378e86d182 ("mm/gup: check page posion status for
coredump.") and noticed that this patch is broken in two ways. First it
doesn't really prevent hwpoison pages from being dumped because hwpoison
pages can be marked asynchornously at any time after the check.
Secondly, and more importantly, the patch introduces a ref count leak
because get_dump_page takes a reference on the page which is not
releases.

It also seems that the patch was merged incorrectly because there were
follow up changes not included as well as discussions on how to address
the underlying problem http://lkml.kernel.org/r/57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com

Therefore revert the original patch.

Fixes: d3378e86d182 ("mm/gup: check page posion status for coredump.")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c      |  4 ----
 mm/internal.h | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 71e546e279fc..a33abe9048ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1592,10 +1592,6 @@ struct page *get_dump_page(unsigned long addr)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
-
-	if (ret == 1 && is_page_poisoned(page))
-		return NULL;
-
 	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
diff --git a/mm/internal.h b/mm/internal.h
index ef5f336f59bd..43c4a2f8d4cc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -96,26 +96,6 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
-/*
- * When kernel touch the user page, the user page may be have been marked
- * poison but still mapped in user space, if without this page, the kernel
- * can guarantee the data integrity and operation success, the kernel is
- * better to check the posion status and avoid touching it, be good not to
- * panic, coredump for process fatal signal is a sample case matching this
- * scenario. Or if kernel can't guarantee the data integrity, it's better
- * not to call this function, let kernel touch the poison page and get to
- * panic.
- */
-static inline bool is_page_poisoned(struct page *page)
-{
-	if (PageHWPoison(page))
-		return true;
-	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
-		return true;
-
-	return false;
-}
-
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
2.30.1

