Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F863CF18B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbhGTBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:00:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:28283 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378166AbhGTAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:10:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191435145"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="191435145"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="660970644"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:08 -0700
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
Subject: [PATCH v4 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Date:   Mon, 19 Jul 2021 17:40:48 -0700
Message-Id: <20210720004057.2112666-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v3:
 * Removed PARAVIRT_XL from dependency list.
 * Fixed typo in help content.

 arch/x86/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e47213cbfc55..abb3ffc7d041 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -866,6 +866,20 @@ config ACRN_GUEST
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

