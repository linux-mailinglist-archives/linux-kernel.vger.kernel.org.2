Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DD3B46E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFYPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhFYPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624636091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=91NpPe1Id4t2V+KLcATxhCcJohC6pMIxwJwvpuRz6W8=;
        b=Xyz0W0d98i0coN1T6/4NoFWBlecKsgNK5SEZYOSwe6e0ORfIS55aTHsShG+/iqE91gPTxX
        A1Fw/B+mSzsFLa8nMJ5tq5dgy10QJz1pVOThWQkcX/CW4gOGSiliF3+j9I0cFsqlc/+KIP
        BUS+TLdh01e5fvGcopT4bUXG6CDBJCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-UWmiW5VEPAioCRuib6ntkA-1; Fri, 25 Jun 2021 11:48:07 -0400
X-MC-Unique: UWmiW5VEPAioCRuib6ntkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0EC804308;
        Fri, 25 Jun 2021 15:48:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BF8F5D6AB;
        Fri, 25 Jun 2021 15:48:05 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for Linux 5.14
Date:   Fri, 25 Jun 2021 11:48:05 -0400
Message-Id: <20210625154805.133099-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

an early pull request for the next merge window, because I will not
be around next week.  It covers all architectures (except MIPS) so I
don't expect any other feature pull requests until after -rc1.

The following changes since commit d8ac05ea13d789d5491a5920d70a05659015441d:

  KVM: selftests: Fix kvm_check_cap() assertion (2021-06-17 13:06:57 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to b8917b4ae44d1b945f6fba3d8ee6777edb44633b:

  Merge tag 'kvmarm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2021-06-25 11:24:24 -0400)

There are shared topic branches with both ARM (see merge commit
85c653fcc635, "Merge branch arm64/for-next/caches into kvmarm-master/next")
and with PPC, where the whole changes are being merged through both
this pull request and Michael Ellerman's.

----------------------------------------------------------------
ARM:

- Add MTE support in guests, complete with tag save/restore interface

- Reduce the impact of CMOs by moving them in the page-table code

- Allow device block mappings at stage-2

- Reduce the footprint of the vmemmap in protected mode

- Support the vGIC on dumb systems such as the Apple M1

- Add selftest infrastructure to support multiple configuration
  and apply that to PMU/non-PMU setups

- Add selftests for the debug architecture

- The usual crop of PMU fixes

PPC:

- Support for the H_RPT_INVALIDATE hypercall

- Conversion of Book3S entry/exit to C

- Bug fixes

S390:

- new HW facilities for guests

- make inline assembly more robust with KASAN and co

x86:

- Allow userspace to handle emulation errors (unknown instructions)

- Lazy allocation of the rmap (host physical -> guest physical address)

- Support for virtualizing TSC scaling on VMX machines

- Optimizations to avoid shattering huge pages at the beginning of live migration

- Support for initializing the PDPTRs without loading them from memory

- Many TLB flushing cleanups

- Refuse to load if two-stage paging is available but NX is not (this has
  been a requirement in practice for over a year)

- A large series that separates the MMU mode (WP/SMAP/SMEP etc.) from
  CR0/CR4/EFER, using the MMU mode everywhere once it is computed
  from the CPU registers

- Use PM notifier to notify the guest about host suspend or hibernate

- Support for passing arguments to Hyper-V hypercalls using XMM registers

- Support for Hyper-V TLB flush hypercalls and enlightened MSR bitmap on
  AMD processors

- Hide Hyper-V hypercalls that are not included in the guest CPUID

- Fixes for live migration of virtual machines that use the Hyper-V
  "enlightened VMCS" optimization of nested virtualization

- Bugfixes (not many)

Generic:

- Support for retrieving statistics without debugfs

- Cleanups for the KVM selftests API

----------------------------------------------------------------
Aaron Lewis (3):
      kvm: x86: Allow userspace to handle emulation errors
      selftests: kvm: Allows userspace to handle emulation errors.
      kvm: x86: disable the narrow guest module parameter on unload

Alexandru Elisei (1):
      KVM: arm64: Don't zero the cycle count register when PMCR_EL0.P is set

Andrew Jones (5):
      KVM: arm64: selftests: get-reg-list: Introduce vcpu configs
      KVM: arm64: selftests: get-reg-list: Prepare to run multiple configs at once
      KVM: arm64: selftests: get-reg-list: Provide config selection option
      KVM: arm64: selftests: get-reg-list: Remove get-reg-list-sve
      KVM: arm64: selftests: get-reg-list: Split base and pmu registers

Aneesh Kumar K.V (1):
      KVM: PPC: Book3S HV: Fix comments of H_RPT_INVALIDATE arguments

Ashish Kalra (1):
      KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall

Ben Gardon (7):
      KVM: x86/mmu: Deduplicate rmap freeing
      KVM: x86/mmu: Factor out allocating memslot rmap
      KVM: mmu: Refactor memslot copy
      KVM: mmu: Add slots_arch_lock for memslot arch fields
      KVM: x86/mmu: Add a field to control memslot rmap allocation
      KVM: x86/mmu: Skip rmap operations if rmaps not allocated
      KVM: x86/mmu: Lazily allocate memslot rmaps

Bharata B Rao (5):
      powerpc/book3s64/radix: Add H_RPT_INVALIDATE pgsize encodings to mmu_psize_def
      KVM: PPC: Book3S HV: Add support for H_RPT_INVALIDATE
      KVM: PPC: Book3S HV: Nested support in H_RPT_INVALIDATE
      KVM: PPC: Book3S HV: Add KVM_CAP_PPC_RPT_INVALIDATE capability
      KVM: PPC: Book3S HV: Use H_RPT_INVALIDATE in nested KVM

Christian Borntraeger (2):
      KVM: s390: gen_facilities: allow facilities 165, 193, 194 and 196
      KVM: s390: allow facility 192 (vector-packed-decimal-enhancement facility 2)

Colin Ian King (1):
      KVM: x86/mmu: Fix uninitialized boolean variable flush

David Matlack (4):
      KVM: x86/mmu: Remove redundant is_tdp_mmu_root check
      KVM: x86/mmu: Remove redundant is_tdp_mmu_enabled check
      KVM: x86/mmu: Refactor is_tdp_mmu_root into is_tdp_mmu
      KVM: x86/mmu: Remove redundant root_hpa checks

Fuad Tabba (16):
      arm64: Apply errata to swsusp_arch_suspend_exit
      arm64: Do not enable uaccess for flush_icache_range
      arm64: Do not enable uaccess for invalidate_icache_range
      arm64: Downgrade flush_icache_range to invalidate
      arm64: assembler: remove user_alt
      arm64: Move documentation of dcache_by_line_op
      arm64: Fix comments to refer to correct function __flush_icache_range
      arm64: __inval_dcache_area to take end parameter instead of size
      arm64: dcache_by_line_op to take end parameter instead of size
      arm64: __flush_dcache_area to take end parameter instead of size
      arm64: __clean_dcache_area_poc to take end parameter instead of size
      arm64: __clean_dcache_area_pop to take end parameter instead of size
      arm64: __clean_dcache_area_pou to take end parameter instead of size
      arm64: sync_icache_aliases to take end parameter instead of size
      arm64: Fix cache maintenance function comments
      arm64: Rename arm64-internal cache maintenance functions

Heiko Carstens (1):
      KVM: s390: get rid of register asm usage

Hou Wenlong (1):
      KVM: selftests: fix triple fault if ept=0 in dirty_log_test

Ilias Stamatis (11):
      math64.h: Add mul_s64_u64_shr()
      KVM: X86: Store L1's TSC scaling ratio in 'struct kvm_vcpu_arch'
      KVM: X86: Rename kvm_compute_tsc_offset() to kvm_compute_l1_tsc_offset()
      KVM: X86: Add a ratio parameter to kvm_scale_tsc()
      KVM: nVMX: Add a TSC multiplier field in VMCS12
      KVM: X86: Add functions for retrieving L2 TSC fields from common code
      KVM: X86: Add functions that calculate the nested TSC fields
      KVM: X86: Move write_l1_tsc_offset() logic to common code and rename it
      KVM: X86: Add vendor callbacks for writing the TSC multiplier
      KVM: nVMX: Enable nested TSC scaling
      KVM: selftests: x86: Add vmx_nested_tsc_scaling_test

Jim Mattson (11):
      KVM: x86: Remove guest mode check from kvm_check_nested_events
      KVM: nVMX: Add a return code to vmx_complete_nested_posted_interrupt
      KVM: x86: Add a return code to inject_pending_event
      KVM: x86: Add a return code to kvm_apic_accept_events
      KVM: nVMX: Fail on MMIO completion for nested posted interrupts
      KVM: nVMX: Disable vmcs02 posted interrupts if vmcs12 PID isn't mappable
      KVM: selftests: Move APIC definitions into a separate file
      KVM: selftests: Hoist APIC functions out of individual tests
      KVM: selftests: Introduce x2APIC register manipulation functions
      KVM: VMX: Skip #PF(RSVD) intercepts when emulating smaller maxphyaddr
      KVM: x86: Print CPU of last attempted VM-entry when dumping VMCS/VMCB

Jing Zhang (7):
      KVM: stats: Separate generic stats from architecture specific ones
      KVM: stats: Add fd-based API to read binary stats data
      KVM: stats: Support binary stats retrieval for a VM
      KVM: stats: Support binary stats retrieval for a VCPU
      KVM: stats: Add documentation for binary statistics interface
      KVM: selftests: Add selftest for KVM statistics data binary interface
      KVM: debugfs: Reuse binary stats descriptors

Kai Huang (3):
      KVM: x86/mmu: Fix return value in tdp_mmu_map_handle_target_level()
      KVM: x86/mmu: Fix pf_fixed count in tdp_mmu_map_handle_target_level()
      KVM: x86/mmu: Fix TDP MMU page table level

Keqian Zhu (4):
      KVM: arm64: Remove the creation time's mapping of MMIO regions
      KVM: arm64: Try stage2 block mapping for host device MMIO
      KVM: x86: Support write protecting only large pages
      KVM: x86: Do not write protect huge page in initially-all-set mode

Krish Sadhukhan (2):
      KVM: nVMX: nSVM: 'nested_run' should count guest-entry attempts that make it to guest code
      KVM: nVMX: nSVM: Add a new VCPU statistic to show if VCPU is in guest mode

Marc Zyngier (22):
      irqchip/gic: Split vGIC probing information from the GIC code
      KVM: arm64: Handle physical FIQ as an IRQ while running a guest
      KVM: arm64: vgic: Be tolerant to the lack of maintenance interrupt masking
      KVM: arm64: vgic: Let an interrupt controller advertise lack of HW deactivation
      KVM: arm64: vgic: move irq->get_input_level into an ops structure
      KVM: arm64: vgic: Implement SW-driven deactivation
      KVM: arm64: timer: Refactor IRQ configuration
      KVM: arm64: timer: Add support for SW-based deactivation
      irqchip/apple-aic: Advertise some level of vGICv3 compatibility
      Merge branch kvm-arm64/m1 into kvmarm-master/next
      Merge branch kvm-arm64/mmu/MMIO-block-mapping into kvmarm-master/next
      Merge branch kvm-arm64/mmu/reduce-vmemmap-overhead into kvmarm-master/next
      Merge branch kvm-arm64/selftest/debug into kvmarm-master/next
      Merge branch kvm-arm64/mmu/stage2-cmos into kvmarm-master/next
      KVM: arm64: Restore PMU configuration on first run
      Merge branch kvm-arm64/pmu-fixes into kvmarm-master/next
      Merge branch arm64/for-next/caches into kvmarm-master/next
      KVM: arm64: Update MAINTAINERS to include selftests
      Merge branch kvm-arm64/selftest/sysreg-list-fix into kvmarm-master/next
      Merge branch kvm-arm64/mmu/mte into kvmarm-master/next
      KVM: arm64: Set the MTE tag bit before releasing the page
      Merge branch kvm-arm64/mmu/mte into kvmarm-master/next

Mark Rutland (2):
      arm64: assembler: replace `kaddr` with `addr`
      arm64: assembler: add conditional cache fixups

Maxim Levitsky (6):
      KVM: nSVM: refactor the CR3 reload on migration
      KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES
      KVM: x86: introduce kvm_register_clear_available
      KVM: x86: Introduce KVM_GET_SREGS2 / KVM_SET_SREGS2
      KVM: x86: avoid loading PDPTRs after migration when possible
      KVM: x86: rename apic_access_page_done to apic_access_memslot_enabled

Nathan Chancellor (1):
      KVM: PPC: Book3S HV: Workaround high stack usage with clang

Nicholas Piggin (33):
      KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path
      KVM: PPC: Book3S 64: move KVM interrupt entry to a common entry point
      KVM: PPC: Book3S 64: Move GUEST_MODE_SKIP test into KVM
      KVM: PPC: Book3S 64: add hcall interrupt handler
      KVM: PPC: Book3S 64: Move hcall early register setup to KVM
      KVM: PPC: Book3S 64: Move interrupt early register setup to KVM
      KVM: PPC: Book3S 64: move bad_host_intr check to HV handler
      KVM: PPC: Book3S 64: Minimise hcall handler calling convention differences
      KVM: PPC: Book3S HV P9: implement kvmppc_xive_pull_vcpu in C
      KVM: PPC: Book3S HV P9: Move setting HDEC after switching to guest LPCR
      KVM: PPC: Book3S HV P9: Reduce irq_work vs guest decrementer races
      KVM: PPC: Book3S HV P9: Move xive vcpu context management into kvmhv_p9_guest_entry
      KVM: PPC: Book3S HV P9: Move radix MMU switching instructions together
      KVM: PPC: Book3S HV P9: Stop handling hcalls in real-mode in the P9 path
      KVM: PPC: Book3S HV P9: Implement the rest of the P9 path in C
      KVM: PPC: Book3S HV P9: inline kvmhv_load_hv_regs_and_go into __kvmhv_vcpu_entry_p9
      KVM: PPC: Book3S HV P9: Read machine check registers while MSR[RI] is 0
      KVM: PPC: Book3S HV P9: Improve exit timing accounting coverage
      KVM: PPC: Book3S HV P9: Move SPR loading after expiry time check
      KVM: PPC: Book3S HV P9: Add helpers for OS SPR handling
      KVM: PPC: Book3S HV P9: Switch to guest MMU context as late as possible
      KVM: PPC: Book3S HV: Implement radix prefetch workaround by disabling MMU
      KVM: PPC: Book3S HV: Remove support for dependent threads mode on P9
      KVM: PPC: Book3S HV: Remove radix guest support from P7/8 path
      KVM: PPC: Book3S HV: Remove virt mode checks from real mode handlers
      KVM: PPC: Book3S HV: Remove unused nested HV tests in XICS emulation
      KVM: PPC: Book3S HV P9: Allow all P9 processors to enable nested HV
      KVM: PPC: Book3S HV: small pseries_do_hcall cleanup
      KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults
      KVM: PPC: Book3S HV P9: Reflect userspace hcalls to hash guests to support PR KVM
      KVM: PPC: Book3S HV P9: implement hash guest support
      KVM: PPC: Book3S HV P9: implement hash host / hash guest support
      KVM: PPC: Book3S HV: remove ISA v3.0 and v3.1 support from P7/8 path

Paolo Bonzini (5):
      KVM: switch per-VM stats to u64
      KVM: x86: Stub out is_tdp_mmu_root on 32-bit hosts
      Merge branch 'topic/ppc-kvm' of https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux into HEAD
      Merge tag 'kvm-s390-next-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Quentin Perret (7):
      KVM: arm64: Move hyp_pool locking out of refcount helpers
      KVM: arm64: Use refcount at hyp to check page availability
      KVM: arm64: Remove list_head from hyp_page
      KVM: arm64: Unify MMIO and mem host stage-2 pools
      KVM: arm64: Remove hyp_pool pointer from struct hyp_page
      KVM: arm64: Use less bits for hyp_page order
      KVM: arm64: Use less bits for hyp_page refcount

Ricardo Koller (6):
      KVM: selftests: Rename vm_handle_exception
      KVM: selftests: Complete x86_64/sync_regs_test ucall
      KVM: selftests: Introduce UCALL_UNHANDLED for unhandled vector reporting
      KVM: selftests: Move GUEST_ASSERT_EQ to utils header
      KVM: selftests: Add exception handling support for aarch64
      KVM: selftests: Add aarch64/debug-exceptions test

Sean Christopherson (107):
      KVM: x86: Emulate triple fault shutdown if RSM emulation fails
      KVM: x86: Replace .set_hflags() with dedicated .exiting_smm() helper
      KVM: x86: Invoke kvm_smm_changed() immediately after clearing SMM flag
      KVM: x86: Move (most) SMM hflags modifications into kvm_smm_changed()
      KVM: x86: Move "entering SMM" tracepoint into kvm_smm_changed()
      KVM: x86: Rename SMM tracepoint to make it reflect reality
      KVM: x86: Drop .post_leave_smm(), i.e. the manual post-RSM MMU reset
      KVM: x86: Drop "pre_" from enter/leave_smm() helpers
      KVM: nVMX: Drop obsolete (and pointless) pdptrs_changed() check
      KVM: nSVM: Drop pointless pdptrs_changed() check on nested transition
      KVM: x86: Always load PDPTRs on CR3 load for SVM w/o NPT and a PAE guest
      KVM: nVMX: Sync all PGDs on nested transition with shadow paging
      KVM: nVMX: Ensure 64-bit shift when checking VMFUNC bitmap
      KVM: nVMX: Don't clobber nested MMU's A/D status on EPTP switch
      KVM: x86: Invalidate all PGDs for the current PCID on MOV CR3 w/ flush
      KVM: x86: Uncondtionally skip MMU sync/TLB flush in MOV CR3's PGD switch
      KVM: nSVM: Move TLB flushing logic (or lack thereof) to dedicated helper
      KVM: x86: Drop skip MMU sync and TLB flush params from "new PGD" helpers
      KVM: nVMX: Consolidate VM-Enter/VM-Exit TLB flush and MMU sync logic
      KVM: nVMX: Free only guest_mode (L2) roots on INVVPID w/o EPT
      KVM: x86: Use KVM_REQ_TLB_FLUSH_GUEST to handle INVPCID(ALL) emulation
      KVM: nVMX: Use fast PGD switch when emulating VMFUNC[EPTP_SWITCH]
      KVM: x86: Defer MMU sync on PCID invalidation
      KVM: x86: Drop pointless @reset_roots from kvm_init_mmu()
      KVM: nVMX: WARN if subtly-impossible VMFUNC conditions occur
      KVM: nVMX: Drop redundant checks on vmcs12 in EPTP switching emulation
      KVM: x86/mmu: Grab nx_lpage_splits as an unsigned long before division
      KVM: VMX: Refuse to load kvm_intel if EPT and NX are disabled
      KVM: SVM: Refuse to load kvm_amd if NX support is not available
      KVM: x86: WARN and reject loading KVM if NX is supported but not enabled
      KVM: nVMX: Dynamically compute max VMCS index for vmcs12
      KVM: nVMX: Handle split-lock #AC exceptions that happen in L2
      KVM: selftests: Remove errant asm/barrier.h include to fix arm64 build
      KVM: selftests: Zero out the correct page in the Hyper-V features test
      KVM: selftests: Unconditionally use memslot 0 when loading elf binary
      KVM: selftests: Unconditionally use memslot 0 for x86's GDT/TSS setup
      KVM: selftests: Use "standard" min virtual address for Hyper-V pages
      KVM: selftests: Add helpers to allocate N pages of virtual memory
      KVM: selftests: Lower the min virtual address for misc page allocations
      KVM: selftests: Use alloc_page helper for x86-64's GDT/IDT/TSS allocations
      KVM: selftests: Use alloc page helper for xAPIC IPI test
      KVM: selftests: Use "standard" min virtual address for CPUID test alloc
      KVM: selftests: Unconditionally use memslot 0 for vaddr allocations
      KVM: selftests: Unconditionally use memslot '0' for page table allocations
      KVM: selftests: Unconditionally allocate EPT tables in memslot 0
      KVM: selftests: Add wrapper to allocate page table page
      KVM: selftests: Rename x86's page table "address" to "pfn"
      KVM: selftests: Add PTE helper for x86-64 in preparation for hugepages
      KVM: selftests: Genericize upper level page table entry struct
      KVM: selftests: Add hugepage support for x86-64
      KVM: sefltests: Add x86-64 test to verify MMU reacts to CPUID updates
      KVM: x86/mmu: Don't WARN on a NULL shadow page in TDP MMU check
      KVM: x86/mmu: Remove broken WARN that fires on 32-bit KVM w/ nested EPT
      KVM: x86/mmu: Treat NX as used (not reserved) for all !TDP shadow MMUs
      KVM: x86: Properly reset MMU context at vCPU RESET/INIT
      KVM: x86/mmu: Use MMU's role to detect CR4.SMEP value in nested NPT walk
      Revert "KVM: x86/mmu: Drop kvm_mmu_extended_role.cr4_la57 hack"
      KVM: x86: Force all MMUs to reinitialize if guest CPUID is modified
      KVM: x86: Alert userspace that KVM_SET_CPUID{,2} after KVM_RUN is broken
      Revert "KVM: MMU: record maximum physical address width in kvm_mmu_extended_role"
      KVM: x86/mmu: Unconditionally zap unsync SPs when creating >4k SP at GFN
      KVM: x86/mmu: Use MMU role to check for matching guest page sizes
      KVM: x86/mmu: WARN and zap SP when sync'ing if MMU role mismatches
      KVM: x86/mmu: comment on kvm_mmu_get_page's syncing of pages
      KVM: x86/mmu: Drop the intermediate "transient" __kvm_sync_page()
      KVM: x86/mmu: Rename unsync helper and update related comments
      KVM: x86: Fix sizes used to pass around CR0, CR4, and EFER
      KVM: nSVM: Add a comment to document why nNPT uses vmcb01, not vCPU state
      KVM: x86/mmu: Drop smep_andnot_wp check from "uses NX" for shadow MMUs
      KVM: x86: Read and pass all CR0/CR4 role bits to shadow MMU helper
      KVM: x86/mmu: Move nested NPT reserved bit calculation into MMU proper
      KVM: x86/mmu: Grab shadow root level from mmu_role for shadow MMUs
      KVM: x86/mmu: Add struct and helpers to retrieve MMU role bits from regs
      KVM: x86/mmu: Consolidate misc updates into shadow_mmu_init_context()
      KVM: x86/mmu: Ignore CR0 and CR4 bits in nested EPT MMU role
      KVM: x86/mmu: Use MMU's role_regs, not vCPU state, to compute mmu_role
      KVM: x86/mmu: Rename "nxe" role bit to "efer_nx" for macro shenanigans
      KVM: x86/mmu: Add accessors to query mmu_role bits
      KVM: x86/mmu: Do not set paging-related bits in MMU role if CR0.PG=0
      KVM: x86/mmu: Set CR4.PKE/LA57 in MMU role iff long mode is active
      KVM: x86/mmu: Always set new mmu_role immediately after checking old role
      KVM: x86/mmu: Don't grab CR4.PSE for calculating shadow reserved bits
      KVM: x86/mmu: Use MMU's role to get CR4.PSE for computing rsvd bits
      KVM: x86/mmu: Drop vCPU param from reserved bits calculator
      KVM: x86/mmu: Use MMU's role to compute permission bitmask
      KVM: x86/mmu: Use MMU's role to compute PKRU bitmask
      KVM: x86/mmu: Use MMU's roles to compute last non-leaf level
      KVM: x86/mmu: Use MMU's role to detect EFER.NX in guest page walk
      KVM: x86/mmu: Use MMU's role/role_regs to compute context's metadata
      KVM: x86/mmu: Use MMU's role to get EFER.NX during MMU configuration
      KVM: x86/mmu: Drop "nx" from MMU context now that there are no readers
      KVM: x86/mmu: Get nested MMU's root level from the MMU's role
      KVM: x86/mmu: Use MMU role_regs to get LA57, and drop vCPU LA57 helper
      KVM: x86/mmu: Consolidate reset_rsvds_bits_mask() calls
      KVM: x86/mmu: Don't update nested guest's paging bitmasks if CR0.PG=0
      KVM: x86/mmu: Add helper to update paging metadata
      KVM: x86/mmu: Add a helper to calculate root from role_regs
      KVM: x86/mmu: Collapse 32-bit PAE and 64-bit statements for helpers
      KVM: x86/mmu: Use MMU's role to determine PTTYPE
      KVM: x86/mmu: Add helpers to do full reserved SPTE checks w/ generic MMU
      KVM: x86/mmu: WARN on any reserved SPTE value when making a valid SPTE
      KVM: x86: Enhance comments for MMU roles and nested transition trickiness
      KVM: x86/mmu: Optimize and clean up so called "last nonleaf level" logic
      KVM: x86/mmu: Drop redundant rsvd bits reset for nested NPT
      KVM: x86/mmu: Get CR0.WP from MMU, not vCPU, in shadow page fault
      KVM: x86/mmu: Get CR4.SMEP from MMU, not vCPU, in shadow page fault
      KVM: x86/mmu: Let guest use GBPAGES if supported in hardware and TDP is on

Sergey Senozhatsky (2):
      kvm: add PM-notifier
      kvm: x86: implement KVM PM-notifier

Shaokun Zhang (1):
      KVM: x86/mmu: Make is_nx_huge_page_enabled an inline function

Siddharth Chandrasekaran (4):
      KVM: x86: Move FPU register accessors into fpu.h
      KVM: hyper-v: Collect hypercall params into struct
      KVM: x86: kvm_hv_flush_tlb use inputs from XMM registers
      KVM: hyper-v: Advertise support for fast XMM hypercalls

Steven Price (6):
      arm64: mte: Sync tags for pages where PTE is untagged
      KVM: arm64: Introduce MTE VM feature
      KVM: arm64: Save/restore MTE registers
      KVM: arm64: Expose KVM_ARM_CAP_MTE
      KVM: arm64: Add ioctl to fetch/store tags in a guest
      KVM: arm64: Document MTE capability and ioctl

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S HV: Fix TLB management on SMT8 POWER9 and POWER10 processors

Vineeth Pillai (7):
      hyperv: Detect Nested virtualization support for SVM
      hyperv: SVM enlightened TLB flush support flag
      KVM: x86: hyper-v: Move the remote TLB flush logic out of vmx
      KVM: SVM: Software reserved fields
      KVM: SVM: hyper-v: Remote TLB flush for SVM
      KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
      KVM: SVM: hyper-v: Direct Virtual Flush support

Vitaly Kuznetsov (44):
      KVM: x86: Use common 'enable_apicv' variable for both APICv and AVIC
      KVM: x86: Drop vendor specific functions for APICv/AVIC enablement
      asm-generic/hyperv: add HV_STATUS_ACCESS_DENIED definition
      KVM: x86: hyper-v: Introduce KVM_CAP_HYPERV_ENFORCE_CPUID
      KVM: x86: hyper-v: Cache guest CPUID leaves determining features availability
      KVM: x86: hyper-v: Prepare to check access to Hyper-V MSRs
      KVM: x86: hyper-v: Honor HV_MSR_HYPERCALL_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_VP_RUNTIME_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_TIME_REF_COUNT_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_VP_INDEX_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_RESET_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_REFERENCE_TSC_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_SYNIC_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_SYNTIMER_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_MSR_APIC_ACCESS_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_ACCESS_FREQUENCY_MSRS privilege bit
      KVM: x86: hyper-v: Honor HV_ACCESS_REENLIGHTENMENT privilege bit
      KVM: x86: hyper-v: Honor HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE privilege bit
      KVM: x86: hyper-v: Honor HV_FEATURE_DEBUG_MSRS_AVAILABLE privilege bit
      KVM: x86: hyper-v: Inverse the default in hv_check_msr_access()
      KVM: x86: hyper-v: Honor HV_STIMER_DIRECT_MODE_AVAILABLE privilege bit
      KVM: x86: hyper-v: Prepare to check access to Hyper-V hypercalls
      KVM: x86: hyper-v: Check access to HVCALL_NOTIFY_LONG_SPIN_WAIT hypercall
      KVM: x86: hyper-v: Honor HV_POST_MESSAGES privilege bit
      KVM: x86: hyper-v: Honor HV_SIGNAL_EVENTS privilege bit
      KVM: x86: hyper-v: Honor HV_DEBUGGING privilege bit
      KVM: x86: hyper-v: Honor HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED bit
      KVM: x86: hyper-v: Honor HV_X64_CLUSTER_IPI_RECOMMENDED bit
      KVM: x86: hyper-v: Honor HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED bit
      KVM: selftests: move Hyper-V MSR definitions to hyperv.h
      KVM: selftests: Move evmcs.h to x86_64/
      KVM: selftests: Introduce hyperv_features test
      KVM: nVMX: Use '-1' in 'hv_evmcs_vmptr' to indicate that eVMCS is not in use
      KVM: nVMX: Don't set 'dirty_vmcs12' flag on enlightened VMPTRLD
      KVM: nVMX: Release eVMCS when enlightened VMENTRY was disabled
      KVM: nVMX: Make copy_vmcs12_to_enlightened()/copy_enlightened_to_vmcs12() return 'void'
      KVM: nVMX: Introduce 'EVMPTR_MAP_PENDING' post-migration state
      KVM: nVMX: Release enlightened VMCS on VMCLEAR
      KVM: nVMX: Ignore 'hv_clean_fields' data when eVMCS data is copied in vmx_get_nested_state()
      KVM: nVMX: Force enlightened VMCS sync from nested_vmx_failValid()
      KVM: nVMX: Reset eVMCS clean fields data from prepare_vmcs02()
      KVM: nVMX: Request to sync eVMCS from VMCS12 after migration
      KVM: selftests: evmcs_test: Test that KVM_STATE_NESTED_EVMCS is never lost
      KVM: x86: Check for pending interrupts when APICv is getting disabled

Wanpeng Li (1):
      KVM: LAPIC: Keep stored TMCCT register value 0 after KVM_SET_LAPIC

Yanan Wang (4):
      KVM: arm64: Introduce two cache maintenance callbacks
      KVM: arm64: Introduce mm_ops member for structure stage2_attr_data
      KVM: arm64: Tweak parameters of guest cache maintenance functions
      KVM: arm64: Move guest CMOs to the fault handlers

 .mailmap                                           |   1 +
 Documentation/ABI/obsolete/sysfs-class-dax         |   2 +-
 .../ABI/obsolete/sysfs-kernel-fadump_registered    |   2 +-
 .../ABI/obsolete/sysfs-kernel-fadump_release_mem   |   2 +-
 Documentation/ABI/removed/sysfs-bus-nfit           |   2 +-
 Documentation/ABI/testing/sysfs-bus-nfit           |  40 +-
 Documentation/ABI/testing/sysfs-bus-papr-pmem      |   4 +-
 Documentation/ABI/testing/sysfs-module             |   4 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  26 +-
 Documentation/block/data-integrity.rst             |   2 +-
 Documentation/cdrom/cdrom-standard.rst             |  30 +-
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   2 -
 Documentation/devicetree/bindings/i2c/i2c-mpc.yaml |   7 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   1 -
 Documentation/devicetree/bindings/input/input.yaml |   1 -
 .../bindings/interconnect/qcom,rpmh.yaml           |   1 -
 .../devicetree/bindings/leds/leds-bcm6328.txt      |   4 +-
 .../devicetree/bindings/leds/leds-bcm6358.txt      |   2 +-
 .../devicetree/bindings/media/renesas,drif.yaml    |  20 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          |   1 -
 .../devicetree/bindings/net/renesas,ether.yaml     |   2 +-
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |   1 -
 .../bindings/phy/phy-cadence-torrent.yaml          |   2 +-
 .../bindings/power/supply/sc2731-charger.yaml      |   2 +-
 .../devicetree/bindings/sound/fsl,rpmsg.yaml       |   2 +-
 Documentation/devicetree/bindings/spi/spi-mux.yaml |   2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst         |   2 +-
 Documentation/driver-api/serial/index.rst          |   1 -
 Documentation/driver-api/usb/usb.rst               |  17 +-
 Documentation/filesystems/erofs.rst                | 175 ++--
 Documentation/hwmon/tmp103.rst                     |   4 +-
 .../device_drivers/ethernet/intel/i40e.rst         |   4 +-
 .../device_drivers/ethernet/intel/iavf.rst         |   2 +-
 Documentation/powerpc/syscall64-abi.rst            |  10 +
 .../process/kernel-enforcement-statement.rst       |   2 +-
 Documentation/security/tpm/xen-tpmfront.rst        |   2 +-
 Documentation/timers/no_hz.rst                     |   2 +-
 Documentation/translations/zh_CN/SecurityBugs      |  50 --
 Documentation/usb/gadget_configfs.rst              |   2 +-
 Documentation/usb/mtouchusb.rst                    |   2 +-
 Documentation/usb/usb-serial.rst                   |   2 +-
 Documentation/userspace-api/seccomp_filter.rst     |  16 +-
 Documentation/virt/kvm/amd-memory-encryption.rst   |   2 +-
 Documentation/virt/kvm/api.rst                     | 356 +++++++-
 Documentation/virt/kvm/cpuid.rst                   |   7 +
 Documentation/virt/kvm/hypercalls.rst              |  21 +
 Documentation/virt/kvm/locking.rst                 |   5 +
 Documentation/virt/kvm/mmu.rst                     |   7 +-
 Documentation/virt/kvm/msr.rst                     |  13 +
 Documentation/x86/amd-memory-encryption.rst        |   6 +-
 MAINTAINERS                                        |  70 +-
 Makefile                                           |   7 +-
 arch/alpha/kernel/syscalls/syscall.tbl             |   2 +-
 arch/arc/Makefile                                  |   2 +-
 arch/arc/include/asm/cmpxchg.h                     |   4 +-
 arch/arc/include/asm/page.h                        |  12 +
 arch/arc/include/asm/pgtable.h                     |  12 +-
 arch/arc/include/uapi/asm/page.h                   |   1 -
 arch/arc/kernel/entry.S                            |   4 +-
 arch/arc/kernel/kgdb.c                             |   1 +
 arch/arc/kernel/process.c                          |   8 +-
 arch/arc/kernel/signal.c                           |   4 +-
 arch/arc/mm/init.c                                 |  11 +-
 arch/arc/mm/ioremap.c                              |   5 +-
 arch/arc/mm/tlb.c                                  |   2 +-
 arch/arm/mach-npcm/Kconfig                         |   1 +
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |   7 +-
 arch/arm/tools/syscall.tbl                         |   2 +-
 arch/arm/xen/mm.c                                  |  20 +-
 arch/arm64/Kbuild                                  |   3 +-
 arch/arm64/Makefile                                |   3 +
 ...hope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi |   2 -
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |   8 +
 .../boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts   |   2 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   4 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a77950.dtsi          |   4 +
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |  12 +
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   4 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |   8 +
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |   2 -
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   4 +
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   3 -
 arch/arm64/include/asm/Kbuild                      |   2 +
 arch/arm64/include/asm/alternative-macros.h        |   5 -
 arch/arm64/include/asm/arch_gicv3.h                |   3 +-
 arch/arm64/include/asm/assembler.h                 |  80 +-
 arch/arm64/include/asm/barrier.h                   |   2 +-
 arch/arm64/include/asm/cacheflush.h                |  71 +-
 arch/arm64/include/asm/cpucaps.h                   |  74 --
 arch/arm64/include/asm/efi.h                       |   2 +-
 arch/arm64/include/asm/kvm_arm.h                   |   3 +-
 arch/arm64/include/asm/kvm_emulate.h               |   3 +
 arch/arm64/include/asm/kvm_host.h                  |  23 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  17 +-
 arch/arm64/include/asm/kvm_mte.h                   |  66 ++
 arch/arm64/include/asm/kvm_pgtable.h               |  42 +-
 arch/arm64/include/asm/mte-def.h                   |   1 +
 arch/arm64/include/asm/mte.h                       |   4 +-
 arch/arm64/include/asm/pgtable.h                   |  22 +-
 arch/arm64/include/asm/sysreg.h                    |   3 +-
 arch/arm64/include/asm/unistd32.h                  |   3 +-
 arch/arm64/include/uapi/asm/kvm.h                  |  11 +
 arch/arm64/kernel/alternative.c                    |   2 +-
 arch/arm64/kernel/asm-offsets.c                    |   2 +
 arch/arm64/kernel/efi-entry.S                      |   9 +-
 arch/arm64/kernel/head.S                           |  13 +-
 arch/arm64/kernel/hibernate-asm.S                  |   7 +-
 arch/arm64/kernel/hibernate.c                      |  20 +-
 arch/arm64/kernel/idreg-override.c                 |   3 +-
 arch/arm64/kernel/image-vars.h                     |   2 +-
 arch/arm64/kernel/insn.c                           |   2 +-
 arch/arm64/kernel/kaslr.c                          |  12 +-
 arch/arm64/kernel/machine_kexec.c                  |  30 +-
 arch/arm64/kernel/mte.c                            |  18 +-
 arch/arm64/kernel/probes/uprobes.c                 |   2 +-
 arch/arm64/kernel/smp.c                            |   8 +-
 arch/arm64/kernel/smp_spin_table.c                 |   7 +-
 arch/arm64/kernel/sys_compat.c                     |   2 +-
 arch/arm64/kvm/Makefile                            |   2 +-
 arch/arm64/kvm/arch_timer.c                        | 162 +++-
 arch/arm64/kvm/arm.c                               |  22 +-
 arch/arm64/kvm/guest.c                             | 134 ++-
 arch/arm64/kvm/hyp/entry.S                         |   7 +
 arch/arm64/kvm/hyp/exception.c                     |   3 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   6 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  21 +
 arch/arm64/kvm/hyp/include/nvhe/gfp.h              |  45 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h      |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h           |   7 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h               |  13 +-
 arch/arm64/kvm/hyp/nvhe/cache.S                    |   4 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  60 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c               | 112 ++-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |  33 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                       |  61 +-
 arch/arm64/kvm/hyp/reserved_mem.c                  |   3 +-
 arch/arm64/kvm/mmu.c                               | 196 +++--
 arch/arm64/kvm/pmu-emul.c                          |   4 +
 arch/arm64/kvm/reset.c                             |   4 +
 arch/arm64/kvm/sys_regs.c                          |  32 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |  36 +-
 arch/arm64/kvm/vgic/vgic-v2.c                      |  19 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |  19 +-
 arch/arm64/kvm/vgic/vgic.c                         |  14 +-
 arch/arm64/lib/uaccess_flushcache.c                |   4 +-
 arch/arm64/mm/cache.S                              | 158 ++--
 arch/arm64/mm/flush.c                              |  33 +-
 arch/arm64/mm/init.c                               |   3 +-
 arch/arm64/mm/mmu.c                                |   3 +-
 arch/arm64/mm/proc.S                               |  12 +
 arch/arm64/tools/Makefile                          |  22 +
 arch/arm64/tools/cpucaps                           |  65 ++
 arch/arm64/tools/gen-cpucaps.awk                   |  40 +
 arch/ia64/kernel/syscalls/syscall.tbl              |   2 +-
 arch/m68k/kernel/signal.c                          |   3 +-
 arch/m68k/kernel/syscalls/syscall.tbl              |   2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl        |   2 +-
 arch/mips/alchemy/board-xxs1500.c                  |   1 +
 arch/mips/include/asm/kvm_host.h                   |   9 +-
 arch/mips/include/asm/mips-boards/launch.h         |   5 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   2 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   2 +-
 arch/mips/kvm/Makefile                             |   2 +-
 arch/mips/kvm/mips.c                               |  90 +-
 arch/mips/lib/mips-atomic.c                        |  12 +-
 arch/mips/ralink/of.c                              |   2 +
 arch/openrisc/include/asm/barrier.h                |   9 +
 arch/openrisc/kernel/setup.c                       |   2 +
 arch/openrisc/mm/init.c                            |   6 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |   2 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |   8 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  16 +
 arch/powerpc/include/asm/asm-prototypes.h          |   3 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |   1 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   4 +
 arch/powerpc/include/asm/cputhreads.h              |  30 +
 arch/powerpc/include/asm/exception-64s.h           |  13 +
 arch/powerpc/include/asm/hvcall.h                  |   7 +-
 arch/powerpc/include/asm/interrupt.h               |   9 +-
 arch/powerpc/include/asm/kvm_asm.h                 |   1 +
 arch/powerpc/include/asm/kvm_book3s.h              |   3 +
 arch/powerpc/include/asm/kvm_book3s_64.h           |   8 +
 arch/powerpc/include/asm/kvm_host.h                |  21 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |  18 +-
 arch/powerpc/include/asm/mmu_context.h             |  18 +-
 arch/powerpc/include/asm/paravirt.h                |  22 +-
 arch/powerpc/include/asm/plpar_wrappers.h          |   6 +-
 arch/powerpc/include/asm/ptrace.h                  |  45 +-
 arch/powerpc/include/asm/syscall.h                 |  42 +-
 arch/powerpc/include/asm/time.h                    |  12 +
 arch/powerpc/include/asm/uaccess.h                 |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/exceptions-64e.S               |  38 +-
 arch/powerpc/kernel/exceptions-64s.S               | 250 +-----
 arch/powerpc/kernel/interrupt.c                    |   4 +-
 arch/powerpc/kernel/legacy_serial.c                |   7 +-
 arch/powerpc/kernel/security.c                     |   5 +-
 arch/powerpc/kernel/setup_64.c                     |   4 +-
 arch/powerpc/kernel/signal.h                       |   4 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |   2 +-
 arch/powerpc/kernel/time.c                         |  10 -
 arch/powerpc/kvm/Makefile                          |   4 +-
 arch/powerpc/kvm/book3s.c                          | 108 ++-
 arch/powerpc/kvm/book3s_64_entry.S                 | 416 ++++++++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  27 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |  12 -
 arch/powerpc/kvm/book3s_hv.c                       | 811 ++++++++++--------
 arch/powerpc/kvm/book3s_hv_builtin.c               | 137 +---
 arch/powerpc/kvm/book3s_hv_interrupts.S            |   9 +-
 arch/powerpc/kvm/book3s_hv_nested.c                | 122 ++-
 arch/powerpc/kvm/book3s_hv_p9_entry.c              | 508 ++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  14 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |  15 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            | 689 +---------------
 arch/powerpc/kvm/book3s_pr.c                       |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c                  |   2 +-
 arch/powerpc/kvm/book3s_segment.S                  |   3 +
 arch/powerpc/kvm/book3s_xive.c                     | 113 ++-
 arch/powerpc/kvm/book3s_xive.h                     |   7 -
 arch/powerpc/kvm/book3s_xive_native.c              |  10 -
 arch/powerpc/kvm/booke.c                           |  76 +-
 arch/powerpc/kvm/powerpc.c                         |   3 +
 arch/powerpc/lib/feature-fixups.c                  | 114 ++-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |  32 +-
 arch/powerpc/mm/book3s64/radix_tlb.c               | 202 ++++-
 arch/powerpc/mm/mmu_context.c                      |   4 +-
 arch/powerpc/platforms/powernv/idle.c              |  52 +-
 arch/powerpc/platforms/pseries/hvCall.S            |  10 +
 arch/powerpc/platforms/pseries/lpar.c              |  29 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/kexec.h                     |   4 +-
 arch/riscv/kernel/machine_kexec.c                  |  11 +-
 arch/riscv/kernel/probes/kprobes.c                 |   2 +
 arch/riscv/kernel/stacktrace.c                     |  14 +-
 arch/s390/include/asm/kvm_host.h                   |   9 +-
 arch/s390/kernel/syscalls/syscall.tbl              |   2 +-
 arch/s390/kvm/Makefile                             |   3 +-
 arch/s390/kvm/kvm-s390.c                           | 254 +++---
 arch/s390/tools/gen_facilities.c                   |   4 +
 arch/sh/kernel/syscalls/syscall.tbl                |   2 +-
 arch/sh/kernel/traps.c                             |   1 -
 arch/sparc/kernel/syscalls/syscall.tbl             |   2 +-
 arch/x86/Makefile                                  |  12 +-
 arch/x86/boot/compressed/Makefile                  |   7 +-
 arch/x86/boot/compressed/misc.c                    |   2 +-
 arch/x86/boot/compressed/misc.h                    |   2 +-
 arch/x86/boot/compressed/{sev-es.c => sev.c}       |   4 +-
 arch/x86/entry/syscalls/syscall_32.tbl             |   2 +-
 arch/x86/entry/syscalls/syscall_64.tbl             |   2 +-
 arch/x86/events/core.c                             |   6 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/lbr.c                        |  26 +-
 arch/x86/events/perf_event.h                       |   6 +
 arch/x86/include/asm/hyperv-tlfs.h                 |  19 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   9 +-
 arch/x86/include/asm/kvm_host.h                    | 169 ++--
 arch/x86/include/asm/msr-index.h                   |   6 +-
 arch/x86/include/asm/processor.h                   |   2 +
 arch/x86/include/asm/sev-common.h                  |  62 ++
 arch/x86/include/asm/{sev-es.h => sev.h}           |  30 +-
 arch/x86/include/asm/svm.h                         |   9 +-
 arch/x86/include/asm/vdso/clocksource.h            |   2 +
 arch/x86/include/uapi/asm/kvm.h                    |  13 +
 arch/x86/include/uapi/asm/kvm_para.h               |  13 +
 arch/x86/include/uapi/asm/svm.h                    |   3 +
 arch/x86/kernel/Makefile                           |   6 +-
 arch/x86/kernel/cpu/amd.c                          |  20 +-
 arch/x86/kernel/cpu/mshyperv.c                     |  10 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |   4 +-
 arch/x86/kernel/head64.c                           |   2 +-
 arch/x86/kernel/mmconf-fam10h_64.c                 |   2 +-
 arch/x86/kernel/nmi.c                              |   2 +-
 arch/x86/kernel/{sev-es-shared.c => sev-shared.c}  |  21 +-
 arch/x86/kernel/{sev-es.c => sev.c}                | 140 ++--
 arch/x86/kernel/signal_compat.c                    |   9 +-
 arch/x86/kernel/smpboot.c                          |   2 +-
 arch/x86/kvm/Kconfig                               |   1 +
 arch/x86/kvm/Makefile                              |  11 +-
 arch/x86/kvm/cpuid.c                               |   6 +-
 arch/x86/kvm/debugfs.c                             |  11 +
 arch/x86/kvm/emulate.c                             | 166 +---
 arch/x86/kvm/fpu.h                                 | 140 ++++
 arch/x86/kvm/hyperv.c                              | 440 ++++++++--
 arch/x86/kvm/hyperv.h                              |   1 +
 arch/x86/kvm/kvm_cache_regs.h                      |  15 +
 arch/x86/kvm/kvm_emulate.h                         |  10 +-
 arch/x86/kvm/kvm_onhyperv.c                        |  93 +++
 arch/x86/kvm/kvm_onhyperv.h                        |  32 +
 arch/x86/kvm/lapic.c                               |  12 +-
 arch/x86/kvm/lapic.h                               |   2 +-
 arch/x86/kvm/mmu.h                                 |  30 +-
 arch/x86/kvm/mmu/mmu.c                             | 894 ++++++++++----------
 arch/x86/kvm/mmu/mmu_internal.h                    |  15 +-
 arch/x86/kvm/mmu/mmutrace.h                        |   2 +-
 arch/x86/kvm/mmu/page_track.c                      |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |  68 +-
 arch/x86/kvm/mmu/spte.c                            |  22 +-
 arch/x86/kvm/mmu/spte.h                            |  32 +
 arch/x86/kvm/mmu/tdp_mmu.c                         |  43 +-
 arch/x86/kvm/mmu/tdp_mmu.h                         |  35 +-
 arch/x86/kvm/svm/avic.c                            |  18 +-
 arch/x86/kvm/svm/nested.c                          |  91 +-
 arch/x86/kvm/svm/svm.c                             | 110 ++-
 arch/x86/kvm/svm/svm.h                             |  62 +-
 arch/x86/kvm/svm/svm_onhyperv.c                    |  41 +
 arch/x86/kvm/svm/svm_onhyperv.h                    | 130 +++
 arch/x86/kvm/trace.h                               |   2 +-
 arch/x86/kvm/vmx/capabilities.h                    |   1 -
 arch/x86/kvm/vmx/evmcs.c                           |   3 +
 arch/x86/kvm/vmx/evmcs.h                           |   8 +
 arch/x86/kvm/vmx/nested.c                          | 418 ++++++----
 arch/x86/kvm/vmx/nested.h                          |  11 +-
 arch/x86/kvm/vmx/vmcs.h                            |  13 +
 arch/x86/kvm/vmx/vmcs12.c                          |   1 +
 arch/x86/kvm/vmx/vmcs12.h                          |  10 +-
 arch/x86/kvm/vmx/vmx.c                             | 225 ++---
 arch/x86/kvm/vmx/vmx.h                             |  21 +-
 arch/x86/kvm/x86.c                                 | 911 +++++++++++++++------
 arch/x86/kvm/x86.h                                 |  10 -
 arch/x86/mm/extable.c                              |   2 +-
 arch/x86/mm/mem_encrypt_identity.c                 |   6 +-
 arch/x86/pci/amd_bus.c                             |   2 +-
 arch/x86/platform/efi/efi_64.c                     |   2 +-
 arch/x86/realmode/init.c                           |   2 +-
 arch/x86/realmode/rm/trampoline_64.S               |   4 +-
 arch/x86/xen/enlighten_pv.c                        |   8 +-
 arch/xtensa/kernel/syscalls/syscall.tbl            |   2 +-
 block/bfq-iosched.c                                |  34 +-
 block/blk-iocost.c                                 |  14 +-
 block/blk-mq-sched.c                               |   8 +-
 block/blk-mq.c                                     |  11 +-
 block/genhd.c                                      |  11 +-
 block/kyber-iosched.c                              |   5 +-
 block/mq-deadline.c                                |   3 +-
 block/partitions/efi.c                             |   2 +-
 drivers/acpi/acpi_apd.c                            |   1 +
 drivers/acpi/device_pm.c                           |   1 +
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/nfit/core.c                           |  15 +-
 drivers/acpi/power.c                               |  61 +-
 drivers/acpi/scan.c                                |   3 +
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/sleep.h                               |   1 -
 drivers/android/binder.c                           |   2 +-
 drivers/base/core.c                                |  71 +-
 drivers/base/power/runtime.c                       |  10 +-
 drivers/block/nbd.c                                |  10 +-
 drivers/cdrom/gdrom.c                              |  13 +-
 drivers/char/hpet.c                                |   2 +
 drivers/char/tpm/tpm2-cmd.c                        |   1 +
 drivers/char/tpm/tpm_tis_core.c                    |  22 +-
 drivers/clk/clk.c                                  |   9 +
 drivers/clocksource/hyperv_timer.c                 |   4 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   6 +-
 drivers/cpufreq/intel_pstate.c                     |  14 +-
 drivers/crypto/cavium/nitrox/nitrox_main.c         |   1 -
 drivers/dma-buf/dma-buf.c                          |  10 +-
 drivers/dma/qcom/hidma_mgmt.c                      |  17 +-
 drivers/edac/amd64_edac.c                          |   2 +-
 drivers/firmware/arm_scmi/notify.h                 |   2 -
 drivers/firmware/arm_scpi.c                        |   4 +-
 drivers/gpio/gpio-cadence.c                        |   1 +
 drivers/gpio/gpio-tegra186.c                       |  11 -
 drivers/gpio/gpio-xilinx.c                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  28 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  38 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   5 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  19 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  13 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  18 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   7 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   7 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   7 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   6 +
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 174 ++--
 drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h    |  34 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   9 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  10 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   2 +-
 drivers/gpu/drm/i915/Kconfig                       |   1 -
 drivers/gpu/drm/i915/display/intel_dp.c            |  61 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  71 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   2 +
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         |   5 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   1 -
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |   4 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     | 124 +--
 drivers/gpu/drm/i915/gvt/gvt.h                     |   3 -
 drivers/gpu/drm/i915/gvt/hypercall.h               |   2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   | 122 ++-
 drivers/gpu/drm/i915/gvt/mpt.h                     |   4 +-
 drivers/gpu/drm/i915/i915_active.c                 |   3 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  11 +-
 drivers/gpu/drm/i915/i915_mm.c                     |  73 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   9 +-
 drivers/gpu/drm/msm/dp/dp_audio.c                  |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  26 +-
 drivers/gpu/drm/msm/dp/dp_display.h                |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c    |   4 +
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  16 +-
 drivers/gpu/drm/msm/msm_gem.h                      |   4 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    | 144 ++--
 drivers/gpu/drm/radeon/nislands_smc.h              |  34 +-
 drivers/gpu/drm/radeon/radeon.h                    |   1 +
 drivers/gpu/drm/radeon/radeon_gart.c               |   3 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |   8 +
 drivers/gpu/drm/radeon/si_dpm.c                    | 177 ++--
 drivers/gpu/drm/radeon/sislands_smc.h              |  34 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   2 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |   6 -
 drivers/hwmon/adm9240.c                            |   2 +-
 drivers/hwmon/corsair-psu.c                        |   4 +-
 drivers/hwmon/lm80.c                               |  11 +-
 drivers/hwmon/ltc2992.c                            |   8 +-
 drivers/hwmon/occ/common.c                         |   5 +-
 drivers/hwmon/occ/common.h                         |   2 +-
 drivers/hwmon/pmbus/fsp-3y.c                       |  27 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-ali1563.c                   |   2 +-
 drivers/i2c/busses/i2c-cadence.c                   |   2 +-
 drivers/i2c/busses/i2c-designware-master.c         |   2 +-
 drivers/i2c/busses/i2c-eg20t.c                     |   3 +-
 drivers/i2c/busses/i2c-i801.c                      |   6 +-
 drivers/i2c/busses/i2c-icy.c                       |   1 -
 drivers/i2c/busses/i2c-mpc.c                       |  81 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |   5 +
 drivers/i2c/busses/i2c-nomadik.c                   |   2 +-
 drivers/i2c/busses/i2c-ocores.c                    |   8 +-
 drivers/i2c/busses/i2c-pnx.c                       |   8 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 |   2 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   3 +
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +-
 drivers/i2c/busses/i2c-st.c                        |   4 +-
 drivers/i2c/busses/i2c-stm32f4.c                   |   2 +-
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |   4 +-
 drivers/iio/accel/Kconfig                          |   1 -
 drivers/iio/adc/ad7124.c                           |  36 +-
 drivers/iio/adc/ad7192.c                           |  19 +-
 drivers/iio/adc/ad7768-1.c                         |   8 +-
 drivers/iio/adc/ad7793.c                           |   1 +
 drivers/iio/adc/ad7923.c                           |   4 +-
 drivers/iio/common/hid-sensors/Kconfig             |   1 +
 drivers/iio/dac/ad5770r.c                          |  16 +-
 drivers/iio/gyro/Kconfig                           |   1 -
 drivers/iio/gyro/fxas21002c_core.c                 |   2 +
 drivers/iio/gyro/mpu3050-core.c                    |  13 +-
 drivers/iio/humidity/Kconfig                       |   1 -
 drivers/iio/industrialio-core.c                    |   9 +-
 drivers/iio/light/Kconfig                          |   2 -
 drivers/iio/light/gp2ap002.c                       |   5 +-
 drivers/iio/light/tsl2583.c                        |   8 +
 drivers/iio/magnetometer/Kconfig                   |   1 -
 drivers/iio/orientation/Kconfig                    |   2 -
 drivers/iio/pressure/Kconfig                       |   1 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 +
 drivers/iio/temperature/Kconfig                    |   1 -
 drivers/infiniband/core/cma.c                      |   5 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |   7 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   6 +-
 drivers/infiniband/hw/mlx5/dm.c                    |   3 +
 drivers/infiniband/hw/mlx5/main.c                  |   1 +
 drivers/infiniband/hw/mlx5/mr.c                    |   4 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  16 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +
 drivers/infiniband/sw/siw/siw_verbs.c              |  11 +-
 drivers/interconnect/qcom/bcm-voter.c              |   4 +-
 drivers/iommu/amd/iommu.c                          |   4 +-
 drivers/iommu/intel/dmar.c                         |   4 +-
 drivers/iommu/intel/iommu.c                        |   9 +-
 drivers/iommu/intel/pasid.c                        |   3 +-
 drivers/iommu/virtio-iommu.c                       |   1 +
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/irq-apple-aic.c                    |   9 +
 drivers/irqchip/irq-gic-common.c                   |  13 -
 drivers/irqchip/irq-gic-common.h                   |   2 -
 drivers/irqchip/irq-gic-v3.c                       |   6 +-
 drivers/irqchip/irq-gic.c                          |   6 +-
 drivers/irqchip/irq-mvebu-icu.c                    |   4 +-
 drivers/irqchip/irq-mvebu-sei.c                    |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |   4 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c              |  17 +-
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        |  21 +-
 drivers/isdn/hardware/mISDN/netjet.c               |   1 -
 drivers/leds/leds-lp5523.c                         |   2 +-
 drivers/md/dm-integrity.c                          |  81 +-
 drivers/md/dm-snap.c                               |   3 +-
 drivers/md/dm-verity-verify-sig.c                  |   2 +-
 drivers/md/raid5.c                                 |   2 -
 drivers/media/dvb-frontends/sp8870.c               |   2 +-
 drivers/media/platform/rcar_drif.c                 |   1 -
 drivers/media/usb/gspca/cpia1.c                    |   6 +-
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c      |  16 +-
 drivers/media/usb/gspca/m5602/m5602_po1030.c       |  14 +-
 drivers/misc/eeprom/at24.c                         |   6 +-
 .../misc/habanalabs/common/command_submission.c    |   2 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  53 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  23 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   7 +
 drivers/misc/habanalabs/common/sysfs.c             |   4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  59 +-
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |  12 +-
 drivers/misc/habanalabs/goya/goya.c                |  47 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  40 +-
 drivers/misc/ics932s401.c                          |   2 +-
 drivers/misc/kgdbts.c                              |   3 +-
 drivers/misc/lis3lv02d/lis3lv02d.h                 |   1 +
 drivers/misc/mei/interrupt.c                       |   3 +
 drivers/mmc/host/meson-gx-mmc.c                    |   7 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |   7 +-
 drivers/mtd/nand/raw/cs553x_nand.c                 |  12 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |  12 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                 |  15 +-
 drivers/mtd/nand/raw/ndfc.c                        |  12 +-
 drivers/mtd/nand/raw/sharpsl.c                     |  12 +-
 drivers/mtd/nand/raw/tmio_nand.c                   |   8 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                   |   5 +-
 drivers/mtd/parsers/ofpart_core.c                  |  26 +-
 drivers/net/appletalk/cops.c                       |   4 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/caif/caif_serial.c                     |   3 -
 drivers/net/dsa/bcm_sf2.c                          |   5 +-
 drivers/net/dsa/microchip/ksz9477.c                |   1 +
 drivers/net/dsa/mt7530.c                           |   8 -
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  15 +-
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c   |  23 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |  74 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 138 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  10 +
 drivers/net/ethernet/cadence/macb_main.c           |   3 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  27 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |  27 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   2 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |  80 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.h      |   2 +
 .../chelsio/inline_crypto/chtls/chtls_io.c         |   6 +-
 drivers/net/ethernet/freescale/fec_main.c          |  24 +-
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  21 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |  10 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 110 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  64 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  16 +-
 drivers/net/ethernet/korina.c                      |  12 +-
 drivers/net/ethernet/lantiq_xrx200.c               |  14 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |  22 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  54 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   4 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  77 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |  24 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/port.c          | 107 ++-
 .../net/ethernet/mellanox/mlx5/core/en/rep/bond.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  28 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   1 +
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |  61 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag_mp.c   |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  22 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |  18 +-
 drivers/net/ethernet/microchip/encx24j600.c        |   2 +-
 drivers/net/ethernet/microchip/encx24j600_hw.h     |   2 +-
 drivers/net/ethernet/pensando/Kconfig              |   1 +
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   3 +-
 drivers/net/ethernet/sfc/nic.c                     |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  32 +-
 drivers/net/ethernet/sun/niu.c                     |  32 +-
 drivers/net/ethernet/ti/netcp_core.c               |   4 +-
 drivers/net/ipa/ipa.h                              |   2 +
 drivers/net/ipa/ipa_mem.c                          |   3 +-
 drivers/net/mdio/mdio-octeon.c                     |   2 -
 drivers/net/mdio/mdio-thunder.c                    |   1 -
 drivers/net/phy/mdio_bus.c                         |   3 +-
 drivers/net/usb/cdc_eem.c                          |   2 +-
 drivers/net/usb/hso.c                              |  45 +-
 drivers/net/usb/lan78xx.c                          |   1 +
 drivers/net/usb/r8152.c                            |  42 +-
 drivers/net/usb/smsc75xx.c                         |   8 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           | 201 ++++-
 drivers/net/wireless/ath/ath10k/rx_desc.h          |  14 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  34 +
 drivers/net/wireless/ath/ath11k/dp_rx.h            |   1 +
 drivers/net/wireless/ath/ath11k/mac.c              |   6 +
 drivers/net/wireless/ath/ath6kl/debug.c            |   5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   8 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |  19 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  42 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.h    |   5 -
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   8 +-
 drivers/net/wireless/marvell/libertas/mesh.c       |  33 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |  18 +-
 drivers/nfc/nfcmrvl/fw_dnld.h                      |   2 +-
 drivers/nfc/nfcmrvl/i2c.c                          |   2 +-
 drivers/nfc/nfcmrvl/nfcmrvl.h                      |   2 +-
 drivers/nfc/nfcmrvl/spi.c                          |   2 +-
 drivers/nfc/nfcmrvl/uart.c                         |   2 +-
 drivers/nfc/nfcmrvl/usb.c                          |   2 +-
 drivers/nvme/host/Kconfig                          |   3 +-
 drivers/nvme/host/core.c                           |   7 +-
 drivers/nvme/host/fabrics.c                        |   5 +
 drivers/nvme/host/fc.c                             |  37 +-
 drivers/nvme/host/multipath.c                      |  55 +-
 drivers/nvme/host/nvme.h                           |   8 +-
 drivers/nvme/host/tcp.c                            |   5 +-
 drivers/nvme/target/admin-cmd.c                    |   7 +-
 drivers/nvme/target/core.c                         |  17 +-
 drivers/nvme/target/discovery.c                    |   2 +-
 drivers/nvme/target/fabrics-cmd.c                  |   6 +-
 drivers/nvme/target/io-cmd-bdev.c                  |   2 +-
 drivers/nvme/target/io-cmd-file.c                  |   8 +-
 drivers/nvme/target/loop.c                         |   4 +-
 drivers/nvme/target/nvmet.h                        |   8 +-
 drivers/nvme/target/passthru.c                     |   2 +-
 drivers/nvme/target/rdma.c                         |   4 +-
 drivers/nvme/target/tcp.c                          |   2 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  11 +-
 drivers/platform/surface/aggregator/controller.c   |   3 +-
 drivers/platform/surface/surface_dtx.c             |   8 +-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c        |   3 +-
 drivers/platform/x86/gigabyte-wmi.c                |  38 +-
 drivers/platform/x86/hp-wireless.c                 |   2 +
 drivers/platform/x86/hp_accel.c                    |  22 +-
 drivers/platform/x86/ideapad-laptop.c              |  13 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |  80 +-
 drivers/platform/x86/intel_punit_ipc.c             |   1 +
 drivers/platform/x86/touchscreen_dmi.c             |  43 +
 drivers/ptp/ptp_ocp.c                              |   4 +-
 drivers/rapidio/rio_cm.c                           |  17 +-
 drivers/s390/block/dasd_diag.c                     |   8 +-
 drivers/s390/block/dasd_fba.c                      |   8 +-
 drivers/s390/block/dasd_int.h                      |   1 -
 drivers/s390/cio/vfio_ccw_cp.c                     |   4 +
 drivers/s390/cio/vfio_ccw_drv.c                    |  12 +-
 drivers/s390/cio/vfio_ccw_fsm.c                    |   1 +
 drivers/s390/cio/vfio_ccw_ops.c                    |   2 -
 drivers/scsi/BusLogic.c                            |   6 +-
 drivers/scsi/BusLogic.h                            |   2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y          |   1 -
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h        |   2 +-
 drivers/scsi/aic7xxx/scsi_message.h                |  11 +
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |   1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   8 +-
 drivers/scsi/libsas/sas_port.c                     |   4 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  10 +-
 drivers/scsi/pm8001/pm8001_init.c                  |   2 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |   7 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  12 +-
 drivers/scsi/qedf/qedf_main.c                      |   4 +-
 drivers/scsi/qla2xxx/qla_nx.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   2 +
 drivers/scsi/ufs/ufs-hisi.c                        |  15 +-
 drivers/scsi/ufs/ufs-mediatek.c                    |   4 +
 drivers/scsi/ufs/ufshcd.c                          |   5 +-
 drivers/scsi/vmw_pvscsi.c                          |   8 +-
 drivers/soundwire/qcom.c                           |  12 +-
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |   4 +-
 drivers/spi/spi-sc18is602.c                        |   9 +-
 drivers/spi/spi-sprd.c                             |   1 +
 drivers/spi/spi-zynq-qspi.c                        |   9 +-
 drivers/spi/spi.c                                  |  51 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   4 +-
 drivers/staging/iio/cdc/ad7746.c                   |   1 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  23 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  21 +-
 drivers/target/target_core_iblock.c                |   4 +-
 drivers/target/target_core_transport.c             |   2 +-
 drivers/target/target_core_user.c                  |  12 +-
 drivers/tee/amdtee/amdtee_private.h                |  13 +
 drivers/tee/amdtee/call.c                          |  94 ++-
 drivers/tee/amdtee/core.c                          |  15 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   4 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
 drivers/thunderbolt/dma_port.c                     |  11 +-
 drivers/thunderbolt/usb4.c                         |   9 +-
 drivers/tty/serial/8250/8250.h                     |  32 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   1 +
 drivers/tty/serial/8250/8250_dw.c                  |   1 +
 drivers/tty/serial/8250/8250_pci.c                 |  47 +-
 drivers/tty/serial/8250/8250_port.c                |  12 +
 drivers/tty/serial/max310x.c                       |   2 +
 drivers/tty/serial/mvebu-uart.c                    |   3 -
 drivers/tty/serial/rp2.c                           |  52 +-
 drivers/tty/serial/serial-tegra.c                  |   2 +-
 drivers/tty/serial/serial_core.c                   |   8 +-
 drivers/tty/serial/sh-sci.c                        |   4 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/tty/vt/vt_ioctl.c                          |  57 +-
 drivers/uio/uio_hv_generic.c                       |  12 +-
 drivers/uio/uio_pci_generic.c                      |   2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   4 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |  14 +-
 drivers/usb/chipidea/udc.c                         |   1 +
 drivers/usb/class/cdc-wdm.c                        |  30 +-
 drivers/usb/core/devio.c                           |  11 +-
 drivers/usb/core/hub.c                             |   6 +-
 drivers/usb/dwc2/core.h                            |   2 +
 drivers/usb/dwc2/gadget.c                          |   3 +-
 drivers/usb/dwc2/platform.c                        |   4 -
 drivers/usb/dwc3/core.h                            |   7 +-
 drivers/usb/dwc3/debug.h                           |   8 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |   3 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   5 +
 drivers/usb/dwc3/dwc3-pci.c                        |   1 +
 drivers/usb/dwc3/gadget.c                          |  26 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   5 +-
 drivers/usb/host/fotg210-hcd.c                     |   4 +-
 drivers/usb/host/xhci-ext-caps.h                   |   5 +-
 drivers/usb/host/xhci-pci.c                        |   8 +-
 drivers/usb/host/xhci-ring.c                       |  30 +-
 drivers/usb/host/xhci.c                            |   6 +-
 drivers/usb/misc/trancevibrator.c                  |   4 +-
 drivers/usb/misc/uss720.c                          |   1 +
 drivers/usb/musb/mediatek.c                        |   2 +-
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   7 +
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/ti_usb_3410_5052.c              |   3 +
 drivers/usb/typec/mux.c                            |   7 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 151 +++-
 drivers/usb/typec/ucsi/ucsi.c                      |  48 +-
 drivers/usb/typec/ucsi/ucsi.h                      |   6 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  19 +-
 drivers/video/console/vgacon.c                     |  56 +-
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/hgafb.c                        |  21 +-
 drivers/video/fbdev/imsttfb.c                      |  26 +-
 drivers/xen/gntdev.c                               |   4 +-
 drivers/xen/swiotlb-xen.c                          |   5 +
 drivers/xen/unpopulated-alloc.c                    |   4 +-
 drivers/xen/xen-pciback/vpci.c                     |  14 +-
 drivers/xen/xen-pciback/xenbus.c                   |  22 +-
 fs/afs/cmservice.c                                 |   5 +
 fs/afs/dir.c                                       |   4 +-
 fs/afs/fsclient.c                                  |   4 +
 fs/afs/vlclient.c                                  |   1 +
 fs/block_dev.c                                     |  18 +-
 fs/btrfs/compression.c                             |  42 +-
 fs/btrfs/ctree.h                                   |   2 +-
 fs/btrfs/extent-tree.c                             |   6 +-
 fs/btrfs/extent_io.c                               |   9 +-
 fs/btrfs/file.c                                    |  35 +-
 fs/btrfs/free-space-cache.c                        |   2 +-
 fs/btrfs/inode.c                                   |   7 +-
 fs/btrfs/ioctl.c                                   |   4 +-
 fs/btrfs/ordered-data.c                            |   2 +-
 fs/btrfs/qgroup.c                                  |  16 +-
 fs/btrfs/reflink.c                                 |   5 +
 fs/btrfs/send.c                                    |   4 +-
 fs/btrfs/tree-log.c                                |  23 +-
 fs/btrfs/volumes.c                                 |   2 +-
 fs/btrfs/zoned.c                                   |   9 +-
 fs/btrfs/zoned.h                                   |   5 +-
 fs/cifs/cifs_ioctl.h                               |  25 +-
 fs/cifs/cifsfs.c                                   |   2 +-
 fs/cifs/cifsglob.h                                 |   4 +-
 fs/cifs/cifspdu.h                                  |   3 +-
 fs/cifs/file.c                                     |  46 +-
 fs/cifs/fs_context.c                               |   2 +-
 fs/cifs/ioctl.c                                    | 143 +++-
 fs/cifs/misc.c                                     |  23 +-
 fs/cifs/smb2ops.c                                  |   4 +
 fs/cifs/smb2pdu.c                                  |  13 +-
 fs/cifs/trace.h                                    |  29 +-
 fs/dax.c                                           |  35 +-
 fs/debugfs/inode.c                                 |   9 +-
 fs/ecryptfs/crypto.c                               |   4 -
 fs/erofs/zmap.c                                    |  21 +-
 fs/f2fs/compress.c                                 |  55 +-
 fs/f2fs/data.c                                     |  39 +-
 fs/f2fs/f2fs.h                                     |   2 +-
 fs/f2fs/file.c                                     |   3 +-
 fs/f2fs/segment.c                                  |   4 +-
 fs/hfsplus/extents.c                               |   7 +-
 fs/hugetlbfs/inode.c                               |   7 +-
 fs/io-wq.c                                         |  29 +-
 fs/io-wq.h                                         |   2 +-
 fs/io_uring.c                                      |  40 +-
 fs/iomap/buffered-io.c                             |   4 +-
 fs/namespace.c                                     |   6 +-
 fs/netfs/Kconfig                                   |   2 +-
 fs/netfs/read_helper.c                             |   2 +-
 fs/nfs/filelayout/filelayout.c                     |   2 +-
 fs/nfs/namespace.c                                 |   2 +-
 fs/nfs/nfs4file.c                                  |   2 +-
 fs/nfs/nfs4proc.c                                  |   4 +-
 fs/nfs/pagelist.c                                  |  20 +-
 fs/nfs/pnfs.c                                      |  17 +-
 fs/nfs/super.c                                     |   2 +-
 fs/proc/base.c                                     |   4 +
 fs/quota/dquot.c                                   |   6 +-
 fs/signalfd.c                                      |  23 +-
 fs/squashfs/file.c                                 |   6 +-
 fs/xfs/libxfs/xfs_ag_resv.c                        |  18 +-
 fs/xfs/libxfs/xfs_bmap.c                           |  12 -
 fs/xfs/libxfs/xfs_fs.h                             |   4 +
 fs/xfs/libxfs/xfs_inode_buf.c                      |  46 +-
 fs/xfs/libxfs/xfs_trans_inode.c                    |  17 +
 fs/xfs/scrub/common.c                              |   4 +-
 fs/xfs/xfs_bmap_util.c                             |  98 ++-
 fs/xfs/xfs_inode.c                                 |  29 +
 fs/xfs/xfs_ioctl.c                                 | 101 +--
 fs/xfs/xfs_message.h                               |   2 +
 include/asm-generic/hyperv-tlfs.h                  |   1 +
 include/kvm/arm_vgic.h                             |  41 +-
 include/linux/bits.h                               |   2 +-
 include/linux/blkdev.h                             |   5 -
 include/linux/cgroup-defs.h                        |   6 +-
 include/linux/cgroup.h                             |   2 +-
 include/linux/compat.h                             |  10 +-
 include/linux/console_struct.h                     |   1 +
 include/linux/const.h                              |   8 +
 include/linux/device.h                             |   6 +-
 include/linux/dynamic_debug.h                      |   5 +
 include/linux/elevator.h                           |   2 +-
 include/linux/fwnode.h                             |   1 +
 include/linux/genhd.h                              |   2 -
 include/linux/init.h                               |   3 +-
 include/linux/irqchip/arm-gic-common.h             |  25 +-
 include/linux/irqchip/arm-vgic-info.h              |  45 +
 include/linux/kvm_host.h                           | 128 ++-
 include/linux/kvm_types.h                          |  14 +
 include/linux/libnvdimm.h                          |   1 -
 include/linux/math64.h                             |  19 +
 include/linux/minmax.h                             |  10 +-
 include/linux/mlx5/driver.h                        |  44 +-
 include/linux/mlx5/mpfs.h                          |  18 +
 include/linux/mm.h                                 |  32 +
 include/linux/mm_types.h                           |   4 +-
 include/linux/pagemap.h                            |   6 +-
 include/linux/phy.h                                |   5 +
 include/linux/pm.h                                 |   1 +
 include/linux/randomize_kstack.h                   |   2 +-
 include/linux/sched/signal.h                       |   1 +
 include/linux/signal.h                             |   1 +
 include/linux/spi/spi.h                            |   4 +-
 include/linux/sunrpc/xprt.h                        |   2 +
 include/linux/surface_aggregator/device.h          |   6 +-
 include/net/cfg80211.h                             |   4 +-
 include/net/netfilter/nf_flow_table.h              |   1 -
 include/net/nfc/nci_core.h                         |   1 +
 include/net/page_pool.h                            |  12 +-
 include/net/pkt_cls.h                              |  11 +
 include/net/pkt_sched.h                            |   7 +-
 include/net/sch_generic.h                          |  35 +-
 include/net/sock.h                                 |   4 +-
 include/sound/soc-dai.h                            |   2 +-
 include/uapi/asm-generic/siginfo.h                 |  15 +-
 include/uapi/linux/fs.h                            |   2 +-
 include/uapi/linux/kvm.h                           | 105 +++
 include/uapi/linux/kvm_para.h                      |   1 +
 include/uapi/linux/perf_event.h                    |   2 +-
 include/uapi/linux/signalfd.h                      |   4 +-
 include/uapi/misc/habanalabs.h                     |  33 +
 include/xen/arm/swiotlb-xen.h                      |  15 +-
 init/Kconfig                                       |  41 +-
 ipc/mqueue.c                                       |   6 +-
 ipc/msg.c                                          |   6 +-
 ipc/sem.c                                          |   6 +-
 kernel/bpf/Kconfig                                 |  89 ++
 kernel/bpf/bpf_lsm.c                               |   2 +
 kernel/bpf/btf.c                                   |  12 +
 kernel/bpf/helpers.c                               |  35 +-
 kernel/bpf/ringbuf.c                               |  24 +-
 kernel/bpf/syscall.c                               |   3 +-
 kernel/bpf/verifier.c                              |  94 ++-
 kernel/cgroup/cgroup-v1.c                          |   2 +-
 kernel/cgroup/cgroup.c                             |  21 +-
 kernel/cgroup/cpuset.c                             |   2 +-
 kernel/cgroup/rdma.c                               |   2 +-
 kernel/cgroup/rstat.c                              |   2 +-
 kernel/events/core.c                               |  11 +-
 kernel/kcsan/debugfs.c                             |   3 +-
 kernel/locking/lockdep.c                           |   4 +-
 kernel/locking/mutex-debug.c                       |   4 +-
 kernel/locking/mutex-debug.h                       |   2 +-
 kernel/locking/mutex.c                             |  18 +-
 kernel/locking/mutex.h                             |   4 +-
 kernel/module.c                                    |  17 +-
 kernel/ptrace.c                                    |  18 +-
 kernel/resource.c                                  |   2 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/seccomp.c                                   |  30 +-
 kernel/signal.c                                    |  59 +-
 kernel/sysctl.c                                    |  29 +-
 kernel/time/alarmtimer.c                           |   2 +-
 kernel/trace/trace.c                               |  31 +-
 kernel/watchdog.c                                  |  34 +-
 kernel/workqueue.c                                 |  12 +-
 lib/Makefile                                       |   1 +
 lib/dynamic_debug.c                                |  20 +-
 lib/percpu-refcount.c                              |   6 +-
 lib/test_kasan.c                                   |  29 +-
 mm/gup.c                                           |   4 -
 mm/hugetlb.c                                       |   1 +
 mm/internal.h                                      |  20 -
 mm/ioremap.c                                       |   6 +-
 mm/ksm.c                                           |   3 +-
 mm/shmem.c                                         |  34 +-
 mm/shuffle.h                                       |   4 +-
 mm/slab_common.c                                   |  10 +
 mm/slub.c                                          |  10 +-
 mm/userfaultfd.c                                   |  28 +-
 net/Kconfig                                        |  27 -
 net/can/isotp.c                                    |  49 +-
 net/core/dev.c                                     |  29 +-
 net/core/filter.c                                  |   1 +
 net/core/page_pool.c                               |  12 +-
 net/core/sock.c                                    |   8 +-
 net/dsa/master.c                                   |   5 +-
 net/dsa/slave.c                                    |  12 +-
 net/ethtool/stats.c                                |   2 +-
 net/hsr/hsr_device.c                               |   2 +
 net/hsr/hsr_forward.c                              |  30 +-
 net/hsr/hsr_forward.h                              |   8 +-
 net/hsr/hsr_main.h                                 |   4 +-
 net/hsr/hsr_slave.c                                |  11 +-
 net/ipv4/bpf_tcp_ca.c                              |   2 +
 net/ipv6/mcast.c                                   |   3 -
 net/ipv6/reassembly.c                              |   4 +-
 net/mac80211/ieee80211_i.h                         |  36 +-
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/key.c                                 |   7 +
 net/mac80211/key.h                                 |   2 +
 net/mac80211/rx.c                                  | 150 +++-
 net/mac80211/sta_info.c                            |   6 +-
 net/mac80211/sta_info.h                            |  33 +-
 net/mac80211/wpa.c                                 |  13 +-
 net/mptcp/options.c                                |   3 +-
 net/mptcp/pm_netlink.c                             |   8 +-
 net/mptcp/protocol.c                               |  20 +-
 net/mptcp/protocol.h                               |   3 +-
 net/mptcp/sockopt.c                                |   4 +-
 net/mptcp/subflow.c                                |   1 -
 net/netfilter/nf_flow_table_core.c                 |   3 +-
 net/netfilter/nf_flow_table_offload.c              |   7 +-
 net/netfilter/nft_set_pipapo.c                     |   4 +-
 net/netfilter/nft_set_pipapo.h                     |   2 +
 net/netfilter/nft_set_pipapo_avx2.c                |   3 +
 net/netlink/af_netlink.c                           |   6 +-
 net/nfc/nci/core.c                                 |   1 +
 net/nfc/nci/hci.c                                  |   5 +
 net/nfc/rawsock.c                                  |   2 +-
 net/openvswitch/meter.c                            |   8 +
 net/packet/af_packet.c                             |  10 +-
 net/rds/connection.c                               |  23 +-
 net/rds/tcp.c                                      |   4 +-
 net/rds/tcp.h                                      |   3 +-
 net/rds/tcp_listen.c                               |   6 +
 net/sched/cls_api.c                                |   2 +-
 net/sched/sch_dsmark.c                             |   3 +-
 net/sched/sch_fq_pie.c                             |  19 +-
 net/sched/sch_generic.c                            |  50 +-
 net/sctp/socket.c                                  |   1 +
 net/sctp/sysctl.c                                  |   2 +-
 net/smc/smc_ism.c                                  |  26 +-
 net/sunrpc/clnt.c                                  |   7 -
 net/sunrpc/xprt.c                                  |  40 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |  27 +-
 net/sunrpc/xprtrdma/transport.c                    |  12 +-
 net/sunrpc/xprtrdma/verbs.c                        |  18 +-
 net/sunrpc/xprtrdma/xprt_rdma.h                    |   1 +
 net/sunrpc/xprtsock.c                              |   2 +
 net/tipc/core.c                                    |   6 +-
 net/tipc/core.h                                    |  10 +-
 net/tipc/discover.c                                |   4 +-
 net/tipc/link.c                                    |   5 +
 net/tipc/link.h                                    |   1 +
 net/tipc/msg.c                                     |   9 +-
 net/tipc/net.c                                     |  15 +-
 net/tipc/node.c                                    |  12 +-
 net/tipc/socket.c                                  |   5 +-
 net/tipc/udp_media.c                               |   2 +
 net/tls/tls_sw.c                                   |  11 +-
 net/wireless/util.c                                |   7 +-
 samples/bpf/xdpsock_user.c                         |   2 +-
 scripts/dummy-tools/gcc                            |   6 +-
 scripts/jobserver-exec                             |   2 +-
 security/keys/trusted-keys/trusted_tpm1.c          |   8 +-
 security/keys/trusted-keys/trusted_tpm2.c          |   6 +-
 sound/firewire/Kconfig                             |   4 +-
 sound/firewire/amdtp-stream-trace.h                |   6 +-
 sound/firewire/amdtp-stream.c                      |  42 +-
 sound/firewire/bebob/bebob.c                       |   2 +-
 sound/firewire/dice/dice-alesis.c                  |   2 +-
 sound/firewire/dice/dice-pcm.c                     |   4 +-
 sound/firewire/dice/dice-stream.c                  |   2 +-
 sound/firewire/dice/dice-tcelectronic.c            |   4 +-
 sound/firewire/dice/dice.c                         |  24 +
 sound/firewire/dice/dice.h                         |   3 +-
 sound/firewire/oxfw/oxfw.c                         |   1 -
 sound/isa/gus/gus_main.c                           |  13 +-
 sound/isa/sb/sb16_main.c                           |  10 +-
 sound/isa/sb/sb8.c                                 |  10 +-
 sound/pci/hda/patch_realtek.c                      | 140 +++-
 sound/pci/intel8x0.c                               |   7 +
 sound/soc/amd/raven/acp3x-pcm-dma.c                |  10 -
 sound/soc/amd/raven/acp3x.h                        |   1 +
 sound/soc/amd/raven/pci-acp3x.c                    |  15 +
 sound/soc/codecs/ak5558.c                          |   2 +-
 sound/soc/codecs/cs35l32.c                         |   3 +
 sound/soc/codecs/cs35l33.c                         |   1 +
 sound/soc/codecs/cs35l34.c                         |   3 +
 sound/soc/codecs/cs42l42.c                         |   3 +
 sound/soc/codecs/cs42l56.c                         |   7 +-
 sound/soc/codecs/cs42l73.c                         |   3 +
 sound/soc/codecs/cs43130.c                         |  28 +-
 sound/soc/codecs/cs53l30.c                         |   3 +
 sound/soc/codecs/da7219.c                          |   5 +-
 sound/soc/codecs/lpass-rx-macro.c                  |   1 +
 sound/soc/codecs/lpass-tx-macro.c                  |   1 +
 sound/soc/codecs/max98088.c                        |  13 +-
 sound/soc/codecs/rt5645.c                          |  49 +-
 sound/soc/codecs/rt711-sdca.c                      |   4 +-
 sound/soc/codecs/sti-sas.c                         |   1 +
 sound/soc/fsl/Kconfig                              |   1 +
 sound/soc/generic/audio-graph-card.c               |  57 +-
 sound/soc/generic/simple-card.c                    | 168 ++--
 sound/soc/intel/boards/bytcr_rt5640.c              |  25 +
 sound/soc/qcom/lpass-cpu.c                         |  12 +-
 sound/soc/sof/intel/hda-dai.c                      |   5 +
 sound/soc/stm/stm32_sai_sub.c                      |   5 +-
 sound/usb/format.c                                 |   2 +-
 sound/usb/line6/driver.c                           |   4 +
 sound/usb/line6/pod.c                              |   5 -
 sound/usb/line6/variax.c                           |   6 -
 sound/usb/midi.c                                   |  11 +-
 sound/usb/mixer_quirks.c                           |   2 +-
 sound/usb/mixer_scarlett_gen2.c                    |  81 +-
 sound/usb/mixer_scarlett_gen2.h                    |   2 +-
 tools/arch/powerpc/include/uapi/asm/errno.h        |   1 +
 tools/arch/x86/include/asm/cpufeatures.h           |   9 +-
 tools/arch/x86/include/asm/msr-index.h             |  10 +-
 tools/arch/x86/include/uapi/asm/kvm.h              |   2 +
 tools/arch/x86/include/uapi/asm/vmx.h              |   1 +
 tools/arch/x86/lib/memcpy_64.S                     |   2 +-
 tools/arch/x86/lib/memset_64.S                     |   2 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |   4 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   6 +-
 tools/bpf/bpftool/cgroup.c                         |   3 +-
 tools/bpf/bpftool/prog.c                           |   2 +-
 tools/build/Makefile.build                         |  22 +-
 .../asm/{alternative-asm.h => alternative.h}       |   0
 tools/include/linux/bits.h                         |   2 +-
 tools/include/linux/const.h                        |   8 +
 tools/include/uapi/asm-generic/unistd.h            |  11 +-
 tools/include/uapi/drm/drm.h                       | 125 ++-
 tools/include/uapi/drm/i915_drm.h                  |   1 +
 tools/include/uapi/linux/fs.h                      |   2 +-
 tools/include/uapi/linux/kvm.h                     |  45 +
 tools/include/uapi/linux/perf_event.h              |  26 +-
 tools/include/uapi/linux/prctl.h                   |   4 +
 tools/lib/bpf/libbpf.c                             |   3 +
 tools/lib/bpf/libbpf_internal.h                    |   5 +
 tools/lib/traceevent/plugins/plugin_kvm.c          |   4 +-
 tools/objtool/arch/x86/decode.c                    |   3 +-
 tools/objtool/elf.c                                |   1 +
 tools/perf/Documentation/perf-intel-pt.txt         |   6 +-
 tools/perf/Documentation/perf-script.txt           |   7 +-
 tools/perf/Makefile.config                         |   1 +
 tools/perf/arch/arm64/util/kvm-stat.c              |   2 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   5 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   4 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   4 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   4 +
 tools/perf/builtin-buildid-list.c                  |   3 +
 tools/perf/builtin-stat.c                          |  13 +-
 tools/perf/perf.c                                  |   4 +-
 .../pmu-events/arch/powerpc/power10/cache.json     |  30 +-
 .../arch/powerpc/power10/floating_point.json       |   2 +-
 .../pmu-events/arch/powerpc/power10/frontend.json  | 124 +--
 .../pmu-events/arch/powerpc/power10/locks.json     |   4 +-
 .../pmu-events/arch/powerpc/power10/marked.json    |  61 +-
 .../pmu-events/arch/powerpc/power10/memory.json    |  79 +-
 .../pmu-events/arch/powerpc/power10/others.json    | 133 ++-
 .../pmu-events/arch/powerpc/power10/pipeline.json  | 135 ++-
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   8 +-
 .../arch/powerpc/power10/translation.json          |  22 +-
 tools/perf/pmu-events/jevents.c                    |   8 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  12 +-
 tools/perf/tests/attr/base-record                  |   2 +-
 tools/perf/tests/attr/base-stat                    |   2 +-
 tools/perf/tests/attr/system-wide-dummy            |   2 +-
 tools/perf/tests/pfm.c                             |   4 +-
 tools/perf/util/Build                              |   7 +
 tools/perf/util/bpf_counter.c                      |   4 +-
 tools/perf/util/event.h                            |   2 +-
 tools/perf/util/evlist.c                           |   3 -
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   6 +-
 tools/perf/util/intel-pt.c                         |   6 +-
 tools/perf/util/parse-events.c                     |  13 +-
 tools/perf/util/parse-events.l                     |   1 +
 tools/perf/util/pfm.c                              |  11 +-
 tools/perf/util/record.c                           |   8 +-
 tools/perf/util/session.c                          |   4 +-
 tools/scripts/Makefile.include                     |  30 +-
 tools/testing/nvdimm/test/iomap.c                  |   2 +-
 tools/testing/nvdimm/test/nfit.c                   |  42 +-
 tools/testing/selftests/arm64/bti/test.c           |   1 +
 tools/testing/selftests/bpf/network_helpers.c      |   2 +-
 tools/testing/selftests/bpf/network_helpers.h      |   1 +
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |  49 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c | 785 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_neigh.c  |  33 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c        |   9 +-
 tools/testing/selftests/bpf/progs/test_tc_peer.c   |  56 +-
 tools/testing/selftests/bpf/test_tc_redirect.sh    | 216 -----
 tools/testing/selftests/bpf/verifier/stack_ptr.c   |   2 -
 .../selftests/bpf/verifier/value_ptr_arith.c       |   8 -
 tools/testing/selftests/exec/Makefile              |   6 +-
 tools/testing/selftests/kvm/.gitignore             |   7 +-
 tools/testing/selftests/kvm/Makefile               |  13 +-
 .../selftests/kvm/aarch64/debug-exceptions.c       | 250 ++++++
 .../selftests/kvm/aarch64/get-reg-list-sve.c       |   3 -
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 439 +++++++---
 tools/testing/selftests/kvm/dirty_log_test.c       |   5 +-
 .../testing/selftests/kvm/hardware_disable_test.c  |   2 +-
 .../selftests/kvm/include/aarch64/processor.h      |  83 +-
 tools/testing/selftests/kvm/include/kvm_util.h     |  44 +-
 tools/testing/selftests/kvm/include/x86_64/apic.h  |  91 ++
 .../selftests/kvm/include/{ => x86_64}/evmcs.h     |   2 +-
 .../testing/selftests/kvm/include/x86_64/hyperv.h  | 185 +++++
 .../selftests/kvm/include/x86_64/processor.h       |  66 +-
 tools/testing/selftests/kvm/include/x86_64/vmx.h   |  11 +-
 .../testing/selftests/kvm/kvm_binary_stats_test.c  | 237 ++++++
 tools/testing/selftests/kvm/kvm_page_table_test.c  |   2 +-
 tools/testing/selftests/kvm/lib/aarch64/handlers.S | 126 +++
 .../testing/selftests/kvm/lib/aarch64/processor.c  | 131 ++-
 tools/testing/selftests/kvm/lib/aarch64/ucall.c    |   2 +-
 tools/testing/selftests/kvm/lib/elf.c              |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  78 +-
 tools/testing/selftests/kvm/lib/perf_test_util.c   |   2 +-
 tools/testing/selftests/kvm/lib/s390x/processor.c  |  17 +-
 tools/testing/selftests/kvm/lib/x86_64/apic.c      |  45 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 352 ++++----
 tools/testing/selftests/kvm/lib/x86_64/svm.c       |   9 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c       |  52 +-
 tools/testing/selftests/kvm/memslot_perf_test.c    |   2 +-
 .../testing/selftests/kvm/set_memory_region_test.c |   2 +-
 tools/testing/selftests/kvm/steal_time.c           |   4 +-
 .../selftests/kvm/x86_64/emulator_error_test.c     | 219 +++++
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |  79 +-
 .../testing/selftests/kvm/x86_64/get_cpuid_test.c  |   3 +-
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c  |  10 +-
 .../testing/selftests/kvm/x86_64/hyperv_features.c | 649 +++++++++++++++
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c   |   2 +-
 tools/testing/selftests/kvm/x86_64/mmu_role_test.c | 147 ++++
 .../testing/selftests/kvm/x86_64/set_boot_cpu_id.c |  10 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c      |   4 +-
 .../testing/selftests/kvm/x86_64/sync_regs_test.c  |   7 +-
 tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c |   9 -
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c |   8 +-
 .../selftests/kvm/x86_64/vmx_apic_access_test.c    |   2 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c      |   8 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c       | 242 ++++++
 .../testing/selftests/kvm/x86_64/xapic_ipi_test.c  |  65 +-
 .../testing/selftests/kvm/x86_64/xen_shinfo_test.c |   2 +-
 .../testing/selftests/kvm/x86_64/xen_vmcall_test.c |   2 +-
 tools/testing/selftests/nci/.gitignore             |   1 +
 .../selftests/perf_events/sigtrap_threads.c        |  14 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  27 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json         |   8 +-
 virt/kvm/Kconfig                                   |   3 +
 virt/kvm/binary_stats.c                            | 146 ++++
 virt/kvm/kvm_main.c                                | 323 ++++++--
 1217 files changed, 20360 insertions(+), 9510 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/SecurityBugs
 delete mode 100644 arch/arm64/include/asm/cpucaps.h
 create mode 100644 arch/arm64/include/asm/kvm_mte.h
 create mode 100644 arch/arm64/tools/Makefile
 create mode 100644 arch/arm64/tools/cpucaps
 create mode 100755 arch/arm64/tools/gen-cpucaps.awk
 create mode 100644 arch/openrisc/include/asm/barrier.h
 create mode 100644 arch/powerpc/kvm/book3s_64_entry.S
 create mode 100644 arch/powerpc/kvm/book3s_hv_p9_entry.c
 rename arch/x86/boot/compressed/{sev-es.c => sev.c} (98%)
 create mode 100644 arch/x86/include/asm/sev-common.h
 rename arch/x86/include/asm/{sev-es.h => sev.h} (70%)
 rename arch/x86/kernel/{sev-es-shared.c => sev-shared.c} (96%)
 rename arch/x86/kernel/{sev-es.c => sev.c} (92%)
 create mode 100644 arch/x86/kvm/fpu.h
 create mode 100644 arch/x86/kvm/kvm_onhyperv.c
 create mode 100644 arch/x86/kvm/kvm_onhyperv.h
 create mode 100644 arch/x86/kvm/svm/svm_onhyperv.c
 create mode 100644 arch/x86/kvm/svm/svm_onhyperv.h
 create mode 100644 include/linux/irqchip/arm-vgic-info.h
 create mode 100644 include/linux/mlx5/mpfs.h
 create mode 100644 kernel/bpf/Kconfig
 rename tools/include/asm/{alternative-asm.h => alternative.h} (100%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
 delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh
 create mode 100644 tools/testing/selftests/kvm/aarch64/debug-exceptions.c
 delete mode 100644 tools/testing/selftests/kvm/aarch64/get-reg-list-sve.c
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/apic.h
 rename tools/testing/selftests/kvm/include/{ => x86_64}/evmcs.h (99%)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/hyperv.h
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/apic.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/emulator_error_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_features.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/mmu_role_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
 create mode 100644 tools/testing/selftests/nci/.gitignore
 create mode 100644 virt/kvm/binary_stats.c

