Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB43EE516
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbhHQDbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhHQDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:31:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094CAC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:31:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a20so23244323plm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eYlsZXR2FK6lsWriLYg+hmKtAtOAY2P842IeWm/0fs=;
        b=1RWBovbHwdzjx4mykOaOi1u3lImcaMb6aK+4PIPlBNOcmJ5QFbka6CudWog77kjnT/
         iBLdZohlrAIay3yCMUi1uVLEuX8aPNIoS3LLLSRzj440cyU3+kkFfmiiDiLoh3wIFNcS
         KH28RW1ag/mOr3HYiMhjDJ7cvo+PM+2S22hwBgrf91BOXortwyxDzBdmTbilbB3fatkP
         FKsovqQm+YN+wYgHFt36uE9Ysd8LY0MsjKxNT/uAggbjOZL2GPGawEK4pGBfksty2sIV
         eLRPVm+ulcbIC7hKHchnuztAQnzKrGb7BdQmu/YgHYUmGW9r4DyVqMpCl9gHVARQzDR0
         SN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eYlsZXR2FK6lsWriLYg+hmKtAtOAY2P842IeWm/0fs=;
        b=ghuIitH62W4U8Y8ICggjjTBTx9EJglmwm2NJQ0ZlqOCU2frVdu+71d32XYsWVjaCbU
         kRKV99OU7r99kqQjdXlMuZMCKHdRRJTLpDTWTI4GNXEl7sGd99c6Ayu1Ya2363m1rrUS
         T8oNWYTDSLVTl8KGMF7ErFVPkuskoDyr0+eFISUwLjCxOUans2zDhNirls9NDIP8uCzP
         vIHrothFcasuat8Cs9v6ulD1uffUsrhHjmlBfyyaKQvMubMn8yNUag68kQCB7qNpguIl
         rIM46BO1vMKax5bjXLaUe5l8YtDCds14rFe2GuHKuivMCuZxe85iMG2/1ezC1/VpuD7j
         3jvA==
X-Gm-Message-State: AOAM533kOX1970G8Z2bu7oF/zkHpTrtcBCv4BGMk6uIke90Mp2IFGLvA
        O+Jqf0DEPvh6b0/rATE4fY3IHQ==
X-Google-Smtp-Source: ABdhPJw6KGdYlKD2j+ITgxvgESdiHeAzzyPOOG44Ou7Ev53gSwvxWEaIw6pwyQrlnTuvIz7pcrVlHQ==
X-Received: by 2002:aa7:8116:0:b029:346:8678:ce26 with SMTP id b22-20020aa781160000b02903468678ce26mr1470339pfi.15.1629171069481;
        Mon, 16 Aug 2021 20:31:09 -0700 (PDT)
Received: from Smcdef-MBP.lan.org ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id g20sm599076pfo.20.2021.08.16.20.31.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 20:31:09 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL << NR_PAGEFLAGS) - 1)
Date:   Tue, 17 Aug 2021 11:30:32 +0800
Message-Id: <20210817033032.76089-1-songmuchun@bytedance.com>
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
 include/linux/page-flags.h      | 4 +++-
 include/trace/events/page_ref.h | 4 ++--
 lib/test_printf.c               | 2 +-
 lib/vsprintf.c                  | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 54c4af35c628..1f951ac24a5e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -180,6 +180,8 @@ enum pageflags {
 	PG_reported = PG_uptodate,
 };
 
+#define PAGEFLAGS_MASK		(~((1UL << NR_PAGEFLAGS) - 1))
+
 #ifndef __GENERATING_BOUNDS_H
 
 static inline unsigned long _compound_head(const struct page *page)
@@ -975,7 +977,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
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

