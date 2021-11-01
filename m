Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA7441ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhKALi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhKALi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92ABF610A8;
        Mon,  1 Nov 2021 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635766554;
        bh=xo42wBSt/Lck5rn+JUGq5LlaqgK91hO8hHDEs/R1Jb0=;
        h=Date:From:To:Cc:Subject:From;
        b=D9w4H8tAOz1DPv1yCC4j/K5A7xGFR+AhMen/7sNchkEMeVILIysSP/T8Flvv2Lwhp
         rCGbHJaLhHzTNEBHF7hFMHkpF4xAnuQUYKs1REaxIBm7jQ2PZQ5lz5GigaDVmQKiwc
         XLt9dd1SsTufRvEk/E++PGPsnvnhPSoD87DZEaffzYeKN6FH6Gm2M4LEk+seWLtM+z
         OearrNtubiq554d52x4/8MFFTrJUAQaEsQW9lxb44cpcVZ3eYo5owysdtTmbZstaD5
         07qJJCBYUz8Qrvlq73j0fc6f6YVsb+EDa5XqW4ewa3QHLAiYOdZS4tOXcdZ9na74ka
         Itm90fYMZGXxQ==
Date:   Mon, 1 Nov 2021 11:35:49 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        gregkh@linuxfoundation.org, mathieu.poirier@linaro.org,
        maz@kernel.org, daniel.lezcano@linaro.org
Subject: [GIT PULL] arm64 updates for 5.16
Message-ID: <20211101113548.GA27758@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this batch of arm64 updates for 5.16. There's the usual
summary in the tag, but the highlights are support for the Armv8.6
timer extensions, KASAN support for asymmetric MTE, the ability to
kexec() with the MMU enabled and a second attempt at switching to the
generic pfn_valid() implementation.

Please note that the changes to the "arm_arch_timer" driver on which we
depend are shared with Daniel and should also come via the -tip tree.

Cheers,

Will

--->8

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to e6359798f62da66a4a48061d2324a69ea59ff39b:

  Merge branch 'for-next/fixes' into for-next/core (2021-10-29 12:27:53 +0100)

----------------------------------------------------------------
arm64 updates for 5.16

- Support for the Arm8.6 timer extensions, including a self-synchronising
  view of the system registers to elide some expensive ISB instructions.

- Exception table cleanup and rework so that the fixup handlers appear
  correctly in backtraces.

- A handful of miscellaneous changes, the main one being selection of
  CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.

- More mm and pgtable cleanups.

- KASAN support for "asymmetric" MTE, where tag faults are reported
  synchronously for loads (via an exception) and asynchronously for
  stores (via a register).

- Support for leaving the MMU enabled during kexec relocation, which
  significantly speeds up the operation.

- Minor improvements to our perf PMU drivers.

- Improvements to the compat vDSO build system, particularly when
  building with LLVM=1.

- Preparatory work for handling some Coresight TRBE tracing errata.

- Cleanup and refactoring of the SVE code to pave the way for SME
  support in future.

- Ensure SCS pages are unpoisoned immediately prior to freeing them
  when KASAN is enabled for the vmalloc area.

- Try moving to the generic pfn_valid() implementation again now that
  the DMA mapping issue from last time has been resolved.

- Numerous improvements and additions to our FPSIMD and SVE selftests.

----------------------------------------------------------------
Amit Daniel Kachhap (1):
      arm64/traps: Avoid unnecessary kernel/user pointer conversion

Anders Roxell (1):
      arm64: asm: setup.h: export common variables

Anshuman Khandual (2):
      arm64/mm: Add pud_sect_supported()
      arm64/mm: drop HAVE_ARCH_PFN_VALID

Jackie Liu (1):
      acpi/arm64: fix next_platform_timer() section mismatch error

John Garry (2):
      drivers/perf: thunderx2_pmu: Change data in size tx2_uncore_event_update()
      drivers/perf: Improve build test coverage

Marc Zyngier (16):
      clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses
      clocksource/drivers/arm_arch_timer: Drop CNT*_TVAL read accessors
      clocksource/drivers/arm_arch_timer: Extend write side of timer register accessors to u64
      clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL
      clocksource/drivers/arm_arch_timer: Move drop _tval from erratum function names
      clocksource/drivers/arm_arch_timer: Fix MMIO base address vs callback ordering issue
      clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL
      clocksource/drivers/arm_arch_timer: Advertise 56bit timer to the core code
      clocksource/drivers/arm_arch_timer: Work around broken CVAL implementations
      clocksource/drivers/arm_arch_timer: Remove any trace of the TVAL programming interface
      clocksource/drivers/arm_arch_timer: Drop unnecessary ISB on CVAL programming
      clocksource/drivers/arch_arm_timer: Move workaround synchronisation around
      arm64: Add a capability for FEAT_ECV
      arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
      arm64: Add handling of CNTVCTSS traps
      arm64: Add HWCAP for self-synchronising virtual counter

Mark Brown (26):
      selftests: arm64: Use a define for the number of SVE ptrace tests to be run
      selftests: arm64: Don't log child creation as a test in SVE ptrace test
      selftests: arm64: Remove extraneous register setting code
      selftests: arm64: Document what the SVE ptrace test is doing
      selftests: arm64: Clarify output when verifying SVE register set
      selftests: arm64: Verify interoperation of SVE and FPSIMD register sets
      selftests: arm64: More comprehensively test the SVE ptrace interface
      selftests: arm64: Move FPSIMD in SVE ptrace test into a function
      selftests: arm64: Fix printf() format mismatch in vec-syscfg
      selftests: arm64: Remove bogus error check on writing to files
      selftests: arm64: Fix and enable test for setting current VL in vec-syscfg
      selftests: arm64: Verify that all possible vector lengths are handled
      selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance
      arm64/fp: Reindent fpsimd_save()
      arm64/sve: Remove sve_load_from_fpsimd_state()
      arm64/sve: Make sve_state_size() static
      arm64/sve: Make access to FFR optional
      arm64/sve: Rename find_supported_vector_length()
      arm64/sve: Use accessor functions for vector lengths in thread_struct
      arm64/sve: Put system wide vector length information into structs
      arm64/sve: Explicitly load vector length when restoring SVE state
      arm64/sve: Track vector lengths for tasks in an array
      selftests: arm64: Factor out utility functions for assembly FP tests
      arm64/sve: Add stub for sve_max_virtualisable_vl()
      arm64/sve: Fix warnings when SVE is disabled
      arm64: Document boot requirements for FEAT_SME_FA64

Mark Rutland (13):
      arm64: lib: __arch_clear_user(): fold fixups into body
      arm64: lib: __arch_copy_from_user(): fold fixups into body
      arm64: lib: __arch_copy_to_user(): fold fixups into body
      arm64: kvm: use kvm_exception_table_entry
      arm64: factor out GPR numbering helpers
      arm64: gpr-num: support W registers
      arm64: extable: consolidate definitions
      arm64: extable: make fixup_exception() return bool
      arm64: extable: use `ex` for `exception_table_entry`
      arm64: extable: add `type` and `data` fields
      arm64: extable: add a dedicated uaccess handler
      arm64: extable: add load_unaligned_zeropad() handler
      arm64: vmlinux.lds.S: remove `.fixup` section

Mike Kravetz (1):
      arm64/hugetlb: fix CMA gigantic page order for non-4K PAGE_SIZE

Mike Rapoport (1):
      dma-mapping: remove bogus test for pfn_valid from dma_map_resource

Nick Desaulniers (4):
      arm64: vdso32: drop the test for dmb ishld
      arm64: vdso32: drop test for -march=armv8-a
      arm64: vdso32: suppress error message for 'make mrproper'
      arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd

Nicolas Saenz Julienne (1):
      arm64: Select POSIX_CPU_TIMERS_TASK_WORK

Oliver Upton (1):
      clocksource/drivers/arm_arch_timer: Fix masking for high freq counters

Pasha Tatashin (15):
      arm64: kernel: add helper for booted at EL2 and not VHE
      arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
      arm64: hibernate: abstract ttrb0 setup function
      arm64: kexec: flush image and lists during kexec load time
      arm64: kexec: skip relocation code for inplace kexec
      arm64: kexec: Use dcache ops macros instead of open-coding
      arm64: kexec: pass kimage as the only argument to relocation function
      arm64: kexec: configure EL2 vectors for kexec
      arm64: kexec: relocate in EL1 mode
      arm64: kexec: use ld script for relocation function
      arm64: kexec: install a copy of the linear-map
      arm64: kexec: keep MMU enabled during kexec relocation
      arm64: kexec: remove the pre-kexec PoC maintenance
      arm64: kexec: remove cpu-reset.h
      arm64: trans_pgd: remove trans_pgd_map_page()

Peter Collingbourne (1):
      arm64: kasan: mte: move GCR_EL1 switch to task switch when KASAN disabled

Shaokun Zhang (1):
      drivers/perf: hisi: Fix PA PMU counter offset

Sudarshan Rajagopalan (1):
      arm64: mm: update max_pfn after memory hotplug

Sumit Garg (1):
      arm64: ftrace: use function_nocfi for _mcount as well

Suzuki K Poulose (4):
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
      arm64: errata: Add detection for TRBE overwrite in FILL mode
      arm64: errata: Add workaround for TSB flush failures
      arm64: errata: Add detection for TRBE write to out-of-range

Vincenzo Frascino (5):
      kasan: Remove duplicate of kasan_flag_async
      arm64: mte: Bitfield definitions for Asymm MTE
      arm64: mte: CPU feature detection for Asymm MTE
      arm64: mte: Add asymmetric mode support
      kasan: Extend KASAN mode kernel parameter

Will Deacon (16):
      arm64: mm: Drop pointless call to set_max_mapnr()
      Merge branch 'timers/drivers/armv8.6_arch_timer' of https://git.linaro.org/people/daniel.lezcano/linux into for-next/8.6-timers
      Merge branch 'for-next/8.6-timers' into for-next/core
      Merge branch 'for-next/extable' into for-next/core
      Merge branch 'for-next/kexec' into for-next/core
      Merge branch 'for-next/kselftest' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/mte' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/pfn-valid' into for-next/core
      Merge branch 'for-next/scs' into for-next/core
      Merge branch 'for-next/sve' into for-next/core
      Merge branch 'for-next/trbe-errata' into for-next/core
      Merge branch 'for-next/vdso' into for-next/core
      Merge branch 'for-next/fixes' into for-next/core

Yee Lee (1):
      scs: Release kasan vmalloc poison in scs_free process

 Documentation/arm64/booting.rst                   |  10 +
 Documentation/arm64/cpu-feature-registers.rst     |  12 +-
 Documentation/arm64/elf_hwcaps.rst                |   4 +
 Documentation/arm64/silicon-errata.rst            |  12 +
 Documentation/dev-tools/kasan.rst                 |   7 +-
 arch/arm/include/asm/arch_timer.h                 |  37 +-
 arch/arm64/Kconfig                                | 122 +++++-
 arch/arm64/include/asm/arch_timer.h               |  78 ++--
 arch/arm64/include/asm/asm-extable.h              |  95 ++++
 arch/arm64/include/asm/asm-uaccess.h              |   7 +-
 arch/arm64/include/asm/assembler.h                |  78 ++--
 arch/arm64/include/asm/barrier.h                  |  16 +-
 arch/arm64/include/asm/cputype.h                  |   4 +
 arch/arm64/include/asm/esr.h                      |   6 +
 arch/arm64/include/asm/extable.h                  |  23 +-
 arch/arm64/include/asm/fpsimd.h                   | 118 ++++-
 arch/arm64/include/asm/fpsimdmacros.h             |  21 +-
 arch/arm64/include/asm/ftrace.h                   |   2 +-
 arch/arm64/include/asm/futex.h                    |  25 +-
 arch/arm64/include/asm/gpr-num.h                  |  26 ++
 arch/arm64/include/asm/hwcap.h                    |   1 +
 arch/arm64/include/asm/kexec.h                    |  12 +
 arch/arm64/include/asm/kvm_asm.h                  |   7 +-
 arch/arm64/include/asm/memory.h                   |   1 +
 arch/arm64/include/asm/mmu_context.h              |  24 +
 arch/arm64/include/asm/mte-kasan.h                |   5 +
 arch/arm64/include/asm/mte.h                      |   8 +-
 arch/arm64/include/asm/page.h                     |   1 -
 arch/arm64/include/asm/pgtable.h                  |   5 +
 arch/arm64/include/asm/processor.h                |  49 ++-
 arch/arm64/include/asm/sections.h                 |   1 +
 arch/arm64/include/asm/setup.h                    |   6 +
 arch/arm64/include/asm/sysreg.h                   |  31 +-
 arch/arm64/include/asm/thread_info.h              |   2 +-
 arch/arm64/include/asm/trans_pgd.h                |  14 +-
 arch/arm64/include/asm/uaccess.h                  |  30 +-
 arch/arm64/include/asm/vdso/compat_barrier.h      |   7 -
 arch/arm64/include/asm/virt.h                     |   7 +
 arch/arm64/include/asm/vmalloc.h                  |   4 +-
 arch/arm64/include/asm/word-at-a-time.h           |  21 +-
 arch/arm64/include/uapi/asm/hwcap.h               |   1 +
 arch/arm64/kernel/armv8_deprecated.c              |  12 +-
 arch/arm64/kernel/asm-offsets.c                   |  11 +
 arch/arm64/kernel/cpu-reset.S                     |   7 +-
 arch/arm64/kernel/cpu-reset.h                     |  32 --
 arch/arm64/kernel/cpu_errata.c                    |  64 +++
 arch/arm64/kernel/cpufeature.c                    |  29 +-
 arch/arm64/kernel/cpuinfo.c                       |   1 +
 arch/arm64/kernel/entry-fpsimd.S                  |  34 +-
 arch/arm64/kernel/entry.S                         |  10 +-
 arch/arm64/kernel/fpsimd.c                        | 342 +++++++++------
 arch/arm64/kernel/hibernate-asm.S                 |  72 ---
 arch/arm64/kernel/hibernate.c                     |  49 +--
 arch/arm64/kernel/machine_kexec.c                 | 177 ++++----
 arch/arm64/kernel/mte.c                           |  67 ++-
 arch/arm64/kernel/ptrace.c                        |   6 +-
 arch/arm64/kernel/relocate_kernel.S               |  69 ++-
 arch/arm64/kernel/sdei.c                          |   2 +-
 arch/arm64/kernel/signal.c                        |   8 +-
 arch/arm64/kernel/traps.c                         |  24 +-
 arch/arm64/kernel/vdso32/Makefile                 |  36 +-
 arch/arm64/kernel/vmlinux.lds.S                   |  22 +-
 arch/arm64/kvm/hyp/fpsimd.S                       |   6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h           |  10 +-
 arch/arm64/kvm/reset.c                            |   6 +-
 arch/arm64/lib/clear_user.S                       |  10 +-
 arch/arm64/lib/copy_from_user.S                   |   8 +-
 arch/arm64/lib/copy_to_user.S                     |   8 +-
 arch/arm64/mm/Makefile                            |   1 +
 arch/arm64/mm/extable.c                           |  85 +++-
 arch/arm64/mm/hugetlbpage.c                       |  27 +-
 arch/arm64/mm/init.c                              |  39 --
 arch/arm64/mm/mmu.c                               |   5 +
 arch/arm64/mm/trans_pgd-asm.S                     |  65 +++
 arch/arm64/mm/trans_pgd.c                         |  84 ++--
 arch/arm64/net/bpf_jit_comp.c                     |   9 +-
 arch/arm64/tools/cpucaps                          |   5 +
 drivers/clocksource/arm_arch_timer.c              | 243 ++++++----
 drivers/perf/Kconfig                              |  12 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c       |   2 +-
 drivers/perf/thunderx2_pmu.c                      |   2 +-
 include/clocksource/arm_arch_timer.h              |   2 +-
 include/linux/kasan.h                             |   9 +-
 kernel/dma/mapping.c                              |   4 -
 kernel/scs.c                                      |   1 +
 lib/test_kasan.c                                  |   2 +-
 mm/kasan/hw_tags.c                                |  29 +-
 mm/kasan/kasan.h                                  |  32 +-
 mm/kasan/report.c                                 |   2 +-
 scripts/sorttable.c                               |  30 ++
 tools/testing/selftests/arm64/fp/Makefile         |   6 +-
 tools/testing/selftests/arm64/fp/TODO             |   9 +-
 tools/testing/selftests/arm64/fp/asm-utils.S      | 172 ++++++++
 tools/testing/selftests/arm64/fp/assembler.h      |  11 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S    | 164 -------
 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S |  33 --
 tools/testing/selftests/arm64/fp/sve-ptrace.c     | 511 ++++++++++++++++------
 tools/testing/selftests/arm64/fp/sve-test.S       | 163 -------
 tools/testing/selftests/arm64/fp/vec-syscfg.c     |  95 +++-
 99 files changed, 2389 insertions(+), 1527 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-extable.h
 create mode 100644 arch/arm64/include/asm/gpr-num.h
 delete mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/mm/trans_pgd-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/asm-utils.S
 delete mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
