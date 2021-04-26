Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D836B883
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhDZSDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:31731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234200AbhDZSDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:21 -0400
IronPort-SDR: TkfkUqt8hWZsyT1A8enA2o8Scir59aOgOaHfaKnvfAoGngiVWs6ZjtSfFK2sohZ2IxNlbzaUtu
 IGP9/OXrsXKA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934011"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934011"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:39 -0700
IronPort-SDR: k9pA6FP8FSSCquT9BG8DlluFuL9n9ic1oC3pVZahEs0hZGnZquVmg4IM0LsMSIcY9+BeiHm1X7
 O0jwGE1FqoOQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353319"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:39 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 00/32] Add TDX Guest Support
Date:   Mon, 26 Apr 2021 11:01:27 -0700
Message-Id: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

NOTE: This series is not ready for wide public review. It is being
specifically posted so that Peter Z and other experts on the entry
code can look for problems with the new exception handler (#VE).
That's also why x86@ is not being spammed.

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. This series adds the bare-minimum
support to run a TDX guest. The host-side support will be submitted
separately. Also support for advanced TD guest features like attestation
or debug-mode will be submitted separately. Also, at this point it is not
secure with some known holes in drivers, and also hasn’t been fully audited
and fuzzed yet.

TDX has a lot of similarities to SEV. It enhances confidentiality and
of guest memory and state (like registers) and includes a new exception
(#VE) for the same basic reasons as SEV-ES. Like SEV-SNP (not merged
yet), TDX limits the host's ability to effect changes in the guest
physical address space.

In contrast to the SEV code in the kernel, TDX guest memory is integrity
protected and isolated; the host is prevented from accessing guest
memory (even ciphertext).

The TDX architecture also includes a new CPU mode called
Secure-Arbitration Mode (SEAM). The software (TDX module) running in this
mode arbitrates interactions between host and guest and implements many of
the guarantees of the TDX architecture.

Some of the key differences between TD and regular VM is,

1. Multi CPU bring-up is done using the ACPI MADT wake-up table.
2. A new #VE exception handler is added. The TDX module injects #VE exception
   to the guest TD in cases of instructions that need to be emulated, disallowed
   MSR accesses, subset of CPUID leaves, etc.
3. By default memory is marked as private, and TD will selectively share it with
   VMM based on need.
4. Remote attestation is supported to enable a third party (either the owner of
   the workload or a user of the services provided by the workload) to establish
   that the workload is running on an Intel-TDX-enabled platform located within a
   TD prior to providing that workload data.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Changes since v1:
 * Implemented tdcall() and tdvmcall() helper functions in assembly and renamed
   them as __tdcall() and __tdvmcall().
 * Added do_general_protection() helper function to re-use protection
   code between #GP exception and TDX #VE exception handlers.
 * Addressed syscall gap issue in #VE handler support (for details check
   the commit log in "x86/traps: Add #VE support for TDX guest").
 * Modified patch titled "x86/tdx: Handle port I/O" to re-use common
   tdvmcall() helper function.
 * Added error handling support to MADT CPU wakeup code.
 * Introduced enum tdx_map_type to identify SHARED vs PRIVATE memory type.
 * Enabled shared memory in IOAPIC driver.
 * Added BINUTILS version info for TDCALL.
 * Changed the TDVMCALL vendor id from 0 to "TDX.KVM".
 * Replaced WARN() with pr_warn_ratelimited() in __tdvmcall() wrappers.
 * Fixed commit log and code comments related review comments.
 * Renamed patch titled # "x86/topology: Disable CPU hotplug support for TDX
   platforms" to "x86/topology: Disable CPU online/offline control for
   TDX guest"
 * Rebased on top of v5.12 kernel.


Erik Kaneda (1):
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (16):
  x86/paravirt: Introduce CONFIG_PARAVIRT_XL
  x86/tdx: Get TD execution environment information via TDINFO
  x86/traps: Add #VE support for TDX guest
  x86/tdx: Add HLT support for TDX guest
  x86/tdx: Wire up KVM hypercalls
  x86/tdx: Add MSR support for TDX guest
  x86/tdx: Handle CPUID via #VE
  x86/io: Allow to override inX() and outX() implementation
  x86/tdx: Handle port I/O
  x86/tdx: Handle in-kernel MMIO
  x86/mm: Move force_dma_unencrypted() to common code
  x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
  x86/tdx: Make pages shared in ioremap()
  x86/tdx: Add helper to do MapGPA TDVMALL
  x86/tdx: Make DMA pages shared
  x86/kvm: Use bounce buffers for TD guest

Kuppuswamy Sathyanarayanan (10):
  x86/tdx: Introduce INTEL_TDX_GUEST config option
  x86/cpufeatures: Add TDX Guest CPU feature
  x86/x86: Add is_tdx_guest() interface
  x86/tdx: Add __tdcall() and __tdvmcall() helper functions
  x86/traps: Add do_general_protection() helper function
  x86/tdx: Handle MWAIT, MONITOR and WBINVD
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
  ACPI/table: Print MADT Wake table information
  x86/acpi, x86/boot: Add multiprocessor wake-up support
  x86/topology: Disable CPU online/offline control for TDX guest

Sean Christopherson (4):
  x86/boot: Add a trampoline for APs booting in 64-bit mode
  x86/boot: Avoid #VE during compressed boot for TDX platforms
  x86/boot: Avoid unnecessary #VE during boot process
  x86/tdx: Forcefully disable legacy PIC for TDX guests

 arch/x86/Kconfig                         |  28 +-
 arch/x86/boot/compressed/Makefile        |   2 +
 arch/x86/boot/compressed/head_64.S       |  10 +-
 arch/x86/boot/compressed/misc.h          |   1 +
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   9 +
 arch/x86/boot/compressed/tdx.c           |  32 ++
 arch/x86/include/asm/apic.h              |   3 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  24 +-
 arch/x86/include/asm/irqflags.h          |  38 +-
 arch/x86/include/asm/kvm_para.h          |  21 +
 arch/x86/include/asm/paravirt.h          |  22 +-
 arch/x86/include/asm/paravirt_types.h    |   3 +-
 arch/x86/include/asm/pgtable.h           |   3 +
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/tdx.h               | 176 +++++++++
 arch/x86/kernel/Makefile                 |   1 +
 arch/x86/kernel/acpi/boot.c              |  79 ++++
 arch/x86/kernel/apic/apic.c              |   8 +
 arch/x86/kernel/apic/io_apic.c           |  12 +-
 arch/x86/kernel/asm-offsets.c            |  22 ++
 arch/x86/kernel/head64.c                 |   3 +
 arch/x86/kernel/head_64.S                |  13 +-
 arch/x86/kernel/idt.c                    |   6 +
 arch/x86/kernel/paravirt.c               |   4 +-
 arch/x86/kernel/pci-swiotlb.c            |   2 +-
 arch/x86/kernel/smpboot.c                |   5 +
 arch/x86/kernel/tdcall.S                 | 361 +++++++++++++++++
 arch/x86/kernel/tdx-kvm.c                |  45 +++
 arch/x86/kernel/tdx.c                    | 480 +++++++++++++++++++++++
 arch/x86/kernel/topology.c               |   3 +-
 arch/x86/kernel/traps.c                  |  81 ++--
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/ioremap.c                    |   8 +-
 arch/x86/mm/mem_encrypt.c                |  75 ----
 arch/x86/mm/mem_encrypt_common.c         |  85 ++++
 arch/x86/mm/mem_encrypt_identity.c       |   1 +
 arch/x86/mm/pat/set_memory.c             |  48 ++-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  49 ++-
 arch/x86/realmode/rm/trampoline_common.S |   5 +-
 drivers/acpi/tables.c                    |  11 +
 include/acpi/actbl2.h                    |  26 +-
 45 files changed, 1654 insertions(+), 162 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdcall.S
 create mode 100644 arch/x86/kernel/tdx-kvm.c
 create mode 100644 arch/x86/kernel/tdx.c
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

-- 
2.25.1

