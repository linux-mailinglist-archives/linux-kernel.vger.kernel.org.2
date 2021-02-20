Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A313207A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBTXZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBTXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:22:52 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B6C06178B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:26 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id m2so7781048pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgHqrRr6CuZt530hq+Km9+KaE5MUEF2093s2khoQ/QY=;
        b=CaB4ngBrBlrTSR+qEgl8jxpSTtJodehTAEbelMivJZDLXoZVMUEtt6/qLJJSvuI/8/
         CyZ6qyhyEdwcF9DrUOgXH1rVLLMiu+AmCYB8fOplpb16lTlSDGvSE8cFZuEwzQh7sasi
         kWhdj4BgKFLxPP1hytFEZeavWxq8FAmUFFLssL/U6KbMylGaErdpnmn/mWfXZkLS/z/8
         rPzyzY0WcFvgh8f+0wBXTLGxXU9k2d8yrDOKE/X7FdvHcHoyKXJfhAT+H6BRBUBCc+6v
         VH8TU6n+ooeOSIgft7GLpX/LwNeUSmWwLSzTWQ4RJ1G1dnGCuB7RppcF4HfJpqTk1Gr1
         /RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgHqrRr6CuZt530hq+Km9+KaE5MUEF2093s2khoQ/QY=;
        b=pNK8Mgwk7YZCdGEH8taOv/axrtodCpNq9ypz5d0reC5vhvDHz01ZUAXs9nR0272nXj
         EDOFEnzh7ZxN4zl+n20iOpJ50xv9NrtcOINDGyKaKcnJxKU/vS7GbJdYXZhb2Ea8pEJB
         NAPZu9qzG4WniG9qaI9jFiO+4GF5jZuRM2PuM0afl4Vmle947bgUGi+s8afEQAVsBLvJ
         x6SgQKLrUJkZy80UEdSFRsmqO8VHfA6zNEw5s2jP+lin9M8hYcA19hZU3pQ3KnqjnCeH
         9zvXyfjmja0XKZJcSMo89MTpJpwIKv/jY4yEX+bXqAnpystTEG/svZjULiRJ/i3+Zmrt
         rmiw==
X-Gm-Message-State: AOAM532rqXorvmnSwTZNdYHb1bZchlkYDnHLCsjtKZtPoNdv9fcCmDvY
        Oy6lRHJ1d41lluu10HYBFIqmHjZgg/Cv+A==
X-Google-Smtp-Source: ABdhPJwDVgsTea94CyWQURWYCqng4LUb7PS63eY9Qlv5pGYwS6yJhq4ZRq1fV4gtJ8jUjiKs4Ejxmg==
X-Received: by 2002:aa7:963b:0:b029:1ec:e3ae:3e57 with SMTP id r27-20020aa7963b0000b02901ece3ae3e57mr15565491pfg.78.1613863345967;
        Sat, 20 Feb 2021 15:22:25 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:25 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v6 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
Date:   Sat, 20 Feb 2021 15:17:06 -0800
Message-Id: <20210220231712.2475218-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Open-code on_each_cpu_cond_mask() in native_flush_tlb_others() to
optimize the code. Open-coding eliminates the need for the indirect branch
that is used to call is_lazy(), and in CPUs that are vulnerable to
Spectre v2, it eliminates the retpoline. In addition, it allows to use a
preallocated cpumask to compute the CPUs that should be.

This would later allow us not to adapt on_each_cpu_cond_mask() to
support local and remote functions.

Note that calling tlb_is_not_lazy() for every CPU that needs to be
flushed, as done in native_flush_tlb_multi() might look ugly, but it is
equivalent to what is currently done in on_each_cpu_cond_mask().
Actually, native_flush_tlb_multi() does it more efficiently since it
avoids using an indirect branch for the matter.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bf12371db6c4..07b6701a540a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -788,11 +788,13 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool tlb_is_not_lazy(int cpu)
 {
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
+static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
+
 STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
@@ -813,12 +815,37 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables) {
 		smp_call_function_many(cpumask, flush_tlb_func,
 			       (void *)info, 1);
-	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
-				(void *)info, 1, cpumask);
+	} else {
+		/*
+		 * Although we could have used on_each_cpu_cond_mask(),
+		 * open-coding it has performance advantages, as it eliminates
+		 * the need for indirect calls or retpolines. In addition, it
+		 * allows to use a designated cpumask for evaluating the
+		 * condition, instead of allocating one.
+		 *
+		 * This code works under the assumption that there are no nested
+		 * TLB flushes, an assumption that is already made in
+		 * flush_tlb_mm_range().
+		 *
+		 * cond_cpumask is logically a stack-local variable, but it is
+		 * more efficient to have it off the stack and not to allocate
+		 * it on demand. Preemption is disabled and this code is
+		 * non-reentrant.
+		 */
+		struct cpumask *cond_cpumask = this_cpu_ptr(&flush_tlb_mask);
+		int cpu;
+
+		cpumask_clear(cond_cpumask);
+
+		for_each_cpu(cpu, cpumask) {
+			if (tlb_is_not_lazy(cpu))
+				__cpumask_set_cpu(cpu, cond_cpumask);
+		}
+		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);
+	}
 }
 
 void flush_tlb_others(const struct cpumask *cpumask,
-- 
2.25.1

