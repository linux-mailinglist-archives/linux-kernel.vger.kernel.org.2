Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991EE436B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhJUTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhJUTzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:55:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD88C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j190so1307309pgd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2owe5n0pN7M447a4f5gtFpdAO84GGDezTjkbshsV/5A=;
        b=NJDNLISDqCS6DWtuKe+YL6u25O9QPnbwfEMv6fi/FTzhN7VZCfvtRP1YGKBc0+XjMh
         YCazBLUWtRkWc81D2XisUekNzNGZaZaRAzPypK2TOhTwjkA/YUpKCRlrLvtfrQM5Pna6
         OryIRAJXIdg5dmnUvNdYU7M0QYPu9QFqpiRmNRY0U5mYE5NsJZOIMzM+a3ROsX7Vumyb
         1M0zHT3yzYTM1R3GOd2RDmG99sGCnvZCnjZ1jWU7BEQssUH2pLHmL6SJ+O4x90sMvFGB
         JO/Ut/ZDjB7YA0eUMqECF9o/RU7AsYnkSG+l2ESCEmCFZWO0AcsdEVfdHTAwybrMkUwG
         bT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2owe5n0pN7M447a4f5gtFpdAO84GGDezTjkbshsV/5A=;
        b=Mx31s+OTNxgb6Prgu80EMLgFzx5O9JEfDlyNSSvyrCitoA3qDz6aul/sWWs+b7ua+a
         2VHNsg/5SjfIhCc/1SXGmX7fzHLkGmg9tZINB1l/nLGGnv6hJSWDxQ+UH416+O7PUmFm
         bWONlUbUl1usK5JGBk/3KbsYLdosyu7CW/9S39a0fJfFSZntRrfiL0WRbWrHnjRIy83Q
         aDCesH9hlfXFxCHkAExcYoqIkbJ9Om8x8ofc8ScKJRubcF/LLJHS/9Eh8NgExd7n+l7M
         dJwpl+UOdYdiyDbKti3zhRuwKDfFwy9KnLdQ7lXbiI2XmPRkHiFj/j0WXoUAcMj/mQkq
         qXyg==
X-Gm-Message-State: AOAM530emFvz7MVBGE9RyTanGWyCIOKB9AlgZeAlq1oYANUIBSVguoAx
        TTklEqeWQh/hEwZ+iPg3bDI=
X-Google-Smtp-Source: ABdhPJwDn3L/Z/hX4WazYQ273fY7J6ervyUBeTkfMNwrqmDOEOlhO9clSXfesU4EUXHWpvcLXdAWhg==
X-Received: by 2002:a63:9554:: with SMTP id t20mr5888260pgn.153.1634845968105;
        Thu, 21 Oct 2021 12:52:48 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n202sm7098078pfd.160.2021.10.21.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:52:47 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v2 1/5] x86: Detection of Knights Landing A/D leak
Date:   Thu, 21 Oct 2021 05:21:08 -0700
Message-Id: <20211021122112.592634-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021122112.592634-1-namit@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Knights Landing has a issue that a thread setting A or D bits may not do
so atomically against checking the present bit.  A thread which is going
to page fault may still set those bits, even though the present bit was
already atomically cleared.

This implies that when the kernel clears present atomically, some time
later the supposed to be zero entry could be corrupted with stray A or D
bits.

Since the PTE could be already used for storing a swap index, or a NUMA
migration index, this cannot be tolerated. Most of the time the kernel
detects the problem, but in some rare cases it may not.

This patch adds an interface to detect the bug, which will be used in
the following patch.

[ Based on a patch by Andi Kleen ]

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Link: https://lore.kernel.org/lkml/1465919919-2093-1-git-send-email-lukasz.anaczkowski@intel.com/
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/intel.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..32d0aabd788d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -436,5 +436,6 @@
 #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
+#define X86_BUG_PTE_LEAK		X86_BUG(25) /* PTE may leak A/D bits after clear */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..40bcba6e3641 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -296,6 +296,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		}
 	}
 
+	if (c->x86_model == 87) {
+		pr_info_once("Enabling PTE leaking workaround\n");
+		set_cpu_bug(c, X86_BUG_PTE_LEAK);
+	}
+
 	/*
 	 * Intel Quark Core DevMan_001.pdf section 6.4.11
 	 * "The operating system also is required to invalidate (i.e., flush)
-- 
2.25.1

