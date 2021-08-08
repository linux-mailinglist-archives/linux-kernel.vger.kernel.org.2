Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645F13E3CD5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 23:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHHVBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhHHVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 17:01:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51AC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 14:00:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d4so752705lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JEHCGTFzSe8ITzEQqBw0jvrVBYRLrOjm4l/Ge7I5njY=;
        b=Iiq4svfe1qYOaB+JRkwHzrPpAslaQi6oGZPApU2EkelwmC9UI/vK0bY+EZm4ch1Y/a
         pFIHzmqV3jCutPh3WkBM2byJxQ0iknwyLyyk3Edr8K6VwmRksf1jolFOmVlwWH36d/uH
         Tpkx6ijZejJsigLsGNdNe1IgIbOInFGgnOVkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JEHCGTFzSe8ITzEQqBw0jvrVBYRLrOjm4l/Ge7I5njY=;
        b=E3ZvcMzP1x0nF0BIcYC+Ng96bGZqoxCKAACl+aIXGq43VGpfoOGBTRb3voUG/xZ4eU
         sUV16z7olQrwn8pqaF7ZVttFbJEIGPz1xI1o6vmBewAywYes+V9oMlrwhgqDzrb6sXyv
         Xno2/NVKkTihb6g76F++VQdT4uqQdzZOrNIJZEBmCijhIOnsXEiH1r2yXUFzYBkrpn0X
         wH8EutqTtsEfVtUk9pLVGSov4Uj9gtXwk0XjGTJjM/opHZESVc/ziNbvbnaHhriFuXFp
         /P2TY9cCYgHR+3lBq8gEMncO1NTbJAH3ULhUvBBsUkCz1IiIr32IubQHf/nPhq/slqC2
         wnVA==
X-Gm-Message-State: AOAM530BZcqh6sqh2rmhSKSZgwGxR3Da6x+Fi8/rqylmKkNjHNijsbRj
        f/11z8RF8v0ZWxid/yHv8om3IrLKGpeEzWjI
X-Google-Smtp-Source: ABdhPJxPT4u8vyPZZ9h8Z0TB6tiod6odqQINm3SaEJX636O0rlP1wiEY32sWrS83a+Q4NlhBRd0CXw==
X-Received: by 2002:a19:7406:: with SMTP id v6mr11728831lfe.466.1628456453078;
        Sun, 08 Aug 2021 14:00:53 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b12sm1379785lfq.193.2021.08.08.14.00.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 14:00:52 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id g13so29630599lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 14:00:52 -0700 (PDT)
X-Received: by 2002:ac2:4c55:: with SMTP id o21mr7262012lfk.201.1628456452370;
 Sun, 08 Aug 2021 14:00:52 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Aug 2021 14:00:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8QmMMBCEYCV0gPM2GqRQObsQ__fK0r8C6SYAg3Upyjg@mail.gmail.com>
Message-ID: <CAHk-=wg8QmMMBCEYCV0gPM2GqRQObsQ__fK0r8C6SYAg3Upyjg@mail.gmail.com>
Subject: Linux 5.14-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things are looking perfectly normal. Size is nominal, diffstat looks
pretty normal, and the changes are all in the usual places, with just
under 60% being drivers, and the rest the usual mix of architecture
updates, core kernel, networking, and some selftests.

The shortlog is appended for people who want to scan the details, but
I can't think of anything in here that looks odd or noteworthy.

Which is just how it should be by rc5.  Let's hope the trend continues,

             Linus

---

Adrian Larumbe (1):
      dmaengine: xilinx_dma: Fix read-after-free bug when terminating trans=
fers

Aharon Landau (1):
      RDMA/mlx5: Delay emptying a cache entry when a new MR is added
to it recently

Alex Xu (Hello71) (1):
      pipe: increase minimum default pipe size to 2 pages

Alexander Monakov (1):
      ALSA: hda/realtek: add mic quirk for Acer SF314-42

Alexander Tsoy (1):
      ALSA: usb-audio: Add registration quirk for JBL Quantum 600

Alexandre Ghiti (2):
      riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical
address conversion
      Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED"

Alexey Gladkov (1):
      ucounts: Fix race condition between alloc_ucounts and put_ucounts

Allen Pais (2):
      optee: fix tee out of memory failure seen during kexec reboot
      firmware: tee_bnxt: Release TEE shm, session, and context during kexe=
c

Andreas Schwab (1):
      spi: update modalias_show after of_device_uevent_modalias support

Andy Shevchenko (2):
      serial: max310x: Unprepare and disable clock in error path
      serial: 8250_pci: Enumerate Elkhart Lake UARTs via dedicated driver

Anirudh Rayabharam (2):
      firmware_loader: use -ETIMEDOUT instead of -EAGAIN in
fw_load_sysfs_fallback
      firmware_loader: fix use-after-free in firmware_fallback_sysfs

Antoine Tenart (1):
      net: ipv6: fix returned variable type in ip6_skb_dst_mtu

Apurva Nandan (1):
      spi: cadence-quadspi: Fix check condition for DTR ops

Arnd Bergmann (6):
      staging: rtl8723bs: select CONFIG_CRYPTO_LIB_ARC4
      ARM: ixp4xx: fix compile-testing soc drivers
      ARM: ixp4xx: goramo_mlr depends on old PCI driver
      soc: ixp4xx: fix printing resources
      soc: ixp4xx/qmgr: fix invalid __iomem access
      net: sparx5: fix bitmask on 32-bit targets

Barry Song (1):
      arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL

Bart Van Assche (1):
      block/partitions/ldm.c: Fix a kernel-doc warning

Bijie Xu (2):
      net: flow_offload: correct comments mismatch with code
      net: sched: provide missing kdoc for tcf_pkt_info and tcf_ematch_ops

Bing Guo (2):
      drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
      drm/amd/display: Increase stutter watermark for dcn303

Bob Pearson (2):
      RDMA/rxe: Use the correct size of wqe when processing SRQ
      RDMA/rxe: Restore setting tot_len in the IPv4 header

Brian Norris (1):
      clk: fix leak on devm_clk_bulk_get_all() unwind

Chengming Gui (1):
      drm/amdgpu: add DID for beige goby

Christoph Hellwig (1):
      n64cart: fix the dma address in n64cart_do_bvec

Christophe JAILLET (1):
      usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro

Claudiu Beznea (1):
      usb: host: ohci-at91: suspend/resume ports after/before OHCI accesses

Colin Ian King (2):
      ARM: imx: fix missing 3rd argument in macro imx_mmdc_perf_init
      interconnect: Fix undersized devress_alloc allocation

Dakshaja Uppalapati (1):
      RDMA/iw_cxgb4: Fix refcount underflow while destroying cqs.

Dan Carpenter (1):
      bnx2x: fix an error code in bnx2x_nic_load()

Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

Dario Binacchi (2):
      clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
      ARM: dts: am437x-l4: fix typo in can@0 node

Dave Gerlach (1):
      ARM: dts: am43x-epos-evm: Reduce i2c0 bus speed for tps65218

Dave Jiang (5):
      dmaengine: idxd: fix array index when int_handles are being used
      dmaengine: idxd: fix setup sequence for MSIXPERM table
      dmaengine: idxd: fix desc->vector that isn't being updated
      dmaengine: idxd: fix sequence for pci driver remove() and shutdown()
      dmaengine: idxd: fix submission race window

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

David S. Miller (2):
      mhi: Fix networking tree build.
      net: really fix the build...

Dmitry Osipenko (3):
      usb: otg-fsm: Fix hrtimer list corruption
      clk: tegra: Implement disable_unused() of tegra_clk_sdmmc_mux_ops
      soc/tegra: Make regulator couplers depend on CONFIG_REGULATOR

Dmitry Safonov (2):
      net/xfrm/compat: Copy xfrm_spdattr_type_t atributes
      selftests/net/ipsec: Add test for xfrm_spdattr_type_t

Dongliang Mu (1):
      spi: meson-spicc: fix memory leak in meson_spicc_remove

Edmund Dea (2):
      drm/kmb: Enable LCD DMA for low TVDDCV
      drm/kmb: Define driver date and major/minor version

Eugen Hristev (1):
      media: atmel: fix build when ISC=3Dm and XISC=3Dy

Fabio Estevam (1):
      ARM: imx: common: Move prototype outside the SMP block

Fei Qin (1):
      nfp: update ethtool reporting of pauseframe control

Filip Schauer (1):
      drivers core: Fix oops when driver probe fails

Frederic Weisbecker (1):
      xfrm: Fix RCU vs hash_resize_mutex lock inversion

Geliang Tang (1):
      mptcp: drop unused rcu member in mptcp_pm_addr_entry

Geoffrey D. Bennett (4):
      ALSA: scarlett2: Fix Mute/Dim/MSD Mode control names
      ALSA: scarlett2: Fix Direct Monitor control name for 2i2
      ALSA: scarlett2: Correct channel mute status after mute button presse=
d
      ALSA: scarlett2: Fix line out/speaker switching notifications

Grygorii Strashko (1):
      net: ethernet: ti: am65-cpsw: fix crash in
am65_cpsw_port_offload_fwd_mark_update()

Guenter Roeck (2):
      spi: mediatek: Fix fifo transfer
      riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is en=
abled

Guoqing Jiang (1):
      ext4: remove conflicting comment from __ext4_forget

H. Nikolaus Schaller (3):
      omap5-board-common: remove not physically existing vdds_1v8_main
fixed-regulator
      x86/tools/relocs: Fix non-POSIX regexp
      mips: Fix non-POSIX regexp

Hans Verkuil (1):
      media: videobuf2-core: dequeue if start_streaming fails

Hao Xu (2):
      io-wq: fix no lock protection of acct->nr_worker
      io-wq: fix lack of acct->nr_workers < acct->max_workers judgement

Harshavardhan Unnibhavi (1):
      VSOCK: handle VIRTIO_VSOCK_OP_CREDIT_REQUEST

Harshvardhan Jha (2):
      net: xfrm: Fix end of loop tests for list_for_each_entry
      scsi: megaraid_mm: Fix end of loop tests for list_for_each_entry()

Heiko Carstens (1):
      s390: update defconfigs

Huang Pei (1):
      MIPS: check return value of pgtable_pmd_page_ctor

Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Igor Pylypiv (1):
      scsi: pm80xx: Fix TMF task completion race condition

Ivan T. Ivanov (1):
      net: usb: lan78xx: don't modify phy_device state concurrently

Jakub Kicinski (5):
      net: sparx5: fix compiletime_assert for GCC 4.9
      docs: operstates: fix typo
      docs: operstates: document IF_OPER_TESTING
      Revert "mhi: Fix networking tree build."
      docs: networking: netdevsim rules

Jakub Sitnicki (1):
      net, gro: Set inner transport header offset in tcp/udp GRO hook

Jaroslav Kysela (1):
      ALSA: pcm - fix mmap capability check for the snd-dummy driver

Jason Ekstrand (1):
      drm/i915: Call i915_globals_exit() if pci_register_device() fails

Jens Axboe (1):
      io-wq: fix race between worker exiting and activating free worker

Jens Wiklander (1):
      tee: add tee_shm_alloc_kernel_buf()

Jisheng Zhang (1):
      riscv: stacktrace: Fix NULL pointer dereference

Johan Hovold (5):
      serial: 8250: fix handle_irq locking
      media: Revert "media: rtl28xxu: fix zero-length control request"
      media: rtl28xxu: fix zero-length control request
      USB: serial: pl2303: fix HX type detection
      USB: serial: pl2303: fix GT type detection

Jon Hunter (1):
      serial: tegra: Only print FIFO error message when an error occurs

Jude Shih (1):
      drm/amd/display: Fix resetting DCN3.1 HW when resuming from S4

Juergen Borleis (1):
      dmaengine: imx-dma: configure the generic DMA type to make it work

Kajol Jain (1):
      fpga: dfl: fme: Fix cpu hotplug issue in performance reporting

Kamal Agrawal (1):
      tracing: Fix NULL pointer dereference in start_creating

Kan Liang (1):
      perf/x86/intel: Apply mid ACK for small core

Kevin Hilman (1):
      bus: ti-sysc: AM3: RNG is GP only

Kunihiko Hayashi (1):
      dmaengine: uniphier-xdmac: Use readl_poll_timeout_atomic() in atomic =
state

Kyle Tso (1):
      usb: typec: tcpm: Keep other events when receiving FRS and
Sourcing_vbus events

Leon Romanovsky (1):
      net/prestera: Fix devlink groups leakage in error flow

Li Manyi (1):
      scsi: sr: Return correct event when media event code is 3

Like Xu (1):
      perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the =
guest

Linus Torvalds (1):
      Linux 5.14-rc5

Lucas Stach (1):
      Revert "soc: imx8m: change to use platform driver"

M Chetan Kumar (4):
      net: wwan: iosm: fix lkp buildbot warning
      net: wwan: iosm: endianness type correction
      net: wwan: iosm: correct data protocol mask bit
      net: wwan: iosm: fix recursive lock acquire in unregister

Maciej W. Rozycki (2):
      serial: 8250: Mask out floating 16/32-bit bus bits
      MIPS: Malta: Do not byte-swap accesses to the CBUS UART

Marco Elver (2):
      perf: Fix required permissions if sigtrap is requested
      perf: Refactor permissions check into perf_check_permission()

Marek Vasut (6):
      ARM: dts: imx: Swap M53Menlo pinctrl_power_button/pinctrl_power_out p=
ins
      spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
      spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
      ARM: dts: stm32: Prefer HW RTC on DHCOM SoM
      ARM: dts: stm32: Disable LAN8710 EDPD on DHCOM
      ARM: dts: stm32: Fix touchscreen IRQ line assignment on DHCOM

Mario Kleiner (1):
      serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.

Mark Rutland (3):
      arm64: fix compat syscall return truncation
      arm64: stacktrace: fix comment
      arm64: stacktrace: avoid tracing arch_stack_walk()

Masahiro Yamada (2):
      arm64: move warning about toolchains to archprepare
      kbuild: cancel sub_make_done for the install target to fix DKMS

Masami Hiramatsu (1):
      tracing: Reject string operand in the histogram expression

Mathieu Desnoyers (3):
      tracepoint: static call: Compare data on transition from 2->1 callees
      tracepoint: Fix static call function vs data state mismatch
      tracepoint: Use rcu get state and cond sync for static call updates

Matt Roper (1):
      drm/i915: Correct SFC_DONE register offset

Matthias Schiffer (1):
      gpio: tqmx86: really make IRQ optional

Maxim Devaev (2):
      usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers
      usb: gadget: f_hid: idle uses the highest byte for duration

Maxim Levitsky (1):
      KVM: selftests: fix hyperv_clock test

Maxime Chevallier (1):
      ARM: dts: imx6qdl-sr-som: Increase the PHY reset duration to 10ms

Michael Walle (1):
      arm64: dts: ls1028: sl28: fix networking for variant 2

Mika Westerberg (1):
      Revert "thunderbolt: Hide authorized attribute if router does
not support PCIe tunnels"

Mike Marciniszyn (1):
      RDMA/cma: Revert INIT-INIT patch

Mike Tipton (4):
      interconnect: Zero initial BW after sync-state
      interconnect: Always call pre_aggregate before aggregate
      interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nod=
es
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregat=
e

Mingwei Zhang (1):
      KVM: SVM: improve the code readability for ASID management

Nathan Chancellor (1):
      scripts/recordmcount.pl: Remove check_objcopy() and $can_use_local

Nikos Liolios (1):
      ALSA: hda/realtek: Fix headset mic for Acer SWIFT SF314-56 (ALC256)

Oleksandr Suvorov (1):
      ARM: dts: colibri-imx6ull: limit SDIO clock to 25MHz

Oleksij Rempel (1):
      net: dsa: qca: ar9331: reorder MDIO write sequence

Pali Roh=C3=A1r (1):
      arm64: dts: armada-3720-turris-mox: remove mrvl,i2c-fast-mode

Paolo Bonzini (2):
      KVM: x86: accept userspace interrupt only if no event is injected
      KVM: Do not leak memory for duplicate debugfs directories

Pavel Skripkin (6):
      net: xfrm: fix memory leak in xfrm_user_rcv_msg
      staging: rtl8712: get rid of flush_scheduled_work
      staging: rtl8712: error handling refactoring
      net: pegasus: fix uninit-value in get_interrupt_interval
      net: fec: fix use-after-free in fec_drv_remove
      net: vxge: fix use-after-free in vxge_device_unregister

Pawel Laszczak (3):
      usb: cdns3: Fixed incorrect gadget state
      usb: cdnsp: Fix incorrect supported maximum speed
      usb: cdnsp: Fixed issue with ZLP

Peter Ujfalusi (1):
      dmaengine: of-dma: router_xlate to return -EPROBE_DEFER if
controller is not yet available

Peter Zijlstra (2):
      sched/rt: Fix double enqueue caused by rt_effective_prio
      perf/x86: Fix out of bound MSR access

Petko Manolov (2):
      net: usb: pegasus: Check the return value of get_geristers() and frie=
nds;
      net: usb: pegasus: Remove the changelog and DRIVER_VERSION.

Phil Elwell (1):
      usb: gadget: f_hid: fixed NULL pointer dereference

Prabhakar Kushwaha (1):
      qede: fix crash in rmmod qede while automatic debug collection

Qiang.zhang (1):
      USB: usbtmc: Fix RCU stall warning

Qingqing Zhuo (1):
      drm/amd/display: workaround for hard hang on HPD on native DP

Qiu Wenbo (1):
      riscv: dts: fix memory size for the SiFive HiFive Unmatched

Rafael J. Wysocki (3):
      cpuidle: teo: Fix alternative idle state lookup
      cpuidle: teo: Rename two local variables in teo_select()
      Revert "ACPICA: Fix memory leak caused by _CID repair function"

Randy Dunlap (4):
      clk: hisilicon: hi3559a: select RESET_HISI
      drm/i915: fix i915_globals_exit() section mismatch error
      scripts: checkversion: modernize linux/version.h search strings
      drm/amdgpu: fix checking pmops when PM_SLEEP is not enabled

Rasmus Villemoes (1):
      Revert "gpio: mpc8xxx: change the gpio interrupt flags."

Sean Christopherson (2):
      KVM: SVM: Fix off-by-one indexing when nullifying last used SEV VMCB
      KVM: x86/mmu: Fix per-cpu counter corruption on 32-bit builds

Sergio Paracuellos (1):
      staging: mt7621-pci: avoid to re-disable clock for those pcies not in=
 use

Shawn Guo (1):
      clk: qcom: smd-rpm: Fix MSM8936 RPM_SMD_PCNOC_A_CLK

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix the wrong return value in lpuart32_get_m=
ctrl

Shirish S (1):
      drm/amdgpu/display: fix DMUB firmware version info

Shuo Liu (1):
      virt: acrn: Do hcall_destroy_vm() before resource release

Sreekanth Reddy (1):
      scsi: core: Avoid printing an error if target_alloc() returns -ENXIO

Stefan Haberland (1):
      s390/dasd: fix use after free in dasd path handling

Steffen Klassert (1):
      Revert "xfrm: policy: Read seqcount outside of rcu-read side in
xfrm_policy_lookup_bytype"

Steve Bennett (1):
      net: phy: micrel: Fix detection of ksz87xx switch

Steven Rostedt (VMware) (2):
      tracing / histogram: Give calculation hist_fields a size
      tracing: Quiet smp_processor_id() use in preemptable warning in hwlat

Sudeep Holla (1):
      ARM: dts: nomadik: Fix up interrupt controller node names

Sumanth Korikkar (1):
      s390/vdso: add .got.plt in vdso linker script

Sumit Garg (1):
      tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Takashi Iwai (4):
      ALSA: usb-audio: Fix superfluous autosuspend recovery
      ALSA: usb-audio: Avoid unnecessary or invalid connector
selection at resume
      ALSA: memalloc: Fix regression with SNDRV_DMA_TYPE_CONTINUOUS
      ALSA: seq: Fix racy deletion of subscriber

Tero Kristo (1):
      ARM: omap2+: hwmod: fix potential NULL pointer access

Tetsuo Handa (1):
      Bluetooth: defer cleanup of resources in hci_unregister_dev()

Theodore Ts'o (1):
      ext4: fix potential htree corruption when growing large_dir directori=
es

Thomas Gleixner (1):
      timers: Move clearing of base::timer_running under base:: Lock

Tony Lindgren (2):
      bus: ti-sysc: Fix gpt12 system timer issue with reserved status
      usb: musb: Fix suspend and resume issues for PHYs on I2C and SPI

Tyler Hicks (4):
      optee: Fix memory leak when failing to register shm pages
      optee: Refuse to load the driver under the kdump kernel
      optee: Clear stale cache entries during initialization
      tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

Tyrel Datwyler (1):
      scsi: ibmvfc: Fix command state accounting and stale response detecti=
on

Uwe Kleine-K=C3=B6nig (1):
      spi: spi-mux: Add module info needed for autoloading

Vasily Gorbik (1):
      s390/boot: fix zstd build for -march=3Dz900

Vidya Sagar (1):
      arm64: tegra: Enable SMMU support for PCIe on Tegra194

Vincent Fu (1):
      kyber: make trace_block_rq call consistent with documentation

Vitaly Kuznetsov (4):
      KVM: x86: hyper-v: Check access to hypercall before reading XMM regis=
ters
      KVM: x86: Introduce trace_kvm_hv_hypercall_done()
      KVM: x86: hyper-v: Check if guest is allowed to use XMM
registers for hypercall input
      KVM: selftests: Test access to XMM fast hypercalls

Vladimir Oltean (9):
      arm64: dts: ls1028a: fix node name for the sysclk
      arm64: dts: armada-3720-turris-mox: fixed indices for the SDHC contro=
llers
      net: dsa: sja1105: fix static FDB writes for SJA1110
      net: dsa: sja1105: overwrite dynamic FDB entries with static
ones in .port_fdb_add
      net: dsa: sja1105: invalidate dynamic FDB entries learned
concurrently with statically added ones
      net: dsa: sja1105: ignore the FDB entry for unknown multicast
when adding a new address
      net: dsa: sja1105: be stateless with FDB entries on
SJA1105P/Q/R/S/SJA1110 too
      net: dsa: sja1105: match FDB entries regardless of inner/outer VLAN t=
ag
      net: bridge: validate the NUD_PERMANENT bit when adding an
extern_learn FDB entry

Wang Hai (1):
      net: natsemi: Fix missing pci_disable_device() in probe and remove

Wei Shuyu (1):
      md/raid10: properly indicate failure when ending a failed write reque=
st

Wesley Chalmers (1):
      drm/amd/display: Assume LTTPR interop for DCN31+

Wesley Cheng (2):
      usb: dwc3: gadget: Use list_replace_init() before traversing lists
      usb: dwc3: gadget: Avoid runtime resume if disabling pullup

Willy Tarreau (1):
      USB: serial: ch341: fix character loss at high transfer rates

Xiangyang Zhang (1):
      staging: rtl8723bs: Fix a resource leak in sd_int_dpc

Xiaomeng Hou (1):
      drm/amd/pm: update yellow carp pmfw interface version

Xin Long (1):
      sctp: move the active_key update after sh_keys is added

Xiu Jianfeng (1):
      selinux: correct the return value when loads initial sids

Yang Yingliang (2):
      ARM: imx: add missing iounmap()
      ARM: imx: add missing clk_disable_unprepare()

Yangyang Li (1):
      RDMA/hns: Fix the double unlock problem of poll_sem

Yannick Vignon (1):
      net/sched: taprio: Fix init procedure

Ye Bin (2):
      ext4: fix potential uninitialized access to retval in kmmpd
      scsi: scsi_dh_rdac: Avoid crash during rdac_bus_attach()

Yifan Zhang (1):
      drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.

Yu Kuai (2):
      dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()
      blk-iolatency: error out if blk_get_queue() failed in
iolatency_set_limit()

Yunsheng Lin (1):
      net: sched: fix lockdep_set_class() typo error for sch->seqlock

Zack Rusin (1):
      drm/vmwgfx: Fix a 64bit regression on svga3

Zhang Qilong (3):
      usb: gadget: remove leaked entry from udc driver list
      dmaengine: stm32-dma: Fix PM usage counter imbalance in stm32 dma ops
      dmaengine: stm32-dmamux: Fix PM usage counter unbalance in stm32
dmamux ops

Zheyu Ma (1):
      pcmcia: i82092: fix a null pointer dereference bug

Zhiyong Tao (1):
      serial: 8250_mtk: fix uart corruption issue when rx power off

chihhao.chen (1):
      ALSA: usb-audio: fix incorrect clock source setting

lijinlin (1):
      scsi: core: Fix capacity set to zero after offlinining device

xinhui pan (1):
      drm/amdgpu: Fix out-of-bounds read when update mapping
