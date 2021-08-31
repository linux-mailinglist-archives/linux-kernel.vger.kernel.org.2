Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F423FCCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhHaSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhHaSE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:04:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A32160F6C;
        Tue, 31 Aug 2021 18:03:31 +0000 (UTC)
Date:   Tue, 31 Aug 2021 19:03:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [GIT PULL] arm64 updates for 5.15
Message-ID: <YS5u8M97frcjTbJW@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates for 5.15 below. The asymmetric AArch32
support patches were queued via tip/sched/arm64 on top of the scheduler
counterpart. I merged the tip branch into the arm64 tree (based on -rc3)
but since the former was based on -rc6, I had to generate the diffstat
manually (dummy merge with upstream and git show --stat). Hopefully it
matches yours.

Thanks.

The following changes since commit 234b8ab6476c5edd5262e2ff563de9498d60044a:

  sched: Introduce dl_task_check_affinity() to check proposed affinity (2021-08-20 12:33:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 65266a7c6abfa1ad915a362c41bf38576607f1f9:

  Merge remote-tracking branch 'tip/sched/arm64' into for-next/core (2021-08-31 09:10:00 +0100)

----------------------------------------------------------------
arm64 updates for 5.15:

- Support for 32-bit tasks on asymmetric AArch32 systems (on top of the
  scheduler changes merged via the tip tree).

- More entry.S clean-ups and conversion to C.

- MTE updates: allow a preferred tag checking mode to be set per CPU
  (the overhead of synchronous mode is smaller for some CPUs than
  others); optimisations for kernel entry/exit path; optionally disable
  MTE on the kernel command line.

- Kselftest improvements for SVE and signal handling, PtrAuth.

- Fix unlikely race where a TLBI could use stale ASID on an ASID
  roll-over (found by inspection).

- Miscellaneous fixes: disable trapping of PMSNEVFR_EL1 to higher
  exception levels; drop unnecessary sigdelsetmask() call in the
  signal32 handling; remove BUG_ON when failing to allocate SVE state
  (just signal the process); SYM_CODE annotations.

- Other trivial clean-ups: use macros instead of magic numbers, remove
  redundant returns, typos.

----------------------------------------------------------------
Alexandru Elisei (1):
      arm64: Do not trap PMSNEVFR_EL1

Anshuman Khandual (2):
      arm64/kexec: Test page size support with new TGRAN range values
      arm64/perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF

Catalin Marinas (3):
      Merge branches 'for-next/mte', 'for-next/misc' and 'for-next/kselftest', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/entry' into for-next/core
      Merge remote-tracking branch 'tip/sched/arm64' into for-next/core

Changbin Du (1):
      arm64: replace in_irq() with in_hardirq()

Jason Wang (3):
      arm64: use __func__ to get function name in pr_err
      arm64: unnecessary end 'return;' in void functions
      arm64: fix typo in a comment

Lingyan Huang (1):
      arm64: SSBS/DIT: print SSBS and DIT bit when printing PSTATE

Marc Zyngier (1):
      arm64: Document the requirement for SCR_EL3.HCE

Mark Brown (19):
      arm64/sme: Document boot requirements for SME
      kselftest/arm64: Ignore check_gcr_el1_cswitch binary
      arm64/sve: Make fpsimd_bind_task_to_cpu() static
      kselftest/arm64: Provide a helper binary and "library" for SVE RDVL
      kselftest/arm64: Validate vector lengths are set in sve-probe-vls
      kselftest/arm64: Add tests for SVE vector configuration
      kselftest/arm64: Add a TODO list for floating point tests
      arm64: entry: Add SYM_CODE annotation for __bad_stack
      kselftest/arm64: mte: Fix misleading output when skipping tests
      kselftest/arm64: pac: Fix skipping of tests on systems without PAC
      kselftest/arm64: signal: Add SVE to the set of features we can check for
      kselftest/arm64: signal: Support signal frames with SVE register data
      kselftest/arm64: signal: Check SVE signal frame shows expected vector length
      kselftest/arm64: signal: Verify that signals can't change the SVE vector length
      kselftest/arm64: signal: Add test case for SVE register state in signals
      kselftest/arm64: signal: Add a TODO list for signal handling tests
      arm64/sve: Add some comments for sve_save/load_state()
      arm64/sve: Add a comment documenting the binutils needed for SVE asm
      arm64/sve: Better handle failure to allocate SVE register storage

Mark Rutland (7):
      arm64: kasan: mte: use a constant kernel GCR_EL1 value
      arm64: kasan: mte: remove redundant mte_report_once logic
      arm64: entry: consolidate entry/exit helpers
      arm64: entry: clarify entry/exit helpers
      arm64: entry: move bulk of ret_to_user to C
      arm64: entry: call exit_to_user_mode() from C
      arm64: head: avoid over-mapping in map_memory

Masahiro Yamada (1):
      arm64: move the (z)install rules to arch/arm64/Makefile

Peter Collingbourne (8):
      arm64: mte: avoid TFSRE0_EL1 related operations unless in async mode
      arm64: mte: rename gcr_user_excl to mte_ctrl
      arm64: mte: change ASYNC and SYNC TCF settings into bitfields
      arm64: move preemption disablement to prctl handlers
      arm64: mte: introduce a per-CPU tag checking mode preference
      Documentation: document the preferred tag checking mode feature
      arm64: mte: optimize GCR_EL1 modification on kernel entry/exit
      arm64: avoid double ISB on kernel entry

Peter Zijlstra (1):
      Merge branch 'sched/core'

Shaokun Zhang (1):
      arm64: cpufeature: Use defined macro instead of magic numbers

Will Deacon (9):
      arm64: mm: Fix TLBI vs ASID rollover
      arm64: Implement task_cpu_possible_mask()
      arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit EL0
      arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system
      arm64: Advertise CPUs capable of running 32-bit applications in sysfs
      arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
      arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
      Documentation: arm64: describe asymmetric 32-bit support
      arm64: signal32: Drop pointless call to sigdelsetmask()

Xujun Leng (1):
      arm64: mm: fix comment typo of pud_offset_phys()

Yee Lee (1):
      arm64/cpufeature: Optionally disable MTE via command-line

 Documentation/ABI/testing/sysfs-devices-system-cpu |  26 +
 Documentation/admin-guide/kernel-parameters.txt    |  14 +
 Documentation/arm64/asymmetric-32bit.rst           | 155 ++++++
 Documentation/arm64/booting.rst                    |  37 +-
 Documentation/arm64/index.rst                      |   1 +
 Documentation/arm64/memory-tagging-extension.rst   |  48 +-
 arch/arm64/Makefile                                |   7 +-
 arch/arm64/boot/Makefile                           |   8 -
 arch/arm64/include/asm/cpufeature.h                |  11 +-
 arch/arm64/include/asm/el2_setup.h                 |  13 +-
 arch/arm64/include/asm/elf.h                       |   6 +-
 arch/arm64/include/asm/exception.h                 |   5 +-
 arch/arm64/include/asm/fpsimd.h                    |   1 -
 arch/arm64/include/asm/fpsimdmacros.h              |   1 +
 arch/arm64/include/asm/kernel-pgtable.h            |   4 +-
 arch/arm64/include/asm/memory.h                    |   2 -
 arch/arm64/include/asm/mmu.h                       |  29 +-
 arch/arm64/include/asm/mmu_context.h               |  13 +
 arch/arm64/include/asm/mte-kasan.h                 |  17 -
 arch/arm64/include/asm/mte.h                       |   6 -
 arch/arm64/include/asm/pgtable.h                   |   2 +-
 arch/arm64/include/asm/pointer_auth.h              |  12 +-
 arch/arm64/include/asm/processor.h                 |  10 +-
 arch/arm64/include/asm/simd.h                      |   2 +-
 arch/arm64/include/asm/sysreg.h                    |  47 +-
 arch/arm64/include/asm/tlbflush.h                  |  13 +-
 arch/arm64/kernel/asm-offsets.c                    |   2 +-
 arch/arm64/kernel/cpufeature.c                     |  58 +-
 arch/arm64/kernel/entry-common.c                   | 219 +++++---
 arch/arm64/kernel/entry-fpsimd.S                   |  13 +
 arch/arm64/kernel/entry.S                          | 114 ++--
 arch/arm64/kernel/fpsimd.c                         |  14 +-
 arch/arm64/kernel/head.S                           |  11 +-
 arch/arm64/kernel/idreg-override.c                 |   2 +
 arch/arm64/kernel/mte.c                            | 180 ++++---
 arch/arm64/kernel/perf_event.c                     |   2 +-
 arch/arm64/kernel/pointer_auth.c                   |  10 +-
 arch/arm64/kernel/process.c                        |  78 ++-
 arch/arm64/kernel/ptrace.c                         |   5 +
 arch/arm64/kernel/signal.c                         |  34 +-
 arch/arm64/kernel/signal32.c                       |   6 +-
 arch/arm64/kernel/suspend.c                        |   1 -
 arch/arm64/lib/insn.c                              |   4 +-
 arch/arm64/mm/fault.c                              |  15 +-
 arch/arm64/mm/proc.S                               |   3 +-
 include/linux/kasan-tags.h                         |  15 +
 include/uapi/linux/prctl.h                         |  11 +-
 lib/test_kasan.c                                   |   2 -
 mm/kasan/hw_tags.c                                 |   8 -
 mm/kasan/kasan.h                                   |  22 +-
 tools/testing/selftests/arm64/fp/.gitignore        |   2 +
 tools/testing/selftests/arm64/fp/Makefile          |  11 +-
 tools/testing/selftests/arm64/fp/TODO              |   4 +
 tools/testing/selftests/arm64/fp/rdvl-sve.c        |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S            |  10 +
 tools/testing/selftests/arm64/fp/rdvl.h            |   8 +
 tools/testing/selftests/arm64/fp/sve-probe-vls.c   |   5 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c      | 593 +++++++++++++++++++++
 tools/testing/selftests/arm64/mte/.gitignore       |   1 +
 .../testing/selftests/arm64/mte/mte_common_util.c  |   2 +-
 tools/testing/selftests/arm64/pauth/pac.c          |  10 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../testing/selftests/arm64/signal/test_signals.h  |   2 +
 .../selftests/arm64/signal/test_signals_utils.c    |   3 +
 .../testing/selftests/arm64/signal/testcases/TODO  |   2 +
 .../testcases/fake_sigreturn_sve_change_vl.c       |  92 ++++
 .../selftests/arm64/signal/testcases/sve_regs.c    | 126 +++++
 .../selftests/arm64/signal/testcases/sve_vl.c      |  68 +++
 .../selftests/arm64/signal/testcases/testcases.c   |  34 +-
 69 files changed, 1843 insertions(+), 464 deletions(-)

-- 
Catalin
