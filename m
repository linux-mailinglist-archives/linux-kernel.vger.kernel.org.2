Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844738F645
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhEXXeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:34:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:39314 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhEXXdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:33:53 -0400
IronPort-SDR: xmGw6oaexb+x57fZxGQqJq/YHAzkn7G4oJc2Br+9i1XU44ijVDqzZRu9qXe5eINOrDujpyIpE9
 SxjDiBFTEJGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="202074825"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="202074825"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 16:32:24 -0700
IronPort-SDR: tMMpTMnSpbpiKlV23esSQpMsNXGRomnh7I0F2BjF87tgEUs7nWFjv+NUOjyJql7bGB9gjztE24
 pzLBDuMWpa9w==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="476126864"
Received: from eyoukerh-mobl.ger.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.2.69])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 16:32:23 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
Date:   Mon, 24 May 2021 16:32:11 -0700
Message-Id: <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionally only DMA devices can notice a side effect from
WBINVD's cache flushing. But, TDX does not support DMA,
because DMA typically needs uncached access for MMIO, and
the current TDX module always sets the IgnorePAT bit, which
prevents that.

So handle the WBINVD instruction as nop. Currently, we did
not include any warning for WBINVD handling because ACPI
reboot code uses it. This is the same behavior as KVM. It only
allows WBINVD in a guest when the guest supports VT-d (=DMA),
but just handles it as a nop if it doesn't .

If TDX ever gets DMA support, a hypercall will be added to
implement it similar to AMD-SEV. But current TDX does not
support direct DMA.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Fixed commit log as per review comments.
 * Removed WARN_ONCE for WBINVD #VE support.

 arch/x86/kernel/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3800c7cbace3..21dec5bfc88e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -511,6 +511,12 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * Non coherent DMA is not supported in TDX guest.
+		 * So ignore WBINVD and treat it nop.
+		 */
+		break;
 	case EXIT_REASON_MONITOR_INSTRUCTION:
 	case EXIT_REASON_MWAIT_INSTRUCTION:
 		/*
-- 
2.25.1

