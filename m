Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F28343563
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 23:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCUWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCUWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:35:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:35:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o126so8843720lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AG62aPAVihbwr+D1OVjGA4sJSVz/4tDxrQVPyeiU66A=;
        b=EsXYL1FNaErf8PalUAPkkAjbMJm1s2tsriYISN0xR2UNLWlqubyPJ8fcex3E3hRKMA
         nnBH2DXSqr29qWK8X2EJoO59nguRdxfn1XvCD85lz9tDcryvoPb4vbGROHbKJWiZPc8Y
         77FgZxqmmtlK0tefSOxtvIh70ey5tTN+4crIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AG62aPAVihbwr+D1OVjGA4sJSVz/4tDxrQVPyeiU66A=;
        b=o3nO28zxRHwTrYi48oBxU/Vl9l36ssRwLfKGE9fSMdZkcFV1L9kJtPj8xpqCJOwG3s
         ukJ3ocqy12RyFeT18vPP4cke7u2OI3ZALvLBZHaUYZXChJ/4XaNG8wQ8K4HwNgS+9iji
         OVAGzJsNqlzIjE/KujlBXawqjKK+ZB695VI7uGukM1Zse5W8nqpnHxw9aHDLH3IEBJbx
         O31RqoFoEi9y6A1A26J5k0K9Yy3T8TVNPFY/+VndtnEI1txvc7R0BJ/loq/Y7LYbiVSu
         1cxyqtmrGi0WKvhkfNl/X7CIFyAVqPoUAYJtWWjnwOgLad710j3iGHh5o4CiJbDIQQ6l
         UM6A==
X-Gm-Message-State: AOAM5336J8cH6F6AvpfBWLvpDAuTgEgKp15kq1apWpMyG2RqponA1rYT
        PUw6uRid8bZT8qSCYSz8xt8fRd6BfE8SVQ==
X-Google-Smtp-Source: ABdhPJxUQTOKkr8o/CX9dTmMX+B1lOJoOP7sGpDO3TexzG0bAdskTIwpyqfDhy8arh4VL1QCAwOBIA==
X-Received: by 2002:a05:6512:3283:: with SMTP id p3mr2235860lfe.570.1616366115927;
        Sun, 21 Mar 2021 15:35:15 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i2sm1355361lfl.308.2021.03.21.15.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 15:35:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i26so2507251lfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:35:14 -0700 (PDT)
X-Received: by 2002:ac2:4250:: with SMTP id m16mr6939156lfl.40.1616366114264;
 Sun, 21 Mar 2021 15:35:14 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Mar 2021 15:34:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDxybSS63==ycQiNobvamDmoyxQo1JL-31Tup8azbeWw@mail.gmail.com>
Message-ID: <CAHk-=whDxybSS63==ycQiNobvamDmoyxQo1JL-31Tup8azbeWw@mail.gmail.com>
Subject: Linux 5.12-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very much an average rc4, possibly just a tad on the smaller side of averag=
e.

Nothing here particularly stands out. The diffstat looks a bit more
spread out than it perhaps normally would do, because of the removal
of the (never used) MODULE_SUPPORTED_DEVICE() thing that causes some
trivial line removal in various drivers, but not only did it never do
anything, it wasn't actually even all that common (ie it certainly
wasn't a "most drivers" kind of situation).

Anyway, drivers (sound, gpu, nvme, USB), some filesystem updates,
io-uring (signal fixes and cleanups), arch fixes (mostly RISC-V and
x86 kvm), and just random small things all over.

So I'll just tempt the fates and say that everything looks pretty
normal and this release seems to look good despite the rc1 hiccup,

            Linus

---

Alan Stern (1):
      usb-storage: Add quirk to defeat Kindle's automatic unload

Alessio Balsini (1):
      fuse: 32-bit user space ioctl compat for fuse device

Alexander Shiyan (1):
      ASoC: fsl_ssi: Fix TDM slot setup for I2S mode

Alexandre Ghiti (1):
      riscv: Ensure page table writes are flushed when initializing
KASAN vmalloc

Alexandru Ardelean (1):
      iio: adc: adi-axi-adc: add proper Kconfig dependencies

Alexey Dobriyan (1):
      scsi: qla2xxx: Fix broken #endif placement

Amir Goldstein (1):
      fuse: fix live lock in fuse_iget()

Andy Shevchenko (2):
      gpiolib: Assign fwnode to parent's if no primary one provided
      genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)

Ard Biesheuvel (1):
      efi: use 32-bit alignment for efi_guid_t literals

Aurelien Aptel (1):
      cifs: warn and fail if trying to use rootfs without the config option

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Invoke power_supply_changed for tcpm-source-psy-
      usb: typec: tcpm: Skip sink_cap query only when VDM sm is busy

Bard Liao (1):
      ASoC: rt711: add snd_soc_component remove callback

Ben Gardon (3):
      KVM: x86/mmu: Fix RCU usage in handle_removed_tdp_mmu_page
      KVM: x86/mmu: Fix RCU usage when atomically zapping SPTEs
      KVM: x86/mmu: Factor out tdp_iter_return_to_root

Benjamin Rood (1):
      ASoC: sgtl5000: set DAP_AVC_CTRL register to correct default
value on probe

Bhaskar Chowdhury (1):
      docs: ABI: Fix the spelling oustanding to outstanding in the
file sysfs-fs-xfs

Calvin Hou (1):
      drm/amd/display: Correct algorithm for reversed gamma

Chao Yu (1):
      zonefs: fix to update .i_wr_refcnt correctly in zonefs_open_zone()

Christian K=C3=B6nig (1):
      drm/ttm: make ttm_bo_unpin more defensive

Christoph Hellwig (5):
      xfs: also reject BULKSTAT_SINGLE in a mount user namespace
      nvme-fabrics: only reserve a single tag
      nvme: merge nvme_keep_alive into nvme_keep_alive_work
      nvme: allocate the keep alive request using BLK_MQ_REQ_NOWAIT
      nvme: fix Write Zeroes limitations

Christophe JAILLET (1):
      scsi: mpt3sas: Do not use GFP_KERNEL in atomic context

Christophe Leroy (2):
      powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
      powerpc: Force inlining of cpu_has_feature() to avoid build failure

Chuck Lever (1):
      svcrdma: Revert "svcrdma: Reduce Receive doorbell rate"

Colin Ian King (4):
      ASoC: codecs: lpass-rx-macro: Fix uninitialized variable ec_tx
      ftrace: Fix spelling mistake "disabed" -> "disabled"
      usbip: Fix incorrect double assignment to udc->ud.tcp_rx
      ALSA: usb-audio: Fix unintentional sign extension issue

Damien Le Moal (3):
      zonefs: prevent use of seq files as swap file
      zonefs: Fix O_APPEND async write handling
      riscv: Fix compilation error with Canaan SoC

Dan Carpenter (2):
      iio: adis16400: Fix an error code in adis16400_initial_setup()
      scsi: lpfc: Fix some error codes in debugfs

Daniel Jordan (1):
      vfio/type1: fix vaddr_get_pfns() return in vfio_pin_page_external()

Daniel Kobras (1):
      sunrpc: fix refcount leak for rpc auth modules

Darrick J. Wong (2):
      xfs: fix quota accounting when a mount is idmapped
      xfs: force log and push AIL to clear pinned inodes when aborting moun=
t

David Howells (2):
      afs: Fix accessing YFS xattrs on a non-YFS server
      afs: Stop listxattr() from listing "afs.*" attributes

David Sterba (1):
      btrfs: fix slab cache flags for free space tree bitmap

Dillon Varone (1):
      drm/amd/display: Remove MPC gamut remap logic for DCN30

Dinghao Liu (1):
      iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler

Dmitry Osipenko (1):
      iommu/tegra-smmu: Make tegra_smmu_probe_device() to handle all
IOMMU phandles

Edmundo Carmona Antoranz (1):
      staging: vt665x: fix alignment constraints

Elad Grupi (1):
      nvmet-tcp: fix kmap leak when data digest in use

Elias Rudberg (1):
      usb: typec: Remove vdo[3] part of tps6598x_rx_identity_reg struct

Emanuele Giuseppe Esposito (4):
      selftests: kvm: add get_msr_index_features
      selftests: kvm: add _vm_ioctl
      selftests: kvm: add set_boot_cpu_id test
      documentation/kvm: additional explanations on KVM_SET_BOOT_CPU_ID

Eric Biggers (1):
      ext4: fix error handling in ext4_end_enable_verity()

Eric W. Biederman (1):
      signal: don't allow STOP on PF_IO_WORKER threads

Eric Whitney (1):
      ext4: shrink race window in ext4_should_retry_alloc()

Fabrice Gasnier (2):
      counter: stm32-timer-cnt: fix ceiling write max value
      counter: stm32-timer-cnt: fix ceiling miss-alignment with reload regi=
ster

Filipe Manana (3):
      btrfs: zoned: fix linked list corruption after log root tree
allocation failure
      btrfs: fix race when cloning extent buffer during rewind of an old ro=
ot
      btrfs: always pin deleted leaves when there are active tree mod log u=
sers

Gautam Dawar (1):
      vhost_vdpa: fix the missing irq_bypass_unregister_producer() invocati=
on

Geert Uytterhoeven (1):
      RISC-V: Fix out-of-bounds accesses in init_resources()

Gerald Schaefer (1):
      s390/vtime: fix increased steal time accounting

Greg Kroah-Hartman (2):
      MAINTAINERS: move some real subsystems off of the staging mailing lis=
t
      MAINTAINERS: move the staging subsystem to lists.linux.dev

Hans de Goede (8):
      ASoC: rt5670: Remove 'OUT Channel Switch' control
      ASoC: rt5670: Remove 'HP Playback Switch' control
      ASoC: rt5670: Remove ADC vol-ctrl mute bits poking from Sto1 ADC
mixer settings
      ASoC: rt5670: Add emulated 'DAC1 Playback Switch' control
      ASoC: Intel: bytcr_rt5640: Fix HP Pavilion x2 10-p0XX OVCD
current threshold
      ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor =
of 10
      ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor =
of 10
      ASoC: es8316: Simplify adc_pga_gain_tlv table

Harshad Shirwadkar (1):
      ext4: fix rename whiteout with fast commit

Heinrich Schuchardt (1):
      RISC-V: correct enum sbi_ext_rfence_fid

Hui Wang (1):
      ALSA: hda: generic: Fix the micmute led init state

J. Bruce Fields (4):
      nfsd: don't abort copies early
      rpc: fix NULL dereference on kmalloc failure
      Revert "nfsd4: remove check_conflicting_opens warning"
      Revert "nfsd4: a client's own opens needn't prevent delegations"

Jack Yu (2):
      ASoC: rt1015: fix i2c communication error
      ASoC: rt1015: enable BCLK detection after calibration

Jan Kara (2):
      ext4: add reclaim checks to xattr code
      ext4: fix timer use-after-free on failed mount

Jason Gunthorpe (4):
      vfio: IOMMU_API should be selected
      vfio-platform: Add COMPILE_TEST to VFIO_PLATFORM
      ARM: amba: Allow some ARM_AMBA users to compile with COMPILE_TEST
      vfio: Depend on MMU

Jason Wang (1):
      vdpa: set the virtqueue num during register

Jens Axboe (5):
      kernel: freezer should treat PF_IO_WORKER like PF_KTHREAD for freezin=
g
      io_uring: allow IO worker threads to be frozen
      io_uring: convert io_buffer_idr to XArray
      signal: don't allow sending any signals to PF_IO_WORKER threads
      io-wq: ensure task is running before processing task_work

Jeremy Szu (3):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP 840 G8
      ALSA: hda/realtek: fix mute/micmute LEDs for HP 440 G8
      ALSA: hda/realtek: fix mute/micmute LEDs for HP 850 G8

Jiaxin Yu (1):
      ASoC: mediatek: mt8192: fix tdm out data is valid on rising edge

Jim Lin (1):
      usb: gadget: configfs: Fix KASAN use-after-free

Joe Korty (1):
      NFSD: Repair misuse of sv_lock in 5.10.16-rt30.

Joerg Roedel (3):
      iommu/amd: Move Stoney Ridge check to detect_ivrs()
      iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is disabl=
ed
      iommu/amd: Keep track of amd_iommu_irq_remap state

Johan Hovold (1):
      x86/apic/of: Fix CPU devicetree-node lookups

Johannes Thumshirn (1):
      scsi: sd_zbc: Update write pointer offset cache

Jon Hunter (1):
      ASoC: soc-core: Prevent warning if no DMI table is present

Jonathan Albrieux (1):
      iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel

Jonathan Cameron (1):
      iio:adc:stm32-adc: Add HAS_IOMEM dependency

Jonathan Marek (2):
      ASoC: codecs: lpass-va-macro: mute/unmute all active decimators
      ASoC: codecs: lpass-wsa-macro: fix RX MIX input controls

Josef Bacik (1):
      Revert "PM: ACPI: reboot: Use S5 for reboot"

Julian Braha (1):
      fs: nfsd: fix kconfig dependency warning for NFSD_V4

Junlin Yang (1):
      drm/omap: dsi: fix unsigned expression compared with zero

Kan Liang (2):
      perf/x86/intel: Fix a crash caused by zero PEBS status
      perf/x86/intel: Fix unchecked MSR access error caused by VLBR_EVENT

Kefeng Wang (1):
      riscv: Correct SPARSEMEM configuration

Laurent Vivier (1):
      vhost: Fix vhost_vq_reset()

Leon Romanovsky (1):
      module: remove never implemented MODULE_SUPPORTED_DEVICE

Linus Torvalds (1):
      Linux 5.12-rc4

Linus Walleij (1):
      iio: adc: ab8500-gpadc: Fix off by 10 to 3

Liu xuzhi (1):
      fs/cifs/: fix misspellings using codespell tool

Lucas Tanure (5):
      ASoC: cs42l42: Fix Bitclock polarity inversion
      ASoC: cs42l42: Fix channel width support
      ASoC: cs42l42: Fix mixer volume control
      ASoC: cs42l42: Don't enable/disable regulator at Bias Level
      ASoC: cs42l42: Always wait at least 3ms after reset

Lv Yunlong (3):
      scsi: myrs: Fix a double free in myrs_cleanup()
      scsi: st: Fix a use after free in st_open()
      firmware/efi: Fix a use after bug in efi_mem_reserve_persistent

Manaf Meethalavalappu Pallikunhi (1):
      thermal/core: Add NULL pointer check before using cooling device stat=
s

Meng Li (1):
      spi: cadence: set cqspi to the driver_data field of struct device

Mika Westerberg (2):
      thunderbolt: Initialize HopID IDAs in tb_switch_alloc()
      thunderbolt: Increase runtime PM reference count on DP tunnel discove=
ry

Nanyong Sun (9):
      riscv: traps: Fix no prototype warnings
      riscv: irq: Fix no prototype warning
      riscv: sbi: Fix comment of __sbi_set_timer_v01
      riscv: ptrace: Fix no prototype warnings
      riscv: time: Fix no prototype for time_init
      riscv: syscall_table: Reduce W=3D1 compilation warnings noise
      riscv: process: Fix no prototype for show_regs
      riscv: ftrace: Use ftrace_get_regs helper
      riscv: process: Fix no prototype for arch_dup_task_struct

Niklas Schnelle (1):
      s390/pci: fix leak of PCI device structure

Oleg Nesterov (4):
      kernel, fs: Introduce and use set_restart_fn() and arch_set_restart_d=
ata()
      x86: Move TS_COMPAT back to asm/thread_info.h
      x86: Introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
      x86: Introduce restart_block->arch_data to remove TS_COMPAT_RESTART

Olga Kornievskaia (2):
      NFSD: fix dest to src mount in inter-server COPY
      NFSD: fix error handling in NFSv4.0 callbacks

Palmer Dabbelt (1):
      RISC-V: kasan: Declare kasan_shallow_populate() static

Pan Bian (1):
      ext4: stop inode update before return

Pan Xiuli (1):
      ASoC: SOF: intel: fix wrong poll bits in dsp power down

Parav Pandit (1):
      vdpa_sim: Skip typecasting from void*

Paul Cercueil (1):
      MIPS: vmlinux.lds.S: Fix appended dtb not properly aligned

Pavel Begunkov (8):
      io_uring: fix ->flags races by linked timeouts
      io_uring: fix complete_post use ctx after free
      io_uring: replace sqd rw_semaphore with mutex
      io_uring: halt SQO submission on ctx exit
      io_uring: fix concurrent parking
      io_uring: add generic callback_head helpers
      io_uring: fix sqpoll cancellation via task_work
      io_uring: don't leak creds on SQO attach error

Pawel Laszczak (1):
      usb: cdnsp: Fixes incorrect value in ISOC TRB

Peter Robinson (1):
      ASoC: remove remnants of sirf prima/atlas audio codec

Peter Zijlstra (3):
      static_call: Fix static_call_set_init()
      static_call: Align static_call_is_init() patching condition
      static_call: Fix static_call_update() sanity check

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: unregister DMIC device on probe error

Qu Wenruo (5):
      btrfs: fix wrong offset to zero out range beyond i_size
      btrfs: track qgroup released data in own variable in
insert_prealloc_file_extent
      btrfs: fix qgroup data rsv leak caused by falloc failure
      btrfs: subpage: fix wild pointer access during metadata read failure
      btrfs: subpage: make readahead work properly

Rafael J. Wysocki (1):
      Revert "PM: runtime: Update device status before letting
suppliers suspend"

Ritesh Harjani (1):
      iomap: Fix negative assignment to unsigned sis->pages in
iomap_swapfile_activate

Sabyrzhan Tasbolatov (1):
      fs/ext4: fix integer overflow in s_log_groups_per_flex

Sagi Grimberg (5):
      nvme-tcp: fix a NULL deref when receiving a 0-length r2t PDU
      nvme-tcp: fix misuse of __smp_processor_id with preemption enabled
      nvme-tcp: fix possible hang when failing to set io queues
      nvme-rdma: fix possible hang when failing to set io queues
      nvmet: don't check iosqes,iocqes for discovery controllers

Sameer Pujar (2):
      ASoC: simple-card-utils: Do not handle device clock
      ASoC: rt5659: Update MCLK rate in set_sysclk()

Sean Christopherson (2):
      KVM: x86/mmu: Store the address space ID in the TDP iterator
      KVM: x86: Protect userspace MSR filter with SRCU, and set atomically-=
ish

Shawn Guo (1):
      efivars: respect EFI_UNSUPPORTED return from firmware

Shengjiu Wang (3):
      ASoC: ak4458: Add MODULE_DEVICE_TABLE
      ASoC: ak5558: Add MODULE_DEVICE_TABLE
      ASoC: dt-bindings: fsl_spdif: Add compatible string for new platforms

Shijie Luo (1):
      ext4: fix potential error in ext4_do_update_inode

Shyam Prasad N (1):
      cifs: update new ACE pointer after populate_new_aces.

Srinivas Kandagatla (3):
      ASoC: qcom: sdm845: Fix array out of bounds access
      ASoC: qcom: sdm845: Fix array out of range on rx slim channels
      ASoC: codecs: wcd934x: add a sanity check in set channel map

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-cpu: Fix lpass dai ids parse

Stefan Metzmacher (4):
      io_uring: imply MSG_NOSIGNAL for send[msg]()/recv[msg]() calls
      io_uring: remove structures from include/linux/io_uring.h
      io_uring: use typesafe pointers in io_uring_task
      io_uring: call req_set_fail_links() on short
send[msg]()/recv[msg]() with MSG_WAITALL

Stefano Garzarella (2):
      vhost-vdpa: fix use-after-free of v->config_ctx
      vhost-vdpa: set v->config_ctx to NULL if eventfd_ctx_fdget() fails

Steve French (1):
      cifs: fix allocation size on newly created files

Steve Sistare (1):
      vfio/type1: fix unmap all on ILP32

Steven Rostedt (VMware) (1):
      workqueue/tracing: Copy workqueue name to buffer in trace event

Sung Lee (1):
      drm/amd/display: Copy over soc values before bounding box creation

Takashi Sakamoto (1):
      ALSA: dice: fix null pointer dereference when node is disconnected

Tang Bin (1):
      virtio-mmio: Use to_virtio_mmio_device() to simply code

Theodore Ts'o (1):
      ext4: initialize ret to suppress smatch warning

Thomas Gleixner (2):
      x86/ioapic: Ignore IRQ2 again
      genirq: Disable interrupts for force threaded handlers

Thomas Richter (1):
      s390/cpumf: disable preemption when accessing per-cpu variable

Timo Rothenpieler (1):
      svcrdma: disable timeouts on rdma backchannel

Tobias Klausmann (1):
      nouveau: Skip unvailable ttm page entries

Tong Zhang (2):
      staging: comedi: cb_pcidas: fix request_irq() warn
      staging: comedi: cb_pcidas64: fix request_irq() warn

Trond Myklebust (1):
      nfsd: Don't keep looking up unhashed files in the nfsd file cache

Tyrel Datwyler (2):
      scsi: ibmvfc: Free channel_setup_buf during device tear down
      PCI: rpadlpar: Fix potential drc_name corruption in store functions

Umesh Nerlige Ramappa (1):
      i915/perf: Start hrtimer only if sampling the OA buffer

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Workaround async flip + VT-d corruption on HSW/BDW

Vincent Whitchurch (1):
      cifs: Fix preauth hash corruption

Vitaly Kuznetsov (5):
      KVM: x86: hyper-v: Limit guest to writing zero to
HV_X64_MSR_TSC_EMULATION_STATUS
      KVM: x86: hyper-v: Prevent using not-yet-updated TSC page by
secondary CPUs
      KVM: x86: hyper-v: Track Hyper-V TSC page status
      KVM: x86: hyper-v: Don't touch TSC page values when guest opted
for re-enlightenment
      selftests: kvm: Add basic Hyper-V clocksources tests

Vivek Goyal (1):
      virtiofs: Fail dax mount if device does not support it

Waiman Long (2):
      locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
      locking/ww_mutex: Fix acquire/release imbalance in
ww_acquire_init()/ww_acquire_fini()

Wanpeng Li (2):
      KVM: X86: Fix missing local pCPU when executing wbinvd on all dirty p=
CPUs
      x86/kvm: Fix broken irq restoration in kvm_wait

Wei Yongjun (1):
      gpiolib: Fix error return code in gpiolib_dev_init()

Wesley Cheng (1):
      usb: dwc3: gadget: Prevent EP queuing while stopping transfers

Wilfried Wessner (1):
      iio: adc: ad7949: fix wrong ADC result due to incorrect bit mask

William Breathitt Gray (1):
      counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISAB=
LED

Xianting Tian (1):
      virtio: remove export for virtio_config_{enable, disable}

Xiaoliang Yu (2):
      ALSA: hda/realtek: Apply headset-mic quirks for Xiaomi Redmibook Air
      ALSA: hda/realtek: apply pin quirk for XiaomiNotebook Pro

Ye Xiang (3):
      iio: hid-sensor-prox: Fix scale not correct issue
      iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
      iio: hid-sensor-temperature: Fix issues of timestamp channel

Zhaolong Zhang (1):
      ext4: fix bh ref count on error paths

dongjian (1):
      scsi: ufs: ufs-mediatek: Correct operator & -> &&

kernel test robot (1):
      riscv: fix bugon.cocci warnings

zhangyi (F) (3):
      ext4: find old entry again if failed to rename whiteout
      ext4: do not iput inode under running transaction in ext4_rename()
      ext4: do not try to set xattr into ea_inode if value is empty
