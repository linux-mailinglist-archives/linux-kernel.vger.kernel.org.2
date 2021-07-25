Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E43D507E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGYWOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 18:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGYWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 18:14:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9815C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 15:55:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r17so12139386lfe.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W4ZSLeraIqJz6KZ92Ep3IwC1mjyiDeXQW3yPleOsO6c=;
        b=VzBI91CCdCJ4mfK0XBQFWDUp+k/2D4zsDPv8BKkETJjmDqIPmeJYaxVWzSYXduQy40
         qk3du/yicyOlPEdSSyq/yz9O2VTERO0jnLCoI7029jxCrpBpqtR2sn2OB3ZQu7R1eKQD
         gTiUPc5HwyNyquzVBqlsT9IV7mYON1i/umDqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W4ZSLeraIqJz6KZ92Ep3IwC1mjyiDeXQW3yPleOsO6c=;
        b=ooV3lIOoMonaTqygX40/bvwnQnDJ2g53y+hiLQOwmp7kZL2bJIVcGhQ/rIP0yq1ckh
         m9f/n1mB7oqwsNNy6bYLxTq6J6lBXNKfh9xSobSFsAPfofkhB14a9PgQOyoCzNDw8xG7
         0SLaK8qDche320iWQd+SLox7jyyX/duNb/FPtwbPtHnxVkhBl4ODbHDRQPSgtFIfOFcS
         VhYtsi3NkVxph0u4d+AYXB+o+bYcLiMzDcGMDfZV6Hyc3ZI5iYB6JOq0+XS+QXuApe3r
         JwyK9Eg+nfkZZIbPtp4PXles64cjTiJoMNZEAEEXU6U0oSvjOWxKh8UKWZ66AflJzaKP
         hobA==
X-Gm-Message-State: AOAM530QSrFH0XabqCNt2+bzi3raQDaCFag6fUGk4mMbqQEuvO2kxmiI
        1nKO0aSvC19mh9pELYB8d7XIMpR13WGR3O/w
X-Google-Smtp-Source: ABdhPJxseczlw38HsD+2GS4j43nxfdq/xqSLUhAmDtXEVceQAmYfXwrRAwri41IM2AUI3waQXcNGJA==
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr10422453lfd.47.1627253713638;
        Sun, 25 Jul 2021 15:55:13 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y19sm2308316lfa.294.2021.07.25.15.55.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 15:55:13 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m13so12073392lfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 15:55:13 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr10448457lfl.487.1627253712706;
 Sun, 25 Jul 2021 15:55:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jul 2021 15:54:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvwZiLbZpFUApWFDkwyjC3+EmRoEBAuP+VzNQaMd630g@mail.gmail.com>
Message-ID: <CAHk-=wgvwZiLbZpFUApWFDkwyjC3+EmRoEBAuP+VzNQaMd630g@mail.gmail.com>
Subject: Linux 5.14-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we are, a week later. After a relatively big rc2, things seem to
have calmed down and rc3 looks pretty normal. Most of the fixes here
are small, and the diffstat looks largely flat. And there's not an
undue amount of stuff.

The fixes are spread fairly evenly all over - driver changes do
dominate, but it all seems commensurate with code size in general, so
not anything odd or unusual. There's two bigger commits, but one of
them is a revert, and the other is just making the amdgpu codec info
structure initializations much clearer.

There are still various discussions about a few pending issues still,
but on the whole things are looking pretty good, and I know of nothing
so scary as to keep people from getting their toes wet and testing
this all out.

Please test,
          Linus

---

Aaron Liu (2):
      drm/amdgpu: update yellow carp external rev_id handling
      drm/amdgpu: add yellow carp pci id (v2)

Adrian Hunter (1):
      driver core: Prevent warning when removing a device link from
unregistered consumer

Akira Tsukamoto (4):
      riscv: __asm_copy_to-from_user: Fix: overrun copy
      riscv: __asm_copy_to-from_user: Fix: fail on RV32
      riscv: __asm_copy_to-from_user: Remove unnecessary size check
      riscv: __asm_copy_to-from_user: Fix: Typos in comments

Alain Volmat (2):
      spi: stm32h7: fix full duplex irq handler handling
      spi: stm32: fixes pm_runtime calls in probe/remove

Alan Stern (1):
      USB: core: Fix incorrect pipe calculation in do_proc_control()

Alan Young (1):
      ALSA: pcm: Call substream ack() method upon compat mmap commit

Alexander Egorenkov (1):
      s390/boot: fix use of expolines in the DMA code

Alexander Potapenko (2):
      kfence: move the size check to the beginning of __kfence_alloc()
      kfence: skip all GFP_ZONEMASK allocations

Alexander Tsoy (1):
      ALSA: usb-audio: Add registration quirk for JBL Quantum headsets

Alexandre Ghiti (3):
      riscv: Fix memory_limit for 64-bit kernel
      riscv: Make sure the linear mapping does not use the kernel mapping
      riscv: Make sure the kernel mapping does not overlap with IS_ERR_VALU=
E

Alexandru Tachici (1):
      spi: spi-bcm2835: Fix deadlock

Amelie Delaunay (2):
      usb: typec: stusb160x: register role switch before interrupt registra=
tion
      usb: typec: stusb160x: Don't block probing of consumer of
"connector" nodes

Anand Jain (1):
      btrfs: check for missing device in btrfs_trim_fs

Andy Shevchenko (1):
      ACPI: utils: Fix reference counting in for_each_acpi_dev_match()

Apurva Nandan (1):
      spi: cadence-quadspi: Disable Auto-HW polling

Arnd Bergmann (1):
      net: ixp46x: fix ptp build failure

Artur Petrosyan (1):
      usb: phy: Fix page fault from usb_phy_uevent

Atish Patra (1):
      efi/libstub: Fix the efi_load_initrd function description

Axel Lin (5):
      regulator: rt5033: Fix n_voltages settings for BUCK and LDO
      regulator: hi6421v600: Fix getting wrong drvdata that causes boot fai=
lure
      regulator: bd9576: Fix testing wrong flag in check_temp_flag_mismatch
      regulator: mtk-dvfsrc: Fix wrong dev pointer for devm_regulator_regis=
ter
      regulator: hi6421: Fix getting wrong drvdata

Baruch Siach (1):
      doc, af_xdp: Fix bind flags option typo

Bhaumik Bhatt (2):
      bus: mhi: pci_generic: Apply no-op for wake using sideband wake boole=
an
      bus: mhi: core: Validate channel ID when processing command completio=
ns

Biju Das (2):
      ravb: Fix a typo in comment
      ravb: Remove extra TAB

Bin Meng (1):
      riscv: Fix 32-bit RISC-V boot failure

Bindu Ramamurthy (2):
      drm/amd/display: Populate socclk entries for dcn3.02/3.03
      drm/amd/display: Populate dtbclk entries for dcn3.02/3.03

Borislav Petkov (1):
      efi/mokvar: Reserve the table only if it is in boot services data

Camille Cho (1):
      drm/amd/display: Only set default brightness for OLED

Charles Baylis (1):
      drm: Return -ENOTTY for non-drm ioctls

Charles Keepax (2):
      ASoC: wm_adsp: Correct wm_coeff_tlv_get handling
      ASoC: wm_adsp: Add CCM_CORE_RESET to Halo start core

Chengwen Feng (1):
      net: hns3: fix possible mismatches resp of mailbox

ChiYuan Huang (1):
      regulator: rtmv20: Fix wrong mask for strobe-polarity-high

Chris Packham (1):
      i2c: mpc: Poll for MCF

Christian Borntraeger (1):
      s390/defconfig: allow early device mapper disks

Christian K=C3=B6nig (1):
      drm/nouveau: init the base GEM fields for internal BOs

Christoph Hellwig (4):
      nvme: set the PRACT bit when using Write Zeroes with T10 PI
      btrfs: store a block_device in struct btrfs_ordered_extent
      mm: call flush_dcache_page() in memcpy_to_page() and memzero_page()
      mm: use kmap_local_page in memzero_page

Colin Ian King (4):
      liquidio: Fix unintentional sign extension issue on left shift of u16
      s390/bpf: Perform r1 range checking before accessing jit->seen_reg[r1=
]
      usb: gadget: u_serial: remove WARN_ON on null port
      ftrace: Remove redundant initialization of variable ret

Colin Xu (1):
      drm/i915/gvt: Clear d3_entered on elsp cmd submission.

Dan Sneddon (1):
      spi: atmel: Fix CS and initialization bug

Daniel Borkmann (1):
      bpf: Fix tail_call_reachable rejection for interpreter when jit faile=
d

David Disseldorp (1):
      scsi: target: Fix NULL dereference on XCOPY completion

David Howells (2):
      afs: Fix tracepoint string placement with built-in AFS
      afs: Fix setting of writeback_index

David Jeffery (1):
      usb: ehci: Prevent missed ehci interrupts with edge-triggered MSI

Dmitry Bogdanov (1):
      scsi: target: Fix protect handling in WRITE SAME(32)

Dongliang Mu (1):
      usb: hso: fix error handling code of hso_create_net_device

Edwin Peer (1):
      bnxt_en: reject ETS settings that will starve a TC

Eric Dumazet (2):
      net/tcp_fastopen: fix data races around tfo_active_disable_stamp
      net/tcp_fastopen: remove obsolete extern

Eric Sandeen (1):
      seq_file: disallow extremely large seq buffer allocations

Eric Woudstra (2):
      mt7530 fix mt7530_fdb_write vid missing ivl bit
      mt7530 mt7530_fdb_write only set ivl bit vid larger than 1

Eric Yang (2):
      drm/amd/display: implement workaround for riommu related hang
      drm/amd/display: change zstate allow msg condition

Felix Kuehling (1):
      drm/amdgpu: workaround failed COW checks for Thunk VMAs

Filipe Manana (2):
      btrfs: fix unpersisted i_size on fsync after expanding truncate
      btrfs: fix lock inversion problem when doing qgroup extent tracing

Frederic Weisbecker (1):
      posix-cpu-timers: Fix rearm racing against process tick

Geert Uytterhoeven (2):
      net: dsa: mv88e6xxx: NET_DSA_MV88E6XXX_PTP should depend on
NET_DSA_MV88E6XXX
      m68k: MAC should select HAVE_PATA_PLATFORM

Greg Kroah-Hartman (2):
      Revert "arm64: dts: qcom: Harmonize DWC USB3 DT nodes name"
      nds32: fix up stack guard gap

Greg Thelen (1):
      usb: xhci: avoid renesas_usb_fw.mem when it's unusable

Gustavo A. R. Silva (2):
      powerpc/pasemi: Fix fall-through warning for Clang
      media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf(=
)

Haiyang Zhang (1):
      Drivers: hv: vmbus: Fix duplicate CPU assignments within a device

Hannes Reinecke (1):
      nvme: fix refcounting imbalance when all paths are down

Haoran Luo (1):
      tracing: Fix bug in rb_per_cpu_empty() that might cause deadloop.

Heiko Carstens (1):
      s390: update defconfigs

Heinrich Schuchardt (1):
      RISC-V: load initrd wherever it fits into memory

Hui Wang (1):
      ALSA: hda/realtek: Fix pop noise and 2 Front Mic issues on a machine

Ian Ray (1):
      USB: serial: cp210x: fix comments for GE CS1000

Ilias Apalodimas (1):
      skbuff: Fix a potential race while recycling page_pool packets

Ilya Dryomov (3):
      rbd: always kick acquire on "acquired" and "released" notifications
      rbd: don't hold lock_rwsem while running_list is being drained
      rbd: resurrect setting of disk->private_data in rbd_init_disk()

Ingo Molnar (2):
      jump_labels: Mark __jump_label_transform() as __always_inlined
to work around aggressive compiler un-inlining
      smpboot: Mark idle_init() as __always_inlined to work around
aggressive compiler un-inlining

Ioana Ciornei (1):
      dpaa2-switch: seed the buffer pool after allocating the swp

Jakub Sitnicki (1):
      bpf, sockmap, udp: sk_prot needs inuse_idx set for proc stats

Jason Ekstrand (4):
      drm/i915: Revert "drm/i915/gem: Asynchronous cmdparser"
      Revert "drm/i915: Propagate errors on awaiting already signaled fence=
s"
      drm/ttm: Force re-init if ttm_global_init() fails
      drm/i915: Correct the docs for intel_engine_cmd_parser

Jean-Philippe Brucker (1):
      arm64: smccc: Save lr before calling __arm_smccc_sve_check()

Jens Axboe (3):
      io_uring: fix early fdput() of file
      io_uring: never attempt iopoll reissue from release path
      io_uring: explicitly catch any illegal async queue attempt

Jia He (2):
      qed: fix possible unpaired spin_{un}lock_bh in _qed_mcp_cmd_and_union=
()
      Revert "qed: fix possible unpaired spin_{un}lock_bh in
_qed_mcp_cmd_and_union()"

Jian Shen (2):
      net: hns3: disable port VLAN filter when support function level
VLAN filter control
      net: hns3: fix rx VLAN offload state inconsistent issue

Jiapeng Chong (1):
      afs: Remove redundant assignment to ret

Jisheng Zhang (1):
      riscv: stacktrace: pin the task's stack in get_wchan

Joakim Zhang (3):
      dt-bindings: net: snps,dwmac: add missing DWMAC IP version
      dt-bindings: net: imx-dwmac: convert imx-dwmac bindings to yaml
      arm64: dts: imx8mp: change interrupt order per dt-binding

John Fastabend (2):
      bpf, sockmap: Fix potential memory leak on unlikely error case
      bpf, sockmap, tcp: sk_prot needs inuse_idx set for proc stats

John Keeping (1):
      USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee stick

Jonathan Marek (1):
      Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"

Jorgen Hansen (1):
      MAINTAINERS: Update for VMCI driver

Julian Sikorski (1):
      USB: usb-storage: Add LaCie Rugged USB3-FW to IGNORE_UAS

J=C3=A9r=C3=B4me Glisse (1):
      misc: eeprom: at24: Always append device id even if label property is=
 set.

Kai Vehmanen (1):
      ALSA: hda/hdmi: Add quirk to force pin connectivity on NUC10

Kalesh AP (1):
      bnxt_en: don't disable an already disabled PCI device

Keith Busch (1):
      nvme: fix nvme_setup_command metadata trace event

Kyle Russell (1):
      ASoC: tlv320aic31xx: fix reversed bclk/wclk master bits

Landen Chao (1):
      net: Update MAINTAINERS for MediaTek switch driver

Lijo Lazar (1):
      drm/amd/pm: Support board calibration on aldebaran

Likun Gao (1):
      drm/amdgpu: update golden setting for sienna_cichlid

Lino Sanfilippo (2):
      net: dsa: ensure linearized SKBs in case of tail taggers
      net: dsa: tag_ksz: dont let the hardware process the layer 4 checksum

Linus Torvalds (3):
      ACPI: fix NULL pointer dereference
      smpboot: fix duplicate and misplaced inlining directive
      Linux 5.14-rc3

Linyu Yuan (1):
      usb: dwc3: avoid NULL access of usb_gadget_driver

Liviu Dudau (1):
      drm/amd/display: Fix 10bit 4K display on CIK GPUs

Loic Poulain (1):
      bus: mhi: pci_generic: Fix inbound IPCR channel

Lucas Stach (1):
      ASoC: codecs: allow SSM2518 to be selected by the user

Luis Henriques (1):
      ceph: don't WARN if we're still opening a session to an MDS

Lukas Bulwahn (1):
      MAINTAINERS: repair reference in USB IP DRIVER FOR HISILICON KIRIN 97=
0

Mahesh Bandewar (1):
      bonding: fix build issue

Marc Zyngier (1):
      firmware/efi: Tell memblock about EFI iomem reservations

Marco De Marco (1):
      USB: serial: option: add support for u-blox LARA-R6 family

Marek Szyprowski (1):
      usb: dwc2: Skip clock gating on Samsung SoCs

Marek Vasut (3):
      spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
      ASoC: tlv320aic32x4: Fix TAS2505 volume controls
      spi: cadence: Correct initialisation of runtime PM again

Mark Brown (1):
      ASoC: tlv320aic31xx: Make regmap cache only on probe()

Mark Tomlinson (1):
      usb: max-3421: Prevent corruption of freed memory

Markus Boehme (1):
      ixgbe: Fix packet corruption due to missing DMA sync

Martin Kepplinger (1):
      usb: typec: tipd: Don't block probing of consumer of "connector" node=
s

Mason Zhang (1):
      spi: mediatek: move devm_spi_register_master position

Mathias Nyman (3):
      xhci: Fix lost USB 2 remote wake
      usb: hub: Fix link power management max exit latency (MEL) calculatio=
ns
      usb: hub: Disable USB 3 device initiated lpm if exit latency is too h=
igh

Maxim Kochetkov (1):
      fsl/fman: Add fibre support

Maxim Schwalm (1):
      ASoC: rt5631: Fix regcache sync errors on resume

Maxime Ripard (2):
      drm/vc4: hdmi: Drop devm interrupt handler for CEC interrupts
      drm/panel: raspberrypi-touchscreen: Prevent double-free

Michael Chan (5):
      bnxt_en: Refresh RoCE capabilities in bnxt_ulp_probe()
      bnxt_en: Add missing check for BNXT_STATE_ABORT_ERR in bnxt_fw_rset_t=
ask()
      bnxt_en: Validate vlan protocol ID on RX packets
      bnxt_en: Move bnxt_ptp_init() to bnxt_open()
      bnxt_en: Fix PTP capability discovery

Michal Suchanek (1):
      efi/tpm: Differentiate missing and invalid final event log table.

Mike Christie (1):
      scsi: iscsi: Fix iface sysfs attr detection

Mike Kravetz (1):
      hugetlbfs: fix mount mode command line processing

Mike Rapoport (2):
      memblock: make for_each_mem_range() traverse MEMBLOCK_HOTPLUG regions
      mm/secretmem: wire up ->set_page_dirty

Mikita Lipski (1):
      drm/amd/display: Remove MALL function from DCN3.1

Minas Harutyunyan (2):
      usb: dwc2: gadget: Fix GOUTNAK flow for Slave mode.
      usb: dwc2: gadget: Fix sending zero length packet in DDMA mode.

Moritz Fischer (1):
      Revert "usb: renesas-xhci: Fix handling of unknown ROM state"

Muchun Song (1):
      mm: mmap_lock: fix disabling preemption directly

Nevenko Stupar (1):
      drm/amd/display: Line Buffer changes

Nguyen Dinh Phi (1):
      netrom: Decrease sock refcount when sock timers expire

Nicholas Kazlauskas (3):
      drm/amd/display: Fix max vstartup calculation for modes with borders
      drm/amd/display: Query VCO frequency from register for DCN3.1
      drm/amd/display: Update bounding box for DCN3.1

Nicholas Piggin (5):
      KVM: PPC: Book3S HV P9: Fix guest TM support
      KVM: PPC: Book3S: Fix CONFIG_TRANSACTIONAL_MEM=3Dn crash
      KVM: PPC: Fix kvm_arch_vcpu_ioctl vcpu_load leak
      KVM: PPC: Book3S: Fix H_RTAS rets buffer overflow
      KVM: PPC: Book3S HV Nested: Sanitise H_ENTER_NESTED TM state

Nicolas Saenz Julienne (2):
      timers: Fix get_next_timer_interrupt() with no timers pending
      ftrace: Avoid synchronize_rcu_tasks_rude() call when not necessary

Oder Chiou (1):
      ASoC: rt5682: Fix the issue of garbled recording after powerd_dbus_su=
spend

Oleksandr Natalenko (1):
      block: increase BLKCG_MAX_POLS

Paolo Abeni (1):
      ipv6: fix another slab-out-of-bounds in fib6_nh_flush_exceptions

Paulo Alcantara (1):
      cifs: support share failover when remounting

Pavel Begunkov (2):
      io_uring: explicitly count entries for poll reqs
      io_uring: remove double poll entry on arm failure

Pavel Skripkin (2):
      net: sched: fix memory leak in tcindex_partial_destroy_work
      drm/ttm: add missing NULL checks

Peilin Ye (1):
      net/sched: act_skbmod: Skip non-Ethernet packets

Peng Li (1):
      net: hns3: add match_id to check mailbox response from PF to VF

Peter Collingbourne (2):
      userfaultfd: do not untag user pointers
      selftest: use mmap instead of posix_memalign to allocate memory

Peter Hess (1):
      spi: mediatek: fix fifo rx mode

Peter Robinson (1):
      ASoC: remove zte zx dangling kconfig

Peter Ujfalusi (3):
      ASoC: ti: j721e-evm: Fix unbalanced domain activity tracking
during startup
      ASoC: ti: j721e-evm: Check for not initialized parent_clk_id
      driver core: auxiliary bus: Fix memory leak when driver_register() fa=
il

Pierre-Louis Bossart (1):
      ALSA: hda: intel-dsp-cfg: add missing ElkhartLake PCI ID

Pravin B Shelar (1):
      net: Fix zero-copy head len calculation.

Qi Zheng (1):
      mm: fix the deadlock in finish_fault()

Qitao Xu (3):
      net: use %px to print skb address in trace_netif_receive_skb
      net_sched: use %px to print skb address in trace_qdisc_dequeue()
      net_sched: introduce tracepoint trace_qdisc_enqueue()

Rander Wang (1):
      ASoC: Intel: boards: fix xrun issue on platform with max98373

Randy Dunlap (2):
      net: hisilicon: rename CACHE_LINE_MASK to avoid redefinition
      net: sparx5: fix unmet dependencies warning

Rob Herring (1):
      ASoC: dt-bindings: renesas: rsnd: Fix incorrect 'port' regex schema

Robert Richter (1):
      ACPI: Kconfig: Fix table override from built-in initrd

Roman Gushchin (2):
      writeback, cgroup: remove wb from offline list before releasing refcn=
t
      writeback, cgroup: do not reparent dax inodes

Roman Skakun (1):
      dma-mapping: handle vmalloc addresses in dma_common_{mmap,get_sgtable=
}

Ronnie Sahlberg (2):
      cifs: only write 64kb at a time when fallocating a small region of a =
file
      cifs: fix fallocate when trying to allocate a hole.

Sathya Prakash M R (1):
      ASoC: SOF: Intel: Update ADL descriptor to use ACPI power states

Sayanta Pattanayak (1):
      r8169: Avoid duplicate sysfs entry creation error

Sergei Trofimovich (1):
      mm: page_alloc: fix page_poison=3D1 / INIT_ON_ALLOC_DEFAULT_ON intera=
ction

Shuo Liu (1):
      MAINTAINERS: Change ACRN HSM driver maintainer

Somnath Kotur (2):
      bnxt_en: fix error path of FW reset
      bnxt_en: Check abort error state in bnxt_half_open_nic()

Sreekanth Reddy (1):
      scsi: mpt3sas: Transition IOC to Ready state during shutdown

Srinivas Kandagatla (2):
      ASoC: codecs: wcd938x: make sdw dependency explicit in Kconfig
      ASoC: codecs: wcd938x: setup irq during component bind

Stephen Boyd (2):
      mmc: core: Use kref in place of struct mmc_blk_data::usage
      mmc: core: Don't allocate IDA for OF aliases

Steve French (2):
      CIFS: Clarify SMB1 code for POSIX Create
      CIFS: Clarify SMB1 code for POSIX delete file

Steven Rostedt (VMware) (4):
      tracing: Synthetic event field_pos is an index not a boolean
      tracing/histogram: Rename "cpu" to "common_cpu"
      tracing: Clean up alloc_synth_event()
      tracepoints: Update static_call before tp_funcs when adding a tracepo=
int

Stylon Wang (1):
      drm/amd/display: Fix ASSR regression on embedded panels

Subbaraya Sundeep (3):
      octeontx2-af: Enable transmit side LBK link
      octeontx2-af: Prepare for allocating MCAM rules for AF
      octeontx2-af: Introduce internal packet switching

Sukadev Bhattiprolu (1):
      ibmvnic: Remove the proper scrq flush

Sven Schnelle (1):
      s390/vdso32: add vdso32.lds to targets

Takashi Iwai (7):
      ALSA: usb-audio: Add missing proc text entry for BESPOKEN type
      r8152: Fix potential PM refcount imbalance
      r8152: Fix a deadlock by doubly PM resume
      ALSA: sb: Fix potential ABBA deadlock in CSP driver
      ALSA: hdmi: Expose all pins on MSI MS-7C94 board
      ALSA: pcm: Fix mmap capability check
      ALSA: pcm: Fix mmap without buffer preallocation

Tao Zhou (2):
      drm/amdgpu: update gc golden setting for dimgrey_cavefish
      drm/amd/pm: update DRIVER_IF_VERSION for beige_goby

Thierry Reding (1):
      ASoC: tegra: Use ADMAIF component for DMA allocations

Tobias Klauser (1):
      bpftool: Check malloc return value in mount_bpffs_for_pin

Tom Rix (1):
      afs: check function return

Ulf Hansson (1):
      regulator: fixed: Mark regulator-fixed-domain as deprecated

Vadim Fedorenko (2):
      udp: check encap socket in __udp_lib_err
      selftests: net: add ESP-in-UDP PMTU test

Vasily Averin (1):
      ipv6: ip6_finish_output2: set sk into newly allocated nskb

Vasily Gorbik (1):
      s390/ftrace: fix ftrace_update_ftrace_func implementation

Veerabadhran Gopalakrishnan (3):
      amdgpu/nv.c - Added video codec support for Yellow Carp
      amdgpu/nv.c - Optimize code for video codec support structure
      drm/amdgpu - Corrected the video codecs array name for yellow carp

Victor Lu (1):
      drm/amd/display: Fix comparison error in dcn21 DML

Vijendar Mukunda (2):
      ASoC: soc-pcm: add a flag to reverse the stop sequence
      ASoC: amd: reverse stop sequence for stoneyridge platform

Vincent Palatin (1):
      Revert "USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE mod=
em"

Vladimir Oltean (2):
      net: bridge: do not replay fdb entries pointing towards the bridge tw=
ice
      net: dsa: sja1105: make VID 4095 a bridge VLAN too

Wei Liu (1):
      Revert "x86/hyperv: fix logical processor creation"

Wei Wang (1):
      tcp: disable TFO blackhole logic by default

Wei Yongjun (1):
      usb: cdc-wdm: fix build error when CONFIG_WWAN_CORE is not set

Weizhao Ouyang (1):
      kfence: defer kfence_test_init to ensure that kunit debugfs is create=
d

Xiaojian Du (1):
      drm/amdgpu: update the golden setting for vangogh

Xin Long (3):
      sctp: trim optlen when it's a huge value in sctp_setsockopt
      sctp: update active_key for asoc when old key is being replaced
      sctp: do not update transport pathmtu if SPP_PMTUD_ENABLE is not set

Xuan Zhuo (2):
      bpf, test: fix NULL pointer dereference on invalid expected_attach_ty=
pe
      xdp, net: Fix use-after-free in bpf_xdp_link_release

Yajun Deng (2):
      net: decnet: Fix sleeping inside in af_decnet
      net: sched: cls_api: Fix the the wrong parameter

Yang Yingliang (1):
      io_uring: fix memleak in io_init_wq_offload()

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Fix superfluous irqs happen after usb_pkt_pop()

Yoshitaka Ikeda (3):
      spi: spi-cadence-quadspi: Fix division by zero warning
      spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
      spi: spi-cadence-quadspi: Fix division by zero warning

Zhang Qilong (1):
      usb: gadget: Fix Unbalanced pm_runtime_enable in tegra_xudc_probe

Zhihao Cheng (1):
      nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESET=
TING

Ziyang Xuan (1):
      net: fix uninit-value in caif_seqpkt_sendmsg

kernel test robot (1):
      s390/cpumf: fix semicolon.cocci warnings
