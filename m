Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0483A0617
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhFHVhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:37:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:21257 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhFHVhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:37:38 -0400
IronPort-SDR: AA94kYoxxZVcGAnuPlAItax/XF3MdGv1Ta+EYYxT52OgP1x44g+wcx/K5CC5mZVtsfBx1iyTiv
 K564Sk57L7iQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204970474"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="204970474"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:35:43 -0700
IronPort-SDR: BZ08dDOVR4ubPR8/rNvAok8ee6i0cPyb6OnYbiiTVrVrjhqcXWa97SA+8uspu1iaD5zwtqtFhl
 OXtaCStcPjYw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551751048"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:35:42 -0700
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
Subject: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
Date:   Tue,  8 Jun 2021 14:35:27 -0700
Message-Id: <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current TDX spec does not have support to emulate the WBINVD
instruction. So, add support to skip WBINVD instruction in
drivers that are currently enabled in the TDX guest.

Functionally only devices outside the CPU (such as DMA devices,
or persistent memory for flushing) can notice the external side
effects from WBINVD's cache flushing for write back mappings.
One exception here is MKTME, but that is not visible outside
the TDX module and not possible inside a TDX guest.

Currently TDX does not support DMA, because DMA typically needs
uncached access for MMIO, and the current TDX module always
sets the IgnorePAT bit, which prevents that.
   
Persistent memory is also currently not supported. Another code
path that uses WBINVD is the MTRR driver, but EPT/virtualization
always disables MTRRs so those are not needed. This all implies
WBINVD is not needed with current TDX.

So, most drivers/code-paths that use wbinvd instructions are
already disabled for TDX guest platforms via config-option/BIOS.
Following are the list of drivers that use wbinvd instruction
and are still enabled for TDX guests.
   
drivers/acpi/sleep.c
drivers/acpi/acpica/hwsleep.c
   
Since cache is always coherent in TDX guests, making wbinvd as
noop should not cause any issues. This behavior is the same as
KVM guest.
   
Also, hwsleep shouldn't happen for TDX guest because the TDX
BIOS won't enable it, but it's better to disable it anyways

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v2:
 * Instead of handling WBINVD #VE exception as nop, we skip its
   usage in currently enabled drivers.
 * Adapted commit log for above change.

 arch/x86/kernel/tdx.c           |  1 +
 drivers/acpi/acpica/hwsleep.c   | 12 +++++++++---
 drivers/acpi/sleep.c            | 26 +++++++++++++++++++++++---
 include/linux/protected_guest.h |  2 ++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 1caf9fa5bb30..e33928131e6a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -100,6 +100,7 @@ bool tdx_protected_guest_has(unsigned long flag)
 	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
 	case PR_GUEST_UNROLL_STRING_IO:
 	case PR_GUEST_SHARED_MAPPING_INIT:
+	case PR_GUEST_DISABLE_WBINVD:
 		return true;
 	}
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 14baa13bf848..9d40df1b8a74 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -9,6 +9,7 @@
  *****************************************************************************/
 
 #include <acpi/acpi.h>
+#include <linux/protected_guest.h>
 #include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -108,9 +109,14 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 	pm1a_control |= sleep_enable_reg_info->access_bit_mask;
 	pm1b_control |= sleep_enable_reg_info->access_bit_mask;
 
-	/* Flush caches, as per ACPI specification */
-
-	ACPI_FLUSH_CPU_CACHE();
+	/*
+	 * WBINVD instruction is not supported in TDX
+	 * guest. Since ACPI_FLUSH_CPU_CACHE() uses
+	 * WBINVD, skip cache flushes for TDX guests.
+	 */
+	if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
+		/* Flush caches, as per ACPI specification */
+		ACPI_FLUSH_CPU_CACHE();
 
 	status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
 	if (status == AE_CTRL_TERMINATE) {
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index df386571da98..3d6c213481f0 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -18,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/syscore_ops.h>
+#include <linux/protected_guest.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
 
@@ -71,7 +72,14 @@ static int acpi_sleep_prepare(u32 acpi_state)
 		acpi_set_waking_vector(acpi_wakeup_address);
 
 	}
-	ACPI_FLUSH_CPU_CACHE();
+
+	/*
+	 * WBINVD instruction is not supported in TDX
+	 * guest. Since ACPI_FLUSH_CPU_CACHE() uses
+	 * WBINVD, skip cache flushes for TDX guests.
+	 */
+	if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
+		ACPI_FLUSH_CPU_CACHE();
 #endif
 	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
 		acpi_state);
@@ -566,7 +574,13 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	u32 acpi_state = acpi_target_sleep_state;
 	int error;
 
-	ACPI_FLUSH_CPU_CACHE();
+	/*
+	 * WBINVD instruction is not supported in TDX
+	 * guest. Since ACPI_FLUSH_CPU_CACHE() uses
+	 * WBINVD, skip cache flushes for TDX guests.
+	 */
+	if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
+		ACPI_FLUSH_CPU_CACHE();
 
 	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
 	switch (acpi_state) {
@@ -899,7 +913,13 @@ static int acpi_hibernation_enter(void)
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FLUSH_CPU_CACHE();
+	/*
+	 * WBINVD instruction is not supported in TDX
+	 * guest. Since ACPI_FLUSH_CPU_CACHE() uses
+	 * WBINVD, skip cache flushes for TDX guests.
+	 */
+	if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
+		ACPI_FLUSH_CPU_CACHE();
 
 	/* This shouldn't return.  If it returns, we have a problem */
 	status = acpi_enter_sleep_state(ACPI_STATE_S4);
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index adfa62e2615e..0ec4dab86f67 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -18,6 +18,8 @@
 #define PR_GUEST_HOST_MEM_ENCRYPT		0x103
 /* Support for shared mapping initialization (after early init) */
 #define PR_GUEST_SHARED_MAPPING_INIT		0x104
+/* Support to disable WBINVD */
+#define PR_GUEST_DISABLE_WBINVD			0x105
 
 #if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
 
-- 
2.25.1

