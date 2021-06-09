Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701183A1DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFITvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:51:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:11979 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:51:34 -0400
IronPort-SDR: Usi+WKNsZf+JX/XipzQaBt8lNN8drlfVKvotgmdvgyHBNRiY4sIxexHsXoBk7jSbRaDjqVVn4p
 BMweIbZCVVTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192469527"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192469527"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 12:49:33 -0700
IronPort-SDR: JziMJckgPI74tyuIFYqThTQvGZ3ztNMP7bSUY40S8VzBYNyC237M5uCHlFGH7P1Uiny4fSlFkP
 qXCqli6r4l7Q==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402551963"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 12:49:32 -0700
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
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v5 1/1] x86: Skip WBINVD instruction for VM guest
Date:   Wed,  9 Jun 2021 12:49:26 -0700
Message-Id: <20210609194926.1949859-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com>
References: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM guests that supports ACPI, use standard ACPI mechanisms to
signal sleep state entry (including reboot) to the host. The
ACPI specification mandates WBINVD on any sleep state entry
with the expectation that the platform is only responsible for
maintaining the state of memory over sleep states, not
preserving dirty data in any CPU caches. ACPI cache flushing
requirements pre-date the advent of virtualization. Given guest
sleep state entry does not affect any host power rails it is not
required to flush caches. The host is responsible for maintaining
cache state over its own bare metal sleep state transitions that
power-off the cache. A TDX guest, unlike a typical guest, will
machine check if the CPU cache is powered off.
   
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v4:
 * Fixed commit log as per Dan's comments.
 * Used boot_cpu_has(X86_FEATURE_HYPERVISOR) instead of
   prot_guest_has(PR_GUEST_DISABLE_WBINVD) check.
   
Changes since RFC v2-fix-v3:
 * Fixed commit log as per review comments.
 * Instead of fixing all usages of ACPI_FLUSH_CPU_CACHE(),
   created TDX specific exception for it in its implementation.

Changes since RFC v2-fix-v2:
 * Instead of handling WBINVD #VE exception as nop, we skip its
   usage in currently enabled drivers.
 * Adapted commit log for above change.

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

