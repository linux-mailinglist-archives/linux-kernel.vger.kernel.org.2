Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF593C8166
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhGNJXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhGNJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:23:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471BC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:20:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y17so1737368pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXaZpxV+G9LRpUwF+VG87MLwHGWNlv6eVU68Ll1BDlg=;
        b=g9aguBnwL1920OCwUhqI3Lc2IO3wEKFUYXyt4p/cwHmuxEILVxh9mCSu9o0GwgtZO/
         wDxqvMQ1ZbiH6IKJHUiIPV3UpcITtfYmpdPxud8pNaCiUvW4xu36P1GqJ+kJzTmLLVcd
         RdbstYinUCtwGZBtxTWq4GBGizTXYTsDQD49emXEPQ6A5PHpMQDyKUurFxmjWRe29RnC
         1/bok7yNN2gB730SHadWTJnC4V+qr6ewnzyR7j2Gb1qse6sxVDy4syZ7xfv5p50v2NTB
         ZstpW+Ku5pkS4IAB4iKj2loqbQYjiSEszi1mTN7NAx/O9PQeL6M5hoYhAyTIW/3Gewp8
         n2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXaZpxV+G9LRpUwF+VG87MLwHGWNlv6eVU68Ll1BDlg=;
        b=jUk2FBokLlT4ps/BJWE09clAMbZzOQ5+vVflzTHN9LG1sPEBR18rOHPDSODoPY+3tJ
         9mKAYrhq+7M7GqZ6Z9gj0plEDhvXMCi67+qpcJ7xQN72sg2JQ+ctpAcK30tF2kArdyLk
         ETaPe7/kV/S1ZcFgsRyQD8RNX9RSLAphS8XOWQfRTUzlzslHPGhmfzGtx9efUwhEZ1tK
         BTnhChzHyfIfrEw2NXtppuEfM8j9qTXL+hB9RHKTRmNezQivV0Pf96BkX7EXB+7g4KMl
         YQzVjmvbTcmhlQrWlDsHHC70RR1tV2QXOZhy3ogSHdkt3CX2sxdRa5dKt1HnVt8BMa8h
         5aoQ==
X-Gm-Message-State: AOAM532P8C9V4qRF83IlmKPi1gnIPdOzCA3lc0LQi2nc3miVqba6Yn2H
        LV9unFL0g6uBsveK+YAQf1T1Uw==
X-Google-Smtp-Source: ABdhPJxjjEP8yL9wM+fk5lNc/bRm4F/w/VpzdXNoCSV1b00VidI9N1OgiQuYPqXD7Wap1+ynN2apBg==
X-Received: by 2002:a63:de45:: with SMTP id y5mr8563948pgi.261.1626254458547;
        Wed, 14 Jul 2021 02:20:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:20:58 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/5] mm: introduce PAGEFLAGS_MASK to replace ((1UL << NR_PAGEFLAGS) - 1)
Date:   Wed, 14 Jul 2021 17:17:56 +0800
Message-Id: <20210714091800.42645-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210714091800.42645-1-songmuchun@bytedance.com>
References: <20210714091800.42645-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
PAGEFLAGS_MASK to make the code clear to get the page flags.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/page-flags.h      | 4 +++-
 include/trace/events/page_ref.h | 4 ++--
 lib/test_printf.c               | 2 +-
 lib/vsprintf.c                  | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..358d3f6fa976 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -178,6 +178,8 @@ enum pageflags {
 	PG_reported = PG_uptodate,
 };
 
+#define PAGEFLAGS_MASK		(~((1UL << NR_PAGEFLAGS) - 1))
+
 #ifndef __GENERATING_BOUNDS_H
 
 static inline unsigned long _compound_head(const struct page *page)
@@ -859,7 +861,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(~(PAGEFLAGS_MASK | __PG_HWPOISON))
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 5d2ea93956ce..643b1b4e9f27 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val)
@@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
 		__entry->pfn,
-		show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+		show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
 		__entry->val, __entry->ret)
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8ac71aee46af..eadcc6458b10 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -614,7 +614,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 	bool append = false;
 	int i;
 
-	flags &= BIT(NR_PAGEFLAGS) - 1;
+	flags &= ~PAGEFLAGS_MASK;
 	if (flags) {
 		page_flags |= flags;
 		snprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dd006adfe853..ff7c180a2971 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2019,7 +2019,7 @@ static const struct page_flags_fields pff[] = {
 static
 char *format_page_flags(char *buf, char *end, unsigned long flags)
 {
-	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
+	unsigned long main_flags = flags & ~PAGEFLAGS_MASK;
 	bool append = false;
 	int i;
 
-- 
2.11.0

