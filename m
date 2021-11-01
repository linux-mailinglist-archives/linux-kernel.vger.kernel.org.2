Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C594411EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhKABzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhKABzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:55:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F96C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 18:52:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635731554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PplmTUSPqiXGNazdP4pVJ0H3lwQpyOBXllhkefxU2qQ=;
        b=gQ+/S6dX8iaaUSZMTGweLRa3y3c27DSaWcqcjztvUiCfgC9lOq9Mwzj4V8PJQ/aO1BdRde
        jbZKEjfvP2YKymqWWKXnPhWsGvdgDVbuGgnu8jOH/h1dLyyxwCmLSKlqhq/K3NPIqqUJSZ
        V0DeDT2/l5vxWuiIK3PQWUM4co8XKhKlEP0dc7Ktwj9FnC7jPd/AH/WHiZNlMy2amazYBw
        N///215oIzauLUh9JZSOEwePUiDdceW3jFEk0tdm59uJHTVw4hhSElff4QkNPWQSItOZk4
        93rkfMdUYB7Z6bCIkZSlS+BOjO//R8dWIRYFhGDoLDEVvQo6HlaGaDzuVcR2nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635731554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PplmTUSPqiXGNazdP4pVJ0H3lwQpyOBXllhkefxU2qQ=;
        b=SumeWlXu46nObyrzN4btUbRe4LxdLboyznosjjinjl8PHfoJZDBHBzg/UmyspvroWWvYSt
        hLLNbwnsH6QU3BAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [GIT pull RESEND] x86/fpu for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572865296.3357115.3707320162730818106.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:52:32 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/fpu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-11-=
01

up to:  d7a9590f608d: Documentation/x86: Add documentation for using dynamic =
XSTATE features

x86/fpu updates:

 - Cleanup of extable fixup handling to be more robust, which in turn
   allows to make the FPU exception fixups more robust as well.

 - Change the return code for signal frame related failures from explicit
   error codes to a boolean fail/success as that's all what the calling
   code evaluates.

 - A large refactoring of the FPU code to prepare for adding AMX support:

   - Distangle the public header maze and remove especially the misnomed
     kitchen sink internal.h which is despite it's name included all over
     the place.

   - Add a proper abstraction for the register buffer storage (struct
     fpstate) which allows to dynamically size the buffer at runtime by
     flipping the pointer to the buffer container from the default
     container which is embedded in task_struct::tread::fpu to a
     dynamically allocated container with a larger register buffer.

   - Convert the code over to the new fpstate mechanism.

   - Consolidate the KVM FPU handling by moving the FPU related code into
     the FPU core which removes the number of exports and avoids adding
     even more export when AMX has to be supported in KVM. This also
     removes duplicated code which was of course unnecessary different and
     incomplete in the KVM copy.

   - Simplify the KVM FPU buffer handling by utilizing the new fpstate
     container and just switching the buffer pointer from the user space
     buffer to the KVM guest buffer when entering vcpu_run() and flipping
     it back when leaving the function. This cuts the memory requirements
     of a vCPU for FPU buffers in half and avoids pointless memory copy
     operations.

     This also solves the so far unresolved problem of adding AMX support
     because the current FPU buffer handling of KVM inflicted a circular
     dependency between adding AMX support to the core and to KVM.  With
     the new scheme of switching fpstate AMX support can be added to the
     core code without affecting KVM.

   - Replace various variables with proper data structures so the extra
     information required for adding dynamically enabled FPU features (AMX)
     can be added in one place

 - Add AMX (Advanved Matrix eXtensions) support (finally):

    AMX is a large XSTATE component which is going to be available with
    Saphire Rapids XEON CPUs. The feature comes with an extra MSR (MSR_XFD)
    which allows to trap the (first) use of an AMX related instruction,
    which has two benefits:

    1) It allows the kernel to control access to the feature
   =20
    2) It allows the kernel to dynamically allocate the large register
       state buffer instead of burdening every task with the the extra 8K
       or larger state storage.

    It would have been great to gain this kind of control already with
    AVX512.

    The support comes with the following infrastructure components:

    1) arch_prctl() to=20
       - read the supported features (equivalent to XGETBV(0))
       - read the permitted features for a task
       - request permission for a dynamically enabled feature

       Permission is granted per process, inherited on fork() and cleared
       on exec(). The permission policy of the kernel is restricted to
       sigaltstack size validation, but the syscall obviously allows
       further restrictions via seccomp etc.

    2) A stronger sigaltstack size validation for sys_sigaltstack(2) which
       takes granted permissions and the potentially resulting larger
       signal frame into account. This mechanism can also be used to
       enforce factual sigaltstack validation independent of dynamic
       features to help with finding potential victims of the 2K
       sigaltstack size constant which is broken since AVX512 support was
       added.

    3) Exception handling for #NM traps to catch first use of a extended
       feature via a new cause MSR. If the exception was caused by the use
       of such a feature, the handler checks permission for that
       feature. If permission has not been granted, the handler sends a
       SIGILL like the #UD handler would do if the feature would have been
       disabled in XCR0. If permission has been granted, then a new fpstate
       which fits the larger buffer requirement is allocated.

       In the unlikely case that this allocation fails, the handler sends
       SIGSEGV to the task. That's not elegant, but unavoidable as the
       other discussed options of preallocation or full per task
       permissions come with their own set of horrors for kernel and/or
       userspace. So this is the lesser of the evils and SIGSEGV caused by
       unexpected memory allocation failures is not a fundamentally new
       concept either.

       When allocation succeeds, the fpstate properties are filled in to
       reflect the extended feature set and the resulting sizes, the
       fpu::fpstate pointer is updated accordingly and the trap is disarmed
       for this task permanently.

    4) Enumeration and size calculations

    5) Trap switching via MSR_XFD

       The XFD (eXtended Feature Disable) MSR is context switched with the
       same life time rules as the FPU register state itself. The mechanism
       is keyed off with a static key which is default disabled so !AMX
       equipped CPUs have zero overhead. On AMX enabled CPUs the overhead
       is limited by comparing the tasks XFD value with a per CPU shadow
       variable to avoid redundant MSR writes. In case of switching from a
       AMX using task to a non AMX using task or vice versa, the extra MSR
       write is obviously inevitable.

       All other places which need to be aware of the variable feature sets
       and resulting variable sizes are not affected at all because they
       retrieve the information (feature set, sizes) unconditonally from
       the fpstate properties.

    6) Enable the new AMX states

  Note, this is relatively new code despite the fact that AMX support is in
  the works for more than a year now.

  The big refactoring of the FPU code, which allowed to do a proper
  integration has been started exactly 3 weeks ago. Refactoring of the
  existing FPU code and of the original AMX patches took a week and has
  been subject to extensive review and testing. The only fallout which has
  not been caught in review and testing right away was restricted to AMX
  enabled systems, which is completely irrelevant for anyone outside Intel
  and their early access program. There might be dragons lurking as usual,
  but so far the fine grained refactoring has held up and eventual yet
  undetected fallout is bisectable and should be easily addressable before
  the 5.16 release. Famous last words...

  Many thanks to Chang Bae and Dave Hansen for working hard on this and
  also to the various test teams at Intel who reserved extra capacity to
  follow the rapid development of this closely which provides the
  confidence level required to offer this rather large update for inclusion
  into 5.16-rc1.

Note: There is a minor merge conflict versus ras/core which is sent to you
by Borislav (whatever you merge first). A reference resolution is here:

   https://tglx.de/~tglx/res-ras-fpu.diff

Thanks,

	tglx

------------------>
Anders Roxell (1):
      x86/fpu/signal: Fix missed conversion to correct boolean retval in save=
_xstate_epilog()

Chang S. Bae (18):
      x86/fpu/xstate: Provide xstate_calculate_size()
      x86/arch_prctl: Add controls for dynamic XSTATE components
      x86/fpu/signal: Prepare for variable sigframe length
      x86/fpu: Reset permission and fpstate on exec()
      x86/cpufeatures: Add eXtended Feature Disabling (XFD) feature bit
      x86/msr-index: Add MSRs for XFD
      x86/fpu: Add XFD state to fpstate
      x86/fpu: Update XFD state where required
      x86/fpu/xstate: Add XFD #NM handler
      x86/fpu/xstate: Add fpstate_realloc()/free()
      x86/fpu/xstate: Prepare XSAVE feature table for gaps in state component=
 numbers
      x86/fpu/amx: Define AMX state components and have it used for boot-time=
 checks
      x86/fpu: Calculate the default sizes independently
      x86/fpu: Add XFD handling for dynamic states
      x86/fpu/amx: Enable the AMX feature in 64-bit mode
      selftests/x86/amx: Add test cases for AMX state management
      selftests/x86/amx: Add context switch test
      Documentation/x86: Add documentation for using dynamic XSTATE features

Stephen Rothwell (1):
      x86/fpu: Include vmalloc.h for vzalloc()

Thomas Gleixner (90):
      x86/extable: Tidy up redundant handler functions
      x86/extable: Get rid of redundant macros
      x86/mce: Deduplicate exception handling
      x86/mce: Get rid of stray semicolons
      x86/extable: Rework the exception table mechanics
      x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE
      x86/copy_mc: Use EX_TYPE_DEFAULT_MCE_SAFE for exception fixups
      x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups
      x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups
      x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()
      x86/fpu/signal: Move header zeroing out of xsave_to_user_sigframe()
      x86/fpu/signal: Move xstate clearing out of copy_fpregs_to_sigframe()
      x86/fpu/signal: Change return type of copy_fpstate_to_sigframe() to boo=
lean
      x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers=
 to boolean
      x86/signal: Change return type of restore_sigcontext() to boolean
      x86/fpu/signal: Change return type of fpu__restore_sig() to boolean
      x86/fpu/signal: Change return type of __fpu_restore_sig() to boolean
      x86/fpu/signal: Change return code of check_xstate_in_sigframe() to boo=
lean
      x86/fpu/signal: Change return code of restore_fpregs_from_user() to boo=
lean
      x86/fpu: Remove pointless argument from switch_fpu_finish()
      x86/fpu: Update stale comments
      x86/pkru: Remove useless include
      x86/fpu: Restrict xsaves()/xrstors() to independent states
      x86/fpu: Cleanup the on_boot_cpu clutter
      x86/fpu: Remove pointless memset in fpu_clone()
      x86/process: Clone FPU in copy_thread()
      x86/fpu: Do not inherit FPU context for kernel and IO worker threads
      x86/fpu: Cleanup xstate xcomp_bv initialization
      x86/fpu/xstate: Provide and use for_each_xfeature()
      x86/fpu/xstate: Mark all init only functions __init
      x86/fpu: Move KVMs FPU swapping to FPU core
      x86/fpu: Replace KVMs home brewed FPU copy from user
      x86/fpu: Rework copy_xstate_to_uabi_buf()
      x86/fpu: Mark fpu__init_prepare_fx_sw_frame() as __init
      x86/fpu: Move context switch and exit to user inlines into sched.h
      x86/fpu: Clean up CPU feature tests
      x86/fpu: Make os_xrstor_booting() private
      x86/fpu: Move os_xsave() and os_xrstor() to core
      x86/fpu: Move legacy ASM wrappers to core
      x86/fpu: Make WARN_ON_FPU() private
      x86/fpu: Move fpregs_restore_userregs() to core
      x86/fpu: Move mxcsr related code to core
      x86/fpu: Move fpstate functions to api.h
      x86/fpu: Remove internal.h dependency from fpu/signal.h
      x86/sev: Include fpu/xcr.h
      x86/fpu: Mop up the internal.h leftovers
      x86/fpu: Replace the includes of fpu/internal.h
      x86/fpu: Provide a proper function for ex_handler_fprestore()
      x86/fpu: Replace KVMs home brewed FPU copy to user
      x86/fpu: Provide struct fpstate
      x86/fpu: Convert fpstate_init() to struct fpstate
      x86/fpu: Convert restore_fpregs_from_fpstate() to struct fpstate
      x86/fpu: Replace KVMs xstate component clearing
      x86/KVM: Convert to fpstate
      x86/fpu: Convert tracing to fpstate
      x86/fpu/regset: Convert to fpstate
      x86/fpu/signal: Convert to fpstate
      x86/fpu/core: Convert to fpstate
      x86/math-emu: Convert to fpstate
      x86/fpu: Remove fpu::state
      x86/fpu: Do not leak fpstate pointer on fork
      x86/process: Move arch_thread_struct_whitelist() out of line
      x86/fpu: Add size and mask information to fpstate
      x86/fpu: Use fpstate::size
      x86/fpu/xstate: Use fpstate for os_xsave()
      x86/fpu/xstate: Use fpstate for xsave_to_user_sigframe()
      x86/fpu: Use fpstate in fpu_copy_kvm_uabi_to_fpstate()
      x86/fpu: Use fpstate in __copy_xstate_to_uabi_buf()
      x86/fpu/xstate: Use fpstate for copy_uabi_to_xstate()
      x86/fpu/signal: Use fpstate for size and features
      x86/fpu: Provide struct fpu_config
      x86/fpu: Cleanup fpu__init_system_xstate_size_legacy()
      x86/fpu/xstate: Cleanup size calculations
      x86/fpu: Move xstate size to fpu_*_cfg
      x86/fpu: Move xstate feature masks to fpu_*_cfg
      x86/fpu: Mop up xfeatures_mask_uabi()
      x86/fpu: Rework restore_regs_from_fpstate()
      x86/fpu/xstate: Move remaining xfeature helpers to core
      x86/fpu: Prepare for sanitizing KVM FPU code
      x86/fpu: Provide infrastructure for KVM FPU cleanup
      x86/kvm: Convert FPU handling to a single swap buffer
      x86/fpu: Remove old KVM FPU interface
      signal: Add an optional check for altstack size
      x86/signal: Implement sigaltstack size validation
      x86/fpu: Add members to struct fpu to cache permission information
      x86/fpu: Add fpu_state_config::legacy_features
      x86/fpu: Add basic helpers for dynamically enabled features
      x86/signal: Use fpu::__state_user_size for sigalt stack validation
      x86/fpu: Prepare fpu_clone() for dynamically enabled features
      x86/fpu: Add sanity checks for XFD


 Documentation/admin-guide/kernel-parameters.txt |   9 +
 Documentation/x86/index.rst                     |   1 +
 Documentation/x86/xstate.rst                    |  65 ++
 arch/Kconfig                                    |   3 +
 arch/x86/Kconfig                                |  17 +
 arch/x86/events/perf_event.h                    |   1 +
 arch/x86/ia32/ia32_signal.c                     |  15 +-
 arch/x86/include/asm/asm.h                      |  50 +-
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/extable.h                  |  44 +-
 arch/x86/include/asm/extable_fixup_types.h      |  22 +
 arch/x86/include/asm/fpu/api.h                  |  58 +-
 arch/x86/include/asm/fpu/internal.h             | 540 --------------
 arch/x86/include/asm/fpu/sched.h                |  68 ++
 arch/x86/include/asm/fpu/signal.h               |  13 +-
 arch/x86/include/asm/fpu/types.h                | 214 +++++-
 arch/x86/include/asm/fpu/xcr.h                  |  11 -
 arch/x86/include/asm/fpu/xstate.h               |  90 +--
 arch/x86/include/asm/kvm_host.h                 |   7 +-
 arch/x86/include/asm/msr-index.h                |   2 +
 arch/x86/include/asm/msr.h                      |   4 +-
 arch/x86/include/asm/pkru.h                     |   2 +-
 arch/x86/include/asm/processor.h                |   9 +-
 arch/x86/include/asm/proto.h                    |   2 +-
 arch/x86/include/asm/segment.h                  |   2 +-
 arch/x86/include/asm/trace/fpu.h                |   4 +-
 arch/x86/include/uapi/asm/prctl.h               |   4 +
 arch/x86/kernel/cpu/bugs.c                      |   2 +-
 arch/x86/kernel/cpu/common.c                    |   2 +-
 arch/x86/kernel/cpu/cpuid-deps.c                |   2 +
 arch/x86/kernel/cpu/mce/core.c                  |  40 +-
 arch/x86/kernel/cpu/mce/internal.h              |  14 +-
 arch/x86/kernel/cpu/mce/severity.c              |  22 +-
 arch/x86/kernel/fpu/bugs.c                      |   2 +-
 arch/x86/kernel/fpu/context.h                   |  83 +++
 arch/x86/kernel/fpu/core.c                      | 392 +++++++++--
 arch/x86/kernel/fpu/init.c                      |  76 +-
 arch/x86/kernel/fpu/internal.h                  |  28 +
 arch/x86/kernel/fpu/legacy.h                    | 115 +++
 arch/x86/kernel/fpu/regset.c                    |  36 +-
 arch/x86/kernel/fpu/signal.c                    | 285 ++++----
 arch/x86/kernel/fpu/xstate.c                    | 898 +++++++++++++++++++---=
--
 arch/x86/kernel/fpu/xstate.h                    | 278 ++++++++
 arch/x86/kernel/process.c                       |  27 +-
 arch/x86/kernel/process_32.c                    |   5 +-
 arch/x86/kernel/process_64.c                    |   5 +-
 arch/x86/kernel/ptrace.c                        |   2 +-
 arch/x86/kernel/sev.c                           |   2 +-
 arch/x86/kernel/signal.c                        |  83 ++-
 arch/x86/kernel/smpboot.c                       |   2 +-
 arch/x86/kernel/traps.c                         |  40 +-
 arch/x86/kvm/svm/sev.c                          |   2 +-
 arch/x86/kvm/svm/svm.c                          |   7 +-
 arch/x86/kvm/vmx/vmx.c                          |   2 +-
 arch/x86/kvm/x86.c                              | 258 +------
 arch/x86/lib/copy_mc_64.S                       |   8 +-
 arch/x86/math-emu/fpu_aux.c                     |   2 +-
 arch/x86/math-emu/fpu_entry.c                   |   6 +-
 arch/x86/math-emu/fpu_system.h                  |   2 +-
 arch/x86/mm/extable.c                           | 135 ++--
 arch/x86/net/bpf_jit_comp.c                     |  11 +-
 arch/x86/power/cpu.c                            |   2 +-
 include/linux/signal.h                          |   6 +
 kernel/signal.c                                 |  35 +-
 scripts/sorttable.c                             |   4 +-
 tools/testing/selftests/x86/Makefile            |   2 +-
 tools/testing/selftests/x86/amx.c               | 851 ++++++++++++++++++++++
 67 files changed, 3458 insertions(+), 1575 deletions(-)
 create mode 100644 Documentation/x86/xstate.rst
 create mode 100644 arch/x86/include/asm/extable_fixup_types.h
 create mode 100644 arch/x86/include/asm/fpu/sched.h
 create mode 100644 arch/x86/kernel/fpu/context.h
 create mode 100644 arch/x86/kernel/fpu/internal.h
 create mode 100644 arch/x86/kernel/fpu/legacy.h
 create mode 100644 arch/x86/kernel/fpu/xstate.h
 create mode 100644 tools/testing/selftests/x86/amx.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..eb9a73ad91a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5497,6 +5497,15 @@
 	stifb=3D		[HW]
 			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]
=20
+        strict_sas_size=3D
+			[X86]
+			Format: <bool>
+			Enable or disable strict sigaltstack size checks
+			against the required signal frame size which
+			depends on the supported FPU features. This can
+			be used to filter out binaries which have
+			not yet been made aware of AT_MINSIGSTKSZ.
+
 	sunrpc.min_resvport=3D
 	sunrpc.max_resvport=3D
 			[NFS,SUNRPC]
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 383048396336..f498f1d36cd3 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -37,3 +37,4 @@ x86-specific Documentation
    sgx
    features
    elf_auxvec
+   xstate
diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
new file mode 100644
index 000000000000..65de3f054ba5
--- /dev/null
+++ b/Documentation/x86/xstate.rst
@@ -0,0 +1,65 @@
+Using XSTATE features in user space applications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The x86 architecture supports floating-point extensions which are
+enumerated via CPUID. Applications consult CPUID and use XGETBV to
+evaluate which features have been enabled by the kernel XCR0.
+
+Up to AVX-512 and PKRU states, these features are automatically enabled by
+the kernel if available. Features like AMX TILE_DATA (XSTATE component 18)
+are enabled by XCR0 as well, but the first use of related instruction is
+trapped by the kernel because by default the required large XSTATE buffers
+are not allocated automatically.
+
+Using dynamically enabled XSTATE features in user space applications
+--------------------------------------------------------------------
+
+The kernel provides an arch_prctl(2) based mechanism for applications to
+request the usage of such features. The arch_prctl(2) options related to
+this are:
+
+-ARCH_GET_XCOMP_SUPP
+
+ arch_prctl(ARCH_GET_XCOMP_SUPP, &features);
+
+ ARCH_GET_XCOMP_SUPP stores the supported features in userspace storage of
+ type uint64_t. The second argument is a pointer to that storage.
+
+-ARCH_GET_XCOMP_PERM
+
+ arch_prctl(ARCH_GET_XCOMP_PERM, &features);
+
+ ARCH_GET_XCOMP_PERM stores the features for which the userspace process
+ has permission in userspace storage of type uint64_t. The second argument
+ is a pointer to that storage.
+
+-ARCH_REQ_XCOMP_PERM
+
+ arch_prctl(ARCH_REQ_XCOMP_PERM, feature_nr);
+
+ ARCH_REQ_XCOMP_PERM allows to request permission for a dynamically enabled
+ feature or a feature set. A feature set can be mapped to a facility, e.g.
+ AMX, and can require one or more XSTATE components to be enabled.
+
+ The feature argument is the number of the highest XSTATE component which
+ is required for a facility to work.
+
+When requesting permission for a feature, the kernel checks the
+availability. The kernel ensures that sigaltstacks in the process's tasks
+are large enough to accommodate the resulting large signal frame. It
+enforces this both during ARCH_REQ_XCOMP_SUPP and during any subsequent
+sigaltstack(2) calls. If an installed sigaltstack is smaller than the
+resulting sigframe size, ARCH_REQ_XCOMP_SUPP results in -ENOSUPP. Also,
+sigaltstack(2) results in -ENOMEM if the requested altstack is too small
+for the permitted features.
+
+Permission, when granted, is valid per process. Permissions are inherited
+on fork(2) and cleared on exec(3).
+
+The first use of an instruction related to a dynamically enabled feature is
+trapped by the kernel. The trap handler checks whether the process has
+permission to use the feature. If the process has no permission then the
+kernel sends SIGILL to the application. If the process has permission then
+the handler allocates a larger xstate buffer for the task so the large
+state can be context switched. In the unlikely cases that the allocation
+fails, the kernel sends SIGSEGV.
diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..af5cf3009b4f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1288,6 +1288,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
=20
+config DYNAMIC_SIGFRAME
+	bool
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d9830e7e1060..8584b30e2536 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
+	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
@@ -2388,6 +2389,22 @@ config MODIFY_LDT_SYSCALL
=20
 	  Saying 'N' here may make sense for embedded or server kernels.
=20
+config STRICT_SIGALTSTACK_SIZE
+	bool "Enforce strict size checking for sigaltstack"
+	depends on DYNAMIC_SIGFRAME
+	help
+	  For historical reasons MINSIGSTKSZ is a constant which became
+	  already too small with AVX512 support. Add a mechanism to
+	  enforce strict checking of the sigaltstack size against the
+	  real size of the FPU frame. This option enables the check
+	  by default. It can also be controlled via the kernel command
+	  line option 'strict_sas_size' independent of this config
+	  switch. Enabling it might break existing applications which
+	  allocate a too small sigaltstack but 'work' because they
+	  never get a signal delivered.
+
+	  Say 'N' unless you want to really enforce this check.
+
 source "kernel/livepatch/Kconfig"
=20
 endmenu
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..134c08df7340 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -14,6 +14,7 @@
=20
 #include <linux/perf_event.h>
=20
+#include <asm/fpu/xstate.h>
 #include <asm/intel_ds.h>
 #include <asm/cpu.h>
=20
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7fd5fb..c9c3859322fa 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -24,7 +24,6 @@
 #include <linux/syscalls.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/ptrace.h>
 #include <asm/ia32_unistd.h>
@@ -57,8 +56,8 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 /*
  * Do a signal return; undo the signal stack.
  */
-static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *usc)
+static bool ia32_restore_sigcontext(struct pt_regs *regs,
+				    struct sigcontext_32 __user *usc)
 {
 	struct sigcontext_32 sc;
=20
@@ -66,7 +65,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn =3D do_no_restart_syscall;
=20
 	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
-		return -EFAULT;
+		return false;
=20
 	/* Get only the ia32 registers. */
 	regs->bx =3D sc.bx;
@@ -111,7 +110,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
=20
 	set_current_blocked(&set);
=20
-	if (ia32_restore_sigcontext(regs, &frame->sc))
+	if (!ia32_restore_sigcontext(regs, &frame->sc))
 		goto badframe;
 	return regs->ax;
=20
@@ -135,7 +134,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
=20
 	set_current_blocked(&set);
=20
-	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
=20
 	if (compat_restore_altstack(&frame->uc.uc_stack))
@@ -220,8 +219,8 @@ static void __user *get_sigframe(struct ksignal *ksig, st=
ruct pt_regs *regs,
=20
 	sp =3D fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate =3D (struct _fpstate_32 __user *) sp;
-	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				     math_size) < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
+				      math_size))
 		return (void __user *) -1L;
=20
 	sp -=3D frame_size;
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ad3da9a7d97..6aadb9a620ee 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -122,28 +122,19 @@
=20
 #ifdef __KERNEL__
=20
+# include <asm/extable_fixup_types.h>
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
 	.long (from) - . ;					\
 	.long (to) - . ;					\
-	.long (handler) - . ;					\
+	.long type ;						\
 	.popsection
=20
-# define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
-
-# define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
-
-# define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
-
-# define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
 # ifdef CONFIG_KPROBES
 #  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
@@ -155,27 +146,15 @@
 # endif
=20
 #else /* ! __ASSEMBLY__ */
-# define _EXPAND_EXTABLE_HANDLE(x) #x
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
 	" .long (" #from ") - .\n"				\
 	" .long (" #to ") - .\n"				\
-	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .long " __stringify(type) " \n"			\
 	" .popsection\n"
=20
-# define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
-
-# define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
-
-# define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
-
-# define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
 /* For C file, we already have NOKPROBE_SYMBOL macro */
=20
 /*
@@ -188,6 +167,17 @@ register unsigned long current_stack_pointer asm(_ASM_SP=
);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
=20
-#endif /* __KERNEL__ */
+#define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_DEFAULT)
=20
+#define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
+
+#define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
+
+#define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
+
+#endif /* __KERNEL__ */
 #endif /* _ASM_X86_ASM_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index d0ce5cfd3ac1..d5b5f2ab87a0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -277,6 +277,7 @@
 #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX =3D 1 instruction=
 */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* "" eXtended Feature Disabling */
=20
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in vario=
us
@@ -298,6 +299,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions =
*/
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
=20
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 1f0cbc52937c..93f400eb728f 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -1,12 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_EXTABLE_H
 #define _ASM_X86_EXTABLE_H
+
+#include <asm/extable_fixup_types.h>
+
 /*
- * The exception table consists of triples of addresses relative to the
- * exception table entry itself. The first address is of an instruction
- * that is allowed to fault, the second is the target at which the program
- * should continue. The third is a handler function to deal with the fault
- * caused by the instruction in the first field.
+ * The exception table consists of two addresses relative to the
+ * exception table entry itself and a type selector field.
+ *
+ * The first address is of an instruction that is allowed to fault, the
+ * second is the target at which the program should continue.
+ *
+ * The type entry is used by fixup_exception() to select the handler to
+ * deal with the fault caused by the instruction in the first field.
  *
  * All the routines below use bits of fixup code that are out of line
  * with the main instruction path.  This means when everything is well,
@@ -15,7 +21,7 @@
  */
=20
 struct exception_table_entry {
-	int insn, fixup, handler;
+	int insn, fixup, type;
 };
 struct pt_regs;
=20
@@ -25,21 +31,27 @@ struct pt_regs;
 	do {							\
 		(a)->fixup =3D (b)->fixup + (delta);		\
 		(b)->fixup =3D (tmp).fixup - (delta);		\
-		(a)->handler =3D (b)->handler + (delta);		\
-		(b)->handler =3D (tmp).handler - (delta);		\
+		(a)->type =3D (b)->type;				\
+		(b)->type =3D (tmp).type;				\
 	} while (0)
=20
-enum handler_type {
-	EX_HANDLER_NONE,
-	EX_HANDLER_FAULT,
-	EX_HANDLER_UACCESS,
-	EX_HANDLER_OTHER
-};
-
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
-extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
+extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
=20
+#ifdef CONFIG_X86_MCE
+extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+#else
+static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+#endif
+
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *r=
egs);
+#else
+static inline bool ex_handler_bpf(const struct exception_table_entry *x,
+				  struct pt_regs *regs) { return false; }
+#endif
+
 #endif
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/as=
m/extable_fixup_types.h
new file mode 100644
index 000000000000..409524d5d2eb
--- /dev/null
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
+#define _ASM_X86_EXTABLE_FIXUP_TYPES_H
+
+#define	EX_TYPE_NONE			 0
+#define	EX_TYPE_DEFAULT			 1
+#define	EX_TYPE_FAULT			 2
+#define	EX_TYPE_UACCESS			 3
+#define	EX_TYPE_COPY			 4
+#define	EX_TYPE_CLEAR_FS		 5
+#define	EX_TYPE_FPU_RESTORE		 6
+#define	EX_TYPE_WRMSR			 7
+#define	EX_TYPE_RDMSR			 8
+#define	EX_TYPE_BPF			 9
+
+#define	EX_TYPE_WRMSR_IN_MCE		10
+#define	EX_TYPE_RDMSR_IN_MCE		11
+
+#define	EX_TYPE_DEFAULT_MCE_SAFE	12
+#define	EX_TYPE_FAULT_MCE_SAFE		13
+
+#endif
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 23bef08a8388..b7267b9e452f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -12,6 +12,8 @@
 #define _ASM_X86_FPU_API_H
 #include <linux/bottom_half.h>
=20
+#include <asm/fpu/types.h>
+
 /*
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
  * disables preemption so be careful if you intend to use it for long periods
@@ -48,9 +50,9 @@ static inline void kernel_fpu_begin(void)
 }
=20
 /*
- * Use fpregs_lock() while editing CPU's FPU registers or fpu->state.
+ * Use fpregs_lock() while editing CPU's FPU registers or fpu->fpstate.
  * A context switch will (and softirq might) save CPU's FPU registers to
- * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
+ * fpu->fpstate.regs and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
  *
  * local_bh_disable() protects against both preemption and soft interrupts
@@ -108,4 +110,56 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const c=
har **feature_name);
=20
 static inline void update_pasid(void) { }
=20
+/* Trap handling */
+extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
+extern void fpu_sync_fpstate(struct fpu *fpu);
+extern void fpu_reset_from_exception_fixup(void);
+
+/* Boot, hotplug and resume */
+extern void fpu__init_cpu(void);
+extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_check_bugs(void);
+extern void fpu__resume_cpu(void);
+
+#ifdef CONFIG_MATH_EMULATION
+extern void fpstate_init_soft(struct swregs_state *soft);
+#else
+static inline void fpstate_init_soft(struct swregs_state *soft) {}
+#endif
+
+/* State tracking */
+DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
+
+/* Process cleanup */
+#ifdef CONFIG_X86_64
+extern void fpstate_free(struct fpu *fpu);
+#else
+static inline void fpstate_free(struct fpu *fpu) { }
+#endif
+
+/* fpstate-related functions which are exported to KVM */
+extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int=
 xfeature);
+
+/* KVM specific functions */
+extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
+extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
+extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
+
+extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf=
, unsigned int size, u32 pkru);
+extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void=
 *buf, u64 xcr0, u32 *vpkru);
+
+static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
+{
+	gfpu->fpstate->is_confidential =3D true;
+}
+
+static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
+{
+	return gfpu->fpstate->is_confidential;
+}
+
+/* prctl */
+struct task_struct;
+extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned l=
ong arg2);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/i=
nternal.h
index 5a18694a89b2..e69de29bb2d1 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -1,540 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 1994 Linus Torvalds
- *
- * Pentium III FXSR, SSE support
- * General FPU state handling cleanups
- *	Gareth Hughes <gareth@valinux.com>, May 2000
- * x86-64 work by Andi Kleen 2002
- */
-
-#ifndef _ASM_X86_FPU_INTERNAL_H
-#define _ASM_X86_FPU_INTERNAL_H
-
-#include <linux/compat.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-
-#include <asm/user.h>
-#include <asm/fpu/api.h>
-#include <asm/fpu/xstate.h>
-#include <asm/fpu/xcr.h>
-#include <asm/cpufeature.h>
-#include <asm/trace/fpu.h>
-
-/*
- * High level FPU state handling functions:
- */
-extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
-extern void fpu__drop(struct fpu *fpu);
-extern void fpu__clear_user_states(struct fpu *fpu);
-extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
-
-extern void fpu_sync_fpstate(struct fpu *fpu);
-
-/* Clone and exit operations */
-extern int  fpu_clone(struct task_struct *dst);
-extern void fpu_flush_thread(void);
-
-/*
- * Boot time FPU initialization functions:
- */
-extern void fpu__init_cpu(void);
-extern void fpu__init_system_xstate(void);
-extern void fpu__init_cpu_xstate(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
-extern void fpu__init_check_bugs(void);
-extern void fpu__resume_cpu(void);
-
-/*
- * Debugging facility:
- */
-#ifdef CONFIG_X86_DEBUG_FPU
-# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
-#else
-# define WARN_ON_FPU(x) ({ (void)(x); 0; })
-#endif
-
-/*
- * FPU related CPU feature flag helper routines:
- */
-static __always_inline __pure bool use_xsaveopt(void)
-{
-	return static_cpu_has(X86_FEATURE_XSAVEOPT);
-}
-
-static __always_inline __pure bool use_xsave(void)
-{
-	return static_cpu_has(X86_FEATURE_XSAVE);
-}
-
-static __always_inline __pure bool use_fxsr(void)
-{
-	return static_cpu_has(X86_FEATURE_FXSR);
-}
-
-/*
- * fpstate handling functions:
- */
-
-extern union fpregs_state init_fpstate;
-
-extern void fpstate_init(union fpregs_state *state);
-#ifdef CONFIG_MATH_EMULATION
-extern void fpstate_init_soft(struct swregs_state *soft);
-#else
-static inline void fpstate_init_soft(struct swregs_state *soft) {}
-#endif
-extern void save_fpregs_to_fpstate(struct fpu *fpu);
-
-/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
-#define user_insn(insn, output, input...)				\
-({									\
-	int err;							\
-									\
-	might_fault();							\
-									\
-	asm volatile(ASM_STAC "\n"					\
-		     "1: " #insn "\n"					\
-		     "2: " ASM_CLAC "\n"				\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  negl %%eax\n"					\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
-		     : [err] "=3Da" (err), output				\
-		     : "0"(0), input);					\
-	err;								\
-})
-
-#define kernel_insn_err(insn, output, input...)				\
-({									\
-	int err;							\
-	asm volatile("1:" #insn "\n\t"					\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=3Dr" (err), output				\
-		     : "0"(0), input);					\
-	err;								\
-})
-
-#define kernel_insn(insn, output, input...)				\
-	asm volatile("1:" #insn "\n\t"					\
-		     "2:\n"						\
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
-		     : output : input)
-
-static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
-{
-	return user_insn(fnsave %[fx]; fwait,  [fx] "=3Dm" (*fx), "m" (*fx));
-}
-
-static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxsave %[fx], [fx] "=3Dm" (*fx), "m" (*fx));
-	else
-		return user_insn(fxsaveq %[fx], [fx] "=3Dm" (*fx), "m" (*fx));
-
-}
-
-static inline void fxrstor(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		kernel_insn(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-	else
-		kernel_insn(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline int fxrstor_safe(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return kernel_insn_err(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-	else
-		return kernel_insn_err(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-	else
-		return user_insn(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline void frstor(struct fregs_state *fx)
-{
-	kernel_insn(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline int frstor_safe(struct fregs_state *fx)
-{
-	return kernel_insn_err(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
-{
-	return user_insn(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
-}
-
-static inline void fxsave(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=3Dm" (*fx));
-	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=3Dm" (*fx));
-}
-
-/* These macros all use (%edi)/(%rdi) as the single memory argument. */
-#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
-#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
-#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
-#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
-#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
-
-/*
- * After this @err contains 0 on success or the negated trap number when
- * the operation raises an exception. For faults this results in -EFAULT.
- */
-#define XSTATE_OP(op, st, lmask, hmask, err)				\
-	asm volatile("1:" op "\n\t"					\
-		     "xor %[err], %[err]\n"				\
-		     "2:\n\t"						\
-		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: negl %%eax\n\t"				\
-		     "jmp 2b\n\t"					\
-		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
-		     : [err] "=3Da" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
- * format and supervisor states in addition to modified optimization in
- * XSAVEOPT.
- *
- * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEO=
PT
- * supports modified optimization which is not supported by XSAVE.
- *
- * We use XSAVE as a fallback.
- *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
- * original instruction which gets replaced. We need to use it here as the
- * address of the instruction where we might get an exception at.
- */
-#define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_2(XSAVE,				\
-				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
-				   XSAVES,   X86_FEATURE_XSAVES)	\
-		     "\n"						\
-		     "xor %[err], %[err]\n"				\
-		     "3:\n"						\
-		     ".pushsection .fixup,\"ax\"\n"			\
-		     "4: movl $-2, %[err]\n"				\
-		     "jmp 3b\n"						\
-		     ".popsection\n"					\
-		     _ASM_EXTABLE(661b, 4b)				\
-		     : [err] "=3Dr" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
- * XSAVE area format.
- */
-#define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile(ALTERNATIVE(XRSTOR,				\
-				 XRSTORS, X86_FEATURE_XSAVES)		\
-		     "\n"						\
-		     "3:\n"						\
-		     _ASM_EXTABLE_HANDLE(661b, 3b, ex_handler_fprestore)\
-		     :							\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * This function is called only during boot time when x86 caps are not set
- * up and alternative can not be used yet.
- */
-static inline void os_xrstor_booting(struct xregs_state *xstate)
-{
-	u64 mask =3D xfeatures_mask_fpstate();
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-	int err;
-
-	WARN_ON(system_state !=3D SYSTEM_BOOTING);
-
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-	else
-		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-
-	/*
-	 * We should never fault when copying from a kernel buffer, and the FPU
-	 * state we set at boot time should be valid.
-	 */
-	WARN_ON_FPU(err);
-}
-
-/*
- * Save processor xstate to xsave area.
- *
- * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
- * and command line options. The choice is permanent until the next reboot.
- */
-static inline void os_xsave(struct xregs_state *xstate)
-{
-	u64 mask =3D xfeatures_mask_all;
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-	int err;
-
-	WARN_ON_FPU(!alternatives_patched);
-
-	XSTATE_XSAVE(xstate, lmask, hmask, err);
-
-	/* We should never fault when copying to a kernel buffer: */
-	WARN_ON_FPU(err);
-}
-
-/*
- * Restore processor xstate from xsave area.
- *
- * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
- */
-static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
-{
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-
-	XSTATE_XRESTORE(xstate, lmask, hmask);
-}
-
-/*
- * Save xstate to user space xsave area.
- *
- * We don't use modified optimization because xrstor/xrstors might track
- * a different application.
- *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
- */
-static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
-{
-	/*
-	 * Include the features which are not xsaved/rstored by the kernel
-	 * internally, e.g. PKRU. That's user space ABI and also required
-	 * to allow the signal handler to modify PKRU.
-	 */
-	u64 mask =3D xfeatures_mask_uabi();
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-	int err;
-
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err =3D __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
-	stac();
-	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
-	clac();
-
-	return err;
-}
-
-/*
- * Restore xstate from user space xsave area.
- */
-static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, =
u64 mask)
-{
-	struct xregs_state *xstate =3D ((__force struct xregs_state *)buf);
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-	int err;
-
-	stac();
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-	clac();
-
-	return err;
-}
-
-/*
- * Restore xstate from kernel space xsave area, return an error code instead=
 of
- * an exception.
- */
-static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
-{
-	u32 lmask =3D mask;
-	u32 hmask =3D mask >> 32;
-	int err;
-
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
-		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-	else
-		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-
-	return err;
-}
-
-extern void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 m=
ask);
-
-static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
-{
-	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
-}
-
-extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int s=
ize);
-
-/*
- * FPU context switch related helper methods:
- */
-
-DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
-
-/*
- * The in-register FPU state for an FPU context on a CPU is assumed to be
- * valid if the fpu->last_cpu matches the CPU, and the fpu_fpregs_owner_ctx
- * matches the FPU.
- *
- * If the FPU register state is valid, the kernel can skip restoring the
- * FPU state from memory.
- *
- * Any code that clobbers the FPU registers or updates the in-memory
- * FPU state for a task MUST let the rest of the kernel know that the
- * FPU registers are no longer valid for this task.
- *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
- * (with preemption disabled), FPU for the current task, or a task that
- * is prevented from running by the current task.
- */
-static inline void __cpu_invalidate_fpregs_state(void)
-{
-	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
-}
-
-static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
-{
-	fpu->last_cpu =3D -1;
-}
-
-static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
-{
-	return fpu =3D=3D this_cpu_read(fpu_fpregs_owner_ctx) && cpu =3D=3D fpu->la=
st_cpu;
-}
-
-/*
- * These generally need preemption protection to work,
- * do try to avoid using these on their own:
- */
-static inline void fpregs_deactivate(struct fpu *fpu)
-{
-	this_cpu_write(fpu_fpregs_owner_ctx, NULL);
-	trace_x86_fpu_regs_deactivated(fpu);
-}
-
-static inline void fpregs_activate(struct fpu *fpu)
-{
-	this_cpu_write(fpu_fpregs_owner_ctx, fpu);
-	trace_x86_fpu_regs_activated(fpu);
-}
-
-/* Internal helper for switch_fpu_return() and signal frame setup */
-static inline void fpregs_restore_userregs(void)
-{
-	struct fpu *fpu =3D &current->thread.fpu;
-	int cpu =3D smp_processor_id();
-
-	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
-		return;
-
-	if (!fpregs_state_valid(fpu, cpu)) {
-		u64 mask;
-
-		/*
-		 * This restores _all_ xstate which has not been
-		 * established yet.
-		 *
-		 * If PKRU is enabled, then the PKRU value is already
-		 * correct because it was either set in switch_to() or in
-		 * flush_thread(). So it is excluded because it might be
-		 * not up to date in current->thread.fpu.xsave state.
-		 */
-		mask =3D xfeatures_mask_restore_user() |
-			xfeatures_mask_supervisor();
-		__restore_fpregs_from_fpstate(&fpu->state, mask);
-
-		fpregs_activate(fpu);
-		fpu->last_cpu =3D cpu;
-	}
-	clear_thread_flag(TIF_NEED_FPU_LOAD);
-}
-
-/*
- * FPU state switching for scheduling.
- *
- * This is a two-stage process:
- *
- *  - switch_fpu_prepare() saves the old state.
- *    This is done within the context of the old process.
- *
- *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
- *    will get loaded on return to userspace, or when the kernel needs it.
- *
- * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
- * are saved in the current thread's FPU register state.
- *
- * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
- * hold current()'s FPU registers. It is required to load the
- * registers before returning to userland or using the content
- * otherwise.
- *
- * The FPU context is only stored/restored for a user task and
- * PF_KTHREAD is used to distinguish between kernel and user threads.
- */
-static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
-{
-	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		save_fpregs_to_fpstate(old_fpu);
-		/*
-		 * The save operation preserved register state, so the
-		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
-		 * current CPU number in @old_fpu, so the next return
-		 * to user space can avoid the FPU register restore
-		 * when is returns on the same CPU and still owns the
-		 * context.
-		 */
-		old_fpu->last_cpu =3D cpu;
-
-		trace_x86_fpu_regs_deactivated(old_fpu);
-	}
-}
-
-/*
- * Misc helper functions:
- */
-
-/*
- * Delay loading of the complete FPU state until the return to userland.
- * PKRU is handled separately.
- */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
-{
-	if (cpu_feature_enabled(X86_FEATURE_FPU))
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-}
-
-#endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sche=
d.h
new file mode 100644
index 000000000000..99a8820e8cc4
--- /dev/null
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPU_SCHED_H
+#define _ASM_X86_FPU_SCHED_H
+
+#include <linux/sched.h>
+
+#include <asm/cpufeature.h>
+#include <asm/fpu/types.h>
+
+#include <asm/trace/fpu.h>
+
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
+extern void fpu__drop(struct fpu *fpu);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags);
+extern void fpu_flush_thread(void);
+
+/*
+ * FPU state switching for scheduling.
+ *
+ * This is a two-stage process:
+ *
+ *  - switch_fpu_prepare() saves the old state.
+ *    This is done within the context of the old process.
+ *
+ *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
+ *    will get loaded on return to userspace, or when the kernel needs it.
+ *
+ * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
+ * are saved in the current thread's FPU register state.
+ *
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
+ * hold current()'s FPU registers. It is required to load the
+ * registers before returning to userland or using the content
+ * otherwise.
+ *
+ * The FPU context is only stored/restored for a user task and
+ * PF_KTHREAD is used to distinguish between kernel and user threads.
+ */
+static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
+	    !(current->flags & PF_KTHREAD)) {
+		save_fpregs_to_fpstate(old_fpu);
+		/*
+		 * The save operation preserved register state, so the
+		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
+		 * current CPU number in @old_fpu, so the next return
+		 * to user space can avoid the FPU register restore
+		 * when is returns on the same CPU and still owns the
+		 * context.
+		 */
+		old_fpu->last_cpu =3D cpu;
+
+		trace_x86_fpu_regs_deactivated(old_fpu);
+	}
+}
+
+/*
+ * Delay loading of the complete FPU state until the return to userland.
+ * PKRU is handled separately.
+ */
+static inline void switch_fpu_finish(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FPU))
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+}
+
+#endif /* _ASM_X86_FPU_SCHED_H */
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/sig=
nal.h
index 8b6631dffefd..22b0273a8bf1 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -5,6 +5,11 @@
 #ifndef _ASM_X86_FPU_SIGNAL_H
 #define _ASM_X86_FPU_SIGNAL_H
=20
+#include <linux/compat.h>
+#include <linux/user.h>
+
+#include <asm/fpu/types.h>
+
 #ifdef CONFIG_X86_64
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
@@ -31,6 +36,12 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
=20
 unsigned long fpu__get_fpstate_size(void);
=20
-extern void fpu__init_prepare_fx_sw_frame(void);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int =
size);
+extern void fpu__clear_user_states(struct fpu *fpu);
+extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
+
+extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask);
+
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int =
size);
=20
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/type=
s.h
index f5a38a5f3ae1..3c06c82ab355 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -120,6 +120,9 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILE_CFG,
+	XFEATURE_XTILE_DATA,
=20
 	XFEATURE_MAX,
 };
@@ -136,12 +139,21 @@ enum xfeature {
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
+#define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
+#define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
=20
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
 					 | XFEATURE_MASK_ZMM_Hi256 \
 					 | XFEATURE_MASK_Hi16_ZMM)
=20
+#ifdef CONFIG_X86_64
+# define XFEATURE_MASK_XTILE		(XFEATURE_MASK_XTILE_DATA \
+					 | XFEATURE_MASK_XTILE_CFG)
+#else
+# define XFEATURE_MASK_XTILE		(0)
+#endif
+
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
=20
 struct reg_128_bit {
@@ -153,6 +165,9 @@ struct reg_256_bit {
 struct reg_512_bit {
 	u8	regbytes[512/8];
 };
+struct reg_1024_byte {
+	u8	regbytes[1024];
+};
=20
 /*
  * State component 2:
@@ -255,6 +270,23 @@ struct arch_lbr_state {
 	u64 ler_to;
 	u64 ler_info;
 	struct lbr_entry		entries[];
+};
+
+/*
+ * State component 17: 64-byte tile configuration register.
+ */
+struct xtile_cfg {
+	u64				tcfg[8];
+} __packed;
+
+/*
+ * State component 18: 1KB tile data register.
+ * Each register represents 16 64-byte rows of the matrix
+ * data. But the number of registers depends on the actual
+ * implementation.
+ */
+struct xtile_data {
+	struct reg_1024_byte		tmm;
 } __packed;
=20
 /*
@@ -309,6 +341,91 @@ union fpregs_state {
 	u8 __padding[PAGE_SIZE];
 };
=20
+struct fpstate {
+	/* @kernel_size: The size of the kernel register image */
+	unsigned int		size;
+
+	/* @user_size: The size in non-compacted UABI format */
+	unsigned int		user_size;
+
+	/* @xfeatures:		xfeatures for which the storage is sized */
+	u64			xfeatures;
+
+	/* @user_xfeatures:	xfeatures valid in UABI buffers */
+	u64			user_xfeatures;
+
+	/* @xfd:		xfeatures disabled to trap userspace use. */
+	u64			xfd;
+
+	/* @is_valloc:		Indicator for dynamically allocated state */
+	unsigned int		is_valloc	: 1;
+
+	/* @is_guest:		Indicator for guest state (KVM) */
+	unsigned int		is_guest	: 1;
+
+	/*
+	 * @is_confidential:	Indicator for KVM confidential mode.
+	 *			The FPU registers are restored by the
+	 *			vmentry firmware from encrypted guest
+	 *			memory. On vmexit the FPU registers are
+	 *			saved by firmware to encrypted guest memory
+	 *			and the registers are scrubbed before
+	 *			returning to the host. So there is no
+	 *			content which is worth saving and restoring.
+	 *			The fpstate has to be there so that
+	 *			preemption and softirq FPU usage works
+	 *			without special casing.
+	 */
+	unsigned int		is_confidential	: 1;
+
+	/* @in_use:		State is in use */
+	unsigned int		in_use		: 1;
+
+	/* @regs: The register state union for all supported formats */
+	union fpregs_state	regs;
+
+	/* @regs is dynamically sized! Don't add anything after @regs! */
+} __aligned(64);
+
+struct fpu_state_perm {
+	/*
+	 * @__state_perm:
+	 *
+	 * This bitmap indicates the permission for state components, which
+	 * are available to a thread group. The permission prctl() sets the
+	 * enabled state bits in thread_group_leader()->thread.fpu.
+	 *
+	 * All run time operations use the per thread information in the
+	 * currently active fpu.fpstate which contains the xfeature masks
+	 * and sizes for kernel and user space.
+	 *
+	 * This master permission field is only to be used when
+	 * task.fpu.fpstate based checks fail to validate whether the task
+	 * is allowed to expand it's xfeatures set which requires to
+	 * allocate a larger sized fpstate buffer.
+	 *
+	 * Do not access this field directly.  Use the provided helper
+	 * function. Unlocked access is possible for quick checks.
+	 */
+	u64				__state_perm;
+
+	/*
+	 * @__state_size:
+	 *
+	 * The size required for @__state_perm. Only valid to access
+	 * with sighand locked.
+	 */
+	unsigned int			__state_size;
+
+	/*
+	 * @__user_state_size:
+	 *
+	 * The size required for @__state_perm user part. Only valid to
+	 * access with sighand locked.
+	 */
+	unsigned int			__user_state_size;
+};
+
 /*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
@@ -337,19 +454,100 @@ struct fpu {
 	unsigned long			avx512_timestamp;
=20
 	/*
-	 * @state:
+	 * @fpstate:
+	 *
+	 * Pointer to the active struct fpstate. Initialized to
+	 * point at @__fpstate below.
+	 */
+	struct fpstate			*fpstate;
+
+	/*
+	 * @__task_fpstate:
+	 *
+	 * Pointer to an inactive struct fpstate. Initialized to NULL. Is
+	 * used only for KVM support to swap out the regular task fpstate.
+	 */
+	struct fpstate			*__task_fpstate;
+
+	/*
+	 * @perm:
+	 *
+	 * Permission related information
+	 */
+	struct fpu_state_perm		perm;
+
+	/*
+	 * @__fpstate:
 	 *
-	 * In-memory copy of all FPU registers that we save/restore
-	 * over context switches. If the task is using the FPU then
-	 * the registers in the FPU are more recent than this state
-	 * copy. If the task context-switches away then they get
-	 * saved here and represent the FPU state.
+	 * Initial in-memory storage for FPU registers which are saved in
+	 * context switch and when the kernel uses the FPU. The registers
+	 * are restored from this storage on return to user space if they
+	 * are not longer containing the tasks FPU register state.
 	 */
-	union fpregs_state		state;
+	struct fpstate			__fpstate;
 	/*
-	 * WARNING: 'state' is dynamically-sized.  Do not put
+	 * WARNING: '__fpstate' is dynamically-sized.  Do not put
 	 * anything after it here.
 	 */
 };
=20
+/*
+ * Guest pseudo FPU container
+ */
+struct fpu_guest {
+	/*
+	 * @fpstate:			Pointer to the allocated guest fpstate
+	 */
+	struct fpstate			*fpstate;
+};
+
+/*
+ * FPU state configuration data. Initialized at boot time. Read only after i=
nit.
+ */
+struct fpu_state_config {
+	/*
+	 * @max_size:
+	 *
+	 * The maximum size of the register state buffer. Includes all
+	 * supported features except independent managed features.
+	 */
+	unsigned int		max_size;
+
+	/*
+	 * @default_size:
+	 *
+	 * The default size of the register state buffer. Includes all
+	 * supported features except independent managed features and
+	 * features which have to be requested by user space before usage.
+	 */
+	unsigned int		default_size;
+
+	/*
+	 * @max_features:
+	 *
+	 * The maximum supported features bitmap. Does not include
+	 * independent managed features.
+	 */
+	u64 max_features;
+
+	/*
+	 * @default_features:
+	 *
+	 * The default supported features bitmap. Does not include
+	 * independent managed features and features which have to
+	 * be requested by user space before usage.
+	 */
+	u64 default_features;
+	/*
+	 * @legacy_features:
+	 *
+	 * Features which can be reported back to user space
+	 * even without XSAVE support, i.e. legacy features FP + SSE
+	 */
+	u64 legacy_features;
+};
+
+/* FPU state configuration information */
+extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
+
 #endif /* _ASM_X86_FPU_H */
diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
index 1c7ab8d95da5..79f95d3787e2 100644
--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -2,17 +2,6 @@
 #ifndef _ASM_X86_FPU_XCR_H
 #define _ASM_X86_FPU_XCR_H
=20
-/*
- * MXCSR and XCR definitions:
- */
-
-static inline void ldmxcsr(u32 mxcsr)
-{
-	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
-}
-
-extern unsigned int mxcsr_feature_mask;
-
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
=20
 static inline u64 xgetbv(u32 index)
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xst=
ate.h
index 109dfcc75299..0f8b90ab18c9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -14,6 +14,8 @@
=20
 #define XSTATE_CPUID		0x0000000d
=20
+#define TILE_CPUID		0x0000001d
+
 #define FXSAVE_SIZE	512
=20
 #define XSAVE_HDR_SIZE	    64
@@ -33,7 +35,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
=20
 /*
  * Features which are restored when returning to user space.
@@ -43,6 +46,9 @@
 #define XFEATURE_MASK_USER_RESTORE	\
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
=20
+/* Features which are dynamically enabled for a process on request */
+#define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
=20
@@ -78,78 +84,42 @@
 				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
=20
-#ifdef CONFIG_X86_64
-#define REX_PREFIX	"0x48, "
-#else
-#define REX_PREFIX
-#endif
-
-extern u64 xfeatures_mask_all;
-
-static inline u64 xfeatures_mask_supervisor(void)
-{
-	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
 /*
- * The xfeatures which are enabled in XCR0 and expected to be in ptrace
- * buffers and signal frames.
+ * The feature mask required to restore FPU state:
+ * - All user states which are not eagerly switched in switch_to()/exec()
+ * - The suporvisor states
  */
-static inline u64 xfeatures_mask_uabi(void)
-{
-	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
-}
-
-/*
- * The xfeatures which are restored by the kernel when returning to user
- * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
- * kernel does not manage all XCR0 enabled features via xsave/xrstor as
- * some of them have to be switched eagerly on context switch and exec().
- */
-static inline u64 xfeatures_mask_restore_user(void)
-{
-	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
-}
-
-/*
- * Like xfeatures_mask_restore_user() but additionally restors the
- * supported supervisor states.
- */
-static inline u64 xfeatures_mask_fpstate(void)
-{
-	return xfeatures_mask_all & \
-		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
-}
-
-static inline u64 xfeatures_mask_independent(void)
-{
-	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
-
-	return XFEATURE_MASK_INDEPENDENT;
-}
+#define XFEATURE_MASK_FPSTATE	(XFEATURE_MASK_USER_RESTORE | \
+				 XFEATURE_MASK_SUPERVISOR_SUPPORTED)
=20
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
=20
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
=20
-void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *k=
buf);
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void =
__user *ubuf);
=20
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
=20
-enum xstate_copy_mode {
-	XSTATE_COPY_FP,
-	XSTATE_COPY_FX,
-	XSTATE_COPY_XSAVE,
-};
+int xfd_enable_feature(u64 xfd_err);
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#endif
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
=20
-struct membuf;
-void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-			     enum xstate_copy_mode mode);
+static __always_inline __pure bool fpu_state_size_dynamic(void)
+{
+	return static_branch_unlikely(&__fpu_state_size_dynamic);
+}
+#else
+static __always_inline __pure bool fpu_state_size_dynamic(void)
+{
+	return false;
+}
+#endif
=20
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8f48a7ec577..eb0d69bb2fc6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -691,11 +691,10 @@ struct kvm_vcpu_arch {
 	 *
 	 * Note that while the PKRU state lives inside the fpu registers,
 	 * it is switched out separately at VMENTER and VMEXIT time. The
-	 * "guest_fpu" state here contains the guest FPU context, with the
+	 * "guest_fpstate" state here contains the guest FPU context, with the
 	 * host PRKU bits.
 	 */
-	struct fpu *user_fpu;
-	struct fpu *guest_fpu;
+	struct fpu_guest guest_fpu;
=20
 	u64 xcr0;
 	u64 guest_supported_xcr0;
@@ -1685,8 +1684,6 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu=
, u8 vector);
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
=20
-void kvm_free_guest_fpu(struct kvm_vcpu *vcpu);
-
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned=
 long cr0);
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned=
 long cr4);
 int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index a7c413432b33..01e2650b9585 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -625,6 +625,8 @@
=20
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
=20
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 #define MSR_IA32_XSS			0x00000da0
=20
 #define MSR_IA32_APICBASE		0x0000001b
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a3f87f1015d3..6b52182e178a 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -92,7 +92,7 @@ static __always_inline unsigned long long __rdmsr(unsigned =
int msr)
=20
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
=20
 	return EAX_EDX_VAL(val, low, high);
@@ -102,7 +102,7 @@ static __always_inline void __wrmsr(unsigned int msr, u32=
 low, u32 high)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
=20
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index ccc539faa5bb..4cd49afa0ca4 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PKRU_H
 #define _ASM_X86_PKRU_H
=20
-#include <asm/fpu/xstate.h>
+#include <asm/cpufeature.h>
=20
 #define PKRU_AD_BIT 0x1
 #define PKRU_WD_BIT 0x2
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 9ad2acaaae9b..1bd3e8d05604 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -461,9 +461,6 @@ DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
=20
-extern unsigned int fpu_kernel_xstate_size;
-extern unsigned int fpu_user_xstate_size;
-
 struct perf_event;
=20
 struct thread_struct {
@@ -537,12 +534,12 @@ struct thread_struct {
 	 */
 };
=20
-/* Whitelist the FPU state from the task_struct for hardened usercopy. */
+extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long=
 *size);
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
-	*offset =3D offsetof(struct thread_struct, fpu.state);
-	*size =3D fpu_kernel_xstate_size;
+	fpu_thread_struct_whitelist(offset, size);
 }
=20
 static inline void
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d1910a848..feed36d44d04 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -40,6 +40,6 @@ void x86_report_nx(void);
 extern int reboot_force;
=20
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled);
+			  unsigned long arg2);
=20
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 72044026eb3c..8dd8e8ec9fa5 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -339,7 +339,7 @@ static inline void __loadsegment_fs(unsigned short value)
 		     "1:	movw %0, %%fs			\n"
 		     "2:					\n"
=20
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_fs)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_CLEAR_FS)
=20
 		     : : "rm" (value) : "memory");
 }
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fp=
u.h
index 879b77792f94..4645a6334063 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -22,8 +22,8 @@ DECLARE_EVENT_CLASS(x86_fpu,
 		__entry->fpu		=3D fpu;
 		__entry->load_fpu	=3D test_thread_flag(TIF_NEED_FPU_LOAD);
 		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-			__entry->xfeatures =3D fpu->state.xsave.header.xfeatures;
-			__entry->xcomp_bv  =3D fpu->state.xsave.header.xcomp_bv;
+			__entry->xfeatures =3D fpu->fpstate->regs.xsave.header.xfeatures;
+			__entry->xcomp_bv  =3D fpu->fpstate->regs.xsave.header.xcomp_bv;
 		}
 	),
 	TP_printk("x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx",
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/pr=
ctl.h
index 5a6aac9fa41f..754a07856817 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,10 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
=20
+#define ARCH_GET_XCOMP_SUPP	0x1021
+#define ARCH_GET_XCOMP_PERM	0x1022
+#define ARCH_REQ_XCOMP_PERM	0x1023
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ecfca3bbcd96..6c8a86b58020 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -22,7 +22,7 @@
 #include <asm/bugs.h>
 #include <asm/processor.h>
 #include <asm/processor-flags.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b3410f1ac217..486dc8c1d388 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -42,7 +42,7 @@
 #include <asm/setup.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/mtrr.h>
 #include <asm/hwcap2.h>
 #include <linux/numa.h>
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index defda61f372d..cb2fdd130aae 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,8 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{}
 };
=20
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 193204aee880..2af4b420172e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,13 +373,16 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
=20
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fi=
xup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
+void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 {
-	pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	if (wrmsr) {
+		pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at r=
IP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
+			 regs->ip, (void *)regs->ip);
+	} else {
+		pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	}
=20
 	show_stack_regs(regs);
=20
@@ -387,8 +390,6 @@ __visible bool ex_handler_rdmsr_fault(const struct except=
ion_table_entry *fixup,
=20
 	while (true)
 		cpu_relax();
-
-	return true;
 }
=20
 /* MSR access wrappers used for error injection */
@@ -420,32 +421,13 @@ static noinstr u64 mce_rdmsrl(u32 msr)
 	 */
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR_IN_MCE)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
=20
=20
 	return EAX_EDX_VAL(val, low, high);
 }
=20
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fi=
xup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
-{
-	pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rI=
P: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
-		  regs->ip, (void *)regs->ip);
-
-	show_stack_regs(regs);
-
-	panic("MCA architectural violation!\n");
-
-	while (true)
-		cpu_relax();
-
-	return true;
-}
-
 static noinstr void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
@@ -470,7 +452,7 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 	/* See comment in mce_rdmsrl() */
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR_IN_MCE)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
=20
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index 88dcc79cfb07..3463f8cedb32 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -61,7 +61,7 @@ static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
-static inline bool intel_filter_mce(struct mce *m) { return false; };
+static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
=20
 void mce_timer_kick(unsigned long interval);
@@ -183,17 +183,7 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 #else
-static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
=20
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fi=
xup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fi=
xup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/sev=
erity.c
index 17e631443116..f60bbaff9f65 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -265,25 +265,25 @@ static bool is_copy_from_user(struct pt_regs *regs)
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
-	enum handler_type t;
-
 	if ((m->cs & 3) =3D=3D 3)
 		return IN_USER;
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
=20
-	t =3D ex_get_fault_handler_type(m->ip);
-	if (t =3D=3D EX_HANDLER_FAULT) {
-		m->kflags |=3D MCE_IN_KERNEL_RECOV;
-		return IN_KERNEL_RECOV;
-	}
-	if (t =3D=3D EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
-		m->kflags |=3D MCE_IN_KERNEL_RECOV;
+	switch (ex_get_fixup_type(m->ip)) {
+	case EX_TYPE_UACCESS:
+	case EX_TYPE_COPY:
+		if (!regs || !is_copy_from_user(regs))
+			return IN_KERNEL;
 		m->kflags |=3D MCE_IN_KERNEL_COPYIN;
+		fallthrough;
+	case EX_TYPE_FAULT_MCE_SAFE:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
+		m->kflags |=3D MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	default:
+		return IN_KERNEL;
 	}
-
-	return IN_KERNEL;
 }
=20
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index 2954fab15e51..794e70151203 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -2,7 +2,7 @@
 /*
  * x86 FPU bug checks:
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
=20
 /*
  * Boot time CPU/FPU FDIV bug detection code:
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
new file mode 100644
index 000000000000..958accf2ccf0
--- /dev/null
+++ b/arch/x86/kernel/fpu/context.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_CONTEXT_H
+#define __X86_KERNEL_FPU_CONTEXT_H
+
+#include <asm/fpu/xstate.h>
+#include <asm/trace/fpu.h>
+
+/* Functions related to FPU context tracking */
+
+/*
+ * The in-register FPU state for an FPU context on a CPU is assumed to be
+ * valid if the fpu->last_cpu matches the CPU, and the fpu_fpregs_owner_ctx
+ * matches the FPU.
+ *
+ * If the FPU register state is valid, the kernel can skip restoring the
+ * FPU state from memory.
+ *
+ * Any code that clobbers the FPU registers or updates the in-memory
+ * FPU state for a task MUST let the rest of the kernel know that the
+ * FPU registers are no longer valid for this task.
+ *
+ * Either one of these invalidation functions is enough. Invalidate
+ * a resource you control: CPU if using the CPU for something else
+ * (with preemption disabled), FPU for the current task, or a task that
+ * is prevented from running by the current task.
+ */
+static inline void __cpu_invalidate_fpregs_state(void)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
+}
+
+static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
+{
+	fpu->last_cpu =3D -1;
+}
+
+static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
+{
+	return fpu =3D=3D this_cpu_read(fpu_fpregs_owner_ctx) && cpu =3D=3D fpu->la=
st_cpu;
+}
+
+static inline void fpregs_deactivate(struct fpu *fpu)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
+	trace_x86_fpu_regs_deactivated(fpu);
+}
+
+static inline void fpregs_activate(struct fpu *fpu)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, fpu);
+	trace_x86_fpu_regs_activated(fpu);
+}
+
+/* Internal helper for switch_fpu_return() and signal frame setup */
+static inline void fpregs_restore_userregs(void)
+{
+	struct fpu *fpu =3D &current->thread.fpu;
+	int cpu =3D smp_processor_id();
+
+	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
+		return;
+
+	if (!fpregs_state_valid(fpu, cpu)) {
+		/*
+		 * This restores _all_ xstate which has not been
+		 * established yet.
+		 *
+		 * If PKRU is enabled, then the PKRU value is already
+		 * correct because it was either set in switch_to() or in
+		 * flush_thread(). So it is excluded because it might be
+		 * not up to date in current->thread.fpu.xsave state.
+		 *
+		 * XFD state is handled in restore_fpregs_from_fpstate().
+		 */
+		restore_fpregs_from_fpstate(fpu->fpstate, XFEATURE_MASK_FPSTATE);
+
+		fpregs_activate(fpu);
+		fpu->last_cpu =3D cpu;
+	}
+	clear_thread_flag(TIF_NEED_FPU_LOAD);
+}
+
+#endif
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7ada7bd03a32..8ea306b1bf8e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -6,8 +6,9 @@
  *  General FPU state handling cleanups
  *	Gareth Hughes <gareth@valinux.com>, May 2000
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
+#include <asm/fpu/sched.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/types.h>
 #include <asm/traps.h>
@@ -15,15 +16,30 @@
=20
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
+#include <linux/vmalloc.h>
+
+#include "context.h"
+#include "internal.h"
+#include "legacy.h"
+#include "xstate.h"
=20
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
=20
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+DEFINE_PER_CPU(u64, xfd_state);
+#endif
+
+/* The FPU state configuration data for kernel and user space */
+struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
+struct fpu_state_config fpu_user_cfg __ro_after_init;
+
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
-union fpregs_state init_fpstate __ro_after_init;
+struct fpstate init_fpstate __ro_after_init;
=20
 /*
  * Track whether the kernel is using the FPU state
@@ -83,7 +99,7 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
=20
 /*
- * Save the FPU register state in fpu->state. The register state is
+ * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
  *
  * Must be called with fpregs_lock() held.
@@ -99,19 +115,19 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		os_xsave(&fpu->state.xsave);
+		os_xsave(fpu->fpstate);
=20
 		/*
 		 * AVX512 state is tracked here because its use is
 		 * known to slow the max clock speed of the core.
 		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		if (fpu->fpstate->regs.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp =3D jiffies;
 		return;
 	}
=20
 	if (likely(use_fxsr())) {
-		fxsave(&fpu->state.fxsave);
+		fxsave(&fpu->fpstate->regs.fxsave);
 		return;
 	}
=20
@@ -119,12 +135,11 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to reload them from the memory state.
 	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=3Dm" (fpu->state.fsave));
-	frstor(&fpu->state.fsave);
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=3Dm" (fpu->fpstate->regs.fsave)=
);
+	frstor(&fpu->fpstate->regs.fsave);
 }
-EXPORT_SYMBOL(save_fpregs_to_fpstate);
=20
-void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 {
 	/*
 	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
@@ -141,15 +156,181 @@ void __restore_fpregs_from_fpstate(union fpregs_state =
*fpstate, u64 mask)
 	}
=20
 	if (use_xsave()) {
-		os_xrstor(&fpstate->xsave, mask);
+		/*
+		 * Dynamically enabled features are enabled in XCR0, but
+		 * usage requires also that the corresponding bits in XFD
+		 * are cleared.  If the bits are set then using a related
+		 * instruction will raise #NM. This allows to do the
+		 * allocation of the larger FPU buffer lazy from #NM or if
+		 * the task has no permission to kill it which would happen
+		 * via #UD if the feature is disabled in XCR0.
+		 *
+		 * XFD state is following the same life time rules as
+		 * XSTATE and to restore state correctly XFD has to be
+		 * updated before XRSTORS otherwise the component would
+		 * stay in or go into init state even if the bits are set
+		 * in fpstate::regs::xsave::xfeatures.
+		 */
+		xfd_update_state(fpstate);
+
+		/*
+		 * Restoring state always needs to modify all features
+		 * which are in @mask even if the current task cannot use
+		 * extended features.
+		 *
+		 * So fpstate->xfeatures cannot be used here, because then
+		 * a feature for which the task has no permission but was
+		 * used by the previous task would not go into init state.
+		 */
+		mask =3D fpu_kernel_cfg.max_features & mask;
+
+		os_xrstor(fpstate, mask);
 	} else {
 		if (use_fxsr())
-			fxrstor(&fpstate->fxsave);
+			fxrstor(&fpstate->regs.fxsave);
 		else
-			frstor(&fpstate->fsave);
+			frstor(&fpstate->regs.fsave);
 	}
 }
-EXPORT_SYMBOL_GPL(__restore_fpregs_from_fpstate);
+
+void fpu_reset_from_exception_fixup(void)
+{
+	restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_FPSTATE);
+}
+
+#if IS_ENABLED(CONFIG_KVM)
+static void __fpstate_reset(struct fpstate *fpstate);
+
+bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
+{
+	struct fpstate *fpstate;
+	unsigned int size;
+
+	size =3D fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), =
64);
+	fpstate =3D vzalloc(size);
+	if (!fpstate)
+		return false;
+
+	__fpstate_reset(fpstate);
+	fpstate_init_user(fpstate);
+	fpstate->is_valloc	=3D true;
+	fpstate->is_guest	=3D true;
+
+	gfpu->fpstate =3D fpstate;
+	return true;
+}
+EXPORT_SYMBOL_GPL(fpu_alloc_guest_fpstate);
+
+void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
+{
+	struct fpstate *fps =3D gfpu->fpstate;
+
+	if (!fps)
+		return;
+
+	if (WARN_ON_ONCE(!fps->is_valloc || !fps->is_guest || fps->in_use))
+		return;
+
+	gfpu->fpstate =3D NULL;
+	vfree(fps);
+}
+EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
+
+int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
+{
+	struct fpstate *guest_fps =3D guest_fpu->fpstate;
+	struct fpu *fpu =3D &current->thread.fpu;
+	struct fpstate *cur_fps =3D fpu->fpstate;
+
+	fpregs_lock();
+	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
+		save_fpregs_to_fpstate(fpu);
+
+	/* Swap fpstate */
+	if (enter_guest) {
+		fpu->__task_fpstate =3D cur_fps;
+		fpu->fpstate =3D guest_fps;
+		guest_fps->in_use =3D true;
+	} else {
+		guest_fps->in_use =3D false;
+		fpu->fpstate =3D fpu->__task_fpstate;
+		fpu->__task_fpstate =3D NULL;
+	}
+
+	cur_fps =3D fpu->fpstate;
+
+	if (!cur_fps->is_confidential) {
+		/* Includes XFD update */
+		restore_fpregs_from_fpstate(cur_fps, XFEATURE_MASK_FPSTATE);
+	} else {
+		/*
+		 * XSTATE is restored by firmware from encrypted
+		 * memory. Make sure XFD state is correct while
+		 * running with guest fpstate
+		 */
+		xfd_update_state(cur_fps);
+	}
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpstate);
+
+void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
+				    unsigned int size, u32 pkru)
+{
+	struct fpstate *kstate =3D gfpu->fpstate;
+	union fpregs_state *ustate =3D buf;
+	struct membuf mb =3D { .p =3D buf, .left =3D size };
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
+		__copy_xstate_to_uabi_buf(mb, kstate, pkru, XSTATE_COPY_XSAVE);
+	} else {
+		memcpy(&ustate->fxsave, &kstate->regs.fxsave,
+		       sizeof(ustate->fxsave));
+		/* Make it restorable on a XSAVE enabled host */
+		ustate->xsave.header.xfeatures =3D XFEATURE_MASK_FPSSE;
+	}
+}
+EXPORT_SYMBOL_GPL(fpu_copy_guest_fpstate_to_uabi);
+
+int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
+				   u64 xcr0, u32 *vpkru)
+{
+	struct fpstate *kstate =3D gfpu->fpstate;
+	const union fpregs_state *ustate =3D buf;
+	struct pkru_state *xpkru;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE)) {
+		if (ustate->xsave.header.xfeatures & ~XFEATURE_MASK_FPSSE)
+			return -EINVAL;
+		if (ustate->fxsave.mxcsr & ~mxcsr_feature_mask)
+			return -EINVAL;
+		memcpy(&kstate->regs.fxsave, &ustate->fxsave, sizeof(ustate->fxsave));
+		return 0;
+	}
+
+	if (ustate->xsave.header.xfeatures & ~xcr0)
+		return -EINVAL;
+
+	ret =3D copy_uabi_from_kernel_to_xstate(kstate, ustate);
+	if (ret)
+		return ret;
+
+	/* Retrieve PKRU if not in init state */
+	if (kstate->regs.xsave.header.xfeatures & XFEATURE_MASK_PKRU) {
+		xpkru =3D get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
+		*vpkru =3D xpkru->pkru;
+	}
+
+	/* Ensure that XCOMP_BV is set up for XSAVES */
+	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
+#endif /* CONFIG_KVM */
=20
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -203,52 +384,88 @@ void fpu_sync_fpstate(struct fpu *fpu)
 	fpregs_unlock();
 }
=20
-static inline void fpstate_init_xstate(struct xregs_state *xsave)
+static inline unsigned int init_fpstate_copy_size(void)
 {
-	/*
-	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
-	 */
-	xsave->header.xcomp_bv =3D XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
+	if (!use_xsave())
+		return fpu_kernel_cfg.default_size;
+
+	/* XSAVE(S) just needs the legacy and the xstate header part */
+	return sizeof(init_fpstate.regs.xsave);
 }
=20
-static inline void fpstate_init_fxstate(struct fxregs_state *fx)
+static inline void fpstate_init_fxstate(struct fpstate *fpstate)
 {
-	fx->cwd =3D 0x37f;
-	fx->mxcsr =3D MXCSR_DEFAULT;
+	fpstate->regs.fxsave.cwd =3D 0x37f;
+	fpstate->regs.fxsave.mxcsr =3D MXCSR_DEFAULT;
 }
=20
 /*
  * Legacy x87 fpstate state init:
  */
-static inline void fpstate_init_fstate(struct fregs_state *fp)
+static inline void fpstate_init_fstate(struct fpstate *fpstate)
 {
-	fp->cwd =3D 0xffff037fu;
-	fp->swd =3D 0xffff0000u;
-	fp->twd =3D 0xffffffffu;
-	fp->fos =3D 0xffff0000u;
+	fpstate->regs.fsave.cwd =3D 0xffff037fu;
+	fpstate->regs.fsave.swd =3D 0xffff0000u;
+	fpstate->regs.fsave.twd =3D 0xffffffffu;
+	fpstate->regs.fsave.fos =3D 0xffff0000u;
 }
=20
-void fpstate_init(union fpregs_state *state)
+/*
+ * Used in two places:
+ * 1) Early boot to setup init_fpstate for non XSAVE systems
+ * 2) fpu_init_fpstate_user() which is invoked from KVM
+ */
+void fpstate_init_user(struct fpstate *fpstate)
 {
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpstate_init_soft(&state->soft);
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+		fpstate_init_soft(&fpstate->regs.soft);
 		return;
 	}
=20
-	memset(state, 0, fpu_kernel_xstate_size);
+	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
=20
-	if (static_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&state->xsave);
-	if (static_cpu_has(X86_FEATURE_FXSR))
-		fpstate_init_fxstate(&state->fxsave);
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
+		fpstate_init_fxstate(fpstate);
 	else
-		fpstate_init_fstate(&state->fsave);
+		fpstate_init_fstate(fpstate);
+}
+
+static void __fpstate_reset(struct fpstate *fpstate)
+{
+	/* Initialize sizes and feature masks */
+	fpstate->size		=3D fpu_kernel_cfg.default_size;
+	fpstate->user_size	=3D fpu_user_cfg.default_size;
+	fpstate->xfeatures	=3D fpu_kernel_cfg.default_features;
+	fpstate->user_xfeatures	=3D fpu_user_cfg.default_features;
+	fpstate->xfd		=3D init_fpstate.xfd;
+}
+
+void fpstate_reset(struct fpu *fpu)
+{
+	/* Set the fpstate pointer to the default fpstate */
+	fpu->fpstate =3D &fpu->__fpstate;
+	__fpstate_reset(fpu->fpstate);
+
+	/* Initialize the permission related info in fpu */
+	fpu->perm.__state_perm		=3D fpu_kernel_cfg.default_features;
+	fpu->perm.__state_size		=3D fpu_kernel_cfg.default_size;
+	fpu->perm.__user_state_size	=3D fpu_user_cfg.default_size;
+}
+
+static inline void fpu_inherit_perms(struct fpu *dst_fpu)
+{
+	if (fpu_state_size_dynamic()) {
+		struct fpu *src_fpu =3D &current->group_leader->thread.fpu;
+
+		spin_lock_irq(&current->sighand->siglock);
+		/* Fork also inherits the permissions of the parent */
+		dst_fpu->perm =3D src_fpu->perm;
+		spin_unlock_irq(&current->sighand->siglock);
+	}
 }
-EXPORT_SYMBOL_GPL(fpstate_init);
=20
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 {
 	struct fpu *src_fpu =3D &current->thread.fpu;
 	struct fpu *dst_fpu =3D &dst->thread.fpu;
@@ -256,36 +473,67 @@ int fpu_clone(struct task_struct *dst)
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu =3D -1;
=20
+	fpstate_reset(dst_fpu);
+
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
=20
 	/*
-	 * Don't let 'init optimized' areas of the XSAVE area
-	 * leak into the child task:
+	 * Enforce reload for user space tasks and prevent kernel threads
+	 * from trying to save the FPU registers on context switch.
+	 */
+	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
+
+	/*
+	 * No FPU state inheritance for kernel threads and IO
+	 * worker threads.
+	 */
+	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+		/* Clear out the minimal state */
+		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
+		       init_fpstate_copy_size());
+		return 0;
+	}
+
+	/*
+	 * If a new feature is added, ensure all dynamic features are
+	 * caller-saved from here!
 	 */
-	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
+	BUILD_BUG_ON(XFEATURE_MASK_USER_DYNAMIC !=3D XFEATURE_MASK_XTILE_DATA);
=20
 	/*
-	 * If the FPU registers are not owned by current just memcpy() the
-	 * state.  Otherwise save the FPU registers directly into the
-	 * child's FPU context, without any memory-to-memory copying.
+	 * Save the default portion of the current FPU state into the
+	 * clone. Assume all dynamic features to be defined as caller-
+	 * saved, which enables skipping both the expansion of fpstate
+	 * and the copying of any dynamic state.
+	 *
+	 * Do not use memcpy() when TIF_NEED_FPU_LOAD is set because
+	 * copying is not valid when current uses non-default states.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
-
-	else
-		save_fpregs_to_fpstate(dst_fpu);
+		fpregs_restore_userregs();
+	save_fpregs_to_fpstate(dst_fpu);
+	if (!(clone_flags & CLONE_THREAD))
+		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
=20
-	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
-
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
=20
 	return 0;
 }
=20
+/*
+ * Whitelist the FPU register state embedded into task_struct for hardened
+ * usercopy.
+ */
+void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
+{
+	*offset =3D offsetof(struct thread_struct, fpu.__fpstate.regs);
+	*size =3D fpu_kernel_cfg.default_size;
+}
+
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
@@ -319,28 +567,19 @@ void fpu__drop(struct fpu *fpu)
 static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
-		os_xrstor(&init_fpstate.xsave, features_mask);
+		os_xrstor(&init_fpstate, features_mask);
 	else if (use_fxsr())
-		fxrstor(&init_fpstate.fxsave);
+		fxrstor(&init_fpstate.regs.fxsave);
 	else
-		frstor(&init_fpstate.fsave);
+		frstor(&init_fpstate.regs.fsave);
=20
 	pkru_write_default();
 }
=20
-static inline unsigned int init_fpstate_copy_size(void)
-{
-	if (!use_xsave())
-		return fpu_kernel_xstate_size;
-
-	/* XSAVE(S) just needs the legacy and the xstate header part */
-	return sizeof(init_fpstate.xsave);
-}
-
 /*
  * Reset current->fpu memory state to the init values.
  */
-static void fpu_reset_fpstate(void)
+static void fpu_reset_fpregs(void)
 {
 	struct fpu *fpu =3D &current->thread.fpu;
=20
@@ -359,7 +598,7 @@ static void fpu_reset_fpstate(void)
 	 * user space as PKRU is eagerly written in switch_to() and
 	 * flush_thread().
 	 */
-	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	memcpy(&fpu->fpstate->regs, &init_fpstate.regs, init_fpstate_copy_size());
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
@@ -375,7 +614,7 @@ void fpu__clear_user_states(struct fpu *fpu)
=20
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpu_reset_fpstate();
+		fpu_reset_fpregs();
 		fpregs_unlock();
 		return;
 	}
@@ -385,12 +624,11 @@ void fpu__clear_user_states(struct fpu *fpu)
 	 * corresponding registers.
 	 */
 	if (xfeatures_mask_supervisor() &&
-	    !fpregs_state_valid(fpu, smp_processor_id())) {
-		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
-	}
+	    !fpregs_state_valid(fpu, smp_processor_id()))
+		os_xrstor_supervisor(fpu->fpstate);
=20
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
+	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
=20
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
@@ -405,7 +643,8 @@ void fpu__clear_user_states(struct fpu *fpu)
=20
 void fpu_flush_thread(void)
 {
-	fpu_reset_fpstate();
+	fpstate_reset(&current->thread.fpu);
+	fpu_reset_fpregs();
 }
 /*
  * Load FPU context before returning to userspace.
@@ -445,7 +684,6 @@ void fpregs_mark_activate(void)
 	fpu->last_cpu =3D smp_processor_id();
 	clear_thread_flag(TIF_NEED_FPU_LOAD);
 }
-EXPORT_SYMBOL_GPL(fpregs_mark_activate);
=20
 /*
  * x87 math exception handling:
@@ -468,11 +706,11 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		 * fully reproduce the context of the exception.
 		 */
 		if (boot_cpu_has(X86_FEATURE_FXSR)) {
-			cwd =3D fpu->state.fxsave.cwd;
-			swd =3D fpu->state.fxsave.swd;
+			cwd =3D fpu->fpstate->regs.fxsave.cwd;
+			swd =3D fpu->fpstate->regs.fxsave.swd;
 		} else {
-			cwd =3D (unsigned short)fpu->state.fsave.cwd;
-			swd =3D (unsigned short)fpu->state.fsave.swd;
+			cwd =3D (unsigned short)fpu->fpstate->regs.fsave.cwd;
+			swd =3D (unsigned short)fpu->fpstate->regs.fsave.swd;
 		}
=20
 		err =3D swd & ~cwd;
@@ -486,7 +724,7 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		unsigned short mxcsr =3D MXCSR_DEFAULT;
=20
 		if (boot_cpu_has(X86_FEATURE_XMM))
-			mxcsr =3D fpu->state.fxsave.mxcsr;
+			mxcsr =3D fpu->fpstate->regs.fxsave.mxcsr;
=20
 		err =3D ~(mxcsr >> 7) & mxcsr;
 	}
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 64e29927cc32..621f4b6cac4a 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -2,7 +2,7 @@
 /*
  * x86 FPU boot time init code:
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
=20
@@ -10,6 +10,10 @@
 #include <linux/sched/task.h>
 #include <linux/init.h>
=20
+#include "internal.h"
+#include "legacy.h"
+#include "xstate.h"
+
 /*
  * Initialize the registers found in all CPUs, CR0 and CR4:
  */
@@ -34,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&current->thread.fpu.state.soft);
+		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
@@ -121,23 +125,14 @@ static void __init fpu__init_system_mxcsr(void)
 static void __init fpu__init_system_generic(void)
 {
 	/*
-	 * Set up the legacy init FPU context. (xstate init might overwrite this
-	 * with a more modern format, if the CPU supports it.)
+	 * Set up the legacy init FPU context. Will be updated when the
+	 * CPU supports XSAVE[S].
 	 */
-	fpstate_init(&init_fpstate);
+	fpstate_init_user(&init_fpstate);
=20
 	fpu__init_system_mxcsr();
 }
=20
-/*
- * Size of the FPU context state. All tasks in the system use the
- * same context size, regardless of what portion they use.
- * This is inherent to the XSAVE architecture which puts all state
- * components into a single, continuous memory block:
- */
-unsigned int fpu_kernel_xstate_size __ro_after_init;
-EXPORT_SYMBOL_GPL(fpu_kernel_xstate_size);
-
 /* Get alignment of the TYPE. */
 #define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
=20
@@ -162,13 +157,13 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -=3D sizeof(((struct task_struct *)0)->thread.fpu.state);
+	task_size -=3D sizeof(current->thread.fpu.__fpstate.regs);
=20
 	/*
 	 * Add back the dynamically-calculated register state
 	 * size.
 	 */
-	task_size +=3D fpu_kernel_xstate_size;
+	task_size +=3D fpu_kernel_cfg.default_size;
=20
 	/*
 	 * We dynamically size 'struct fpu', so we require that
@@ -177,7 +172,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * you hit a compile error here, check the structure to
 	 * see if something got added to the end.
 	 */
-	CHECK_MEMBER_AT_END_OF(struct fpu, state);
+	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
 	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
 	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
=20
@@ -192,37 +187,34 @@ static void __init fpu__init_task_struct_size(void)
  */
 static void __init fpu__init_system_xstate_size_legacy(void)
 {
-	static int on_boot_cpu __initdata =3D 1;
-
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu =3D 0;
+	unsigned int size;
=20
 	/*
-	 * Note that xstate sizes might be overwritten later during
-	 * fpu__init_system_xstate().
+	 * Note that the size configuration might be overwritten later
+	 * during fpu__init_system_xstate().
 	 */
-
-	if (!boot_cpu_has(X86_FEATURE_FPU)) {
-		fpu_kernel_xstate_size =3D sizeof(struct swregs_state);
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+		size =3D sizeof(struct swregs_state);
+	} else if (cpu_feature_enabled(X86_FEATURE_FXSR)) {
+		size =3D sizeof(struct fxregs_state);
+		fpu_user_cfg.legacy_features =3D XFEATURE_MASK_FPSSE;
 	} else {
-		if (boot_cpu_has(X86_FEATURE_FXSR))
-			fpu_kernel_xstate_size =3D
-				sizeof(struct fxregs_state);
-		else
-			fpu_kernel_xstate_size =3D
-				sizeof(struct fregs_state);
+		size =3D sizeof(struct fregs_state);
+		fpu_user_cfg.legacy_features =3D XFEATURE_MASK_FP;
 	}
=20
-	fpu_user_xstate_size =3D fpu_kernel_xstate_size;
+	fpu_kernel_cfg.max_size =3D size;
+	fpu_kernel_cfg.default_size =3D size;
+	fpu_user_cfg.max_size =3D size;
+	fpu_user_cfg.default_size =3D size;
+	fpstate_reset(&current->thread.fpu);
 }
=20
-/* Legacy code to initialize eager fpu mode. */
-static void __init fpu__init_system_ctx_switch(void)
+static void __init fpu__init_init_fpstate(void)
 {
-	static bool on_boot_cpu __initdata =3D 1;
-
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu =3D 0;
+	/* Bring init_fpstate size and features up to date */
+	init_fpstate.size		=3D fpu_kernel_cfg.max_size;
+	init_fpstate.xfeatures		=3D fpu_kernel_cfg.max_features;
 }
=20
 /*
@@ -231,6 +223,7 @@ static void __init fpu__init_system_ctx_switch(void)
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
+	fpstate_reset(&current->thread.fpu);
 	fpu__init_system_early_generic(c);
=20
 	/*
@@ -241,8 +234,7 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
=20
 	fpu__init_system_generic();
 	fpu__init_system_xstate_size_legacy();
-	fpu__init_system_xstate();
+	fpu__init_system_xstate(fpu_kernel_cfg.max_size);
 	fpu__init_task_struct_size();
-
-	fpu__init_system_ctx_switch();
+	fpu__init_init_fpstate();
 }
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
new file mode 100644
index 000000000000..dbdb31f55fc7
--- /dev/null
+++ b/arch/x86/kernel/fpu/internal.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_INTERNAL_H
+#define __X86_KERNEL_FPU_INTERNAL_H
+
+extern struct fpstate init_fpstate;
+
+/* CPU feature check wrappers */
+static __always_inline __pure bool use_xsave(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_XSAVE);
+}
+
+static __always_inline __pure bool use_fxsr(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_FXSR);
+}
+
+#ifdef CONFIG_X86_DEBUG_FPU
+# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
+#else
+# define WARN_ON_FPU(x) ({ (void)(x); 0; })
+#endif
+
+/* Used in init.c */
+extern void fpstate_init_user(struct fpstate *fpstate);
+extern void fpstate_reset(struct fpu *fpu);
+
+#endif
diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
new file mode 100644
index 000000000000..17c26b164c63
--- /dev/null
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_LEGACY_H
+#define __X86_KERNEL_FPU_LEGACY_H
+
+#include <asm/fpu/types.h>
+
+extern unsigned int mxcsr_feature_mask;
+
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
+/*
+ * Returns 0 on success or the trap number when the operation raises an
+ * exception.
+ */
+#define user_insn(insn, output, input...)				\
+({									\
+	int err;							\
+									\
+	might_fault();							\
+									\
+	asm volatile(ASM_STAC "\n"					\
+		     "1: " #insn "\n"					\
+		     "2: " ASM_CLAC "\n"				\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     : [err] "=3Da" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
+#define kernel_insn_err(insn, output, input...)				\
+({									\
+	int err;							\
+	asm volatile("1:" #insn "\n\t"					\
+		     "2:\n"						\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:  movl $-1,%[err]\n"				\
+		     "    jmp  2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=3Dr" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
+#define kernel_insn(insn, output, input...)				\
+	asm volatile("1:" #insn "\n\t"					\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FPU_RESTORE)	\
+		     : output : input)
+
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
+{
+	return user_insn(fnsave %[fx]; fwait,  [fx] "=3Dm" (*fx), "m" (*fx));
+}
+
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxsave %[fx], [fx] "=3Dm" (*fx), "m" (*fx));
+	else
+		return user_insn(fxsaveq %[fx], [fx] "=3Dm" (*fx), "m" (*fx));
+
+}
+
+static inline void fxrstor(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		kernel_insn(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+	else
+		kernel_insn(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline int fxrstor_safe(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return kernel_insn_err(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+	else
+		return kernel_insn_err(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxrstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+	else
+		return user_insn(fxrstorq %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline void frstor(struct fregs_state *fx)
+{
+	kernel_insn(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline int frstor_safe(struct fregs_state *fx)
+{
+	return kernel_insn_err(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
+{
+	return user_insn(frstor %[fx], "=3Dm" (*fx), [fx] "m" (*fx));
+}
+
+static inline void fxsave(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		asm volatile( "fxsave %[fx]" : [fx] "=3Dm" (*fx));
+	else
+		asm volatile("fxsaveq %[fx]" : [fx] "=3Dm" (*fx));
+}
+
+#endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 66ed317ebc0d..437d7c930c0b 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -5,10 +5,14 @@
 #include <linux/sched/task_stack.h>
 #include <linux/vmalloc.h>
=20
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
-#include <asm/fpu/xstate.h>
+
+#include "context.h"
+#include "internal.h"
+#include "legacy.h"
+#include "xstate.h"
=20
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active()=
 routine,
@@ -74,8 +78,8 @@ int xfpregs_get(struct task_struct *target, const struct us=
er_regset *regset,
 	sync_fpstate(fpu);
=20
 	if (!use_xsave()) {
-		return membuf_write(&to, &fpu->state.fxsave,
-				    sizeof(fpu->state.fxsave));
+		return membuf_write(&to, &fpu->fpstate->regs.fxsave,
+				    sizeof(fpu->fpstate->regs.fxsave));
 	}
=20
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
@@ -110,15 +114,15 @@ int xfpregs_set(struct task_struct *target, const struc=
t user_regset *regset,
 	fpu_force_restore(fpu);
=20
 	/* Copy the state  */
-	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
+	memcpy(&fpu->fpstate->regs.fxsave, &newstate, sizeof(newstate));
=20
 	/* Clear xmm8..15 */
-	BUILD_BUG_ON(sizeof(fpu->state.fxsave.xmm_space) !=3D 16 * 16);
-	memset(&fpu->state.fxsave.xmm_space[8], 0, 8 * 16);
+	BUILD_BUG_ON(sizeof(fpu->__fpstate.regs.fxsave.xmm_space) !=3D 16 * 16);
+	memset(&fpu->fpstate->regs.fxsave.xmm_space[8], 0, 8 * 16);
=20
 	/* Mark FP and SSE as in use when XSAVE is enabled */
 	if (use_xsave())
-		fpu->state.xsave.header.xfeatures |=3D XFEATURE_MASK_FPSSE;
+		fpu->fpstate->regs.xsave.header.xfeatures |=3D XFEATURE_MASK_FPSSE;
=20
 	return 0;
 }
@@ -149,7 +153,7 @@ int xstateregs_set(struct task_struct *target, const stru=
ct user_regset *regset,
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if (pos !=3D 0 || count !=3D fpu_user_xstate_size)
+	if (pos !=3D 0 || count !=3D fpu_user_cfg.max_size)
 		return -EFAULT;
=20
 	if (!kbuf) {
@@ -164,7 +168,7 @@ int xstateregs_set(struct task_struct *target, const stru=
ct user_regset *regset,
 	}
=20
 	fpu_force_restore(fpu);
-	ret =3D copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret =3D copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf);
=20
 out:
 	vfree(tmpbuf);
@@ -283,7 +287,7 @@ static void __convert_from_fxsr(struct user_i387_ia32_str=
uct *env,
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.fpstate->regs.fxsave);
 }
=20
 void convert_to_fxsr(struct fxregs_state *fxsave,
@@ -326,7 +330,7 @@ int fpregs_get(struct task_struct *target, const struct u=
ser_regset *regset,
 		return fpregs_soft_get(target, regset, to);
=20
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
-		return membuf_write(&to, &fpu->state.fsave,
+		return membuf_write(&to, &fpu->fpstate->regs.fsave,
 				    sizeof(struct fregs_state));
 	}
=20
@@ -337,7 +341,7 @@ int fpregs_get(struct task_struct *target, const struct u=
ser_regset *regset,
 		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
 		fx =3D &fxsave;
 	} else {
-		fx =3D &fpu->state.fxsave;
+		fx =3D &fpu->fpstate->regs.fxsave;
 	}
=20
 	__convert_from_fxsr(&env, target, fx);
@@ -366,16 +370,16 @@ int fpregs_set(struct task_struct *target, const struct=
 user_regset *regset,
 	fpu_force_restore(fpu);
=20
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
-		convert_to_fxsr(&fpu->state.fxsave, &env);
+		convert_to_fxsr(&fpu->fpstate->regs.fxsave, &env);
 	else
-		memcpy(&fpu->state.fsave, &env, sizeof(env));
+		memcpy(&fpu->fpstate->regs.fsave, &env, sizeof(env));
=20
 	/*
 	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
-		fpu->state.xsave.header.xfeatures |=3D XFEATURE_MASK_FP;
+		fpu->fpstate->regs.xsave.header.xfeatures |=3D XFEATURE_MASK_FP;
=20
 	return 0;
 }
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 831b25c5e705..cc977da6e128 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -7,23 +7,25 @@
 #include <linux/cpu.h>
 #include <linux/pagemap.h>
=20
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
=20
 #include <asm/sigframe.h>
+#include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
=20
-static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
-static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
+#include "context.h"
+#include "internal.h"
+#include "legacy.h"
+#include "xstate.h"
=20
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
-					   struct _fpx_sw_bytes *fx_sw)
+static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbu=
f,
+					    struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size =3D sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
@@ -31,12 +33,12 @@ static inline int check_xstate_in_sigframe(struct fxregs_=
state __user *fxbuf,
 	unsigned int magic2;
=20
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
-		return -EFAULT;
+		return false;
=20
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 !=3D FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > fpu_user_xstate_size ||
+	    fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
=20
@@ -47,10 +49,10 @@ static inline int check_xstate_in_sigframe(struct fxregs_=
state __user *fxbuf,
 	 * in the memory layout.
 	 */
 	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
-		return -EFAULT;
+		return false;
=20
 	if (likely(magic2 =3D=3D FP_XSTATE_MAGIC2))
-		return 0;
+		return true;
 setfx:
 	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
=20
@@ -58,22 +60,22 @@ static inline int check_xstate_in_sigframe(struct fxregs_=
state __user *fxbuf,
 	fx_sw->magic1 =3D 0;
 	fx_sw->xstate_size =3D sizeof(struct fxregs_state);
 	fx_sw->xfeatures =3D XFEATURE_MASK_FPSSE;
-	return 0;
+	return true;
 }
=20
 /*
  * Signal frame handlers.
  */
-static inline int save_fsave_header(struct task_struct *tsk, void __user *bu=
f)
+static inline bool save_fsave_header(struct task_struct *tsk, void __user *b=
uf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave =3D &tsk->thread.fpu.state.xsave;
+		struct xregs_state *xsave =3D &tsk->thread.fpu.fpstate->regs.xsave;
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp =3D buf;
=20
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			fxsave(&tsk->thread.fpu.state.fxsave);
+			fxsave(&tsk->thread.fpu.fpstate->regs.fxsave);
 		fpregs_unlock();
=20
 		convert_from_fxsr(&env, tsk);
@@ -81,33 +83,54 @@ static inline int save_fsave_header(struct task_struct *t=
sk, void __user *buf)
 		if (__copy_to_user(buf, &env, sizeof(env)) ||
 		    __put_user(xsave->i387.swd, &fp->status) ||
 		    __put_user(X86_FXSR_MAGIC, &fp->magic))
-			return -1;
+			return false;
 	} else {
 		struct fregs_state __user *fp =3D buf;
 		u32 swd;
+
 		if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
-			return -1;
+			return false;
 	}
=20
-	return 0;
+	return true;
+}
+
+/*
+ * Prepare the SW reserved portion of the fxsave memory layout, indicating
+ * the presence of the extended state information in the memory layout
+ * pointed to by the fpstate pointer in the sigcontext.
+ * This is saved when ever the FP and extended state context is
+ * saved on the user stack during the signal handler delivery to the user.
+ */
+static inline void save_sw_bytes(struct _fpx_sw_bytes *sw_bytes, bool ia32_f=
rame,
+				 struct fpstate *fpstate)
+{
+	sw_bytes->magic1 =3D FP_XSTATE_MAGIC1;
+	sw_bytes->extended_size =3D fpstate->user_size + FP_XSTATE_MAGIC2_SIZE;
+	sw_bytes->xfeatures =3D fpstate->user_xfeatures;
+	sw_bytes->xstate_size =3D fpstate->user_size;
+
+	if (ia32_frame)
+		sw_bytes->extended_size +=3D sizeof(struct fregs_state);
 }
=20
-static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
+static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
+				      struct fpstate *fpstate)
 {
 	struct xregs_state __user *x =3D buf;
-	struct _fpx_sw_bytes *sw_bytes;
+	struct _fpx_sw_bytes sw_bytes;
 	u32 xfeatures;
 	int err;
=20
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
-	sw_bytes =3D ia32_frame ? &fx_sw_reserved_ia32 : &fx_sw_reserved;
-	err =3D __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
+	save_sw_bytes(&sw_bytes, ia32_frame, fpstate);
+	err =3D __copy_to_user(&x->i387.sw_reserved, &sw_bytes, sizeof(sw_bytes));
=20
 	if (!use_xsave())
-		return err;
+		return !err;
=20
 	err |=3D __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 __user *)(buf + fpu_user_xstate_size));
+			  (__u32 __user *)(buf + fpstate->user_size));
=20
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
@@ -130,23 +153,17 @@ static inline int save_xstate_epilog(void __user *buf, =
int ia32_frame)
=20
 	err |=3D __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
=20
-	return err;
+	return !err;
 }
=20
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 {
-	int err;
-
 	if (use_xsave())
-		err =3D xsave_to_user_sigframe(buf);
-	else if (use_fxsr())
-		err =3D fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
+		return xsave_to_user_sigframe(buf);
+	if (use_fxsr())
+		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err =3D fnsave_to_user_sigframe((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err =3D -EFAULT;
-	return err;
+		return fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 }
=20
 /*
@@ -159,10 +176,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_s=
tate __user *buf)
  *	buf =3D=3D buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf !=3D buf_fx for 32-bit frames with fxstate.
  *
- * Try to save it directly to the user frame with disabled page fault handle=
r.
- * If this fails then do the slow path where the FPU state is first saved to
- * task's fpu->state and then copy it to the user frame pointed to by the
- * aligned pointer 'buf_fx'.
+ * Save it directly to the user frame with disabled page fault handler. If
+ * that faults, try to clear the frame which handles the page fault.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -170,10 +185,11 @@ static inline int copy_fpregs_to_sigframe(struct xregs_=
state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int siz=
e)
 {
 	struct task_struct *tsk =3D current;
-	int ia32_fxstate =3D (buf !=3D buf_fx);
+	struct fpstate *fpstate =3D tsk->thread.fpu.fpstate;
+	bool ia32_fxstate =3D (buf !=3D buf_fx);
 	int ret;
=20
 	ia32_fxstate &=3D (IS_ENABLED(CONFIG_X86_32) ||
@@ -181,13 +197,25 @@ int copy_fpstate_to_sigframe(void __user *buf, void __u=
ser *buf_fx, int size)
=20
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
 		struct user_i387_ia32_struct fp;
+
 		fpregs_soft_get(current, NULL, (struct membuf){.p =3D &fp,
 						.left =3D sizeof(fp)});
-		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
+		return !copy_to_user(buf, &fp, sizeof(fp));
 	}
=20
 	if (!access_ok(buf, size))
-		return -EACCES;
+		return false;
+
+	if (use_xsave()) {
+		struct xregs_state __user *xbuf =3D buf_fx;
+
+		/*
+		 * Clear the xsave header first, so that reserved fields are
+		 * initialized to zero.
+		 */
+		if (__clear_user(&xbuf->header, sizeof(xbuf->header)))
+			return false;
+	}
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
@@ -205,26 +233,26 @@ int copy_fpstate_to_sigframe(void __user *buf, void __u=
ser *buf_fx, int size)
 	fpregs_unlock();
=20
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpstate->user_size))
 			goto retry;
-		return -EFAULT;
+		return false;
 	}
=20
 	/* Save the fsave header for the 32-bit frames. */
-	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-		return -1;
+	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
+		return false;
=20
-	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
-		return -1;
+	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate, fpstate))
+		return false;
=20
-	return 0;
+	return true;
 }
=20
-static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				      bool fx_only)
+static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
+				      u64 xrestore, bool fx_only)
 {
 	if (use_xsave()) {
-		u64 init_bv =3D xfeatures_mask_uabi() & ~xrestore;
+		u64 init_bv =3D ufeatures & ~xrestore;
 		int ret;
=20
 		if (likely(!fx_only))
@@ -233,7 +261,7 @@ static int __restore_fpregs_from_user(void __user *buf, u=
64 xrestore,
 			ret =3D fxrstor_from_user_sigframe(buf);
=20
 		if (!ret && unlikely(init_bv))
-			os_xrstor(&init_fpstate.xsave, init_bv);
+			os_xrstor(&init_fpstate, init_bv);
 		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
@@ -246,16 +274,19 @@ static int __restore_fpregs_from_user(void __user *buf,=
 u64 xrestore,
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				    bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				     bool fx_only, unsigned int size)
 {
 	struct fpu *fpu =3D &current->thread.fpu;
 	int ret;
=20
 retry:
 	fpregs_lock();
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpu->fpstate);
 	pagefault_disable();
-	ret =3D __restore_fpregs_from_user(buf, xrestore, fx_only);
+	ret =3D __restore_fpregs_from_user(buf, fpu->fpstate->user_xfeatures,
+					 xrestore, fx_only);
 	pagefault_enable();
=20
 	if (unlikely(ret)) {
@@ -275,13 +306,12 @@ static int restore_fpregs_from_user(void __user *buf, u=
64 xrestore,
 		fpregs_unlock();
=20
 		/* Try to handle #PF, but anything else is fatal. */
-		if (ret !=3D -EFAULT)
-			return -EINVAL;
+		if (ret !=3D X86_TRAP_PF)
+			return false;
=20
-		ret =3D fault_in_pages_readable(buf, size);
-		if (!ret)
+		if (!fault_in_pages_readable(buf, size))
 			goto retry;
-		return ret;
+		return false;
 	}
=20
 	/*
@@ -294,45 +324,40 @@ static int restore_fpregs_from_user(void __user *buf, u=
64 xrestore,
 	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
-		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+		os_xrstor_supervisor(fpu->fpstate);
=20
 	fpregs_mark_activate();
 	fpregs_unlock();
-	return 0;
+	return true;
 }
=20
-static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
-			     bool ia32_fxstate)
+static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			      bool ia32_fxstate)
 {
-	int state_size =3D fpu_kernel_xstate_size;
 	struct task_struct *tsk =3D current;
 	struct fpu *fpu =3D &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	bool success, fx_only =3D false;
+	union fpregs_state *fpregs;
+	unsigned int state_size;
 	u64 user_xfeatures =3D 0;
-	bool fx_only =3D false;
-	int ret;
=20
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
=20
-		ret =3D check_xstate_in_sigframe(buf_fx, &fx_sw_user);
-		if (unlikely(ret))
-			return ret;
+		if (!check_xstate_in_sigframe(buf_fx, &fx_sw_user))
+			return false;
=20
 		fx_only =3D !fx_sw_user.magic1;
 		state_size =3D fx_sw_user.xstate_size;
 		user_xfeatures =3D fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures =3D XFEATURE_MASK_FPSSE;
+		state_size =3D fpu->fpstate->user_size;
 	}
=20
 	if (likely(!ia32_fxstate)) {
-		/*
-		 * Attempt to restore the FPU registers directly from user
-		 * memory. For that to succeed, the user access cannot cause page
-		 * faults. If it does, fall back to the slow path below, going
-		 * through the kernel buffer with the enabled pagefault handler.
-		 */
+		/* Restore the FPU registers directly from user memory. */
 		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
 						state_size);
 	}
@@ -342,9 +367,8 @@ static int __fpu_restore_sig(void __user *buf, void __use=
r *buf_fx,
 	 * to be ignored for histerical raisins. The legacy state is folded
 	 * in once the larger state has been copied.
 	 */
-	ret =3D __copy_from_user(&env, buf, sizeof(env));
-	if (ret)
-		return ret;
+	if (__copy_from_user(&env, buf, sizeof(env)))
+		return false;
=20
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
@@ -363,38 +387,38 @@ static int __fpu_restore_sig(void __user *buf, void __u=
ser *buf_fx,
 		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			os_xsave(&fpu->state.xsave);
+			os_xsave(fpu->fpstate);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
 	__cpu_invalidate_fpregs_state();
 	fpregs_unlock();
=20
+	fpregs =3D &fpu->fpstate->regs;
 	if (use_xsave() && !fx_only) {
-		ret =3D copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
-		if (ret)
-			return ret;
+		if (copy_sigframe_from_user_to_xstate(fpu->fpstate, buf_fx))
+			return false;
 	} else {
-		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
-				     sizeof(fpu->state.fxsave)))
-			return -EFAULT;
+		if (__copy_from_user(&fpregs->fxsave, buf_fx,
+				     sizeof(fpregs->fxsave)))
+			return false;
=20
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			/* Reject invalid MXCSR values. */
-			if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
-				return -EINVAL;
+			if (fpregs->fxsave.mxcsr & ~mxcsr_feature_mask)
+				return false;
 		} else {
 			/* Mask invalid bits out for historical reasons (broken hardware). */
-			fpu->state.fxsave.mxcsr &=3D mxcsr_feature_mask;
+			fpregs->fxsave.mxcsr &=3D mxcsr_feature_mask;
 		}
=20
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())
-			fpu->state.xsave.header.xfeatures |=3D XFEATURE_MASK_FPSSE;
+			fpregs->xsave.header.xfeatures |=3D XFEATURE_MASK_FPSSE;
 	}
=20
 	/* Fold the legacy FP storage */
-	convert_to_fxsr(&fpu->state.fxsave, &env);
+	convert_to_fxsr(&fpregs->fxsave, &env);
=20
 	fpregs_lock();
 	if (use_xsave()) {
@@ -409,40 +433,45 @@ static int __fpu_restore_sig(void __user *buf, void __u=
ser *buf_fx,
 		 */
 		u64 mask =3D user_xfeatures | xfeatures_mask_supervisor();
=20
-		fpu->state.xsave.header.xfeatures &=3D mask;
-		ret =3D os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
+		fpregs->xsave.header.xfeatures &=3D mask;
+		success =3D !os_xrstor_safe(fpu->fpstate,
+					  fpu_kernel_cfg.max_features);
 	} else {
-		ret =3D fxrstor_safe(&fpu->state.fxsave);
+		success =3D !fxrstor_safe(&fpregs->fxsave);
 	}
=20
-	if (likely(!ret))
+	if (likely(success))
 		fpregs_mark_activate();
=20
 	fpregs_unlock();
-	return ret;
+	return success;
 }
-static inline int xstate_sigframe_size(void)
+
+static inline unsigned int xstate_sigframe_size(struct fpstate *fpstate)
 {
-	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
-			fpu_user_xstate_size;
+	unsigned int size =3D fpstate->user_size;
+
+	return use_xsave() ? size + FP_XSTATE_MAGIC2_SIZE : size;
 }
=20
 /*
  * Restore FPU state from a sigframe:
  */
-int fpu__restore_sig(void __user *buf, int ia32_frame)
+bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	unsigned int size =3D xstate_sigframe_size();
 	struct fpu *fpu =3D &current->thread.fpu;
 	void __user *buf_fx =3D buf;
 	bool ia32_fxstate =3D false;
-	int ret;
+	bool success =3D false;
+	unsigned int size;
=20
 	if (unlikely(!buf)) {
 		fpu__clear_user_states(fpu);
-		return 0;
+		return true;
 	}
=20
+	size =3D xstate_sigframe_size(fpu->fpstate);
+
 	ia32_frame &=3D (IS_ENABLED(CONFIG_X86_32) ||
 		       IS_ENABLED(CONFIG_IA32_EMULATION));
=20
@@ -456,30 +485,28 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
 		ia32_fxstate =3D true;
 	}
=20
-	if (!access_ok(buf, size)) {
-		ret =3D -EACCES;
+	if (!access_ok(buf, size))
 		goto out;
-	}
=20
 	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
-		ret =3D fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
+		success =3D !fpregs_soft_set(current, NULL, 0,
+					   sizeof(struct user_i387_ia32_struct),
+					   NULL, buf);
 	} else {
-		ret =3D __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+		success =3D __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
=20
 out:
-	if (unlikely(ret))
+	if (unlikely(!success))
 		fpu__clear_user_states(fpu);
-	return ret;
+	return success;
 }
=20
 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size =3D xstate_sigframe_size();
+	unsigned long frame_size =3D xstate_sigframe_size(current->thread.fpu.fpsta=
te);
=20
 	*buf_fx =3D sp =3D round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
@@ -492,9 +519,12 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 	return sp;
 }
=20
-unsigned long fpu__get_fpstate_size(void)
+unsigned long __init fpu__get_fpstate_size(void)
 {
-	unsigned long ret =3D xstate_sigframe_size();
+	unsigned long ret =3D fpu_user_cfg.max_size;
+
+	if (use_xsave())
+		ret +=3D FP_XSTATE_MAGIC2_SIZE;
=20
 	/*
 	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
@@ -510,28 +540,3 @@ unsigned long fpu__get_fpstate_size(void)
 	return ret;
 }
=20
-/*
- * Prepare the SW reserved portion of the fxsave memory layout, indicating
- * the presence of the extended state information in the memory layout
- * pointed by the fpstate pointer in the sigcontext.
- * This will be saved when ever the FP and extended state context is
- * saved on the user stack during the signal handler delivery to the user.
- */
-void fpu__init_prepare_fx_sw_frame(void)
-{
-	int size =3D fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
-
-	fx_sw_reserved.magic1 =3D FP_XSTATE_MAGIC1;
-	fx_sw_reserved.extended_size =3D size;
-	fx_sw_reserved.xfeatures =3D xfeatures_mask_uabi();
-	fx_sw_reserved.xstate_size =3D fpu_user_xstate_size;
-
-	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
-	    IS_ENABLED(CONFIG_X86_32)) {
-		int fsave_header_size =3D sizeof(struct fregs_state);
-
-		fx_sw_reserved_ia32 =3D fx_sw_reserved;
-		fx_sw_reserved_ia32.extended_size =3D size + fsave_header_size;
-	}
-}
-
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..d28829403ed0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -4,21 +4,33 @@
  *
  * Author: Suresh Siddha <suresh.b.siddha@intel.com>
  */
+#include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
 #include <linux/mman.h>
+#include <linux/nospec.h>
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/fpu/api.h>
-#include <asm/fpu/internal.h>
-#include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
-#include <asm/fpu/xstate.h>
+#include <asm/fpu/signal.h>
+#include <asm/fpu/xcr.h>
=20
 #include <asm/tlbflush.h>
-#include <asm/cpufeature.h>
+#include <asm/prctl.h>
+#include <asm/elf.h>
+
+#include "context.h"
+#include "internal.h"
+#include "legacy.h"
+#include "xstate.h"
+
+#define for_each_extended_xfeature(bit, mask)				\
+	(bit) =3D FIRST_EXTENDED_XFEATURE;				\
+	for_each_set_bit_from(bit, (unsigned long *)&(mask), 8 * sizeof(mask))
=20
 /*
  * Although we spell it out in here, the Processor Trace
@@ -39,29 +51,32 @@ static const char *xfeature_names[] =3D
 	"Protection Keys User registers",
 	"PASID state",
 	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"unknown xstate feature"	,
+	"AMX Tile config"		,
+	"AMX Tile data"			,
+	"unknown xstate feature"	,
 };
=20
-static short xsave_cpuid_features[] __initdata =3D {
-	X86_FEATURE_FPU,
-	X86_FEATURE_XMM,
-	X86_FEATURE_AVX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_INTEL_PT,
-	X86_FEATURE_PKU,
-	X86_FEATURE_ENQCMD,
+static unsigned short xsave_cpuid_features[] __initdata =3D {
+	[XFEATURE_FP]				=3D X86_FEATURE_FPU,
+	[XFEATURE_SSE]				=3D X86_FEATURE_XMM,
+	[XFEATURE_YMM]				=3D X86_FEATURE_AVX,
+	[XFEATURE_BNDREGS]			=3D X86_FEATURE_MPX,
+	[XFEATURE_BNDCSR]			=3D X86_FEATURE_MPX,
+	[XFEATURE_OPMASK]			=3D X86_FEATURE_AVX512F,
+	[XFEATURE_ZMM_Hi256]			=3D X86_FEATURE_AVX512F,
+	[XFEATURE_Hi16_ZMM]			=3D X86_FEATURE_AVX512F,
+	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	=3D X86_FEATURE_INTEL_PT,
+	[XFEATURE_PKRU]				=3D X86_FEATURE_PKU,
+	[XFEATURE_PASID]			=3D X86_FEATURE_ENQCMD,
+	[XFEATURE_XTILE_CFG]			=3D X86_FEATURE_AMX_TILE,
+	[XFEATURE_XTILE_DATA]			=3D X86_FEATURE_AMX_TILE,
 };
=20
-/*
- * This represents the full set of bits that should ever be set in a kernel
- * XSAVE buffer, both supervisor and user xstates.
- */
-u64 xfeatures_mask_all __ro_after_init;
-EXPORT_SYMBOL_GPL(xfeatures_mask_all);
-
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =3D
 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =3D
@@ -71,13 +86,6 @@ static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro=
_after_init =3D
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_=
init =3D
 	{ [ 0 ... XFEATURE_MAX - 1] =3D -1};
=20
-/*
- * The XSAVE area of kernel can be in standard or compacted format;
- * it is always in standard format for user mode. This is the user
- * mode standard format size used for signal and ptrace frames.
- */
-unsigned int fpu_user_xstate_size __ro_after_init;
-
 /*
  * Return whether the system supports a given xfeature.
  *
@@ -85,7 +93,7 @@ unsigned int fpu_user_xstate_size __ro_after_init;
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing =3D xfeatures_needed & ~xfeatures_mask_all;
+	u64 xfeatures_missing =3D xfeatures_needed & ~fpu_kernel_cfg.max_features;
=20
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -135,17 +143,26 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !fpu_kernel_cfg.max_features)
 		return;
=20
 	cr4_set_bits(X86_CR4_OSXSAVE);
=20
+	/*
+	 * Must happen after CR4 setup and before xsetbv() to allow KVM
+	 * lazy passthrough.  Write independent of the dynamic state static
+	 * key as that does not work on the boot CPU. This also ensures
+	 * that any stale state is wiped out from XFD.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XFD))
+		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, fpu_user_cfg.max_features);
=20
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
@@ -158,7 +175,7 @@ void fpu__init_cpu_xstate(void)
=20
 static bool xfeature_enabled(enum xfeature xfeature)
 {
-	return xfeatures_mask_all & BIT_ULL(xfeature);
+	return fpu_kernel_cfg.max_features & BIT_ULL(xfeature);
 }
=20
 /*
@@ -184,10 +201,7 @@ static void __init setup_xstate_features(void)
 	xstate_sizes[XFEATURE_SSE]	=3D sizeof_field(struct fxregs_state,
 						       xmm_space);
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
=20
 		xstate_sizes[i] =3D eax;
@@ -236,6 +250,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
+	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
=20
 /*
@@ -291,20 +307,15 @@ static void __init setup_xstate_comp_offsets(void)
 	xstate_comp_offsets[XFEATURE_SSE] =3D offsetof(struct fxregs_state,
 						     xmm_space);
=20
-	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
-		for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-			if (xfeature_enabled(i))
-				xstate_comp_offsets[i] =3D xstate_offsets[i];
-		}
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+		for_each_extended_xfeature(i, fpu_kernel_cfg.max_features)
+			xstate_comp_offsets[i] =3D xstate_offsets[i];
 		return;
 	}
=20
 	next_offset =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		if (xfeature_is_aligned(i))
 			next_offset =3D ALIGN(next_offset, 64);
=20
@@ -328,8 +339,8 @@ static void __init setup_supervisor_only_offsets(void)
=20
 	next_offset =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i) || !xfeature_is_supervisor(i))
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
+		if (!xfeature_is_supervisor(i))
 			continue;
=20
 		if (xfeature_is_aligned(i))
@@ -347,14 +358,35 @@ static void __init print_xstate_offset_size(void)
 {
 	int i;
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
 			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
 	}
 }
=20
+/*
+ * This function is called only during boot time when x86 caps are not set
+ * up and alternative can not be used yet.
+ */
+static __init void os_xrstor_booting(struct xregs_state *xstate)
+{
+	u64 mask =3D fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSTATE;
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+	int err;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+
+	/*
+	 * We should never fault when copying from a kernel buffer, and the FPU
+	 * state we set at boot time should be valid.
+	 */
+	WARN_ON_FPU(err);
+}
+
 /*
  * All supported features have either init state all zeros or are
  * handled in setup_init_fpu() individually. This is an explicit
@@ -372,36 +404,30 @@ static void __init print_xstate_offset_size(void)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
-	 XFEATURE_MASK_PASID)
+	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_XTILE)
=20
 /*
  * setup the xstate image representing the init state
  */
 static void __init setup_init_fpu_buf(void)
 {
-	static int on_boot_cpu __initdata =3D 1;
-
 	BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
 		      XFEATURE_MASK_SUPERVISOR_SUPPORTED) !=3D
 		     XFEATURES_INIT_FPSTATE_HANDLED);
=20
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu =3D 0;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
=20
 	setup_xstate_features();
 	print_xstate_features();
=20
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv =3D XCOMP_BV_COMPACTED_FORMAT |
-						     xfeatures_mask_all;
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
=20
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
 	 */
-	os_xrstor_booting(&init_fpstate.xsave);
+	os_xrstor_booting(&init_fpstate.regs.xsave);
=20
 	/*
 	 * All components are now in init state. Read the state back so
@@ -419,7 +445,7 @@ static void __init setup_init_fpu_buf(void)
 	 * state is all zeroes or if not to add the necessary handling
 	 * here.
 	 */
-	fxsave(&init_fpstate.fxsave);
+	fxsave(&init_fpstate.regs.fxsave);
 }
=20
 static int xfeature_uncompacted_offset(int xfeature_nr)
@@ -451,10 +477,11 @@ int xfeature_size(int xfeature_nr)
 }
=20
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-static int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr,
+				       struct fpstate *fpstate)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_uabi())
+	if (hdr->xfeatures & ~fpstate->user_xfeatures)
 		return -EINVAL;
=20
 	/* Userspace must use the uncompacted format */
@@ -474,7 +501,7 @@ static int validate_user_xstate_header(const struct xstat=
e_header *hdr)
 	return 0;
 }
=20
-static void __xstate_dump_leaves(void)
+static void __init __xstate_dump_leaves(void)
 {
 	int i;
 	u32 eax, ebx, ecx, edx;
@@ -509,12 +536,73 @@ static void __xstate_dump_leaves(void)
 	}								\
 } while (0)
=20
+/**
+ * check_xtile_data_against_struct - Check tile data state size.
+ *
+ * Calculate the state size by multiplying the single tile size which is
+ * recorded in a C struct, and the number of tiles that the CPU informs.
+ * Compare the provided size with the calculation.
+ *
+ * @size:	The tile data state size
+ *
+ * Returns:	0 on success, -EINVAL on mismatch.
+ */
+static int __init check_xtile_data_against_struct(int size)
+{
+	u32 max_palid, palid, state_size;
+	u32 eax, ebx, ecx, edx;
+	u16 max_tile;
+
+	/*
+	 * Check the maximum palette id:
+	 *   eax: the highest numbered palette subleaf.
+	 */
+	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
+
+	/*
+	 * Cross-check each tile size and find the maximum number of
+	 * supported tiles.
+	 */
+	for (palid =3D 1, max_tile =3D 0; palid <=3D max_palid; palid++) {
+		u16 tile_size, max;
+
+		/*
+		 * Check the tile size info:
+		 *   eax[31:16]:  bytes per title
+		 *   ebx[31:16]:  the max names (or max number of tiles)
+		 */
+		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
+		tile_size =3D eax >> 16;
+		max =3D ebx >> 16;
+
+		if (tile_size !=3D sizeof(struct xtile_data)) {
+			pr_err("%s: struct is %zu bytes, cpu xtile %d bytes\n",
+			       __stringify(XFEATURE_XTILE_DATA),
+			       sizeof(struct xtile_data), tile_size);
+			__xstate_dump_leaves();
+			return -EINVAL;
+		}
+
+		if (max > max_tile)
+			max_tile =3D max;
+	}
+
+	state_size =3D sizeof(struct xtile_data) * max_tile;
+	if (size !=3D state_size) {
+		pr_err("%s: calculated size is %u bytes, cpu state %d bytes\n",
+		       __stringify(XFEATURE_XTILE_DATA), state_size, size);
+		__xstate_dump_leaves();
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * We have a C struct for each 'xstate'.  We need to ensure
  * that our software representation matches what the CPU
  * tells us about the state's size.
  */
-static void check_xstate_against_struct(int nr)
+static bool __init check_xstate_against_struct(int nr)
 {
 	/*
 	 * Ask the CPU for the size of the state.
@@ -532,6 +620,11 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
+	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
+
+	/* The tile data size varies between implementations. */
+	if (nr =3D=3D XFEATURE_XTILE_DATA)
+		check_xtile_data_against_struct(sz);
=20
 	/*
 	 * Make *SURE* to add any feature numbers in below if
@@ -541,10 +634,39 @@ static void check_xstate_against_struct(int nr)
 	if ((nr < XFEATURE_YMM) ||
 	    (nr >=3D XFEATURE_MAX) ||
 	    (nr =3D=3D XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >=3D XFEATURE_RSRVD_COMP_11) && (nr <=3D XFEATURE_LBR))) {
+	    ((nr >=3D XFEATURE_RSRVD_COMP_11) && (nr <=3D XFEATURE_RSRVD_COMP_16)))=
 {
 		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
+		return false;
+	}
+	return true;
+}
+
+static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+{
+	unsigned int size =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	int i;
+
+	for_each_extended_xfeature(i, xfeatures) {
+		/* Align from the end of the previous feature */
+		if (xfeature_is_aligned(i))
+			size =3D ALIGN(size, 64);
+		/*
+		 * In compacted format the enabled features are packed,
+		 * i.e. disabled features do not occupy space.
+		 *
+		 * In non-compacted format the offsets are fixed and
+		 * disabled states still occupy space in the memory buffer.
+		 */
+		if (!compacted)
+			size =3D xfeature_uncompacted_offset(i);
+		/*
+		 * Add the feature size even for non-compacted format
+		 * to make the end result correct
+		 */
+		size +=3D xfeature_size(i);
 	}
+	return size;
 }
=20
 /*
@@ -556,44 +678,29 @@ static void check_xstate_against_struct(int nr)
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
-static void do_extra_xstate_size_checks(void)
+static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 {
-	int paranoid_xstate_size =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	bool compacted =3D cpu_feature_enabled(X86_FEATURE_XSAVES);
+	unsigned int size =3D FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
-		check_xstate_against_struct(i);
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
+		if (!check_xstate_against_struct(i))
+			return false;
 		/*
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
 		 */
-		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			XSTATE_WARN_ON(xfeature_is_supervisor(i));
-
-		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
-			paranoid_xstate_size =3D ALIGN(paranoid_xstate_size, 64);
-		/*
-		 * The offset of a given state in the non-compacted
-		 * format is given to us in a CPUID leaf.  We check
-		 * them for being ordered (increasing offsets) in
-		 * setup_xstate_features(). XSAVES uses compacted format.
-		 */
-		if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
-			paranoid_xstate_size =3D xfeature_uncompacted_offset(i);
-		/*
-		 * The compacted-format offset always depends on where
-		 * the previous state ended.
-		 */
-		paranoid_xstate_size +=3D xfeature_size(i);
+		if (!compacted && xfeature_is_supervisor(i)) {
+			XSTATE_WARN_ON(1);
+			return false;
+		}
 	}
-	XSTATE_WARN_ON(paranoid_xstate_size !=3D fpu_kernel_xstate_size);
+	size =3D xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
+	XSTATE_WARN_ON(size !=3D kernel_size);
+	return size =3D=3D kernel_size;
 }
=20
-
 /*
  * Get total size of enabled xstates in XCR0 | IA32_XSS.
  *
@@ -644,7 +751,7 @@ static unsigned int __init get_xsaves_size_no_independent=
(void)
 	return size;
 }
=20
-static unsigned int __init get_xsave_size(void)
+static unsigned int __init get_xsave_size_user(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	/*
@@ -662,44 +769,54 @@ static unsigned int __init get_xsave_size(void)
  * Will the runtime-enumerated 'xstate_size' fit in the init
  * task's statically-allocated buffer?
  */
-static bool is_supported_xstate_size(unsigned int test_xstate_size)
+static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 {
-	if (test_xstate_size <=3D sizeof(union fpregs_state))
+	if (test_xstate_size <=3D sizeof(init_fpstate.regs))
 		return true;
=20
 	pr_warn("x86/fpu: xstate buffer too small (%zu < %d), disabling xsave\n",
-			sizeof(union fpregs_state), test_xstate_size);
+			sizeof(init_fpstate.regs), test_xstate_size);
 	return false;
 }
=20
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
-	unsigned int possible_xstate_size;
-	unsigned int xsave_size;
+	unsigned int user_size, kernel_size, kernel_default_size;
+	bool compacted =3D cpu_feature_enabled(X86_FEATURE_XSAVES);
=20
-	xsave_size =3D get_xsave_size();
+	/* Uncompacted user space size */
+	user_size =3D get_xsave_size_user();
=20
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size =3D get_xsaves_size_no_independent();
+	/*
+	 * XSAVES kernel size includes supervisor states and
+	 * uses compacted format when available.
+	 *
+	 * XSAVE does not support supervisor states so
+	 * kernel and user size is identical.
+	 */
+	if (compacted)
+		kernel_size =3D get_xsaves_size_no_independent();
 	else
-		possible_xstate_size =3D xsave_size;
+		kernel_size =3D user_size;
+
+	kernel_default_size =3D
+		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
=20
-	/* Ensure we have the space to store all enabled: */
-	if (!is_supported_xstate_size(possible_xstate_size))
+	/* Ensure we have the space to store all default enabled features. */
+	if (!is_supported_xstate_size(kernel_default_size))
 		return -EINVAL;
=20
-	/*
-	 * The size is OK, we are definitely going to use xsave,
-	 * make it known to the world that we need more space.
-	 */
-	fpu_kernel_xstate_size =3D possible_xstate_size;
-	do_extra_xstate_size_checks();
+	if (!paranoid_xstate_size_valid(kernel_size))
+		return -EINVAL;
+
+	fpu_kernel_cfg.max_size =3D kernel_size;
+	fpu_user_cfg.max_size =3D user_size;
+
+	fpu_kernel_cfg.default_size =3D kernel_default_size;
+	fpu_user_cfg.default_size =3D
+		xstate_calculate_size(fpu_user_cfg.default_features, false);
=20
-	/*
-	 * User space is always in standard format.
-	 */
-	fpu_user_xstate_size =3D xsave_size;
 	return 0;
 }
=20
@@ -707,28 +824,38 @@ static int __init init_xstate_size(void)
  * We enabled the XSAVE hardware, but something went wrong and
  * we can not use it.  Disable it.
  */
-static void fpu__init_disable_system_xstate(void)
+static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 {
-	xfeatures_mask_all =3D 0;
+	fpu_kernel_cfg.max_features =3D 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	/* Restore the legacy size.*/
+	fpu_kernel_cfg.max_size =3D legacy_size;
+	fpu_kernel_cfg.default_size =3D legacy_size;
+	fpu_user_cfg.max_size =3D legacy_size;
+	fpu_user_cfg.default_size =3D legacy_size;
+
+	/*
+	 * Prevent enabling the static branch which enables writes to the
+	 * XFD MSR.
+	 */
+	init_fpstate.xfd =3D 0;
+
+	fpstate_reset(&current->thread.fpu);
 }
=20
 /*
  * Enable and initialize the xsave feature.
  * Called once per system bootup.
  */
-void __init fpu__init_system_xstate(void)
+void __init fpu__init_system_xstate(unsigned int legacy_size)
 {
 	unsigned int eax, ebx, ecx, edx;
-	static int on_boot_cpu __initdata =3D 1;
 	u64 xfeatures;
 	int err;
 	int i;
=20
-	WARN_ON_FPU(!on_boot_cpu);
-	on_boot_cpu =3D 0;
-
 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
 		pr_info("x86/fpu: No FPU detected\n");
 		return;
@@ -749,22 +876,22 @@ void __init fpu__init_system_xstate(void)
 	 * Find user xstates supported by the processor.
 	 */
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask_all =3D eax + ((u64)edx << 32);
+	fpu_kernel_cfg.max_features =3D eax + ((u64)edx << 32);
=20
 	/*
 	 * Find supervisor xstates supported by the processor.
 	 */
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask_all |=3D ecx + ((u64)edx << 32);
+	fpu_kernel_cfg.max_features |=3D ecx + ((u64)edx << 32);
=20
-	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) !=3D XFEATURE_MASK_FPSSE)=
 {
+	if ((fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSSE) !=3D XFEATURE_MASK_=
FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
 		 * booting without it.  This is too early to BUG().
 		 */
 		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%=
llx.\n",
-		       xfeatures_mask_all);
+		       fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
=20
@@ -772,15 +899,39 @@ void __init fpu__init_system_xstate(void)
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
 	for (i =3D 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_all &=3D ~BIT_ULL(i);
+		unsigned short cid =3D xsave_cpuid_features[i];
+
+		/* Careful: X86_FEATURE_FPU is 0! */
+		if ((i !=3D XFEATURE_FP && !cid) || !boot_cpu_has(cid))
+			fpu_kernel_cfg.max_features &=3D ~BIT_ULL(i);
 	}
=20
-	xfeatures_mask_all &=3D XFEATURE_MASK_USER_SUPPORTED |
+	if (!cpu_feature_enabled(X86_FEATURE_XFD))
+		fpu_kernel_cfg.max_features &=3D ~XFEATURE_MASK_USER_DYNAMIC;
+
+	fpu_kernel_cfg.max_features &=3D XFEATURE_MASK_USER_SUPPORTED |
 			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
=20
+	fpu_user_cfg.max_features =3D fpu_kernel_cfg.max_features;
+	fpu_user_cfg.max_features &=3D XFEATURE_MASK_USER_SUPPORTED;
+
+	/* Clean out dynamic features from default */
+	fpu_kernel_cfg.default_features =3D fpu_kernel_cfg.max_features;
+	fpu_kernel_cfg.default_features &=3D ~XFEATURE_MASK_USER_DYNAMIC;
+
+	fpu_user_cfg.default_features =3D fpu_user_cfg.max_features;
+	fpu_user_cfg.default_features &=3D ~XFEATURE_MASK_USER_DYNAMIC;
+
 	/* Store it for paranoia check at the end */
-	xfeatures =3D xfeatures_mask_all;
+	xfeatures =3D fpu_kernel_cfg.max_features;
+
+	/*
+	 * Initialize the default XFD state in initfp_state and enable the
+	 * dynamic sizing mechanism if dynamic states are available.  The
+	 * static key cannot be enabled here because this runs before
+	 * jump_label_init(). This is delayed to an initcall.
+	 */
+	init_fpstate.xfd =3D fpu_user_cfg.max_features & XFEATURE_MASK_USER_DYNAMIC;
=20
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -788,13 +939,16 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
=20
+	/* Reset the state for the current task */
+	fpstate_reset(&current->thread.fpu);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
+	update_regset_xstate_info(fpu_user_cfg.max_size,
+				  fpu_user_cfg.max_features);
=20
-	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
@@ -803,22 +957,22 @@ void __init fpu__init_system_xstate(void)
 	 * Paranoia check whether something in the setup modified the
 	 * xfeatures mask.
 	 */
-	if (xfeatures !=3D xfeatures_mask_all) {
+	if (xfeatures !=3D fpu_kernel_cfg.max_features) {
 		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during ini=
t, disabling XSAVE\n",
-		       xfeatures, xfeatures_mask_all);
+		       xfeatures, fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
=20
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes,=
 using '%s' format.\n",
-		xfeatures_mask_all,
-		fpu_kernel_xstate_size,
+		fpu_kernel_cfg.max_features,
+		fpu_kernel_cfg.max_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
=20
 out_disable:
 	/* something went wrong, try to boot without any XSAVE support */
-	fpu__init_disable_system_xstate();
+	fpu__init_disable_system_xstate(legacy_size);
 }
=20
 /*
@@ -830,7 +984,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, fpu_user_cfg.max_features);
=20
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
@@ -840,6 +994,9 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
+
+	if (fpu_state_size_dynamic())
+		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
 }
=20
 /*
@@ -886,7 +1043,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfea=
ture_nr)
 	 * We should not ever be requesting features that we
 	 * have not enabled.
 	 */
-	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(fpu_kernel_cfg.max_features & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
@@ -904,7 +1061,6 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfea=
ture_nr)
=20
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
-EXPORT_SYMBOL_GPL(get_xsave_addr);
=20
 #ifdef CONFIG_ARCH_HAS_PKEYS
=20
@@ -961,9 +1117,10 @@ static void copy_feature(bool from_xstate, struct membu=
f *to, void *xstate,
 }
=20
 /**
- * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * __copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @tsk:	The task from which to copy the saved xstate
+ * @fpstate:	The fpstate buffer from which to copy
+ * @pkru_val:	The PKRU value to store in the PKRU component
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -972,14 +1129,15 @@ static void copy_feature(bool from_xstate, struct memb=
uf *to, void *xstate,
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-			     enum xstate_copy_mode copy_mode)
+void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
+			       u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr =3D offsetof(struct fxregs_state, mxcsr);
-	struct xregs_state *xsave =3D &tsk->thread.fpu.state.xsave;
-	struct xregs_state *xinit =3D &init_fpstate.xsave;
+	struct xregs_state *xinit =3D &init_fpstate.regs.xsave;
+	struct xregs_state *xsave =3D &fpstate->regs.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
+	u64 mask;
 	int i;
=20
 	memset(&header, 0, sizeof(header));
@@ -996,7 +1154,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct ta=
sk_struct *tsk,
 		break;
=20
 	case XSTATE_COPY_XSAVE:
-		header.xfeatures &=3D xfeatures_mask_uabi();
+		header.xfeatures &=3D fpstate->user_xfeatures;
 		break;
 	}
=20
@@ -1033,17 +1191,15 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct=
 task_struct *tsk,
=20
 	zerofrom =3D offsetof(struct xregs_state, extended_state_area);
=20
-	for (i =3D FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		/*
-		 * The ptrace buffer is in non-compacted XSAVE format.
-		 * In non-compacted format disabled features still occupy
-		 * state space, but there is no state to copy from in the
-		 * compacted init_fpstate. The gap tracking will zero this
-		 * later.
-		 */
-		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
-			continue;
+	/*
+	 * The ptrace buffer is in non-compacted XSAVE format.  In
+	 * non-compacted format disabled features still occupy state space,
+	 * but there is no state to copy from in the compacted
+	 * init_fpstate. The gap tracking will zero these states.
+	 */
+	mask =3D fpstate->user_xfeatures;
=20
+	for_each_extended_xfeature(i, mask) {
 		/*
 		 * If there was a feature or alignment gap, zero the space
 		 * in the destination buffer.
@@ -1055,10 +1211,9 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct =
task_struct *tsk,
 			struct pkru_state pkru =3D {0};
 			/*
 			 * PKRU is not necessarily up to date in the
-			 * thread's XSAVE buffer.  Fill this part from the
-			 * per-thread storage.
+			 * XSAVE buffer. Use the provided value.
 			 */
-			pkru.pkru =3D tsk->thread.pkru;
+			pkru.pkru =3D pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
 			copy_feature(header.xfeatures & BIT_ULL(i), &to,
@@ -1078,6 +1233,25 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct =
task_struct *tsk,
 		membuf_zero(&to, to.left);
 }
=20
+/**
+ * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * @to:		membuf descriptor
+ * @tsk:	The task from which to copy the saved xstate
+ * @copy_mode:	The requested copy mode
+ *
+ * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
+ * format, i.e. from the kernel internal hardware dependent storage format
+ * to the requested @mode. UABI XSTATE is always uncompacted!
+ *
+ * It supports partial copy but @to.pos always starts from zero.
+ */
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
+			     enum xstate_copy_mode copy_mode)
+{
+	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu.fpstate,
+				  tsk->thread.pkru, copy_mode);
+}
+
 static int copy_from_buffer(void *dst, unsigned int offset, unsigned int siz=
e,
 			    const void *kbuf, const void __user *ubuf)
 {
@@ -1091,9 +1265,10 @@ static int copy_from_buffer(void *dst, unsigned int of=
fset, unsigned int size,
 }
=20
=20
-static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf)
 {
+	struct xregs_state *xsave =3D &fpstate->regs.xsave;
 	unsigned int offset, size;
 	struct xstate_header hdr;
 	u64 mask;
@@ -1103,7 +1278,7 @@ static int copy_uabi_to_xstate(struct xregs_state *xsav=
e, const void *kbuf,
 	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
 		return -EFAULT;
=20
-	if (validate_user_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr, fpstate))
 		return -EINVAL;
=20
 	/* Validate MXCSR when any of the related features is in use */
@@ -1156,12 +1331,11 @@ static int copy_uabi_to_xstate(struct xregs_state *xs=
ave, const void *kbuf,
=20
 /*
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
- * format and copy to the target thread. This is called from
- * xstateregs_set().
+ * format and copy to the target thread. Used by ptrace and KVM.
  */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *k=
buf)
+int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbu=
f)
 {
-	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
 }
=20
 /*
@@ -1169,26 +1343,20 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_stat=
e *xsave, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(xsave, NULL, ubuf);
+	return copy_uabi_to_xstate(fpstate, NULL, ubuf);
 }
=20
-static bool validate_xsaves_xrstors(u64 mask)
+static bool validate_independent_components(u64 mask)
 {
 	u64 xchk;
=20
 	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
 		return false;
-	/*
-	 * Validate that this is either a task->fpstate related component
-	 * subset or an independent one.
-	 */
-	if (mask & xfeatures_mask_independent())
-		xchk =3D ~xfeatures_mask_independent();
-	else
-		xchk =3D ~xfeatures_mask_all;
+
+	xchk =3D ~xfeatures_mask_independent();
=20
 	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return false;
@@ -1206,14 +1374,13 @@ static bool validate_xsaves_xrstors(u64 mask)
  * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
  * can #GP.
  *
- * The feature mask must either be a subset of the independent features or
- * a subset of the task->fpstate related features.
+ * The feature mask must be a subset of the independent features.
  */
 void xsaves(struct xregs_state *xstate, u64 mask)
 {
 	int err;
=20
-	if (!validate_xsaves_xrstors(mask))
+	if (!validate_independent_components(mask))
 		return;
=20
 	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
@@ -1231,20 +1398,379 @@ void xsaves(struct xregs_state *xstate, u64 mask)
  * Proper usage is to restore the state which was saved with
  * xsaves() into @xstate.
  *
- * The feature mask must either be a subset of the independent features or
- * a subset of the task->fpstate related features.
+ * The feature mask must be a subset of the independent features.
  */
 void xrstors(struct xregs_state *xstate, u64 mask)
 {
 	int err;
=20
-	if (!validate_xsaves_xrstors(mask))
+	if (!validate_independent_components(mask))
 		return;
=20
 	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
 	WARN_ON_ONCE(err);
 }
=20
+#if IS_ENABLED(CONFIG_KVM)
+void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeatu=
re)
+{
+	void *addr =3D get_xsave_addr(&fps->regs.xsave, xfeature);
+
+	if (addr)
+		memset(addr, 0, xstate_sizes[xfeature]);
+}
+EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
+#endif
+
+#ifdef CONFIG_X86_64
+
+#ifdef CONFIG_X86_DEBUG_FPU
+/*
+ * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=3D@mask
+ * can safely operate on the @fpstate buffer.
+ */
+static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	u64 xfd =3D __this_cpu_read(xfd_state);
+
+	if (fpstate->xfd =3D=3D xfd)
+		return true;
+
+	 /*
+	  * The XFD MSR does not match fpstate->xfd. That's invalid when
+	  * the passed in fpstate is current's fpstate.
+	  */
+	if (fpstate->xfd =3D=3D current->thread.fpu.fpstate->xfd)
+		return false;
+
+	/*
+	 * XRSTOR(S) from init_fpstate are always correct as it will just
+	 * bring all components into init state and not read from the
+	 * buffer. XSAVE(S) raises #PF after init.
+	 */
+	if (fpstate =3D=3D &init_fpstate)
+		return rstor;
+
+	/*
+	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
+	 * XRSTORS(S): fpu_swap_kvm_fpu()
+	 */
+
+	/*
+	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
+	 * the buffer area for XFD-disabled state components.
+	 */
+	mask &=3D ~xfd;
+
+	/*
+	 * Remove features which are valid in fpstate. They
+	 * have space allocated in fpstate.
+	 */
+	mask &=3D ~fpstate->xfeatures;
+
+	/*
+	 * Any remaining state components in 'mask' might be written
+	 * by XSAVE/XRSTOR. Fail validation it found.
+	 */
+	return !mask;
+}
+
+void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
+}
+#endif /* CONFIG_X86_DEBUG_FPU */
+
+static int __init xfd_update_static_branch(void)
+{
+	/*
+	 * If init_fpstate.xfd has bits set then dynamic features are
+	 * available and the dynamic sizing must be enabled.
+	 */
+	if (init_fpstate.xfd)
+		static_branch_enable(&__fpu_state_size_dynamic);
+	return 0;
+}
+arch_initcall(xfd_update_static_branch)
+
+void fpstate_free(struct fpu *fpu)
+{
+	if (fpu->fpstate && fpu->fpstate !=3D &fpu->__fpstate)
+		vfree(fpu->fpstate);
+}
+
+/**
+ * fpu_install_fpstate - Update the active fpstate in the FPU
+ *
+ * @fpu:	A struct fpu * pointer
+ * @newfps:	A struct fpstate * pointer
+ *
+ * Returns:	A null pointer if the last active fpstate is the embedded
+ *		one or the new fpstate is already installed;
+ *		otherwise, a pointer to the old fpstate which has to
+ *		be freed by the caller.
+ */
+static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
+					   struct fpstate *newfps)
+{
+	struct fpstate *oldfps =3D fpu->fpstate;
+
+	if (fpu->fpstate =3D=3D newfps)
+		return NULL;
+
+	fpu->fpstate =3D newfps;
+	return oldfps !=3D &fpu->__fpstate ? oldfps : NULL;
+}
+
+/**
+ * fpstate_realloc - Reallocate struct fpstate for the requested new features
+ *
+ * @xfeatures:	A bitmap of xstate features which extend the enabled features
+ *		of that task
+ * @ksize:	The required size for the kernel buffer
+ * @usize:	The required size for user space buffers
+ *
+ * Note vs. vmalloc(): If the task with a vzalloc()-allocated buffer
+ * terminates quickly, vfree()-induced IPIs may be a concern, but tasks
+ * with large states are likely to live longer.
+ *
+ * Returns: 0 on success, -ENOMEM on allocation error.
+ */
+static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
+			   unsigned int usize)
+{
+	struct fpu *fpu =3D &current->thread.fpu;
+	struct fpstate *curfps, *newfps =3D NULL;
+	unsigned int fpsize;
+
+	curfps =3D fpu->fpstate;
+	fpsize =3D ksize + ALIGN(offsetof(struct fpstate, regs), 64);
+
+	newfps =3D vzalloc(fpsize);
+	if (!newfps)
+		return -ENOMEM;
+	newfps->size =3D ksize;
+	newfps->user_size =3D usize;
+	newfps->is_valloc =3D true;
+
+	fpregs_lock();
+	/*
+	 * Ensure that the current state is in the registers before
+	 * swapping fpstate as that might invalidate it due to layout
+	 * changes.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+
+	newfps->xfeatures =3D curfps->xfeatures | xfeatures;
+	newfps->user_xfeatures =3D curfps->user_xfeatures | xfeatures;
+	newfps->xfd =3D curfps->xfd & ~xfeatures;
+
+	curfps =3D fpu_install_fpstate(fpu, newfps);
+
+	/* Do the final updates within the locked region */
+	xstate_init_xcomp_bv(&newfps->regs.xsave, newfps->xfeatures);
+	xfd_update_state(newfps);
+
+	fpregs_unlock();
+
+	vfree(curfps);
+	return 0;
+}
+
+static int validate_sigaltstack(unsigned int usize)
+{
+	struct task_struct *thread, *leader =3D current->group_leader;
+	unsigned long framesize =3D get_sigframe_size();
+
+	lockdep_assert_held(&current->sighand->siglock);
+
+	/* get_sigframe_size() is based on fpu_user_cfg.max_size */
+	framesize -=3D fpu_user_cfg.max_size;
+	framesize +=3D usize;
+	for_each_thread(leader, thread) {
+		if (thread->sas_ss_size && thread->sas_ss_size < framesize)
+			return -ENOSPC;
+	}
+	return 0;
+}
+
+static int __xstate_request_perm(u64 permitted, u64 requested)
+{
+	/*
+	 * This deliberately does not exclude !XSAVES as we still might
+	 * decide to optionally context switch XCR0 or talk the silicon
+	 * vendors into extending XFD for the pre AMX states, especially
+	 * AVX512.
+	 */
+	bool compacted =3D cpu_feature_enabled(X86_FEATURE_XSAVES);
+	struct fpu *fpu =3D &current->group_leader->thread.fpu;
+	unsigned int ksize, usize;
+	u64 mask;
+	int ret;
+
+	/* Check whether fully enabled */
+	if ((permitted & requested) =3D=3D requested)
+		return 0;
+
+	/* Calculate the resulting kernel state size */
+	mask =3D permitted | requested;
+	ksize =3D xstate_calculate_size(mask, compacted);
+
+	/* Calculate the resulting user state size */
+	mask &=3D XFEATURE_MASK_USER_SUPPORTED;
+	usize =3D xstate_calculate_size(mask, false);
+
+	ret =3D validate_sigaltstack(usize);
+	if (ret)
+		return ret;
+
+	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
+	WRITE_ONCE(fpu->perm.__state_perm, requested);
+	/* Protected by sighand lock */
+	fpu->perm.__state_size =3D ksize;
+	fpu->perm.__user_state_size =3D usize;
+	return ret;
+}
+
+/*
+ * Permissions array to map facilities with more than one component
+ */
+static const u64 xstate_prctl_req[XFEATURE_MAX] =3D {
+	[XFEATURE_XTILE_DATA] =3D XFEATURE_MASK_XTILE_DATA,
+};
+
+static int xstate_request_perm(unsigned long idx)
+{
+	u64 permitted, requested;
+	int ret;
+
+	if (idx >=3D XFEATURE_MAX)
+		return -EINVAL;
+
+	/*
+	 * Look up the facility mask which can require more than
+	 * one xstate component.
+	 */
+	idx =3D array_index_nospec(idx, ARRAY_SIZE(xstate_prctl_req));
+	requested =3D xstate_prctl_req[idx];
+	if (!requested)
+		return -EOPNOTSUPP;
+
+	if ((fpu_user_cfg.max_features & requested) !=3D requested)
+		return -EOPNOTSUPP;
+
+	/* Lockless quick check */
+	permitted =3D xstate_get_host_group_perm();
+	if ((permitted & requested) =3D=3D requested)
+		return 0;
+
+	/* Protect against concurrent modifications */
+	spin_lock_irq(&current->sighand->siglock);
+	permitted =3D xstate_get_host_group_perm();
+	ret =3D __xstate_request_perm(permitted, requested);
+	spin_unlock_irq(&current->sighand->siglock);
+	return ret;
+}
+
+int xfd_enable_feature(u64 xfd_err)
+{
+	u64 xfd_event =3D xfd_err & XFEATURE_MASK_USER_DYNAMIC;
+	unsigned int ksize, usize;
+	struct fpu *fpu;
+
+	if (!xfd_event) {
+		pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
+		return 0;
+	}
+
+	/* Protect against concurrent modifications */
+	spin_lock_irq(&current->sighand->siglock);
+
+	/* If not permitted let it die */
+	if ((xstate_get_host_group_perm() & xfd_event) !=3D xfd_event) {
+		spin_unlock_irq(&current->sighand->siglock);
+		return -EPERM;
+	}
+
+	fpu =3D &current->group_leader->thread.fpu;
+	ksize =3D fpu->perm.__state_size;
+	usize =3D fpu->perm.__user_state_size;
+	/*
+	 * The feature is permitted. State size is sufficient.  Dropping
+	 * the lock is safe here even if more features are added from
+	 * another task, the retrieved buffer sizes are valid for the
+	 * currently requested feature(s).
+	 */
+	spin_unlock_irq(&current->sighand->siglock);
+
+	/*
+	 * Try to allocate a new fpstate. If that fails there is no way
+	 * out.
+	 */
+	if (fpstate_realloc(xfd_event, ksize, usize))
+		return -EFAULT;
+	return 0;
+}
+#else /* CONFIG_X86_64 */
+static inline int xstate_request_perm(unsigned long idx)
+{
+	return -EPERM;
+}
+#endif  /* !CONFIG_X86_64 */
+
+/**
+ * fpu_xstate_prctl - xstate permission operations
+ * @tsk:	Redundant pointer to current
+ * @option:	A subfunction of arch_prctl()
+ * @arg2:	option argument
+ * Return:	0 if successful; otherwise, an error code
+ *
+ * Option arguments:
+ *
+ * ARCH_GET_XCOMP_SUPP: Pointer to user space u64 to store the info
+ * ARCH_GET_XCOMP_PERM: Pointer to user space u64 to store the info
+ * ARCH_REQ_XCOMP_PERM: Facility number requested
+ *
+ * For facilities which require more than one XSTATE component, the request
+ * must be the highest state component number related to that facility,
+ * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
+ * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
+ */
+long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg=
2)
+{
+	u64 __user *uptr =3D (u64 __user *)arg2;
+	u64 permitted, supported;
+	unsigned long idx =3D arg2;
+
+	if (tsk !=3D current)
+		return -EPERM;
+
+	switch (option) {
+	case ARCH_GET_XCOMP_SUPP:
+		supported =3D fpu_user_cfg.max_features |	fpu_user_cfg.legacy_features;
+		return put_user(supported, uptr);
+
+	case ARCH_GET_XCOMP_PERM:
+		/*
+		 * Lockless snapshot as it can also change right after the
+		 * dropping the lock.
+		 */
+		permitted =3D xstate_get_host_group_perm();
+		permitted &=3D XFEATURE_MASK_USER_SUPPORTED;
+		return put_user(permitted, uptr);
+
+	case ARCH_REQ_XCOMP_PERM:
+		if (!IS_ENABLED(CONFIG_X86_64))
+			return -EOPNOTSUPP;
+
+		return xstate_request_perm(idx);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
new file mode 100644
index 000000000000..e18210dff88c
--- /dev/null
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_XSTATE_H
+#define __X86_KERNEL_FPU_XSTATE_H
+
+#include <asm/cpufeature.h>
+#include <asm/fpu/xstate.h>
+
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU(u64, xfd_state);
+#endif
+
+static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
+{
+	/*
+	 * XRSTORS requires these bits set in xcomp_bv, or it will
+	 * trigger #GP:
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		xsave->header.xcomp_bv =3D mask | XCOMP_BV_COMPACTED_FORMAT;
+}
+
+static inline u64 xstate_get_host_group_perm(void)
+{
+	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
+	return READ_ONCE(current->group_leader->thread.fpu.perm.__state_perm);
+}
+
+enum xstate_copy_mode {
+	XSTATE_COPY_FP,
+	XSTATE_COPY_FX,
+	XSTATE_COPY_XSAVE,
+};
+
+struct membuf;
+extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpst=
ate,
+				      u32 pkru_val, enum xstate_copy_mode copy_mode);
+extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *ts=
k,
+				    enum xstate_copy_mode mode);
+extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const vo=
id *kbuf);
+extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const =
void __user *ubuf);
+
+
+extern void fpu__init_cpu_xstate(void);
+extern void fpu__init_system_xstate(unsigned int legacy_size);
+
+extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+
+static inline u64 xfeatures_mask_supervisor(void)
+{
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+}
+
+static inline u64 xfeatures_mask_independent(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+
+	return XFEATURE_MASK_INDEPENDENT;
+}
+
+/* XSAVE/XRSTOR wrapper functions */
+
+#ifdef CONFIG_X86_64
+#define REX_PREFIX	"0x48, "
+#else
+#define REX_PREFIX
+#endif
+
+/* These macros all use (%edi)/(%rdi) as the single memory argument. */
+#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
+#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
+#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
+#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
+#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
+
+/*
+ * After this @err contains 0 on success or the trap number when the
+ * operation raises an exception.
+ */
+#define XSTATE_OP(op, st, lmask, hmask, err)				\
+	asm volatile("1:" op "\n\t"					\
+		     "xor %[err], %[err]\n"				\
+		     "2:\n\t"						\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     : [err] "=3Da" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
+ * format and supervisor states in addition to modified optimization in
+ * XSAVEOPT.
+ *
+ * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEO=
PT
+ * supports modified optimization which is not supported by XSAVE.
+ *
+ * We use XSAVE as a fallback.
+ *
+ * The 661 label is defined in the ALTERNATIVE* macros as the address of the
+ * original instruction which gets replaced. We need to use it here as the
+ * address of the instruction where we might get an exception at.
+ */
+#define XSTATE_XSAVE(st, lmask, hmask, err)				\
+	asm volatile(ALTERNATIVE_2(XSAVE,				\
+				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
+				   XSAVES,   X86_FEATURE_XSAVES)	\
+		     "\n"						\
+		     "xor %[err], %[err]\n"				\
+		     "3:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "4: movl $-2, %[err]\n"				\
+		     "jmp 3b\n"						\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE(661b, 4b)				\
+		     : [err] "=3Dr" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
+ * XSAVE area format.
+ */
+#define XSTATE_XRESTORE(st, lmask, hmask)				\
+	asm volatile(ALTERNATIVE(XRSTOR,				\
+				 XRSTORS, X86_FEATURE_XSAVES)		\
+		     "\n"						\
+		     "3:\n"						\
+		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     :							\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+#if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
+extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor=
);
+#else
+static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, boo=
l rstor) { }
+#endif
+
+#ifdef CONFIG_X86_64
+static inline void xfd_update_state(struct fpstate *fpstate)
+{
+	if (fpu_state_size_dynamic()) {
+		u64 xfd =3D fpstate->xfd;
+
+		if (__this_cpu_read(xfd_state) !=3D xfd) {
+			wrmsrl(MSR_IA32_XFD, xfd);
+			__this_cpu_write(xfd_state, xfd);
+		}
+	}
+}
+#else
+static inline void xfd_update_state(struct fpstate *fpstate) { }
+#endif
+
+/*
+ * Save processor xstate to xsave area.
+ *
+ * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
+ * and command line options. The choice is permanent until the next reboot.
+ */
+static inline void os_xsave(struct fpstate *fpstate)
+{
+	u64 mask =3D fpstate->xfeatures;
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+	int err;
+
+	WARN_ON_FPU(!alternatives_patched);
+	xfd_validate_state(fpstate, mask, false);
+
+	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
+
+	/* We should never fault when copying to a kernel buffer: */
+	WARN_ON_FPU(err);
+}
+
+/*
+ * Restore processor xstate from xsave area.
+ *
+ * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
+ */
+static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
+{
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+
+	xfd_validate_state(fpstate, mask, true);
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+}
+
+/* Restore of supervisor state. Does not require XFD */
+static inline void os_xrstor_supervisor(struct fpstate *fpstate)
+{
+	u64 mask =3D xfeatures_mask_supervisor();
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+}
+
+/*
+ * Save xstate to user space xsave area.
+ *
+ * We don't use modified optimization because xrstor/xrstors might track
+ * a different application.
+ *
+ * We don't use compacted format xsave area for backward compatibility for
+ * old applications which don't understand the compacted format of the
+ * xsave area.
+ *
+ * The caller has to zero buf::header before calling this because XSAVE*
+ * does not touch the reserved fields in the header.
+ */
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
+{
+	/*
+	 * Include the features which are not xsaved/rstored by the kernel
+	 * internally, e.g. PKRU. That's user space ABI and also required
+	 * to allow the signal handler to modify PKRU.
+	 */
+	struct fpstate *fpstate =3D current->thread.fpu.fpstate;
+	u64 mask =3D fpstate->user_xfeatures;
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+	int err;
+
+	xfd_validate_state(fpstate, mask, false);
+
+	stac();
+	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
+	clac();
+
+	return err;
+}
+
+/*
+ * Restore xstate from user space xsave area.
+ */
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, =
u64 mask)
+{
+	struct xregs_state *xstate =3D ((__force struct xregs_state *)buf);
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+	int err;
+
+	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
+
+	stac();
+	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	clac();
+
+	return err;
+}
+
+/*
+ * Restore xstate from kernel space xsave area, return an error code instead=
 of
+ * an exception.
+ */
+static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
+{
+	struct xregs_state *xstate =3D &fpstate->regs.xsave;
+	u32 lmask =3D mask;
+	u32 hmask =3D mask >> 32;
+	int err;
+
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpstate);
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+
+	return err;
+}
+
+
+#endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..f3f251787b99 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -30,7 +30,9 @@
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
+#include <asm/fpu/sched.h>
+#include <asm/fpu/xstate.h>
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
 #include <asm/tlbflush.h>
@@ -87,8 +89,19 @@ int arch_dup_task_struct(struct task_struct *dst, struct t=
ask_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 =3D NULL;
 #endif
-	return fpu_clone(dst);
+	/* Drop the copied pointer to current's fpstate */
+	dst->thread.fpu.fpstate =3D NULL;
+
+	return 0;
+}
+
+#ifdef CONFIG_X86_64
+void arch_release_task_struct(struct task_struct *tsk)
+{
+	if (fpu_state_size_dynamic())
+		fpstate_free(&tsk->thread.fpu);
 }
+#endif
=20
 /*
  * Free thread data structures etc..
@@ -154,6 +167,8 @@ int copy_thread(unsigned long clone_flags, unsigned long =
sp, unsigned long arg,
 	frame->flags =3D X86_EFLAGS_FIXED;
 #endif
=20
+	fpu_clone(p, clone_flags);
+
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		p->thread.pkru =3D pkru_get_init_value();
@@ -999,13 +1014,17 @@ unsigned long get_wchan(struct task_struct *p)
 }
=20
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
+	case ARCH_GET_XCOMP_SUPP:
+	case ARCH_GET_XCOMP_PERM:
+	case ARCH_REQ_XCOMP_PERM:
+		return fpu_xstate_prctl(task, option, arg2);
 	}
=20
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..26edb1cd07a4 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -41,7 +41,7 @@
=20
 #include <asm/ldt.h>
 #include <asm/processor.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/sched.h>
 #include <asm/desc.h>
=20
 #include <linux/err.h>
@@ -160,7 +160,6 @@ __switch_to(struct task_struct *prev_p, struct task_struc=
t *next_p)
 	struct thread_struct *prev =3D &prev_p->thread,
 			     *next =3D &next_p->thread;
 	struct fpu *prev_fpu =3D &prev->fpu;
-	struct fpu *next_fpu =3D &next->fpu;
 	int cpu =3D smp_processor_id();
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectl=
y */
@@ -213,7 +212,7 @@ __switch_to(struct task_struct *prev_p, struct task_struc=
t *next_p)
=20
 	this_cpu_write(current_task, next_p);
=20
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish();
=20
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ec0d836a13b1..3402edec236c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -42,7 +42,7 @@
=20
 #include <asm/processor.h>
 #include <asm/pkru.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/sched.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
 #include <asm/desc.h>
@@ -559,7 +559,6 @@ __switch_to(struct task_struct *prev_p, struct task_struc=
t *next_p)
 	struct thread_struct *prev =3D &prev_p->thread;
 	struct thread_struct *next =3D &next_p->thread;
 	struct fpu *prev_fpu =3D &prev->fpu;
-	struct fpu *next_fpu =3D &next->fpu;
 	int cpu =3D smp_processor_id();
=20
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
@@ -620,7 +619,7 @@ __switch_to(struct task_struct *prev_p, struct task_struc=
t *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
=20
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish();
=20
 	/* Reload sp0. */
 	update_task_stack(next_p);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4c208ea3bd9f..6d2244c94799 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -29,9 +29,9 @@
=20
 #include <linux/uaccess.h>
 #include <asm/processor.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/fpu/xstate.h>
 #include <asm/debugreg.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..50c773c3384c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,7 +23,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
 #include <asm/insn-eval.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/xcr.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e470083..ec71e06ae364 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/tracehook.h>
@@ -30,8 +31,8 @@
=20
 #include <asm/processor.h>
 #include <asm/ucontext.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
+#include <asm/fpu/xstate.h>
 #include <asm/vdso.h>
 #include <asm/mce.h>
 #include <asm/sighandling.h>
@@ -41,6 +42,7 @@
 #include <linux/compat.h>
 #include <asm/proto.h>
 #include <asm/ia32_unistd.h>
+#include <asm/fpu/xstate.h>
 #endif /* CONFIG_X86_64 */
=20
 #include <asm/syscall.h>
@@ -79,9 +81,9 @@ static void force_valid_ss(struct pt_regs *regs)
 # define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
=20
-static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *usc,
-			      unsigned long uc_flags)
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
 {
 	struct sigcontext sc;
=20
@@ -89,7 +91,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn =3D do_no_restart_syscall;
=20
 	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return -EFAULT;
+		return false;
=20
 #ifdef CONFIG_X86_32
 	set_user_gs(regs, sc.gs);
@@ -244,7 +246,6 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs=
, size_t frame_size,
 	unsigned long math_size =3D 0;
 	unsigned long sp =3D regs->sp;
 	unsigned long buf_fx =3D 0;
-	int ret;
=20
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -292,8 +293,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs=
, size_t frame_size,
 	}
=20
 	/* save i387 and extended state */
-	ret =3D copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size=
);
-	if (ret < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
 		return (void __user *)-1L;
=20
 	return (void __user *)sp;
@@ -643,7 +643,7 @@ SYSCALL_DEFINE0(sigreturn)
 	 * x86_32 has no uc_flags bits relevant to restore_sigcontext.
 	 * Save a few cycles by skipping the __get_user.
 	 */
-	if (restore_sigcontext(regs, &frame->sc, 0))
+	if (!restore_sigcontext(regs, &frame->sc, 0))
 		goto badframe;
 	return regs->ax;
=20
@@ -671,7 +671,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
=20
 	set_current_blocked(&set);
=20
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
=20
 	if (restore_altstack(&frame->uc.uc_stack))
@@ -721,12 +721,15 @@ SYSCALL_DEFINE0(rt_sigreturn)
=20
 /* max_frame_size tells userspace the worst case signal stack size. */
 static unsigned long __ro_after_init max_frame_size;
+static unsigned int __ro_after_init fpu_default_state_size;
=20
 void __init init_sigframe_size(void)
 {
+	fpu_default_state_size =3D fpu__get_fpstate_size();
+
 	max_frame_size =3D MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
=20
-	max_frame_size +=3D fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+	max_frame_size +=3D fpu_default_state_size + MAX_XSAVE_PADDING;
=20
 	/* Userspace expects an aligned size. */
 	max_frame_size =3D round_up(max_frame_size, FRAME_ALIGNMENT);
@@ -910,6 +913,62 @@ void signal_fault(struct pt_regs *regs, void __user *fra=
me, char *where)
 	force_sig(SIGSEGV);
 }
=20
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+#ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
+static bool strict_sigaltstack_size __ro_after_init =3D true;
+#else
+static bool strict_sigaltstack_size __ro_after_init =3D false;
+#endif
+
+static int __init strict_sas_size(char *arg)
+{
+	return kstrtobool(arg, &strict_sigaltstack_size);
+}
+__setup("strict_sas_size", strict_sas_size);
+
+/*
+ * MINSIGSTKSZ is 2048 and can't be changed despite the fact that AVX512
+ * exceeds that size already. As such programs might never use the
+ * sigaltstack they just continued to work. While always checking against
+ * the real size would be correct, this might be considered a regression.
+ *
+ * Therefore avoid the sanity check, unless enforced by kernel
+ * configuration or command line option.
+ *
+ * When dynamic FPU features are supported, the check is also enforced when
+ * the task has permissions to use dynamic features. Tasks which have no
+ * permission are checked against the size of the non-dynamic feature set
+ * if strict checking is enabled. This avoids forcing all tasks on the
+ * system to allocate large sigaltstacks even if they are never going
+ * to use a dynamic feature. As this is serialized via sighand::siglock
+ * any permission request for a dynamic feature either happened already
+ * or will see the newly install sigaltstack size in the permission checks.
+ */
+bool sigaltstack_size_valid(size_t ss_size)
+{
+	unsigned long fsize =3D max_frame_size - fpu_default_state_size;
+	u64 mask;
+
+	lockdep_assert_held(&current->sighand->siglock);
+
+	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
+		return true;
+
+	fsize +=3D current->group_leader->thread.fpu.perm.__user_state_size;
+	if (likely(ss_size > fsize))
+		return true;
+
+	if (strict_sigaltstack_size)
+		return ss_size > fsize;
+
+	mask =3D current->group_leader->thread.fpu.perm.__state_perm;
+	if (mask & XFEATURE_MASK_USER_DYNAMIC)
+		return ss_size > fsize;
+
+	return true;
+}
+#endif /* CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_X86_X32_ABI
 COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
@@ -929,7 +988,7 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
=20
 	set_current_blocked(&set);
=20
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
=20
 	if (compat_restore_altstack(&frame->uc.uc_stack))
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e242b6b4..2577ed3b5e6b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -70,7 +70,7 @@
 #include <asm/mwait.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/setup.h>
 #include <asm/uv/uv.h>
 #include <linux/mc146818rtc.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..6ca1454a65d4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -48,7 +48,7 @@
 #include <asm/ftrace.h>
 #include <asm/traps.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/mce.h>
@@ -1108,10 +1108,48 @@ DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 	 */
 }
=20
+static bool handle_xfd_event(struct pt_regs *regs)
+{
+	u64 xfd_err;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_X86_64) || !cpu_feature_enabled(X86_FEATURE_XFD))
+		return false;
+
+	rdmsrl(MSR_IA32_XFD_ERR, xfd_err);
+	if (!xfd_err)
+		return false;
+
+	wrmsrl(MSR_IA32_XFD_ERR, 0);
+
+	/* Die if that happens in kernel space */
+	if (WARN_ON(!user_mode(regs)))
+		return false;
+
+	local_irq_enable();
+
+	err =3D xfd_enable_feature(xfd_err);
+
+	switch (err) {
+	case -EPERM:
+		force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
+		break;
+	case -EFAULT:
+		force_sig(SIGSEGV);
+		break;
+	}
+
+	local_irq_disable();
+	return true;
+}
+
 DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 =3D read_cr0();
=20
+	if (handle_xfd_event(regs))
+		return;
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info =3D { };
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c36b5fe4c27c..3c57bd091120 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -17,10 +17,10 @@
 #include <linux/misc_cgroup.h>
 #include <linux/processor.h>
 #include <linux/trace_events.h>
-#include <asm/fpu/internal.h>
=20
 #include <asm/pkru.h>
 #include <asm/trapnr.h>
+#include <asm/fpu/xcr.h>
=20
 #include "x86.h"
 #include "svm.h"
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 989685098b3e..f39c87ddc2e5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -36,6 +36,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/cpu_device_id.h>
 #include <asm/traps.h>
+#include <asm/fpu/api.h>
=20
 #include <asm/virtext.h>
 #include "trace.h"
@@ -1346,10 +1347,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 		/*
 		 * SEV-ES guests maintain an encrypted version of their FPU
 		 * state which is restored and saved on VMRUN and VMEXIT.
-		 * Free the fpu structure to prevent KVM from attempting to
-		 * access the FPU state.
+		 * Mark vcpu->arch.guest_fpu->fpstate as scratch so it won't
+		 * do xsave/xrstor on it.
 		 */
-		kvm_free_guest_fpu(vcpu);
+		fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	}
=20
 	err =3D avic_init_vcpu(svm);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 116b08904ac3..9a979279a37b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -35,7 +35,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/debugreg.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aabd3a2ec1bc..c953ec24a75c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -68,7 +68,9 @@
 #include <asm/mce.h>
 #include <asm/pkru.h>
 #include <linux/kernel_stat.h>
-#include <asm/fpu/internal.h> /* Ugh! */
+#include <asm/fpu/api.h>
+#include <asm/fpu/xcr.h>
+#include <asm/fpu/xstate.h>
 #include <asm/pvclock.h>
 #include <asm/div64.h>
 #include <asm/irq_remapping.h>
@@ -293,8 +295,6 @@ u64 __read_mostly host_xcr0;
 u64 __read_mostly supported_xcr0;
 EXPORT_SYMBOL_GPL(supported_xcr0);
=20
-static struct kmem_cache *x86_fpu_cache;
-
 static struct kmem_cache *x86_emulator_cache;
=20
 /*
@@ -4700,144 +4700,27 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct k=
vm_vcpu *vcpu,
 	return 0;
 }
=20
-#define XSTATE_COMPACTION_ENABLED (1ULL << 63)
-
-static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
-{
-	struct xregs_state *xsave =3D &vcpu->arch.guest_fpu->state.xsave;
-	u64 xstate_bv =3D xsave->header.xfeatures;
-	u64 valid;
-
-	/*
-	 * Copy legacy XSAVE area, to avoid complications with CPUID
-	 * leaves 0 and 1 in the loop below.
-	 */
-	memcpy(dest, xsave, XSAVE_HDR_OFFSET);
-
-	/* Set XSTATE_BV */
-	xstate_bv &=3D vcpu->arch.guest_supported_xcr0 | XFEATURE_MASK_FPSSE;
-	*(u64 *)(dest + XSAVE_HDR_OFFSET) =3D xstate_bv;
-
-	/*
-	 * Copy each region from the possibly compacted offset to the
-	 * non-compacted offset.
-	 */
-	valid =3D xstate_bv & ~XFEATURE_MASK_FPSSE;
-	while (valid) {
-		u32 size, offset, ecx, edx;
-		u64 xfeature_mask =3D valid & -valid;
-		int xfeature_nr =3D fls64(xfeature_mask) - 1;
-		void *src;
-
-		cpuid_count(XSTATE_CPUID, xfeature_nr,
-			    &size, &offset, &ecx, &edx);
-
-		if (xfeature_nr =3D=3D XFEATURE_PKRU) {
-			memcpy(dest + offset, &vcpu->arch.pkru,
-			       sizeof(vcpu->arch.pkru));
-		} else {
-			src =3D get_xsave_addr(xsave, xfeature_nr);
-			if (src)
-				memcpy(dest + offset, src, size);
-		}
-
-		valid -=3D xfeature_mask;
-	}
-}
-
-static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
-{
-	struct xregs_state *xsave =3D &vcpu->arch.guest_fpu->state.xsave;
-	u64 xstate_bv =3D *(u64 *)(src + XSAVE_HDR_OFFSET);
-	u64 valid;
-
-	/*
-	 * Copy legacy XSAVE area, to avoid complications with CPUID
-	 * leaves 0 and 1 in the loop below.
-	 */
-	memcpy(xsave, src, XSAVE_HDR_OFFSET);
-
-	/* Set XSTATE_BV and possibly XCOMP_BV.  */
-	xsave->header.xfeatures =3D xstate_bv;
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		xsave->header.xcomp_bv =3D host_xcr0 | XSTATE_COMPACTION_ENABLED;
-
-	/*
-	 * Copy each region from the non-compacted offset to the
-	 * possibly compacted offset.
-	 */
-	valid =3D xstate_bv & ~XFEATURE_MASK_FPSSE;
-	while (valid) {
-		u32 size, offset, ecx, edx;
-		u64 xfeature_mask =3D valid & -valid;
-		int xfeature_nr =3D fls64(xfeature_mask) - 1;
-
-		cpuid_count(XSTATE_CPUID, xfeature_nr,
-			    &size, &offset, &ecx, &edx);
-
-		if (xfeature_nr =3D=3D XFEATURE_PKRU) {
-			memcpy(&vcpu->arch.pkru, src + offset,
-			       sizeof(vcpu->arch.pkru));
-		} else {
-			void *dest =3D get_xsave_addr(xsave, xfeature_nr);
-
-			if (dest)
-				memcpy(dest, src + offset, size);
-		}
-
-		valid -=3D xfeature_mask;
-	}
-}
-
 static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 					 struct kvm_xsave *guest_xsave)
 {
-	if (!vcpu->arch.guest_fpu)
+	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return;
=20
-	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
-		memset(guest_xsave, 0, sizeof(struct kvm_xsave));
-		fill_xsave((u8 *) guest_xsave->region, vcpu);
-	} else {
-		memcpy(guest_xsave->region,
-			&vcpu->arch.guest_fpu->state.fxsave,
-			sizeof(struct fxregs_state));
-		*(u64 *)&guest_xsave->region[XSAVE_HDR_OFFSET / sizeof(u32)] =3D
-			XFEATURE_MASK_FPSSE;
-	}
+	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu,
+				       guest_xsave->region,
+				       sizeof(guest_xsave->region),
+				       vcpu->arch.pkru);
 }
=20
-#define XSAVE_MXCSR_OFFSET 24
-
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
-	u64 xstate_bv;
-	u32 mxcsr;
-
-	if (!vcpu->arch.guest_fpu)
+	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return 0;
=20
-	xstate_bv =3D *(u64 *)&guest_xsave->region[XSAVE_HDR_OFFSET / sizeof(u32)];
-	mxcsr =3D *(u32 *)&guest_xsave->region[XSAVE_MXCSR_OFFSET / sizeof(u32)];
-
-	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
-		/*
-		 * Here we allow setting states that are not present in
-		 * CPUID leaf 0xD, index 0, EDX:EAX.  This is for compatibility
-		 * with old userspace.
-		 */
-		if (xstate_bv & ~supported_xcr0 || mxcsr & ~mxcsr_feature_mask)
-			return -EINVAL;
-		load_xsave(vcpu, (u8 *)guest_xsave->region);
-	} else {
-		if (xstate_bv & ~XFEATURE_MASK_FPSSE ||
-			mxcsr & ~mxcsr_feature_mask)
-			return -EINVAL;
-		memcpy(&vcpu->arch.guest_fpu->state.fxsave,
-			guest_xsave->region, sizeof(struct fxregs_state));
-	}
-	return 0;
+	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
+					      guest_xsave->region,
+					      supported_xcr0, &vcpu->arch.pkru);
 }
=20
 static void kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
@@ -8417,18 +8300,11 @@ int kvm_arch_init(void *opaque)
 	}
=20
 	r =3D -ENOMEM;
-	x86_fpu_cache =3D kmem_cache_create("x86_fpu", sizeof(struct fpu),
-					  __alignof__(struct fpu), SLAB_ACCOUNT,
-					  NULL);
-	if (!x86_fpu_cache) {
-		printk(KERN_ERR "kvm: failed to allocate cache for x86 fpu\n");
-		goto out;
-	}
=20
 	x86_emulator_cache =3D kvm_alloc_emulator_cache();
 	if (!x86_emulator_cache) {
 		pr_err("kvm: failed to allocate cache for x86 emulator\n");
-		goto out_free_x86_fpu_cache;
+		goto out;
 	}
=20
 	user_return_msrs =3D alloc_percpu(struct kvm_user_return_msrs);
@@ -8466,8 +8342,6 @@ int kvm_arch_init(void *opaque)
 	free_percpu(user_return_msrs);
 out_free_x86_emulator_cache:
 	kmem_cache_destroy(x86_emulator_cache);
-out_free_x86_fpu_cache:
-	kmem_cache_destroy(x86_fpu_cache);
 out:
 	return r;
 }
@@ -8494,7 +8368,6 @@ void kvm_arch_exit(void)
 	kvm_mmu_module_exit();
 	free_percpu(user_return_msrs);
 	kmem_cache_destroy(x86_emulator_cache);
-	kmem_cache_destroy(x86_fpu_cache);
 #ifdef CONFIG_KVM_XEN
 	static_key_deferred_flush(&kvm_xen_enabled);
 	WARN_ON(static_branch_unlikely(&kvm_xen_enabled.key));
@@ -9913,58 +9786,21 @@ static int complete_emulated_mmio(struct kvm_vcpu *vc=
pu)
 	return 0;
 }
=20
-static void kvm_save_current_fpu(struct fpu *fpu)
-{
-	/*
-	 * If the target FPU state is not resident in the CPU registers, just
-	 * memcpy() from current, else save CPU state directly to the target.
-	 */
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(&fpu->state, &current->thread.fpu.state,
-		       fpu_kernel_xstate_size);
-	else
-		save_fpregs_to_fpstate(fpu);
-}
-
 /* Swap (qemu) user FPU context for the guest FPU context. */
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	fpregs_lock();
-
-	kvm_save_current_fpu(vcpu->arch.user_fpu);
-
 	/*
-	 * Guests with protected state can't have it set by the hypervisor,
-	 * so skip trying to set it.
+	 * Exclude PKRU from restore as restored separately in
+	 * kvm_x86_ops.run().
 	 */
-	if (vcpu->arch.guest_fpu)
-		/* PKRU is separately restored in kvm_x86_ops.run. */
-		__restore_fpregs_from_fpstate(&vcpu->arch.guest_fpu->state,
-					~XFEATURE_MASK_PKRU);
-
-	fpregs_mark_activate();
-	fpregs_unlock();
-
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
 	trace_kvm_fpu(1);
 }
=20
 /* When vcpu_run ends, restore user space FPU context. */
 static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	fpregs_lock();
-
-	/*
-	 * Guests with protected state can't have it read by the hypervisor,
-	 * so skip trying to save it.
-	 */
-	if (vcpu->arch.guest_fpu)
-		kvm_save_current_fpu(vcpu->arch.guest_fpu);
-
-	restore_fpregs_from_fpstate(&vcpu->arch.user_fpu->state);
-
-	fpregs_mark_activate();
-	fpregs_unlock();
-
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
 }
@@ -10545,12 +10381,12 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vc=
pu, struct kvm_fpu *fpu)
 {
 	struct fxregs_state *fxsave;
=20
-	if (!vcpu->arch.guest_fpu)
+	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return 0;
=20
 	vcpu_load(vcpu);
=20
-	fxsave =3D &vcpu->arch.guest_fpu->state.fxsave;
+	fxsave =3D &vcpu->arch.guest_fpu.fpstate->regs.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw =3D fxsave->cwd;
 	fpu->fsw =3D fxsave->swd;
@@ -10568,12 +10404,12 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vc=
pu, struct kvm_fpu *fpu)
 {
 	struct fxregs_state *fxsave;
=20
-	if (!vcpu->arch.guest_fpu)
+	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return 0;
=20
 	vcpu_load(vcpu);
=20
-	fxsave =3D &vcpu->arch.guest_fpu->state.fxsave;
+	fxsave =3D &vcpu->arch.guest_fpu.fpstate->regs.fxsave;
=20
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd =3D fpu->fcw;
@@ -10626,14 +10462,6 @@ static int sync_regs(struct kvm_vcpu *vcpu)
=20
 static void fx_init(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->arch.guest_fpu)
-		return;
-
-	fpstate_init(&vcpu->arch.guest_fpu->state);
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		vcpu->arch.guest_fpu->state.xsave.header.xcomp_bv =3D
-			host_xcr0 | XSTATE_COMPACTION_ENABLED;
-
 	/*
 	 * Ensure guest xcr0 is valid for loading
 	 */
@@ -10642,15 +10470,6 @@ static void fx_init(struct kvm_vcpu *vcpu)
 	vcpu->arch.cr0 |=3D X86_CR0_ET;
 }
=20
-void kvm_free_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->arch.guest_fpu) {
-		kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
-		vcpu->arch.guest_fpu =3D NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(kvm_free_guest_fpu);
-
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
 	if (kvm_check_tsc_unstable() && atomic_read(&kvm->online_vcpus) !=3D 0)
@@ -10707,19 +10526,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!alloc_emulate_ctxt(vcpu))
 		goto free_wbinvd_dirty_mask;
=20
-	vcpu->arch.user_fpu =3D kmem_cache_zalloc(x86_fpu_cache,
-						GFP_KERNEL_ACCOUNT);
-	if (!vcpu->arch.user_fpu) {
-		pr_err("kvm: failed to allocate userspace's fpu\n");
+	if (!fpu_alloc_guest_fpstate(&vcpu->arch.guest_fpu)) {
+		pr_err("kvm: failed to allocate vcpu's fpu\n");
 		goto free_emulate_ctxt;
 	}
=20
-	vcpu->arch.guest_fpu =3D kmem_cache_zalloc(x86_fpu_cache,
-						 GFP_KERNEL_ACCOUNT);
-	if (!vcpu->arch.guest_fpu) {
-		pr_err("kvm: failed to allocate vcpu's fpu\n");
-		goto free_user_fpu;
-	}
 	fx_init(vcpu);
=20
 	vcpu->arch.maxphyaddr =3D cpuid_query_maxphyaddr(vcpu);
@@ -10752,9 +10563,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
=20
 free_guest_fpu:
-	kvm_free_guest_fpu(vcpu);
-free_user_fpu:
-	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
+	fpu_free_guest_fpstate(&vcpu->arch.guest_fpu);
 free_emulate_ctxt:
 	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
 free_wbinvd_dirty_mask:
@@ -10803,8 +10612,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
=20
 	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
 	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
-	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
-	kvm_free_guest_fpu(vcpu);
+	fpu_free_guest_fpstate(&vcpu->arch.guest_fpu);
=20
 	kvm_hv_vcpu_uninit(vcpu);
 	kvm_pmu_destroy(vcpu);
@@ -10856,8 +10664,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_=
event)
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted =3D false;
=20
-	if (vcpu->arch.guest_fpu && kvm_mpx_supported()) {
-		void *mpx_state_buffer;
+	if (vcpu->arch.guest_fpu.fpstate && kvm_mpx_supported()) {
+		struct fpstate *fpstate =3D vcpu->arch.guest_fpu.fpstate;
=20
 		/*
 		 * To avoid have the INIT path from kvm_apic_has_events() that be
@@ -10865,14 +10673,10 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool ini=
t_event)
 		 */
 		if (init_event)
 			kvm_put_guest_fpu(vcpu);
-		mpx_state_buffer =3D get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
-					XFEATURE_BNDREGS);
-		if (mpx_state_buffer)
-			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndreg_state));
-		mpx_state_buffer =3D get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
-					XFEATURE_BNDCSR);
-		if (mpx_state_buffer)
-			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
+
+		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
+		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
+
 		if (init_event)
 			kvm_load_guest_fpu(vcpu);
 	}
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index e5f77e293034..7334055157ba 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -107,9 +107,9 @@ SYM_FUNC_END(copy_mc_fragile)
=20
 	.previous
=20
-	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
-	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
-	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_=
MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAUL=
T_MCE_SAFE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
@@ -149,5 +149,5 @@ SYM_FUNC_END(copy_mc_enhanced_fast_string)
=20
 	.previous
=20
-	_ASM_EXTABLE_FAULT(.L_copy, .E_copy)
+	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
 #endif /* !CONFIG_UML */
diff --git a/arch/x86/math-emu/fpu_aux.c b/arch/x86/math-emu/fpu_aux.c
index 034748459482..d62662bdd460 100644
--- a/arch/x86/math-emu/fpu_aux.c
+++ b/arch/x86/math-emu/fpu_aux.c
@@ -53,7 +53,7 @@ void fpstate_init_soft(struct swregs_state *soft)
=20
 void finit(void)
 {
-	fpstate_init_soft(&current->thread.fpu.state.soft);
+	fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
 }
=20
 /*
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 8679a9d6c47f..7fe56c594aa6 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -31,7 +31,7 @@
 #include <linux/uaccess.h>
 #include <asm/traps.h>
 #include <asm/user.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
=20
 #include "fpu_system.h"
 #include "fpu_emu.h"
@@ -640,7 +640,7 @@ int fpregs_soft_set(struct task_struct *target,
 		    unsigned int pos, unsigned int count,
 		    const void *kbuf, const void __user *ubuf)
 {
-	struct swregs_state *s387 =3D &target->thread.fpu.state.soft;
+	struct swregs_state *s387 =3D &target->thread.fpu.fpstate->regs.soft;
 	void *space =3D s387->st_space;
 	int ret;
 	int offset, other, i, tags, regnr, tag, newtop;
@@ -691,7 +691,7 @@ int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
 		    struct membuf to)
 {
-	struct swregs_state *s387 =3D &target->thread.fpu.state.soft;
+	struct swregs_state *s387 =3D &target->thread.fpu.fpstate->regs.soft;
 	const void *space =3D s387->st_space;
 	int offset =3D (S387->ftop & 7) * 10, other =3D 80 - offset;
=20
diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index 9b41391867dc..eec3e4805c75 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -73,7 +73,7 @@ static inline bool seg_writable(struct desc_struct *d)
 	return (d->type & SEG_TYPE_EXECUTE_MASK) =3D=3D SEG_TYPE_WRITABLE;
 }
=20
-#define I387			(&current->thread.fpu.state)
+#define I387			(&current->thread.fpu.fpstate->regs)
 #define FPU_info		(I387->soft.info)
=20
 #define FPU_CS			(*(unsigned short *) &(FPU_info->regs->cs))
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index e1664e9f969c..5cd2a88930a9 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -4,46 +4,30 @@
 #include <linux/sched/debug.h>
 #include <xen/xen.h>
=20
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
=20
-typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			    struct pt_regs *, int, unsigned long,
-			    unsigned long);
-
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
 {
 	return (unsigned long)&x->fixup + x->fixup;
 }
-static inline ex_handler_t
-ex_fixup_handler(const struct exception_table_entry *x)
-{
-	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
-}
=20
-__visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_default(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs)
 {
 	regs->ip =3D ex_fixup_addr(fixup);
 	return true;
 }
-EXPORT_SYMBOL(ex_handler_default);
=20
-__visible bool ex_handler_fault(const struct exception_table_entry *fixup,
-				struct pt_regs *regs, int trapnr,
-				unsigned long error_code,
-				unsigned long fault_addr)
+static bool ex_handler_fault(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, int trapnr)
 {
-	regs->ip =3D ex_fixup_addr(fixup);
 	regs->ax =3D trapnr;
-	return true;
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL_GPL(ex_handler_fault);
=20
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never =
get
@@ -55,65 +39,47 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * of vulnerability by restoring from the initial state (essentially, zeroing
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
-__visible bool ex_handler_fprestore(const struct exception_table_entry *fixu=
p,
-				    struct pt_regs *regs, int trapnr,
-				    unsigned long error_code,
-				    unsigned long fault_addr)
+static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
+				 struct pt_regs *regs)
 {
 	regs->ip =3D ex_fixup_addr(fixup);
=20
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
=20
-	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
+	fpu_reset_from_exception_fixup();
 	return true;
 }
-EXPORT_SYMBOL_GPL(ex_handler_fprestore);
=20
-__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr =3D=3D X86_TRAP_GP, "General protection fault in user acce=
ss. Non-canonical address?");
-	regs->ip =3D ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_uaccess);
=20
-__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
-			       struct pt_regs *regs, int trapnr,
-			       unsigned long error_code,
-			       unsigned long fault_addr)
+static bool ex_handler_copy(const struct exception_table_entry *fixup,
+			    struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr =3D=3D X86_TRAP_GP, "General protection fault in user acce=
ss. Non-canonical address?");
-	regs->ip =3D ex_fixup_addr(fixup);
-	regs->ax =3D trapnr;
-	return true;
+	return ex_handler_fault(fixup, regs, trapnr);
 }
-EXPORT_SYMBOL(ex_handler_copy);
=20
-__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *f=
ixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixu=
p,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx=
 (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
 		show_stack_regs(regs);
=20
 	/* Pretend that the read succeeded and returned 0. */
-	regs->ip =3D ex_fixup_addr(fixup);
 	regs->ax =3D 0;
 	regs->dx =3D 0;
-	return true;
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
=20
-__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *f=
ixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixu=
p,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write=
 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -121,45 +87,29 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exce=
ption_table_entry *fixup
 		show_stack_regs(regs);
=20
 	/* Pretend that the write succeeded. */
-	regs->ip =3D ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
=20
-__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr,
-				   unsigned long error_code,
-				   unsigned long fault_addr)
+static bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
+				struct pt_regs *regs)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
 	asm volatile ("mov %0, %%fs" : : "rm" (0));
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_clear_fs);
=20
-enum handler_type ex_get_fault_handler_type(unsigned long ip)
+int ex_get_fixup_type(unsigned long ip)
 {
-	const struct exception_table_entry *e;
-	ex_handler_t handler;
+	const struct exception_table_entry *e =3D search_exception_tables(ip);
=20
-	e =3D search_exception_tables(ip);
-	if (!e)
-		return EX_HANDLER_NONE;
-	handler =3D ex_fixup_handler(e);
-	if (handler =3D=3D ex_handler_fault)
-		return EX_HANDLER_FAULT;
-	else if (handler =3D=3D ex_handler_uaccess || handler =3D=3D ex_handler_cop=
y)
-		return EX_HANDLER_UACCESS;
-	else
-		return EX_HANDLER_OTHER;
+	return e ? e->type : EX_TYPE_NONE;
 }
=20
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_co=
de,
 		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
-	ex_handler_t handler;
=20
 #ifdef CONFIG_PNPBIOS
 	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
@@ -179,8 +129,35 @@ int fixup_exception(struct pt_regs *regs, int trapnr, un=
signed long error_code,
 	if (!e)
 		return 0;
=20
-	handler =3D ex_fixup_handler(e);
-	return handler(e, regs, trapnr, error_code, fault_addr);
+	switch (e->type) {
+	case EX_TYPE_DEFAULT:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
+		return ex_handler_default(e, regs);
+	case EX_TYPE_FAULT:
+	case EX_TYPE_FAULT_MCE_SAFE:
+		return ex_handler_fault(e, regs, trapnr);
+	case EX_TYPE_UACCESS:
+		return ex_handler_uaccess(e, regs, trapnr);
+	case EX_TYPE_COPY:
+		return ex_handler_copy(e, regs, trapnr);
+	case EX_TYPE_CLEAR_FS:
+		return ex_handler_clear_fs(e, regs);
+	case EX_TYPE_FPU_RESTORE:
+		return ex_handler_fprestore(e, regs);
+	case EX_TYPE_RDMSR:
+		return ex_handler_rdmsr_unsafe(e, regs);
+	case EX_TYPE_WRMSR:
+		return ex_handler_wrmsr_unsafe(e, regs);
+	case EX_TYPE_BPF:
+		return ex_handler_bpf(e, regs);
+	case EX_TYPE_RDMSR_IN_MCE:
+		ex_handler_msr_mce(regs, false);
+		break;
+	case EX_TYPE_WRMSR_IN_MCE:
+		ex_handler_msr_mce(regs, true);
+		break;
+	}
+	BUG();
 }
=20
 extern unsigned int early_recursion_flag;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9ea57389c554..e63ca38acbe4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -827,9 +827,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
=20
-static bool ex_handler_bpf(const struct exception_table_entry *x,
-			   struct pt_regs *regs, int trapnr,
-			   unsigned long error_code, unsigned long fault_addr)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *r=
egs)
 {
 	u32 reg =3D x->fixup >> 8;
=20
@@ -1313,12 +1311,7 @@ st:			if (is_imm8(insn->off))
 				}
 				ex->insn =3D delta;
=20
-				delta =3D (u8 *)ex_handler_bpf - (u8 *)&ex->handler;
-				if (!is_simm32(delta)) {
-					pr_err("extable->handler doesn't fit into 32-bit\n");
-					return -EFAULT;
-				}
-				ex->handler =3D delta;
+				ex->type =3D EX_TYPE_BPF;
=20
 				if (dst_reg > BPF_REG_9) {
 					pr_err("verifier error\n");
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 6665f8802098..9f2b251e83c5 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #include <asm/mce.h>
 #include <asm/suspend.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3f96a6374e4f..7d34105e20c6 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -464,6 +464,12 @@ int __save_altstack(stack_t __user *, unsigned long);
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
 } while (0);
=20
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+bool sigaltstack_size_valid(size_t ss_size);
+#else
+static inline bool sigaltstack_size_valid(size_t size) { return true; }
+#endif /* !CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..9278f5291ed6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4151,11 +4151,29 @@ int do_sigaction(int sig, struct k_sigaction *act, st=
ruct k_sigaction *oact)
 	return 0;
 }
=20
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+static inline void sigaltstack_lock(void)
+	__acquires(&current->sighand->siglock)
+{
+	spin_lock_irq(&current->sighand->siglock);
+}
+
+static inline void sigaltstack_unlock(void)
+	__releases(&current->sighand->siglock)
+{
+	spin_unlock_irq(&current->sighand->siglock);
+}
+#else
+static inline void sigaltstack_lock(void) { }
+static inline void sigaltstack_unlock(void) { }
+#endif
+
 static int
 do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 		size_t min_ss_size)
 {
 	struct task_struct *t =3D current;
+	int ret =3D 0;
=20
 	if (oss) {
 		memset(oss, 0, sizeof(stack_t));
@@ -4179,19 +4197,24 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsi=
gned long sp,
 				ss_mode !=3D 0))
 			return -EINVAL;
=20
+		sigaltstack_lock();
 		if (ss_mode =3D=3D SS_DISABLE) {
 			ss_size =3D 0;
 			ss_sp =3D NULL;
 		} else {
 			if (unlikely(ss_size < min_ss_size))
-				return -ENOMEM;
+				ret =3D -ENOMEM;
+			if (!sigaltstack_size_valid(ss_size))
+				ret =3D -ENOMEM;
 		}
-
-		t->sas_ss_sp =3D (unsigned long) ss_sp;
-		t->sas_ss_size =3D ss_size;
-		t->sas_ss_flags =3D ss_flags;
+		if (!ret) {
+			t->sas_ss_sp =3D (unsigned long) ss_sp;
+			t->sas_ss_size =3D ss_size;
+			t->sas_ss_flags =3D ss_flags;
+		}
+		sigaltstack_unlock();
 	}
-	return 0;
+	return ret;
 }
=20
 SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uos=
s)
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 6ee4fa882919..278bb53b325c 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -240,7 +240,7 @@ static void x86_sort_relative_table(char *extab_image, in=
t image_size)
=20
 		w(r(loc) + i, loc);
 		w(r(loc + 1) + i + 4, loc + 1);
-		w(r(loc + 2) + i + 8, loc + 2);
+		/* Don't touch the fixup type */
=20
 		i +=3D sizeof(uint32_t) * 3;
 	}
@@ -253,7 +253,7 @@ static void x86_sort_relative_table(char *extab_image, in=
t image_size)
=20
 		w(r(loc) - i, loc);
 		w(r(loc + 1) - (i + 4), loc + 1);
-		w(r(loc + 2) - (i + 8), loc + 2);
+		/* Don't touch the fixup type */
=20
 		i +=3D sizeof(uint32_t) * 3;
 	}
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x=
86/Makefile
index b4142cd1c5c2..8a1f62ab3c8e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86 test_syscall_vdso=
 unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header
+			corrupt_xstate_header amx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED :=3D ldt_gdt ptrace_syscall
=20
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/=
amx.c
new file mode 100644
index 000000000000..3615ef4a48bb
--- /dev/null
+++ b/tools/testing/selftests/x86/amx.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <pthread.h>
+#include <setjmp.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <x86intrin.h>
+
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+#define XSAVE_HDR_OFFSET	512
+#define XSAVE_HDR_SIZE		64
+
+struct xsave_buffer {
+	union {
+		struct {
+			char legacy[XSAVE_HDR_OFFSET];
+			char header[XSAVE_HDR_SIZE];
+			char extended[0];
+		};
+		char bytes[0];
+	};
+};
+
+static inline uint64_t xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv;"
+		     : "=3Da" (eax), "=3Dd" (edx)
+		     : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
+static inline void cpuid(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32=
_t *edx)
+{
+	asm volatile("cpuid;"
+		     : "=3Da" (*eax), "=3Db" (*ebx), "=3Dc" (*ecx), "=3Dd" (*edx)
+		     : "0" (*eax), "2" (*ecx));
+}
+
+static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo =3D rfbm;
+	uint32_t rfbm_hi =3D rfbm >> 32;
+
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
+		     : "memory");
+}
+
+static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo =3D rfbm;
+	uint32_t rfbm_hi =3D rfbm >> 32;
+
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
+}
+
+/* err() exits and will not return */
+#define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction =3D handler;
+	sa.sa_flags =3D SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		fatal_error("sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		fatal_error("sigaction");
+}
+
+#define XFEATURE_XTILECFG	17
+#define XFEATURE_XTILEDATA	18
+#define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
+#define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
+#define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDAT=
A)
+
+#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
+#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
+static inline void check_cpuid_xsave(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	/*
+	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
+	 * support for the XSAVE feature set, including
+	 * XGETBV.
+	 */
+	eax =3D 1;
+	ecx =3D 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
+		fatal_error("cpuid: no CPU xsave support");
+	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
+		fatal_error("cpuid: no OS xsave support");
+}
+
+static uint32_t xbuf_size;
+
+static struct {
+	uint32_t xbuf_offset;
+	uint32_t size;
+} xtiledata;
+
+#define CPUID_LEAF_XSTATE		0xd
+#define CPUID_SUBLEAF_XSTATE_USER	0x0
+#define TILE_CPUID			0x1d
+#define TILE_PALETTE_ID			0x1
+
+static void check_cpuid_xtiledata(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	eax =3D CPUID_LEAF_XSTATE;
+	ecx =3D CPUID_SUBLEAF_XSTATE_USER;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/*
+	 * EBX enumerates the size (in bytes) required by the XSAVE
+	 * instruction for an XSAVE area containing all the user state
+	 * components corresponding to bits currently set in XCR0.
+	 *
+	 * Stash that off so it can be used to allocate buffers later.
+	 */
+	xbuf_size =3D ebx;
+
+	eax =3D CPUID_LEAF_XSTATE;
+	ecx =3D XFEATURE_XTILEDATA;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	/*
+	 * eax: XTILEDATA state component size
+	 * ebx: XTILEDATA state component offset in user buffer
+	 */
+	if (!eax || !ebx)
+		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
+				eax, ebx);
+
+	xtiledata.size	      =3D eax;
+	xtiledata.xbuf_offset =3D ebx;
+}
+
+/* The helpers for managing XSAVE buffer and tile states: */
+
+struct xsave_buffer *alloc_xbuf(void)
+{
+	struct xsave_buffer *xbuf;
+
+	/* XSAVE buffer should be 64B-aligned. */
+	xbuf =3D aligned_alloc(64, xbuf_size);
+	if (!xbuf)
+		fatal_error("aligned_alloc()");
+	return xbuf;
+}
+
+static inline void clear_xstate_header(struct xsave_buffer *buffer)
+{
+	memset(&buffer->header, 0, sizeof(buffer->header));
+}
+
+static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
+{
+	/* XSTATE_BV is at the beginning of the header: */
+	return *(uint64_t *)&buffer->header;
+}
+
+static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
+{
+	/* XSTATE_BV is at the beginning of the header: */
+	*(uint64_t *)(&buffer->header) =3D bv;
+}
+
+static void set_rand_tiledata(struct xsave_buffer *xbuf)
+{
+	int *ptr =3D (int *)&xbuf->bytes[xtiledata.xbuf_offset];
+	int data;
+	int i;
+
+	/*
+	 * Ensure that 'data' is never 0.  This ensures that
+	 * the registers are never in their initial configuration
+	 * and thus never tracked as being in the init state.
+	 */
+	data =3D rand() | 1;
+
+	for (i =3D 0; i < xtiledata.size / sizeof(int); i++, ptr++)
+		*ptr =3D data;
+}
+
+struct xsave_buffer *stashed_xsave;
+
+static void init_stashed_xsave(void)
+{
+	stashed_xsave =3D alloc_xbuf();
+	if (!stashed_xsave)
+		fatal_error("failed to allocate stashed_xsave\n");
+	clear_xstate_header(stashed_xsave);
+}
+
+static void free_stashed_xsave(void)
+{
+	free(stashed_xsave);
+}
+
+/* See 'struct _fpx_sw_bytes' at sigcontext.h */
+#define SW_BYTES_OFFSET		464
+/* N.B. The struct's field name varies so read from the offset. */
+#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
+
+static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *buffer)
+{
+	return (struct _fpx_sw_bytes *)(buffer + SW_BYTES_OFFSET);
+}
+
+static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
+{
+	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
+}
+
+/* Work around printf() being unsafe in signals: */
+#define SIGNAL_BUF_LEN 1000
+char signal_message_buffer[SIGNAL_BUF_LEN];
+void sig_print(char *msg)
+{
+	int left =3D SIGNAL_BUF_LEN - strlen(signal_message_buffer) - 1;
+
+	strncat(signal_message_buffer, msg, left);
+}
+
+static volatile bool noperm_signaled;
+static int noperm_errs;
+/*
+ * Signal handler for when AMX is used but
+ * permission has not been obtained.
+ */
+static void handle_noperm(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
+	void *xbuf =3D ctx->uc_mcontext.fpregs;
+	struct _fpx_sw_bytes *sw_bytes;
+	uint64_t features;
+
+	/* Reset the signal message buffer: */
+	signal_message_buffer[0] =3D '\0';
+	sig_print("\tAt SIGILL handler,\n");
+
+	if (si->si_code !=3D ILL_ILLOPC) {
+		noperm_errs++;
+		sig_print("[FAIL]\tInvalid signal code.\n");
+	} else {
+		sig_print("[OK]\tValid signal code (ILL_ILLOPC).\n");
+	}
+
+	sw_bytes =3D get_fpx_sw_bytes(xbuf);
+	/*
+	 * Without permission, the signal XSAVE buffer should not
+	 * have room for AMX register state (aka. xtiledata).
+	 * Check that the size does not overlap with where xtiledata
+	 * will reside.
+	 *
+	 * This also implies that no state components *PAST*
+	 * XTILEDATA (features >=3D19) can be present in the buffer.
+	 */
+	if (sw_bytes->xstate_size <=3D xtiledata.xbuf_offset) {
+		sig_print("[OK]\tValid xstate size\n");
+	} else {
+		noperm_errs++;
+		sig_print("[FAIL]\tInvalid xstate size\n");
+	}
+
+	features =3D get_fpx_sw_bytes_features(xbuf);
+	/*
+	 * Without permission, the XTILEDATA feature
+	 * bit should not be set.
+	 */
+	if ((features & XFEATURE_MASK_XTILEDATA) =3D=3D 0) {
+		sig_print("[OK]\tValid xstate mask\n");
+	} else {
+		noperm_errs++;
+		sig_print("[FAIL]\tInvalid xstate mask\n");
+	}
+
+	noperm_signaled =3D true;
+	ctx->uc_mcontext.gregs[REG_RIP] +=3D 3; /* Skip the faulting XRSTOR */
+}
+
+/* Return true if XRSTOR is successful; otherwise, false. */
+static inline bool xrstor_safe(struct xsave_buffer *xbuf, uint64_t mask)
+{
+	noperm_signaled =3D false;
+	xrstor(xbuf, mask);
+
+	/* Print any messages produced by the signal code: */
+	printf("%s", signal_message_buffer);
+	/*
+	 * Reset the buffer to make sure any future printing
+	 * only outputs new messages:
+	 */
+	signal_message_buffer[0] =3D '\0';
+
+	if (noperm_errs)
+		fatal_error("saw %d errors in noperm signal handler\n", noperm_errs);
+
+	return !noperm_signaled;
+}
+
+/*
+ * Use XRSTOR to populate the XTILEDATA registers with
+ * random data.
+ *
+ * Return true if successful; otherwise, false.
+ */
+static inline bool load_rand_tiledata(struct xsave_buffer *xbuf)
+{
+	clear_xstate_header(xbuf);
+	set_xstatebv(xbuf, XFEATURE_MASK_XTILEDATA);
+	set_rand_tiledata(xbuf);
+	return xrstor_safe(xbuf, XFEATURE_MASK_XTILEDATA);
+}
+
+/* Return XTILEDATA to its initial configuration. */
+static inline void init_xtiledata(void)
+{
+	clear_xstate_header(stashed_xsave);
+	xrstor_safe(stashed_xsave, XFEATURE_MASK_XTILEDATA);
+}
+
+enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
+
+/* arch_prctl() and sigaltstack() test */
+
+#define ARCH_GET_XCOMP_PERM	0x1022
+#define ARCH_REQ_XCOMP_PERM	0x1023
+
+static void req_xtiledata_perm(void)
+{
+	syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
+}
+
+static void validate_req_xcomp_perm(enum expected_result exp)
+{
+	unsigned long bitmask;
+	long rc;
+
+	rc =3D syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
+	if (exp =3D=3D FAIL_EXPECTED) {
+		if (rc) {
+			printf("[OK]\tARCH_REQ_XCOMP_PERM saw expected failure..\n");
+			return;
+		}
+
+		fatal_error("ARCH_REQ_XCOMP_PERM saw unexpected success.\n");
+	} else if (rc) {
+		fatal_error("ARCH_REQ_XCOMP_PERM saw unexpected failure.\n");
+	}
+
+	rc =3D syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
+	if (rc) {
+		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
+	} else if (bitmask & XFEATURE_MASK_XTILE) {
+		printf("\tARCH_REQ_XCOMP_PERM is successful.\n");
+	}
+}
+
+static void validate_xcomp_perm(enum expected_result exp)
+{
+	bool load_success =3D load_rand_tiledata(stashed_xsave);
+
+	if (exp =3D=3D FAIL_EXPECTED) {
+		if (load_success) {
+			noperm_errs++;
+			printf("[FAIL]\tLoad tiledata succeeded.\n");
+		} else {
+			printf("[OK]\tLoad tiledata failed.\n");
+		}
+	} else if (exp =3D=3D SUCCESS_EXPECTED) {
+		if (load_success) {
+			printf("[OK]\tLoad tiledata succeeded.\n");
+		} else {
+			noperm_errs++;
+			printf("[FAIL]\tLoad tiledata failed.\n");
+		}
+	}
+}
+
+#ifndef AT_MINSIGSTKSZ
+#  define AT_MINSIGSTKSZ	51
+#endif
+
+static void *alloc_altstack(unsigned int size)
+{
+	void *altstack;
+
+	altstack =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+
+	if (altstack =3D=3D MAP_FAILED)
+		fatal_error("mmap() for altstack");
+
+	return altstack;
+}
+
+static void setup_altstack(void *addr, unsigned long size, enum expected_res=
ult exp)
+{
+	stack_t ss;
+	int rc;
+
+	memset(&ss, 0, sizeof(ss));
+	ss.ss_size =3D size;
+	ss.ss_sp =3D addr;
+
+	rc =3D sigaltstack(&ss, NULL);
+
+	if (exp =3D=3D FAIL_EXPECTED) {
+		if (rc) {
+			printf("[OK]\tsigaltstack() failed.\n");
+		} else {
+			fatal_error("sigaltstack() succeeded unexpectedly.\n");
+		}
+	} else if (rc) {
+		fatal_error("sigaltstack()");
+	}
+}
+
+static void test_dynamic_sigaltstack(void)
+{
+	unsigned int small_size, enough_size;
+	unsigned long minsigstksz;
+	void *altstack;
+
+	minsigstksz =3D getauxval(AT_MINSIGSTKSZ);
+	printf("\tAT_MINSIGSTKSZ =3D %lu\n", minsigstksz);
+	/*
+	 * getauxval() itself can return 0 for failure or
+	 * success.  But, in this case, AT_MINSIGSTKSZ
+	 * will always return a >=3D0 value if implemented.
+	 * Just check for 0.
+	 */
+	if (minsigstksz =3D=3D 0) {
+		printf("no support for AT_MINSIGSTKSZ, skipping sigaltstack tests\n");
+		return;
+	}
+
+	enough_size =3D minsigstksz * 2;
+
+	altstack =3D alloc_altstack(enough_size);
+	printf("\tAllocate memory for altstack (%u bytes).\n", enough_size);
+
+	/*
+	 * Try setup_altstack() with a size which can not fit
+	 * XTILEDATA.  ARCH_REQ_XCOMP_PERM should fail.
+	 */
+	small_size =3D minsigstksz - xtiledata.size;
+	printf("\tAfter sigaltstack() with small size (%u bytes).\n", small_size);
+	setup_altstack(altstack, small_size, SUCCESS_EXPECTED);
+	validate_req_xcomp_perm(FAIL_EXPECTED);
+
+	/*
+	 * Try setup_altstack() with a size derived from
+	 * AT_MINSIGSTKSZ.  It should be more than large enough
+	 * and thus ARCH_REQ_XCOMP_PERM should succeed.
+	 */
+	printf("\tAfter sigaltstack() with enough size (%u bytes).\n", enough_size);
+	setup_altstack(altstack, enough_size, SUCCESS_EXPECTED);
+	validate_req_xcomp_perm(SUCCESS_EXPECTED);
+
+	/*
+	 * Try to coerce setup_altstack() to again accept a
+	 * too-small altstack.  This ensures that big-enough
+	 * sigaltstacks can not shrink to a too-small value
+	 * once XTILEDATA permission is established.
+	 */
+	printf("\tThen, sigaltstack() with small size (%u bytes).\n", small_size);
+	setup_altstack(altstack, small_size, FAIL_EXPECTED);
+}
+
+static void test_dynamic_state(void)
+{
+	pid_t parent, child, grandchild;
+
+	parent =3D fork();
+	if (parent < 0) {
+		/* fork() failed */
+		fatal_error("fork");
+	} else if (parent > 0) {
+		int status;
+		/* fork() succeeded.  Now in the parent. */
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			fatal_error("arch_prctl test parent exit");
+		return;
+	}
+	/* fork() succeeded.  Now in the child . */
+
+	printf("[RUN]\tCheck ARCH_REQ_XCOMP_PERM around process fork() and sigaltac=
k() test.\n");
+
+	printf("\tFork a child.\n");
+	child =3D fork();
+	if (child < 0) {
+		fatal_error("fork");
+	} else if (child > 0) {
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			fatal_error("arch_prctl test child exit");
+		_exit(0);
+	}
+
+	/*
+	 * The permission request should fail without an
+	 * XTILEDATA-compatible signal stack
+	 */
+	printf("\tTest XCOMP_PERM at child.\n");
+	validate_xcomp_perm(FAIL_EXPECTED);
+
+	/*
+	 * Set up an XTILEDATA-compatible signal stack and
+	 * also obtain permission to populate XTILEDATA.
+	 */
+	printf("\tTest dynamic sigaltstack at child:\n");
+	test_dynamic_sigaltstack();
+
+	/* Ensure that XTILEDATA can be populated. */
+	printf("\tTest XCOMP_PERM again at child.\n");
+	validate_xcomp_perm(SUCCESS_EXPECTED);
+
+	printf("\tFork a grandchild.\n");
+	grandchild =3D fork();
+	if (grandchild < 0) {
+		/* fork() failed */
+		fatal_error("fork");
+	} else if (!grandchild) {
+		/* fork() succeeded.  Now in the (grand)child. */
+		printf("\tTest XCOMP_PERM at grandchild.\n");
+
+		/*
+		 * Ensure that the grandchild inherited
+		 * permission and a compatible sigaltstack:
+		 */
+		validate_xcomp_perm(SUCCESS_EXPECTED);
+	} else {
+		int status;
+		/* fork() succeeded.  Now in the parent. */
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			fatal_error("fork test grandchild");
+	}
+
+	_exit(0);
+}
+
+/*
+ * Save current register state and compare it to @xbuf1.'
+ *
+ * Returns false if @xbuf1 matches the registers.
+ * Returns true  if @xbuf1 differs from the registers.
+ */
+static inline bool __validate_tiledata_regs(struct xsave_buffer *xbuf1)
+{
+	struct xsave_buffer *xbuf2;
+	int ret;
+
+	xbuf2 =3D alloc_xbuf();
+	if (!xbuf2)
+		fatal_error("failed to allocate XSAVE buffer\n");
+
+	xsave(xbuf2, XFEATURE_MASK_XTILEDATA);
+	ret =3D memcmp(&xbuf1->bytes[xtiledata.xbuf_offset],
+		     &xbuf2->bytes[xtiledata.xbuf_offset],
+		     xtiledata.size);
+
+	free(xbuf2);
+
+	if (ret =3D=3D 0)
+		return false;
+	return true;
+}
+
+static inline void validate_tiledata_regs_same(struct xsave_buffer *xbuf)
+{
+	int ret =3D __validate_tiledata_regs(xbuf);
+
+	if (ret !=3D 0)
+		fatal_error("TILEDATA registers changed");
+}
+
+static inline void validate_tiledata_regs_changed(struct xsave_buffer *xbuf)
+{
+	int ret =3D __validate_tiledata_regs(xbuf);
+
+	if (ret =3D=3D 0)
+		fatal_error("TILEDATA registers did not change");
+}
+
+/* tiledata inheritance test */
+
+static void test_fork(void)
+{
+	pid_t child, grandchild;
+
+	child =3D fork();
+	if (child < 0) {
+		/* fork() failed */
+		fatal_error("fork");
+	} else if (child > 0) {
+		/* fork() succeeded.  Now in the parent. */
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			fatal_error("fork test child");
+		return;
+	}
+	/* fork() succeeded.  Now in the child. */
+	printf("[RUN]\tCheck tile data inheritance.\n\tBefore fork(), load tiledata=
\n");
+
+	load_rand_tiledata(stashed_xsave);
+
+	grandchild =3D fork();
+	if (grandchild < 0) {
+		/* fork() failed */
+		fatal_error("fork");
+	} else if (grandchild > 0) {
+		/* fork() succeeded.  Still in the first child. */
+		int status;
+
+		wait(&status);
+		if (!WIFEXITED(status) || WEXITSTATUS(status))
+			fatal_error("fork test grand child");
+		_exit(0);
+	}
+	/* fork() succeeded.  Now in the (grand)child. */
+
+	/*
+	 * TILEDATA registers are not preserved across fork().
+	 * Ensure that their value has changed:
+	 */
+	validate_tiledata_regs_changed(stashed_xsave);
+
+	_exit(0);
+}
+
+/* Context switching test */
+
+static struct _ctxtswtest_cfg {
+	unsigned int iterations;
+	unsigned int num_threads;
+} ctxtswtest_config;
+
+struct futex_info {
+	pthread_t thread;
+	int nr;
+	pthread_mutex_t mutex;
+	struct futex_info *next;
+};
+
+static void *check_tiledata(void *info)
+{
+	struct futex_info *finfo =3D (struct futex_info *)info;
+	struct xsave_buffer *xbuf;
+	int i;
+
+	xbuf =3D alloc_xbuf();
+	if (!xbuf)
+		fatal_error("unable to allocate XSAVE buffer");
+
+	/*
+	 * Load random data into 'xbuf' and then restore
+	 * it to the tile registers themselves.
+	 */
+	load_rand_tiledata(xbuf);
+	for (i =3D 0; i < ctxtswtest_config.iterations; i++) {
+		pthread_mutex_lock(&finfo->mutex);
+
+		/*
+		 * Ensure the register values have not
+		 * diverged from those recorded in 'xbuf'.
+		 */
+		validate_tiledata_regs_same(xbuf);
+
+		/* Load new, random values into xbuf and registers */
+		load_rand_tiledata(xbuf);
+
+		/*
+		 * The last thread's last unlock will be for
+		 * thread 0's mutex.  However, thread 0 will
+		 * have already exited the loop and the mutex
+		 * will already be unlocked.
+		 *
+		 * Because this is not an ERRORCHECK mutex,
+		 * that inconsistency will be silently ignored.
+		 */
+		pthread_mutex_unlock(&finfo->next->mutex);
+	}
+
+	free(xbuf);
+	/*
+	 * Return this thread's finfo, which is
+	 * a unique value for this thread.
+	 */
+	return finfo;
+}
+
+static int create_threads(int num, struct futex_info *finfo)
+{
+	int i;
+
+	for (i =3D 0; i < num; i++) {
+		int next_nr;
+
+		finfo[i].nr =3D i;
+		/*
+		 * Thread 'i' will wait on this mutex to
+		 * be unlocked.  Lock it immediately after
+		 * initialization:
+		 */
+		pthread_mutex_init(&finfo[i].mutex, NULL);
+		pthread_mutex_lock(&finfo[i].mutex);
+
+		next_nr =3D (i + 1) % num;
+		finfo[i].next =3D &finfo[next_nr];
+
+		if (pthread_create(&finfo[i].thread, NULL, check_tiledata, &finfo[i]))
+			fatal_error("pthread_create()");
+	}
+	return 0;
+}
+
+static void affinitize_cpu0(void)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) !=3D 0)
+		fatal_error("sched_setaffinity to CPU 0");
+}
+
+static void test_context_switch(void)
+{
+	struct futex_info *finfo;
+	int i;
+
+	/* Affinitize to one CPU to force context switches */
+	affinitize_cpu0();
+
+	req_xtiledata_perm();
+
+	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\=
n",
+	       ctxtswtest_config.iterations,
+	       ctxtswtest_config.num_threads);
+
+
+	finfo =3D malloc(sizeof(*finfo) * ctxtswtest_config.num_threads);
+	if (!finfo)
+		fatal_error("malloc()");
+
+	create_threads(ctxtswtest_config.num_threads, finfo);
+
+	/*
+	 * This thread wakes up thread 0
+	 * Thread 0 will wake up 1
+	 * Thread 1 will wake up 2
+	 * ...
+	 * the last thread will wake up 0
+	 *
+	 * ... this will repeat for the configured
+	 * number of iterations.
+	 */
+	pthread_mutex_unlock(&finfo[0].mutex);
+
+	/* Wait for all the threads to finish: */
+	for (i =3D 0; i < ctxtswtest_config.num_threads; i++) {
+		void *thread_retval;
+		int rc;
+
+		rc =3D pthread_join(finfo[i].thread, &thread_retval);
+
+		if (rc)
+			fatal_error("pthread_join() failed for thread %d err: %d\n",
+					i, rc);
+
+		if (thread_retval !=3D &finfo[i])
+			fatal_error("unexpected thread retval for thread %d: %p\n",
+					i, thread_retval);
+
+	}
+
+	printf("[OK]\tNo incorrect case was found.\n");
+
+	free(finfo);
+}
+
+int main(void)
+{
+	/* Check hardware availability at first */
+	check_cpuid_xsave();
+	check_cpuid_xtiledata();
+
+	init_stashed_xsave();
+	sethandler(SIGILL, handle_noperm, 0);
+
+	test_dynamic_state();
+
+	/* Request permission for the following tests */
+	req_xtiledata_perm();
+
+	test_fork();
+
+	ctxtswtest_config.iterations =3D 10;
+	ctxtswtest_config.num_threads =3D 5;
+	test_context_switch();
+
+	clearhandler(SIGILL);
+	free_stashed_xsave();
+
+	return 0;
+}

