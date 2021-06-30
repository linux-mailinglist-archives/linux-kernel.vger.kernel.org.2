Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A963B7D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhF3GKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:10:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:46942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhF3GKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195448546"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195448546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455156477"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2021 23:08:14 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6 00/26] x86: Support Intel Advanced Matrix Extensions
Date:   Tue, 29 Jun 2021 23:02:00 -0700
Message-Id: <20210630060226.24652-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Advanced Matrix Extensions (AMX)[1][2] will be shipping on servers
soon.  AMX consists of configurable TMM "TILE" registers plus new CPU
instructions that operate on them.  TMUL (Tile matrix MULtiply) is the
first operator to take advantage of the new registers, and we anticipate
additional instructions in the future.

Neither AMX state nor TMUL instructions depend on AVX.  However, AMX and
AVX do share common challenges.  The TMM registers are 8KB today, and
architecturally as large as 64KB, which merit updates to hardware and
software state management.

Further, both technologies run faster when they are not simultaneously
running on SMT siblings, and both technologies use of power and bandwidth
impact the power and performance available to neighboring cores.  (This
impact has measurably improved in recent hardware.)

If the existing kernel approach for managing XSAVE state was employed to
handle AMX, 8KB space would be added to every task, but possibly rarely
used.  Thus, Linux implements on-demand expansion of per-task context
switch buffers using a XSAVE feature: eXtended Feature Disabling (XFD). The
kernel arms XFD to provide an #NM exception upon a tasks' first access to
TILE state. The kernel exception handler allocates and installs the
appropriate XSAVE context switch buffer, and the task behaves as if the
kernel had done that for all tasks.

AMX is accessible only to applications that invoke a new system call to
request access.  If those applications also use an alternate signal stack,
they must provide a sigaltstack of sufficient size.  If they use the ABI in
glibc 2.34 or later [8][9], they can take advantage of the Stack size
computed directly by glibc, or provided to glibc by the kernel [3].

The patches are built on top of the recent x86 FPU changes [13].

This series has three parts:
* Patch 01-15: Foundation to support dynamic user state management
* Patch 16-21: AMX enablement, including some preparation
* Patch 22-26: Optimizations, DEBUG sanity check, and self test

Note that the per-process system call in PATCH14 reflects the latest
discussion on LKML, [10][12].

The following points summarize the latest discussion, and this implementation:

1. Kernel sets XCR0.AMX=1 at boot, and leaves it set, always.

    XCR0 is NOT context switched by Linux.
    (if it were, every change would provoke VMEXIT if in VM)

    (KVM context switches XCR0.   If KVM exports XFD for use by a guest OS,
    it must also context switch XFD, and it can not use XFD for its own
    purposes.)

2. Kernel arms XFD for all tasks.

    XFD is context switched per Linux task.

3. Apps invoke new system call to request feature access (AMX).

    Implemented as a flag to prctl(2), permission granted to any task will
    grant that permission to all tasks in a process.

    It is sufficient to invoke this syscall at process or library init-time.

    There is no concept of removing or revoking permission, once granted.

    Analogous to AVX-512 and other stateful features, applications probe
    for AMX support by checking CPUID for the instructions and checking
    XGETBV(XCR0) for the OS support.

    However, stateful features from AMX onward also require the system call
    above to be invoked before tasks in that process may use the feature.

4. Applications touching AMX without permission results in process exit.

    Armed XFD results in #NM, results in SIGSEGV, typically resulting in
    process exit.

5. Applications touching AMX with permission allocate buffer on-demand.

    Armed XFD results in #NM.
    Kernel allocates large context switch kernel buffer.
    Kernel dis-arms XFD for that task.

6. NM handler allocation failure results in process exit.

    If the #NM handler can not allocate the 8KB buffer, the task will
    receive a SIGSEGV at the instruction that took the #NM fault, typically
    resulting in process exit.

7. Legacy app signal stack XSTATE support stops at AVX-512

    Legacy apps are these which do request AMX (or subsequent) access.
    ABI continues to be uncompacted XSTATE up through AVX-512 on signal
    stack.

    Existing code to find offsets in XSTATE still work.
    Exiting code doing XRESTOR/XSAVE on stack buffer will work.*

    *XSTATE size calculation using CPUID will return buffer that includes
    AMX and other supported features, even if the process did not invoke
    the new system call.    However, XSAVE/XRESTOR will never access XSTATE
    buffer past AVX-512.

Reviewed-by: Len Brown <len.brown@intel.com>

Changes from v5 [11]:
* Updated to require per-process permission for dynamic states (v5 was
  per-task).
* Support both legacy and expanded sigframe xstate buffer sizes.
* Moved the TILERELEASE code to intel_idle driver. (Peter Zijlstra)
* Fixed to deactivate fpregs with TILERELEASE. (Adny Lutomirski and Dave
  Hansen)
* Rebased on Thomas Gleixner's recent x86 FPU code changes.
* Added XFD sanity check. (Dave Hansen)
* Future proofed __raw_xsave_addr().
* Tighten up task size calculation (previously, it could over-calculate).
* Cleaned invocation memset() for init_fpstate (no functional change).
* Updated selftest to handle latest syscall semantics, plus minor updates.
* Dropped the change for XSTATE restore helper.

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
[11]: https://lore.kernel.org/lkml/20210523193259.26200-1-chang.seok.bae@intel.com/
[12]: https://lore.kernel.org/lkml/CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com/
[13]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fpu

Chang S. Bae (26):
  x86/fpu/xstate: Modify the initialization helper to handle both static
    and dynamic buffers
  x86/fpu/xstate: Modify state copy helpers to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify address finders to handle both static and
    dynamic buffers
  x86/fpu/xstate: Add a new variable to indicate dynamic user states
  x86/fpu/xstate: Add new variables to indicate dynamic XSTATE buffer
    size
  x86/fpu/xstate: Calculate and remember dynamic XSTATE buffer sizes
  x86/fpu/xstate: Convert the struct fpu 'state' field to a pointer
  x86/fpu/xstate: Introduce helpers to manage the XSTATE buffer
    dynamically
  x86/fpu/xstate: Update the XSTATE save function to support dynamic
    states
  x86/fpu/xstate: Update the XSTATE buffer address finder to support
    dynamic states
  x86/fpu/xstate: Update the XSTATE context copy function to support
    dynamic states
  x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user
    state
  x86/fpu/xstate: Support ptracer-induced XSTATE buffer expansion
  x86/arch_prctl: Create ARCH_ENABLE_XSTATE
  x86/fpu/xstate: Support both legacy and expanded signal XSTATE size
  x86/fpu/xstate: Adjust the XSAVE feature table to address gaps in
    state component numbers
  x86/fpu/xstate: Disable XSTATE support if an inconsistent state is
    detected
  x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature
    bits
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu/amx: Initialize child's AMX state
  x86/fpu/amx: Enable the AMX feature in 64-bit mode
  x86/fpu/xstate: Skip writing zeros to signal frame for dynamic user
    states if in INIT-state
  selftest/x86/amx: Test cases for the AMX state management
  x86/insn/amx: Add TILERELEASE instruction to the opcode map
  intel_idle/amx: Clear the AMX state before entering idle
  x86/fpu/xstate: Add a sanity check for XFD state when saving XSTATE

 arch/x86/include/asm/cpufeatures.h    |   4 +
 arch/x86/include/asm/fpu/internal.h   | 119 +++-
 arch/x86/include/asm/fpu/types.h      |  61 +-
 arch/x86/include/asm/fpu/xstate.h     |  33 +-
 arch/x86/include/asm/msr-index.h      |   2 +
 arch/x86/include/asm/processor.h      |  10 +-
 arch/x86/include/asm/special_insns.h  |   6 +
 arch/x86/include/asm/thread_info.h    |   2 +
 arch/x86/include/asm/trace/fpu.h      |   9 +-
 arch/x86/include/uapi/asm/prctl.h     |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c      |   4 +
 arch/x86/kernel/fpu/core.c            |  95 ++-
 arch/x86/kernel/fpu/init.c            |  37 +-
 arch/x86/kernel/fpu/regset.c          |  51 +-
 arch/x86/kernel/fpu/signal.c          | 107 ++--
 arch/x86/kernel/fpu/xstate.c          | 630 ++++++++++++++++---
 arch/x86/kernel/process.c             |  15 +
 arch/x86/kernel/process_32.c          |   2 +-
 arch/x86/kernel/process_64.c          |   8 +-
 arch/x86/kernel/traps.c               |  44 ++
 arch/x86/kvm/x86.c                    |  48 +-
 arch/x86/lib/x86-opcode-map.txt       |   8 +-
 arch/x86/math-emu/fpu_aux.c           |   2 +-
 arch/x86/math-emu/fpu_entry.c         |   4 +-
 arch/x86/math-emu/fpu_system.h        |   2 +-
 drivers/idle/intel_idle.c             |  79 +++
 tools/arch/x86/lib/x86-opcode-map.txt |   8 +-
 tools/testing/selftests/x86/Makefile  |   2 +-
 tools/testing/selftests/x86/amx.c     | 859 ++++++++++++++++++++++++++
 29 files changed, 2022 insertions(+), 231 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c


base-commit: 93c2cdc975aab53c222472c5b96c2d41dbeb350c
--
2.17.1

