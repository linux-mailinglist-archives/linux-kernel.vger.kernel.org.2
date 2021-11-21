Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA534586B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhKUWKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 17:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhKUWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 17:10:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF71C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:07:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so68245052edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WIv5bFnlYSsA/wXVz/5rXlGIzk63WWsDU4GxIysNO0k=;
        b=DrktH4KWWWOnygRghM6F6NFCqUKf2wJZjrOrtAsm4SpHdKiE/aUoILjnhEmWNEWx84
         oW1LPo7visdR6HPeT0ywI+fbdBZ9oy5Pjuf5UaTlIj9z0Jz+oY76odwc7n3PU7Wp0eR0
         XnKgAyZqurvuUmUnvm7aIKD0a2wjQHyZkb8ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WIv5bFnlYSsA/wXVz/5rXlGIzk63WWsDU4GxIysNO0k=;
        b=Gx+7dD2h8WuFSdwlt3CVVC8DNa/+SC1SBEeci+f4eZNKXHZ5jxLtFGpuBOmpfzOLwr
         yvTRx3t1qS9TODg8qGWDIf9vspbNrenm9imwEzKdBwSCb+Rdly7XwqDBeOe2PtLUw7zT
         OpSCJvIMqytKivXdrL7I/FwbODXAt7dnn8scGMAUAlcTiADVMRnMKB+g8jKOOgIB0DwV
         AddhNc0Dou1W2RM+56J5CI7pnsC4ZKhMgVHeTGi/5mBaLpg4XExgLKVkYi7WzwiSKIHW
         CqjDTmbERi21Mh8UR69tU9Pk2VxawBIVxt7ENvUGmYMlOP9AjzJvuZHBlRf6TYWLYNNi
         NHsA==
X-Gm-Message-State: AOAM533vPtHlQnMv8AUeMVxfcIbUj61+GrkqcGFskxpQDXPH7KxcZT6y
        4OKx+vqAbj0WHaMdGnaua6YE56ONh0+/LXQR
X-Google-Smtp-Source: ABdhPJxyiWj2SUaUsya7Gv3SkCo0G/IyiArM3gNVYdyxUkLWbw2hUie9iAHVmT/BLFeb7CaYqbLVWQ==
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr21980352ejc.290.1637532433955;
        Sun, 21 Nov 2021 14:07:13 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id h7sm3211454edb.89.2021.11.21.14.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 14:07:13 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so15155363wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:07:13 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr22653978wmc.152.1637532432666;
 Sun, 21 Nov 2021 14:07:12 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Nov 2021 14:06:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMLMKjQUFoAA+chpZqaLJgpnUHsOJtBzWgFepT_DEwSw@mail.gmail.com>
Message-ID: <CAHk-=wgMLMKjQUFoAA+chpZqaLJgpnUHsOJtBzWgFepT_DEwSw@mail.gmail.com>
Subject: Linux 5.16-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing especially noteworthy stands out for the last week, it all
felt pretty normal for a rc2 week.

The commit stats look normal, and the diffstat looks fairly regular
too. There's perhaps relatively less driver diffs than usual, partly
explained by the tools subdirectory diff being larger than usual (a
quarter of the whole thing), mostly just due to added kvm tests. The
rest is arch updates, filesystems, networking, documentation etc...

So fixes a bit all over the place, with nothing that really stands
out. Details below in the shortlog.

                Linus

---

Aaron Ma (1):
      net: usb: r8152: Add MAC passthrough support for more Lenovo Docks

Adrian Hunter (2):
      scsi: ufs: core: Fix task management completion timeout race
      scsi: ufs: core: Fix another task management completion race

Akeem G Abodunrin (1):
      iavf: Restore VLAN filters after link down

Akira Yokosawa (1):
      docs: Update Sphinx requirements

Alex Elder (2):
      net: ipa: HOLB register sometimes must be written twice
      net: ipa: disable HOLB drop when updating timer

Alex Shi (1):
      doc/zh_CN: fix a translation error in management-style

Alex Williamson (1):
      platform/x86: think-lmi: Abort probe on analyze failure

Alexander Antonov (3):
      perf/x86/intel/uncore: Fix filter_tid mask for CHA events on
Skylake Server
      perf/x86/intel/uncore: Fix IIO event constraints for Skylake Server
      perf/x86/intel/uncore: Fix IIO event constraints for Snowridge

Alexander Egorenkov (1):
      s390/dump: fix copying to user-space of swapped kdump oldmem

Alexander Lobakin (2):
      samples/bpf: Fix summary per-sec stats in xdp_sample_user
      samples/bpf: Fix build error due to -isystem removal

Alexander Mikhalitsyn (2):
      ipc: WARN if trying to remove ipc object which is absent
      shm: extend forced shm destroy to support objects from several IPC ns=
es

Alexander Stein (1):
      spi: lpspi: Silence error message upon deferred probe

Alexei Starovoitov (1):
      bpf: Fix inner map state pruning regression.

Alexey Kardashevskiy (3):
      powerpc/pseries/ddw: Revert "Extend upper limit for huge DMA
window for persistent memory"
      powerpc/pseries/ddw: simplify enable_ddw()
      powerpc/pseries/ddw: Do not try direct mapping with persistent
memory and one window

Alistair Delva (1):
      block: Check ADMIN before NICE for IOPRIO_CLASS_RT

Andreas Gruenbacher (5):
      gfs2: Only dereference i->iov when iter_is_iovec(i)
      gfs2: Fix atomic bug in gfs2_instantiate
      gfs2: Fix length of holes reported at end-of-file
      gfs2: Fix "Introduce flag for glock holder auto-demotion"
      gfs2: Prevent endless loops in gfs2_file_buffered_write

Andreas Schwab (1):
      riscv: fix building external modules

Andy Shevchenko (1):
      printk: Remove printk.h inclusion in percpu.h

Anup Patel (1):
      RISC-V: Enable KVM in RV64 and RV32 defconfigs as a module

Ard Biesheuvel (1):
      kmap_local: don't assume kmap PTEs are linear arrays in memory

Arjun Roy (1):
      tcp: Fix uninitialized access in skb frags array for Rx 0cp.

Arnaldo Carvalho de Melo (8):
      selftests: KVM: Add /x86_64/sev_migrate_tests to .gitignore
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      perf tests wp: Remove unused functions on s390
      perf tools: Set COMPAT_NEED_REALLOCARRAY for CONFIG_AUXTRACE=3D1
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools build: Fix removal of feature-sync-compare-and-swap
feature detection
      tools headers UAPI: Sync MIPS syscall table file changed by new
futex_waitv syscall

Arnd Bergmann (2):
      pinctrl: tegra194: remove duplicate initializer again
      thermal: int340x: Limit Kconfig to 64-bit

Avihai Horon (1):
      net/mlx5: Fix flow counters SF bulk query len

Baoquan He (1):
      s390/kexec: fix memory leak of ipl report buffer

Bart Van Assche (1):
      scsi: ufs: core: Improve SCSI abort handling

Bernard Zhao (1):
      drm/amd/amdgpu: fix potential memleak

Bjorn Andersson (2):
      pinctrl: qcom: sdm845: Enable dual edge errata
      pinctrl: qcom: sm8350: Correct UFS and SDC offsets

Bob Peterson (1):
      gfs2: release iopen glock early in evict

Boqun Feng (1):
      Drivers: hv: balloon: Use VMBUS_RING_SIZE() wrapper for dm_ring_size

Borislav Petkov (1):
      x86/boot: Pull up cmdline preparation and early param parsing

Bryan Tan (1):
      MAINTAINERS: Update for VMware PVRDMA driver

Bui Quang Minh (1):
      hugetlb: fix hugetlb cgroup refcounting during mremap

Christian Borntraeger (1):
      MAINTAINERS: update email address of Christian Borntraeger

Christian Brauner (1):
      fs: handle circular mappings correctly

Christian K=C3=B6nig (1):
      drm/scheduler: fix drm_sched_job_add_implicit_dependencies

Christophe JAILLET (1):
      platform/x86: hp_accel: Fix an error handling path in 'lis3lv02d_prob=
e()'

Christophe Leroy (3):
      powerpc/book3e: Fix TLBCAM preset at boot
      powerpc/signal32: Fix sigset_t copy
      powerpc/8xx: Fix pinned TLBs with CONFIG_STRICT_KERNEL_RWX

Chuck Lever (1):
      NFSD: Fix exposure in nfsd4_decode_bitmap()

Colin Ian King (2):
      MIPS: generic/yamon-dt: fix uninitialized variable error
      btrfs: make 1-bit bit-fields of scrub_page unsigned int

Cong Wang (1):
      udp: Validate checksum in udp_read_sock()

C=C3=A9dric Le Goater (1):
      powerpc/xive: Change IRQ domain to a tree domain

Damien Le Moal (3):
      ata: libata: improve ata_read_log_page() error message
      ata: libata: add missing ata_identify_page_supported() calls
      ata: libata-sata: Declare ata_ncq_sdev_attrs static

Dan Carpenter (5):
      spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()
      platform/mellanox: mlxreg-lc: fix error code in
mlxreg_lc_create_static_devices()
      drm/i915/guc: fix NULL vs IS_ERR() checking
      octeontx2-af: debugfs: don't corrupt user memory
      ptp: ocp: Fix a couple NULL vs IS_ERR() checks

Daniel Borkmann (1):
      bpf: Fix toctou on read-only map's constant scalar tracking

Daniel Lezcano (1):
      powercap: DTPM: Fix suspend failure and kernel warning

David Hildenbrand (1):
      proc/vmcore: fix clearing user buffer by properly using clear_user()

David Matlack (4):
      KVM: selftests: Start at iteration 0 instead of -1
      KVM: selftests: Move vCPU thread creation and joining to common helpe=
rs
      KVM: selftests: Wait for all vCPU to be created before entering guest=
 mode
      KVM: selftests: Use perf_test_destroy_vm in
memslot_modification_stress_test

David Woodhouse (8):
      KVM: selftests: Add event channel upcall support to xen_shinfo_test
      KVM: Fix steal time asm constraints
      KVM: x86/xen: Fix get_attr of KVM_XEN_ATTR_TYPE_SHARED_INFO
      KVM: nVMX: Use kvm_{read,write}_guest_cached() for shadow_vmcs12
      KVM: x86/xen: Use sizeof_field() instead of open-coding it
      KVM: nVMX: Use kvm_read_guest_offset_cached() for nested VMCS check
      KVM: nVMX: Use a gfn_to_hva_cache for vmptrld
      KVM: Kill kvm_map_gfn() / kvm_unmap_gfn() and gfn_to_pfn_cache

Davide Caratti (1):
      selftests: add a test case for mirred egress to ingress

Dennis Dalessandro (1):
      IB/hfi1: Properly allocate rdma counter desc memory

Dinh Nguyen (1):
      spi: cadence-quadspi: fix write completion support

Dmitrii Banshchikov (2):
      bpf: Forbid bpf_ktime_get_coarse_ns and bpf_timer_* in tracing progs
      selftests/bpf: Add tests for restricted helpers

Edwin Peer (2):
      bnxt_en: extend RTNL to VF check in devlink driver_reinit
      bnxt_en: fix format specifier in live patch error message

Eric W. Biederman (2):
      signal: Don't always set SA_IMMUTABLE for forced signals
      signal: Replace force_fatal_sig with force_exit_sig when in doubt

Eryk Rybak (3):
      i40e: Fix correct max_pkt_size on VF RX queue
      i40e: Fix changing previously set num_queue_pairs for PFs
      i40e: Fix ping is lost after configuring ADq on VF

Evan Quan (1):
      drm/amd/pm: avoid duplicate powergate/ungate setting

Ewan D. Milne (1):
      scsi: qla2xxx: Fix mailbox direction flags in qla2xxx_get_adapter_id(=
)

Felix Fietkau (2):
      mac80211: drop check for DONT_REORDER in __ieee80211_select_queue
      mac80211: fix throughput LED trigger

Filipe Manana (1):
      btrfs: silence lockdep when reading chunk tree during mount

Geert Uytterhoeven (1):
      pstore/blk: Use "%lu" to format unsigned long

German Gomez (1):
      perf inject: Fix ARM SPE handling

Grzegorz Szczurek (2):
      iavf: Fix for setting queues to 0
      i40e: Fix display error code in dmesg

Guchun Chen (1):
      drm/amdgpu: add error print when failing to add IP block(v2)

Gustavo A. R. Silva (1):
      kbuild: Fix -Wimplicit-fallthrough=3D5 error for GCC 5.x and 6.x

Hans Verkuil (1):
      drm/nouveau: hdmigv100.c: fix corrupted HDMI Vendor InfoFrame

Hans de Goede (1):
      platform/x86: amd-pmc: Make CONFIG_AMD_PMC depend on RTC_CLASS

Heiko Carstens (3):
      s390/kexec: fix return code handling
      ftrace/samples: add missing Kconfig option for ftrace direct multi sa=
mple
      ftrace/samples: add s390 support for ftrace direct multi sample

Helge Deller (5):
      parisc: Include stringify.h to avoid build error in crypto/api.c
      parisc: Wire up futex_waitv
      parisc: Wrap assembler related defines inside __ASSEMBLY__
      Revert "parisc: Reduce sigreturn trampoline to 3 instructions"
      parisc: Enable CONFIG_PRINTK_TIME=3Dy in 32bit defconfig

Ian Rogers (3):
      perf hist: Fix memory leak of a perf_hpp_fmt
      perf report: Fix memory leaks around perf_tip()
      perf evsel: Fix memory leaks relating to unit

Jack Wang (1):
      RDMA/mlx4: Do not fail the registration on port stats

Jacob Keller (1):
      iavf: prevent accidental free of filter structure

Jakub Kicinski (2):
      selftests: net: switch to socat in the GSO GRE test
      ethernet: sis900: fix indentation

Jan Kara (1):
      udf: Fix crash after seekdir

Jason Wang (1):
      platform/x86: samsung-laptop: Fix typo in a comment

Javier Martinez Canillas (1):
      fbdev: Prevent probing generic drivers if a FB is already registered

Jean-Philippe Brucker (1):
      tools/runqslower: Fix cross-build

Jedrzej Jagielski (1):
      i40e: Fix creation of first queue by omitting it if is not power of t=
wo

Jens Axboe (1):
      block: fix missing queue put in error path

Jesse Brandeburg (1):
      e100: fix device suspend/resume

Jiapeng Chong (1):
      net: Clean up some inconsistent indenting

Jimmy Wang (1):
      platform/x86: thinkpad_acpi: Add support for dual fan control

Johannes Berg (3):
      nl80211: fix radio statistics in survey dump
      mac80211: fix radiotap header generation
      mac80211: fix monitor_sdata RCU/locking assertions

Jonathan Corbet (1):
      Remove unused header <linux/sdb.h>

Jonathan Davies (1):
      net: virtio_net_hdr_to_skb: count transport header in UFO

Jordy Zomer (1):
      ipv6: check return value of ipv6_skip_exthdr

Julian Braha (2):
      drm/sun4i: fix unmet dependency on RESET_CONTROLLER for
PHY_SUN6I_MIPI_DPHY
      pinctrl: qcom: fix unmet dependencies on GPIOLIB for GPIOLIB_IRQCHIP

Kalesh Singh (1):
      tracing/histogram: Fix UAF in destroy_hist_field()

Karen Sornek (1):
      i40e: Fix warning message and call stack during rmmod i40e driver

Kees Cook (3):
      Revert "mark pstore-blk as broken"
      tracing: Use memset_startat() to zero struct trace_iterator
      kasan: test: silence intentional read overflow warnings

Kent Gibson (2):
      selftests: gpio: fix uninitialised variable warning
      selftests: gpio: restore CFLAGS options

Konrad Dybcio (1):
      net/ipa: ipa_resource: Fix wrong for loop range

Kumar Kartikeya Dwivedi (2):
      samples/bpf: Fix incorrect use of strlen in xdp_redirect_cpu
      libbpf: Perform map fd cleanup for gen_loader in case of error

Leon Romanovsky (4):
      RDMA/netlink: Add __maybe_unused to static inline in C file
      RDMA/core: Set send and receive CQ before forwarding to the driver
      RDMA/nldev: Check stat attribute before accessing it
      devlink: Don't throw an error if flash notification sent before
devlink visible

Li Zhijian (1):
      selftests: gpio: fix gpio compiling error

Lijo Lazar (1):
      drm/amd/pm: Remove artificial freq level on Navi1x

Lin Ma (4):
      hamradio: remove needs_free_netdev to avoid UAF
      NFC: reorganize the functions in nci_request
      NFC: reorder the logic in nfc_{un,}register_device
      NFC: add NCI_UNREG flag to eliminate the race

Linus Torvalds (1):
      Linux 5.16-rc2

Lorenz Bauer (1):
      selftests/bpf: Check map in map pruning

Luben Tuikov (1):
      drm/amd/pm: Enhanced reporting also for a stuck command

Lukasz Luba (2):
      Documentation: power: Add description about new callback for EM
registration
      Documentation: power: Describe 'advanced' and 'simple' EM models

Magnus Karlsson (1):
      xsk: Fix crash on double free in buffer pool

Maher Sanalla (1):
      net/mlx5: Lag, update tracker when state change event received

Manaf Meethalavalappu Pallikunhi (1):
      thermal: core: Reset previous low and high trip during thermal zone i=
nit

Marcin Wojtas (1):
      net: mvmdio: fix compilation warning

Mario Limonciello (4):
      ACPI: Add stubs for wakeup handler functions
      pinctrl: amd: Fix wakeups when IRQ is shared with SCI
      ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile
      ata: libahci: Adjust behavior when StorageD3Enable _DSD is set

Mark Bloch (1):
      net/mlx5: E-Switch, rebuild lag only when needed

Masahiro Yamada (2):
      powerpc: clean vdso32 and vdso64 directories
      s390/vdso: remove -nostdlib compiler flag

Mateusz Palczewski (1):
      iavf: Fix return of set the new channel count

Matthew Wilcox (1):
      mm/swap.c:put_pages_list(): reinitialise the page list

Mauro Carvalho Chehab (4):
      libbpf: update index.rst reference
      docs: accounting: update delay-accounting.rst reference
      Documentation: update vcpu-requests.rst reference
      Documentation/process: fix a cross reference

Maxim Levitsky (2):
      KVM: nVMX: don't use vcpu->arch.efer when checking host state on
nested state load
      KVM: x86/mmu: include EFER.LMA in extended mmu role

Meng Li (1):
      net: stmmac: socfpga: add runtime suspend/resume callback for
stratix10 platform

Michael Chan (1):
      bnxt_en: Fix compile error regression when CONFIG_BNXT_SRIOV is not s=
et

Michael Ellerman (1):
      KVM: PPC: Book3S HV: Use GLOBAL_TOC for kvmppc_h_set_dabr/xdabr()

Michael Walle (1):
      spi: fix use-after-free of the add_lock mutex

Michal Maloszewski (1):
      i40e: Fix NULL ptr dereference on VSI filter sync

Mike Christie (2):
      scsi: iscsi: Unblock session then wake up error handler
      scsi: core: sysfs: Fix hang when device state is set via sysfs

Mina Almasry (1):
      hugetlb, userfaultfd: fix reservation restore on userfaultfd error

Ming Lei (3):
      blk-mq: cancel blk-mq dispatch work in both blk_cleanup_queue
and disk_release()
      block: avoid to quiesce queue in elevator_init_mq
      blk-mq: don't insert FUA request with data into scheduler queue

Mitch Williams (1):
      iavf: validate pointers

Namhyung Kim (3):
      perf sort: Fix the 'weight' sort key behavior
      perf sort: Fix the 'ins_lat' sort key behavior
      perf sort: Fix the 'p_stage_cyc' sort key behavior

Nathan Chancellor (3):
      hexagon: export raw I/O routines for modules
      hexagon: clean up timer-regs.h
      hexagon: ignore vmlinux.lds

Neta Ostrovsky (1):
      net/mlx5: Update error handler for UCTX and UMEM

Nguyen Dinh Phi (1):
      cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

Nicholas Nunley (3):
      iavf: check for null in iavf_fix_features
      iavf: free q_vectors before queues in iavf_disable_vf
      iavf: don't clear a lock we don't hold

Nicholas Piggin (3):
      printk: restore flushing of NMI buffers on remote CPUs after NMI
backtraces
      powerpc/pseries: rename numa_dist_table to form2_distances
      powerpc/pseries: Fix numa FORM2 parsing fallback code

Nick Terrell (3):
      lib: zstd: Fix unused variable warning
      lib: zstd: Don't inline functions in zstd_opt.c
      lib: zstd: Don't add -O3 to cflags

Nicolas Dichtel (1):
      tun: fix bonding active backup with arp monitoring

Nikita Yushchenko (1):
      tracing: Don't use out-of-sync va_list in event printing

Nikolay Borisov (2):
      btrfs: fix memory ordering between normal and ordered work functions
      btrfs: deprecate BTRFS_IOC_BALANCE ioctl

Pali Roh=C3=A1r (3):
      Documentation: arm: marvell: Add some links to homepage / product inf=
os
      Documentation: arm: marvell: Put Armada XP section between
Armada 370 and 375
      Documentation: arm: marvell: Fix link to armada_1000_pb.pdf document

Paul Blakey (1):
      net/mlx5: E-Switch, Fix resetting of encap mode when entering switchd=
ev

Paul Durrant (1):
      cpuid: kvm_find_kvm_cpuid_features() should be declared 'static'

Paul Moore (1):
      net,lsm,selinux: revert the security_sctp_assoc_established() hook

Paulo Alcantara (1):
      cifs: introduce cifs_ses_mark_for_reconnect() helper

Pavel Skripkin (3):
      net: bnx2x: fix variable dereferenced before check
      MAINTAINERS: remove GR-everest-linux-l2@marvell.com
      net: dpaa2-eth: fix use-after-free in dpaa2_eth_remove

Perry Yuan (1):
      drm/amd/pm: add GFXCLK/SCLK clocks level print support for APUs

Peter Zijlstra (1):
      x86: Pin task-stack in __get_wchan()

Piotr Marczak (1):
      iavf: Fix failure to exit out from last all-multicast mode

Prathamesh Shete (1):
      pinctrl: tegra: Return const pointer from tegra_pinctrl_get_group()

Qing Wang (1):
      s390: replace snprintf in show functions with sysfs_emit

Qu Wenruo (1):
      btrfs: fix a out-of-bound access in copy_compressed_data_to_page()

Raed Salem (1):
      net/mlx5: E-Switch, return error if encap isn't supported

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Release PM resources blocked by unused objects"

Randy Dunlap (6):
      ptp: ptp_clockmatrix: repair non-kernel-doc comment
      net: ethernet: lantiq_etop: fix build errors/warnings
      mips: bcm63xx: add support for clk_get_parent()
      mips: lantiq: add support for clk_get_parent()
      gpio: rockchip: needs GENERIC_IRQ_CHIP to fix build errors
      riscv: kvm: fix non-kernel-doc comment block

Reinette Chatre (1):
      x86/sgx: Fix free page accounting

Rob Clark (1):
      drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder

Roi Dayan (1):
      net/mlx5e: CT, Fix multiple allocations and memleak of mod acts

Roman Li (1):
      drm/amd/display: Fix OLED brightness control on eDP

Rustam Kovhaev (1):
      mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag

Sean Christopherson (19):
      x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if Hyper-V setup =
fails
      x86/hyperv: Move required MSRs check to initial platform probing
      KVM: selftests: Explicitly state indicies for vm_guest_mode_params ar=
ray
      KVM: selftests: Expose align() helpers to tests
      KVM: selftests: Assert mmap HVA is aligned when using HugeTLB
      KVM: selftests: Require GPA to be aligned when backed by hugepages
      KVM: selftests: Use shorthand local var to access struct perf_tests_a=
rgs
      KVM: selftests: Capture per-vCPU GPA in perf_test_vcpu_args
      KVM: selftests: Use perf util's per-vCPU GPA/pages in demand paging t=
est
      KVM: selftests: Move per-VM GPA into perf_test_args
      KVM: selftests: Remove perf_test_args.host_page_size
      KVM: selftests: Create VM with adjusted number of guest pages
for perf tests
      KVM: selftests: Fill per-vCPU struct during "perf_test" VM creation
      KVM: selftests: Sync perf_test_args to guest during VM creation
      KVM: SEV: Disallow COPY_ENC_CONTEXT_FROM if target has created vCPUs
      KVM: SEV: Set sev_info.active after initial checks in sev_guest_init(=
)
      KVM: SEV: WARN if SEV-ES is marked active but SEV is not
      KVM: SEV: Drop a redundant setting of sev->asid during initialization
      KVM: SEV: Fix typo in and tweak name of cmd_allowed_from_miror()

SeongJae Park (2):
      mm/damon/dbgfs: use '__GFP_NOWARN' for user-specified size
buffer allocation
      mm/damon/dbgfs: fix missed use of damon_dbgfs_lock

Sergio Paracuellos (1):
      pinctrl: ralink: include 'ralink_regs.h' in 'pinctrl-mt7620.c'

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 =
deep

Sohaib Mohamed (1):
      perf bench: Fix two memory leaks detected with ASan

Song Liu (1):
      x86/perf: Fix snapshot_branch_stack warning in VM

Sriharsha Basavapatna (1):
      bnxt_en: reject indirect blk offload when hw-tc-offload is off

Steve French (2):
      cifs: move debug print out of spinlock
      cifs: protect srv_count with cifs_tcp_ses_lock

Steven Rostedt (VMware) (1):
      tracing: Add length protection to histogram string copies

Surabhi Boob (1):
      iavf: Fix for the false positive ASQ/ARQ errors while issuing VF rese=
t

Sven Peter (1):
      pinctrl: apple: Always return valid type in apple_gpio_irq_type

Sven Schnelle (2):
      s390/vdso: filter out -mstack-guard and -mstack-size
      parisc/sticon: fix reverse colors

Tadeusz Struk (2):
      tipc: use consistent GFP flags
      tipc: check for null after calling kmemdup

Taehee Yoo (1):
      amt: cancel delayed_work synchronously in amt_fini()

Tariq Toukan (1):
      net/mlx5e: kTLS, Fix crash in RX resync flow

Teng Qi (2):
      ethernet: hisilicon: hns: hns_dsaf_misc: fix a possible array
overflow in hns_dsaf_ge_srst_by_port()
      net: ethernet: dec: tulip: de4x5: fix possible array overflows
in type3_infoblock()

Tetsuo Handa (1):
      sock: fix /proc/net/sockstat underflow in sk_clone_lock()

Thomas Gleixner (1):
      net: stmmac: Fix signed/unsigned wreckage

Thomas Richter (1):
      perf test sample-parsing: Fix branch_stack entry endianness check

Thomas Wei=C3=9Fschuh (1):
      platform/x86: dell-wmi-descriptor: disable by default

Thomas Zimmermann (1):
      drm/cma-helper: Release non-coherent memory with dma_free_noncoherent=
()

Tom Lendacky (1):
      KVM: x86: Assume a 64-bit hypercall for guests with protected state

Uwe Kleine-K=C3=B6nig (1):
      powerpc/83xx/mpc8349emitx: Drop unused variable

Valentine Fatiev (1):
      net/mlx5e: nullify cq->dbg pointer in mlx5_debug_cq_remove()

Vandita Kulkarni (2):
      Revert "drm/i915/tgl/dsi: Gate the ddi clocks after pll mapping"
      drm/i915/dsi/xelpd: Fix the bit mask for wakeup GB

Vasily Gorbik (5):
      s390/setup: avoid reserving memory above identity mapping
      s390/setup: avoid using memblock_enforce_memory_limit
      s390/setup: re-arrange memblock setup
      s390/boot: simplify and fix kernel memory layout setup
      s390: wire up sys_futex_waitv system call

Vincent Bernat (1):
      platform/x86: thinkpad_acpi: fix documentation for adaptive keyboard

Vitaly Kuznetsov (6):
      KVM: arm64: Cap KVM_CAP_NR_VCPUS by kvm_arm_default_max_vcpus()
      KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
      KVM: PPC: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
      KVM: RISC-V: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
      KVM: s390: Cap KVM_CAP_NR_VCPUS by num_online_cpus()
      KVM: x86: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS

Vlad Buslov (1):
      net/mlx5e: Wait for concurrent flow deletion during neigh/fib events

Wang Haojun (1):
      MIPS: syscalls: Wire up futex_waitv syscall

Wang Yugui (1):
      btrfs: check-integrity: fix a warning on write caching disabled disk

Wasin Thonkaew (1):
      docs: filesystems: Fix grammatical error "with" to "which"

Wen Gu (2):
      net/smc: Transfer remaining wait queue entries during fallback
      net/smc: Make sure the link_id is unique

Xin Long (2):
      tipc: only accept encrypted MSG_CRYPTO msgs
      net: sched: act_mirred: drop dst for the direction from egress to ing=
ress

Xing Song (1):
      mac80211: do not access the IV when it was stripped

Yang Li (1):
      gpio: virtio: remove unneeded semicolon

Yevgeny Kliteynik (2):
      net/mlx5: DR, Handle eswitch manager and uplink vports separately
      net/mlx5: DR, Fix check for unsupported fields in match param

Yu Kuai (1):
      blk-cgroup: fix missing put device in error path from blkg_conf_pref(=
)

Yunfeng Ye (1):
      mm: emit the "free" trace report before freeing memory in
kmem_cache_free()

Yunsheng Lin (1):
      page_pool: Revert "page_pool: disable dma mapping support..."

Zekun Shen (1):
      atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

Zhaoyu Liu (1):
      docs: ftrace: fix the wrong path of tracefs

hongao (1):
      drm/amdgpu: fix set scaling mode Full/Full aspect/Center not
works on vga and dvi connectors

liuguoqiang (1):
      net: return correct error code

shaoyunl (1):
      drm/amd/amdkfd: Fix kernel panic when reset failed and been
triggered again

zhangyue (1):
      net: tulip: de4x5: fix the problem that the array 'lp->phy[8]'
may be out of bound

=C5=81ukasz Stelmach (1):
      net: ax88796c: use bit numbers insetad of bit masks

=E9=BB=84=E4=B9=90 (1):
      KVM: x86: Fix uninitialized eoi_exit_bitmap usage in
vcpu_load_eoi_exitmap()
