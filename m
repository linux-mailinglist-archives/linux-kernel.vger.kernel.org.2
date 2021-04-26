Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4836B1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhDZKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:46:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhDZKqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:46:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6113DB1FD;
        Mon, 26 Apr 2021 10:46:08 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:46:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v5.13
Message-ID: <YIaZ8y+xn3PcbnX2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the usual pile of cleanups for v5.13.

Thx.

---

The following changes since commit 2c41fab1c60b02626c8153a1806a7a1e5d62aaf1:

  Merge tag 'io_uring-5.12-2021-03-21' of git://git.kernel.dk/linux-block (2021-03-21 12:25:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.13

for you to fetch changes up to df448cdfc01ffc117702a494ef302e7fb76df78a:

  MAINTAINERS: Remove me from IDE/ATAPI section (2021-04-16 12:58:34 +0200)

----------------------------------------------------------------
Trivial cleanups and fixes all over the place.

----------------------------------------------------------------
Aditya Srivastava (1):
      x86/platform/intel/quark: Fix incorrect kernel-doc comment syntax in files

Arnd Bergmann (2):
      x86/msr: Fix wr/rdmsr_safe_regs_on_cpu() prototypes
      x86/fpu/math-emu: Fix function cast warning

Borislav Petkov (1):
      MAINTAINERS: Remove me from IDE/ATAPI section

Cao jin (1):
      x86/setup: Remove unused RESERVE_BRK_ARRAY()

Dave Hansen (1):
      x86: Remove duplicate TSC DEADLINE MSR definitions

Ingo Molnar (5):
      Merge tag 'v5.12-rc3' into x86/cleanups, to refresh the tree
      x86: Fix various typos in comments
      Merge branch 'linus' into x86/cleanups, to resolve conflict
      x86: Remove unusual Unicode characters from comments
      x86: Fix various typos in comments, take #2

Jan Kiszka (2):
      x86/asm: Ensure asm/proto.h can be included stand-alone
      x86/pat: Do not compile stubbed functions when X86_PAT is off

Jiapeng Chong (1):
      x86/kaslr: Return boolean values from a function returning bool

Lai Jiangshan (1):
      x86/process/64: Move cpu_current_top_of_stack out of TSS

Mark Brown (1):
      stacktrace: Move documentation for arch_stack_walk_reliable() to header

Masahiro Yamada (1):
      x86/syscalls: Fix -Wmissing-prototypes warnings from COND_SYSCALL()

Randy Dunlap (1):
      tools/turbostat: Unmark non-kernel-doc comment

Yang Li (1):
      x86/cacheinfo: Remove unneeded dead-store initialization

Zhao Xuehui (1):
      x86/msr: Make locally used functions static

 MAINTAINERS                                    |  3 +--
 arch/s390/kernel/stacktrace.c                  |  6 ------
 arch/x86/boot/compressed/efi_thunk_64.S        |  2 +-
 arch/x86/boot/compressed/head_64.S             |  2 +-
 arch/x86/boot/compressed/kaslr.c               |  4 ++--
 arch/x86/crypto/crc32-pclmul_glue.c            |  2 +-
 arch/x86/crypto/curve25519-x86_64.c            |  6 +++---
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S   |  2 +-
 arch/x86/crypto/twofish_glue_3way.c            |  2 +-
 arch/x86/entry/entry_32.S                      |  2 +-
 arch/x86/entry/entry_64.S                      |  2 +-
 arch/x86/entry/vdso/vdso2c.c                   |  2 +-
 arch/x86/entry/vdso/vdso32/system_call.S       |  2 +-
 arch/x86/entry/vdso/vma.c                      |  2 +-
 arch/x86/entry/vdso/vsgx.S                     |  2 +-
 arch/x86/events/amd/core.c                     |  2 +-
 arch/x86/events/amd/iommu.h                    |  2 +-
 arch/x86/events/core.c                         |  2 +-
 arch/x86/events/intel/bts.c                    |  2 +-
 arch/x86/events/intel/core.c                   | 14 +++++++-------
 arch/x86/events/intel/ds.c                     |  2 +-
 arch/x86/events/intel/lbr.c                    |  2 +-
 arch/x86/events/intel/p4.c                     |  6 +++---
 arch/x86/events/intel/pt.c                     |  2 +-
 arch/x86/events/intel/uncore_snbep.c           | 12 ++++++------
 arch/x86/events/zhaoxin/core.c                 |  2 +-
 arch/x86/hyperv/hv_init.c                      |  4 ++--
 arch/x86/include/asm/agp.h                     |  2 +-
 arch/x86/include/asm/cmpxchg.h                 |  2 +-
 arch/x86/include/asm/elf.h                     | 10 +++++-----
 arch/x86/include/asm/idtentry.h                |  2 +-
 arch/x86/include/asm/intel_pconfig.h           |  2 +-
 arch/x86/include/asm/intel_pt.h                |  2 +-
 arch/x86/include/asm/io.h                      |  2 +-
 arch/x86/include/asm/irq_stack.h               |  2 +-
 arch/x86/include/asm/kvm_host.h                |  4 ++--
 arch/x86/include/asm/msr-index.h               |  2 --
 arch/x86/include/asm/nospec-branch.h           |  2 +-
 arch/x86/include/asm/paravirt_types.h          |  2 +-
 arch/x86/include/asm/pgtable.h                 |  2 +-
 arch/x86/include/asm/processor.h               | 12 +-----------
 arch/x86/include/asm/proto.h                   |  2 ++
 arch/x86/include/asm/set_memory.h              |  4 ++--
 arch/x86/include/asm/setup.h                   |  5 -----
 arch/x86/include/asm/switch_to.h               |  7 +------
 arch/x86/include/asm/syscall_wrapper.h         |  1 +
 arch/x86/include/asm/thread_info.h             |  8 +-------
 arch/x86/include/asm/uv/uv_geo.h               |  2 +-
 arch/x86/include/asm/uv/uv_hub.h               |  2 +-
 arch/x86/include/uapi/asm/bootparam.h          |  4 ++--
 arch/x86/include/uapi/asm/msgbuf.h             |  2 +-
 arch/x86/include/uapi/asm/sgx.h                |  2 +-
 arch/x86/include/uapi/asm/shmbuf.h             |  2 +-
 arch/x86/include/uapi/asm/sigcontext.h         |  2 +-
 arch/x86/kernel/acpi/boot.c                    |  4 ++--
 arch/x86/kernel/acpi/sleep.c                   |  2 +-
 arch/x86/kernel/amd_nb.c                       |  2 +-
 arch/x86/kernel/apic/apic.c                    | 10 +++++-----
 arch/x86/kernel/apic/io_apic.c                 |  8 ++++----
 arch/x86/kernel/apic/vector.c                  |  4 ++--
 arch/x86/kernel/apm_32.c                       |  6 +++---
 arch/x86/kernel/cpu/cacheinfo.c                |  2 +-
 arch/x86/kernel/cpu/common.c                   |  6 ++++--
 arch/x86/kernel/cpu/cyrix.c                    |  2 +-
 arch/x86/kernel/cpu/intel.c                    |  2 +-
 arch/x86/kernel/cpu/mce/core.c                 |  2 +-
 arch/x86/kernel/cpu/mce/severity.c             |  2 +-
 arch/x86/kernel/cpu/mshyperv.c                 |  4 ++--
 arch/x86/kernel/cpu/mtrr/cleanup.c             |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                |  2 +-
 arch/x86/kernel/cpu/resctrl/core.c             |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c          |  6 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c      |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c         |  6 +++---
 arch/x86/kernel/cpu/sgx/arch.h                 |  2 +-
 arch/x86/kernel/cpu/sgx/main.c                 |  4 ++--
 arch/x86/kernel/cpu/topology.c                 |  4 ++--
 arch/x86/kernel/e820.c                         |  2 +-
 arch/x86/kernel/fpu/xstate.c                   |  2 +-
 arch/x86/kernel/head64.c                       |  2 +-
 arch/x86/kernel/idt.c                          |  2 +-
 arch/x86/kernel/irq.c                          |  2 +-
 arch/x86/kernel/kgdb.c                         |  4 ++--
 arch/x86/kernel/kprobes/ftrace.c               |  2 +-
 arch/x86/kernel/machine_kexec_64.c             |  2 +-
 arch/x86/kernel/process.c                      |  9 ++-------
 arch/x86/kernel/pvclock.c                      |  2 +-
 arch/x86/kernel/relocate_kernel_32.S           |  2 +-
 arch/x86/kernel/relocate_kernel_64.S           |  2 +-
 arch/x86/kernel/setup.c                        |  6 +++---
 arch/x86/kernel/signal.c                       |  2 +-
 arch/x86/kernel/smp.c                          |  4 ++--
 arch/x86/kernel/smpboot.c                      |  2 +-
 arch/x86/kernel/stacktrace.c                   |  6 ------
 arch/x86/kernel/sysfb_efi.c                    |  2 +-
 arch/x86/kernel/topology.c                     |  2 +-
 arch/x86/kernel/traps.c                        |  2 +-
 arch/x86/kernel/tsc.c                          |  6 +++---
 arch/x86/kernel/tsc_sync.c                     |  2 +-
 arch/x86/kernel/umip.c                         |  2 +-
 arch/x86/kvm/cpuid.c                           |  2 +-
 arch/x86/kvm/emulate.c                         |  2 +-
 arch/x86/kvm/irq_comm.c                        |  2 +-
 arch/x86/kvm/mmu/mmu.c                         |  2 +-
 arch/x86/kvm/mmu/mmu_internal.h                |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                     |  6 +++---
 arch/x86/kvm/pmu.h                             |  2 +-
 arch/x86/kvm/svm/avic.c                        |  4 ++--
 arch/x86/kvm/svm/sev.c                         |  2 +-
 arch/x86/kvm/svm/svm.c                         |  2 +-
 arch/x86/kvm/vmx/nested.c                      |  2 +-
 arch/x86/kvm/vmx/posted_intr.c                 |  2 +-
 arch/x86/kvm/vmx/vmx.c                         |  6 +++---
 arch/x86/kvm/x86.c                             | 14 +++++++-------
 arch/x86/lib/insn-eval.c                       |  6 +++---
 arch/x86/lib/mmx_32.c                          |  2 +-
 arch/x86/lib/msr-smp.c                         |  4 ++--
 arch/x86/lib/msr.c                             |  4 ++--
 arch/x86/math-emu/fpu_trig.c                   | 11 ++++++++---
 arch/x86/math-emu/reg_ld_str.c                 |  2 +-
 arch/x86/math-emu/reg_round.S                  |  2 +-
 arch/x86/mm/fault.c                            |  4 ++--
 arch/x86/mm/init.c                             |  6 +++---
 arch/x86/mm/init_64.c                          |  6 +++---
 arch/x86/mm/kaslr.c                            |  2 +-
 arch/x86/mm/kmmio.c                            |  2 +-
 arch/x86/mm/mem_encrypt_boot.S                 |  2 +-
 arch/x86/mm/pat/memtype.c                      |  4 +++-
 arch/x86/mm/pat/set_memory.c                   |  2 +-
 arch/x86/mm/pkeys.c                            |  2 +-
 arch/x86/mm/pti.c                              | 11 +++++------
 arch/x86/mm/tlb.c                              |  6 +++---
 arch/x86/net/bpf_jit_comp.c                    |  4 ++--
 arch/x86/pci/fixup.c                           |  2 +-
 arch/x86/platform/efi/efi_64.c                 |  4 ++--
 arch/x86/platform/efi/quirks.c                 |  4 ++--
 arch/x86/platform/intel-quark/imr.c            |  4 ++--
 arch/x86/platform/intel-quark/imr_selftest.c   |  2 +-
 arch/x86/platform/intel/iosf_mbi.c             |  4 ++--
 arch/x86/platform/olpc/olpc-xo15-sci.c         |  2 +-
 arch/x86/platform/olpc/olpc_dt.c               |  2 +-
 arch/x86/platform/pvh/head.S                   |  6 +++---
 arch/x86/platform/uv/uv_nmi.c                  |  2 +-
 arch/x86/power/cpu.c                           |  2 +-
 arch/x86/realmode/init.c                       |  2 +-
 arch/x86/xen/mmu_pv.c                          |  2 +-
 include/linux/stacktrace.h                     | 19 +++++++++++++++++++
 tools/arch/x86/include/asm/msr-index.h         |  2 --
 tools/perf/trace/beauty/tracepoints/x86_msr.sh |  2 +-
 tools/power/x86/turbostat/turbostat.c          |  2 +-
 150 files changed, 259 insertions(+), 277 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
