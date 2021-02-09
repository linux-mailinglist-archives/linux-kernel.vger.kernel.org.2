Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840E315BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBJBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhBIWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34102C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm1so2377388pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgHqrRr6CuZt530hq+Km9+KaE5MUEF2093s2khoQ/QY=;
        b=IAjyxHZHeBJtVGL0XZhb/oAZ72pzHqT1A2ajVbXh6QUrBwxENYHqy6nIv+E6ZD8Vpx
         +qW7gT8G4xVD42MYbT9RoTaK60k+phOLnHVAmX9nbc7oukmT+PIRt/DlkzJxeWQE+5ai
         EBDWQtRTAukBUKG8/MFr7Bs5BxY40YqymPAcESDfLc6n3lEC8QeK79GQbNciviSFWBqe
         P11P9mAG6jyj/UdRv394dCTVRhg6IhaT5rLtyfshBQbYLC/7T/CaJRQQGtTgG8JBH788
         7Oyyk0pbRJwEdexTe0/HVqoGAcKw5SjM+TPUuU8O88NuZHpvyZmlVeJlXV6P5nIlXYwl
         dBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgHqrRr6CuZt530hq+Km9+KaE5MUEF2093s2khoQ/QY=;
        b=TnYYj3d2uw6ymP1W5yZ50mxBiUrYrKiOa2ogNbL3NR1BAHqDpuXXdSrT01YQmY40WW
         SrFs2UKNVdFVgeWH7ZcHgFu1OFK/rzHWwDoItvIwSu9QTsBz5VSNQ4aJg6FVZzLxP3vt
         MRqG5A5TE/LIb4ZkySkUKCBu/pR1nqaNJ20+D1efV4qHUSdTXRGVetLhQpytV12qM+i6
         qQpIP8eoHO0K3lxU/iUbcvVmlHH5rn+QwfIz7Un/MJGFtmhPPOnQqXrwG4mwvKQQ6iPA
         JrCdCgdRpNW65NpxArRPgFhQrzpv+Smpw4aC3/qakpnLtKowdzh4npsHXQHq1vd0W5a/
         lFsQ==
X-Gm-Message-State: AOAM5325rLTj5gYu52VK5b1w8MN/kdokFqH6AcNCnr/75nxM8V6jIh+g
        ORdfLHzMl7bdiZsdgqRFxP0=
X-Google-Smtp-Source: ABdhPJwMcUR/J/a3pGFuJX/JLVRXe44Dh6sRzNOUKZ1DYbyNLQqMWoXSGMFQpNmWYKAVAP51bsGp/w==
X-Received: by 2002:a17:902:c40a:b029:e2:9a65:ffec with SMTP id k10-20020a170902c40ab02900e29a65ffecmr57097plk.42.1612909279591;
        Tue, 09 Feb 2021 14:21:19 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:19 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 3/8] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
Date:   Tue,  9 Feb 2021 14:16:48 -0800
Message-Id: <20210209221653.614098-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
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

