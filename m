Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5399940E9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349394AbhIPShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:37:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:52262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348406AbhIPSh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:37:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="286319730"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="286319730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545819407"
Received: from rswart-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.64.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:02 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v7 03/12] x86/tdx: Introduce INTEL_TDX_GUEST config option
Date:   Thu, 16 Sep 2021 11:35:41 -0700
Message-Id: <20210916183550.15349-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 2b2a9639d8ae..6ed6afee0424 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -865,6 +865,20 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
 
+config INTEL_TDX_GUEST
+	bool "Intel Trusted Domain eXtensions Guest Support"
+	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
+	depends on SECURITY
+	select X86_X2APIC
+	select SECURITY_LOCKDOWN_LSM
+	help
+	  Provide support for running in a trusted domain on Intel processors
+	  equipped with Trusted Domain eXtensions. TDX is a new Intel
+	  technology that extends VMX and Memory Encryption with a new kind of
+	  virtual machine guest called Trust Domain (TD). A TD is designed to
+	  run in a CPU mode that protects the confidentiality of TD memory
+	  contents and the TD’s CPU state from other software, including VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
-- 
2.25.1

