Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0131309F2F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhAaWJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhAaWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:02:45 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D69C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:02:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f19so17222356ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q4i5K96w7N0agK2+WF1bC9oSwEZ0IHtICLJ/vHvGemI=;
        b=W4pBzZtlk9XLB7BX5V15MTfvhoeP8ldZVlOCmrbPw17aUmb6UUJMbQKAQKMT9YLKbU
         8VqRcCkGWuBAkbB6o/P8zfwC/F9jhcPzAybxBqqzAt8J7oiTFnH+w6Rh++vaOmduQ7WL
         LceaGCGDVUOu2DYqT/eSWL8PfiDNGZiPqHCAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q4i5K96w7N0agK2+WF1bC9oSwEZ0IHtICLJ/vHvGemI=;
        b=IhZC/dh1H79aOeoHzOcEZwTaaTadMr1DyrY0FFIOII05+Xja3hRSbp4ExUMfZ/G+b6
         x/G5Z+f0WdvWyX2p0lEaXIrvq6+5GnQtTxsGeJiUKuQCTXogDG3yMiv3qgUGZUILbLEw
         SmU5btkSffLdExfDyyGW9Zg1iJIpvw6HlOE654du4rSDPGiN68LmxgxPz0XWRbcvKIQI
         +Jt6jbRGRfTt8qn9staZu9CyGOAL6UNZk80wn0B4CxgqniDP67uHMsGMqGMmKZGCUTX0
         5ry5yqI67dG3rQBKUdIzb91+dtpI1pJ5YnQnfxxWpbduStlyWSTkmsXyRs7HkzGCgTVq
         HInQ==
X-Gm-Message-State: AOAM533zUsQC3RHKn6sAXh3s2taSGa8wk7452Ka8wpH4xXyBdVXe5r7b
        5Iv6ZcwYQQdAnTvXCyVnMN/lPNgi7TvqkQ==
X-Google-Smtp-Source: ABdhPJztV4BTZT7RiYyoEX4E+7wlGRkviBpsQE4zFKGhY8ufATXe6mlpcXB26XcW3FwjAVF1Vz8jqA==
X-Received: by 2002:a2e:5812:: with SMTP id m18mr8544183ljb.83.1612130520411;
        Sun, 31 Jan 2021 14:02:00 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j12sm2753281lfc.99.2021.01.31.14.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 14:01:59 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id h12so20124241lfp.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:01:59 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr6772328lff.201.1612130518892;
 Sun, 31 Jan 2021 14:01:58 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 14:01:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOjOh4gNkg==Tyjho98cea06UtnZ4ePwMP3uK-9VLCNA@mail.gmail.com>
Message-ID: <CAHk-=wiOjOh4gNkg==Tyjho98cea06UtnZ4ePwMP3uK-9VLCNA@mail.gmail.com>
Subject: Linux 5.11-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things look a little calmer than last week, and over-all very average
for rc6. So - like always this late in the release schedule - I'd
certainly have liked things to be even calmer, but nothing here really
stands out.

The diffstat is quite flat, meaning lots of small fixes, with the
exception of one new LED driver, and a flurry of PI futex fixes (and
one nouveau patch that is just a lot of trivial lines).

And all the stats look normal: average number of commits, and they are
all in the usual places, with most of the patch being drivers (gpu,
networking, sound, etc), but we obviously have all the usual suspects
with arch updates, and a smattering of fixes to core code (kernel, mm,
networking, filesystems).

A few known issues still, hopefully soon fixed, and on the whole
things look quite normal apart from some mailing list hiccups..

Go test,

                   Linus

---

Adam Harvey (1):
      cifs: ignore auto and noauto options if given

Alex Deucher (1):
      Revert "drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)"

Alexandru Elisei (1):
      KVM: arm64: Use the reg_to_encoding() macro instead of sys_reg()

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: topology: Properly unregister DAI on removal

Andrea Righi (1):
      leds: trigger: fix potential deadlock with libata

Arnd Bergmann (7):
      ARM: imx: fix imx8m dependencies
      ia64: fix timer cleanup regression
      ia64: fix xchg() warning
      ia64: Mark architecture as orphaned
      clk: imx: fix Kconfig warning for i.MX SCU clk
      clk: mmp2: fix build without CONFIG_PM
      amdgpu: fix clang build warning

Baolin Wang (1):
      blk-cgroup: Use cond_resched() when destroy blkgs

Baoquan He (1):
      kernel: kexec: remove the lock operation of system_transition_mutex

Bard Liao (1):
      ALSA: hda: intel-dsp-config: add PCI id for TGL-H

Bastian Beranek (1):
      drm/nouveau/dispnv50: Restore pushing of all data.

Ben Skeggs (1):
      drm/nouveau/nvif: fix method count when pushing an array

Bharat Gooty (1):
      arm64: dts: broadcom: Fix USB DMA address translation for Stingray

Borislav Petkov (1):
      x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument

Brett Creeley (2):
      ice: Don't allow more channels than LAN MSI-X available
      ice: Fix MSI-X vector fallback logic

Bruno Thomsen (1):
      ARM: dts: imx7d-flex-concentrator: fix pcf2127 reset

Bryan Tan (1):
      RDMA/vmw_pvrdma: Fix network_hdr_type reported in WC

Chaitanya Kulkarni (1):
      nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a SPCC device

Chao Leng (1):
      nvme-core: use list_add_tail_rcu instead of list_add_tail for
nvme_init_ns_head

Chris Wilson (3):
      drm/i915/gt: Clear CACHE_MODE prior to clearing residuals
      drm/i915: Always flush the active worker before returning from the wa=
it
      drm/i915/gt: Always try to reserve GGTT address 0x0

Claudiu Beznea (1):
      drivers: soc: atmel: add null entry at the end of at91_soc_allowed_li=
st[]

Colin Ian King (1):
      media: rcar-vin: fix return, use ret instead of zero

Coly Li (1):
      bcache: only check feature sets when sb->version >=3D
BCACHE_SB_VERSION_CDEV_WITH_FEATURES

Cong Wang (1):
      af_key: relax availability checks for skb size calculation

Corinna Vinschen (1):
      igc: fix link speed advertising

Damien Le Moal (2):
      block: fix bd_size_lock use
      null_blk: cleanup zoned mode initialization

Dan Carpenter (2):
      ASoC: topology: Fix memory corruption in soc_tplg_denum_create_values=
()
      can: dev: prevent potential information leak in can_fill_info()

Daniel Jurgens (1):
      net/mlx5: Maintain separate page trees for ECPF and PF functions

Daniel Wagner (1):
      nvme-multipath: Early exit if no path is available

Daniel Walker (1):
      spidev: Add cisco device compatible

Danielle Ratson (1):
      selftests: forwarding: Specify interface when invoking mausezahn

Dave Wysochanski (2):
      SUNRPC: Move simple_get_bytes and simple_get_netobj into private head=
er
      SUNRPC: Handle 0 length opaque XDR object data properly

David Brazdil (1):
      KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return

David Collins (1):
      regulator: core: avoid regulator_resolve_supply() race condition

David Gow (1):
      soc: litex: Properly depend on HAS_IOMEM

David Woodhouse (1):
      xen: Fix XenStore initialisation for XS_LOCAL

Davidlohr Bueso (1):
      parisc: Remove leftover reference to the power_tasklet

Dinghao Liu (1):
      block: Fix an error handling in add_partition

Dmitry Baryshkov (1):
      clk: qcom: gcc-sm250: Use floor ops for sdcc clks

Dmitry Osipenko (1):
      regulator: consumer: Add missing stubs to regulator/consumer.h

Dom Cobley (2):
      drm/vc4: Correct lbm size and calculation
      drm/vc4: Correct POS1_SCL for hvs5

Eliot Blennerhassett (1):
      ASoC: ak4458: correct reset polarity

Emmanuel Grumbach (3):
      iwlwifi: fix the NMI flow for old devices
      iwlwifi: queue: don't crash if txq->entries is NULL
      iwlwifi: pcie: add a NULL check in iwl_pcie_txq_unmap

Enke Chen (1):
      tcp: make TCP_USER_TIMEOUT accurate for zero window probes

Enzo Matsumiya (1):
      scsi: qla2xxx: Fix description for parameter ql2xenforce_iocb_limit

Eric Dumazet (1):
      iwlwifi: provide gso_type to GSO packets

Eyal Birger (1):
      xfrm: fix disable_xfrm sysctl when used on xfrm interfaces

Filipe Manana (1):
      btrfs: fix log replay failure due to race with space cache rebuild

Giacinto Cifelli (2):
      net: usb: qmi_wwan: added support for Thales Cinterion PLSx3 modem fa=
mily
      net: usb: cdc_ether: added support for Thales Cinterion PLSx3
modem family.

Gregory Greenman (1):
      iwlwifi: mvm: invalidate IDs of internal stations at mvm start

Grygorii Strashko (1):
      dt-bindings: usb: j721e: add ranges and dma-coherent props

Guo Ren (1):
      riscv: Fixup pfn_valid error with wrong max_mapnr

Hans Verkuil (1):
      media: v4l2-subdev.h: BIT() is not available in userspace

Hao Xu (1):
      io_uring: fix flush cqring overflow list while TASK_INTERRUPTIBLE

Helge Deller (1):
      parisc: Enable -mlong-calls gcc option by default when !CONFIG_MODULE=
S

Henry Tieman (1):
      ice: fix FDir IPv6 flexbyte

Herbert Xu (1):
      crypto: marvel/cesa - Fix tdma descriptor on 64-bit

Ido Schimmel (1):
      mlxsw: spectrum_span: Do not overwrite policer configuration

Ivan Vecera (1):
      team: protect features update by RCU to avoid deadlock

Jacky Bai (1):
      arm64: dts: imx8mp: Correct the gpio ranges of gpio3

Jakub Kicinski (2):
      MAINTAINERS: add David Ahern to IPv4/IPv6 maintainers
      MAINTAINERS: add missing header for bonding

James Schulman (1):
      ASoC: wm_adsp: Fix control name parsing for multi-fw

Jan H=C3=B6ppner (1):
      s390/dasd: Fix inconsistent kobject removal

Janosch Frank (1):
      s390: uv: Fix sysfs max number of VCPUs reporting

Jaroslav Kysela (1):
      ASoC: AMD Renoir - refine DMI entries for some Lenovo products

Jason Gerecke (1):
      HID: wacom: Correct NULL dereference on AES pen proximity

Jay Zhou (1):
      KVM: x86: get smi pending status correctly

Jens Axboe (2):
      io_uring: if we see flush on exit, cancel related tasks
      io_uring: only call io_cqring_ev_posted() if events were posted

Jernej Skrabec (1):
      media: cedrus: Fix H264 decoding

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset of ASUS B1400CEPE with ALC256

Joe Perches (1):
      RDMA/usnic: Fix misuse of sysfs_emit_at

Johannes Berg (14):
      iwlwifi: mvm: take mutex for calling iwl_mvm_get_sync_time()
      iwlwifi: pcie: avoid potential PNVM leaks
      iwlwifi: pnvm: don't skip everything when not reloading
      iwlwifi: pnvm: don't try to load after failures
      iwlwifi: pcie: set LTR on more devices
      iwlwifi: pcie: fix context info memory leak
      iwlwifi: pcie: use jiffies for memory read spin time limit
      iwlwifi: pcie: reschedule in long-running memory reads
      iwlwifi: mvm: guard against device removal in reprobe
      iwlwifi: queue: bail out on invalid freeing
      fs/pipe: allow sendfile() to pipe again
      wext: fix NULL-ptr-dereference with cfg80211's lack of commit()
      mac80211: pause TX while changing interface type
      staging: rtl8723bs: fix wireless regulatory API misuse

John Ogness (1):
      printk: fix string termination for record_print_text()

Jonathan Neusch=C3=A4fer (1):
      ASoC: dt-bindings: mt8192-mt6359: Fix indentation

Josef Bacik (2):
      btrfs: fix possible free space tree corruption with online conversion
      nbd: freeze the queue while we're adding connections

Juergen Gross (1):
      x86/xen: avoid warning in Xen pv guest with CONFIG_AMD_MEM_ENCRYPT en=
abled

Justin Iurman (1):
      uapi: fix big endian definition of ipv6_rpl_sr_hdr

Kai-Heng Feng (2):
      HID: multitouch: Apply MT_QUIRK_CONFIDENCE quirk for multi-input devi=
ces
      ACPI: sysfs: Prefer "compatible" modalias

Kamal Heib (1):
      RDMA/cxgb4: Fix the reported max_recv_sge value

Karol Herbst (1):
      drm/nouveau/svm: fail NOUVEAU_SVM_INIT ioctl on unsupported devices

Kevin Hao (1):
      net: octeontx2: Make sure the buffer is 128 byte aligned

Koen Vandeputte (1):
      ARM: dts: imx6qdl-gw52xx: fix duplicate regulator naming

Laurent Badel (2):
      PM: hibernate: flush swap writer after marking
      net: fec: Fix temporary RMII clock reset on link up

Libin Yang (1):
      ASoC: Intel: sof_sdw: set proper flags for Dell TGL-H SKU 0A5E

Lijun Pan (1):
      ibmvnic: Ensure that CRQ entry read are correctly ordered

Like Xu (2):
      KVM: x86/pmu: Fix UBSAN shift-out-of-bounds warning in intel_pmu_refr=
esh()
      KVM: x86/pmu: Fix HW_REF_CPU_CYCLES event pseudo-encoding in
intel_arch_events[]

Linus Torvalds (3):
      Revert "mm: fix initialization of struct page for holes in memory lay=
out"
      tty: avoid using vfs_iocb_iter_write() for redirected console writes
      Linux 5.11-rc6

Linus Walleij (3):
      ARM: dts: ux500: Reserve memory carveouts
      dt-bindings: leds: Add DT binding for Richtek RT8515
      leds: rt8515: Add Richtek RT8515 LED driver

Lorenzo Bianconi (3):
      mt7601u: fix rx buffer refcounting
      mt76: mt7663s: fix rx buffer refcounting
      mt7601u: fix kernel crash unplugging the device

Lorenzo Brescia (1):
      kvm: tracing: Fix unmatched kvm_entry and kvm_exit events

Lu Baolu (1):
      iommu/vt-d: Correctly check addr alignment in qi_flush_dev_iotlb_pasi=
d()

Luca Coelho (1):
      iwlwifi: pcie: add rules to match Qu with Hr2

Lukas Wunner (1):
      efi/apple-properties: Reinstate support for boolean properties

Lyude Paul (3):
      drivers/nouveau/kms/nv50-: Reject format modifiers for cursor planes
      drm/nouveau/kms/nv50-: Report max cursor size to userspace
      drm/nouveau/kms/gk104-gp1xx: Fix > 64x64 cursors

Maor Dickman (2):
      net/mlx5e: Reduce tc unsupported key print level
      net/mlx5e: Disable hw-tc-offload when MLX5_CLS_ACT config is disabled

Marc Zyngier (4):
      KVM: arm64: Hide PMU registers from userspace when not available
      KVM: arm64: Simplify handling of absent PMU system registers
      KVM: arm64: Filter out v8.1+ events on v8.0 HW
      KVM: Forbid the use of tagged userspace addresses for memslots

Marco Felsch (2):
      ARM: dts: imx6qdl-kontron-samx6i: fix pwms for lcd-backlight
      ARM: dts: imx6qdl-kontron-samx6i: fix i2c_lcd/cam default status

Marek Vasut (2):
      net: dsa: microchip: ksz8795: Fix KSZ8794 port map again
      net: dsa: microchip: Adjust reset release timing to match
reference reset circuit

Mark Brown (1):
      regulator: Fix lockdep warning resolving supplies

Martin Wilck (1):
      Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"

Matt Chen (1):
      iwlwifi: mvm: fix the return type for DSM functions 1 and 2

Matthias Reichl (2):
      media: rc: fix timeout handling after switch to microsecond durations
      media: rc: ite-cir: fix min_timeout calculation

Matti Gottlieb (1):
      iwlwifi: Fix IWL_SUBDEVICE_NO_160 macro to use the correct bit.

Mauro Carvalho Chehab (4):
      ASoC: audio-graph-card: update audio-graph-card.yaml reference
      dt-bindings: display: mediatek: update mediatek,dpi.yaml reference
      dt-bindings: memory: mediatek: update mediatek,smi-larb.yaml referenc=
es
      dt-bindings:iio:adc: update adc.yaml reference

Max Krummenacher (1):
      ARM: imx: build suspend-imx6.S with arm instruction set

Maxim Levitsky (1):
      KVM: nVMX: Sync unsync'd vmcs02 state to vmcs12 on migration

Maxim Mikityanskiy (5):
      net/mlx5e: Fix IPSEC stats
      net/mlx5e: Correctly handle changing the number of queues when
the interface is down
      net/mlx5e: Revert parameters on errors when changing trust state
without reset
      net/mlx5e: Revert parameters on errors when changing MTU and LRO
state without reset
      Revert "block: simplify set_init_blocksize" to regain lost performanc=
e

Michael Walle (1):
      arm64: dts: ls1028a: fix the offset of the reset register

Miklos Szeredi (1):
      ecryptfs: fix uid translation for setxattr on security.capability

Ming Lei (1):
      blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in hctx_may_qu=
eue

Moritz Fischer (1):
      ACPI/IORT: Do not blindly trust DMA masks from firmware

Nadav Amit (1):
      iommu/vt-d: Do not use flush-queue when caching-mode is on

Nathan Chancellor (1):
      mt76: Fix queue ID variable types after mcu queue split

Naushir Patuck (1):
      media: Revert "media: videobuf2: Fix length check for single
plane dmabuf queueing"

Nicholas Piggin (1):
      powerpc/64s: prevent recursive replay_soft_interrupts causing
superfluous interrupt

Nick Desaulniers (1):
      x86/entry: Emit a symbol for register restoring thunk

Nick Nunley (2):
      ice: Implement flow for IPv6 next header (extension header)
      ice: update dev_addr in ice_set_mac_address even if HW filter exists

Nishanth Menon (1):
      arm64: defconfig: Drop unused K3 SoC specific options

Pablo Neira Ayuso (3):
      netfilter: nft_dynset: honor stateful expressions in set definition
      netfilter: nft_dynset: add timeout extension to template
      netfilter: nft_dynset: dump expressions when set definition
contains no expressions

Pali Roh=C3=A1r (1):
      doc: networking: ip-sysctl: Document conf/all/disable_ipv6 and
conf/default/disable_ipv6

Pan Bian (9):
      spi: altera: Fix memory leak on error path
      net: stmmac: dwmac-intel-plat: remove config data on error
      net: fec: put child node on error path
      net: dsa: bcm_sf2: put device node before return
      chtls: Fix potential resource leak
      NFC: fix possible resource leak
      NFC: fix resource leak when target index is invalid
      drm/i915/selftest: Fix potential memory leak
      net/mlx5e: free page before return

Paolo Bonzini (1):
      KVM: x86: allow KVM_REQ_GET_NESTED_STATE_PAGES outside guest mode for=
 VMX

Parav Pandit (2):
      Revert "RDMA/mlx5: Fix devlink deadlock on net namespace deletion"
      net/mlx5e: E-switch, Fix rate calculation for overflow

Paul Blakey (2):
      net/mlx5e: Fix CT rule + encap slow path offload and deletion
      net/mlx5: CT: Fix incorrect removal of tuple_nat_node from nat rhasht=
able

Pavel Begunkov (6):
      io_uring: fix __io_uring_files_cancel() with TASK_UNINTERRUPTIBLE
      io_uring: fix cancellation taking mutex while TASK_UNINTERRUPTIBLE
      io_uring: fix wqe->lock/completion_lock deadlock
      io_uring: fix list corruption for splice file_get
      io_uring: fix sqo ownership false positive warning
      io_uring: reinforce cancel on flush during exit

Pengcheng Yang (1):
      tcp: fix TLP timer not set when CA_STATE changes from DISORDER to OPE=
N

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: soundwire: fix select/depend unmet dependencies
      ASoC: SOF: SND_INTEL_DSP_CONFIG dependency

Po-Hsu Lin (1):
      selftests: xfrm: fix test return value override issue in xfrm_policy.=
sh

Qii Wang (1):
      i2c: mediatek: Move suspend and resume handling to NOIRQ phase

Quentin Perret (1):
      KVM: Documentation: Fix spec for KVM_CAP_ENABLE_CAP_VM

Rafael J. Wysocki (1):
      ACPI: thermal: Do not call acpi_thermal_check() directly

Randy Dunlap (1):
      firmware: imx: select SOC_BUS to fix firmware build

Rasmus Villemoes (3):
      net: mrp: fix definitions of MRP test packets
      net: mrp: move struct definitions out of uapi
      net: switchdev: don't set port_obj_info->handled true when -EOPNOTSUP=
P

Ricardo Ribalda (3):
      ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
      ASoC: Intel: Skylake: Zero snd_ctl_elem_value
      media: hantro: Fix reset_raw_fmt initialization

Rob Herring (2):
      ARM: zImage: atags_to_fdt: Fix node names on added root nodes
      dt-bindings: Cleanup standard unit properties

Roger Pau Monne (1):
      xen-blkfront: allow discard-* nodes to be optional

Roi Dayan (1):
      net/mlx5: Fix memory leak on flow table creation error flow

Ronnie Sahlberg (1):
      cifs: fix dfs domain referrals

Rouven Czerwinski (1):
      tee: optee: replace might_sleep with cond_resched

Russell King (1):
      ARM: dts: imx6qdl-sr-som: fix some cubox-i platforms

Sakari Ailus (3):
      media: ccs-pll: Fix link frequency for C-PHY
      media: ccs: Get static data version minor correctly
      media: v4l: common: Fix naming of v4l2_get_link_rate

Sami Tolvanen (1):
      Fix the redirected_tty_write declaration in n_tty

Sara Sharon (1):
      iwlwifi: mvm: skip power command when unbinding vif during CSA

Sean Christopherson (3):
      KVM: x86: Add more protection against undefined behavior in rsvd_bits=
()
      KVM: SVM: Unconditionally sync GPRs to GHCB on VMRUN of SEV-ES guest
      KVM: x86: Revert "KVM: x86: Mark GPRs dirty when written"

Sean Young (1):
      media: rc: ensure that uevent can be read directly after rc
device register

Shaul Triebitz (1):
      iwlwifi: mvm: clear IN_D3 after wowlan status cmd

Shay Bar (1):
      mac80211: 160MHz with extended NSS BW in CSA

Shengjiu Wang (1):
      arm64: dts: imx8mn: Fix duplicate node name

Shmulik Ladkani (1):
      xfrm: Fix oops in xfrm_replay_advance_bmp

Soeren Moch (1):
      ARM: dts: tbs2910: rename MMC node aliases

Srinivas Kandagatla (3):
      ASoC: dt-bindings: lpass: Fix and common up lpass dai ids
      ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY
      ASoC: qcom: lpass-ipq806x: fix bitwidth regmap field

Stanimir Varbanov (1):
      media: venus: core: Fix platform driver shutdown

Stefan Assmann (1):
      i40e: acquire VSI pointer only after VF is initialized

Stefan Wahren (1):
      MAINTAINERS: Include bcm2835 subsequents into search

Stephan Gerhold (1):
      ASoC: qcom: lpass: Fix out-of-bounds DAI ID lookup

Stephen Boyd (1):
      ASoC: qcom: Fix number of HDMI RDMA channels on sc7180

Steve French (2):
      cifs: fix mounts to subdirectories of target
      cifs: returning mount parm processing errors correctly

Steven Price (1):
      KVM: arm64: Compute TPIDR_EL2 ignoring MTE tag

Su Yue (1):
      btrfs: fix lockdep warning due to seqcount_mutex on 32bit arch

Sudeep Holla (1):
      drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs

Sumera Priyadarsini (1):
      bus: arm-integrator-lm: Add of_node_put() before return statement

Suravee Suthikulpanit (1):
      iommu/amd: Use IVHD EFR for early initialization of IOMMU features

Takashi Iwai (4):
      iwlwifi: dbg: Don't touch the tlv data
      ALSA: pcm: One more dependency for hw constraints
      ALSA: usb-audio: workaround for iface reset issue
      ALSA: hda/via: Apply the workaround generically for Clevo machines

Takeshi Misawa (1):
      rxrpc: Fix memory leak in rxrpc_lookup_local

Taniya Das (1):
      clk: qcom: gcc-sc7180: Mark the camera abh clock always ON

Thomas Gleixner (8):
      futex: Ensure the correct return value from futex_lock_pi()
      futex: Replace pointless printk in fixup_owner()
      futex: Provide and use pi_state_update_owner()
      rtmutex: Remove unused argument from rt_mutex_proxy_unlock()
      futex: Use pi_state_update_owner() in put_pi_state()
      futex: Simplify fixup_pi_state_owner()
      futex: Handle faults correctly for PI futexes
      rtc: mc146818: Detect and handle broken RTCs

Tony Krowiak (2):
      s390/vfio-ap: clean up vfio_ap resources when KVM pointer invalidated
      s390/vfio-ap: No need to disable IRQ after queue reset

Trond Myklebust (4):
      pNFS/NFSv4: Fix a layout segment leak in pnfs_layout_process()
      pNFS/NFSv4: Try to return invalid layout in pnfs_layout_process()
      pNFS/NFSv4: Update the layout barrier when we schedule a layoutreturn
      pNFS/NFSv4: Improve rejection of out-of-order layouts

Tzung-Bi Shih (3):
      ASoC: mediatek: mt8183-mt6358: ignore TDM DAI link by default
      ASoC: mediatek: mt8183-da7219: ignore TDM DAI link by default
      ASoC: mediatek: mt8192-mt6359: add format constraints for RT5682

Umesh Nerlige Ramappa (1):
      drm/i915: Check for all subplatform bits

Vadim Fedorenko (1):
      net: decnet: fix netdev refcount leaking on error path

Valdis Kletnieks (1):
      scsi: target: iscsi: Fix typo in comment

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix ICL MG PHY vswing handling

Vincenzo Frascino (1):
      arm64: Fix kernel address detection of __is_lm_address()

Visa Hankala (1):
      xfrm: Fix wraparound in xfrm_policy_addr_delta()

Voon Weifeng (1):
      stmmac: intel: Configure EHL PSE0 GbE and PSE1 GbE to 32 bits
DMA addressing

Wang Hai (1):
      Revert "mm/slub: fix a memory leak in sysfs_slab_add()"

Xie He (1):
      net: lapb: Add locking to the lapb module

Yangyang Li (1):
      RDMA/hns: Use mutex instead of spinlock for ida allocation

Yannick Fertre (1):
      media: cec: add stm32 driver

Yong Wu (1):
      of/device: Update dma_range_map only when dev has valid dma-ranges

Yuxuan Shui (1):
      entry: Unbreak single step reporting behaviour

Zenghui Yu (1):
      KVM: Documentation: Update description of KVM_{GET,CLEAR}_DIRTY_LOG

Zheng Yongjun (2):
      leds: leds-lm3533: convert comma to semicolon
      leds: leds-ariel: convert comma to semicolon

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      mailmap: remove the "repo-abbrev" comment
