Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2453118A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBFCnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:43:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:27618 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhBFCeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:34:50 -0500
IronPort-SDR: eRN1YixRIJAagRKIbxtweC5A5cEQ//VQeKjVAKXS4IWEBZALNA3ELOEvTIYq5ONspuHu71n4sy
 MYk00cE+YM9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650750"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650750"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:14 -0800
IronPort-SDR: vY8pwvgPQJx17GXjMXiDeoILXivFyQ+DARyL2kzWmj+3hJHzNx3wgJYNjinKQSTNidFrMwTJMK
 UvWvh8hq4DTg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183966"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:14 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 19/26] x86/tdx: Forcefully disable legacy PIC for TDX guests
Date:   Fri,  5 Feb 2021 15:38:36 -0800
Message-Id: <4209dc6ec33a0a78f8be20b6ee05914ab447ddc7.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Disable the legacy PIC (8259) for TDX guests as the PIC cannot be
supported by the VMM. TDX Module does not allow direct IRQ injection,
and using posted interrupt style delivery requires the guest to EOI
the IRQ, which diverges from the legacy PIC behavior.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index a36b6ae14942..ae37498df981 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,7 @@
 #include <asm/tdx.h>
 #include <asm/cpufeature.h>
 #include <linux/cpu.h>
+#include <asm/i8259.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
@@ -410,6 +411,8 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdx_safe_halt;
 	pv_ops.irq.halt = tdx_halt;
 
+	legacy_pic = &null_legacy_pic;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
 			  NULL, tdx_cpu_offline_prepare);
 
-- 
2.25.1

