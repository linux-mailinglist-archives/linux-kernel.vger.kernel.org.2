Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853EB36B893
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDZSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:22343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234288AbhDZSDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:32 -0400
IronPort-SDR: EIwMIS/QHzEQA/86PIg7vL+c4SqLU8FuWqvjmaw1nUfRYlhMvKMjjkDatER7odkec50BVdyuje
 QogY7eHhpYcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263253"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263253"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:49 -0700
IronPort-SDR: 3jWZ8EtxzHZBiFbjW+9c8U3Cl0QWi4h0JH9PK35KjuaU5Aus0UbfLOb+x2jHdXqNGrGd3Lf4u9
 gYxkZ3J0UOWw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353380"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:47 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 12/32] x86/tdx: Handle CPUID via #VE
Date:   Mon, 26 Apr 2021 11:01:39 -0700
Message-Id: <f1012bd41760f878eaf56c8f1abfe8b9120f56c9.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX has three classes of CPUID leaves: some CPUID leaves
are always handled by the CPU, others are handled by the TDX module,
and some others are handled by the VMM. Since the VMM cannot directly
intercept the instruction these are reflected with a #VE exception
to the guest, which then converts it into a TDCALL to the VMM,
or handled directly.

The TDX module EAS has a full list of CPUID leaves which are handled
natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by
the #VE method. In practice this typically only applies to the
hypervisor specific CPUIDs unknown to the native CPU.

Therefore there is no risk of causing this in early CPUID code which
runs before the #VE handler is set up because it will never access
those exotic CPUID leaves.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5b16707b3577..e42e260df245 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -174,6 +174,21 @@ static int tdg_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? -EIO : 0;
 }
 
+static void tdg_handle_cpuid(struct pt_regs *regs)
+{
+	u64 ret;
+	struct tdvmcall_output out = {0};
+
+	ret = __tdvmcall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
+
+	WARN_ON(ret);
+
+	regs->ax = out.r12;
+	regs->bx = out.r13;
+	regs->cx = out.r14;
+	regs->dx = out.r15;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -220,6 +235,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdg_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		tdg_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

