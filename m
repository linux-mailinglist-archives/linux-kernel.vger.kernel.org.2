Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477C6309956
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhAaASV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhAaAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA4C06178C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id j12so9055331pfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWcbdOnCHMci4gKmimhTyGECgzNX5SMoV5I4t1mnNZ0=;
        b=kGy8P8tEiPGFpNiMdALVuLcPBAKB5uzpz08ljdIJlFrJ3V1V4HWknbD805k1tUI0zq
         5bOA5gbhW77cDC3aRozEAUTAoZvPJeo+5njDt9+GhpD1RuGVjoAsMOzLlgAd3oPpcKsz
         oAhtOZqt784wu/H4bdG0X5Ad02xITuDE8bxQLlAkx8rMNdeCJb1j4DMgc28ObRF1MTU6
         UJVw9bnewbKW+tGZYJpjcYbgwmGxrF6Fun7V30BY53BAfi+Q666601tb+6ZFxzdTN/8T
         +dsz79Iaipj0knSCa1Wgsxxzd2Ps/UWLt76tMMSW19kR3a4j4ApKxGhMZux70qA60K/g
         p+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWcbdOnCHMci4gKmimhTyGECgzNX5SMoV5I4t1mnNZ0=;
        b=FrPnQK+UAL+AzM3W83PhjnQAi6RbbFww/XnP+EMr2Djd0kTfIPZ4s1ugW+DlSmL4zA
         bZKkhEatNjWS+zw8LD3kWvIfnmQxbv1Do452Vp8jKATISODEKkQcCCjqig22gV/nsWHw
         1TYZaAm20RLj1jRKwZimFTfQQabRUIB7ffgKTu+xPK/f+tkH2c0+Qvt9ikvvAxSok/pb
         EvJkX8Bi3jJbGTonOVojlQmo8uMQdbLK0QCkmeS2J9OdM3Cqvswo4I5CWScmYRrSLZsF
         bp0ROh/o44JRrx/m8Knx01ewVlfjjJlYzs7dWhxradlJW7MVlmhB5GrllPZ7siP3M1Xv
         v/TQ==
X-Gm-Message-State: AOAM531JPQUGbU065rf7r9XAY11DxWV95/xBJITWSqGQZRjuTmrHosT1
        ZduU3Yel6S8c4uCm8770CS0=
X-Google-Smtp-Source: ABdhPJxQY7yUiw79HkzXnSgtQxnTcWCyetEnB5yzFncWaRDkeWefmPRQgZcLK7ZQuCV+QkDOmqmirQ==
X-Received: by 2002:a62:8f96:0:b029:1b7:75a9:a8b7 with SMTP id n144-20020a628f960000b02901b775a9a8b7mr10430610pfd.28.1612052176690;
        Sat, 30 Jan 2021 16:16:16 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:16 -0800 (PST)
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
        Will Deacon <will@kernel.org>, Nick Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>
Subject: [RFC 10/20] mm: add pte_to_page()
Date:   Sat, 30 Jan 2021 16:11:22 -0800
Message-Id: <20210131001132.3368247-11-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Add a pte_to_page(), which is similar to pmd_to_page, which will be used
later.

Inline pmd_to_page() as well.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..d78a79fbb012 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2161,6 +2161,13 @@ static inline spinlock_t *ptlock_ptr(struct page *page)
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
+static inline struct page *pte_to_page(pte_t *pte)
+{
+	unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
+
+	return virt_to_page((void *)((unsigned long) pte & mask));
+}
+
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
 	return ptlock_ptr(pmd_page(*pmd));
@@ -2246,7 +2253,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static struct page *pmd_to_page(pmd_t *pmd)
+static inline struct page *pmd_to_page(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
 	return virt_to_page((void *)((unsigned long) pmd & mask));
-- 
2.25.1

