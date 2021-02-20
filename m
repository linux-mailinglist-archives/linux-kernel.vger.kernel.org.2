Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271F53207B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBTXbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBTXXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:23:19 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D841C0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 189so4291430pfy.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JGB1oXcTP6A9qfRlJJHY1vEAgYu+PGPpWjnbejswhI=;
        b=PaajKGy553lkCbsCnUfhwWlEOK6SRkLYpM8aWlfxQ1XAwtXaDHVJiiM1PiIorA5prK
         /WZMWtfm1AnmBcyhZP9yTphAjpqfRA9wsq6cYgNDa9p39D18eE7xjLNy0kWA54q84hMa
         DnxXsW/UAj+rmaEX0brpipL36pSp7k1B9o8dfSUNfS0FoAXSVNCmtSlQimPjw68hqvyN
         KeqQuutFLBbYC8y3R5AnLlODfDSoX/kjUYoyaJ/4q1lrkj37k94zR9WXWsdIqY5eR6J1
         z9aHWgSXh5fNIFqKvd/QaSq/9mWrqnr6doU3NiOKT8Lk5NjTeFEJ1GtbKjdrN/F5xpJ3
         bb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JGB1oXcTP6A9qfRlJJHY1vEAgYu+PGPpWjnbejswhI=;
        b=oK92t/wW1+zFq+iLucLMGAt78i5oSqEHjIBfjLeAYpD9vWsE/s5QYKVXv/uSj1/7Ar
         6CyCPe/vgaj11udo7Q13Y7hu6F7xFB8vLr3NVzOruqJ1UZpKLliG/jOk57ciRUB3v0Zr
         dQF1ZrOjaCZwHHK/rXMvG8JFU2XplgKMNPjQYSXbch49rzSf6j+RCUoEKi8EsWJvbHEb
         m0fPf8QQBeM+3jQbYpWVG7gmm+dLDUxVb2vbq4DF0XbamK+J1w765fqBJw9u3CuMZ+mc
         jgLL8Dk064emWNbcaO7Qg296iHvHlts3I3hQ8MAlXQFfgxbcXhmz1JPJP95yezBaL+gS
         01Lw==
X-Gm-Message-State: AOAM530UO2s6Ob+if+mfHNkr+cUPQWekQxp68ULCwV4G1RDJuABaKnl5
        cDDs0ycDutD2egK4R+nq2Tz1BfHi7URxMw==
X-Google-Smtp-Source: ABdhPJxLsF5MraGiEpfjn7UzH7bpjhzdpLz3RCpIJFtRapoOUGIE7G56p5H1HvrY0C2YsFiXLK7GqQ==
X-Received: by 2002:aa7:991c:0:b029:1e8:b29:cd69 with SMTP id z28-20020aa7991c0000b02901e80b29cd69mr8296832pff.50.1613863352804;
        Sat, 20 Feb 2021 15:22:32 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:32 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v6 8/9] x86/mm/tlb: Remove unnecessary uses of the inline keyword
Date:   Sat, 20 Feb 2021 15:17:11 -0800
Message-Id: <20210220231712.2475218-9-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The compiler is smart enough without these hints.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 17ec4bfeee67..f4b162f273f5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,7 +316,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
@@ -880,7 +880,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
 static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 #endif
 
-static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
@@ -907,7 +907,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	return info;
 }
 
-static inline void put_flush_tlb_info(void)
+static void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
 	/* Complete reentrency prevention checks */
-- 
2.25.1

