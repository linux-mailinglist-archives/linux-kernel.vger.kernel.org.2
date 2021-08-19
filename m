Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD93F1C36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhHSPIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbhHSPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:08:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:07:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x4so6182745pgh.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYuk+DEGwmqpa17SuWp9uKR9u9Vjn438MMp/iFqe6x8=;
        b=eTys5198HwvfjTo7k2gq3jBj0e0iiULC/gJ9XjDFKq16sZPVAETyCpQcbrkPFrbRUw
         IkgzfV/6xy5dS8f8NcT9fyP/VfvnGgO2+oZY71TKcIc2lTOJXdH7qPT5woOPGkUxczbO
         I1m8IehPcrcyjpA9NMLr5+W8wLBg8BboskU100z+Y9a8k7jByblPAPLsiD1vjHJoi6hU
         0Y8R56Vrfn3LSvhiVqBbXE3iro2jb4n36m8J4xGlwBJKfJ1iWUY98Y+SMZcPklOQpLSN
         pjAqxuLFrI+LTra6HLnCOUAIiUXekuGn5/n1ls97WaFjbdf22AbaPq3fOhd6wg14okzp
         Bl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYuk+DEGwmqpa17SuWp9uKR9u9Vjn438MMp/iFqe6x8=;
        b=drMBDinic/5/OVtMSnAlBgqbljPKr8tGJhjbygcqDuUXkqThUpuqUGL9LVw0sQHGZx
         aCpTZrkqZcInIhPdNV3bNzRZLn98dsitYjB+HBRREbvG9hA0/mREr11UIeAcIEcwuLwY
         bLha2LMsJEClU1Je1HZl1H3NLkAoo0iQ27YLYasYMIaQMIcS0ndMcjYn/RBv2Ke4wNwd
         wPUSgBQqJRYX3fRt7uPc6Myj1u6MjhgRlzQLDLezPnQmexmQ37x9FPMHtuHZUYcriWOK
         r01a+oZCaoYQ9eymMmL9A4QEsIcnPaT8mAFClAcoGAAMRz2ixghoa2o7PKhCH/QmaNwL
         PmPg==
X-Gm-Message-State: AOAM5339q70wB5jZQmIWmj77vl4+L6yHS2L3SLrcuLkdoMrcGfseNJFC
        1NAF+oxtu2DLklumG9y5CRVsBTkN7U/msw==
X-Google-Smtp-Source: ABdhPJz0wxv/g3GbA0t1zv8J4Ui8EtOs//AFwfyVwvmqugO3/NcDMGWLZlbhQyxXb91CP6DEcd7JFA==
X-Received: by 2002:a63:ba5c:: with SMTP id l28mr14288818pgu.311.1629385646996;
        Thu, 19 Aug 2021 08:07:26 -0700 (PDT)
Received: from Smcdef-MBP.lan.org ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y7sm3342081pfi.204.2021.08.19.08.07.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 08:07:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: introduce PAGEFLAGS_MASK to replace ((1UL << NR_PAGEFLAGS) - 1)
Date:   Thu, 19 Aug 2021 23:07:12 +0800
Message-Id: <20210819150712.59948-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
PAGEFLAGS_MASK to make the code clear to get the page flags.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Change log in v2:
 1. Revert PAGEFLAGS_MASK

 include/linux/page-flags.h      | 4 +++-
 include/trace/events/page_ref.h | 4 ++--
 lib/test_printf.c               | 2 +-
 lib/vsprintf.c                  | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 54c4af35c628..8e1d97d8f3bd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -180,6 +180,8 @@ enum pageflags {
 	PG_reported = PG_uptodate,
 };
 
+#define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
+
 #ifndef __GENERATING_BOUNDS_H
 
 static inline unsigned long _compound_head(const struct page *page)
@@ -975,7 +977,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(PAGEFLAGS_MASK & ~__PG_HWPOISON)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 5d2ea93956ce..8a99c1cd417b 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val)
@@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val, __entry->ret)
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8ac71aee46af..ec69953cf80c 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -614,7 +614,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 	bool append = false;
 	int i;
 
-	flags &= BIT(NR_PAGEFLAGS) - 1;
+	flags &= PAGEFLAGS_MASK;
 	if (flags) {
 		page_flags |= flags;
 		snprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dd006adfe853..42ad16327c75 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2019,7 +2019,7 @@ static const struct page_flags_fields pff[] = {
 static
 char *format_page_flags(char *buf, char *end, unsigned long flags)
 {
-	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
+	unsigned long main_flags = flags & PAGEFLAGS_MASK;
 	bool append = false;
 	int i;
 
-- 
2.11.0

