Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6729427796
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbhJIFj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:39:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:29176 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244323AbhJIFjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:39:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="225410045"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="225410045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="569280216"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:57 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Date:   Fri,  8 Oct 2021 22:37:38 -0700
Message-Id: <20211009053747.1694419-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add INTEL_TDX_GUEST config option to selectively compile
TDX guest support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Changes since v9:
 * None.

Changes since v8:
 * Used Extensions in place of eXtensions to maintain uniformity.
 * Removed "select SECURITY_LOCKDOWN_LSM" (it is no longer needed).
 * Replaced "select X86_X2APIC" with "depends X86_X2APIC".

Changes since v7:
 * None

Changes since v6:
 * None

Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * Removed PARAVIRT_XL from dependency list.
 * Fixed typo in help content.

 arch/x86/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2b2a9639d8ae..eab7f2911f94 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -865,6 +865,20 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
 
+config INTEL_TDX_GUEST
+	bool "Intel Trusted Domain Extensions (TDX) Guest Support"
+	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
+	depends on SECURITY
+	depends on X86_X2APIC
+	help
+	  Provide support for running in a trusted domain on Intel processors
+	  equipped with Trusted Domain Extensions. TDX is a Intel technology
+	  that extends VMX and Memory Encryption with a new kind of virtual
+	  machine guest called Trust Domain (TD). A TD is designed to run in
+	  a CPU mode that protects the confidentiality of TD memory contents
+	  and the TD’s CPU state from other software, including VMM. TDX guest
+	  uses virtual X2APIC for interrupt management.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
-- 
2.25.1

