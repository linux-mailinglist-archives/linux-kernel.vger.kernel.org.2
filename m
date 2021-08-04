Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD03E08D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhHDT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:28:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:42526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240740AbhHDT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:28:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235953247"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="235953247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="585563771"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:50 -0700
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
Subject: [PATCH v4 5/5] x86: Skip WBINVD instruction for VM guest
Date:   Wed,  4 Aug 2021 12:27:28 -0700
Message-Id: <20210804192729.2902472-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804192729.2902472-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210804192729.2902472-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM guests that supports ACPI, use standard ACPI mechanisms to signal
sleep state entry (including reboot) to the host. The ACPI
specification mandates WBINVD on any sleep state entry with the
expectation that the platform is only responsible for maintaining the
state of memory over sleep states, not preserving dirty data in any
CPU caches. ACPI cache flushing requirements pre-date the advent of
virtualization. Given guest sleep state entry does not affect any
host power rails it is not required to flush caches. The host is
responsible for maintaining cache state over its own bare metal sleep
state transitions that power-off the cache. A TDX guest, unlike a
typical guest, will machine check if the CPU cache is powered off.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * None

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

