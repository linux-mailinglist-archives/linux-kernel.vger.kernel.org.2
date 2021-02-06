Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BC311BBC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 07:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBFG0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 01:26:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:61870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhBFG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 01:26:38 -0500
IronPort-SDR: fLDwjN/cPG9smTyywJ2UdVXjaWCyE5QQJEJ7Wjo2nYl1S/bMoVVYdwZjey+H90JxgZfFnlHeOz
 5n6KEJC5B3Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="245595980"
X-IronPort-AV: E=Sophos;i="5.81,157,1610438400"; 
   d="scan'208";a="245595980"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 22:24:51 -0800
IronPort-SDR: nP61PpHdYmCjzUtoHRdB+zQ1mq9dfL8yiHOSbpGquxRmoDjwUcGQnJgC95+9BXnaA/5wfmFvYw
 9O0Xpmg1thMQ==
X-IronPort-AV: E=Sophos;i="5.81,157,1610438400"; 
   d="scan'208";a="409638738"
Received: from eliaschi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 22:24:51 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     linux-kernel@vger.kernel.org
Subject: [RFC v1 00/26] Add TDX Guest Support
Date:   Fri,  5 Feb 2021 22:24:38 -0800
Message-Id: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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

This RFC series has been reviewed by Dave Hansen.

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

Kuppuswamy Sathyanarayanan (6):
  x86/cpufeatures: Add TDX Guest CPU feature
  x86/cpufeatures: Add is_tdx_guest() interface
  x86/tdx: Handle MWAIT, MONITOR and WBINVD
  ACPI: tables: Add multiprocessor wake-up support
  x86/topology: Disable CPU hotplug support for TDX platforms.
  x86/tdx: Introduce INTEL_TDX_GUEST config option

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
 arch/x86/boot/compressed/tdx.c           |  32 ++
 arch/x86/boot/compressed/tdx_io.S        |   9 +
 arch/x86/include/asm/apic.h              |   3 +
 arch/x86/include/asm/asm-prototypes.h    |   1 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  25 +-
 arch/x86/include/asm/irqflags.h          |  42 +-
 arch/x86/include/asm/kvm_para.h          |  21 +
 arch/x86/include/asm/paravirt.h          |  22 +-
 arch/x86/include/asm/paravirt_types.h    |   3 +-
 arch/x86/include/asm/pgtable.h           |   3 +
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/tdx.h               | 114 +++++
 arch/x86/kernel/Makefile                 |   1 +
 arch/x86/kernel/acpi/boot.c              |  56 +++
 arch/x86/kernel/apic/probe_32.c          |   8 +
 arch/x86/kernel/apic/probe_64.c          |   8 +
 arch/x86/kernel/head64.c                 |   3 +
 arch/x86/kernel/head_64.S                |  13 +-
 arch/x86/kernel/idt.c                    |   6 +
 arch/x86/kernel/paravirt.c               |   4 +-
 arch/x86/kernel/pci-swiotlb.c            |   2 +-
 arch/x86/kernel/smpboot.c                |   5 +
 arch/x86/kernel/tdx-kvm.c                | 116 +++++
 arch/x86/kernel/tdx.c                    | 560 +++++++++++++++++++++++
 arch/x86/kernel/tdx_io.S                 | 143 ++++++
 arch/x86/kernel/topology.c               |   3 +-
 arch/x86/kernel/traps.c                  |  73 ++-
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/ioremap.c                    |   8 +-
 arch/x86/mm/mem_encrypt.c                |  74 ---
 arch/x86/mm/mem_encrypt_common.c         |  83 ++++
 arch/x86/mm/mem_encrypt_identity.c       |   1 +
 arch/x86/mm/pat/set_memory.c             |  23 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  49 +-
 arch/x86/realmode/rm/trampoline_common.S |   5 +-
 drivers/acpi/tables.c                    |   9 +
 include/acpi/actbl2.h                    |  21 +-
 45 files changed, 1444 insertions(+), 157 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx_io.S
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdx-kvm.c
 create mode 100644 arch/x86/kernel/tdx.c
 create mode 100644 arch/x86/kernel/tdx_io.S
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

-- 
2.25.1

