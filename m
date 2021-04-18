Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1B3637FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhDRWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhDRWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 18:03:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F77C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 15:03:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so53055147lfh.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kWyNTLt3gKAwZt8ByRSBYPVrnl7uFJmv0ueCNImZUgo=;
        b=AY2qIG8w/KZ+RI5MLpBCFd1DTmNICbDqF3bkL1TQwNj73JL5v/Fs92AlDvpyMuLxqB
         wPdVgdLynvir1TR3Skevtk2oJuf+RcLwI00akxd4o9EXD8xNixiq3s4zxOfpaXOm8KGQ
         OqEPwIy6ht1kg+s/AbiCDKDCN5RPspukHiKcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kWyNTLt3gKAwZt8ByRSBYPVrnl7uFJmv0ueCNImZUgo=;
        b=Dogl2mlDWjPcXtATOXXZKT42J/NOLEp7JLpPS048c0aDtGO5kinJBVXD0Wq/t4SINK
         Ng9d+niMOlHN8wmkOV1dspFhxq6HdybnBW5Acm3QpyO80Pc1pyXYmZCA+7tS63dfn3jY
         SCxElgPFMryY+aLO0vzekrHT0xvUX9SYjKHQsCumHeEzr+K1bO+z8JVeEMHe/It4vk3+
         wNI/BiY5UdU600ZdxUR736Z0FDMbZK4WuttV4wLMwp0IuL7Jh+sBhcIXn7BIGqJeyP3j
         TUDMP4xpU7FXTO4e7Hmp5u5cdPLQ5ozbk93SbszmyCfA7jPt80DORteAEvFRjUAz0Eox
         NxQA==
X-Gm-Message-State: AOAM531LEqwSBJXrFOw20UsqJlI5ejNnJ56gtT6lwKYGhZeGdMhxRU1s
        2ZCLn9vjL3kYzG8/QOkdgjyf4Jq9NTL0E6k1
X-Google-Smtp-Source: ABdhPJyhWT3gOGs7NwuGOppZO74Sn6XE8bkYdMO0Euf3hDxUatXHsk/IVtdeYEMVyOon9naS9uL3EA==
X-Received: by 2002:ac2:58ec:: with SMTP id v12mr6337687lfo.542.1618783386551;
        Sun, 18 Apr 2021 15:03:06 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k11sm243191lfg.288.2021.04.18.15.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 15:03:06 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y4so12798797lfl.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 15:03:06 -0700 (PDT)
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr9778564lfe.41.1618783385619;
 Sun, 18 Apr 2021 15:03:05 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Apr 2021 15:02:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgVFDhX60fxwDobHoqJvVkuxf=JgSTtGnGMa5r-1u4Yw@mail.gmail.com>
Message-ID: <CAHk-=wjgVFDhX60fxwDobHoqJvVkuxf=JgSTtGnGMa5r-1u4Yw@mail.gmail.com>
Subject: Linux 5.12-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so it's been _fairly_ calm this past week, but it hasn't been the
kind of dead calm I would have taken to mean "no rc8 necessary".

So here we are, with an extra rc to make sure things are all settled
down. It's not _that_ rare: this is the fifth time in the 5.x series
we've ended up with an rc8, but I have to admit that I prefer it when
a release doesn't end up needing that extra week.

Because let's keep it to just one extra week, ok? We have occasionally
done rc9's too, but I really don't expect that this time around.

About half of this is once more networking, with driver and bpf
verifier fixes standing out. Other than that it's mostly other driver
updates (gpu, dmaengine, HID, input, nvdimm) and arch updates (mainly
arm and arm64).

And a number of one-liner build fixes for unusual configurations.

So it's not tiny, but it's all small enough that you can easily scan
through the shortlog below and get a fair sense of what's going on.

Let's plan on a final 5.12 release next weekend - but please do give
it one last test to check that it is all solid. Ok?

                  Linus

---

Alexander Duyck (1):
      ixgbe: Fix NULL pointer dereference in ethtool loopback test

Andre Przywara (1):
      arm64: dts: allwinner: Fix SD card CD GPIO for SOPine systems

Andy Shevchenko (1):
      dmaengine: dw: Make it dependent to HAS_IOMEM

Angelo Dureghello (1):
      m68k: fix flatmem memory model setup

Ard Biesheuvel (1):
      ARM: 9063/1: mm: reduce maximum number of CPUs if
DEBUG_KMAP_LOCAL is enabled

Arnd Bergmann (3):
      dax: avoid -Wempty-body warnings
      Input: i8042 - fix Pegatron C15B ID entry
      kasan: fix hwasan build for gcc

Aya Levin (2):
      net/mlx5: Fix setting of devlink traps in switchdev mode
      net/mlx5e: Fix setting of RS FEC mode

Ben Widawsky (1):
      cxl/mem: Fix register block offset calculation

Caleb Connolly (1):
      Input: s6sy761 - fix coordinate read bit shift

Catalin Marinas (1):
      arm64: mte: Ensure TIF_MTE_ASYNC_FAULT is set atomically

Chen-Yu Tsai (1):
      arm64: dts: allwinner: h6: Switch to macros for RSB clock/reset indic=
es

Christian A. Ehrhardt (1):
      vfio/pci: Add missing range check in vfio_pci_mmap

Christophe JAILLET (2):
      net: davicom: Fix regulator not turned off on failed probe
      tracing/dynevent: Fix a memory leak in an error handling path

Christophe Leroy (1):
      mm: ptdump: fix build failure

Ciara Loftus (1):
      libbpf: Fix potential NULL pointer dereference

Claudiu Beznea (1):
      net: macb: fix the restore of cmp registers

Colin Ian King (1):
      ice: Fix potential infinite loop when using u8 loop counter

Dan Carpenter (1):
      dmaengine: plx_dma: add a missing put_device() on error path

Dan Williams (6):
      cxl/mem: Use sysfs_emit() for attribute show routines
      cxl/mem: Fix synchronization mechanism for device removal vs
ioctl operations
      cxl/mem: Do not rely on device_add() side effects for
dev_set_name() failures
      cxl/mem: Disable cxl device power management
      libnvdimm: Notify disk drivers to revalidate region read-only
      cxl/mem: Fix memory device capacity probing

Daniel Borkmann (9):
      bpf: Use correct permission flag for mixed signed bounds arithmetic
      bpf: Move off_reg into sanitize_ptr_alu
      bpf: Ensure off_reg has no mixed signed bounds for all types
      bpf: Rework ptr_limit into alu_limit and add common error path
      bpf: Improve verifier error messages for users
      bpf: Refactor and streamline bounds check into helper
      bpf: Move sanitize_val_alu out of op switch
      bpf: Tighten speculative pointer arithmetic mask
      bpf: Update selftests to reflect new error states

Dave Jiang (6):
      dmaengine: idxd: Fix clobbering of SWERR overflow bit on writeback
      dmaengine: idxd: fix delta_rec and crc size field for completion reco=
rd
      dmaengine: idxd: fix opcap sysfs attribute output
      dmaengine: idxd: fix wq size store permission state
      dmaengine: idxd: clear MSIX permission entry on shutdown
      dmaengine: idxd: fix wq cleanup of WQCFG registers

Dinghao Liu (1):
      dmaengine: tegra20: Fix runtime PM imbalance on error

Dmitry Osipenko (2):
      Input: elants_i2c - fix division by zero if firmware reports
zero phys size
      Input: elants_i2c - drop zero-checking of ABS_MT_TOUCH_MAJOR resoluti=
on

Douglas Gilbert (1):
      HID cp2112: fix support for multiple gpiochips

Eric Dumazet (2):
      netfilter: nft_limit: avoid possible divide error in nft_limit_init
      gro: ensure frag0 meets IP header alignment

Fabian Vogt (1):
      Input: nspire-keypad - enable interrupts only when opened

Florian Westphal (4):
      netfilter: bridge: add pre_exit hooks for ebtable unregistration
      netfilter: arp_tables: add pre_exit hook for table unregister
      netfilter: x_tables: fix compat match/target pad out-of-bound write
      netlink: don't call ->netlink_bind with table lock held

Fredrik Strupe (1):
      ARM: 9071/1: uprobes: Don't hook on thumb instructions

Hans de Goede (4):
      AMD_SFH: Removed unused activecontrolstatus member from the
amd_mp2_dev struct
      AMD_SFH: Add sensor_mask module parameter
      AMD_SFH: Add DMI quirk table for BIOS-es which don't set the
activestatus bits
      drm/i915/display/vlv_dsi: Do not skip panel_pwr_cycle_delay when
disabling the panel

Hauke Mehrtens (1):
      mtd: rawnand: mtk: Fix WAITRDY break condition and timeout

Heiner Kallweit (1):
      r8169: don't advertise pause in jumbo mode

Hristo Venev (2):
      net: sit: Unregister catch-all devices
      net: ip6_tunnel: Unregister catch-all devices

Jaegeuk Kim (1):
      dm verity fec: fix misaligned RS roots IO

Jakub Kicinski (2):
      ethtool: fix kdoc attr name
      ethtool: pause: make sure we init driver stats

Jason Xing (1):
      i40e: fix the panic when running bpf in xdpdrv mode

Jernej Skrabec (1):
      arm64: dts: allwinner: h6: beelink-gs1: Remove ext. 32 kHz osc refere=
nce

Jia-Ju Bai (1):
      HID: alps: fix error return code in alps_input_configured()

Jiapeng Zhong (1):
      HID: wacom: Assign boolean values to a bool variable

Jisheng Zhang (4):
      arm64: kprobes: Restore local irqflag if kprobes is cancelled
      riscv: add do_page_fault and do_trap_break into the kprobes blacklist
      riscv: kprobes/ftrace: Add recursion protection to the ftrace callbac=
k
      riscv: keep interrupts disabled for BREAKPOINT exception

Joakim Zhang (1):
      MAINTAINERS: update maintainer entry for freescale fec driver

Johannes Berg (1):
      gcov: clang: fix clang-11+ build

John Paul Adrian Glaubitz (2):
      ia64: tools: remove inclusion of ia64-specific version of errno.h hea=
der
      ia64: tools: remove duplicate definition of ia64_mf() on ia64

Jolly Shah (1):
      scsi: libsas: Reset num_scatter if libata marks qc as NODATA

Jonathon Reinhart (1):
      net: Make tcp_allowed_congestion_control readonly in non-init netns

Kefeng Wang (1):
      riscv: Fix spelling mistake "SPARSEMEM" to "SPARSMEM"

Laurent Pinchart (2):
      dmaengine: xilinx: dpdma: Fix descriptor issuing on video group
      dmaengine: xilinx: dpdma: Fix race condition in done IRQ

Lijun Pan (5):
      ibmvnic: correctly use dev_consume/free_skb_irq
      ibmvnic: avoid calling napi_disable() twice
      ibmvnic: remove duplicate napi_schedule call in do_reset function
      ibmvnic: remove duplicate napi_schedule call in open function
      MAINTAINERS: update my email

Linus Torvalds (2):
      readdir: make sure to verify directory entry for legacy interfaces to=
o
      Linux 5.12-rc8

Luke D Jones (1):
      HID: asus: Add support for 2021 ASUS N-Key keyboard

Lv Yunlong (1):
      dmaengine: Fix a double free in dma_async_device_register

Lyude Paul (1):
      drm/i915/dpcd_bl: Don't try vesa interface unless specified by VBT

Marek Beh=C3=BAn (1):
      i2c: mv64xxx: Fix random system lock caused by runtime PM

Matti Vaittinen (1):
      gpio: sysfs: Obey valid_mask

Maxime Ripard (2):
      MAINTAINERS: Add our new mailing-list
      MAINTAINERS: Match on allwinner keyword

Michael Brown (1):
      xen-netback: Check for hotplug-status existence before watching

Mike Christie (1):
      scsi: iscsi: Fix iSCSI cls conn state

Nathan Chancellor (1):
      arm64: alternatives: Move length validation in alternative_{insn, end=
if}

Nicolas Dichtel (2):
      doc: move seg6_flowlabel to seg6-sysctl.rst
      vrf: fix a comment about loopback device

Or Cohen (1):
      net/sctp: fix race condition in sctp_destroy_sock

Pablo Neira Ayuso (3):
      netfilter: flowtable: fix NAT IPv6 offload mangling
      netfilter: conntrack: do not print icmpv6 as unknown via /proc
      netfilter: nftables: clone set element expression template

Pali Roh=C3=A1r (1):
      net: phy: marvell: fix detection of PHY on Topaz switches

Pavel Begunkov (1):
      io_uring: fix early sqd_list removal sqpoll hangs

Peter Collingbourne (1):
      arm64: fix inline asm in load_unaligned_zeropad()

Phillip Potter (1):
      net: geneve: check skb is large enough for IPv4/IPv6 header

Ping Cheng (1):
      HID: wacom: set EV_KEY and EV_ABS only for non-HID_GENERIC type of de=
vices

Rafael J. Wysocki (1):
      ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()

Randy Dunlap (5):
      mm: eliminate "expecting prototype" kernel-doc warnings
      csky: change a Kconfig symbol name to fix e1000 build error
      ia64: remove duplicate entries in generic_defconfig
      ia64: fix discontig.c section mismatches
      lib: remove "expecting prototype" kernel-doc warnings

Reiji Watanabe (1):
      KVM: VMX: Don't use vcpu->run->internal.ndata as an array index

Robert Richter (1):
      cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX

Russell King (1):
      ARM: footbridge: fix PCI interrupt mapping

Shawn Guo (1):
      soc: qcom: geni: shield geni_icc_get() for ACPI boot

Shou-Chieh Hsu (1):
      HID: google: add don USB id

Thierry Reding (1):
      Revert "net: stmmac: re-init rx buffers when mac resume back"

Tony Lindgren (3):
      ARM: OMAP2+: Fix warning for omap_init_time_of()
      ARM: dts: Fix swapped mmc order for omap3
      ARM: OMAP2+: Fix uninitialized sr_inst

Vaibhav Jain (1):
      libnvdimm/region: Fix nvdimm_has_flush() to handle ND_REGION_ASYNC

Vasily Gorbik (2):
      s390/entry: avoid setting up backchain in ext|io handlers
      s390/entry: save the caller of psw_idle

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Don't zero out the Y plane's watermarks

Vinay Kumar Yadav (4):
      ch_ktls: Fix kernel panic
      ch_ktls: fix device connection close
      ch_ktls: tcb close causes tls connection failure
      ch_ktls: do not send snd_una update to TCB in middle

Vladimir Murzin (1):
      ARM: 9069/1: NOMMU: Fix conversion for_each_membock() to
for_each_mem_range()

Walter Wu (1):
      kasan: remove redundant config option

Wan Jiabing (1):
      cavium/liquidio: Fix duplicate argument

Wei Yongjun (1):
      Input: n64joy - fix return value check in n64joy_probe()

Yongxin Liu (1):
      ixgbe: fix unbalanced device enable/disable in suspend/resume

Zack Rusin (4):
      drm/vmwgfx: Make sure we unpin no longer needed buffers
      drm/vmwgfx: Fix the lockdep breakage
      drm/vmwgfx: Make sure bo's are unpinned before putting them back
      mm/mapping_dirty_helpers: guard hugepage pud's usage

wenxu (1):
      net/mlx5e: fix ingress_ifindex check in mlx5e_flower_parse_meta
