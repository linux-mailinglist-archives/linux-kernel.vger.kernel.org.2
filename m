Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1F30994C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhAaAQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhAaAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:32 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E0C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b21so9425386pgk.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBC+01VJDydhQXc0ahXrqYuyDmXo9pxN+3IIrkulC2k=;
        b=TVaH6VkAFpqdsk3/O5YnMODhdAAk+rzD1GW94VeMtYiLPCpNcRRex1R5curwd/F/u2
         JoZO+6hwCClkfatFg7nvWtmamjIgVWUi6E8GJpxIWv2iPzxgDU/qaQNi3EZ9zSaSkdcr
         JeafsVuqp25qdIhEsQH1BBdCItzsiDYGctTkAvqDLxfpb74yY1KmKU2sjHqS2M0xFeVc
         YIU60KL8eTty3Ml5hP60IR5UfA1EwnwH4r29RX9A0wlgF123L+y962rKwK3V6mzC1u1r
         JIrMzJzUFgndPpsk4dnSac3Hja48wtwRVU1AJ865LmviTsl5s5ntTPYH88jXCOxx/4V8
         nuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBC+01VJDydhQXc0ahXrqYuyDmXo9pxN+3IIrkulC2k=;
        b=eeio5M76xZ/jfdtPQt5eXYUeOyAk7gLLwGR8BVUQmXqs2mZIenT0STunstCd/5fL2W
         IJmzKmYmn6HSfZ/eAyzkgiTR7SH0oEvkg9ZmILHUwI7ooqmlxY55HyDdWtZK4vTobaOv
         IY4L8NwtonuKAeazvYQ15l51o5wTL8LuOCIPr8tO6QUKdH9kRDbk6v7dhjJSC6uhJl4A
         GcVc4ct6c617VaGbwI/DfRwxoRuCvP3UxxdnO3Chhz5YtQy5a1hxDtLfhzf9wWNHC0t0
         /xuHAeNdW0qlqK+3mLQ+pgUShMKO6rlkI84OuJJ7zABm+ZdWoYW0/Ty0PB0GZYHKIVqT
         Sp8g==
X-Gm-Message-State: AOAM533fxx/oLo3xIiQp8FMUGymQMYHBa0f7jUUxzK7OfFYDwasDVGNK
        IvBWpvRfLB8JNy6iAi6GqsU=
X-Google-Smtp-Source: ABdhPJyqoXCkGVfO0VoTpCz9roEewxlxHC7XiUyi9KFDCIAE2zizHYqngYx2P5q4ZIJvw6BChNykYQ==
X-Received: by 2002:a63:43c6:: with SMTP id q189mr10561751pga.245.1612052166645;
        Sat, 30 Jan 2021 16:16:06 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:06 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 04/20] mm/mapping_dirty_helpers: use mmu_gather
Date:   Sat, 30 Jan 2021 16:11:16 -0800
Message-Id: <20210131001132.3368247-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Avoid open-coding mmu_gather for no reason. There is no apparent reason
not to use the existing mmu_gather interfaces.

Use the newly introduced pte_may_need_flush() to check whether a flush
is needed to avoid unnecassary flushes.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 mm/mapping_dirty_helpers.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index b59054ef2e10..2ce6cf431026 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -4,7 +4,7 @@
 #include <linux/bitops.h>
 #include <linux/mmu_notifier.h>
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 /**
  * struct wp_walk - Private struct for pagetable walk callbacks
@@ -15,8 +15,7 @@
  */
 struct wp_walk {
 	struct mmu_notifier_range range;
-	unsigned long tlbflush_start;
-	unsigned long tlbflush_end;
+	struct mmu_gather tlb;
 	unsigned long total;
 };
 
@@ -42,9 +41,9 @@ static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
 		ptent = pte_wrprotect(old_pte);
 		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
 		wpwalk->total++;
-		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
-		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
-					   addr + PAGE_SIZE);
+
+		if (pte_may_need_flush(old_pte, ptent))
+			tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
 	}
 
 	return 0;
@@ -101,9 +100,7 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
 
 		wpwalk->total++;
-		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
-		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
-					   addr + PAGE_SIZE);
+		tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
 
 		__set_bit(pgoff, cwalk->bitmap);
 		cwalk->start = min(cwalk->start, pgoff);
@@ -184,20 +181,13 @@ static int wp_clean_pre_vma(unsigned long start, unsigned long end,
 {
 	struct wp_walk *wpwalk = walk->private;
 
-	wpwalk->tlbflush_start = end;
-	wpwalk->tlbflush_end = start;
-
 	mmu_notifier_range_init(&wpwalk->range, MMU_NOTIFY_PROTECTION_PAGE, 0,
 				walk->vma, walk->mm, start, end);
 	mmu_notifier_invalidate_range_start(&wpwalk->range);
 	flush_cache_range(walk->vma, start, end);
 
-	/*
-	 * We're not using tlb_gather_mmu() since typically
-	 * only a small subrange of PTEs are affected, whereas
-	 * tlb_gather_mmu() records the full range.
-	 */
-	inc_tlb_flush_pending(walk->mm);
+	tlb_gather_mmu(&wpwalk->tlb, walk->mm);
+	tlb_start_vma(&wpwalk->tlb, walk->vma);
 
 	return 0;
 }
@@ -212,15 +202,10 @@ static void wp_clean_post_vma(struct mm_walk *walk)
 {
 	struct wp_walk *wpwalk = walk->private;
 
-	if (mm_tlb_flush_nested(walk->mm))
-		flush_tlb_range(walk->vma, wpwalk->range.start,
-				wpwalk->range.end);
-	else if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
-		flush_tlb_range(walk->vma, wpwalk->tlbflush_start,
-				wpwalk->tlbflush_end);
-
 	mmu_notifier_invalidate_range_end(&wpwalk->range);
-	dec_tlb_flush_pending(walk->mm);
+
+	tlb_end_vma(&wpwalk->tlb, walk->vma);
+	tlb_finish_mmu(&wpwalk->tlb);
 }
 
 /*
-- 
2.25.1

