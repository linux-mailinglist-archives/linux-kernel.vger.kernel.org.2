Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601BC3ECBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 02:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhHPAJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 20:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhHPAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 20:08:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146AEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 17:08:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y7so24679919ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5X6mFMIXrh0Qg1w/Uw199hnZU6dcV3C8WBu1L7re1Ds=;
        b=KKdGSlqWEOlf+FYz7qfq5x9jGITnXRWGXGYh5rsRgYzgNE5Ql7WIkvYF2xTucoZ43R
         8PxO1MHiZJg3yzCnq+mBwFXYJBmHU8WjmrEXEA87DDCIKZw7nFngflNSzekueYkS/yn8
         hY/OxIsvYluIyIXYWXSd9vPiF33C0gA7Cu08M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5X6mFMIXrh0Qg1w/Uw199hnZU6dcV3C8WBu1L7re1Ds=;
        b=sAZ/ljkR2Hyz50DXwtY6+N/nZSgYAYriIYwu6SImo3JOfhrr8158pbk11s/UqXuW3F
         A+QJ9WWAeuTnxpJkqdr7DaI9Nxy8QUv20/+b0gGqGnkqzvAP9nx3kxsL17+y+kENIU8V
         PxABRzi/TVyFbjB05cWMz8wiAJjFOjfCJWdXKIFgYW/5mcLdK3hQP0V5GzSMTHi7JvLl
         idzTrwThNfX0NCat6pRwymIu/QUPtfAmEwLuFEvipFSJoS8iQ6O7tK/jpSQEJ/ZK3bhE
         9IaMHELoiVAaRJR76vcSS1wDPaVNtKW/9h1+jMd0j7FATDQKtHR9C4E3NU1QvUMAsRDs
         6Nqw==
X-Gm-Message-State: AOAM531Tu40di29daul5QDpvqjdFH6zkOGUr1IzIgYtZ/J6HSHkvSJlJ
        Y54qVk/Mnk4i5pb+1Itkgp4nouCZm1cCxVjL
X-Google-Smtp-Source: ABdhPJxM0X3bgP5PRomkF1QD1tiHPWhoxLLGCAc9qtyAkb5oVW8T0ZUPq/3YzRRMmjI3Jr6onl4V5Q==
X-Received: by 2002:a2e:a806:: with SMTP id l6mr10931580ljq.91.1629072496152;
        Sun, 15 Aug 2021 17:08:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u22sm444555lja.21.2021.08.15.17.08.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 17:08:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id t9so31089215lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 17:08:15 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr9502556lfn.41.1629072495153;
 Sun, 15 Aug 2021 17:08:15 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Aug 2021 14:07:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
Message-ID: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
Subject: Linux 5.14-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another fairly normal week. A little over half is driver fixes
(networking, sound, gpu, block are the bulk of it, but there's other
noise in there too), with the other half being the usual mix:
architecture, filesystems (ceph and cifs), core kernel and networking
and some documentation fixes.

Nothing particular stands out to me. Go test, we should be getting
pretty close to done with this release...

               Linus

---

Alex Deucher (2):
      drm/amdgpu: don't enable baco on boco platforms in runpm
      drm/amdgpu: handle VCN instances when harvesting (v2)

Alex Vesker (1):
      net/mlx5: DR, Add fail on error check on decap

Alexandre Ghiti (1):
      riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_V=
ALUE

Amir Goldstein (1):
      ovl: skip stale entries in merge dir cache iteration

Andre Przywara (1):
      pinctrl: sunxi: Don't underestimate number of functions

Andy Shevchenko (2):
      pinctrl: tigerlake: Fix GPIO mapping for newer version of software
      wwan: core: Avoid returning NULL from wwan_create_dev()

Anirudh Venkataramanan (2):
      ice: Prevent probing virtual functions
      ice: Stop processing VF messages during teardown

Ankit Nautiyal (1):
      drm/i915/display: Fix the 12 BPC bits for PIPE_MISC reg

Anson Jacob (1):
      drm/amd/display: use GFP_ATOMIC in amdgpu_dm_irq_schedule_work

Antti Ker=C3=A4nen (1):
      iio: adis: set GPIO reset pin direction

Ard Biesheuvel (4):
      efi/libstub: arm64: Force Image reallocation if BSS was not reserved
      efi/libstub: arm64: Relax 2M alignment again for relocatable kernels
      efi/libstub: arm64: Warn when efi_random_alloc() fails
      efi/libstub: arm64: Double check image alignment at entry

Arnd Bergmann (3):
      ASoC: codecs: wcd938x: fix wcd module dependency
      pinctrl: qcom: fix GPIOLIB dependencies
      iio: accel: fxls8962af: fix i2c dependency

Aya Levin (2):
      net/mlx5: Block switchdev mode while devlink traps are active
      net/mlx5: Fix return value from tracer initialization

Babu Moger (1):
      x86/resctrl: Fix default monitoring groups reporting

Bart Van Assche (1):
      configfs: restore the kernel v5.13 text attribute write behavior

Baruch Siach (1):
      MAINTAINERS: fix Microchip CAN BUS Analyzer Tool entry typo

Ben Dai (1):
      genirq/timings: Prevent potential array overflow in __irq_timings_sto=
re()

Ben Hutchings (8):
      net: phy: micrel: Fix link detection on ksz87xx switch"
      net: dsa: microchip: Fix ksz_read64()
      net: dsa: microchip: ksz8795: Fix PVID tag insertion
      net: dsa: microchip: ksz8795: Reject unsupported VLAN configuration
      net: dsa: microchip: ksz8795: Fix VLAN untagged flag change on deleti=
on
      net: dsa: microchip: ksz8795: Use software untagging on CPU port
      net: dsa: microchip: ksz8795: Fix VLAN filtering
      net: dsa: microchip: ksz8795: Don't use phy_port_cnt in VLAN table lo=
okup

Benjamin Herrenschmidt (1):
      arm64: efi: kaslr: Fix occasional random alloc (and boot) failure

Bixuan Cui (1):
      genirq/msi: Ensure deactivation on teardown

Brent Lu (1):
      ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard

Brett Creeley (1):
      ice: don't remove netdev->dev_addr from uc sync list

Changbin Du (1):
      riscv: kexec: do not add '-mno-relax' flag if compiler doesn't suppor=
t it

Chris Lesiak (1):
      iio: humidity: hdc100x: Add margin to the conversion time

Chris Mi (1):
      net/mlx5e: TC, Fix error handling memory leak

Christian Hewitt (1):
      drm/meson: fix colour distortion from HDR set during vendor u-boot

Christophe JAILLET (1):
      drm/amd/pm: Fix a memory leak in an error handling path in
'vangogh_tables_init()'

Christophe Leroy (5):
      powerpc/32s: Fix napping restore in data storage interrupt (DSI)
      powerpc/32: Fix critical and debug interrupts on BOOKE
      powerpc/smp: Fix OOPS in topology_init()
      powerpc/interrupt: Fix OOPS by not calling do_IRQ() from timer_interr=
upt()
      powerpc/interrupt: Do not call single_step_exception() from
other exceptions

Colin Ian King (4):
      xen/events: remove redundant initialization of variable irq
      iio: adc: Fix incorrect exit of for-loop
      arc: Fix spelling mistake and grammar in Kconfig
      scsi: mpt3sas: Fix incorrectly assigned error return and check

C=C3=A9dric Le Goater (1):
      powerpc/xive: Do not skip CPU-less nodes when creating the IPIs

DENG Qingfang (1):
      net: dsa: mt7530: add the missing RxUnicast MIB counter

Damien Le Moal (1):
      pinctrl: k210: Fix k210_fpioa_probe()

Dan Williams (3):
      ACPI: NFIT: Fix support for virtual SPA ranges
      libnvdimm/region: Fix label activation vs errors
      tools/testing/nvdimm: Fix missing 'fallthrough' warning

Daniel Borkmann (2):
      bpf: Add _kernel suffix to internal lockdown_bpf_read
      bpf: Add lockdown check for probe_write_user helper

Daniel Vetter (1):
      drm/doc/rfc: drop lmem uapi section

Daniel Xu (1):
      libbpf: Do not close un-owned FD 0 on errors

David Brazdil (1):
      KVM: arm64: Fix off-by-one in range_is_memory

David Hildenbrand (1):
      mm/madvise: report SIGBUS as -EFAULT for MADV_POPULATE_(READ|WRITE)

Derek Fang (1):
      ASoC: rt5682: Adjust headset volume button threshold

Dhananjay Phadke (1):
      i2c: iproc: fix race between client unreg and tasklet

Dongliang Mu (2):
      ieee802154: hwsim: fix GPF in hwsim_set_edge_lqi
      ieee802154: hwsim: fix GPF in hwsim_new_edge_nl

Eric Bernstein (1):
      drm/amd/display: Remove invalid assert for ODM + MPC case

Eric Dumazet (2):
      net: igmp: fix data-race in igmp_ifc_timer_expire()
      net: igmp: increase size of mr_ifc_count

Ewan D. Milne (1):
      scsi: lpfc: Move initialization of phba->poll_list earlier to avoid c=
rash

Florian Westphal (2):
      netfilter: conntrack: collect all entries in one cycle
      netfilter: conntrack: remove offload_pickup sysctl again

Frank Wunderlich (1):
      drm/mediatek: dpi: Fix NULL dereference in mtk_dpi_bridge_atomic_chec=
k

Greg Kroah-Hartman (2):
      Revert "usb: dwc3: gadget: Use list_replace_init() before
traversing lists"
      i2c: dev: zero out array used for i2c reads from userspace

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix min eth packet size for non-switch use-c=
ases

Guennadi Liakhovetski (1):
      ASoC: SOF: Intel: hda-ipc: fix reply size checking

Guenter Roeck (1):
      ARC: Fix CONFIG_STACKDEPOT

Guillaume Nault (1):
      bareudp: Fix invalid read beyond skb's linear data

Guvenc Gulce (1):
      net/smc: Correct smc link connection counter in case of smc client

Hangbin Liu (1):
      net: sched: act_mirred: Reset ct info when mirror/redirect skb

Hans de Goede (3):
      platform/x86: Add and use a dual_accel_detect() helper
      platform/x86: Make dual_accel_detect() KIOX010A + KIOX020A
detect more robust
      platform/x86: pcengines-apuv2: Add missing terminating entries
to gpio-lookup tables

Hao Xu (2):
      io-wq: fix bug of creating io-wokers unconditionally
      io-wq: fix IO_WORKER_F_FIXED issue in create_io_worker()

Hayes Wang (2):
      Revert "r8169: avoid link-up interrupt issue on RTL8106e if user
enables ASPM"
      r8169: change the L0/L1 entrance latencies for RTL8106e

Hoang Le (1):
      Revert "tipc: Return the correct errno code"

Hsin-Yi Wang (2):
      drm/mediatek: mtk-dpi: Set out_fmt from config if not the last bridge
      pinctrl: mediatek: Fix fallback behavior for bias_set_combo

Hsuan-Chi Kuo (1):
      seccomp: Fix setting loaded filter count during TSYNC

Hu Haowen (1):
      Documentation: i2c: add i2c-sysfs into index

Hussein Alasadi (1):
      can: m_can: m_can_set_bittiming(): fix setting M_CAN_DBTP register

Ira Weiny (3):
      fs/fuse: Remove unneeded kaddr parameter
      fs/dax: Clarify nr_pages to dax_direct_access()
      dax: Ensure errno is returned from dax_direct_access

Jeff Layton (1):
      ceph: take snap_empty_lock atomically with snaprealm refcount change

Jens Axboe (3):
      io_uring: rsrc ref lock needs to be IRQ safe
      io_uring: drop ctx->uring_lock before flushing work item
      tools/io_uring/io_uring-cp: sync with liburing example

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 650 G8 Notebo=
ok PC

Jinchao Wang (1):
      arc: Prefer unsigned int to bare use of unsigned

John Clements (1):
      drm/amdgpu: set RAS EEPROM address from VBIOS

John Hubbard (1):
      net: mvvp2: fix short frame size on s390

Jozsef Kadlecsik (1):
      netfilter: ipset: Limit the maximal range of consecutive
elements to add/delete

Junaid Shahid (1):
      kvm: vmx: Sync all matching EPTPs when injecting nested EPT fault

Karsten Graul (1):
      net/smc: fix wait on already cleared link

Kefeng Wang (1):
      once: Fix panic when module unload

Kenneth Feng (1):
      drm/amd/pm: bug fix for the runtime pm BACO

Kuan-Ying Lee (2):
      kasan, kmemleak: reset tags when scanning block
      kasan, slub: reset tag when printing address

Laurent Dufour (1):
      powerpc/pseries: Fix update of LPAR security flavor after LPM

Leon Romanovsky (1):
      net/mlx5: Don't skip subfunction cleanup in case of error in module i=
nit

Liang Wang (1):
      lib: use PFN_PHYS() in devmem_is_allowed()

Linus Torvalds (1):
      Linux 5.14-rc6

Loic Poulain (1):
      net: wwan: mhi_wwan_ctrl: Fix possible deadlock

Longpeng(Mike) (1):
      vsock/virtio: avoid potential deadlock when vsock device remove

Lucas Tanure (1):
      ASoC: wm_adsp: Let soc_cleanup_component_debugfs remove debugfs

Luis Henriques (1):
      ceph: reduce contention in ceph_check_delayed_caps()

Luke D Jones (1):
      ALSA: hda: Add quirk for ASUS Flow x13

Marek Vasut (1):
      ASoC: tlv320aic32x4: Fix TAS2505/TAS2521 processing block selection

Mario Limonciello (2):
      ASoC: amd: renoir: Run hibernation callbacks
      pinctrl: amd: Fix an issue with shutdown when system set to s0ix

Mark Brown (4):
      ASoC: tlv320aic31xx: Fix jack detection after suspend
      ASoC: component: Remove misplaced prefix handling in pin control func=
tions
      ASoC: nau8824: Fix open coded prefix handling
      net: mscc: Fix non-GPL export of regmap APIs

Matt Roper (1):
      drm/i915: Only access SFC_DONE when media domain is not fused off

Maxim Mikityanskiy (1):
      net/mlx5e: Destroy page pool after XDP SQ to fix use-after-free

Maxime Ripard (1):
      dt-bindings: iio: st: Remove wrong items length check

Maximilian Heyne (1):
      xen/events: Fix race in set_evtchn_to_irq

Md Fahad Iqbal Polash (1):
      iavf: Set RSS LUT and key in reset handle path

Michael Chan (3):
      bnxt_en: Update firmware interface to 1.10.2.52
      bnxt_en: Update firmware call to retrieve TX PTP timestamp
      bnxt_en: Use register window 6 instead of 5 to read the PHC

Michael Kelley (1):
      scsi: storvsc: Log TEST_UNIT_READY errors as warnings

Miklos Szeredi (3):
      ovl: fix deadlock in splice write
      ovl: fix uninitialized pointer read in ovl_lookup_real_one()
      ovl: prevent private clone if bind mount is not allowed

Ming Lei (1):
      blk-iocost: fix lockdep warning on blkcg->lock

Nadav Amit (2):
      io_uring: clear TIF_NOTIFY_SIGNAL when running task work
      io_uring: Use WRITE_ONCE() when writing to sq_flags

Nathan Chancellor (1):
      vmlinux.lds.h: Handle clang's module.{c,d}tor sections

Neal Cardwell (1):
      tcp_bbr: fix u32 wrap bug in round logic if bbr_init() called
after 2B packets

Nikolay Aleksandrov (1):
      net: bridge: fix flags interpretation for extern learn fdb entries

Oleksij Rempel (1):
      net: dsa: qca: ar9331: make proper initial port defaults

Pablo Neira Ayuso (5):
      netfilter: nfnetlink_hook: strip off module name from hookfn
      netfilter: nfnetlink_hook: missing chain family
      netfilter: nfnetlink_hook: use the sequence number of the request mes=
sage
      netfilter: nfnetlink_hook: Use same family as request message
      netfilter: nfnetlink_hook: translate inet ingress to netdev

Pali Roh=C3=A1r (2):
      ppp: Fix generating ifname when empty IFLA_IFNAME is specified
      ppp: Fix generating ppp unit id when ifname is not specified

Paolo Bonzini (1):
      KVM: x86: remove dead initialization

Pavel Begunkov (1):
      io_uring: fix ctx-exit io_rsrc_put_work() deadlock

Peter Ujfalusi (1):
      ASoC: topology: Select SND_DYNAMIC_MINORS

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: hda: enforce exclusion between HDaudio and SoundWir=
e
      ASoC: SOF: Intel: Kconfig: fix SoundWire dependencies

Pu Lehui (1):
      powerpc/kprobes: Fix kprobe Oops happens in booke

Randy Dunlap (5):
      libbpf, doc: Eliminate warnings in libbpf_naming_convention
      dccp: add do-while-0 stubs for dccp_pr_debug macros
      net: openvswitch: fix kernel-doc warnings in flow.c
      bpf, core: Fix kernel-doc notation
      x86/tools: Fix objdump version check again

Richard Fitzgerald (10):
      MAINTAINERS: Add sound devicetree bindings for Wolfson Micro devices
      ASoC: cs42l42: Correct definition of ADC Volume control
      ASoC: cs42l42: Don't allow SND_SOC_DAIFMT_LEFT_J
      ASoC: cs42l42: Fix bclk calculation for mono
      ASoC: cs42l42: Fix inversion of ADC Notch Switch control
      ASoC: cs42l42: Remove duplicate control for WNF filter frequency
      ASoC: cs42l42: PLL must be running when changing MCLK_SRC_SEL
      ASoC: cs42l42: Fix LRCLK frame start edge
      ASoC: cs42l42: Constrain sample rate to prevent illegal SCLK
      ASoC: cs42l42: Fix mono playback

Robin G=C3=B6gge (1):
      libbpf: Fix probe for BPF_PROG_TYPE_CGROUP_SOCKOPT

Rodrigo Campos (1):
      Documentation: seccomp: Fix typo in user notification

Rohith Surabattula (2):
      cifs: Handle race conditions during rename
      cifs: Call close synchronously during unlink/rename/lease break.

Roi Dayan (2):
      psample: Add a fwd declaration for skbuff
      net/mlx5e: Avoid creating tunnel headers for local route

Ronnie Sahlberg (1):
      cifs: use the correct max-length for dentry_path_raw()

Sean Christopherson (6):
      KVM: VMX: Use current VMCS to query WAITPKG support for MSR emulation
      KVM: x86: Allow guest to set EFER.NX=3D1 on non-PAE 32-bit kernels
      KVM: nVMX: Use vmx_need_pf_intercept() when deciding if L0 wants a #P=
F
      KVM: x86/mmu: Don't leak non-leaf SPTEs when zapping all SPTEs
      KVM: x86/mmu: Don't step down in the TDP iterator when zapping all SP=
TEs
      KVM: x86/mmu: Protect marking SPs unsync when using TDP MMU with spin=
lock

Sean Nyekjaer (1):
      iio: accel: fxls8962af: fix potential use of uninitialized symbol

Sergey Shtylyov (1):
      MAINTAINERS: switch to my OMP email for Renesas Ethernet drivers

Shakeel Butt (1):
      slub: fix kmalloc_pagealloc_invalid_free unit test

Shay Drory (4):
      net/mlx5: Fix order of functions in mlx5_irq_detach_nb()
      net/mlx5: Set all field of mlx5_irq before inserting it to the xarray
      net/mlx5: Destroy pool->mutex
      net/mlx5: Synchronize correct IRQ when destroying CQ

Shyam Prasad N (1):
      cifs: create sd context must be a multiple of 8

Solomon Chiu (1):
      drm/amdgpu: Add preferred mode in modeset when freesync video
mode's enabled.

Steven Price (1):
      KVM: arm64: Fix race when enabling KVM_ARM_CAP_MTE

Sven Schnelle (1):
      ucounts: add missing data type changes

Takashi Iwai (6):
      ASoC: intel: atom: Fix reference to PCM buffer address
      ASoC: xilinx: Fix reference to PCM buffer address
      ASoC: uniphier: Fix reference to PCM buffer address
      ASoC: kirkwood: Fix reference to PCM buffer address
      ASoC: amd: Fix reference to PCM buffer address
      ALSA: pcm: Fix mmap breakage without explicit buffer setup

Takeshi Misawa (1):
      net: Fix memory leak in ieee802154_raw_deliver

Tatsuhiko Yasumatsu (1):
      bpf: Fix integer overflow involving bucket_size

Tejun Heo (2):
      cgroup: rstat: fix A-A deadlock on 32bit around u64_stats_sync
      Revert "block/mq-deadline: Add cgroup support"

Thomas Gleixner (12):
      PCI/MSI: Enable and mask MSI-X early
      PCI/MSI: Mask all unused MSI-X entries
      PCI/MSI: Enforce that MSI-X table entry is masked for update
      PCI/MSI: Enforce MSI[X] entry updates to be visible
      PCI/MSI: Do not set invalid bits in MSI mask
      PCI/MSI: Correct misleading comments
      PCI/MSI: Use msi_mask_irq() in pci_msi_shutdown()
      PCI/MSI: Protect msi_desc::masked for multi-MSI
      genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
      x86/ioapic: Force affinity setup before startup
      x86/msi: Force affinity setup before startup
      driver core: Add missing kernel doc for device::msi_lock

Tianjia Zhang (1):
      selftests/sgx: Fix Q1 and Q2 calculation in sigstruct.c

Uwe Kleine-K=C3=B6nig (1):
      iio: adc: ti-ads7950: Ensure CS is deasserted after reading channels

Vijendar Mukunda (1):
      ASoC: amd: enable stop_dma_first flag for cz_dai_7219_98357 dai link

Vineet Gupta (2):
      ARC: fp: set FPU_STATUS.FWE to enable FPU_STATUS update on context sw=
itch
      MAINTAINERS: update Vineet's email address

Vinicius Costa Gomes (1):
      ptp: Fix possible memory leak caused by invalid cast

Vlad Buslov (1):
      net/mlx5: Bridge, fix ageing time

Vladimir Oltean (6):
      net: dsa: hellcreek: fix broken backpressure in .port_fdb_dump
      net: dsa: lan9303: fix broken backpressure in .port_fdb_dump
      net: dsa: lantiq: fix broken backpressure in .port_fdb_dump
      net: dsa: sja1105: fix broken backpressure in .port_fdb_dump
      net: switchdev: zero-initialize struct
switchdev_notifier_fdb_info emitted by drivers towards the bridge
      net: dsa: sja1105: unregister the MDIO buses during teardown

Vlastimil Babka (1):
      mm: slub: fix slub_debug disabling for list of slabs

Waiman Long (1):
      mm/memcg: fix incorrect flushing of lruvec data in obj_stock

Willy Tarreau (1):
      net: linkwatch: fix failure to restore device state across suspend/re=
sume

Wong Vee Khee (1):
      net: pcs: xpcs: fix error handling on failed to allocate memory

Xiaomeng Hou (1):
      drm/amd/pm: update smu v13.0.1 firmware header

Xie Yongji (1):
      nbd: Aovid double completion of a request

Yajun Deng (1):
      netfilter: nf_conntrack_bridge: Fix memory leak when error

Yang Yingliang (1):
      net: bridge: fix memleak in br_add_if()

Yonghong Song (2):
      bpf: Add missing bpf_read_[un]lock_trace() for syscall program
      bpf: Fix potentially incorrect results with bpf_get_local_storage()

Yu Kuai (1):
      blk-mq: clear active_queues before clearing BLK_MQ_F_TAG_QUEUE_SHARED

Yunsheng Lin (1):
      page_pool: mask the page->signature before the checking

Zhen Lei (1):
      locking/rtmutex: Use the correct rtmutex debugging config option

Zhenyu Wang (1):
      drm/i915/gvt: Fix cached atomics setting for Windows VM

jason-jh.lin (1):
      drm/mediatek: Fix cursor plane no update
