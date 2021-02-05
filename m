Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2F3118FF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhBFCwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:52:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:27691 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBFCgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:36:00 -0500
IronPort-SDR: Fp1WyDgbK7CDSDMaY3t1qNulgWKJb2J8r+1COOz90WYnZirGcOyi3u9Ptqx+cntAS0nUoMIUTG
 snw3XU5GsKtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650752"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:15 -0800
IronPort-SDR: 1AEfRPhU3cj3TfK3NhczIbUcPp1G1NbCTdIldeMoc6Ujg+hgZs8Uyw+Mmbm6OpL8SPPKNh4BAu
 fAlI+uV1KUvw==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183970"
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 20/26] x86/tdx: Introduce INTEL_TDX_GUEST config option
Date:   Fri,  5 Feb 2021 15:38:37 -0800
Message-Id: <87aeb7541b323be178d1f1fb8a5a8b1f4b1faa94.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
 arch/x86/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8fe91114bfee..0374d9f262a5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -868,6 +868,21 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
 
+config INTEL_TDX_GUEST
+	bool "Intel Trusted Domain eXtensions Guest Support"
+	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
+	depends on SECURITY
+	select PARAVIRT_XL
+	select X86_X2APIC
+	select SECURITY_LOCKDOWN_LSM
+	help
+	  Provide support for running in a trusted domain on Intel processors
+	  equipped with Trusted Domain eXtenstions. TDX is an new Intel
+	  technology that extends VMX and Memory Encryption with a new kind of
+	  virtual machine guest called Trust Domain (TD). A TD is designed to
+	  run in a CPU mode that protects the confidentiality of TD memory
+	  contents and the TD’s CPU state from other software, including VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
-- 
2.25.1

