Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730740041A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbhICR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:29:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:65004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350257AbhICR3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:29:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206593433"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206593433"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="534222206"
Received: from dlinsen-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.56.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:21 -0700
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
Subject: [PATCH v6 00/11] Add TDX Guest Support (Initial support)
Date:   Fri,  3 Sep 2021 10:28:01 -0700
Message-Id: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. This series adds the basic TDX guest
infrastructure support (including #VE handler support, and #VE support
for halt and CPUID). This is just a subset of patches in the bare minimum
TDX support patch list which is required for supporting minimal
functional TDX guest. Other basic feature features like #VE support for
IO, MMIO, boot optimization fixes and shared-mm support will be submitted
in a separate patch set. To make reviewing easier we split it into smaller
series. This series alone is not necessarily fully functional.

Also, the host-side support patches, and support for advanced TD guest
features like attestation or debug-mode will be submitted at a later time.
Also, at this point it is not secure with some known holes in drivers, and
also hasn’t been fully audited and fuzzed yet.

TDX has a lot of similarities to SEV. It enhances confidentiality and
of guest memory and state (like registers) and includes a new exception
(#VE) for the same basic reasons as SEV-ES. Like SEV-SNP (not merged
yet), TDX limits the host's ability to effect changes in the guest
physical address space. With TDX the host cannot access the guest memory,
so various functionality that would normally be done in KVM has moved
into a (paravirtualized) guest. Partially this is done using the
Virtualization Exception (#VE) and partially with direct paravirtual hooks.

The TDX architecture also includes a new CPU mode called
Secure-Arbitration Mode (SEAM). The software (TDX module) running in this
mode arbitrates interactions between host and guest and implements many of
the guarantees of the TDX architecture.

Some of the key differences between TD and regular VM is,

1. Multi CPU bring-up is done using the ACPI MADT wake-up table.
2. A new #VE exception handler is added. The TDX module injects #VE exception
   to the guest TD in cases of instructions that need to be emulated, disallowed
   MSR accesses, etc.
3. By default memory is marked as private, and TD will selectively share it with
   VMM based on need.
   
Note that the kernel will also need to be hardened against low level inputs from
the now untrusted hosts. This will be done in follow on patches.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

This patchset has dependency on protected guest changes submitted by Tom Lendacky

https://lore.kernel.org/patchwork/cover/1468760/

Changes since v5:
 * Moved patch titled "x86/tdx: Get TD execution environment
   information via TDINFO" to the series which uses it.
 * Rest of the change log is added per patch.

Changes since v4:
 * Added a patch that adds TDX guest exception for CSTAR MSR.
 * Rebased on top of Tom Lendacky's protected guest changes.
 * Rest of the change log is added per patch.

Changes since v3:
 * Moved generic protected guest changes from patch titled "x86:
   Introduce generic protected guest abstraction" into seperate
   patch outside this patchset. Also, TDX specific changes are
   moved to patch titled "x86/tdx: Add protected guest support
   for TDX guest"
 * Rebased on top of v5.14-rc1.
 * Rest of the change log is added per patch.

Changes since v1 (v2 is partial set submission):
 * Patch titled "x86/x86: Add early_is_tdx_guest() interface" is moved
   out of this series.
 * Rest of the change log is added per patch.

Andi Kleen (1):
  x86/tdx: Don't write CSTAR MSR on Intel

Kirill A. Shutemov (6):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
  x86/traps: Add #VE support for TDX guest
  x86/tdx: Add HLT support for TDX guest
  x86/tdx: Wire up KVM hypercalls
  x86/tdx: Add MSR support for TDX guest
  x86/tdx: Handle CPUID via #VE

Kuppuswamy Sathyanarayanan (4):
  x86/tdx: Introduce INTEL_TDX_GUEST config option
  x86/cpufeatures: Add TDX Guest CPU feature
  x86/tdx: Add protected guest support for TDX guest
  x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper
    functions

 arch/x86/Kconfig                       |  15 ++
 arch/x86/include/asm/asm-prototypes.h  |   1 +
 arch/x86/include/asm/cpufeatures.h     |   1 +
 arch/x86/include/asm/idtentry.h        |   4 +
 arch/x86/include/asm/irqflags.h        |  48 ++--
 arch/x86/include/asm/kvm_para.h        |  22 ++
 arch/x86/include/asm/paravirt.h        |  20 +-
 arch/x86/include/asm/paravirt_types.h  |   3 +-
 arch/x86/include/asm/protected_guest.h |   9 +
 arch/x86/include/asm/tdx.h             | 109 +++++++++
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/kernel/asm-offsets.c          |  23 ++
 arch/x86/kernel/cpu/common.c           |  11 +-
 arch/x86/kernel/cpu/intel.c            |  14 ++
 arch/x86/kernel/head64.c               |   3 +
 arch/x86/kernel/idt.c                  |   6 +
 arch/x86/kernel/paravirt.c             |   3 +-
 arch/x86/kernel/tdcall.S               | 314 +++++++++++++++++++++++++
 arch/x86/kernel/tdx.c                  | 237 +++++++++++++++++++
 arch/x86/kernel/traps.c                |  77 ++++++
 include/linux/protected_guest.h        |   3 +
 21 files changed, 890 insertions(+), 35 deletions(-)
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdcall.S
 create mode 100644 arch/x86/kernel/tdx.c

-- 
2.25.1

