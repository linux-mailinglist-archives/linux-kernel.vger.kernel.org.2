Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9F392687
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhE0EkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:40:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:31721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhE0EkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:40:10 -0400
IronPort-SDR: GckvqPwhQfR3/nkCbmjh1rzSSM9HYahsXYq65aHUOeL2HkOqWa8MT69CUuqReErJXDLl/XMNbH
 h/5q2rNc4SNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202656978"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202656978"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:38:37 -0700
IronPort-SDR: g83o+XloVPGxzzZaoUTwmeTd71P9I3/YL/cvfT93jxxxl0WwI0b4XYfQupjq6NJEPGNYcAwZY2
 KtSJxorKS6Kw==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="414739626"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:38:36 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v3 1/1] x86/tdx: Ignore WBINVD instruction for TDX guest
Date:   Wed, 26 May 2021 21:38:32 -0700
Message-Id: <20210527043832.3984374-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fe11bf3c-c0f8-7c25-8fc0-99bee9c1d164@linux.intel.com>
References: <fe11bf3c-c0f8-7c25-8fc0-99bee9c1d164@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionally only devices outside the CPU (such as DMA devices,
or persistent memory for flushing) can notice the external side
effects from WBINVD's cache flushing for write back mappings. One
exception here is MKTME, but that is not visible outside the TDX
module and not possible inside a TDX guest.

Currently TDX does not support DMA, because DMA typically needs
uncached access for MMIO, and the current TDX module always sets
the IgnorePAT bit, which prevents that.

Persistent memory is also currently not supported. There are some
other cases that use WBINVD, such as the legacy ACPI sleeps, but
these are all not supported in virtualization and there are better
mechanisms inside a guest anyways. The guests usually are not
aware of power management. Another code path that uses WBINVD is
the MTRR driver, but EPT/virtualization always disables MTRRs so
those are not needed. This all implies WBINVD is not needed with
current TDX. 

So handle the WBINVD instruction as nop. Currently, #VE exception
handler does not include any warning for WBINVD handling because
ACPI reboot code uses it. This is the same behavior as KVM. It
only allows WBINVD in a guest when the guest supports VT-d (=DMA),
but just handles it as a nop if it doesn't .

If TDX ever gets DMA support, or persistent memory support, or
some other devices that can observe flushing side effects, a
hypercall can be added to implement it similar to AMD-SEV. But
current TDX does not need it.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-2:
 * Added more details to commit log and comments to address
   review comments.

Changes since RFC v2:
 * Fixed commit log as per review comments.
 * Removed WARN_ONCE for WBINVD #VE support.

 arch/x86/kernel/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index da5c9cd08299..775ae090b625 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -455,6 +455,13 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * Non coherent DMA, persistent memory, MTRRs or
+		 * outdated ACPI sleeps are not supported in TDX guest.
+		 * So ignore WBINVD and treat it nop.
+		 */
+		break;
 	case EXIT_REASON_MONITOR_INSTRUCTION:
 	case EXIT_REASON_MWAIT_INSTRUCTION:
 		/*
-- 
2.25.1

