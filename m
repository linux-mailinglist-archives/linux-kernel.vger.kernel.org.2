Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956AF31210C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBGDMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:12:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:9985 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBGDL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:11:56 -0500
IronPort-SDR: pVmOP7opvmo4cavU+HmVQKlF25tlDeGN+0OeNIxIZzZQxFHuvwv0oORHg572D+Ad/D83N0FBp4
 ESIkHhfGWvgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="161331940"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="161331940"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:11:16 -0800
IronPort-SDR: tOeBzsBYo3XBvF5jJdFbV4b+Dt8UloADWqom242vdVgv2I6LYB16UbzLxyQnYvc5rzBOXEXxDs
 qJjxb2tey3Gg==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="584618099"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:11:11 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v9 04/18] x86/acrn: Introduce hypercall interfaces
Date:   Sun,  7 Feb 2021 11:10:26 +0800
Message-Id: <20210207031040.49576-5-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210207031040.49576-1-shuo.a.liu@intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The Service VM communicates with the hypervisor via conventional
hypercalls. VMCALL instruction is used to make the hypercalls.

ACRN hypercall ABI:
  * Hypercall number is in R8 register.
  * Up to 2 parameters are in RDI and RSI registers.
  * Return value is in RAX register.

Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
register as direct register constraints, use supported constraint as
input with a explicit MOV to R8 in beginning of asm.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 127f20672c5d..e003a01b7c67 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -21,4 +21,58 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
+/*
+ * Hypercalls for ACRN
+ *
+ * - VMCALL instruction is used to implement ACRN hypercalls.
+ * - ACRN hypercall ABI:
+ *   - Hypercall number is passed in R8 register.
+ *   - Up to 2 arguments are passed in RDI, RSI.
+ *   - Return value will be placed in RAX.
+ *
+ * Because GCC doesn't support R8 register as direct register constraints, use
+ * supported constraint as input with a explicit MOV to R8 in beginning of asm.
+ */
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id)
+		     : "r8", "memory");
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id), "D" (param1)
+		     : "r8", "memory");
+
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id), "D" (param1), "S" (param2)
+		     : "r8", "memory");
+
+	return result;
+}
+
 #endif /* _ASM_X86_ACRN_H */
-- 
2.28.0

