Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968FB45219A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbhKPBFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:05:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:30901 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245604AbhKPA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:57:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="297013467"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="297013467"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:50:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454247909"
Received: from asu1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.192])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:50:38 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] x86: Skip WBINVD instruction for VM guest
Date:   Mon, 15 Nov 2021 16:50:27 -0800
Message-Id: <20211116005027.2929297-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI mandates that CPU caches be flushed before entering any sleep
state. This ensures that the CPU and its caches can be powered down
without losing data.

ACPI-based VMs have maintained this sleep-state-entry behavior.
However, cache flushing for VM sleep state entry is useless. Unlike on
bare metal, guest sleep states are not correlated with potential data
loss of any kind; the host is responsible for data preservation. In
fact, some KVM configurations simply skip the cache flushing
instruction (see need_emulate_wbinvd()).

Further, on TDX systems, the WBINVD instruction causes an
unconditional #VE exception.  If this cache flushing remained, it would
need extra code in the form of a #VE handler.

All use of ACPI_FLUSH_CPU_CACHE() appears to be in sleep-state-related
code.

This means that the ACPI use of WBINVD is at *best* superfluous.

Disable ACPI CPU cache flushing on all X86_FEATURE_HYPERVISOR systems,
which includes TDX.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/acenv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..d4162e94bee8 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
 #define _ASM_X86_ACENV_H
 
 #include <asm/special_insns.h>
+#include <asm/cpu.h>
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()				\
+do {							\
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();				\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
-- 
2.25.1

