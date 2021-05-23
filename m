Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5B38DCA0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhEWTj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:39:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:31996 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhEWTjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:55 -0400
IronPort-SDR: 3KiccQiE62RuhOaxvQgnFGBBONsb/QwgpohFvG1Jqwy/twQlIL8Xaqnzv5TX1eDfcuoJSNq7xY
 vuNX7SHz254w==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198740672"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198740672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:28 -0700
IronPort-SDR: 0bDWXkrhVGCeOvb1cx4nqxGhweLuqsReUz8Hro/iooubj0jGze0lAZgbsGpXuuvOTpHtdhzVXV
 xgfVSLxWRI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467059"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 00/28] x86: Support Intel Advanced Matrix Extensions
Date:   Sun, 23 May 2021 12:32:31 -0700
Message-Id: <20210523193259.26200-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Advanced Matrix Extensions (AMX)[1][2] will be shipping on servers
soon.  AMX consists of configurable TMM "TILE" registers plus new
accelerator instructions that operate on them.  TMUL (Tile matrix MULtiply)
is the first accelerator instruction set to use the new registers, and we
anticipate additional instructions in the future.

Neither AMX state nor TMUL instructions depend on AVX.  However, AMX and
AVX do share common challenges.  The TMM registers are 8KB today, and
architecturally as large as 64KB, which merits updates to hardware and
software state management.

Further, both technologies run faster when they are not simultaneously
running on SMT siblings, and both technologies use of power and bandwidth
impact the power and performance available to neighboring cores.  (This
impact has measurably improved in recent hardware.)

If the existing kernel approach for managing XSAVE state was employed to
handle AMX, 8KB space would be added to every task, but possibly rarely
used.  So Linux support is optimized by using a new XSAVE feature: eXtended
Feature Disabling (XFD).  The kernel arms XFD to provide a #NM exception
upon a tasks' first access to TILE state. The kernel exception handler
installs the appropriate XSAVE context switch buffer, and the task behaves
as if the kernel had done that for all tasks.  Using XFD, AMX space is
allocated only when needed, eliminating the memory waste for unused state
components.

This series requires glibc 2.34 or later [8][9], or the new minimum signal
stack size export [3]. The patches are based on the mainline (4.13-rc2).
The series is composed of three parts:
* Patch 01-18: Foundation to support dynamic user state management
* Patch 19-23: AMX enablement, including unit tests
* Patch 24-28: Optimizations for signal frame and for power/performance

Note. The per-task system call with GET/PUT semantics in PATCH15 is
currently under active discussion on LKML [10]. This is its v1 proposal.

Thanks to Len Brown and Dave Hansen for help with the cover letter.

Changes from v4 [7]:
* Changed the buffer expansion policy to the access-request based approach
  from the transparent #NM-based approach. (Andy Lutomirski, Thomas
  Gleixner, and et al)
* Removed the boot parameter patch. (Thomas Gleixner)
* Included code to explicitly initialize AMX state during a context switch.
  (Thomas Gleixner)
* Added a new arch_prctl to pre-allocate a buffer for dynamic state. (Andy
  Lutomirski)
* Updated the fork() path to initialize all the AMX state.
* Improved ptracer's dynamic user state injection path.
* Add optimization to skip tile data in sigframe when an AMX thread
  initialized the state.
* Updated to treat the mismatched state size as an error. (Thomas Gleixner)
* Simplified the xstate feature check routine. (Thomas Gleixner)
* Simplified and updated the selftest.
* Updated some changelog. (Thomas Gleixner)
* Updated a function description. (Borislav Petkov)

Changes from v3 [6]:
* Updated some commit messages and code comments. (Borislav Petkov)
* Added and removed some helpers. (Borislav Petkov)
* Revised the buffer allocation function. (Borislav Petkov)
* Simplified in accessing buffers. (Borislav Petkov)
* Re-organized some code change more reviewable. (PATCH9/10)
* Reverted unnecessary changes. (PATCH4)
* Fixed typo in the documentation. (Randy Dunlap)

Changes from v2 [5]:
* Removed the patch for the tile data inheritance. Also, updated the
  selftest patch. (Andy Lutomirski)
* Changed the kernel tainted when any unknown state is enabled. (Andy
  Lutomirski)
* Changed to use the XFD feature only when the compacted format in use.
* Improved the test code.
* Simplified the cmdline handling.
* Removed 'task->fpu' in changelogs. (Boris Petkov)
* Updated the variable name / comments / changelogs for clarification.

Changes from v1 [4]:
* Added vmalloc() error tracing (Dave Hansen, PeterZ, and Andy Lutomirski)
* Inlined the #NM handling code (Andy Lutomirski)
* Made signal handling optimization revertible
* Revised the new parameter handling code (Andy Lutomirski and Dave Hansen)
* Rebased on the upstream kernel

[1]: Intel Architecture Instruction Set Extension Programming Reference
    February 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-intel-advanced-matrix-extensions-intel-amx-instructions.html
[3]: https://lore.kernel.org/lkml/20210518200320.17239-1-chang.seok.bae@intel.com/
[4]: https://lore.kernel.org/lkml/20201001203913.9125-1-chang.seok.bae@intel.com/
[5]: https://lore.kernel.org/lkml/20201119233257.2939-1-chang.seok.bae@intel.com/
[6]: https://lore.kernel.org/lkml/20201223155717.19556-1-chang.seok.bae@intel.com/
[7]: https://lore.kernel.org/lkml/20210221185637.19281-1-chang.seok.bae@intel.com/
[8]: https://sourceware.org/git/?p=glibc.git;a=commit;h=6c57d320484988e87e446e2e60ce42816bf51d53
[9]: https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS;h=aa0f10a891f8f9b4e6f0f6d25b6a307898c07d82;hb=HEAD#l12
[10]: https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com/

Chang S. Bae (28):
  x86/fpu/xstate: Modify the initialization helper to handle both static
    and dynamic buffers
  x86/fpu/xstate: Modify state copy helpers to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify address finders to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify the context restore helper to handle both
    static and dynamic buffers
  x86/fpu/xstate: Add a new variable to indicate dynamic user states
  x86/fpu/xstate: Add new variables to indicate dynamic xstate buffer
    size
  x86/fpu/xstate: Calculate and remember dynamic xstate buffer sizes
  x86/fpu/xstate: Convert the struct fpu 'state' field to a pointer
  x86/fpu/xstate: Introduce helpers to manage the xstate buffer
    dynamically
  x86/fpu/xstate: Define the scope of the initial xstate data
  x86/fpu/xstate: Update the xstate save function to support dynamic
    states
  x86/fpu/xstate: Update the xstate buffer address finder to support
    dynamic states
  x86/fpu/xstate: Update the xstate context copy function to support
    dynamic states
  x86/fpu/xstate: Prevent unauthorised use of dynamic user state
  x86/arch_prctl: Create ARCH_GET_XSTATE/ARCH_PUT_XSTATE
  x86/fpu/xstate: Support ptracer-induced xstate buffer expansion
  x86/fpu/xstate: Adjust the XSAVE feature table to address gaps in
    state component numbers
  x86/fpu/xstate: Disable xstate support if an inconsistent state is
    detected
  x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature
    bits
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu/amx: Initialize child's AMX state
  x86/fpu/amx: Enable the AMX feature in 64-bit mode
  selftest/x86/amx: Test cases for the AMX state management
  x86/fpu/xstate: Use per-task xstate mask for saving xstate in signal
    frame
  x86/fpu/xstate: Skip writing zeros to signal frame for dynamic user
    states if in INIT-state
  selftest/x86/amx: Test case for AMX state copy optimization in signal
    delivery
  x86/insn/amx: Add TILERELEASE instruction to the opcode map
  x86/fpu/amx: Clear the AMX state when appropriate

 arch/x86/include/asm/cpufeatures.h    |   4 +
 arch/x86/include/asm/fpu/internal.h   |  93 +++-
 arch/x86/include/asm/fpu/types.h      |  69 ++-
 arch/x86/include/asm/fpu/xstate.h     |  42 +-
 arch/x86/include/asm/msr-index.h      |   2 +
 arch/x86/include/asm/pgtable.h        |   2 +-
 arch/x86/include/asm/processor.h      |  10 +-
 arch/x86/include/asm/proto.h          |   2 +-
 arch/x86/include/asm/special_insns.h  |   6 +
 arch/x86/include/asm/trace/fpu.h      |   9 +-
 arch/x86/include/uapi/asm/prctl.h     |   3 +
 arch/x86/kernel/cpu/common.c          |   2 +-
 arch/x86/kernel/cpu/cpuid-deps.c      |   4 +
 arch/x86/kernel/fpu/core.c            | 100 +++-
 arch/x86/kernel/fpu/init.c            |  42 +-
 arch/x86/kernel/fpu/regset.c          |  66 ++-
 arch/x86/kernel/fpu/signal.c          |  61 ++-
 arch/x86/kernel/fpu/xstate.c          | 725 +++++++++++++++++++++----
 arch/x86/kernel/process.c             |  20 +-
 arch/x86/kernel/process_32.c          |   2 +-
 arch/x86/kernel/process_64.c          |   2 +-
 arch/x86/kernel/traps.c               |  12 +
 arch/x86/kvm/x86.c                    |  48 +-
 arch/x86/lib/x86-opcode-map.txt       |   8 +-
 arch/x86/math-emu/fpu_aux.c           |   2 +-
 arch/x86/math-emu/fpu_entry.c         |   4 +-
 arch/x86/math-emu/fpu_system.h        |   2 +-
 arch/x86/mm/pkeys.c                   |   2 +-
 tools/arch/x86/lib/x86-opcode-map.txt |   8 +-
 tools/testing/selftests/x86/Makefile  |   2 +-
 tools/testing/selftests/x86/amx.c     | 738 ++++++++++++++++++++++++++
 31 files changed, 1825 insertions(+), 267 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
--
2.17.1

