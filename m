Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0E310EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhBEPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:46:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:44422 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhBEPaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:30:21 -0500
IronPort-SDR: ecTRBCCI/0kQ8xOC7zVbyo36ZjArHoS9lHMN4op5UQx1Fll1pnlhKBhR3a0EIC1GzfU0XoFwZs
 su56m78q5nVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161198911"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161198911"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:48 -0800
IronPort-SDR: q7Q3i9vozj8sDWJ29m98QW/kh6uPo5gdVnuiVSBEnlnVm0Sa/QFVXswC/aPjxw1Gq46ZBttVQF
 AQTL4mzUhNvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="358274761"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2021 07:16:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 08F43397; Fri,  5 Feb 2021 17:16:41 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 7/9] x86/mm: Handle tagged memory accesses from kernel threads
Date:   Fri,  5 Feb 2021 18:16:28 +0300
Message-Id: <20210205151631.43511-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel thread performs memory access on behalf of a process (like
in async I/O, io_uring, etc.) it has to respect tagging setup of the
process as user addresses can include tags.

Normally, LAM setup is per-thread and recorded in thread flags, but for
this use case we also track LAM setup per-mm. mm->context.lam would
record LAM that allows the most tag bits among the threads of the mm.

The info used by switch_mm_irqs_off() to construct CR3 if the task is
kernel thread. Thread flags of the kernel thread get updated according
to mm->context.lam. It allows untagged_addr() to work correctly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h |  1 +
 arch/x86/mm/tlb.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 9257667d13c5..fb05d6a11538 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -35,6 +35,7 @@ typedef struct {
 #ifdef CONFIG_X86_64
 	/* True if mm supports a task running in 32 bit compatibility mode. */
 	unsigned short ia32_compat;
+	u8 lam;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 138d4748aa97..1f9749da12e4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -176,6 +176,34 @@ static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
 	if (!tsk)
 		return LAM_NONE;
 
+	if (tsk->flags & PF_KTHREAD) {
+		/*
+		 * For kernel thread use the most permissive LAM
+		 * used by the mm. It's required to handle kernel thread
+		 * memory accesses on behalf of a process.
+		 *
+		 * Adjust thread flags accodringly, so untagged_addr() would
+		 * work correctly.
+		 */
+		switch (mm->context.lam) {
+		case LAM_NONE:
+			clear_thread_flag(TIF_LAM_U48);
+			clear_thread_flag(TIF_LAM_U57);
+			return LAM_NONE;
+		case LAM_U57:
+			clear_thread_flag(TIF_LAM_U48);
+			set_thread_flag(TIF_LAM_U57);
+			return LAM_U57;
+		case LAM_U48:
+			set_thread_flag(TIF_LAM_U48);
+			clear_thread_flag(TIF_LAM_U57);
+			return LAM_U48;
+		default:
+			WARN_ON_ONCE(1);
+			return LAM_NONE;
+		}
+	}
+
 	if (test_ti_thread_flag(ti, TIF_LAM_U57))
 		return LAM_U57;
 	if (test_ti_thread_flag(ti, TIF_LAM_U48))
-- 
2.26.2

