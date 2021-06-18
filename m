Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5C3AD58F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhFRXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:00:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:13194 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235149AbhFRXAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:45 -0400
IronPort-SDR: FuFGBJzkn2YOe8yiXBdFM2nYaL+yb/3SyZpZPKbOn3BiUqm31V70+rroAKWD/uIEtPWROPQJt6
 rggGoTv+PtWw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763409"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763409"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:35 -0700
IronPort-SDR: AmZL0dnfNF0EdBs2H7a9HjrfttGNfs/zkkNkcI71ucMeZ6mgKRHp1gb83i3lkYH4u/80T1zhOf
 5cO1c6BeVAvg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874161"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:34 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Date:   Fri, 18 Jun 2021 15:57:46 -0700
Message-Id: <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..ff79263aebd1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -876,6 +876,21 @@ config ACRN_GUEST
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
+	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
+	  technology that extends VMX and Memory Encryption with a new kind of
+	  virtual machine guest called Trust Domain (TD). A TD is designed to
+	  run in a CPU mode that protects the confidentiality of TD memory
+	  contents and the TD’s CPU state from other software, including VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
-- 
2.25.1

