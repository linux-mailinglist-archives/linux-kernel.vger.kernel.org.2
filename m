Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A5460AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 23:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357172AbhK1W2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 17:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347913AbhK1W0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 17:26:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA5C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 14:21:39 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so63904359edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tAF+McmMVbHKSqJ4Bh/aFlPNavPdpA6RHVFahr1s/9U=;
        b=iHJKRFpUFCYf6ER/pN7ZnVyh0dPv86awvG0uSBGw1yK1uIWPDvkC5m7neUx27URIxY
         wTUILtz37vSATH3SL26b2DCeR32jZ1wkDgt2t8eha7zfZhQjzZvIs2maTSJrKAywq+UQ
         sqF05+Jtu6zbzmzfgxmfP5l9QCZ3S1jLUt8lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tAF+McmMVbHKSqJ4Bh/aFlPNavPdpA6RHVFahr1s/9U=;
        b=47NptzGPSyJIfOZXUFcZmkoGDp+xyb5k6NxW0cvrXh2aZvdTgXQgrobPa9N5oM9lxn
         xA8OS9H+mNKHdwGKMIsPIEiH8OMH7jnh//PPffF117VyxjDoRuhSIZ9x1quxFJ/lw9Vb
         RyFV1ISCJFBMqr4z/E8PZSkkAtyObhk2X7nTsyznGTnPQ9CPeF2S1uAJykZFGUBglxi1
         wVKmyXGUe9O64MxoEH0XE59T1HlDKQVG9w6/zRTf9VRG58Es6XogB1Ssllv4XP4hqglq
         WOfiaZu2fEWhcshCHshshAXfbGAJWFAlGv8lbpZreyO8N2y6CQItLectHQkaf4kYl6BL
         tGxg==
X-Gm-Message-State: AOAM533+pmv4YNMvpJ7ldFJafRPfoKcj7QdAHHcCCHhYCthrKpTkBoYh
        x6dPpgVgaRmBaiAPDb808jFhKFoPWLWN1KNX
X-Google-Smtp-Source: ABdhPJysPQSNAUD7y/SeFrAJS6IVlQwSQURPH4D/CgqLvu00rPSkscqbGeyAoovbNd+vLxQ7LztKEQ==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr53127875ejc.356.1638138097828;
        Sun, 28 Nov 2021 14:21:37 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id cw20sm6051598ejc.90.2021.11.28.14.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 14:21:37 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so15291995wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 14:21:37 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr32216718wmq.26.1638138096597;
 Sun, 28 Nov 2021 14:21:36 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Nov 2021 14:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
Message-ID: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
Subject: Linux 5.16-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So rc3 is usually a bit larger than rc2 just because people had some
time to start finding things.

So too this time, although it's not like this is a particularly big
rc3. Possibly partly due to the past week having been Thanksgiving
week here in the US. But the size is well within the normal range, so
if that's a factor, it's not been a big one.

The diff for rc3 is mostly drivers, although part of that is just
because of the removal of a left-over MIPS Netlogic driver which makes
the stats look a bit wonky, and is over a third of the whole diff just
in itself.

If you ignore that part, the statistics look a bit more normal, but
drivers still dominate (network drivers, sound and gpu are the big
ones, but there is noise all over). Other than that there's once again
a fair amount of selftest (mostly networking), along with core
networking, some arch updates - the bulk of it from a single arm64
uaccess patch, although that's mostly because it's all pretty small -
and random other changes.

Full shortlog below.

Please test,

             Linus

---

Abel Vesa (1):
      dt-bindings: i2c: imx-lpi2c: Fix i.MX 8QM compatible matching

Adamos Ttofari (1):
      cpufreq: intel_pstate: Add Ice Lake server to out-of-band IDs

Adrian Hunter (1):
      mmc: sdhci: Fix ADMA for PAGE_SIZE >=3D 64KiB

Albert Wang (1):
      usb: dwc3: gadget: Fix null pointer exception

Alex Bee (1):
      iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568

Alex Deucher (4):
      drm/amdgpu/gfx10: add wraparound gpu counter check for APUs as well
      drm/amdgpu/gfx9: switch to golden tsc registers for renoir+
      drm/amdgpu/pm: fix powerplay OD interface
      drm/amd/display: update bios scratch when setting backlight

Alex Elder (3):
      net: ipa: directly disable ipa-setup-ready interrupt
      net: ipa: separate disabling setup from modem stop
      net: ipa: kill ipa_cmd_pipeline_clear()

Alex Williamson (1):
      iommu/vt-d: Fix unmap_pages support

Alexander Aring (1):
      net: ieee802154: handle iftypes as u32

Amit Cohen (1):
      mlxsw: spectrum: Protect driver from buggy firmware

Andreas Gruenbacher (2):
      iomap: Fix inline extent handling in iomap_readpage
      iomap: iomap_read_inline_data cleanup

Andr=C3=A9 Almeida (1):
      futex: Wireup futex_waitv syscall

AngeloGioacchino Del Regno (2):
      ASoC: mediatek: mt8173-rt5650: Rename Speaker control to Ext Spk
      ASoC: mediatek: mt8173: Fix debugfs registration for components

Ansuel Smith (1):
      net: dsa: qca8k: fix internal delay applied to the wrong PAD config

Arnd Bergmann (4):
      media: v4l2-core: fix VIDIOC_DQEVENT handling on non-x86
      HID: intel-ish-hid: fix module device-id handling
      ASoC: SOF: build compression interface into snd_sof.ko
      nixge: fix mac address error handling again

Bean Huo (1):
      scsi: ufs: ufshpb: Fix warning in ufshpb_set_hpb_read_to_upiu()

Ben Skeggs (1):
      drm/nouveau: recognise GA106

Benjamin Coddington (2):
      NFS: Add a tracepoint to show the results of nfs_set_cache_invalid()
      NFSv42: Fix pagecache invalidation after COPY/CLONE

Borislav Petkov (1):
      x86/boot: Mark prepare_command_line() __init

Brett Creeley (1):
      iavf: Fix VLAN feature flags after VFR

Chanho Park (1):
      arm64: dts: exynos: drop samsung,ufs-shareability-reg-offset in
ExynosAutov9

Charles Keepax (1):
      ASoC: cs35l41: Change monitor widgets to siggens

ChiYuan Huang (3):
      ASoC: rt9120: Update internal ocp level to the correct value
      ASoC: rt9120: Fix clock auto sync issue when fs is the multiple of 48
      ASoC: rt9120: Add the compatibility with rt9120s

Christoph Hellwig (1):
      xfs: remove xfs_inew_wait

Christophe JAILLET (3):
      usb: gadget: udc-xilinx: Fix an error handling path in 'xudc_probe()'
      ksmbd: Fix an error handling path in 'smb2_sess_setup()'
      iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()

Christophe Leroy (1):
      powerpc/32: Fix hardlockup on vmap stack overflow

Claudia Pellegrino (1):
      HID: magicmouse: prevent division by 0 on scroll

Cristian Marussi (3):
      firmware: arm_scmi: Fix null de-reference on error path
      firmware: arm_scmi: Fix type error in sensor protocol
      firmware: arm_scmi: Fix type error assignment in voltage protocol

Dan Carpenter (8):
      HID: nintendo: unlock on error in joycon_leds_create()
      staging: r8188eu: fix a memory leak in rtw_wx_read32()
      staging: rtl8192e: Fix use after free in _rtl92e_pci_disconnect()
      usb: chipidea: ci_hdrc_imx: fix potential error pointer
dereference in probe
      drm/nouveau/acr: fix a couple NULL vs IS_ERR() checks
      scsi: qla2xxx: edif: Fix off by one bug in qla_edif_app_getfcinfo()
      scsi: target: configfs: Delete unnecessary checks for NULL
      drm/vc4: fix error code in vc4_create_object()

Daniel Borkmann (1):
      net, neigh: Fix crash in v6 module initialization error path

Daniele Palmas (1):
      USB: serial: option: add Telit LE910S1 0x9200 composition

Danielle Ratson (1):
      mlxsw: spectrum: Allow driver to load with old firmware versions

Davide Caratti (1):
      net/sched: sch_ets: don't peek at classes beyond 'nbands'

Derek Fang (2):
      ASoC: rt5682: Avoid the unexpected IRQ event during going to suspend
      ASoC: rt5682: Re-detect the combo jack after resuming

Diana Wang (1):
      nfp: checking parameter process for rx-usecs/tx-usecs is invalid

Dmitry Osipenko (1):
      usb: xhci: tegra: Check padctrl interrupt presence in device tree

Dylan Hung (1):
      mdio: aspeed: Fix "Link is Down" issue

Enzo Matsumiya (1):
      nvme-pci: add NO APST quirk for Kioxia device

Eric Dumazet (4):
      mptcp: fix delack timer
      ipv6: fix typos in __ip6_finish_output()
      tools: sync uapi/linux/if_link.h header
      tcp_cubic: fix spurious Hystart ACK train detections for
not-cwnd-limited flows

Evan Green (1):
      PM: hibernate: Fix snapshot partial write lengths

Fabio Aiuto (1):
      usb: dwc3: leave default DMA for PCI devices

Fabio M. De Francesco (1):
      staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context

Felix Kuehling (1):
      drm/amdgpu: Fix MMIO HDP flush on SRIOV

Florent Fourcot (2):
      netfilter: ctnetlink: fix filtering with CTA_TUPLE_REPLY
      netfilter: ctnetlink: do not erase error code with EINVAL

Florian Fainelli (4):
      ARM: dts: BCM5301X: Fix I2C controller interrupt
      ARM: dts: BCM5301X: Add interrupt properties to GPIO node
      ARM: dts: bcm2711: Fix PCIe interrupts
      MAINTAINERS: Update B53 section to cover SF2 switch driver

Florian Westphal (3):
      selftests: netfilter: add a vrf+conntrack testcase
      selftests: netfilter: extend nfqueue tests to cover vrf device
      selftests: nft_nat: switch port shadow test cases to socat

George Kennedy (2):
      scsi: scsi_debug: Fix type in min_t to avoid stack OOB
      scsi: scsi_debug: Sanity check block descriptor length in
resp_mode_select()

Gongjun Song (9):
      ASoC: Intel: sof_sdw: Add support for SKU 0AF3 product
      ASoC: Intel: soc-acpi: add SKU 0AF3 SoundWire configuration
      ASoC: Intel: sof_sdw: Add support for SKU 0B00 and 0B01 products
      ASoC: Intel: sof_sdw: Add support for SKU 0B11 product
      ASoC: Intel: sof_sdw: Add support for SKU 0B13 product
      ASoC: Intel: soc-acpi: add SKU 0B13 SoundWire configuration
      ASoC: Intel: sof_sdw: Add support for SKU 0B29 product
      ASoC: Intel: soc-acpi: add SKU 0B29 SoundWire configuration
      ASoC: Intel: sof_sdw: Add support for SKU 0B12 product

Guangbin Huang (1):
      net: hns3: fix VF RSS failed problem after PF enable multi-TCs

Guenter Roeck (3):
      arch: Add generic Kconfig option indicating page size smaller than 64=
k
      fs: ntfs: Limit NTFS_RW to page sizes smaller than 64k
      vmxnet3: Use generic Kconfig option for page size limit

Guo DaXing (1):
      net/smc: Fix loop in smc_listen

Hans Verkuil (1):
      media: cec: copy sequence field for the reply

Hans de Goede (2):
      media: videobuf2-dma-sg: Fix buf->vb NULL pointer dereference
      HID: input: Fix parsing of HID_CP_CONSUMER_CONTROL fields

Hao Chen (2):
      net: hns3: add check NULL address for page pool
      net: hns3: fix one incorrect value of page pool info when
queried by debugfs

Hector Martin (2):
      usb: typec: tipd: Fix typo in cd321x_switch_power_state
      usb: typec: tipd: Fix initialization sequence for cd321x

Heiner Kallweit (2):
      r8169: fix incorrect mac address assignment
      lan743x: fix deadlock in lan743x_phy_link_status_change()

Helge Deller (4):
      parisc: Increase FRAME_WARN to 2048 bytes on parisc
      parisc: Provide an extru_safe() macro to extract unsigned bits
      parisc: Convert PTE lookup to use extru_safe() macro
      Revert "parisc: Fix backtrace to always include init funtion names"

Holger Assmann (1):
      net: stmmac: retain PTP clock time during SIOCSHWTSTAMP ioctls

Huang Jianan (1):
      erofs: fix deadlock when shrink erofs slab

Huang Pei (4):
      hamradio: fix macro redefine warning
      slip: fix macro redefine warning
      MIPS: loongson64: fix FTLB configuration
      MIPS: use 3-level pgtable for 64KB page size on MIPS_VA_BITS_48

Jack Yu (1):
      ASoC: rt1011: revert 'I2S Reference' to SOC_ENUM_EXT

Jakub Kicinski (10):
      selftests: tls: add helper for creating sock pairs
      selftests: tls: factor out cmsg send/receive
      selftests: tls: add tests for handling of bad records
      tls: splice_read: fix record type check
      selftests: tls: test splicing cmsgs
      tls: splice_read: fix accessing pre-processed records
      selftests: tls: test splicing decrypted records
      tls: fix replacing proto_ops
      selftests: tls: test for correct proto_ops
      ptp: fix filter names in the documentation

Jamal Hadi Salim (1):
      tc-testing: Add link for reviews with TC MAINTAINERS

James Prestwood (1):
      selftests: add arp_ndisc_evict_nocarrier to Makefile

Jarkko Nikula (1):
      i2c: i801: Fix interrupt storm from SMB_ALERT signal

Jason Gerecke (1):
      HID: wacom: Use "Confidence" flag to prevent reporting invalid contac=
ts

Jean Delvare (1):
      i2c: i801: Restore INTREN on unload

Jedrzej Jagielski (2):
      iavf: Fix deadlock occurrence during resetting VF interface
      iavf: Fix refreshing iavf adapter stats on ethtool request

Jens Axboe (2):
      block: call rq_qos_done() before ref check in batch completions
      zram: only make zram_wb_devops for CONFIG_ZRAM_WRITEBACK

Jesse Brandeburg (1):
      igb: fix netpoll exit with traffic

Jie Wang (1):
      net: hns3: fix incorrect components info of ethtool --reset command

Jing Yao (1):
      netfilter: xt_IDLETIMER: replace snprintf in show functions with
sysfs_emit

Jiri Kosina (1):
      HID: nintendo: eliminate dead datastructures in !CONFIG_NINTENDO_FF c=
ase

Jiri Olsa (1):
      tracing/uprobe: Fix uprobe_perf_open probes iteration

Joel Stanley (1):
      drm/aspeed: Fix vga_pw sysfs output

Joerg Roedel (2):
      iommu/vt-d: Remove unused PASID_DISABLED
      iommu/amd: Clarify AMD IOMMUv2 initialization messages

Johan Hovold (1):
      USB: serial: pl2303: fix GC type detection

John David Anglin (1):
      parisc: Fix extraction of hash lock bits in syscall.S

Jon Hunter (1):
      mmc: spi: Add device-tree SPI IDs

Juergen Gross (9):
      xen/privcmd: make option visible in Kconfig
      xen/pvh: add missing prototype to header
      xen: add "not_essential" flag to struct xenbus_driver
      xen: flag xen_drm_front to be not essential for system boot
      xen: flag hvc_xen to be not essential for system boot
      xen: flag pvcalls-front to be not essential for system boot
      xen: flag xen_snd_front to be not essential for system boot
      xen: make HYPERVISOR_get_debugreg() always_inline
      xen: make HYPERVISOR_set_debugreg() always_inline

Julian Wiedmann (1):
      ethtool: ioctl: fix potential NULL deref in ethtool_set_coalesce()

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix hotplug when only codec is suspended

Kamal Mostafa (1):
      io_uring: fix missed comment from *task_file rename

Karsten Graul (1):
      net/smc: Fix NULL pointer dereferencing in smc_vlan_by_tcpsk()

Klaus Jensen (1):
      nvme: fix write zeroes pi

Kumar Thangavel (1):
      net/ncsi : Add payload to be 32-bit aligned to fix dropped packets

Kuninori Morimoto (1):
      ASoC: rsnd: fixup DMAEngine API

Larry Finger (1):
      staging: r8188eu: Fix breakage introduced when 5G code was removed

Li Zhijian (2):
      selftests/tc-testing: match any qdisc type
      selftests/tc-testings: Be compatible with newer tc output

Lijo Lazar (1):
      drm/amdgpu: Skip ASPM programming on aldebaran

Linus Torvalds (1):
      Linux 5.16-rc3

Longpeng (1):
      vdpa_sim: avoid putting an uninitialized iova_domain

Lv Ruyi (1):
      optee: fix kfree NULL pointer

Maciej Fijalkowski (1):
      ice: fix vsi->txq_map sizing

Marco Elver (1):
      perf: Ignore sigtrap for tracepoints destined for other tasks

Marek Beh=C3=BAn (1):
      net: marvell: mvpp2: increase MTU limit when XDP enabled

Mark Rutland (3):
      arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
      arm64: uaccess: avoid blocking within critical sections
      sched/scs: Reset task stack state in bringup_cpu()

Marta Plantykow (1):
      ice: avoid bpf_prog refcount underflow

Martin Kepplinger (2):
      media: hi846: include property.h instead of of_graph.h
      media: hi846: remove the of_match_ptr macro

Martyn Welch (1):
      net: usb: Correct PHY handling of smsc95xx

Mathias Nyman (2):
      usb: hub: Fix usb enumeration issue due to address0 race
      usb: hub: Fix locking issues with address0_mutex

Matthew Wilcox (Oracle) (6):
      Add linux/cacheflush.h
      mm: Rename folio_test_multi to folio_test_large
      mm: Remove folio_test_single
      fs: Remove FS_THP_SUPPORT
      fs: Rename AS_THP_SUPPORT and mapping_thp_support
      mm: Add functions to zero portions of a folio

Maurizio Lombardi (6):
      nvmet-tcp: fix a race condition between release_queue and io_work
      nvmet-tcp: add an helper to free the cmd buffers
      nvmet-tcp: fix memory leak when performing a controller reset
      nvme-tcp: fix memory leak when freeing a queue
      nvme-fabrics: ignore invalid fast_io_fail_tmo values
      nvmet: use IOCB_NOWAIT only if the filesystem supports it

Michael Kelley (1):
      firmware: smccc: Fix check for ARCH_SOC_ID not implemented

Michael S. Tsirkin (5):
      vsock/virtio: suppress used length validation
      Revert "virtio-scsi: don't let virtio core to validate used buffer le=
ngth"
      Revert "virtio-blk: don't let virtio core to validate used length"
      Revert "virtio-net: don't let virtio core to validate used length"
      Revert "virtio_ring: validate used buffer length"

Michael Straube (1):
      staging: r8188eu: use GFP_ATOMIC under spinlock

Michael Zaidman (1):
      HID: ft260: fix i2c probing for hwmon devices

Mike Christie (2):
      scsi: target: core: Use RCU helpers for INQUIRY t10_alua_tg_pt_gp
      scsi: core: sysfs: Fix setting device state to SDEV_RUNNING

Miklos Szeredi (1):
      fuse: release pipe buf after last use

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix ISOC flow for elapsed frames

Ming Lei (1):
      block: avoid to touch unloaded module instance when opening bdev

Mingjie Zhang (1):
      USB: serial: option: add Fibocom FM101-GL variants

Miquel Raynal (1):
      docs: i2c: smbus-protocol: mention the repeated start condition

Mohammed Gamal (1):
      drm/hyperv: Fix device removal on Gen1 VMs

Muchun Song (1):
      locking/rwsem: Optimize down_read_trylock() under highly contended ca=
se

Nadav Amit (2):
      hugetlbfs: flush TLBs correctly after huge_pmd_unshare
      hugetlbfs: flush before unlock on move_hugetlb_page_tables()

Namjae Jeon (3):
      ksmbd: downgrade addition info error msg to debug in smb2_get_info_se=
c()
      ksmbd: contain default data stream even if xattr is empty
      ksmbd: fix memleak in get_file_stream_info()

Nathan Chancellor (1):
      usb: dwc2: hcd_queue: Fix use of floating point literal

NeilBrown (1):
      SUNRPC: use different lock keys for INET6 and LOCAL

Nicholas Kazlauskas (3):
      drm/amd/display: Fix DPIA outbox timeout after GPU reset
      drm/amd/display: Set plane update flags for all planes in reset
      drm/amd/display: Reset link encoder assignments for GPU reset

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Prevent POWER7/8 TLB flush flushing SLB

Nicolas Iooss (1):
      net: ax88796c: do not receive data in pointer

Nikolay Aleksandrov (4):
      net: ipv6: add fib6_nh_release_dsts stub
      net: nexthop: release IPv6 per-cpu dsts when replacing a nexthop grou=
p
      selftests: net: fib_nexthops: add test for group refcount imbalance b=
ug
      net: nexthop: fix null pointer dereference when IPv6 is not enabled

Nishanth Menon (1):
      MAINTAINERS: Update maintainer entry for keystone platforms

Nitesh B Venkatesh (1):
      iavf: Prevent changing static ITR values if adaptive moderation is on

Noralf Tr=C3=B8nnes (1):
      staging/fbtft: Fix backlight

Oleksij Rempel (1):
      net: dsa: microchip: implement multi-bridge support

Olga Kornievskaia (1):
      NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION

Olivier Moysan (1):
      ASoC: stm32: i2s: fix 32 bits channel length without mclk

Ondrej Jirman (1):
      usb: typec: fusb302: Fix masking of comparator and bc_lvl interrupts

Ondrej Mosnacek (1):
      selinux: fix NULL-pointer dereference when hashtab allocation fails

Ondrej Zary (1):
      HID: multitouch: Fix Iiyama ProLite T1931SAW (0eef:0001 again!)

Paolo Abeni (1):
      mptcp: use delegate action to schedule 3rd ack retrans

Paul Cercueil (1):
      MIPS: boot/compressed/: add __ashldi3 to target for ZSTD compression

Pavel Begunkov (3):
      io_uring: correct link-list traversal locking
      io_uring: fail cancellation for EXITING tasks
      io_uring: fix link traversal locking

Peng Fan (1):
      firmware: arm_scmi: pm: Propagate return value to caller

Peter Ujfalusi (1):
      ASoC: SOF:control: Fix variable type in snd_sof_refresh_control()

Phil Sutter (2):
      selftests: nft_nat: Improve port shadow test stability
      selftests: nft_nat: Simplify port shadow notrack test

Philip Yang (6):
      drm/amdgpu: IH process reset count when restart
      drm/amdkfd: process exit and retry fault race
      drm/amdkfd: handle VMA remove race
      drm/amdkfd: simplify drain retry fault
      drm/amdgpu: enable Navi 48-bit IH timestamp counter
      drm/amdgpu: enable Navi retry fault wptr overflow

Pierre-Louis Bossart (1):
      ALSA: intel-dsp-config: add quirk for JSL devices based on ES8336 cod=
ec

Pingfan Liu (1):
      arm64: mm: Fix VM_BUG_ON(mm !=3D &init_mm) for trans_pgd

Qu Wenruo (1):
      btrfs: fix the memory leak caused in lzo_compress_pages()

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Fix active mode offline/online EPP handling
      ACPI: CPPC: Add NULL pointer check to cppc_get_perf()

Rob Herring (1):
      staging: Remove Netlogic XLP network driver

Robert Marko (1):
      net: dsa: qca8k: fix MTU calculation

Russell King (Oracle) (2):
      net: phylink: Force link down and retrigger resolve on interface chan=
ge
      net: phylink: Force retrigger in case of latched link-fail indicator

Sakari Ailus (2):
      ACPI: Get acpi_device's parent from the parent field
      ACPI: Make acpi_node_get_parent() local

Salvatore Bonaccorso (1):
      docs: filesystem: cifs: ksmbd: Fix small layout issues

Shin'ichiro Kawasaki (1):
      scsi: scsi_debug: Zero clear zones at reset write pointer

Shyam Prasad N (2):
      cifs: nosharesock should be set on new server
      cifs: populate server_hostname for extra channels

Simon Trimmer (1):
      ASoC: wm_adsp: wm_adsp_control_add() error: uninitialized symbol 'ret=
'

Sreekanth Reddy (3):
      scsi: mpt3sas: Fix kernel panic during drive powercycle test
      scsi: mpt3sas: Fix system going into read-only mode
      scsi: mpt3sas: Fix incorrect system timestamp

Srinivas Kandagatla (8):
      ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
      ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
      ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
      ASoC: qdsp6: q6adm: improve error reporting
      ASoC: qdsp6: q6routing: validate port id before setting up route
      ASoC: codecs: wcd938x: fix volatile register range
      ASoC: codecs: wcd934x: return error code correctly from hw_params
      ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: ITMT support for overclocked system

Stefano Garzarella (2):
      vhost/vsock: fix incorrect used length reported to the guest
      vhost/vsock: cleanup removing `len` variable

Stefano Stabellini (2):
      xen: don't continue xenstore initialization in case of errors
      xen: detect uninitialized xenbus in xenbus_init

Steve French (2):
      smb2: clarify rc initialization in smb2_reconnect
      cifs: update internal version number

Steven Rostedt (VMware) (3):
      tracing: Check pid filtering when creating events
      tracing: Fix pid filtering when triggers are attached
      tracing: Test the 'Do not trace this pid' case in create event

Sugaya Taichi (1):
      MAINTAINERS: Add entry to MAINTAINERS for Milbeaut

Takashi Iwai (9):
      ASoC: DAPM: Cover regression by kctl change notification fix
      ALSA: cmipci: Drop stale variable assignment
      ASoC: topology: Add missing rwsem around snd_ctl_remove() calls
      staging: greybus: Add missing rwsem around snd_ctl_remove() calls
      ALSA: hda/realtek: Fix LED on HP ProBook 435 G7
      ALSA: ctxfi: Fix out-of-range access
      ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
      ALSA: usb-audio: Switch back to non-latency mode at a later point
      ALSA: usb-audio: Don't start stream for capture at prepare

Tejas Upadhyay (1):
      drm/i915/gt: Hold RPM wakelock during PXP suspend

Thadeu Lima de Souza Cascardo (1):
      nfc: virtual_ncidev: change default device permissions

Thiago Rafael Becker (1):
      sunrpc: fix header include guard in trace header

Thinh Nguyen (3):
      usb: dwc3: core: Revise GHWPARAMS9 offset
      usb: dwc3: gadget: Ignore NoStream after End Transfer
      usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer

Thomas Wei=C3=9Fschuh (8):
      HID: intel-ish-hid: add support for MODULE_DEVICE_TABLE()
      HID: intel-ish-hid: use constants for modaliases
      HID: intel-ish-hid: fw-loader: only load for matching devices
      HID: intel-ish-hid: hid-client: only load for matching devices
      platform/chrome: chros_ec_ishtp: only load for matching devices
      platform/x86: isthp_eclite: only load for matching devices
      mod_devicetable: fix kdocs for ishtp_device_id
      HID: input: set usage type to key on keycode remap

Thomas Zeitlhofer (1):
      PM: hibernate: use correct mode for swsusp_close()

Tiezhu Yang (1):
      MIPS: Fix using smp_processor_id() in preemptible in show_cpuinfo()

Tim Harvey (1):
      mmc: sdhci-esdhc-imx: disable CMDQ support

Todd Kjos (1):
      binder: fix test regression due to sender_euid change

Tony Lu (3):
      net/smc: Clean up local struct sock variables
      net/smc: Ensure the active closing peer first closes clcsock
      net/smc: Don't call clcsock shutdown twice when smc shutdown

Trevor Davenport (1):
      HID: Ignore battery for Elan touchscreen on HP Envy X360 15-eu0xxx

Trond Myklebust (1):
      NFSv42: Don't fail clone() unless the OP_CLONE operation failed

Varun Prakash (2):
      nvmet-tcp: fix incomplete data digest send
      nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()

Vihas Mak (1):
      HID: thrustmaster: fix sparse warnings

Vincent Guittot (1):
      firmware: arm_scmi: Fix base agent discover response

Vincent Whitchurch (2):
      af_unix: fix regression in read after shutdown
      i2c: virtio: disable timeout handling

Vin=C3=ADcius Angiolucci Reis (1):
      Revert "HID: hid-asus.c: Maps key 0x35 (display off) to KEY_SCREENLOC=
K"

Vladimir Oltean (5):
      net: mscc: ocelot: don't downgrade timestamping RX filters in
SIOCSHWTSTAMP
      net: mscc: ocelot: create a function that replaces an existing VCAP f=
ilter
      net: ptp: add a definition for the UDP port for IEEE 1588 general mes=
sages
      net: mscc: ocelot: set up traps for PTP packets
      net: mscc: ocelot: correctly report the timestamping RX filters in et=
htool

Volodymyr Mytnyk (2):
      net: marvell: prestera: fix brige port operation
      net: marvell: prestera: fix double free issue on err path

Waiman Long (1):
      locking/rwsem: Make handoff bit handling more consistent

Wan Jiabing (1):
      netfilter: nft_payload: Remove duplicated include in nft_payload.c

Wen Gu (1):
      net/smc: Avoid warning of possible recursive locking

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for ASRock NUC Box 1100

Will Mortensen (1):
      netfilter: flowtable: fix IPv6 tunnel addr match

Wu Zongyong (1):
      vhost-vdpa: clean irqs before reseting vdpa device

Yang Guang (1):
      block: fix parameter not described warning

Yang Wang (1):
      drm/amdgpu: fix byteorder error in amdgpu discovery

Yang Xu (1):
      xfs: Fix the free logic of state in xfs_attr_node_hasname

Yannick Vignon (1):
      net: stmmac: Disable Tx queues when reconfiguring the interface

Ye Bin (2):
      io_uring: fix soft lockup when call __io_remove_buffers
      io_uring: Fix undefined-behaviour in io_issue_sqe

Ye Guojin (2):
      scsi: ufs: ufs-mediatek: Add put_device() after of_find_device_by_nod=
e()
      virtio-blk: modify the value type of num in virtio_queue_rq()

Yi-Ling Chen (1):
      drm/amd/display: Fixed DSC would not PG after removing DSC stream

Yong Wu (1):
      memory: mtk-smi: Fix a null dereference for the ostd

Zekun Shen (2):
      atlantic: fix double-free in aq_ring_tx_clean
      stmmac_pci: Fix underflow size in stmmac_rx

Zheyu Ma (1):
      net: chelsio: cxgb4vf: Fix an error code in cxgb4vf_pci_probe()

Ziyang Xuan (1):
      net: vlan: fix underflow for the real_dev refcnt

shaoyunl (1):
      drm/amdgpu: move kfd post_reset out of reset_sriov function

xinhui pan (1):
      drm/amdgpu: Fix double free of dmabuf

yangxingwu (1):
      netfilter: ipvs: Fix reuse connection if RS weight is 0

zhangyue (1):
      net: qed: fix the array may be out of bound
