Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C917F3821D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhEPWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhEPWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 18:49:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD951C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:48:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so6031311lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NAZS9pabjBW0YlzNwa3LnRD/fERj4biFvJmZV+pmhyQ=;
        b=Om6BstN0rXEp4wiP1YZzIxlYkb8S5xKoxqluva8EtEENU8PgOScNWmy4FmOZyuC8LK
         cUUtRbfjg1r7a8OqacYqEPbDo9h0sQ+ZDR2y0qXOV7EvV3xOmsgWhsoz0Fjzc09Kztf1
         HZTQ7xF9uUA6kSXrST/aOXAz5+GlNVlJipckU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NAZS9pabjBW0YlzNwa3LnRD/fERj4biFvJmZV+pmhyQ=;
        b=IkTey3qujvYs1Mu7n+mZmkJ1nFlRjp/tM5eQkN5TYqSEbzLfNREMvp6B5+vhb/VexN
         9pcpFse163tmiSOyi59UNNJl/rwwFzjYkXBcjOS9bJsp5gGsJ+x1DPv5SC/bpHEH+UkP
         paawDM9H4Emd1EGk7KFndPYHEaoF5bZieuDFRyOhZkg/at9OflXokt/zKSayvQR5pGsI
         47V+G459EjNfWSd2eW4jlIlBdC8tzed2LG8am5aKnjYdJpFGLElVM1QmKSKYE3ecxg6U
         L+v5BJzw369A/l55hu94cauLeneCR4YxwemUKEShN1RigGfYn4YPGfQnFdA04dtqiYgn
         P0eA==
X-Gm-Message-State: AOAM533rbLZCzgszJDU625WGXIPnIysEcGpj1zomyg1e/opd0GlAYgGL
        MrR8XAikeNYDDKGOS2Zuj3u9gpcoqYH6aIzJ
X-Google-Smtp-Source: ABdhPJyJtpYg7hbq7IaDb3S2YwDJc42nX5U2EesqjeedOA32DgR2rXLFLDGp8Mxxoqsp6wz4gSR+0A==
X-Received: by 2002:a05:6512:3b22:: with SMTP id f34mr38051751lfv.361.1621205310129;
        Sun, 16 May 2021 15:48:30 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b24sm1771222lff.93.2021.05.16.15.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 15:48:29 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f12so4988471ljp.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 15:48:29 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr45683373ljp.251.1621205309188;
 Sun, 16 May 2021 15:48:29 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 May 2021 15:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
Message-ID: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
Subject: Linux 5.13-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So a week has passed, and rc2 is tagged and pushed out.

Things look pretty normal: rc2 tends to be fairly quiet as people
start finding issues, and while 5.13 looks to be a pretty big release
over-all, the changes in rc2 are if anything slightly smaller than
average.  But it's well within the noise.

The fixes here are all over the place - drivers, arch updates,
documentation, tooling.. Nothing particularly stands out, although a
fix for some VGA text-mode font size issues is funny (as in "strange",
not "ha-ha funny") just because so few people presumably use the
extended SVGA text modes any more. That's not recent breakage either.

The appended shortlog shows the details.

                 Linus

---

Abhijeet Rao (1):
      xhci-pci: Allow host runtime PM as default for Intel Alder Lake xHCI

Alexandre Belloni (1):
      alarmtimer: Check RTC features instead of ops

Alexandru Ardelean (2):
      iio: hid-sensors: select IIO_TRIGGERED_BUFFER under HID_SENSOR_IIO_TR=
IGGER
      iio: core: return ENODEV if ioctl is unknown

Alistair Popple (1):
      kernel/resource: fix return code check in __request_free_mem_region

Anand Jain (1):
      btrfs: fix unmountable seed device after fstrim

Andy Shevchenko (2):
      usb: typec: ucsi: Put fwnode in any case during ->probe()
      hwmon: (ltc2992) Put fwnode in error case during ->probe()

Ankit Nautiyal (1):
      drm/i915: Use correct downstream caps for check Src-Ctl mode for PCON

Arnaldo Carvalho de Melo (11):
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers UAPI: Sync files changed by landlock,
quotactl_path and mount_settattr new syscalls
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in
'perf bench mem memcpy'
      tools include UAPI powerpc: Sync errno.h with the kernel headers
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync perf_event.h with the kernel sources

Arnd Bergmann (1):
      staging: rtl8723bs: avoid bogus gcc warning

Axel Rasmussen (1):
      userfaultfd: release page in error path to avoid BUG_ON

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix SINK_DISCOVERY current limit for Rp-default

Bart Van Assche (2):
      blk-mq: Swap two calls in blk_mq_exit_queue()
      block/partitions/efi.c: Fix the efi_partition() kernel-doc header

Ben Boeckel (1):
      trusted-keys: match tpm_get_ops on all return paths

Benjamin Segall (1):
      kvm: exit halt polling on need_resched() as well

Bhaskar Chowdhury (1):
      arc: Fix typos/spellos

Bill Wendling (1):
      selftests: kvm: remove reassignment of non-absolute variables

Brijesh Singh (3):
      x86/sev-es: Rename sev-es.{ch} to sev.{ch}
      x86/sev: Move GHCB MSR protocol and NAE definitions in a common heade=
r
      x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG

Catalin Marinas (1):
      arm64: Fix race condition on PG_dcache_clean in __sync_icache_dcache(=
)

Chaitanya Kulkarni (5):
      nvmet: fix inline bio check for bdev-ns
      nvmet: fix inline bio check for passthru
      nvmet: demote discovery cmd parse err msg to debug
      nvmet: use helper to remove the duplicate code
      nvmet: demote fabrics cmd parse err msg to debug

Chao Yu (3):
      f2fs: compress: fix to free compress page correctly
      f2fs: compress: fix race condition of overwrite vs truncate
      f2fs: compress: fix to assign cc.cluster_idx correctly

Chenyi Qiang (1):
      KVM: X86: Add support for the emulation of DR6_BUS_LOCK bit

Christoph Hellwig (2):
      nvme-multipath: fix double initialization of ANA state
      arm64: do not set SWIOTLB_NO_FORCE when swiotlb is required

Christophe JAILLET (4):
      usb: fotg210-hcd: Fix an error message
      usb: musb: Fix an error message
      ACPI: scan: Fix a memory leak in an error handling path
      xhci: Do not use GFP_KERNEL in (potentially) atomic context

Christophe Leroy (6):
      powerpc/interrupts: Fix kuep_unlock() call
      powerpc/syscall: Calling kuap_save_and_lock() is wrong
      powerpc/uaccess: Fix __get_user() with CONFIG_CC_HAS_ASM_GOTO_OUTPUT
      powerpc/signal: Fix possible build failure with
unsafe_copy_fpr_{to/from}_user
      powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
      mm/ioremap: fix iomap_max_page_shift

Chunfeng Yun (1):
      usb: core: hub: fix race condition about TRSMRCY of resume

Colin Ian King (3):
      KVM: x86: Fix potential fput on a null source_kvm_file
      iio: tsl2583: Fix division by a zero lux_val
      KEYS: trusted: Fix memory leak on object td

Damien Le Moal (1):
      block: uapi: fix comment about block device ioctl

Dan Williams (2):
      MAINTAINERS: Move nvdimm mailing list
      ACPI: NFIT: Fix support for variable 'SPA' structure size

Daniel Vetter (1):
      MAINTAINERS: Update address for Emma Anholt

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

David Matlack (1):
      kvm: Cap halt polling at kvm->max_halt_poll_ns

David Ward (1):
      drm/amd/display: Initialize attribute for hdcp_srm sysfs file

Desmond Cheong Zhi Xi (1):
      Remove link to nonexistent rocket driver docs

Dinghao Liu (2):
      iio: light: gp2ap002: Fix rumtime PM imbalance on error
      iio: proximity: pulsedlight: Fix rumtime PM imbalance on error

Dmitry Baryshkov (2):
      drm/msm/dsi: dsi_phy_28nm_8960: fix uninitialized variable access
      drm/msm/dsi: fix msm_dsi_phy_get_clk_provider return code

Dmitry Koshelev (1):
      perf session: Fix swapping of cpu_map and stat_config records

Dmitry Osipenko (1):
      iio: gyro: mpu3050: Fix reported temperature value

Eddie James (1):
      hwmon: (occ) Fix poll rate limiting

Eric Dumazet (1):
      sh: Remove unused variable

Fabio Estevam (1):
      usb: Restore the reference to ch9.h

Ferry Toth (1):
      usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield

Filipe Manana (4):
      btrfs: zoned: fix silent data loss after failure splitting ordered ex=
tent
      btrfs: do not consider send context as valid when trying to flush qgr=
oups
      btrfs: fix race leading to unpersisted data and metadata on fsync
      btrfs: fix deadlock when cloning inline extents and using qgroups

Gao Xiang (3):
      erofs: fix broken illustration in documentation
      erofs: update documentation about data compression
      erofs: fix 1 lcluster-sized pcluster for big pcluster

Gautham R. Shenoy (1):
      sched/fair: Fix clearing of has_idle_cores flag in select_idle_cpu()

Guenter Roeck (1):
      hwmon: (adm9240) Fix writes into inX_max attributes

Gustavo A. R. Silva (3):
      drm/radeon/ni_dpm: Fix booting bug
      drm/radeon/si_dpm: Fix SMU power state load
      drm/amd/pm: Fix out-of-bounds bug

Hou Pu (1):
      nvmet: use new ana_log_size instead the old one

Huang Rui (1):
      x86, sched: Fix the AMD CPPC maximum performance value on
certain AMD Ryzen generations

Hugh Dickins (1):
      ksm: revert "use GET_KSM_PAGE_NOLOCK to get ksm page in
remove_rmap_item_from_tree()"

Ian Rogers (1):
      perf jevents: Silence warning for ArchStd files

Jack Pham (4):
      usb: dwc3: gadget: Enable suspend events
      usb: dwc3: gadget: Rename EOPF event macros to Suspend
      usb: dwc3: gadget: Free gadget structure only after freeing endpoints
      usb: typec: ucsi: Retrieve all the PDOs instead of just the first 4

Jaegeuk Kim (4):
      f2fs: avoid null pointer access when handling IPU error
      f2fs: support iflag change given the mask
      f2fs: avoid swapon failure by giving a warning first
      f2fs: return EINVAL for hole cases in swap file

Jarkko Sakkinen (2):
      tpm, tpm_tis: Extend locality handling to TPM2 in tpm_tis_gen_interru=
pt()
      tpm, tpm_tis: Reserve locality in tpm_tis_resume()

Jernej Skrabec (1):
      MAINTAINERS: Update my e-mail

Jiapeng Chong (1):
      drm/vc4: remove unused function

Jiri Olsa (1):
      perf tools: Fix dynamic libbpf link

Jonathan Marek (2):
      drm/msm: fix LLC not being enabled for mmu500 targets
      drm/msm: fix minor version to indicate MSM_PARAM_SUSPENDS support

Jouni Roivas (1):
      hfsplus: prevent corruption in shrinking truncate

Juergen Gross (1):
      xen/gntdev: fix gntdev_mmap() error exit path

Kai Huang (2):
      KVM: x86/mmu: Avoid unnecessary page table allocation in kvm_tdp_mmu_=
map()
      KVM: x86/mmu: Fix kdoc of __handle_changed_spte

Kai-Heng Feng (2):
      drm/i915/dp: Use slow and wide link training for everything
      drm/radeon/dpm: Disable sclk switching on Oland when two 4K 60Hz
monitors are connected

Kuogee Hsieh (2):
      drm/msm/dp: check sink_count before update is_connected status
      drm/msm/dp: initialize audio_comp when audio starts

Kyle Tso (3):
      usb: typec: tcpm: Fix wrong handling in GET_SINK_CAP
      usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work
      usb: typec: tcpm: Fix wrong handling for Not_Supported in VDM AMS

Li Jun (1):
      usb: dwc3: imx8mp: detect dwc3 core node via compatible string

Likun GAO (1):
      drm/amdgpu: add judgement when add ip blocks (v2)

Likun Gao (1):
      drm/amdgpu: update the method for harvest IP for specific SKU

Lin Feng (1):
      blkdev.h: remove unused codes blk_account_rq

Linus Torvalds (1):
      Linux 5.13-rc2

Lv Yunlong (1):
      drm/i915/gt: Fix a double free in gen8_preallocate_top_level_pdp

Maciej W. Rozycki (3):
      vgacon: Record video mode changes with VT_RESIZEX
      vt_ioctl: Revert VT_RESIZEX parameter handling removal
      vt: Fix character height handling with VT_RESIZEX

Marcel Hamer (1):
      usb: dwc3: omap: improve extcon initialization

Mark Brown (3):
      arm64: Generate cpucaps.h
      kselftest/arm64: Add missing stddef.h include to BTI tests
      arm64: tools: Add __ASM_CPUCAPS_H to the endif in cpucaps.h

Masami Hiramatsu (1):
      perf tools: Fix a build error on arm64 with clang

Mathias Nyman (1):
      xhci: Fix giving back cancelled URBs even if halted endpoint can't re=
set

Matthew Wilcox (Oracle) (2):
      mm: fix struct page layout on 32-bit systems
      mm/filemap: fix readahead return types

Matthijs Kooijman (1):
      usb: dwc2: Remove obsolete MODULE_ constants from platform.c

Mauro Carvalho Chehab (5):
      docs: cdrom-standard.rst: get rid of uneeded UTF-8 chars
      docs: ABI: remove a meaningless UTF-8 character
      docs: ABI: remove some spurious characters
      docs: hwmon: tmp103.rst: fix bad usage of UTF-8 chars
      docs: networking: device_drivers: fix bad usage of UTF-8 chars

Maxim Levitsky (5):
      KVM: nSVM: fix a typo in svm_leave_nested
      KVM: nSVM: fix few bugs in the vmcb02 caching logic
      KVM: nSVM: leave the guest mode prior to loading a nested state
      KVM: nSVM: always restore the L1's GIF on migration
      KVM: nSVM: remove a warning about vmcb01 VM exit reason

Maximilian Luz (1):
      usb: xhci: Increase timeout for HC halt

Michael Ellerman (5):
      KVM: PPC: Book3S HV: Fix kvm_unmap_gfn_range_hv() for Hash MMU
      powerpc/64s: Fix crashes when toggling stf barrier
      powerpc/64s: Fix crashes when toggling entry flush barrier
      powerpc/64s: Fix entry flush patching w/strict RWX & hash
      powerpc/64s: Fix stf mitigation patching w/strict RWX & hash

Michal Kalderon (1):
      nvmet-rdma: Fix NULL deref when SEND is completed with error

Ming Lei (1):
      blk-mq: plug request for shared sbitmap

Namhyung Kim (1):
      perf record: Disallow -c and -F option at the same time

Naohiro Aota (1):
      btrfs: zoned: sanity check zone type

Nicholas Piggin (7):
      KVM: PPC: Book3S HV: Fix conversion to gfn-based MMU notifier callbac=
ks
      powerpc/pseries: Fix hcall tracing recursion in pv queued spinlocks
      powerpc/pseries: Don't trace hcall tracing wrapper
      powerpc/pseries: use notrace hcall variant for H_CEDE idle
      powerpc/pseries: warn if recursing into the hcall tracing code
      powerpc/64s: Make NMI record implicitly soft-masked code as irqs disa=
bled
      powerpc/64e/interrupt: Fix nvgprs being clobbered

Nick Desaulniers (2):
      stack: Replace "o" output with "r" input constraint
      x86/boot/compressed: Enable -Wundef

Oleg Nesterov (1):
      ptrace: make ptrace() fail if the tracee changed its pid unexpectedly

Oliver Neukum (1):
      cdc-wdm: untangle a circular dependency between callback and softint

Omar Sandoval (1):
      kyber: fix out of bounds access when preempted

Paolo Bonzini (1):
      KVM: X86: Expose bus lock debug exception to guest

Paolo Valente (1):
      block, bfq: avoid circular stable merges

Pavel Begunkov (4):
      io_uring: fix link timeout refs
      io_uring: fix ltout double free on completion race
      io_uring: further remove sqpoll limits on opcodes
      io_uring: increase max number of reg buffers

Peter Collingbourne (2):
      arm64: mte: initialize RGSR_EL1.SEED in __cpu_setup
      kasan: fix unit tests with CONFIG_UBSAN_LOCAL_BOUNDS enabled

Peter Xu (2):
      mm/hugetlb: fix F_SEAL_FUTURE_WRITE
      mm/hugetlb: fix cow where page writtable in child

Phil Elwell (1):
      usb: dwc2: Fix gadget DMA unmap direction

Phillip Lougher (1):
      squashfs: fix divide error in calculate_skip()

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Use HWP if enabled by platform firmware
      Revert "Revert "ACPI: scan: Turn off unused power resources
during initialization""

Randy Dunlap (2):
      ARC: kgdb: add 'fallthrough' to prevent a warning
      Documentation: drop optional BOMs

Rasmus Villemoes (1):
      docs: admin-guide: update description for kernel.modprobe sysctl

Ritesh Harjani (1):
      btrfs: handle transaction start error in btrfs_fileattr_set

Rob Clark (1):
      drm/msm: Do not unpin/evict exported dma-buf's

Sandeep Singh (1):
      xhci: Add reset resume quirk for AMD xhci controller.

Saravana Kannan (1):
      usb: typec: tcpm: Don't block probing of consumers of "connector" nod=
es

Sathishkumar S (2):
      drm/amdgpu: set vcn mgcg flag for picasso
      drm/amdgpu: update vcn1.0 Non-DPG suspend sequence

Sean Christopherson (17):
      KVM: VMX: Do not advertise RDPID if ENABLE_RDTSCP control is unsuppor=
ted
      KVM: x86: Emulate RDPID only if RDTSCP is supported
      KVM: SVM: Inject #UD on RDTSCP when it should be disabled in the gues=
t
      KVM: x86: Move RDPID emulation intercept to its own enum
      KVM: VMX: Disable preemption when probing user return MSRs
      KVM: SVM: Probe and load MSR_TSC_AUX regardless of RDTSCP support in =
host
      KVM: x86: Add support for RDPID without RDTSCP
      KVM: VMX: Configure list of user return MSRs at module init
      KVM: VMX: Use flag to indicate "active" uret MSRs instead of sorting =
list
      KVM: VMX: Use common x86's uret MSR list as the one true list
      KVM: VMX: Disable loading of TSX_CTRL MSR the more conventional way
      KVM: x86: Export the number of uret MSRs to vendor modules
      KVM: x86: Move uret MSR slot management to common x86
      KVM: x86: Tie Intel and AMD behavior for MSR_TSC_AUX to guest CPU mod=
el
      KVM: x86: Hide RDTSCP and RDPID if MSR_TSC_AUX probing failed
      KVM: x86: Prevent KVM SVM from loading on kernels with 5-level paging
      KVM: SVM: Invert user pointer casting in SEV {en,de}crypt helpers

Shahin, Md Shahadat Hossain (1):
      kvm/x86: Fix 'lpages' kvm stat for TDM MMU

Siddharth Chandrasekaran (2):
      doc/kvm: Fix wrong entry for KVM_CAP_X86_MSR_FILTER
      KVM: x86: Hoist input checks in kvm_add_msr_filter()

Stefan Raspl (1):
      tools/kvm_stat: Fix documentation typo

Stefano Stabellini (2):
      xen/arm: move xen_swiotlb_detect to arm/swiotlb-xen.h
      xen/swiotlb: check if the swiotlb has already been initialized

Steven Rostedt (VMware) (1):
      tracing: Handle %.*s in trace_check_vprintf()

St=C3=A9phane Marchesin (1):
      drm/i915: Fix crash in auto_retire

Sumeet Pawnikar (1):
      ACPI: PM: Add ACPI ID of Alder Lake Fan

Sun Ke (2):
      nbd: Fix NULL pointer in flush_workqueue
      nbd: share nbd_put and return by goto put_nbd

Tejun Heo (1):
      blk-iocost: fix weight updates of inner active iocgs

Tetsuo Handa (1):
      tty: vt: always invoke vc->vc_sw->con_resize callback

Thinh Nguyen (1):
      usb: dwc3: core: Add missing GHWPARAMS9 doc

Thomas Gleixner (2):
      KVM: x86: Cancel pvclock_gtod_work on module removal
      KVM: x86: Prevent deadlock against tk_core.seq

Tom Lendacky (1):
      KVM: SVM: Move GHCB unmapping to fix RCU warning

Tom Rix (1):
      btrfs: initialize return variable in cleanup_free_space_cache_v1

Tomasz Duszynski (1):
      iio: core: fix ioctl handlers removal

Tony Lindgren (1):
      PM: runtime: Fix unpaired parent child_count for force_resume

Tudor Ambarus (1):
      clk: Skip clk provider registration when np is NULL

Tvrtko Ursulin (1):
      drm/i915/overlay: Fix active retire callback alignment

Vasily Gorbik (2):
      objtool: Fix elf_create_undef_symbol() endianness
      objtool/x86: Fix elf_add_alternative() endianness

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Avoid div-by-zero on gen2
      drm/i915: Read C0DRB3/C1DRB3 as 16 bits again

Vineet Gupta (1):
      ARC: entry: fix off-by-one error in syscall number validation

Vitaly Kuznetsov (10):
      x86/kvm: Fix pr_info() for async PF setup/teardown
      x86/kvm: Teardown PV features on boot CPU as well
      x86/kvm: Disable kvmclock on all CPUs on shutdown
      x86/kvm: Disable all PV features on crash
      x86/kvm: Unify kvm_pv_guest_cpu_reboot() with kvm_guest_cpu_offline()
      KVM: nVMX: Always make an attempt to map eVMCS after migration
      KVM: selftests: evmcs_test: Check that VMLAUNCH with bogus
EVMPTR is causing #UD
      KVM: selftests: evmcs_test: Check that VMCS12 is alway properly
synced to eVMCS after restore
      KVM: nVMX: Properly pad 'struct kvm_vmx_nested_state_hdr'
      clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86

Vivek Goyal (3):
      dax: Add an enum for specifying dax wakup mode
      dax: Add a wakeup mode parameter to put_unlocked_entry()
      dax: Wake up all waiters after invalidating dax entry

Vladimir Isaev (2):
      ARC: mm: PAE: use 40-bit physical page mask
      ARC: mm: Use max_high_pfn as a HIGHMEM zone border

Vlastimil Babka (1):
      mm, slub: move slub_debug static key enabling outside slab_mutex

V=C3=A1clav Kubern=C3=A1t (1):
      hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E non-compliant vout encoding

Wan Jiabing (3):
      hwmon: (corsair-psu) Remove unneeded semicolons
      docs/zh_CN: Remove obsolete translation file
      libnvdimm: Remove duplicate struct declaration

Wanpeng Li (1):
      KVM: LAPIC: Accurately guarantee busy wait for timer to expire
when using hv_timer

Wei Ming Chen (1):
      docs: usb: function: Modify path name

Wesley Cheng (1):
      usb: dwc3: gadget: Return success always for kick transfer in ep queu=
e

Zhen Lei (3):
      xen/unpopulated-alloc: fix error return code in fill_list()
      usb: dwc3: imx8mp: fix error return code in dwc3_imx8mp_probe()
      tpm: fix error return code in tpm2_get_cc_attrs_tbl()

Zou Wei (1):
      tools/testing/nvdimm: Make symbol '__nfit_test_ioremap' static

xinhui pan (1):
      drm/ttm: Do not add non-system domain BO into swap list
