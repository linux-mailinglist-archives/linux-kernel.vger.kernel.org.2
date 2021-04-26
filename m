Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5836B4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhDZO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhDZO15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:27:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC786052B;
        Mon, 26 Apr 2021 14:27:14 +0000 (UTC)
Date:   Mon, 26 Apr 2021 15:27:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.13-rc1
Message-ID: <20210426142710.GA10892@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below for 5.13. Apart from the usual arm64
and perf stuff, the MTE changes touch the kasan code under mm/ (acked by
the kasan maintainers). There is a minor conflicts with v5.12 due to
a fix that went in a late -rc stage. I included my resolution after the
diffstat below, though the only one not automatically resolved is in
arch/arm64/include/asm/cpucaps.h.

Thanks.

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to a27a8816568964fcef62a3ae5f9d2228ec1ebc68:

  Merge branch 'for-next/pac-set-get-enabled-keys' into for-next/core (2021-04-15 14:00:48 +0100)

----------------------------------------------------------------
arm64 updates for 5.13:

- MTE asynchronous support for KASan. Previously only synchronous
  (slower) mode was supported. Asynchronous is faster but does not allow
  precise identification of the illegal access.

- Run kernel mode SIMD with softirqs disabled. This allows using NEON in
  softirq context for crypto performance improvements. The conditional
  yield support is modified to take softirqs into account and reduce the
  latency.

- Preparatory patches for Apple M1: handle CPUs that only have the VHE
  mode available (host kernel running at EL2), add FIQ support.

- arm64 perf updates: support for HiSilicon PA and SLLC PMU drivers, new
  functions for the HiSilicon HHA and L3C PMU, cleanups.

- Re-introduce support for execute-only user permissions but only when
  the EPAN (Enhanced Privileged Access Never) architecture feature is
  available.

- Disable fine-grained traps at boot and improve the documented boot
  requirements.

- Support CONFIG_KASAN_VMALLOC on arm64 (only with KASAN_GENERIC).

- Add hierarchical eXecute Never permissions for all page tables.

- Add arm64 prctl(PR_PAC_{SET,GET}_ENABLED_KEYS) allowing user programs
  to control which PAC keys are enabled in a particular task.

- arm64 kselftests for BTI and some improvements to the MTE tests.

- Minor improvements to the compat vdso and sigpage.

- Miscellaneous cleanups.

----------------------------------------------------------------
Andre Przywara (11):
      kselftest/arm64: mte: Fix compilation with native compiler
      kselftest/arm64: mte: Fix pthread linking
      kselftest/arm64: mte: ksm_options: Fix fscanf warning
      kselftest/arm64: mte: user_mem: Fix write() warning
      kselftest/arm64: mte: common: Fix write() warnings
      kselftest/arm64: mte: Fix MTE feature detection
      kselftest/arm64: mte: Use cross-compiler if specified
      kselftest/arm64: mte: Output warning about failing compiler
      kselftest/arm64: mte: Makefile: Fix clang compilation
      kselftest/arm64: mte: Fix clang warning
      kselftest/arm64: mte: Report filename on failing temp file creation

Andrey Konovalov (1):
      kasan, arm64: tests supports for HW_TAGS async mode

Ard Biesheuvel (6):
      arm64: mm: add missing P4D definitions and use them consistently
      arm64: mm: use XN table mapping attributes for the linear region
      arm64: mm: use XN table mapping attributes for user/kernel mappings
      arm64: assembler: remove conditional NEON yield macros
      arm64: assembler: introduce wxN aliases for wN registers
      arm64: fpsimd: run kernel mode NEON with softirqs disabled

Catalin Marinas (3):
      Merge branches 'for-next/misc', 'for-next/kselftest', 'for-next/xntable', 'for-next/vdso', 'for-next/fiq', 'for-next/epan', 'for-next/kasan-vmalloc', 'for-next/fgt-boot-init', 'for-next/vhe-only' and 'for-next/neon-softirqs-disabled', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/mte-async-kernel-mode' into for-next/core
      Merge branch 'for-next/pac-set-get-enabled-keys' into for-next/core

Chen Lifu (1):
      arm64: smp: Add missing prototype for some smp.c functions

He Ying (1):
      docs: arm64: Fix a grammar error

Hector Martin (1):
      arm64: Always keep DAIF.[IF] in sync

Jisheng Zhang (1):
      arm64: Add __init section marker to some functions

Lecopzer Chen (5):
      arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
      arm64: kasan: abstract _text and _end to KERNEL_START/END
      arm64: Kconfig: support CONFIG_KASAN_VMALLOC
      arm64: kaslr: support randomized module area with KASAN_VMALLOC
      arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled

Linus Walleij (1):
      arm64: barrier: Remove spec_bar() macro

Marc Zyngier (6):
      genirq: Allow architectures to override set_handle_irq() fallback
      arm64: don't use GENERIC_IRQ_MULTI_HANDLER
      arm64: entry: factor irq triage logic into macros
      arm64: cpufeature: Allow early filtering of feature override
      arm64: Cope with CPUs stuck in VHE mode
      arm64: Get rid of CONFIG_ARM64_VHE

Mark Brown (9):
      arm64: defconfig: Use DEBUG_INFO_REDUCED
      kselftest: arm64: Add BTI tests
      arm64: stacktrace: Move start_backtrace() out of the header
      arm64/sve: Rework SVE access trap to convert state in registers
      arm64: Document requirements for fine grained traps at boot
      arm64: Disable fine grained traps on boot
      arm64: Require that system registers at all visible ELs be initialized
      arm64/sve: Remove redundant system_supports_sve() tests
      arm64/sve: Add compile time checks for SVE hooks in generic functions

Mark Rutland (5):
      arm64: irq: rework root IRQ handler registration
      arm64: irq: allow FIQs to be handled
      arm64: entry: remove test_irqs_unmasked macro
      arm64: setup: name `mair` register
      arm64: setup: name `tcr` register

Peter Collingbourne (3):
      arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
      arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
      arm64: pac: Optimize kernel entry/exit key installation code paths

Qi Liu (5):
      drivers/perf: convert sysfs scnprintf family to sysfs_emit_at() and sysfs_emit()
      drivers/perf: convert sysfs sprintf family to sysfs_emit
      drivers/perf: Simplify the SMMUv3 PMU event attributes
      docs: perf: Address some html build warnings
      arm64: perf: Remove redundant initialization in perf_event.c

Robin Murphy (3):
      perf/arm_pmu_platform: Use dev_err_probe() for IRQ errors
      perf/arm_pmu_platform: Fix error handling
      perf/arm_pmu_platform: Clean up with dev_printk

Shaokun Zhang (9):
      drivers/perf: hisi: Remove unnecessary check of counter index
      drivers/perf: hisi: Refactor code for more uncore PMUs
      drivers/perf: hisi: Add PMU version for uncore PMU drivers.
      drivers/perf: hisi: Add new functions for L3C PMU
      drivers/perf: hisi: Add new functions for HHA PMU
      drivers/perf: hisi: Update DDRC PMU for programmable counter
      drivers/perf: hisi: Add support for HiSilicon SLLC PMU driver
      drivers/perf: hisi: Add support for HiSilicon PA PMU driver
      docs: perf: Add new description on HiSilicon uncore PMU v2

Vincenzo Frascino (9):
      arm64: mte: Remove unused mte_assign_mem_tag_range()
      arm64: mte: Add asynchronous mode support
      kasan: Add KASAN mode kernel parameter
      arm64: mte: Drop arch_enable_tagging()
      kasan: Add report for async mode
      arm64: mte: Enable TCO in functions that can read beyond buffer limits
      arm64: mte: Conditionally compile mte_enable_kernel_*()
      arm64: mte: Enable async tag check fault
      arm64: mte: Report async tag faults before suspend

Vladimir Murzin (1):
      arm64: Support execute-only permissions with Enhanced PAN

Will Deacon (5):
      arm64: vdso: Use GFP_KERNEL for allocating compat vdso and signal pages
      arm64: vdso: Remove redundant calls to flush_dcache_page()
      arm64: compat: Allow signal page to be remapped
      arm64: vdso: Avoid ISB after reading from cntvct_el0
      arm64: compat: Poison the compat sigpage

Yury Norov (1):
      ARM64: enable GENERIC_FIND_FIRST_BIT

Zihao Tang (1):
      drivers/perf: convert sysfs snprintf family to sysfs_emit

zhouchuangao (1):
      arm64/kernel/probes: Use BUG_ON instead of if condition followed by BUG.

 Documentation/admin-guide/kernel-parameters.txt    |   3 +-
 Documentation/admin-guide/perf/hisi-pmu.rst        |  54 +++
 Documentation/arm64/booting.rst                    |  13 +-
 Documentation/arm64/pointer-authentication.rst     |  34 ++
 Documentation/arm64/tagged-address-abi.rst         |   2 +-
 Documentation/dev-tools/kasan.rst                  |   9 +
 arch/arm64/Kconfig                                 |  41 +-
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/crypto/aes-modes.S                      |   2 +-
 arch/arm64/crypto/sha1-ce-core.S                   |   2 +-
 arch/arm64/crypto/sha2-ce-core.S                   |   2 +-
 arch/arm64/crypto/sha3-ce-core.S                   |   4 +-
 arch/arm64/crypto/sha512-ce-core.S                 |   2 +-
 arch/arm64/include/asm/arch_gicv3.h                |   2 +-
 arch/arm64/include/asm/arch_timer.h                |  21 -
 arch/arm64/include/asm/asm_pointer_auth.h          |  20 +-
 arch/arm64/include/asm/assembler.h                 | 114 ++---
 arch/arm64/include/asm/barrier.h                   |  23 +-
 arch/arm64/include/asm/cpucaps.h                   |   3 +-
 arch/arm64/include/asm/cpufeature.h                |  17 +
 arch/arm64/include/asm/daifflags.h                 |  10 +-
 arch/arm64/include/asm/el2_setup.h                 |  21 +
 arch/arm64/include/asm/fpsimd.h                    |   1 +
 arch/arm64/include/asm/irq.h                       |   4 +
 arch/arm64/include/asm/irq_work.h                  |   2 +
 arch/arm64/include/asm/irqflags.h                  |  16 +-
 arch/arm64/include/asm/memory.h                    |   4 +-
 arch/arm64/include/asm/mte-kasan.h                 |   9 +-
 arch/arm64/include/asm/mte.h                       |  54 ++-
 arch/arm64/include/asm/pgalloc.h                   |  19 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |  15 +
 arch/arm64/include/asm/pgtable-prot.h              |   5 +-
 arch/arm64/include/asm/pgtable.h                   |  31 +-
 arch/arm64/include/asm/pointer_auth.h              |  61 ++-
 arch/arm64/include/asm/processor.h                 |  13 +-
 arch/arm64/include/asm/ptdump.h                    |   2 +-
 arch/arm64/include/asm/smp.h                       |   1 +
 arch/arm64/include/asm/stacktrace.h                |  24 +-
 arch/arm64/include/asm/sysreg.h                    |  13 +-
 arch/arm64/include/asm/uaccess.h                   |  22 +
 arch/arm64/include/asm/vdso/gettimeofday.h         |   6 +-
 arch/arm64/include/asm/word-at-a-time.h            |   4 +
 arch/arm64/kernel/asm-offsets.c                    |   7 +-
 arch/arm64/kernel/cpufeature.c                     |  22 +-
 arch/arm64/kernel/entry-common.c                   |   6 +
 arch/arm64/kernel/entry-fpsimd.S                   |   5 +
 arch/arm64/kernel/entry.S                          | 174 ++++---
 arch/arm64/kernel/fpsimd.c                         |  39 +-
 arch/arm64/kernel/head.S                           |  39 +-
 arch/arm64/kernel/hyp-stub.S                       |  10 +-
 arch/arm64/kernel/idreg-override.c                 |  26 +-
 arch/arm64/kernel/irq.c                            |  35 +-
 arch/arm64/kernel/kaslr.c                          |  18 +-
 arch/arm64/kernel/module.c                         |  16 +-
 arch/arm64/kernel/mte.c                            | 121 +++--
 arch/arm64/kernel/perf_event.c                     |   5 +-
 arch/arm64/kernel/pointer_auth.c                   |  63 +++
 arch/arm64/kernel/probes/kprobes.c                 |   3 +-
 arch/arm64/kernel/process.c                        |  35 +-
 arch/arm64/kernel/ptrace.c                         |  41 ++
 arch/arm64/kernel/smp.c                            |   1 +
 arch/arm64/kernel/stacktrace.c                     |  24 +
 arch/arm64/kernel/suspend.c                        |   6 +-
 arch/arm64/kernel/vdso.c                           |  26 +-
 arch/arm64/mm/fault.c                              |  18 +-
 arch/arm64/mm/kasan_init.c                         |  29 +-
 arch/arm64/mm/mmu.c                                |  41 +-
 arch/arm64/mm/proc.S                               |  48 +-
 arch/arm64/mm/ptdump.c                             |   4 +-
 arch/arm64/mm/ptdump_debugfs.c                     |   2 +-
 drivers/perf/arm-cci.c                             |  12 +-
 drivers/perf/arm-ccn.c                             |  31 +-
 drivers/perf/arm-cmn.c                             |  22 +-
 drivers/perf/arm_dmc620_pmu.c                      |   2 +-
 drivers/perf/arm_dsu_pmu.c                         |   5 +-
 drivers/perf/arm_pmu_platform.c                    |  54 +--
 drivers/perf/arm_smmuv3_pmu.c                      |  36 +-
 drivers/perf/arm_spe_pmu.c                         |   3 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |   7 +-
 drivers/perf/hisilicon/Makefile                    |   3 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      | 348 +++++++++-----
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       | 301 ++++++++----
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       | 355 ++++++++++----
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        | 500 +++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |  79 ++-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |  20 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      | 530 +++++++++++++++++++++
 drivers/perf/qcom_l2_pmu.c                         |   2 +-
 drivers/perf/qcom_l3_pmu.c                         |   4 +-
 drivers/perf/thunderx2_pmu.c                       |   4 +-
 drivers/perf/xgene_pmu.c                           |   4 +-
 include/linux/cpuhotplug.h                         |   2 +
 include/linux/irq.h                                |   2 +
 include/linux/kasan.h                              |   6 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |   4 +
 kernel/sys.c                                       |  16 +
 lib/test_kasan.c                                   |  19 +-
 mm/kasan/hw_tags.c                                 |  66 ++-
 mm/kasan/kasan.h                                   |  40 +-
 mm/kasan/report.c                                  |  22 +-
 mm/mmap.c                                          |   6 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/bti/.gitignore       |   2 +
 tools/testing/selftests/arm64/bti/Makefile         |  61 +++
 tools/testing/selftests/arm64/bti/assembler.h      |  80 ++++
 tools/testing/selftests/arm64/bti/btitest.h        |  23 +
 tools/testing/selftests/arm64/bti/compiler.h       |  21 +
 tools/testing/selftests/arm64/bti/gen/.gitignore   |   2 +
 tools/testing/selftests/arm64/bti/signal.c         |  37 ++
 tools/testing/selftests/arm64/bti/signal.h         |  21 +
 tools/testing/selftests/arm64/bti/start.S          |  14 +
 tools/testing/selftests/arm64/bti/syscall.S        |  23 +
 tools/testing/selftests/arm64/bti/system.c         |  22 +
 tools/testing/selftests/arm64/bti/system.h         |  28 ++
 tools/testing/selftests/arm64/bti/test.c           | 234 +++++++++
 tools/testing/selftests/arm64/bti/teststubs.S      |  39 ++
 tools/testing/selftests/arm64/bti/trampoline.S     |  29 ++
 tools/testing/selftests/arm64/mte/Makefile         |  15 +-
 .../selftests/arm64/mte/check_ksm_options.c        |   5 +-
 tools/testing/selftests/arm64/mte/check_user_mem.c |   3 +-
 .../testing/selftests/arm64/mte/mte_common_util.c  |  39 +-
 122 files changed, 3862 insertions(+), 914 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
 create mode 100644 tools/testing/selftests/arm64/bti/.gitignore
 create mode 100644 tools/testing/selftests/arm64/bti/Makefile
 create mode 100644 tools/testing/selftests/arm64/bti/assembler.h
 create mode 100644 tools/testing/selftests/arm64/bti/btitest.h
 create mode 100644 tools/testing/selftests/arm64/bti/compiler.h
 create mode 100644 tools/testing/selftests/arm64/bti/gen/.gitignore
 create mode 100644 tools/testing/selftests/arm64/bti/signal.c
 create mode 100644 tools/testing/selftests/arm64/bti/signal.h
 create mode 100644 tools/testing/selftests/arm64/bti/start.S
 create mode 100644 tools/testing/selftests/arm64/bti/syscall.S
 create mode 100644 tools/testing/selftests/arm64/bti/system.c
 create mode 100644 tools/testing/selftests/arm64/bti/system.h
 create mode 100644 tools/testing/selftests/arm64/bti/test.c
 create mode 100644 tools/testing/selftests/arm64/bti/teststubs.S
 create mode 100644 tools/testing/selftests/arm64/bti/trampoline.S

---
diff --cc arch/arm64/include/asm/cpucaps.h
index c40f2490cd7b,9e3ec4dd56d8..b0c5eda0498f
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@@ -66,8 -66,8 +66,9 @@@
  #define ARM64_WORKAROUND_1508412		58
  #define ARM64_HAS_LDAPR				59
  #define ARM64_KVM_PROTECTED_MODE		60
 -#define ARM64_HAS_EPAN				61
 +#define ARM64_WORKAROUND_NVIDIA_CARMEL_CNP	61
++#define ARM64_HAS_EPAN				62
  
--#define ARM64_NCAPS				62
++#define ARM64_NCAPS				63
  
  #endif /* __ASM_CPUCAPS_H */
diff --cc arch/arm64/include/asm/word-at-a-time.h
index ea487218db79,c62d9fa791aa..2dcb104c645b
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@@ -53,8 -53,10 +53,10 @@@ static inline unsigned long find_zero(u
   */
  static inline unsigned long load_unaligned_zeropad(const void *addr)
  {
 -	unsigned long ret, offset;
 +	unsigned long ret, tmp;
  
+ 	__uaccess_enable_tco_async();
+ 
  	/* Load word from unaligned pointer addr */
  	asm(
  	"1:	ldr	%0, %3\n"
@@@ -73,9 -75,11 +75,11 @@@
  	"	b	2b\n"
  	"	.popsection\n"
  	_ASM_EXTABLE(1b, 3b)
 -	: "=&r" (ret), "=&r" (offset)
 +	: "=&r" (ret), "=&r" (tmp)
  	: "r" (addr), "Q" (*(unsigned long *)addr));
  
+ 	__uaccess_disable_tco_async();
+ 
  	return ret;
  }
  
diff --cc arch/arm64/kernel/entry.S
index 6acfc5e6b5e0,2df32a516ffe..4ac5455c0ead
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@@ -246,10 -244,32 +246,32 @@@ alternative_else_nop_endi
  	disable_step_tsk x19, x20
  
  	/* Check for asynchronous tag check faults in user space */
 -	check_mte_async_tcf x19, x22
 +	check_mte_async_tcf x22, x23
  	apply_ssbd 1, x22, x23
  
- 	ptrauth_keys_install_kernel tsk, x20, x22, x23
+ #ifdef CONFIG_ARM64_PTR_AUTH
+ alternative_if ARM64_HAS_ADDRESS_AUTH
+ 	/*
+ 	 * Enable IA for in-kernel PAC if the task had it disabled. Although
+ 	 * this could be implemented with an unconditional MRS which would avoid
+ 	 * a load, this was measured to be slower on Cortex-A75 and Cortex-A76.
+ 	 *
+ 	 * Install the kernel IA key only if IA was enabled in the task. If IA
+ 	 * was disabled on kernel exit then we would have left the kernel IA
+ 	 * installed so there is no need to install it again.
+ 	 */
+ 	ldr	x0, [tsk, THREAD_SCTLR_USER]
+ 	tbz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+ 	__ptrauth_keys_install_kernel_nosync tsk, x20, x22, x23
+ 	b	2f
+ 1:
+ 	mrs	x0, sctlr_el1
+ 	orr	x0, x0, SCTLR_ELx_ENIA
+ 	msr	sctlr_el1, x0
+ 2:
+ 	isb
+ alternative_else_nop_endif
+ #endif
  
  	mte_set_kernel_gcr x22, x23
  
diff --cc arch/arm64/kernel/probes/kprobes.c
index 85645b2b0c7a,ecf0f613327f..d607c9912025
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@@ -264,15 -264,12 +264,14 @@@ int __kprobes kprobe_fault_handler(stru
  		 * normal page fault.
  		 */
  		instruction_pointer_set(regs, (unsigned long) cur->addr);
- 		if (!instruction_pointer(regs))
- 			BUG();
+ 		BUG_ON(!instruction_pointer(regs));
  
 -		if (kcb->kprobe_status == KPROBE_REENTER)
 +		if (kcb->kprobe_status == KPROBE_REENTER) {
  			restore_previous_kprobe(kcb);
 -		else
 +		} else {
 +			kprobes_restore_local_irqflag(kcb, regs);
  			reset_current_kprobe();
 +		}
  
  		break;
  	case KPROBE_HIT_ACTIVE:

