Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F53C3CC415
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhGQPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:38:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:24179 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhGQPh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:37:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853796"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853796"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631386941"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:01 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 00/26] x86: Support Intel Advanced Matrix Extensions
Date:   Sat, 17 Jul 2021 08:28:37 -0700
Message-Id: <20210717152903.7651-1-chang.seok.bae@intel.com>
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
switch buffers using an XSAVE feature: eXtended Feature Disabling (XFD).
The kernel arms XFD to provide an #NM exception upon a tasks' first access
to TILE state. The kernel exception handler allocates and installs the
appropriate XSAVE context switch buffer.  User space is unaware of the
kernel's contexts switch buffer optimization.

AMX is accessible only to applications that invoke a new system call to
request access.  When a user invokes this system call, they agree that if
they use an alternate signal stack, that they are providing an alternative
signal stack of sufficient size.  The simplest way to do that is to use the
updated ABI in glibc 2.34 or later [8][9], though they could Also use their
own calculation or ask the kernel directly [3].

The patches are built on top of the recent upstream x86 FPU changes [13].

This series has three parts:
* Patch 01-15: Foundation to support dynamic user state management
* Patch 16-21: AMX enablement, including some preparation
* Patch 22-26: Optimizations, DEBUG sanity check, and self test

Note that the per-process system call in PATCH14 reflects the latest
discussion on LKML, [10][12].

The following points summarize the latest discussion, and this
implementation:

1. Kernel sets XCR0.AMX=1 at boot, and leaves it set, always.

    XCR0 is NOT context switched by Linux.
    (If it were, every change would provoke VMEXIT if in VM.)

    (KVM context switches XCR0.   If KVM exports XFD for use by a guest OS,
    it must also context switch XFD.  KVM can not use XFD for its own
    purposes.)

2. Kernel arms XFD for all tasks.

    XFD is context switched per Linux task.

3. Apps invoke new system call to request feature access (AMX).

    Implemented as a flag to arch_prctl(2), permission granted to any task
    will grant that permission to all tasks in the process.

    It is sufficient to invoke this syscall at process or library
    init-time.

    There is no concept of removing or revoking permission, once granted to
    a process.  (Permission is cleared upon exec of a new process.)

    There is a companion system call to return the current permission.

    Analogous to AVX-512 and other stateful features, applications probe
    for AMX support by checking CPUID for the instructions and checking
    XGETBV(XCR0) for the OS support.

    However, stateful features from AMX onward also require the system call
    above to be invoked before tasks in that process may use the feature.

4. Applications touching AMX without permission results in process exit.

    Armed XFD results in #NM, results in SIGILL with si_code ILL_ILLOPC,
    typically resulting in process exit.

5. Applications touching AMX with permission allocate context switch buffer
   on-demand.

    Armed XFD results in #NM.
    Kernel allocates large context switch kernel buffer.
    Kernel dis-arms XFD for that task.

6. NM handler allocation failure results in process exit.

    If the #NM handler can not allocate the 8KB buffer, the task will
    receive a SIGILL with si_code ILL_ILLOPC at the instruction that took
    the #NM fault, typically resulting in process exit.

7. Legacy app signal stack XSTATE support includes AVX-512, and stops
   before AMX.

    Legacy apps are those which do not request AMX (or subsequent feature)
    access.The signal stack ABI continues to be uncompacted XSTATE for both
    legacy and new apps.

    Existing code to find offsets in XSTATE still work.
    Existing code doing XRSTOR/XSAVE on signal stack buffer will still
    work.*

    * XSTATE size calculation using CPUID will include
    AMX and other supported features, even if the process did not invoke
    the new system call.    However, the kernel will not XSAVE AMX or later
    features onto the signal stack of a legacy process.**

   ** User-space XSAVE/XRSTOR should size buffers according to CPUID
   if they include the bits of xgetbv(XCR0) in RFBM, because XSAVE will
   write data (including zeros for INIT state) for all features included in
   RFBM.

8. New opt-in apps must agree to provide large enough sigaltstack

    1. must invoke permission system call before touching AMX TMM
    2. must guarantee if using sigaltstack(2), that they have
       allocated signal stack of sufficient size, e.g., by utilizing
       glibc signal.h 2.34 or later.

    (glibc 2.34 changed MINSIGSTKSZ and SIGSTKSZ from 2KB/8KB constants
    into run-time routines. [8])

    Linux will continue to XSAVE/XRSTOR directly to/from the signal stack,
    and the stack will always include the 8KB *space* for AMX TMM and
    subsequent features.

    Linux has an optimization in for all XFD-supported features in the INIT
    state so that XSAVE will skip writing zeros.

9. intel_idle for SPR will clear AMX TMM state

    This guarantees that AMX use will not prevent the CPU from entering the
    idle C6 state, which can be beneficial for power savings, and thus
    turbo frequency.

Reviewed-by: Len Brown <len.brown@intel.com>

Changes from v7 [15]:
* Update #NM handler to raise SIGILL rather than SIGSEGV (Patch 12).
  (Thiago Macieira)
* Rename the syscalls (Patch 14). (Thiago Macieira and Dave Hansen)
* If XSAVE is disabled, assure that syscall correctly indicates legacy
  states (Patch14). (Thiago Macieira and Dave Hansen)
* Update existing self-test to expect SIGILL (Patch23).

Changes from v6 [14]:
* Add state bitmap param to proposed syscall. (Thiago Macieira)
* Add companion syscall to return the current permission bitmap.
* Update the ptrace path to return EFAULT when no permission to write
  XTILEDATA.
* Simplify xstate size calculation code. (Dave Hansen)
* Update comments for TILERELEASE code. (Rafael J. Wysocki)

Changes from v5 [11]:
* Updated to require per-process permission for dynamic states (v5 was
  per-task).
* Support both legacy and expanded sigframe xstate buffer sizes.
* Moved the TILERELEASE code to intel_idle driver. (Peter Zijlstra)
* Fixed to deactivate fpregs with TILERELEASE. (Andy Lutomirski and Dave
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
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
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
[13]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1423e2660cf134a8f21f2451865a04792013e49e
[14]: https://lore.kernel.org/lkml/20210630060226.24652-1-chang.seok.bae@intel.com/
[15]: https://lore.kernel.org/lkml/20210710130313.5072-1-chang.seok.bae@intel.com/

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
  x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
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
  intel_idle/amx: Add SPR support with XTILEDATA capability
  x86/fpu/xstate: Add a sanity check for XFD state when saving XSTATE

 arch/x86/include/asm/cpufeatures.h    |   4 +
 arch/x86/include/asm/fpu/internal.h   | 117 +++-
 arch/x86/include/asm/fpu/types.h      |  72 +-
 arch/x86/include/asm/fpu/xstate.h     |  34 +-
 arch/x86/include/asm/msr-index.h      |   2 +
 arch/x86/include/asm/processor.h      |  10 +-
 arch/x86/include/asm/proto.h          |   2 +-
 arch/x86/include/asm/special_insns.h  |   6 +
 arch/x86/include/asm/trace/fpu.h      |   9 +-
 arch/x86/include/uapi/asm/prctl.h     |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c      |   4 +
 arch/x86/kernel/fpu/core.c            |  94 ++-
 arch/x86/kernel/fpu/init.c            |  37 +-
 arch/x86/kernel/fpu/regset.c          |  57 +-
 arch/x86/kernel/fpu/signal.c          |  99 ++-
 arch/x86/kernel/fpu/xstate.c          | 658 ++++++++++++++++--
 arch/x86/kernel/process.c             |  21 +-
 arch/x86/kernel/process_32.c          |   2 +-
 arch/x86/kernel/process_64.c          |   8 +-
 arch/x86/kernel/traps.c               |  41 ++
 arch/x86/kvm/x86.c                    |  48 +-
 arch/x86/lib/x86-opcode-map.txt       |   8 +-
 arch/x86/math-emu/fpu_aux.c           |   2 +-
 arch/x86/math-emu/fpu_entry.c         |   4 +-
 arch/x86/math-emu/fpu_system.h        |   2 +-
 drivers/idle/intel_idle.c             |  79 +++
 tools/arch/x86/lib/x86-opcode-map.txt |   8 +-
 tools/testing/selftests/x86/Makefile  |   2 +-
 tools/testing/selftests/x86/amx.c     | 954 ++++++++++++++++++++++++++
 29 files changed, 2151 insertions(+), 236 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
--
2.17.1

