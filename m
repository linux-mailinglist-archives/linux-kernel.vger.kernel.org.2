Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0B39F5B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhFHL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:07 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43852 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhFHL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:06 -0400
Received: by mail-qt1-f176.google.com with SMTP id 93so7641336qtc.10;
        Tue, 08 Jun 2021 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=VMaxIBn2qqbfUX6zKsHmZqwhLISgllu71tVzGJYE73tltZNe5U2IHXkvAALM8X9Yj1
         QM3OQAud62cywUIC6AA2ohHBOniYB7AMSqJnrYzHHVIDgDushX7SBkzGId48qa3AjzRL
         osZi/YBaZITPanGvi2HJfoTrXjd3jNWeGbktte7mqMWCHLIPFHH/l5wSv4LmrXs0PhBy
         UocXgZQFJuwOYCZ5NcVz90UnQE9nXlAJp3Q67VE0VDwxaxCOp8gwkG4G2nmGQvukBE6M
         80bTzbpafanF3H7Mt6P/Xq1Tj2EKncenNryrmYDhwlXFe9EwBlIc+fgQPJ1LNxvKr93a
         AO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vycya5wChR8O11SPvwfrbgcahHWj2DvmeexI6w+aeRE=;
        b=UQnq5OIOcSF0ZhkromZrbfuRHXdMeHaZs5X1ZuIyMuI4mu1mGjz0uDIWk5TXDWbnR/
         qYZY8491Oy9URGaAtAiqh858MV9Hu8MX2AtY/WBFJp5Lw1WeDfzHF1a0QE/dBUlWFf/n
         9Lp/C732Dp9uRSJfQD/9msggHchFX0S+brQpv35SMETV9TDfAmSaxFttJTJ6PLr4tekb
         0hHQkuhNu4c6140HL50Aj/MTde55Wvh7Jb5dUBzLcDRqzwrB0Gq7Tq24DO0FX8YQSqZw
         GxF6+Vc9DYi/tqO3hGk4/FZUR9Q3pCH4Dnr9kPqmc/jRvsYqAPQ2z1H4WOL5gxz3irQe
         JDxA==
X-Gm-Message-State: AOAM530AbKN3KBTinGdfHDo6dHjOODHq4Vz7+1nKdobYXPB8BKiHjgoH
        eLuFg+5os6zs3oLnoE5PJrs=
X-Google-Smtp-Source: ABdhPJx845C6iRrgasVW+zarBTjWb+SmovQC2wL/Jo6i9FC3w095hG/aJB033l3Kh9Gyf0GzT+yN5Q==
X-Received: by 2002:ac8:604:: with SMTP id d4mr20607540qth.304.1623153193659;
        Tue, 08 Jun 2021 04:53:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:13 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 01/14] mm/damon/paddr: Support the pageout scheme
Date:   Tue,  8 Jun 2021 11:52:41 +0000
Message-Id: <20210608115254.11930-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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

