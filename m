Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE933CFA62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhGTMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhGTMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CCC0613DF;
        Tue, 20 Jul 2021 06:13:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l2so3439314qtp.11;
        Tue, 20 Jul 2021 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=AXjurdksSSyEZKFZ4dwI7bqIy7rFRNuiCDsvXU0YkuocK0QEXajhTDLdW4z1z/e65T
         LTLEY6rfvFw2zhW9t6YjY7pJAjqcinHqBHc+fLPFdMRjVhHRZY3JEDBzx0pGr0y45zCU
         iMbw3FsUPACZLzgC4Ivq0MGqY+ZiR2YUf2t8qzEmccEijSZfWJAdOZQw6+fudK9PdaVL
         vHFg5lAVpphObFQG7UQNG2Y7Zo2Wq6azf1aFxNlccsJv0JcY+wecDmxG65lP2Bd2K52V
         0l/f7AZ2VcijTD9MfXEdPXS0oRr+XOwZHi1mI/PTW7FAtdTPFRyz8UwmWuFcQwEhzPy9
         otjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=tsXgX8jpQo1i2EuaUiEUqgLBzdXlq6avjlblGiF8XwM7dfbDzpclE3z/LKk9tzUgK6
         BMFyk14ugfHHlXCiHpmB6NgY2JnHgEoN6e+W55JwFZdLTXKFO9djYZsd2zeUbHezmOok
         jGahtIDtr19urCCj21WeckPNTw8uqG6fxRfzSBBRBfOJag3lMQoyJqrAk5apT6NMsuox
         kz+tGTW21qv6aJyWe3XPdeWZYit8HVNAp0UORQ0S0stTZAegvzgSftkcuXAQULe8YX5F
         Bo8WuTd9n692VaxYbqeYfM96Ntmo402YCFZpKo6X0a0uca90zMoslWVvV7Bj3vLCQsqa
         CdKQ==
X-Gm-Message-State: AOAM533ozi75qcWjckQu3cj87LQbKHGYjADPEynSz609SrHZFWuhJ8nM
        o2LWEdnS4xY4ZVZJqwusy6M=
X-Google-Smtp-Source: ABdhPJy0LjG6uDWiu+ZbyuX11opxgLX2i0q6/CnN0YojkXcrGAiVtf0xl2dZoqfsPzdIQwBuOwt9DA==
X-Received: by 2002:ac8:7645:: with SMTP id i5mr26265284qtr.133.1626786833321;
        Tue, 20 Jul 2021 06:13:53 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:13:52 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 01/15] mm/damon/paddr: Support the pageout scheme
Date:   Tue, 20 Jul 2021 13:12:55 +0000
Message-Id: <20210720131309.22073-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the DAMON primitives for physical address space to
support the pageout action for DAMON-based Operation Schemes.  IOW, now
the users can implement their own data access-aware reclamations for
whole system using DAMOS.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/paddr.c        | 38 +++++++++++++++++++++++++++++++++++++-
 mm/damon/prmtv-common.c |  2 +-
 mm/damon/prmtv-common.h |  2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b92b07a3ce53..303db372e53b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -7,6 +7,9 @@
 
 #define pr_fmt(fmt) "damon-pa: " fmt
 
+#include <linux/swap.h>
+
+#include "../internal.h"
 #include "prmtv-common.h"
 
 /*
@@ -85,6 +88,39 @@ bool damon_pa_target_valid(void *t)
 	return true;
 }
 
+int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	unsigned long addr;
+	LIST_HEAD(page_list);
+
+	if (scheme->action != DAMOS_PAGEOUT)
+		return -EINVAL;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+		if (isolate_lru_page(page)) {
+			put_page(page);
+			continue;
+		}
+		if (PageUnevictable(page)) {
+			putback_lru_page(page);
+		} else {
+			list_add(&page->lru, &page_list);
+			put_page(page);
+		}
+	}
+	reclaim_pages(&page_list);
+	cond_resched();
+	return 0;
+}
+
 void damon_pa_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init = NULL;
@@ -94,5 +130,5 @@ void damon_pa_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.reset_aggregated = NULL;
 	ctx->primitive.target_valid = damon_pa_target_valid;
 	ctx->primitive.cleanup = NULL;
-	ctx->primitive.apply_scheme = NULL;
+	ctx->primitive.apply_scheme = damon_pa_apply_scheme;
 }
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 08e9318d67ed..01c1c1b37859 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -14,7 +14,7 @@
  * The body of this function is stolen from the 'page_idle_get_page()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-static struct page *damon_get_page(unsigned long pfn)
+struct page *damon_get_page(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
 
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index 939c41af6b59..ba0c4eecbb79 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -18,6 +18,8 @@
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32_max(r - l))
 
+struct page *damon_get_page(unsigned long pfn);
+
 void damon_va_mkold(struct mm_struct *mm, unsigned long addr);
 bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 			unsigned long *page_sz);
-- 
2.17.1

