Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79A7396223
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhEaOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEaOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:02:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA55C07E5FC;
        Mon, 31 May 2021 06:38:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 76so11177263qkn.13;
        Mon, 31 May 2021 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=EYvCQQKgPCYb1T1zyBOC+Sfwkask8E/SULWEbSYSdm+BE5nST2/xfLVAfpqDuvUmaY
         QV2BCuEtvdflaZmcKNByibhZkFOStYY9nMd3P1rudbWQ9P0ffFWMtNzPwfLokj17xSG3
         GHwzkmAzdTEMyXkE7NgvaU5X/QFKIRcWaP/uejePivKp5cf0KmxAJ1HlEnzCbH/tvH92
         ZXdazTitutzOFde+lcBXEHI8Iwq8rWGmUgbGf69eHIbYT+7sfX3ljZI64jU0wMYmFmfX
         38uI5oT/SqD+LMAAQ2WfMmhdT/Afz70n7XF9BCdtbrUnWpvT9MFWgUrl35uk1Uz2UgDR
         /lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=o3WJ3h+BBPL3b/Lx5Pob71Mlc02UE7leJslalQjjXTKRAMVx5M4aAWpDadKrR285Ev
         sZDjGetFjS9qLuBUA9GuzddjZJCG/Xl4a6M9vif2MYy8L1f9kFYl4hgrD2Y3LuxFFAEk
         Vf79hIltswLdIVsll6XY3S+IgfFIPeutsm8G27tG3PJ/vo7r2EHpHCc2FiMJm2tKzs1i
         6loM6V4WMElEJJVs9CY5gm9FVk90L/M6VERaAKPoN54K1FYl/ZLSrtfswAjARy2Ywupx
         EXjwEIckf3z9IFfsP32iHf4ETLMhLhzYSmTq56cZoFOGFnCGCgiLG2mOezaMGv285Ie4
         R8GA==
X-Gm-Message-State: AOAM531ICAGefLzo8AaynBEnFPOryzS+Eu7Fg5SrYOfxue9RPWl9hOa5
        Y60FMLwvUnCcdrHpP4VOedhzXVByT+KWcswt
X-Google-Smtp-Source: ABdhPJz8Py5qmvt9kNyJEpjuXtDnKtYR+UgBG/W3ChFm/OMm8eaV8QxMIwb1VCjqy5p8uyIj9S6AzQ==
X-Received: by 2002:a37:a44d:: with SMTP id n74mr16863684qke.367.1622468309513;
        Mon, 31 May 2021 06:38:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:29 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/13] mm/damon/paddr: Support the pageout scheme
Date:   Mon, 31 May 2021 13:38:04 +0000
Message-Id: <20210531133816.12689-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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

