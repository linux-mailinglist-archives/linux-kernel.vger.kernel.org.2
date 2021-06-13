Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0F3A5ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhFMWf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:35:58 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39581 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhFMWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:35:57 -0400
Received: by mail-lf1-f41.google.com with SMTP id p17so17805328lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OreEwcdFz1nSF+i1envucqT2Umt96dR2wyzYgX7TN8I=;
        b=c88ZlmTAPutfRpQZpyqzq1IIG8PMqidfPcEz1WS9+HIOo9CTFyNeF95TyQjNTihDO2
         Aq63BrfrgtwKA1a9TCiyC/6w3g5DwTJEEz7LH0ZzlNJNbZ5QhoUNivv/LK3K4fIeU6wN
         KA982yImSn6W5jGz/mVNtyMPH6OBMi30gq6dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OreEwcdFz1nSF+i1envucqT2Umt96dR2wyzYgX7TN8I=;
        b=ZSHHlg4QF+l/e18YdgORDbIuHTAvUnWn3y1+aiI2Qo+TYqLfh5LyfYJioBE3K/AJxC
         31Mss8zJ44105rAFgfxHogj5goeRmR1lIuZrkXYpzH+OUYwLE+xV6Q5OdKpiYXDHaczE
         xfdB5JDpuaIDQkhwQwbhEfdhovBGJtrDetajG9F4nLTl6RRkS1eIiZjLxnP7pnaxF/SM
         TQxcQAyuA/rlWgZeq9JYLO1ups3i5x7cauSltURnszF/YgUowp5qlDEv3UBTh6X25yjI
         Ybhuz7lnBAFS/ysLOhsr+5SFa8rHUJlyFxlBC0zVfbtLu5h/xLwboRNuUCjp0DOg9aGE
         LEPQ==
X-Gm-Message-State: AOAM531yQj0TrfAGgdz+7PoAoG5DnjThVxV8CcywdgiTi98iZAXgdBI3
        bhACqVhHk93y/eKneoP9nln2B2yxr6WuyvhVo/c=
X-Google-Smtp-Source: ABdhPJytgJDPb4XMQetbU8iGkrSVnnrZR9gMZqdarofeKi3U3GxaARR8qRkC825BQY54pNcsFspbuA==
X-Received: by 2002:a19:480b:: with SMTP id v11mr10278742lfa.126.1623623559374;
        Sun, 13 Jun 2021 15:32:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p5sm1680431ljc.117.2021.06.13.15.32.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 15:32:39 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id d13so5324456ljg.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:32:39 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr11420555ljh.507.1623623558568;
 Sun, 13 Jun 2021 15:32:38 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 15:32:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9so00V0_ZVBP8oSZpowoWu5VKKTswGz=nuYTpWkkqQA@mail.gmail.com>
Message-ID: <CAHk-=wi9so00V0_ZVBP8oSZpowoWu5VKKTswGz=nuYTpWkkqQA@mail.gmail.com>
Subject: Linux 5.13-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing particularly special to say about this - rc6 is certainly
smaller than rc5 was, so we're moving in the right direction.

It's also not larger (or smaller) than usual for this stage, nor am I
aware of any particularly worrying reports, so I think we're all good.
The diffstat is nice and flat with a couple of small spikes for a few
specific drivers. It all looks very normal and non-threatening, in
other words.

Most of the diff by far is drivers (usb, gpu, regulator, rdma, spi,
pinctrl, scsi..), with just a few other areas: some x86 fixes (mainly
kvm), some RISC-V ones, tiny btrfs and nfs client fixes, a couple of
core kernel (scheduler, tracing) fixes.

It's all really pretty small.

Let's hope the trend continues, and we'll have a nice timely 5.13
release. But please do keep testing and verifying,

             Linus

---

Aharon Landau (1):
      RDMA/mlx5: Delete right entry from MR signature database

Alaa Hleihel (1):
      IB/mlx5: Fix initializing CQ fragments buffer

Alexander Kuznetsov (1):
      cgroup1: don't allow '\n' in renaming

Alexandre GRIVEAUX (2):
      USB: serial: omninet: add device id for Zyxel Omni 56K Plus
      USB: serial: omninet: update driver description

Alexandre Ghiti (1):
      riscv: Fix BUILTIN_DTB for sifive and microchip soc

Alexandru Elisei (1):
      Revert "usb: dwc3: core: Add shutdown callback for dwc3"

Alexey Minnekhanov (1):
      drm/msm: Init mm_list before accessing it for use_vram path

Andy Shevchenko (5):
      usb: typec: intel_pmc_mux: Put fwnode in error case during ->probe()
      usb: typec: intel_pmc_mux: Add missed error check for
devm_ioremap_resource()
      usb: typec: intel_pmc_mux: Put ACPI device using acpi_dev_put()
      serial: 8250_exar: Avoid NULL pointer dereference at ->exit()
      usb: typec: wcove: Use LE to CPU conversion when accessing msg->heade=
r

Anna Schumaker (1):
      NFS: Fix use-after-free in nfs4_init_client()

Arnaldo Carvalho de Melo (1):
      tools headers cpufeatures: Sync with the kernel sources

Arnd Bergmann (1):
      ARM: cpuidle: Avoid orphan section warning

Ashish Kalra (1):
      KVM: SVM: Fix SEV SEND_START session length & SEND_UPDATE_DATA
query length after commit 238eca821cee

Axel Lin (14):
      regulator: cros-ec: Fix error code in dev_err message
      regulator: da9121: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: fan53880: Fix missing n_voltages setting
      regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
      regulator: fixed: Ensure enable_counter is correct if
reg_domain_disable fails
      regulator: scmi: Fix off-by-one for linear regulators .n_voltages set=
ting
      regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting
      regulator: bd71828: Fix .n_voltages settings
      regulator: rtmv20: Fix .set_current_limit/.get_current_limit callback=
s
      regulator: rtmv20: Add Richtek to Kconfig text
      regulator: mt6315: Fix function prototype for mt6315_map_mode
      regulator: atc260x: Fix n_voltages and min_sel for pickable linear ra=
nges
      regulator: hi6421v600: Fix .vsel_mask setting
      regulator: rt4801: Fix NULL pointer dereference if
priv->enable_gpios is NULL

Bjorn Andersson (2):
      pinctrl: qcom: Make it possible to select SC8180x TLMM
      usb: typec: mux: Fix copy-paste mistake in typec_mux_match

Changfeng (1):
      drm/amdgpu: switch kzalloc to kvzalloc in amdgpu_bo_create

Chen Li (2):
      phy: usb: Fix misuse of IS_ENABLED
      radeon: use memcpy_to/fromio for UVD fw upload

ChiYuan Huang (1):
      regulator: rtmv20: Fix to make regcache value first reading back from=
 HW

Christian Borntraeger (1):
      KVM: selftests: introduce P47V64 for s390x

Christian K=C3=B6nig (1):
      drm/ttm: fix deref of bo->ttm without holding the lock v2

Christoph Hellwig (1):
      block: loop: fix deadlock between open and remove

Christophe JAILLET (1):
      usb: dwc3: meson-g12a: Disable the regulator in the error
handling path of the probe

Chuck Lever (1):
      NFS: FMODE_READ and friends are C macros, not enum types

CodyYao-oc (1):
      x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel =
CPUs

Colin Ian King (1):
      ASoC: topology: Fix spelling mistake "vesion" -> "version"

Coly Li (2):
      bcache: remove bcache device self-defined readahead
      bcache: avoid oversized read request in cache missing code path

Dai Ngo (1):
      NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on err=
or.

Dan Carpenter (1):
      NFS: Fix a potential NULL dereference in nfs_get_client()

Desmond Cheong Zhi Xi (2):
      drm: Fix use-after-free read in drm_getunique()
      drm: Lock pointer access in drm_master_release()

Dietmar Eggemann (2):
      sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
      debugfs: Fix debugfs_read_file_str()

Dmitry Baryshkov (1):
      regulator: core: resolve supply for boot-on/always-on regulators

Dmitry Osipenko (2):
      regulator: max77620: Use device_set_of_node_from_dev()
      regulator: max77620: Silence deferred probe error

Eric W. Biederman (1):
      coredump: Limit what can interrupt coredumps

Fabrizio Castro (1):
      media: dt-bindings: media: renesas,drif: Fix fck definition

Feng Tang (1):
      mm: relocate 'write_protect_seq' in struct mm_struct

Frederic Weisbecker (1):
      tick/nohz: Only check for RCU deferred wakeup on user/guest
entry when needed

Geert Uytterhoeven (1):
      mmc: renesas_sdhi: Fix HS400 on R-Car M3-W+

George McCollister (1):
      USB: serial: ftdi_sio: add NovaTech OrionMX product ID

Greg Kroah-Hartman (1):
      Revert "usb: gadget: fsl: Re-enable driver for ARM SoCs"

Gustavo A. R. Silva (1):
      drm/amd/pm: Fix fall-through warning for Clang

Hao Fang (1):
      regulator: hisilicon: use the correct HiSilicon copyright

Hui Wang (1):
      ALSA: hda/realtek: headphone and mic don't work on an Acer laptop

Jack Pham (2):
      usb: dwc3: gadget: Bail from dwc3_gadget_exit() if dwc->gadget is NUL=
L
      usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Jack Yu (1):
      ASoC: rt5659: Fix the lost powers for the HDA header

Jarvis Jiang (1):
      bus: mhi: pci_generic: T99W175: update channel name from AT to DUN

Jeremy Szu (4):
      ALSA: hda/realtek: fix mute/micmute LEDs and speaker for HP
Elite Dragonfly G2
      ALSA: hda/realtek: fix mute/micmute LEDs and speaker for HP
EliteBook x360 1040 G8
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook 840 Aero G8
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power G8

Jerome Brunet (1):
      ASoC: meson: gx-card: fix sound-dai dt schema

Jisheng Zhang (1):
      riscv: code patching only works on !XIP_KERNEL

Joel Stanley (1):
      usb: gadget: fsl: Re-enable driver for ARM SoCs

Johan Hovold (2):
      USB: serial: quatech2: fix control-request directions
      USB: serial: cp210x: fix CP2102N-A01 modem control

Jonathan Marek (3):
      drm/msm/a6xx: update/fix CP_PROTECT initialization
      drm/msm/a6xx: fix incorrectly set uavflagprd_inv field for A650
      drm/msm/a6xx: avoid shadow NULL reference in failure path

Josef Bacik (1):
      btrfs: do not write supers if we have an fs error

Kai Vehmanen (1):
      ASoC: SOF: reset enabled_cores state at suspend

Kamal Heib (1):
      RDMA/ipoib: Fix warning caused by destroying non-initial netns

Kan Liang (2):
      perf/x86/intel/uncore: Fix a kernel WARNING triggered by maxcpus=3D1
      perf/x86/intel/uncore: Fix M2M event umask for Ice Lake server

Kees Cook (1):
      proc: Track /proc/$pid/attr/ opener mm_struct

Kefeng Wang (1):
      ASoC: core: Fix Null-point-dereference in fmt_single_name()

Kyle Tso (8):
      usb: pd: Set PD_T_SINK_WAIT_CAP to 310ms
      dt-bindings: connector: Replace BIT macro with generic bit ops
      usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
      dt-bindings: connector: Add PD rev 2.0 VDO definition
      usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
      usb: typec: tcpm: Fix misuses of AMS invocation
      usb: typec: tcpm: Properly handle Alert and Status Messages
      usb: typec: tcpm: Do not finish VDM AMS for retrying Responses

Lai Jiangshan (3):
      KVM: X86: MMU: Use the correct inherited permissions to get shadow pa=
ge
      KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior
      KVM: x86: Unload MMU on guest TLB flush if TDP disabled to force MMU =
sync

Lars-Peter Clausen (1):
      staging: ralink-gdma: Remove incorrect author information

Leo Yan (1):
      perf session: Correct buffer copying when peeking events

Li Jun (3):
      usb: typec: tcpm: cancel vdm and state machine hrtimer when
unregister tcpm port
      usb: typec: tcpm: cancel frs hrtimer when unregister tcpm port
      usb: typec: tcpm: cancel send discover hrtimer when unregister tcpm p=
ort

Liangyan (1):
      tracing: Correct the length check which causes memory corruption

Linus Torvalds (1):
      Linux 5.13-rc6

Linus Walleij (1):
      drm/mcde: Fix off by 10^3 in calculation

Linyu Yuan (1):
      usb: gadget: eem: fix wrong eem header operation

Loic Poulain (1):
      bus: mhi: pci-generic: Fix hibernation

Lukas Wunner (2):
      spi: bcm2835: Fix out-of-bounds access with more than 4 slaves
      spi: Cleanup on failure of initial setup

Maciej =C5=BBenczykowski (4):
      USB: f_ncm: ncm_bitrate (speed) is unsigned
      usb: f_ncm: only first packet of aggregate needs to start timer
      usb: fix various gadgets null ptr deref on 10gbps cabling.
      usb: fix various gadget panics on 10gbps cabling

Manivannan Sadhasivam (1):
      pinctrl: qcom: Fix duplication in gpio_groups

Maor Gottlieb (1):
      RDMA: Verify port when creating flow rule

Marc Dionne (1):
      afs: Fix partial writeback of large files on fsync and close

Marco Elver (1):
      perf: Fix data race between pin_count increment/decrement

Marian-Cristian Rotariu (1):
      usb: dwc3: ep0: fix NULL pointer exception

Mario Limonciello (1):
      usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Ren=
oir

Mark Bloch (1):
      RDMA/mlx5: Block FDB rules when not in switchdev mode

Mark Pearson (2):
      ASoC: AMD Renoir - add DMI entry for Lenovo 2020 AMD platforms
      ASoC: AMD Renoir: Remove fix for DMI entry on Lenovo 2020 platforms

Mark Rutland (1):
      drm/vc4: fix vc4_atomic_commit_tail() logic

Mark Zhang (1):
      RDMA/mlx5: Use different doorbell memory for different processes

Masami Hiramatsu (1):
      tools/bootconfig: Fix a build error accroding to undefined fallthroug=
h

Matti Vaittinen (1):
      regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837

Maximilian Luz (4):
      platform/surface: aggregator_registry: Update comments for 15"
AMD Surface Laptop 4
      platform/surface: aggregator_registry: Add support for 13" Intel
Surface Laptop 4
      platform/surface: aggregator: Fix event disable function
      platform/surface: dtx: Add missing mutex_destroy() call in failure pa=
th

Mayank Rana (1):
      usb: typec: ucsi: Clear PPM capability data in ucsi_init() error path

Michel D=C3=A4nzer (1):
      drm/amdgpu: Use drm_dbg_kms for reporting failure to get a GEM FB

Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

Mika Westerberg (1):
      ACPI: Pass the same capabilities to the _OSC regardless of the query =
flag

Ming Lei (4):
      scsi: core: Fix error handling of scsi_host_alloc()
      scsi: core: Fix failure handling of scsi_add_host_with_dma()
      scsi: core: Put .shost_dev in failure path if host state changes
to RUNNING
      scsi: core: Only put parent device if host state differs from
SHOST_CREATED

Mykola Kostenok (1):
      platform/mellanox: mlxreg-hotplug: Revert "move to use
request_irq by IRQF_NO_AUTOEN flag"

Naohiro Aota (1):
      btrfs: zoned: fix zone number to sector/physical calculation

Nathan Chancellor (1):
      vmlinux.lds.h: Avoid orphan section with !SMP

Neil Armstrong (1):
      usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled

Nicolas Cavallari (1):
      ASoC: fsl-asoc-card: Set .owner attribute when registering card.

Nikolay Borisov (1):
      btrfs: promote debugging asserts to full-fledged checks in validate_s=
uper

Nobuhiro Iwamatsu (1):
      dt-bindings: hwmon: Fix typo in TI ADS7828 bindings

Oder Chiou (1):
      ASoC: rt5682: Fix the fast discharge for headset unplugging in
soundwire mode

Paolo Bonzini (2):
      kvm: avoid speculation-based attacks from out-of-range memslot access=
es
      kvm: fix previous commit for 32-bit builds

Patrice Chotard (1):
      spi: stm32-qspi: Always wait BUSY bit to be cleared in
stm32_qspi_wait_cmd()

Pavel Begunkov (2):
      io_uring: change registration/upd/rsrc tagging ABI
      io_uring: add feature flag for rsrc tags

Pawel Laszczak (1):
      usb: cdnsp: Fix deadlock issue in cdnsp_thread_irq_handler

Peter Geis (1):
      regulator: fan53555: fix TCS4525 voltage calulation

Peter Zijlstra (3):
      irq_work: Make irq_work_queue() NMI-safe again
      objtool: Fix .symtab_shndx handling for elf_create_undef_symbol()
      objtool: Only rewrite unconditional retpoline thunk calls

Richard Weinberger (1):
      ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values

Ricky Wu (1):
      misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG

Ritesh Harjani (1):
      btrfs: return value from btrfs_mark_extent_written() in case of error

Riwen Lu (1):
      hwmon: (scpi-hwmon) shows the negative temperature properly

Robert Marko (3):
      hwmon: (tps23861) define regmap max register
      hwmon: (tps23861) set current shunt value
      hwmon: (tps23861) correct shunt LSB values

Roger Pau Monne (1):
      xen-netback: take a reference to the RX task thread

Rohit Khaire (1):
      drm/amdgpu: Fix incorrect register offsets for Sienna Cichlid

Rui Miguel Silva (1):
      MAINTAINERS: usb: add entry for isp1760

Sanket Parmar (1):
      usb: cdns3: Enable TDL_CHK only for OUT ep

Saravana Kannan (1):
      drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device

Scott Mayhew (1):
      NFS: Ensure the NFS_CAP_SECURITY_LABEL capability is set when appropr=
iate

Sean Christopherson (1):
      KVM: x86: Ensure liveliness of nested VM-Enter fail tracepoint messag=
e

Sergio Paracuellos (2):
      phy: ralink: phy-mt7621-pci: drop 'of_match_ptr' to fix
-Wunused-const-variable
      pinctrl: ralink: rt2880: avoid to error in calls is pin is already en=
abled

Shay Drory (1):
      RDMA/mlx4: Do not map the core_clock page to user space unless enable=
d

Souptick Joarder (1):
      pinctrl: aspeed: Fix minor documentation error

Srinivas Kandagatla (1):
      gpio: wcd934x: Fix shift-out-of-bounds error

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-cpu: Fix pop noise during audio capture begin

Stefan Agner (1):
      USB: serial: cp210x: fix alternate function for CP2102N QFN20

Stephen Boyd (1):
      drm/msm/dsi: Stash away calculated vco frequency on recalc

Steven Rostedt (VMware) (1):
      ftrace: Do not blindly read the ip address in ftrace_bug()

Takashi Iwai (1):
      ALSA: seq: Fix race of snd_seq_timer_open()

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix the context to call snd_pcm_stop_xrun()

Thomas Petazzoni (1):
      usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling

Tiezhu Yang (1):
      phy: phy-mtk-tphy: Fix some resource leaks in mtk_phy_init()

Til Jasper Ullrich (1):
      platform/x86: thinkpad_acpi: Add X1 Carbon Gen 9 second fan support

Tor Vic (1):
      x86, lto: Pass -stack-alignment only on LLD < 13.0.0

Trond Myklebust (2):
      NFSv4: Fix deadlock between nfs4_evict_inode() and
nfs4_opendata_get_inode()
      NFSv4: Fix second deadlock in nfs4_evict_inode()

Vincent Guittot (3):
      sched/fair: Keep load_avg and load_sum synced
      sched/fair: Make sure to update tg contrib for blocked load
      sched/pelt: Ensure that *_sum is always synced with *_avg

Vitaly Wool (2):
      riscv: xip: support runtime trap patching
      riscv: alternative: fix typo in macro name

Wang Wensheng (1):
      phy: cadence: Sierra: Fix error return code in cdns_sierra_phy_probe(=
)

Wanpeng Li (1):
      KVM: LAPIC: Write 0 to TMICT should also cancel vmx-preemption timer

Wei Ming Chen (1):
      Compiler Attributes: Add continue in comment

Wei Yongjun (1):
      bus: mhi: pci_generic: Fix possible use-after-free in mhi_pci_remove(=
)

Wenli Looi (1):
      staging: rtl8723bs: Fix uninitialized variables

Wesley Cheng (2):
      usb: dwc3: gadget: Disable gadget IRQ during pullup disable
      usb: gadget: f_fs: Ensure io_completion_wq is idle during unbind

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix suspend behavior

Wolfram Sang (1):
      mmc: renesas_sdhi: abort tuning when timeout detected

Xiao Ni (1):
      async_xor: check src_offs is not NULL before updating it

Yang Li (1):
      phy: ti: Fix an error code in wiz_probe()

Yang Yingliang (2):
      phy: Sparx5 Eth SerDes: check return value after calling
platform_get_resource()
      usb: misc: brcmstb-usb-pinmap: check return value after calling
platform_get_resource()

Zhang Rui (1):
      Revert "ACPI: sleep: Put the FACS table after using it"

Zhen Lei (1):
      tools/bootconfig: Fix error return code in apply_xbc()

Zhenzhong Duan (1):
      selftests: kvm: Add support for customized slot0 memory size

zpershuai (1):
      spi: spi-zynq-qspi: Fix some wrong goto jumps & missing error code
