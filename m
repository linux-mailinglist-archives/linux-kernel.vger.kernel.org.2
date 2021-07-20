Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E093CF35A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbhGTDxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:53:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:61766 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhGTDxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:53:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190760791"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="190760791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:33:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="661016026"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:33:44 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] x86/tdx: Add tdg_debug_enabled() interface
Date:   Mon, 19 Jul 2021 21:33:38 -0700
Message-Id: <20210720043338.2123695-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720043338.2123695-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720043338.2123695-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A guest TD is defined as debuggable if its ATTRIBUTES.DEBUG bit is 1.
In this mode, the host VMM can use Intel TDX functions to access
secret TD state that is not accessible for non-debuggable TDs. A
debuggable TD is, by nature, untrusted.

Since the TD’s ATTRIBUTES are included in the TDG.MR.REPORT, the TD’s
debuggability state can be known to any third party to which the TD
attests. TD Attributes are initialized during TD INIT call. You can get
more details about debug features in Intel Trust Domain Extensions
(Intel TDX) Module Architecture specification, sec 13.3.

Add a new interface to detect the TDX debug mode. This will be used by
follow-on patches. Examples of its usage are, when adding command line
debug options to disable TDX features like driver or port filter,
tdg_debug_enabled() is used to make sure it is used only in debug
mode.

https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1eas-v0.85.039.pdf

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h | 1 +
 arch/x86/kernel/tdx.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 665c8cf57d5b..1c0d4bf693a3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,7 @@ enum tdx_map_type {
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+bool tdg_debug_enabled(void);
 void __init tdx_early_init(void);
 
 bool tdx_prot_guest_has(unsigned long flag);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 9b0361218863..fcf2743481b7 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -123,6 +123,11 @@ phys_addr_t tdg_shared_mask(void)
 	return 1ULL << (td_info.gpa_width - 1);
 }
 
+bool tdg_debug_enabled(void)
+{
+	return td_info.attributes & BIT(0);
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
-- 
2.25.1

