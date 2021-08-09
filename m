Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0D3E4883
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhHIPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234437AbhHIPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91FEE60EBB;
        Mon,  9 Aug 2021 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628522228;
        bh=BAVtUqdGTwqHDa+yvqPzEHUaBkygZbsoONnsx/LNpFc=;
        h=Subject:From:To:Date:From;
        b=RQ0w2N/nP/GIlSPoTpqoAJ/LdcyBMg2G53iQhcuKO13LnePfB7j4H7bg0RpfaC/oG
         S8cn27PlSwcyi6Xe84mc6Lx5e4HsyxsYPWSTzQE6o+bWBxDnd3o+4iRH7ayY3YPGXx
         YCeV4wgmZkfDKty2sbOkd2azU7dISqIio66yqpFOF0h/qH4s1/9IT8vEkCyFFMfveb
         U7t8Cf/AI29WC182inSw+R94hUyzlIGh1NgNmubIBvUAVPyX/X7QB/uoA4hqxnz98t
         rJreV87tFsVcjdTmhIT1En40lefBxE22+pKzn1oM6deEOXn2n+Gjl1PBv6/nT4SsaD
         cfQl5/BFsoGMQ==
Message-ID: <79b45d1c784a9dedd08b66e55fecaca46a9878d6.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.138-rt62
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 09 Aug 2021 10:17:06 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.138-rt62 stable release.

This release is just an update to the new stable 5.4.138
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 16059655875e5e4cc3af5f490c7a151495092ef0

Or to build 5.4.138-rt62 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.138.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.138-rt62.patch.xz

Enjoy!

   Tom

Changes from v5.4.129-rt61:
---

Al Cooper (1):
      mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode

Al Viro (2):
      copy_page_to_iter(): fix ITER_DISCARD case
      iov_iter_fault_in_readable() should do nothing in xarray case

Alain Volmat (1):
      spi: stm32: fixes pm_runtime calls in probe/remove

Aleksandr Loktionov (1):
      igb: Check if num of q_vectors is smaller than max before array access

Alex Williamson (1):
      vfio/pci: Handle concurrent vma faults

Alexander Aring (2):
      fs: dlm: cancel work sync othercon
      fs: dlm: fix memory leak when fenced

Alexander Egorenkov (1):
      s390/boot: fix use of expolines in the DMA code

Alexander Larkin (1):
      Input: joydev - prevent use of not validated data in JSIOCSBTNMAP ioctl

Alexander Ovechkin (1):
      net: send SYNACK packet with accepted fwmark

Alexander Shishkin (1):
      intel_th: Wait until port is in reset before programming it

Alexander Tsoy (1):
      ALSA: usb-audio: Add registration quirk for JBL Quantum headsets

Alexandre Torgue (5):
      ARM: dts: stm32: fix gpio-keys node on STM32 MCU boards
      ARM: dts: stm32: fix RCC node name on stm32f429 MCU
      ARM: dts: stm32: fix timer nodes on STM32 MCU to prevent warnings
      ARM: dts: stm32: fix i2c node name on stm32f746 to prevent warnings
      ARM: dts: stm32: move stmmac axi config in ethernet node on stm32mp15

Alexandru Ardelean (1):
      iio: at91-sama5d2_adc: remove usage of iio_priv_to_dev() helper

Alper Gun (1):
      KVM: SVM: Call SEV Guest Decommission if ASID binding fails

Alvin Šipraga (2):
      brcmfmac: fix setting of station info chains bitmask
      brcmfmac: correctly report average RSSI in station info

Anand Jain (1):
      btrfs: check for missing device in btrfs_trim_fs

Andrew Gabbasov (1):
      usb: gadget: f_fs: Fix setting of device and driver data cross-references

Andrey Grodzovsky (1):
      drm/sched: Avoid data corruptions

Andy Shevchenko (9):
      net: mvpp2: Put fwnode in error case during ->probe()
      net: pch_gbe: Propagate error from devm_gpio_request_one()
      staging: fbtft: Rectify GPIO handling
      backlight: lm3630a_bl: Put fwnode in error case during ->probe()
      leds: lm3532: select regmap I2C API
      leds: lm3692x: Put fwnode in any case during ->probe()
      eeprom: idt_89hpesx: Put fwnode in matching case during ->probe()
      eeprom: idt_89hpesx: Restore printing the unsupported fwnode name
      net: pch_gbe: Use proper accessors to BE data in pch_ptp_match()

Anirudh Rayabharam (2):
      ext4: fix kernel infoleak via ext4_extent_header
      media: pvrusb2: fix warning in pvr2_i2c_core_done

Anshuman Khandual (1):
      arm64/mm: Fix ttbr0 values stored in struct thread_info for software-pan

Antoine Tenart (1):
      vrf: do not push non-ND strict packets with a source LLA through packet taps again

Ard Biesheuvel (1):
      crypto: shash - avoid comparing pointers to exported functions under CFI

Arkadiusz Kubalewski (2):
      i40e: Fix logic of disabling queues
      i40e: Fix firmware LLDP agent related warning

Arnaldo Carvalho de Melo (2):
      perf llvm: Return -ENOMEM when asprintf() fails
      Revert "perf map: Fix dso->nsinfo refcounting"

Arnd Bergmann (4):
      ia64: mca_drv: fix incorrect array size calculation
      mwifiex: re-fix for unaligned accesses
      media: subdev: disallow ioctl for saa6588/davinci
      mips: always link byteswap helpers into decompressor

Arturo Giusti (1):
      udf: Fix NULL pointer dereference in udf_symlink function

Aswath Govindraju (2):
      ARM: dts: am335x: align ti,pindir-d0-out-d1-in property with dt-shema
      ARM: dts: am437x: align ti,pindir-d0-out-d1-in property with dt-shema

Athira Rajeev (1):
      selftests/powerpc: Fix "no_handler" EBB selftest

Axel Lin (4):
      regulator: da9052: Ensure enough delay time for .set_voltage_time_sel
      regulator: hi655x: Fix pass wrong pointer to config.driver_data
      regulator: hi6421: Use correct variable type for regmap api val argument
      regulator: hi6421: Fix getting wrong drvdata

Bailey Forrest (1):
      gve: Fix swapped vars when fetching max queues

Bean Huo (1):
      mmc: block: Disable CMDQ on the ioctl path

Benjamin Drung (1):
      media: uvcvideo: Fix pixel format change for Elgato Cam Link 4K

Benjamin Gaignard (1):
      ARM: dts: rockchip: Fix IOMMU nodes properties on rk322x

Benjamin Herrenschmidt (1):
      powerpc/boot: Fixup device-tree on little endian

Bibo Mao (1):
      hugetlb: clear huge pte during flush function on mips platform

Bixuan Cui (4):
      crypto: nx - add missing MODULE_DEVICE_TABLE
      EDAC/ti: Add missing MODULE_DEVICE_TABLE
      power: reset: gpio-poweroff: add missing MODULE_DEVICE_TABLE
      rtc: mxc_v2: add missing MODULE_DEVICE_TABLE

Bob Pearson (1):
      RDMA/rxe: Fix qp reference counting for atomic ops

Boqun Feng (2):
      locking/lockdep: Fix the dep path printing for backwards BFS
      lockding/lockdep: Avoid to find wrong lock dep path in check_irq_usage()

Boris Sukholitko (1):
      net/sched: act_vlan: Fix modify to allow 0

Bryan O'Donoghue (1):
      wcn36xx: Move hal_buf allocation to devm_kmalloc in probe

Casey Chen (1):
      nvme-pci: do not call nvme_dev_remove_admin from nvme_remove

Chandrakanth Patil (2):
      scsi: megaraid_sas: Fix resource leak in case of probe failure
      scsi: megaraid_sas: Handle missing interrupts while re-enabling IRQs

Chang S. Bae (1):
      x86/signal: Detect and prevent an alternate signal stack overflow

Chao Yu (1):
      f2fs: add MODULE_SOFTDEP to ensure crc32 is included in the initramfs

Charles Baylis (1):
      drm: Return -ENOTTY for non-drm ioctls

Charles Keepax (1):
      spi: Make of_register_spi_device also set the fwnode

Chris Chiu (1):
      ACPI: EC: Make more Asus laptops use ECDT _GPE

Christian Brauner (1):
      cgroup: verify that source is a string

Christian König (1):
      drm/nouveau: fix dma_address check for CPU/GPU sync

Christian Löhle (1):
      mmc: core: Allow UHS-I voltage switch for SDSC cards if supported

Christoph Hellwig (3):
      nvme: set the PRACT bit when using Write Zeroes with T10 PI
      iomap: remove the length variable in iomap_seek_data
      iomap: remove the length variable in iomap_seek_hole

Christoph Niedermaier (3):
      ARM: dts: imx6q-dhcom: Fix ethernet reset time properties
      ARM: dts: imx6q-dhcom: Fix ethernet plugin detection problems
      ARM: dts: imx6q-dhcom: Add gpios pinctrl for i2c bus recovery

Christophe JAILLET (20):
      crypto: ccp - Fix a resource leak in an error handling path
      media: rc: i2c: Fix an error message
      video: fbdev: imxfb: Fix an error message
      brcmsmac: mac80211_if: Fix a resource leak in an error handling path
      tty: nozomi: Fix a resource leak in an error handling function
      firmware: stratix10-svc: Fix a resource leak in an error handling path
      tty: nozomi: Fix the error handling path of 'nozomi_card_init()'
      ASoC: mediatek: mtk-btcvsd: Fix an error handling path in 'mtk_btcvsd_snd_probe()'
      phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe()
      leds: ktd2692: Fix an error handling path
      nvmem: core: add a missing of_node_put
      tty: serial: 8250: serial_cs: Fix a memory leak in error handling path
      scsi: be2iscsi: Fix an error handling path in beiscsi_dev_probe()
      ixgbe: Fix an error handling path in 'ixgbe_probe()'
      igc: Fix an error handling path in 'igc_probe()'
      igb: Fix an error handling path in 'igb_probe()'
      fm10k: Fix an error handling path in 'fm10k_probe()'
      e1000e: Fix an error handling path in 'e1000_probe()'
      iavf: Fix an error handling path in 'iavf_probe()'
      gve: Fix an error handling path in 'gve_probe()'

Christophe Leroy (2):
      btrfs: disable build on platforms having page size 256K
      powerpc/mm: Fix lockup on kernel exec fault

Chung-Chiang Cheng (1):
      configfs: fix memleak in configfs_release_bin_file

Clark Wang (1):
      spi: imx: add a check for speed_hz before calculating the clock

Clément Lassieur (1):
      usb: dwc2: Don't reset the core after setting turnaround time

Codrin Ciubotariu (1):
      ASoC: atmel-i2s: Fix usage of capture and playback at the same time

Colin Ian King (5):
      drm: qxl: ensure surf.data is ininitialized
      fsi: core: Fix return of error values on failures
      scsi: aic7xxx: Fix unintentional sign extension issue on left shift of u8
      liquidio: Fix unintentional sign extension issue on left shift of u16
      s390/bpf: Perform r1 range checking before accessing jit->seen_reg[r1]

Cong Wang (1):
      net_sched: check error pointer in tcf_dump_walker()

Corentin Labbe (5):
      crypto: ixp4xx - dma_unmap the correct address
      mtd: partitions: redboot: seek fis-index-block in the right node
      ARM: dts: gemini-rut1xx: remove duplicate ethernet node
      ARM: dts: gemini: rename mdio to the right name
      ARM: dts: gemini: add device_type on pci

Cristian Ciocaltea (3):
      clk: actions: Fix UART clock dividers on Owl S500 SoC
      clk: actions: Fix SD clocks factor table on Owl S500 SoC
      clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC

Cristian Marussi (2):
      firmware: arm_scmi: Reset Rx buffer to max size during async commands
      firmware: arm_scmi: Fix range check for the maximum number of pending messages

Daehwan Jung (1):
      ALSA: usb-audio: fix rate on Ozone Z90 USB headset

Dan Carpenter (8):
      media: au0828: fix a NULL vs IS_ERR() check
      ocfs2: fix snprintf() checking
      staging: gdm724x: check for buffer overflow in gdm_lte_multi_sdu_pkt()
      staging: gdm724x: check for overflow in gdm_lte_netif_rx()
      drm/vc4: fix argument ordering in vc4_crtc_get_margins()
      rtc: fix snprintf() checking in is_rtc_hctosys()
      scsi: scsi_dh_alua: Fix signedness bug in alua_rtpg()
      can: hi311x: fix a signedness bug in hi3110_cmd()

Daniel Borkmann (1):
      bpf: Fix up register-based shifts in interpreter to silence KUBSAN

Daniel Mack (1):
      serial: tty: uartlite: fix console setup

Daniel Rosenberg (1):
      f2fs: Show casefolding support only when supported

Daniel Vetter (3):
      drm/tegra: Don't set allow_fb_modifiers explicitly
      drm/msm/mdp4: Fix modifier support enabling
      drm/arm/malidp: Always list modifiers

Dany Madden (1):
      Revert "ibmvnic: remove duplicate napi_schedule call in open function"

Dave Hansen (1):
      selftests/vm/pkeys: fix alloc_random_pkey() to make it really, really random

David Howells (1):
      afs: Fix tracepoint string placement with built-in AFS

David Rientjes (1):
      KVM: SVM: Periodically schedule when unregistering regions on destroy

David Sterba (3):
      btrfs: clear defrag status of a root if starting transaction fails
      btrfs: clear log tree recovering status if starting transaction fails
      btrfs: compression: don't try to compress if we don't have enough pages

Desmond Cheong Zhi Xi (5):
      ntfs: fix validity check for file name attribute
      hfs: add missing clean-up in hfs_fill_super
      hfs: fix high memory mapping in hfs_bnode_read
      hfs: add lock nesting notation to hfs_find_init
      btrfs: fix rw device counting in __btrfs_free_extra_devids

Dillon Min (1):
      media: s5p-g2d: Fix a memory leak on ctx->fh.m2m_ctx

Dima Chumak (1):
      net/mlx5e: Fix nullptr in mlx5e_hairpin_get_mdev()

Dimitri John Ledkov (1):
      lib/decompress_unlz4.c: correctly handle zero-padding around initrds.

Dinghao Liu (1):
      i40e: Fix error handling in i40e_vsi_open

Dmitry Bogdanov (1):
      scsi: target: Fix protect handling in WRITE SAME(32)

Dmitry Osipenko (2):
      clk: tegra: Ensure that PLLU configuration is applied properly
      ASoC: tegra: Set driver_name=tegra for all machine drivers

Dmitry Torokhov (2):
      HID: do not use down_interruptible() when unbinding devices
      i2c: core: Disable client irq on reboot/shutdown

Dmytro Laktyushkin (1):
      drm/amd/display: fix use_max_lb flag for 420 pixel formats

Dongliang Mu (3):
      media: dvd_usb: memory leak in cinergyt2_fe_attach
      ieee802154: hwsim: Fix possible memory leak in hwsim_subscribe_all_others
      ieee802154: hwsim: Fix memory leak in hwsim_add_one

Doug Berger (1):
      net: bcmgenet: ensure EXT_ENERGY_DET_MASK is clear

Dwaipayan Ray (1):
      ACPI: Use DEVICE_ATTR_<RW|RO|WO> macros

Eddie James (2):
      fsi: scom: Reset the FSI2PIB engine for any error
      fsi: occ: Don't accept response from un-initialized OCC

Elaine Zhang (5):
      ARM: dts: rockchip: Fix power-controller node names for rk3066a
      ARM: dts: rockchip: Fix power-controller node names for rk3188
      ARM: dts: rockchip: Fix power-controller node names for rk3288
      arm64: dts: rockchip: Fix power-controller node names for px30
      arm64: dts: rockchip: Fix power-controller node names for rk3328

Elia Devito (1):
      ALSA: hda/realtek: Improve fixup for HP Spectre x360 15-df0xxx

Eric Biggers (1):
      fscrypt: don't ignore minor_hash when hash is 0

Eric Dumazet (10):
      pkt_sched: sch_qfq: fix qfq_change_class() error path
      vxlan: add missing rcu_read_lock() in neigh_reduce()
      ieee802154: hwsim: avoid possible crash in hwsim_del_edge_nl()
      ipv6: exthdrs: do not blindly use init_net
      ipv6: fix out-of-bound access in ip6_parse_tlv()
      tcp: annotate data races around tp->mtu_info
      ipv6: tcp: drop silly ICMPv6 packet too big messages
      udp: annotate data races around unix_sk(sk)->gso_size
      net/tcp_fastopen: fix data races around tfo_active_disable_stamp
      net: annotate data race around sk_ll_usec

Eric Sandeen (1):
      seq_file: disallow extremely large seq buffer allocations

Erik Kaneda (1):
      ACPICA: Fix memory leak caused by _CID repair function

Evan Quan (1):
      PCI: Mark AMD Navi14 GPU ATS as broken

Evgeny Novikov (1):
      media: st-hva: Fix potential NULL pointer dereferences

Ezequiel Garcia (1):
      ARM: dts: rockchip: Fix the timer clocks order

Fabio Aiuto (1):
      staging: rtl8723bs: fix macro value for 2.4Ghz only device

Felix Fietkau (2):
      mac80211: remove iwlwifi specific workaround that broke sta NDP tx
      mt76: mt7615: fix fixed-rate tx status reporting

Ferry Toth (1):
      extcon: intel-mrfld: Sync hardware and software state on init

Filipe Manana (1):
      btrfs: send: fix invalid path for unlink operations after parent orphanization

Florian Fainelli (1):
      net: bcmgenet: Ensure all TX/RX queues DMAs are disabled

Florian Westphal (1):
      netfilter: conntrack: adjust stop timestamp to real expiry value

Frederic Weisbecker (1):
      srcu: Fix broken node geometry after early ssp init

Gao Xiang (2):
      MIPS: fix "mipsel-linux-ld: decompress.c:undefined reference to `memmove'"
      nfs: fix acl memory leak of posix_acl_create()

Gary Lin (1):
      bpfilter: Specify the log level for the kmsg message

Geert Uytterhoeven (4):
      pinctrl: renesas: r8a7796: Add missing bias for PRESET# pin
      pinctrl: renesas: r8a77990: JTAG pins do not have pull-down capabilities
      of: Fix truncation of memory sizes on 32-bit platforms
      ARM: dts: r8a7779, marzen: Fix DU clock names

Geoff Levand (1):
      powerpc/ps3: Add dma_mask to ps3_dma_region

Geoffrey D. Bennett (4):
      ALSA: usb-audio: scarlett2: Fix 18i8 Gen 2 PCM Input count
      ALSA: usb-audio: scarlett2: Fix data_mutex lock
      ALSA: usb-audio: scarlett2: Fix scarlett2_*_ctl_put() return values
      ALSA: usb-audio: scarlett2: Fix 6i6 Gen 2 line out descriptions

Gerd Rausch (1):
      RDMA/cma: Fix rdma_resolve_route() memory leak

Gilad Naaman (1):
      net: Set true network header for ECN decapsulation

Goldwyn Rodrigues (1):
      btrfs: mark compressed range uptodate only if all bio succeed

Greg Kroah-Hartman (10):
      Linux 5.4.131
      Linux 5.4.132
      Linux 5.4.133
      Linux 5.4.134
      Linux 5.4.135
      nds32: fix up stack guard gap
      Linux 5.4.136
      selftest: fix build error in tools/testing/selftests/vm/userfaultfd.c
      Linux 5.4.137
      Linux 5.4.138

Grygorii Strashko (2):
      ARM: dts: am57xx-cl-som-am57x: fix ti,no-reset-on-init flag for gpios
      ARM: dts: am437x-gp-evm: fix ti,no-reset-on-init flag for gpios

Gu Shengxian (1):
      bpftool: Properly close va_list 'ap' by va_end() on error

Guchun Chen (1):
      drm/amd/display: fix incorrrect valid irq check

Guenter Roeck (4):
      hwmon: (max31790) Report correct current pwm duty cycles
      hwmon: (max31790) Fix pwmX_enable attributes
      hwmon: (max31722) Remove non-standard ACPI device IDs
      hwmon: (max31790) Fix fan speed reporting for fan7..12

Gustavo A. R. Silva (3):
      media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2()
      wireless: wext-spy: Fix out-of-bounds warning
      media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf()

Haiyang Zhang (1):
      PCI: hv: Add check for hyperv_initialized in init_hv_pci_drv()

Hangbin Liu (3):
      net: ip_tunnel: fix mtu calculation for ETHER tunnel devices
      selftests: icmp_redirect: remove from checking for IPv6 route get
      selftests: icmp_redirect: IPv6 PMTU info should be cleared after redirect

Hanjun Guo (1):
      ACPI: bus: Call kobject_put() in acpi_init() error path

Hannes Reinecke (2):
      nvmet-fc: do not check for invalid target port in nvmet_fc_handle_fcp_rqst()
      scsi: scsi_dh_alua: Check for negative result value

Hannu Hartikainen (1):
      USB: cdc-acm: blacklist Heimann USB Appset device

Hans Verkuil (1):
      media: cobalt: fix race condition in setting HPD

Hans de Goede (1):
      ACPI: video: Add quirk for the Dell Vostro 3350

Haoran Luo (1):
      tracing: Fix bug in rb_per_cpu_empty() that might cause deadloop.

Harry Wentland (1):
      drm/amd/display: Reject non-zero src_y and src_x for video planes

Heiko Carstens (7):
      s390/stack: fix possible register corruption with stack switch helper
      KVM: s390: get rid of register asm usage
      s390/processor: always inline stap() and __load_psw_mask()
      s390/ipl_parm: fix program check new psw handling
      s390/mem_detect: fix diag260() program check new psw handling
      s390/mem_detect: fix tprot() program check new psw handling
      s390: introduce proper type handling call_on_stack() macro

Heiner Kallweit (1):
      r8169: avoid link-up interrupt issue on RTL8106e if user enables ASPM

Herbert Xu (1):
      crypto: nx - Fix RCU warning in nx842_OF_upd_status

Hoang Le (1):
      tipc: fix sleeping in tipc accept routine

Hou Tao (1):
      dm btree remove: assign new_root only when removal succeeds

Hsin-Hsiung Wang (1):
      regulator: mt6358: Fix vdram2 .vsel_mask

Huang Pei (2):
      MIPS: add PMD table accounting into MIPS'pmd_alloc_one
      Revert "MIPS: add PMD table accounting into MIPS'pmd_alloc_one"

Hui Wang (2):
      ACPI: resources: Add checks for ACPI IRQ override
      Revert "ACPI: resources: Add checks for ACPI IRQ override"

Hyunchul Lee (1):
      cifs: fix the out of range assignment to bit fields in parse_server_interfaces

Ian Ray (1):
      USB: serial: cp210x: fix comments for GE CS1000

Ian Rogers (1):
      perf bench: Fix 2 memory sanitizer warnings

Igor Matheus Andrade Torrente (1):
      media: em28xx: Fix possible memory leak of em28xx struct

Ilya Dryomov (2):
      rbd: don't hold lock_rwsem while running_list is being drained
      rbd: always kick acquire on "acquired" and "released" notifications

Jack Xu (2):
      crypto: qat - check return code of qat_hal_rd_rel_reg()
      crypto: qat - remove unused macro in FW loader

Jack Zhang (1):
      drm/amd/amdgpu/sriov disable all ip hw status by default

Jakub Kicinski (2):
      tls: prevent oversized sendfile() hangs by ignoring MSG_MORE
      net: ip: avoid OOM kills with large UDP sends over loopback

James Smart (2):
      scsi: lpfc: Fix "Unexpected timeout" error in direct attach topology
      scsi: lpfc: Fix crash when lpfc_sli4_hba_setup() fails to initialize the SGLs

Jan Kara (2):
      dax: fix ENOMEM handling in grab_mapping_entry()
      rq-qos: fix missed wake-ups in rq_qos_throttle try two

Jan Kiszka (2):
      watchdog: iTCO_wdt: Account for rebooting on second timeout
      x86/asm: Ensure asm/proto.h can be included stand-alone

Jason Ekstrand (1):
      dma-buf/sync_file: Don't leak fences on merge failure

Jason Gerecke (2):
      HID: wacom: Correct base usage for capacitive ExpressKey status bits
      HID: wacom: Re-enable touch by default for Cintiq 24HDT / 27QHDT

Javed Hasan (2):
      scsi: libfc: Fix array index out of bound exception
      scsi: qedf: Add check to synchronize abort and flush

Jay Fang (2):
      spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'
      spi: spi-topcliff-pch: Fix potential double free in pch_spi_process_messages()

Jedrzej Jagielski (3):
      igb: Fix position of assignment to *ring
      i40e: Fix queue-to-TC mapping on Tx
      i40e: Fix log TC creation failure when max num of queues is exceeded

Jeff Layton (1):
      ceph: remove bogus checks and WARN_ONs from ceph_set_page_dirty

Jerome Brunet (1):
      clk: meson: g12a: fix gp0 and hifi ranges

Jesse Brandeburg (2):
      e100: handle eeprom as little endian
      igb: handle vlan types with checker enabled

Jiajun Cao (1):
      ALSA: hda: Add IRQ check for platform_get_irq()

Jian Shen (2):
      net: fix mistake path for netdev_features_strings
      net: hns3: fix rx VLAN offload state inconsistent issue

Jian-Hong Pan (1):
      net: bcmgenet: Fix attaching to PYH failed on RPi 4B

Jiapeng Chong (4):
      platform/x86: toshiba_acpi: Fix missing error code in toshiba_acpi_setup_keyboard()
      RDMA/cxgb4: Fix missing error code in create_qp()
      fs/jfs: Fix missing error code in lmLogInit()
      mlx4: Fix missing error code in mlx4_load_one()

Jing Xiangfeng (3):
      usb: typec: Add the missed altmode_id_remove() in typec_register_altmode()
      drivers/perf: fix the missed ida_simple_remove() in ddr_perf_probe()
      drm/radeon: Add the missed drm_gem_object_put() in radeon_user_framebuffer_create()

Joachim Fenkes (2):
      fsi/sbefifo: Clean up correct FIFO when receiving reset request from SBE
      fsi/sbefifo: Fix reset timeout

Joe Thornber (1):
      dm space maps: don't reset space map allocation cursor when committing

Joerg Roedel (2):
      iommu/dma: Fix compile warning in 32-bit builds
      crypto: ccp - Annotate SEV Firmware file names

Johan Hovold (6):
      Input: usbtouchscreen - fix control-request directions
      media: gspca/gl860: fix zero-length control requests
      mmc: vub3000: fix control-request direction
      media: dtv5100: fix control-request directions
      media: gspca/sq905: fix control-request direction
      media: gspca/sunplus: fix zero-length control requests

Johan Jonker (3):
      ARM: dts: rockchip: fix pinctrl sleep nodename for rk3036-kylin and rk3288
      arm64: dts: rockchip: fix pinctrl sleep nodename for rk3399.dtsi
      ARM: dts: rockchip: fix supply properties in io-domains nodes

Johannes Berg (4):
      gpio: AMD8111 and TQMX86 require HAS_IOPORT_MAP
      iwlwifi: mvm: don't change band on bound PHY contexts
      iwlwifi: pcie: free IML DMA memory allocation
      iwlwifi: pcie: fix context info freeing

John Fastabend (1):
      bpf, sockmap, tcp: sk_prot needs inuse_idx set for proc stats

John Garry (1):
      scsi: core: Cap scsi_host cmd_per_lun at can_queue

John Keeping (1):
      USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee stick

Jonathan Cameron (31):
      iio: accel: bma180: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: bma220: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: hid: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: kxcjk-1013: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read calls
      iio: accel: mxc4005: Fix overread of data and alignment issue.
      iio: accel: stk8312: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: stk8ba50: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads1015: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: vf610: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: gyro: bmg160: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: humidity: am2315: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: srf08: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: pulsed-light: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: as3935: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: hmc5843: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: bmc150: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: isl29125: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3414: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3472: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: cros_ec_sensors: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: potentiostat: lmp91000: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: adc: at91-sama5d2: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: hx711: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: mxs-lradc: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: magn: rm3100: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: isl29501: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: gyro: fxa21002c: Balance runtime pm + use pm_runtime_resume_and_get().
      iio: magn: bmc150: Balance runtime pm + use pm_runtime_resume_and_get()

Jonathan Neuschäfer (1):
      ARM: imx: pm-imx5: Fix references to imx5_cpu_suspend_info

Josef Bacik (2):
      btrfs: fix error handling in __btrfs_update_delayed_inode
      btrfs: abort transaction if we fail to update the delayed inode

Joseph Greathouse (1):
      drm/amdgpu: Update NV SIMD-per-CU to 2

Josh Poimboeuf (1):
      kbuild: Fix objtool dependency for 'OBJECT_FILES_NON_STANDARD_<obj> := n'

Juergen Gross (2):
      xen/events: reset active flag for lateeoi events later
      x86/kvm: fix vcpu-id indexed array sizes

Julian Sikorski (1):
      USB: usb-storage: Add LaCie Rugged USB3-FW to IGNORE_UAS

Junxiao Bi (2):
      ocfs2: fix zero out valid data
      ocfs2: issue zeroout to EOF blocks

Kai-Heng Feng (1):
      Bluetooth: Shutdown controller after workqueues are flushed or cancelled

Kamal Heib (1):
      RDMA/rxe: Fix failure during driver load

Kashyap Desai (1):
      scsi: megaraid_sas: Early detection of VD deletion through RaidMap update

Kefeng Wang (1):
      KVM: mmio: Fix use-after-free Read in kvm_vm_ioctl_unregister_coalesced_mmio

Konstantin Kharlamov (1):
      PCI: Leave Apple Thunderbolt controllers on for s2idle or standby

Krzysztof Kozlowski (12):
      mmc: sdhci-sprd: use sdhci_sprd_writew
      power: supply: max17042: Do not enforce (incorrect) interrupt trigger type
      reset: a10sr: add missing of_match_table reference
      ARM: exynos: add missing of_node_put for loop iteration
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU/XU3
      ARM: dts: exynos: fix PWM LED max brightness on Odroid HC1
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
      memory: atmel-ebi: add missing of_node_put for loop iteration
      memory: fsl_ifc: fix leak of IO mapping on probe failure
      memory: fsl_ifc: fix leak of private memory on probe failure
      rtc: max77686: Do not enforce (incorrect) interrupt trigger type
      nfc: nfcsim: fix use after free during module unload

Krzysztof Wilczyński (2):
      ACPI: sysfs: Fix a buffer overrun problem with description_show()
      PCI/sysfs: Fix dsm_label_utf16s_to_utf8s() buffer overrun

Kunihiko Hayashi (1):
      phy: uniphier-pcie: Fix updating phy parameters

Kuninori Morimoto (2):
      ASoC: rsnd: tidyup loop on rsnd_adg_clk_query()
      clk: renesas: r8a77995: Add ZA2 clock

Lai Jiangshan (1):
      KVM: X86: Disable hardware breakpoints unconditionally before kvm_x86->run()

Laurent Pinchart (1):
      media: imx: imx7_mipi_csis: Fix logging of only error event counters

Lee Gibson (1):
      wl1251: Fix possible buffer overflow in wl1251_cmd_scan

Leon Romanovsky (3):
      RDMA/core: Sanitize WQ state received from the userspace
      RDMA/mlx5: Don't add slave port to unaffiliated list
      RDMA/mlx5: Don't access NULL-cleared mpi pointer

Liguang Zhang (1):
      ACPI: AMBA: Fix resource name in /proc/iomem

Linus Walleij (3):
      power: supply: ab8500: Fix an old bug
      power: supply: ab8500: Avoid NULL pointers
      iio: accel: bma180: Use explicit member assignment

Linyu Yuan (1):
      usb: gadget: eem: fix echo command packet response issue

Liu Shixin (1):
      netlabel: Fix memory leak in netlbl_mgmt_add_common

Liwei Song (1):
      ice: set the value of global config lock timeout longer

Logan Gunthorpe (1):
      PCI/P2PDMA: Avoid pci_get_slot(), which may sleep

Long Li (1):
      block: return the correct bvec when checking for gaps

Longpeng(Mike) (1):
      vsock: notify server to shutdown when client has pending signal

Luc Van Oostenryck (1):
      kbuild: run the checker after the compiler

Lucas Stach (1):
      arm64: dts: imx8mq: assign PCIe clocks

Ludovic Desroches (1):
      ARM: dts: at91: sama5d4: fix pinctrl muxing

Luiz Augusto von Dentz (2):
      Bluetooth: mgmt: Fix slab-out-of-bounds in tlv_data_is_valid
      Bluetooth: Fix handling of HCI_LE_Advertising_Set_Terminated event

Luiz Sampaio (1):
      w1: ds2438: fixing bug that would always get page0

Lukasz Cieplicki (1):
      i40e: Add additional info to PHY type error

Lv Yunlong (4):
      media: v4l2-core: Avoid the dangling pointer in v4l2_fh_release
      media: exynos4-is: Fix a use after free in isp_video_release
      ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe
      misc/libmasm/module: Fix two use after free in ibmasm_init_one

Maciej W. Rozycki (1):
      serial: 8250: Actually allow UPF_MAGIC_MULTIPLIER baud rates

Maciej Żenczykowski (1):
      bpf: Do not change gso_size during bpf_skb_change_proto()

ManYi Li (1):
      scsi: sr: Return appropriate error code when disk is ejected

Maor Gottlieb (1):
      net/mlx5: Fix flow table chaining

Marc Kleine-Budde (1):
      iio: ltr501: mark register holding upper 8 bits of ALS_DATA{0,1} and PS_DATA as volatile, too

Marc Zyngier (1):
      firmware/efi: Tell memblock about EFI iomem reservations

Marcelo Henrique Cerri (1):
      proc: Avoid mixing integer types in mem_rw()

Marcelo Ricardo Leitner (4):
      tc-testing: fix list handling
      sctp: validate from_addr_param return
      sctp: add size validation when walking chunks
      sctp: fix return value check in __sctp_rcv_asconf_lookup

Marco De Marco (1):
      USB: serial: option: add support for u-blox LARA-R6 family

Marek Behún (7):
      leds: lm36274: cosmetic: rename lm36274_data to chip
      firmware: turris-mox-rwtm: fix reply status decoding function
      firmware: turris-mox-rwtm: report failures better
      arm64: dts: armada-3720-turris-mox: add firmware node
      net: dsa: mv88e6xxx: enable .port_set_policy() on Topaz
      net: dsa: mv88e6xxx: enable .rmu_disable() on Topaz
      net: dsa: mv88e6xxx: use correct .stats_set_histogram() on Topaz

Marek Szyprowski (1):
      extcon: max8997: Add missing modalias string

Marek Vasut (2):
      rsi: Assign beacon rate settings to the correct rate_info descriptor field
      spi: cadence: Correct initialisation of runtime PM again

Mario Limonciello (1):
      ACPI: processor idle: Fix up C-state latency if not ordered

Mark Bloch (1):
      RDMA/mlx5: Block FDB rules when not in switchdev mode

Mark Rutland (1):
      arm64: consistently use reserved_pg_dir

Mark Tomlinson (1):
      usb: max-3421: Prevent corruption of freed memory

Mark Yacoub (1):
      drm/amd/display: Verify Gamma & Degamma LUT sizes in amdgpu_dm_atomic_check

Markus Boehme (1):
      ixgbe: Fix packet corruption due to missing DMA sync

Martin Fuzzey (2):
      rtc: stm32: Fix unbalanced clk_disable_unprepare() on probe error path
      rsi: fix AP mode with WPA failure due to encrypted EAPOL

Martin Fäcknitz (1):
      MIPS: vdso: Invalid GIC access through VDSO

Masahiro Yamada (1):
      kbuild: sink stdout from cmd for silent build

Mateusz Palczewski (1):
      i40e: Fix autoneg disabling for non-10GBaseT links

Mathias Nyman (4):
      xhci: Fix lost USB 2 remote wake
      usb: hub: Disable USB 3 device initiated lpm if exit latency is too high
      usb: hub: Fix link power management max exit latency (MEL) calculations
      xhci: add xhci_get_virt_ep() helper

Matthias Maennich (1):
      kbuild: mkcompile_h: consider timestamp if KBUILD_BUILD_TIMESTAMP is set

Matti Vaittinen (1):
      extcon: extcon-max8997: Fix IRQ freeing at error path

Maurizio Lombardi (1):
      nvme-tcp: can't set sk_user_data without write_lock

Mauro Carvalho Chehab (11):
      media: mdk-mdp: fix pm_runtime_get_sync() usage count
      media: s5p: fix pm_runtime_get_sync() usage count
      media: sh_vou: fix pm_runtime_get_sync() usage count
      media: mtk-vcodec: fix PM runtime get logic
      media: s5p-jpeg: fix pm_runtime_get_sync() usage count
      media: sti/bdisp: fix pm_runtime_get_sync() usage count
      media: exynos-gsc: fix pm_runtime_get_sync() usage count
      media: sti: fix obj-$(config) targets
      media: dvb_net: avoid speculation from net slot
      media: siano: fix device register error path
      media: s5p_cec: decrement usage count if disabled

Maxim Levitsky (1):
      KVM: x86: determine if an exception has an error code only when injecting it.

Maxim Schwalm (1):
      ASoC: rt5631: Fix regcache sync errors on resume

Maxime Ripard (1):
      drm/panel: raspberrypi-touchscreen: Prevent double-free

Maximilian Luz (1):
      pinctrl/amd: Add device HID for new AMD GPIO controller

Mian Yousaf Kaukab (1):
      arm64: dts: ls208xa: remove bus-num from dspi node

Miao Wang (1):
      net/ipv4: swap flow ports when validating source

Miaohe Lin (2):
      mm/huge_memory.c: don't discard hugepage if other processes are mapping it
      mm/z3fold: fix potential memory leak in z3fold_destroy_pool()

Michael Buesch (1):
      ssb: sdio: Don't overwrite const buffer if block_write fails

Michael Chan (2):
      bnxt_en: Refresh RoCE capabilities in bnxt_ulp_probe()
      bnxt_en: Add missing check for BNXT_STATE_ABORT_ERR in bnxt_fw_rset_task()

Michael Ellerman (1):
      powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()

Michael S. Tsirkin (1):
      virtio_net: move tx vq operation under tx queue lock

Michal Suchanek (1):
      efi/tpm: Differentiate missing and invalid final event log table.

Mike Christie (5):
      scsi: iscsi: Add iscsi_cls_conn refcount helpers
      scsi: iscsi: Fix conn use after free during resets
      scsi: iscsi: Fix shost->max_id use
      scsi: qedi: Fix null ref during abort handling
      scsi: iscsi: Fix iface sysfs attr detection

Mike Kravetz (1):
      hugetlbfs: fix mount mode command line processing

Mike Marshall (1):
      orangefs: fix orangefs df output.

Miklos Szeredi (4):
      fuse: ignore PG_workingset after stealing
      fuse: check connected before queueing on fpq->io
      fuse: reject internal errno
      af_unix: fix garbage collect vs MSG_PEEK

Mikulas Patocka (1):
      dm writecache: return the exact table values that were set

Mimi Zohar (1):
      evm: fix writing <securityfs>/evm overflow

Minas Harutyunyan (2):
      usb: dwc3: Fix debugfs creation flow
      usb: dwc2: gadget: Fix sending zero length packet in DDMA mode.

Minchan Kim (1):
      selinux: use __GFP_NOWARN with GFP_NOWAIT in the AVC

Ming Lei (2):
      block: fix race between adding/removing rq qos and normal IO
      block: fix discard request merge

Mirko Vogt (1):
      spi: spi-sun6i: Fix chipselect/clock bug

Muchun Song (1):
      writeback: fix obtain a reference to a freeing memcg css

Nanyong Sun (1):
      mm: slab: fix kmem_cache_create failed when sysfs node not destroyed

Nathan Chancellor (5):
      KVM: PPC: Book3S HV: Workaround high stack usage with clang
      ACPI: bgrt: Fix CFI violation
      powerpc/barrier: Avoid collision with clang's __lwsync macro
      qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
      hexagon: use common DISCARDS macro

Nguyen Dinh Phi (2):
      netrom: Decrease sock refcount when sock timers expire
      cfg80211: Fix possible memory leak in function cfg80211_bss_update

Nicholas Piggin (5):
      powerpc: Offline CPU in stop_this_cpu()
      KVM: PPC: Book3S: Fix CONFIG_TRANSACTIONAL_MEM=n crash
      KVM: PPC: Fix kvm_arch_vcpu_ioctl vcpu_load leak
      KVM: PPC: Book3S: Fix H_RTAS rets buffer overflow
      KVM: PPC: Book3S HV Nested: Sanitise H_ENTER_NESTED TM state

Nick Desaulniers (3):
      Makefile: fix GDB warning with CONFIG_RELR
      MIPS: set mips32r5 for virt extensions
      ARM: 9087/1: kprobes: test-thumb: fix for LLVM_IAS=1

Nicolas Dichtel (1):
      ipv6: fix 'disable_policy' for fwd packets

Niklas Söderlund (1):
      thermal/drivers/rcar_gen3_thermal: Fix coefficient calculations

Nirmoy Das (1):
      drm/amdkfd: use allowed domain for vmbo validation

Nuno Sa (2):
      iio: adis_buffer: do not return ints in irq handlers
      iio: adis16400: do not return ints in irq handlers

Odin Ugedal (2):
      sched/fair: Fix ascii art by relpacing tabs
      sched/fair: Fix CFS bandwidth hrtimer expiry type

Oleksij Rempel (2):
      can: j1939: j1939_sk_init(): set SOCK_RCU_FREE to call sk_destruct() after RCU is done
      can: j1939: j1939_session_deactivate(): clarify lifetime of session object

Oliver Hartkopp (1):
      can: gw: synchronize rcu operations before removing gw job entry

Oliver Lang (2):
      iio: ltr501: ltr559: fix initialization of LTR501_ALS_CONTR
      iio: ltr501: ltr501_read_ps(): add missing endianness conversion

Ondrej Zary (2):
      serial_cs: Add Option International GSM-Ready 56K/ISDN modem
      serial_cs: remove wrong GLOBETROTTER.cis entry

Pablo Neira Ayuso (4):
      netfilter: nft_exthdr: check for IPv6 packet before further processing
      netfilter: nft_osf: check for TCP packet before further processing
      netfilter: nft_tproxy: restrict support to TCP and UDP transport protocols
      netfilter: nft_nat: allow to specify layer 4 protocol NAT only

Pali Rohár (10):
      serial: mvebu-uart: fix calculation of clock divisor
      ath9k: Fix kernel NULL pointer dereference during ath_reset_internal()
      serial: mvebu-uart: do not allow changing baudrate when uartclk is not available
      serial: mvebu-uart: correctly calculate minimal possible baudrate
      arm64: dts: marvell: armada-37xx: Fix reg for standard variant of UART
      PCI: aardvark: Fix checking for PIO Non-posted Request
      PCI: aardvark: Implement workaround for the readback value of VEND_ID
      firmware: turris-mox-rwtm: fail probing when firmware does not support hwrng
      firmware: turris-mox-rwtm: add marvell,armada-3700-rwtm-firmware compatible string
      arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi file

Pan Dong (1):
      ext4: fix avefreec in find_group_orlov

Paolo Abeni (1):
      ipv6: fix another slab-out-of-bounds in fib6_nh_flush_exceptions

Paolo Bonzini (1):
      KVM: add missing compat KVM_CLEAR_DIRTY_LOG

Pascal Terjan (1):
      rtl8xxxu: Fix device info for RTL8192EU devices

Paul Burton (2):
      tracing: Simplify & fix saved_tgids logic
      tracing: Resize tgid_map to pid_max, not PID_MAX_DEFAULT

Paul E. McKenney (2):
      clocksource: Retry clock read if long delays detected
      rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()

Paul Gortmaker (1):
      cgroup1: fix leaked context root causing sporadic NULL deref in LTP

Paul Jakma (1):
      NIU: fix incorrect error return, missed in previous revert

Paulo Alcantara (1):
      cifs: prevent NULL deref in cifs_compose_mount_options()

Pavel Skripkin (22):
      media: dvb-usb: fix wrong definition
      net: can: ems_usb: fix use-after-free in ems_usb_disconnect()
      media: cpia2: fix memory leak in cpia2_usb_probe
      net: ethernet: aeroflex: fix UAF in greth_of_remove
      net: ethernet: ezchip: fix UAF in nps_enet_remove
      net: ethernet: ezchip: fix error handling
      net: sched: fix warning in tcindex_alloc_perfect_hash
      staging: rtl8712: remove redundant check in r871xu_drv_init
      staging: rtl8712: fix memory leak in rtl871x_load_fw_cb
      reiserfs: add check for invalid 1st journal block
      media: zr364xx: fix memory leak in zr364xx_start_readpipe
      jfs: fix GPF in diFree
      net: moxa: fix UAF in moxart_mac_probe
      net: qcom/emac: fix UAF in emac_remove
      net: ti: fix UAF in tlan_remove_one
      net: fddi: fix UAF in fza_probe
      net: sched: fix memory leak in tcindex_partial_destroy_work
      can: mcba_usb_start(): add missing urb->transfer_dma initialization
      can: usb_8dev: fix memory leak
      can: ems_usb: fix memory leak
      can: esd_usb2: fix memory leak
      net: llc: fix skb_over_panic

Peilin Ye (1):
      net/sched: act_skbmod: Skip non-Ethernet packets

Peter Collingbourne (2):
      selftest: use mmap instead of posix_memalign to allocate memory
      userfaultfd: do not untag user pointers

Peter Hess (1):
      spi: mediatek: fix fifo rx mode

Peter Robinson (1):
      gpio: pca953x: Add support for the On Semi pca9655

Peter Ujfalusi (1):
      spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()

Petr Mladek (1):
      kthread_worker: fix return value when kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()

Petr Oros (1):
      Revert "be2net: disable bh with spin_lock in be_process_mcc"

Petr Pavlu (1):
      ipmi/watchdog: Stop watchdog timer when the current action is 'none'

Philipp Zabel (2):
      reset: bail if try_module_get() fails
      reset: ti-syscon: fix to_ti_syscon_reset_data macro

Pierre-Louis Bossart (1):
      ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characters

Ping-Ke Shih (1):
      mac80211: remove iwlwifi specific workaround NDPs of null_response

Po-Hsu Lin (1):
      selftests: timers: rtcpie: skip test if default RTC device does not exist

Primoz Fiser (1):
      ARM: dts: imx6: phyFLEX: Fix UART hardware flow control

Qais Yousef (3):
      sched/uclamp: Fix wrong implementation of cpu.uclamp.min
      sched/uclamp: Fix locking around cpu_util_update_eff()
      sched/uclamp: Fix uclamp_tg_restrict()

Quat Le (1):
      scsi: core: Retry I/O for Notify (Enable Spinup) Required error

Radim Pavlik (1):
      pinctrl: mcp23s08: fix race condition in irq handler

Rafael J. Wysocki (1):
      cpufreq: Make cpufreq_online() call driver->offline() on errors

Rafał Miłecki (6):
      ARM: dts: BCM5301X: Fixup SPI binding
      ARM: brcmstb: dts: fix NAND nodes names
      ARM: Cygnus: dts: fix NAND nodes names
      ARM: NSP: dts: fix NAND nodes names
      ARM: dts: BCM63xx: Fix NAND nodes names
      ARM: dts: Hurricane 2: Fix NAND nodes names

Randy Dunlap (7):
      media: I2C: change 'RST' to "RSET" to fix multiple build errors
      m68k: atari: Fix ATARI_KBD_CORE kconfig unmet dependency warning
      wireless: carl9170: fix LEDS build errors & warnings
      scsi: FlashPoint: Rename si_flags field
      s390: appldata depends on PROC_SYSCTL
      mips: disable branch profiling in boot/decompress.o
      net: hisilicon: rename CACHE_LINE_MASK to avoid redefinition

Riccardo Mancini (12):
      perf test bpf: Free obj_buf
      perf map: Fix dso->nsinfo refcounting
      perf probe: Fix dso->nsinfo refcounting
      perf env: Fix sibling_dies memory leak
      perf test session_topology: Delete session->evlist
      perf test event_update: Fix memory leak of evlist
      perf dso: Fix memory leak in dso__new_map()
      perf script: Fix memory 'threads' and 'cpus' leaks on exit
      perf lzma: Close lzma stream on exit
      perf probe-file: Delete namelist in del_events() on the error path
      perf data: Close all files in close_dir()
      perf inject: Close inject.output on exit

Richard Fitzgerald (5):
      lib: vsprintf: Fix handling of number field widths in vsscanf
      random32: Fix implicit truncation warning in prandom_seed_state()
      ACPI: tables: Add custom DSDT file as makefile prerequisite
      ASoC: cs42l42: Correct definition of CS42L42_ADC_PDN_MASK
      soundwire: stream: Fix test for DP prepare complete

Robert Hancock (2):
      clk: si5341: Avoid divide errors due to bogus register contents
      clk: si5341: Update initialization magic

Roberto Sassu (2):
      evm: Execute evm_inode_init_security() only when an HMAC key is loaded
      evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded

Robin Gong (1):
      dmaengine: fsl-qdma: check dma_set_mask return value

Robin Murphy (1):
      perf/smmuv3: Don't trample existing events with global filter

Roman Gushchin (1):
      writeback, cgroup: increment isw_nr_in_flight before grabbing an inode

Roman Li (1):
      drm/amd/display: Update scaling settings on modeset

Ruslan Bilovol (1):
      usb: gadget: f_hid: fix endianness issue with descriptors

Russ Weight (1):
      fpga: stratix10-soc: Add missing fpga_mgr_free() call

Sabrina Dubroca (1):
      xfrm: xfrm_state_mtu should return at least 1280 for ipv6

Sai Prakash Ranjan (1):
      coresight: tmc-etf: Fix global-out-of-bounds in tmc_update_etf_buffer()

Samuel Holland (1):
      clocksource/arm_arch_timer: Improve Allwinner A64 timer workaround

Sandor Bodo-Merle (2):
      PCI: iproc: Fix multi-MSI base vector number allocation
      PCI: iproc: Support multi-MSI only on uniprocessor kernel

Sanket Parmar (1):
      usb: cdns3: Enable TDL_CHK only for OUT ep

Sasha Levin (1):
      Linux 5.4.130

Sasha Neftin (2):
      e1000e: Check the PCIm state
      igc: Prefer to use the pci_release_mem_regions method

Sayanta Pattanayak (1):
      r8169: Avoid duplicate sysfs entry creation error

Sean Christopherson (2):
      KVM: nVMX: Ensure 64-bit shift when checking VMFUNC bitmap
      KVM: x86: Use guest MAXPHYADDR from CPUID.0x8000_0008 iff TDP is enabled

Sean Young (1):
      media, bpf: Do not copy more entries than user space requested

Sebastian Andrzej Siewior (1):
      net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT

Sergey Shtylyov (5):
      sata_highbank: fix deferred probing
      pata_rb532_cf: fix deferred probing
      pata_octeon_cf: avoid WARN_ON() in ata_host_activate()
      pata_ep93xx: fix deferred probing
      scsi: hisi_sas: Propagate errors in interrupt_init_v1_hw()

Sergio Paracuellos (1):
      staging: mt7621-dts: fix pci address for PCI memory range

Shahjada Abul Husain (1):
      cxgb4: fix IRQ free race during driver unload

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix the potential risk of division or modulo by zero

Shmuel Hazan (1):
      PCI: mvebu: Setup BAR0 in order to fix MSI

Shuah Khan (1):
      media: Fix Media Controller API config checks

Somnath Kotur (1):
      bnxt_en: Check abort error state in bnxt_half_open_nic()

Srikar Dronamraju (1):
      powerpc/pseries: Fix regression while building external modules

Srinath Mannam (1):
      iommu/dma: Fix IOVA reserve dma ranges

Srinivas Neeli (1):
      gpio: zynq: Check return value of pm_runtime_get_sync

Srinivas Pandruvada (1):
      thermal/drivers/int340x/processor_thermal: Fix tcc setting

Stefan Eichenberger (1):
      watchdog: imx_sc_wdt: fix pretimeout

Steffen Klassert (1):
      xfrm: Fix error reporting in xfrm_state_construct.

Stephan Gerhold (3):
      extcon: sm5502: Drop invalid register write in sm5502_reg_data
      power: supply: rt5033_battery: Fix device tree enumeration
      iio: accel: bma180: Fix BMA25x bandwidth register values

Stephane Grosjean (1):
      can: peak_pciefd: pucan_handle_status(): fix a potential starvation issue in TX path

Stephen Brennan (1):
      ext4: use ext4_grp_locked_error in mb_find_extent

Steve French (1):
      cifs: fix missing spinlock around update to ses->status

Steve Longerbeam (1):
      media: imx-csi: Skip first few frames from a BT.656 source

Steven Rostedt (VMware) (4):
      tracing/histograms: Fix parsing of "sym-offset" modifier
      tracepoint: Add tracepoint_probe_register_may_exist() for BPF tracing
      tracing: Do not reference char * as a string in histograms
      tracing/histogram: Rename "cpu" to "common_cpu"

Sudeep Holla (3):
      arm64: dts: juno: Update SCPI nodes as per the YAML schema
      firmware: arm_scmi: Fix possible scmi_linux_errmap buffer overflow
      ARM: dts: versatile: Fix up interrupt controller node names

Sukadev Bhattiprolu (1):
      ibmvnic: free tx_pool if tso_pool alloc fails

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S HV: Fix TLB management on SMT8 POWER9 and POWER10 processors

Taehee Yoo (1):
      net: validate lwtstate->data before returning from skb_tunnel_info()

Takashi Iwai (11):
      ALSA: usb-audio: Fix OOB access at proc output
      ALSA: usb-audio: scarlett2: Fix wrong resume call
      ALSA: intel8x0: Fix breakage at ac97 clock measurement
      ALSA: hda/realtek: Add another ALC236 variant support
      ALSA: hda/realtek: Fix bass speaker DAC mapping for Asus UM431D
      ALSA: hda/realtek: Apply LED fixup for HP Dragonfly G1, too
      ALSA: usx2y: Don't call free_pages_exact() with NULL address
      ALSA: sb: Fix potential double-free of CSP mixer elements
      ALSA: usb-audio: Add missing proc text entry for BESPOKEN type
      ALSA: sb: Fix potential ABBA deadlock in CSP driver
      ALSA: hdmi: Expose all pins on MSI MS-7C94 board

Takashi Sakamoto (2):
      Revert "ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro"
      ALSA: bebob: add support for ToneWeal FW66

Tao Ren (1):
      watchdog: aspeed: fix hardware timeout calculation

Tetsuo Handa (1):
      smackfs: restrict bytes count in smk_set_cipso()

Thadeu Lima de Souza Cascardo (1):
      can: bcm: delay release of struct bcm_op after synchronize_rcu()

Thierry Reding (2):
      soc/tegra: fuse: Fix Tegra234-only builds
      firmware: tegra: bpmp: Fix Tegra234-only builds

Thomas Gleixner (3):
      cpu/hotplug: Cure the cpusets trainwreck
      x86/fpu: Return proper error codes from user access functions
      x86/fpu: Limit xstate copy size in xstateregs_set()

Thomas Hebb (2):
      drm/rockchip: dsi: move all lane config except LCDC mux to bind()
      drm/rockchip: dsi: remove extra component_del() call

Thomas Zimmermann (2):
      drm/mxsfb: Don't select DRM_KMS_FB_HELPER
      drm/zte: Don't select DRM_KMS_FB_HELPER

Tian Tao (1):
      spi: omap-100k: Fix the length judgment problem

Tim Jiang (1):
      Bluetooth: btusb: fix bt fiwmare downloading failure issue for qca btsoc.

Timo Sigurdsson (1):
      ata: ahci_sunxi: Disable DIPM

Tobias Klauser (1):
      bpftool: Check malloc return value in mount_bpffs_for_pin

Tom Rix (1):
      igc: change default return of igc_read_phy_reg()

Tom Zanussi (2):
      Merge tag 'v5.4.138' into v5.4-rt
      Linux 5.4.138-rt62

Tong Tiangen (1):
      crypto: nitrox - fix unchecked variable in nitrox_register_interrupts

Tong Zhang (3):
      memstick: rtsx_usb_ms: fix UAF
      misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
      misc: alcor_pci: fix inverted branch condition

Tony Lindgren (2):
      wlcore/wl12xx: Fix wl12xx get_mac error if device is in ELP
      mfd: cpcap: Fix cpcap dmamask not set warnings

Tony Luck (1):
      EDAC/Intel: Do not load EDAC driver when running as a guest

Trond Myklebust (3):
      NFS: nfs_find_open_context() may only select open files
      NFSv4: Initialise connection to the server in nfs4_alloc_client()
      NFSv4/pNFS: Don't call _nfs4_pnfs_v3_ds_connect multiple times

Tyrel Datwyler (1):
      scsi: core: Fix bad pointer dereference when ehandler kthread is invalid

Uwe Kleine-König (5):
      backlight: lm3630a: Fix return code of .update_status() callback
      pwm: spear: Don't modify HW state in .remove callback
      pwm: tegra: Don't modify HW state in .remove callback
      pwm: imx1: Don't disable clocks at device remove time
      pwm: sprd: Ensure configuring period and duty_cycle isn't wrongly skipped

Vadim Fedorenko (2):
      net: lwtunnel: handle MTU calculation in forwading
      net: ipv6: fix return value of ip6_skb_dst_mtu

Valentin Vidic (1):
      s390/sclp_vt220: fix console name to match device

Valentine Barshak (1):
      arm64: dts: renesas: v3msk: Fix memory size

Varun Prakash (1):
      scsi: target: cxgbit: Unmap DMA buffer before calling target_execute_cmd()

Vasily Averin (3):
      netfilter: ctnetlink: suspicious RCU usage in ctnetlink_dump_helpinfo
      ipv6: allocate enough headroom in ip6_finish_output2()
      ipv6: ip6_finish_output2: set sk into newly allocated nskb

Vasily Gorbik (1):
      s390/ftrace: fix ftrace_update_ftrace_func implementation

Vasundhara Volam (1):
      bnxt_en: Improve bnxt_ulp_stop()/bnxt_ulp_start() call sequence.

Vincent Donnefort (2):
      sched/rt: Fix RT utilization tracking during policy change
      sched/rt: Fix Deadline utilization tracking during policy change

Vincent Palatin (1):
      Revert "USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem"

Vineeth Vijayan (1):
      s390/cio: dont call css_wait_for_slow_path() inside a lock

Vinicius Costa Gomes (2):
      igc: Fix use-after-free error during reset
      igb: Fix use-after-free error during reset

Vladimir Stempen (1):
      drm/amd/display: Release MST resources on switch from MST to SST

Wang Hai (3):
      samples/bpf: Fix the error return code of xdp_redirect's main()
      tulip: windbond-840: Fix missing pci_disable_device() in probe and remove
      sis900: Fix missing pci_disable_device() in probe and remove

Wang Li (1):
      drm/mediatek: Fix PM reference leak in mtk_crtc_ddp_hw_init()

Wei Li (1):
      MIPS: Fix PKMAP with 32-bit MIPS huge page support

Wesley Chalmers (1):
      drm/amd/display: Set DISPCLK_MAX_ERRDET_CYCLES to 7

Willy Tarreau (1):
      ipv6: use prandom_u32() for ID generation

Wolfgang Bumiller (1):
      net: bridge: sync fdb to new unicast-filtering ports

Wolfram Sang (1):
      mmc: core: clear flags before allowing to retune

Xianting Tian (1):
      virtio_net: Remove BUG() to avoid machine dead

Xiao Yang (1):
      RDMA/rxe: Don't overwrite errno from ib_umem_get()

Xie Yongji (4):
      drm/virtio: Fix double free on probe failure
      virtio-blk: Fix memory leak among suspend/resume procedure
      virtio_net: Fix error handling in virtnet_restore()
      virtio_console: Assure used length from device is limited

Xin Long (2):
      sctp: update active_key for asoc when old key is being replaced
      sctp: move 198 addresses from unusable to private scope

Xiyu Yang (2):
      iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation

Yajun Deng (2):
      net: decnet: Fix sleeping inside in af_decnet
      net: sched: cls_api: Fix the the wrong parameter

Yang Jihong (1):
      arm_pmu: Fix write counter incorrect in ARMv7 big-endian mode

Yang Li (1):
      ath10k: Fix an error code in ath10k_add_interface()

Yang Yingliang (20):
      ext4: return error code when ext4_fill_flex_info() fails
      net: ftgmac100: add missing error return code in ftgmac100_probe()
      drm/rockchip: cdn-dp-core: add missing clk_disable_unprepare() on error in cdn_dp_grf_write()
      ath10k: go to path err_unsupported when chip id is not supported
      ath10k: add missing error return code in ath10k_pci_probe()
      ASoC: rk3328: fix missing clk_disable_unprepare() on error in rk3328_platform_probe()
      ASoC: hisilicon: fix missing clk_disable_unprepare() on error in hi6210_i2s_startup()
      mtd: rawnand: marvell: add missing clk_disable_unprepare() on error in marvell_nfc_resume()
      net: bcmgenet: check return value after calling platform_get_resource()
      net: mvpp2: check return value after calling platform_get_resource()
      net: micrel: check return value after calling platform_get_resource()
      fjes: check return value after calling platform_get_resource()
      net: sched: fix error return code in tcf_del_walker()
      net: moxa: Use devm_platform_get_and_ioremap_resource()
      ALSA: ppc: fix error return code in snd_pmac_probe()
      usb: gadget: hid: fix error return code in hid_bind()
      thermal/core: Correct function name thermal_zone_device_unregister()
      workqueue: fix UAF in pwq_unbound_release_workfn()
      net/802/mrp: fix memleak in mrp_request_join()
      net/802/garp: fix memleak in garp_request_join()

Yizhuo Zhai (1):
      Input: hideep - fix the uninitialized use in hideep_nvm_unlock()

Yonghong Song (1):
      tools: Allow proper CC/CXX/... override with LLVM=1 in Makefile.include

Yoshihiro Shimoda (2):
      serial: sh-sci: Stop dmaengine transfer in sci_stop_tx()
      usb: renesas_usbhs: Fix superfluous irqs happen after usb_pkt_pop()

Yu Kuai (1):
      char: pcmcia: error out if 'num_bytes_read' is greater than 4 in set_protocol()

Yu Liu (1):
      Bluetooth: Fix the HCI to MGMT status conversion table

YueHaibing (2):
      x86/efi: remove unused variables
      hv_utils: Fix passing zero to 'PTR_ERR' warning

Yufen Yu (3):
      ALSA: ac97: fix PM reference leak in ac97_bus_remove()
      ASoC: img: Fix PM reference leak in img_i2s_in_probe()
      scsi: libsas: Add LUN number check in .slave_alloc callback

Yun Zhou (2):
      seq_buf: Make trace_seq_putmem_hex() support data longer than 8
      seq_buf: Fix overflow in seq_buf_putmem_hex()

Yunsheng Lin (1):
      net: sched: add barrier to ensure correct ordering for lockless qdisc

Zhang Changzhong (1):
      can: j1939: j1939_xtp_rx_dat_one(): fix rxtimer value between consecutive TP.DT to 750ms

Zhang Qilong (1):
      crypto: omap-sham - Fix PM reference leak in omap sham ops

Zhang Xiaoxu (2):
      SUNRPC: Fix the batch tasks count wraparound.
      SUNRPC: Should wake up the privileged task firstly.

Zhang Yi (5):
      ext4: cleanup in-core orphan list if ext4_truncate() failed to get a transaction handle
      ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
      ext4: remove check for zero nr_to_scan in ext4_es_scan()
      blk-wbt: introduce a new disable state to prevent false positive by rwb_enabled()
      blk-wbt: make sure throttle is enabled properly

Zhangjiantao (Kirin, nanjing) (1):
      xhci: solve a double free problem while doing s4

Zhen Lei (16):
      crypto: ux500 - Fix error return code in hash_hw_final()
      media: tc358743: Fix error return code in tc358743_probe_of()
      mmc: usdhi6rol0: fix error return code in usdhi6_probe()
      ehea: fix error return code in ehea_restart_qps()
      ssb: Fix error return code in ssb_bus_scan()
      Input: hil_kbd - fix error return code in hil_dev_connect()
      visorbus: fix error return code in visorchipset_init()
      scsi: mpt3sas: Fix error return value in _scsih_expander_add()
      leds: as3645a: Fix error return code in as3645a_parse_node()
      fbmem: Do not delete the mode that is still in use
      ASoC: soc-core: Fix the error return code in snd_soc_of_parse_audio_routing()
      um: fix error return code in slip_open()
      um: fix error return code in winch_tramp()
      ALSA: isa: Fix error return code in snd_cmi8330_probe()
      memory: pl353: Fix error return code in pl353_smc_probe()
      firmware: tegra: Fix error return code in tegra210_bpmp_init()

Zheyu Ma (4):
      media: bt8xx: Fix a missing check bug in bt878_probe
      mmc: via-sdmmc: add a check against NULL pointer dereference
      atm: nicstar: use 'dma_free_coherent' instead of 'kfree'
      atm: nicstar: register the interrupt handler in the right place

Zhihao Cheng (4):
      tools/bpftool: Fix error return code in do_batch()
      ubifs: Fix races between xattr_{set|get} and listxattr operations
      ubifs: Set/Clear I_LINKABLE under i_lock for whiteout inode
      nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING

Ziyang Xuan (2):
      net: fix uninit-value in caif_seqpkt_sendmsg
      can: raw: raw_setsockopt(): fix raw_rcv panic for sock UAF

Zou Wei (18):
      regulator: uniphier: Add missing MODULE_DEVICE_TABLE
      atm: iphase: fix possible use-after-free in ia_module_exit()
      mISDN: fix possible use-after-free in HFC_cleanup()
      atm: nicstar: Fix possible use-after-free in nicstar_cleanup()
      drm/bridge: cdns: Fix PM reference leak in cdns_dsi_transfer()
      cw1200: add missing MODULE_DEVICE_TABLE
      pinctrl: mcp23s08: Fix missing unlock on error in mcp23s08_irq()
      mfd: da9052/stmpe: Add and modify MODULE_DEVICE_TABLE
      power: supply: sc27xx: Add missing MODULE_DEVICE_TABLE
      power: supply: sc2731_charger: Add missing MODULE_DEVICE_TABLE
      watchdog: Fix possible use-after-free in wdt_startup()
      watchdog: sc520_wdt: Fix possible use-after-free in wdt_turnoff()
      watchdog: Fix possible use-after-free by calling del_timer_sync()
      PCI: tegra: Add missing MODULE_DEVICE_TABLE
      power: supply: charger-manager: add missing MODULE_DEVICE_TABLE
      power: supply: ab8500: add missing MODULE_DEVICE_TABLE
      pwm: img: Fix PM reference leak in img_pwm_enable()
      reset: brcmstb: Add missing MODULE_DEVICE_TABLE

frank zago (1):
      iio: light: tcs3472: do not free unallocated IRQ

mark-yw.chen (1):
      Bluetooth: btusb: Fixed too many in-token issue for Mediatek Chip.

wenxu (1):
      net/sched: act_ct: fix err check for nf_conntrack_confirm

xinhui pan (1):
      drm/amdkfd: Walk through list with dqm lock hold

zhanglianjie (1):
      MIPS: loongsoon64: Reserve memory below starting pfn to prevent Oops

zhangyi (F) (1):
      block_dump: remove block_dump feature in mark_inode_dirty()

Íñigo Huguet (2):
      sfc: avoid double pci_remove of VFs
      sfc: error code if SRIOV cannot be disabled

Łukasz Stelmach (1):
      hwrng: exynos - Fix runtime PM imbalance on error
---
Documentation/ABI/testing/evm                      |  26 ++++-
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/arm64/tagged-address-abi.rst         |  26 +++--
 Documentation/hwmon/max31790.rst                   |   5 +-
 Documentation/trace/histogram.rst                  |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |   2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   5 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   5 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |   2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  18 +--
 arch/arm/boot/dts/bcm63138.dtsi                    |   2 +-
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts         |   4 +-
 arch/arm/boot/dts/bcm7445.dtsi                     |   2 +-
 arch/arm/boot/dts/bcm911360_entphn.dts             |   4 +-
 arch/arm/boot/dts/bcm958300k.dts                   |   4 +-
 arch/arm/boot/dts/bcm958305k.dts                   |   4 +-
 arch/arm/boot/dts/bcm958522er.dts                  |   4 +-
 arch/arm/boot/dts/bcm958525er.dts                  |   4 +-
 arch/arm/boot/dts/bcm958525xmc.dts                 |   4 +-
 arch/arm/boot/dts/bcm958622hr.dts                  |   4 +-
 arch/arm/boot/dts/bcm958623hr.dts                  |   4 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |   4 +-
 arch/arm/boot/dts/bcm958625k.dts                   |   4 +-
 arch/arm/boot/dts/bcm963138dvt.dts                 |   4 +-
 arch/arm/boot/dts/bcm988312hr.dts                  |   4 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |   2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         |   2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |   4 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts         |   2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts              |   2 +-
 arch/arm/boot/dts/gemini-rut1xx.dts                |  14 +--
 arch/arm/boot/dts/gemini-wbd111.dts                |   2 +-
 arch/arm/boot/dts/gemini-wbd222.dts                |   2 +-
 arch/arm/boot/dts/gemini.dtsi                      |   1 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi             |  41 ++++++-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   5 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   1 +
 arch/arm/boot/dts/rk3036-kylin.dts                 |   2 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   6 +-
 arch/arm/boot/dts/rk3188.dtsi                      |  14 +--
 arch/arm/boot/dts/rk322x.dtsi                      |  10 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts                 |   4 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  14 +--
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |   8 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |   6 +-
 arch/arm/boot/dts/stm32f429-disco.dts              |   6 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |  10 +-
 arch/arm/boot/dts/stm32f469-disco.dts              |   6 +-
 arch/arm/boot/dts/stm32f746.dtsi                   |  12 +-
 arch/arm/boot/dts/stm32f769-disco.dts              |   6 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |   4 -
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  12 +-
 arch/arm/boot/dts/versatile-ab.dts                 |   5 +-
 arch/arm/boot/dts/versatile-pb.dts                 |   2 +-
 arch/arm/kernel/perf_event_v7.c                    |   4 +-
 arch/arm/mach-exynos/exynos.c                      |   2 +
 arch/arm/mach-imx/suspend-imx53.S                  |   4 +-
 arch/arm/probes/kprobes/test-thumb.c               |  10 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  16 +++
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |   6 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  10 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  16 +--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   2 +-
 arch/arm64/include/asm/asm-uaccess.h               |   4 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   6 -
 arch/arm64/include/asm/mmu_context.h               |   8 +-
 arch/arm64/include/asm/pgtable.h                   |   1 +
 arch/arm64/include/asm/uaccess.h                   |   4 +-
 arch/arm64/kernel/entry.S                          |   6 +-
 arch/arm64/kernel/setup.c                          |   2 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   8 +-
 arch/arm64/mm/proc.S                               |   2 +-
 arch/hexagon/kernel/vmlinux.lds.S                  |   7 +-
 arch/ia64/kernel/mca_drv.c                         |   2 +-
 arch/m68k/Kconfig.machine                          |   3 +
 arch/mips/boot/compressed/Makefile                 |   4 +-
 arch/mips/boot/compressed/decompress.c             |   2 +
 arch/mips/boot/compressed/string.c                 |  17 +++
 arch/mips/include/asm/highmem.h                    |   2 +-
 arch/mips/include/asm/hugetlb.h                    |   8 +-
 arch/mips/include/asm/mipsregs.h                   |   8 +-
 arch/mips/include/asm/vdso/vdso.h                  |   2 +-
 arch/mips/loongson64/loongson-3/numa.c             |   3 +
 arch/nds32/mm/mmap.c                               |   2 +-
 arch/powerpc/boot/devtree.c                        |  59 +++++-----
 arch/powerpc/boot/ns16550.c                        |   9 +-
 arch/powerpc/include/asm/barrier.h                 |   2 +
 arch/powerpc/include/asm/cputhreads.h              |  30 +++++
 arch/powerpc/include/asm/ps3.h                     |   2 +
 arch/powerpc/kernel/smp.c                          |  11 ++
 arch/powerpc/kernel/stacktrace.c                   |  27 ++++-
 arch/powerpc/kvm/book3s_hv.c                       |  15 ++-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   2 +-
 arch/powerpc/kvm/book3s_hv_nested.c                |  23 +++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   2 +-
 arch/powerpc/kvm/book3s_rtas.c                     |  25 ++++-
 arch/powerpc/kvm/powerpc.c                         |   4 +-
 arch/powerpc/mm/fault.c                            |   4 +-
 arch/powerpc/platforms/ps3/mm.c                    |  12 ++
 arch/powerpc/platforms/pseries/setup.c             |   2 +-
 arch/s390/Kconfig                                  |   2 +-
 arch/s390/boot/ipl_parm.c                          |  19 ++--
 arch/s390/boot/mem_detect.c                        |  47 ++++----
 arch/s390/boot/text_dma.S                          |  19 +---
 arch/s390/include/asm/ftrace.h                     |   1 +
 arch/s390/include/asm/processor.h                  |   4 +-
 arch/s390/include/asm/stacktrace.h                 | 115 +++++++++++++++++--
 arch/s390/kernel/ftrace.c                          |   2 +
 arch/s390/kernel/mcount.S                          |   4 +-
 arch/s390/kernel/setup.c                           |   2 +-
 arch/s390/kvm/kvm-s390.c                           |  18 +--
 arch/s390/net/bpf_jit_comp.c                       |   2 +-
 arch/um/drivers/chan_user.c                        |   3 +-
 arch/um/drivers/slip_user.c                        |   3 +-
 arch/x86/include/asm/fpu/internal.h                |  19 ++--
 arch/x86/include/asm/proto.h                       |   2 +
 arch/x86/kernel/fpu/regset.c                       |   2 +-
 arch/x86/kernel/signal.c                           |  24 +++-
 arch/x86/kvm/cpuid.c                               |   8 +-
 arch/x86/kvm/ioapic.c                              |   2 +-
 arch/x86/kvm/ioapic.h                              |   4 +-
 arch/x86/kvm/svm.c                                 |  33 ++++--
 arch/x86/kvm/vmx/nested.c                          |   2 +-
 arch/x86/kvm/x86.c                                 |  15 ++-
 block/blk-merge.c                                  |   8 +-
 block/blk-rq-qos.c                                 |   4 +-
 block/blk-rq-qos.h                                 |  24 ++++
 block/blk-wbt.c                                    |  11 +-
 block/blk-wbt.h                                    |   1 +
 crypto/shash.c                                     |  18 ++-
 drivers/acpi/Makefile                              |   5 +
 drivers/acpi/acpi_amba.c                           |   1 +
 drivers/acpi/acpi_pad.c                            |  24 ++--
 drivers/acpi/acpi_tad.c                            |  14 +--
 drivers/acpi/acpi_video.c                          |   9 ++
 drivers/acpi/acpica/nsrepair2.c                    |   7 ++
 drivers/acpi/bgrt.c                                |  57 +++-------
 drivers/acpi/bus.c                                 |   1 +
 drivers/acpi/device_sysfs.c                        |  46 ++++----
 drivers/acpi/dock.c                                |  26 ++---
 drivers/acpi/ec.c                                  |  16 +++
 drivers/acpi/power.c                               |   9 +-
 drivers/acpi/processor_idle.c                      |  40 +++++++
 drivers/ata/ahci_sunxi.c                           |   2 +-
 drivers/ata/pata_ep93xx.c                          |   2 +-
 drivers/ata/pata_octeon_cf.c                       |   5 +-
 drivers/ata/pata_rb532_cf.c                        |   6 +-
 drivers/ata/sata_highbank.c                        |   6 +-
 drivers/atm/iphase.c                               |   2 +-
 drivers/atm/nicstar.c                              |  26 +++--
 drivers/block/rbd.c                                |  32 ++----
 drivers/block/virtio_blk.c                         |   2 +
 drivers/bluetooth/btusb.c                          |  15 ++-
 drivers/char/hw_random/exynos-trng.c               |   4 +-
 drivers/char/ipmi/ipmi_watchdog.c                  |  22 ++--
 drivers/char/pcmcia/cm4000_cs.c                    |   4 +
 drivers/char/virtio_console.c                      |   4 +-
 drivers/clk/actions/owl-s500.c                     |  62 ++++++-----
 drivers/clk/clk-si5341.c                           |  19 +++-
 drivers/clk/meson/g12a.c                           |   2 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |   1 +
 drivers/clk/tegra/clk-pll.c                        |   9 +-
 drivers/clocksource/arm_arch_timer.c               |   2 +-
 drivers/cpufreq/cpufreq.c                          |  11 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.c          |   4 +
 drivers/crypto/ccp/psp-dev.c                       |   4 +
 drivers/crypto/ccp/sp-pci.c                        |   6 +-
 drivers/crypto/ixp4xx_crypto.c                     |   2 +-
 drivers/crypto/nx/nx-842-pseries.c                 |   9 +-
 drivers/crypto/omap-sham.c                         |   4 +-
 drivers/crypto/qat/qat_common/qat_hal.c            |   6 +-
 drivers/crypto/qat/qat_common/qat_uclo.c           |   1 -
 drivers/crypto/ux500/hash/hash_core.c              |   1 +
 drivers/dma-buf/sync_file.c                        |  13 ++-
 drivers/dma/fsl-qdma.c                             |   6 +-
 drivers/edac/i10nm_base.c                          |   3 +
 drivers/edac/pnd2_edac.c                           |   3 +
 drivers/edac/sb_edac.c                             |   3 +
 drivers/edac/skx_base.c                            |   3 +
 drivers/edac/ti_edac.c                             |   1 +
 drivers/extcon/extcon-intel-mrfld.c                |   9 ++
 drivers/extcon/extcon-max8997.c                    |   3 +-
 drivers/extcon/extcon-sm5502.c                     |   1 -
 drivers/firmware/arm_scmi/driver.c                 |  16 ++-
 drivers/firmware/efi/efi.c                         |  13 ++-
 drivers/firmware/efi/tpm.c                         |   8 +-
 drivers/firmware/qemu_fw_cfg.c                     |   8 +-
 drivers/firmware/stratix10-svc.c                   |  22 ++--
 drivers/firmware/tegra/Makefile                    |   1 +
 drivers/firmware/tegra/bpmp-private.h              |   3 +-
 drivers/firmware/tegra/bpmp-tegra210.c             |   2 +-
 drivers/firmware/tegra/bpmp.c                      |   3 +-
 drivers/firmware/turris-mox-rwtm.c                 |  54 +++++++--
 drivers/fpga/stratix10-soc.c                       |   1 +
 drivers/fsi/fsi-core.c                             |   4 +-
 drivers/fsi/fsi-occ.c                              |   1 +
 drivers/fsi/fsi-sbefifo.c                          |  10 +-
 drivers/fsi/fsi-scom.c                             |  16 +--
 drivers/gpio/Kconfig                               |   2 +
 drivers/gpio/gpio-pca953x.c                        |   1 +
 drivers/gpio/gpio-zynq.c                           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  21 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  22 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |  41 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   2 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h         |   2 +-
 drivers/gpu/drm/amd/include/navi10_enum.h          |   2 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   9 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |   2 +-
 drivers/gpu/drm/drm_ioctl.c                        |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |   2 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   8 +-
 drivers/gpu/drm/mxsfb/Kconfig                      |   1 -
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   4 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |   1 -
 drivers/gpu/drm/qxl/qxl_dumb.c                     |   2 +
 drivers/gpu/drm/radeon/radeon_display.c            |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |   1 +
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  40 +++++--
 drivers/gpu/drm/scheduler/sched_entity.c           |   5 +
 drivers/gpu/drm/tegra/dc.c                         |  10 +-
 drivers/gpu/drm/tegra/drm.c                        |   2 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |   2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   1 +
 drivers/gpu/drm/zte/Kconfig                        |   1 -
 drivers/hid/hid-core.c                             |  10 +-
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 drivers/hv/hv_util.c                               |   4 +-
 drivers/hwmon/max31722.c                           |   9 --
 drivers/hwmon/max31790.c                           |  49 +++++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   2 +-
 drivers/hwtracing/intel_th/core.c                  |  17 +++
 drivers/hwtracing/intel_th/gth.c                   |  16 +++
 drivers/hwtracing/intel_th/intel_th.h              |   3 +
 drivers/i2c/i2c-core-base.c                        |   3 +
 drivers/iio/accel/bma180.c                         |  85 +++++++++-----
 drivers/iio/accel/bma220_spi.c                     |  10 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |  13 ++-
 drivers/iio/accel/kxcjk-1013.c                     |  24 ++--
 drivers/iio/accel/mxc4005.c                        |  12 +-
 drivers/iio/accel/stk8312.c                        |  12 +-
 drivers/iio/accel/stk8ba50.c                       |  17 ++-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  33 +++---
 drivers/iio/adc/hx711.c                            |   4 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |   3 +-
 drivers/iio/adc/ti-ads1015.c                       |  12 +-
 drivers/iio/adc/ti-ads8688.c                       |   3 +-
 drivers/iio/adc/vf610_adc.c                        |  10 +-
 drivers/iio/gyro/bmg160_core.c                     |  10 +-
 drivers/iio/gyro/fxas21002c_core.c                 |  11 +-
 drivers/iio/humidity/am2315.c                      |  16 ++-
 drivers/iio/imu/adis16400.c                        |   3 -
 drivers/iio/imu/adis_buffer.c                      |   3 -
 drivers/iio/light/isl29125.c                       |  10 +-
 drivers/iio/light/ltr501.c                         |  15 ++-
 drivers/iio/light/tcs3414.c                        |  10 +-
 drivers/iio/light/tcs3472.c                        |  16 ++-
 drivers/iio/light/vcnl4035.c                       |   3 +-
 drivers/iio/magnetometer/bmc150_magn.c             |  21 ++--
 drivers/iio/magnetometer/hmc5843.h                 |   8 +-
 drivers/iio/magnetometer/hmc5843_core.c            |   4 +-
 drivers/iio/magnetometer/rm3100-core.c             |   3 +-
 drivers/iio/potentiostat/lmp91000.c                |   4 +-
 drivers/iio/proximity/as3935.c                     |  10 +-
 drivers/iio/proximity/isl29501.c                   |   2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  10 +-
 drivers/iio/proximity/srf08.c                      |  14 +--
 drivers/infiniband/core/cma.c                      |   3 +-
 drivers/infiniband/core/uverbs_cmd.c               |  21 +++-
 drivers/infiniband/hw/cxgb4/qp.c                   |   1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   9 +-
 drivers/infiniband/hw/mlx5/flow.c                  |   8 ++
 drivers/infiniband/hw/mlx5/main.c                  |   4 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  10 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   1 -
 drivers/infiniband/sw/rxe/rxe_resp.c               |   2 -
 drivers/input/joydev.c                             |   2 +-
 drivers/input/keyboard/Kconfig                     |   3 -
 drivers/input/keyboard/hil_kbd.c                   |   1 +
 drivers/input/touchscreen/hideep.c                 |  13 ++-
 drivers/input/touchscreen/usbtouchscreen.c         |   8 +-
 drivers/iommu/arm-smmu.c                           |  10 +-
 drivers/iommu/dma-iommu.c                          |   6 +-
 drivers/ipack/carriers/tpci200.c                   |   5 +-
 drivers/isdn/hardware/mISDN/hfcpci.c               |   2 +-
 drivers/leds/Kconfig                               |   1 +
 drivers/leds/leds-as3645a.c                        |   1 +
 drivers/leds/leds-ktd2692.c                        |  27 +++--
 drivers/leds/leds-lm36274.c                        |  82 +++++++-------
 drivers/leds/leds-lm3692x.c                        |   8 +-
 drivers/md/dm-writecache.c                         |  32 +++---
 drivers/md/persistent-data/dm-btree-remove.c       |   3 +-
 drivers/md/persistent-data/dm-space-map-disk.c     |   9 +-
 drivers/md/persistent-data/dm-space-map-metadata.c |   9 +-
 drivers/media/common/siano/smscoreapi.c            |  22 ++--
 drivers/media/common/siano/smscoreapi.h            |   4 +-
 drivers/media/common/siano/smsdvb-main.c           |   4 +
 drivers/media/dvb-core/dvb_net.c                   |  25 ++++-
 drivers/media/i2c/ir-kbd-i2c.c                     |   4 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |   6 +-
 drivers/media/i2c/s5c73m3/s5c73m3.h                |   2 +-
 drivers/media/i2c/s5k4ecgx.c                       |  10 +-
 drivers/media/i2c/s5k5baf.c                        |   6 +-
 drivers/media/i2c/s5k6aa.c                         |  10 +-
 drivers/media/i2c/saa6588.c                        |   4 +-
 drivers/media/i2c/tc358743.c                       |   1 +
 drivers/media/mc/Makefile                          |   2 +-
 drivers/media/pci/bt8xx/bt878.c                    |   3 +
 drivers/media/pci/bt8xx/bttv-driver.c              |   6 +-
 drivers/media/pci/cobalt/cobalt-driver.c           |   1 +
 drivers/media/pci/cobalt/cobalt-driver.h           |   7 +-
 drivers/media/pci/ngene/ngene-core.c               |   2 +-
 drivers/media/pci/ngene/ngene.h                    |  14 ++-
 drivers/media/pci/saa7134/saa7134-video.c          |   6 +-
 drivers/media/platform/davinci/vpbe_display.c      |   2 +-
 drivers/media/platform/davinci/vpbe_venc.c         |   6 +-
 drivers/media/platform/exynos-gsc/gsc-m2m.c        |   4 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |   7 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c       |   6 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c |   4 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  |   8 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h  |   2 +-
 drivers/media/platform/s5p-cec/s5p_cec.c           |   7 +-
 drivers/media/platform/s5p-g2d/g2d.c               |   3 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |   5 +-
 drivers/media/platform/sh_vou.c                    |   6 +-
 drivers/media/platform/sti/bdisp/Makefile          |   2 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |   7 +-
 drivers/media/platform/sti/delta/Makefile          |   2 +-
 drivers/media/platform/sti/hva/Makefile            |   2 +-
 drivers/media/platform/sti/hva/hva-hw.c            |   3 +-
 drivers/media/rc/bpf-lirc.c                        |   3 +-
 drivers/media/usb/au0828/au0828-core.c             |   4 +-
 drivers/media/usb/cpia2/cpia2.h                    |   1 +
 drivers/media/usb/cpia2/cpia2_core.c               |  12 ++
 drivers/media/usb/cpia2/cpia2_usb.c                |  13 ++-
 drivers/media/usb/dvb-usb/cinergyT2-core.c         |   2 +
 drivers/media/usb/dvb-usb/cxusb.c                  |   2 +-
 drivers/media/usb/dvb-usb/dtv5100.c                |   7 +-
 drivers/media/usb/em28xx/em28xx-input.c            |   8 +-
 drivers/media/usb/gspca/gl860/gl860.c              |   4 +-
 drivers/media/usb/gspca/sq905.c                    |   2 +-
 drivers/media/usb/gspca/sunplus.c                  |   8 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |   4 +-
 drivers/media/usb/uvc/uvc_video.c                  |  27 +++++
 drivers/media/usb/zr364xx/zr364xx.c                |   1 +
 drivers/media/v4l2-core/v4l2-fh.c                  |   1 +
 drivers/memory/atmel-ebi.c                         |   4 +-
 drivers/memory/fsl_ifc.c                           |   8 +-
 drivers/memory/pl353-smc.c                         |   1 +
 drivers/memstick/host/rtsx_usb_ms.c                |  10 +-
 drivers/mfd/da9052-i2c.c                           |   1 +
 drivers/mfd/motorola-cpcap.c                       |   4 +
 drivers/mfd/stmpe-i2c.c                            |   2 +-
 drivers/misc/cardreader/alcor_pci.c                |   8 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |   8 +-
 drivers/misc/ibmasm/module.c                       |   5 +-
 drivers/mmc/core/block.c                           |   8 ++
 drivers/mmc/core/core.c                            |   7 +-
 drivers/mmc/core/sd.c                              |  10 +-
 drivers/mmc/host/sdhci-sprd.c                      |   1 +
 drivers/mmc/host/sdhci.c                           |   4 +
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/usdhi6rol0.c                      |   1 +
 drivers/mmc/host/via-sdmmc.c                       |   3 +
 drivers/mmc/host/vub300.c                          |   2 +-
 drivers/mtd/nand/raw/marvell_nand.c                |   4 +-
 drivers/mtd/parsers/redboot.c                      |   7 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |   4 +-
 drivers/net/can/spi/hi311x.c                       |   2 +-
 drivers/net/can/usb/ems_usb.c                      |  17 ++-
 drivers/net/can/usb/esd_usb2.c                     |  16 ++-
 drivers/net/can/usb/mcba_usb.c                     |   2 +
 drivers/net/can/usb/usb_8dev.c                     |  15 ++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   8 +-
 drivers/net/ethernet/aeroflex/greth.c              |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  28 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  19 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   3 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  23 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |   6 -
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   4 +
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  18 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |   3 +
 drivers/net/ethernet/dec/tulip/winbond-840.c       |   7 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   6 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +
 drivers/net/ethernet/ezchip/nps_enet.c             |   4 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   6 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   9 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |   6 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  10 ++
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |   9 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  10 +-
 drivers/net/ethernet/intel/e100.c                  |  12 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  25 +++--
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  63 +++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  50 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h          |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  20 +++-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   6 +
 drivers/net/ethernet/mellanox/mlx4/main.c          |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  33 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  10 +-
 drivers/net/ethernet/micrel/ks8842.c               |   4 +
 drivers/net/ethernet/moxa/moxart_ether.c           |   8 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |  29 +++--
 drivers/net/ethernet/qualcomm/emac/emac.c          |   3 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
 drivers/net/ethernet/sfc/ef10_sriov.c              |  25 ++---
 drivers/net/ethernet/sis/sis900.c                  |   7 +-
 drivers/net/ethernet/sun/niu.c                     |   3 +-
 drivers/net/ethernet/ti/tlan.c                     |   3 +-
 drivers/net/fddi/defza.c                           |   3 +-
 drivers/net/fjes/fjes_main.c                       |   4 +
 drivers/net/ieee802154/mac802154_hwsim.c           |  11 +-
 drivers/net/virtio_net.c                           |  29 ++++-
 drivers/net/vrf.c                                  |  14 +--
 drivers/net/vxlan.c                                |   2 +
 drivers/net/wireless/ath/ath10k/mac.c              |   1 +
 drivers/net/wireless/ath/ath10k/pci.c              |  14 ++-
 drivers/net/wireless/ath/ath9k/main.c              |   5 +
 drivers/net/wireless/ath/carl9170/Kconfig          |   8 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |  21 ++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  37 ++++---
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  24 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   3 +
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  15 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   3 +
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   3 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  10 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  11 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |  59 +++++++++-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |   6 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   3 -
 drivers/net/wireless/rsi/rsi_91x_mgmt.c            |   3 +-
 drivers/net/wireless/rsi/rsi_main.h                |   1 -
 drivers/net/wireless/st/cw1200/cw1200_sdio.c       |   1 +
 drivers/net/wireless/ti/wl1251/cmd.c               |   9 +-
 drivers/net/wireless/ti/wl12xx/main.c              |   7 ++
 drivers/nfc/nfcsim.c                               |   3 +-
 drivers/nvme/host/core.c                           |   5 +-
 drivers/nvme/host/pci.c                            |   5 +-
 drivers/nvme/target/fc.c                           |  10 +-
 drivers/nvme/target/tcp.c                          |   1 -
 drivers/nvmem/core.c                               |   9 +-
 drivers/of/fdt.c                                   |   8 +-
 drivers/of/of_reserved_mem.c                       |   8 +-
 drivers/pci/controller/pci-aardvark.c              |  13 ++-
 drivers/pci/controller/pci-hyperv.c                |   3 +
 drivers/pci/controller/pci-mvebu.c                 |  16 ++-
 drivers/pci/controller/pci-tegra.c                 |   1 +
 drivers/pci/controller/pcie-iproc-msi.c            |  29 +++--
 drivers/pci/p2pdma.c                               |  34 +++++-
 drivers/pci/pci-label.c                            |   2 +-
 drivers/pci/quirks.c                               |  15 ++-
 drivers/perf/arm_smmuv3_pmu.c                      |  18 +--
 drivers/perf/fsl_imx8_ddr_perf.c                   |   6 +-
 drivers/phy/socionext/phy-uniphier-pcie.c          |  11 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |  17 ++-
 drivers/pinctrl/pinctrl-amd.c                      |   1 +
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  10 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |   3 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              |   8 +-
 drivers/platform/x86/toshiba_acpi.c                |   1 +
 drivers/power/reset/gpio-poweroff.c                |   1 +
 drivers/power/supply/Kconfig                       |   3 +-
 drivers/power/supply/ab8500_btemp.c                |   1 +
 drivers/power/supply/ab8500_charger.c              |  19 +++-
 drivers/power/supply/ab8500_fg.c                   |   1 +
 drivers/power/supply/charger-manager.c             |   1 +
 drivers/power/supply/max17042_battery.c            |   2 +-
 drivers/power/supply/rt5033_battery.c              |   7 ++
 drivers/power/supply/sc2731_charger.c              |   1 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |   1 +
 drivers/pwm/pwm-img.c                              |   2 +-
 drivers/pwm/pwm-imx1.c                             |   2 -
 drivers/pwm/pwm-spear.c                            |   4 -
 drivers/pwm/pwm-sprd.c                             |  11 +-
 drivers/pwm/pwm-tegra.c                            |  13 ---
 drivers/regulator/da9052-regulator.c               |   3 +-
 drivers/regulator/hi6421-regulator.c               |  30 ++---
 drivers/regulator/hi655x-regulator.c               |  16 +--
 drivers/regulator/mt6358-regulator.c               |   2 +-
 drivers/regulator/uniphier-regulator.c             |   1 +
 drivers/reset/core.c                               |   5 +-
 drivers/reset/reset-a10sr.c                        |   1 +
 drivers/reset/reset-brcmstb.c                      |   1 +
 drivers/reset/reset-ti-syscon.c                    |   4 +-
 drivers/rtc/proc.c                                 |   4 +-
 drivers/rtc/rtc-max77686.c                         |   4 +-
 drivers/rtc/rtc-mxc_v2.c                           |   1 +
 drivers/rtc/rtc-stm32.c                            |   6 +-
 drivers/s390/char/sclp_vt220.c                     |   4 +-
 drivers/s390/cio/chp.c                             |   3 +
 drivers/s390/cio/chsc.c                            |   2 -
 drivers/scsi/FlashPoint.c                          |  32 +++---
 drivers/scsi/aic7xxx/aic7xxx_core.c                |   2 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   1 +
 drivers/scsi/be2iscsi/be_main.c                    |   5 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |   4 +-
 drivers/scsi/device_handler/scsi_dh_alua.c         |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |  13 ++-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |   1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   1 +
 drivers/scsi/hosts.c                               |   4 +
 drivers/scsi/isci/init.c                           |   1 +
 drivers/scsi/libfc/fc_rport.c                      |  13 ++-
 drivers/scsi/libiscsi.c                            | 122 ++++++++++-----------
 drivers/scsi/libsas/sas_scsi_host.c                |   9 ++
 drivers/scsi/lpfc/lpfc_els.c                       |   9 ++
 drivers/scsi/lpfc/lpfc_sli.c                       |   5 +-
 drivers/scsi/megaraid/megaraid_sas.h               |  12 ++
 drivers/scsi/megaraid/megaraid_sas_base.c          |  96 ++++++++++++++--
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   6 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |  10 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   4 +-
 drivers/scsi/mvsas/mv_init.c                       |   1 +
 drivers/scsi/pm8001/pm8001_init.c                  |   1 +
 drivers/scsi/qedf/qedf_io.c                        |  22 +++-
 drivers/scsi/qedi/qedi_fw.c                        |   2 +-
 drivers/scsi/qedi/qedi_main.c                      |   2 +-
 drivers/scsi/scsi_lib.c                            |   1 +
 drivers/scsi/scsi_transport_iscsi.c                | 102 ++++++++---------
 drivers/scsi/sr.c                                  |   2 +
 drivers/soc/tegra/fuse/fuse-tegra30.c              |   3 +-
 drivers/soundwire/stream.c                         |  13 +--
 drivers/spi/spi-cadence.c                          |  14 ++-
 drivers/spi/spi-imx.c                              |  37 ++++---
 drivers/spi/spi-loopback-test.c                    |   2 +-
 drivers/spi/spi-mt65xx.c                           |  16 ++-
 drivers/spi/spi-omap-100k.c                        |   2 +-
 drivers/spi/spi-stm32.c                            |  41 +++++--
 drivers/spi/spi-sun6i.c                            |   6 +-
 drivers/spi/spi-topcliff-pch.c                     |   4 +-
 drivers/spi/spi.c                                  |   1 +
 drivers/ssb/scan.c                                 |   1 +
 drivers/ssb/sdio.c                                 |   1 -
 drivers/staging/fbtft/fb_agm1264k-fl.c             |  20 ++--
 drivers/staging/fbtft/fb_bd663474.c                |   4 -
 drivers/staging/fbtft/fb_ili9163.c                 |   4 -
 drivers/staging/fbtft/fb_ili9320.c                 |   1 -
 drivers/staging/fbtft/fb_ili9325.c                 |   4 -
 drivers/staging/fbtft/fb_ili9340.c                 |   1 -
 drivers/staging/fbtft/fb_s6d1121.c                 |   4 -
 drivers/staging/fbtft/fb_sh1106.c                  |   1 -
 drivers/staging/fbtft/fb_ssd1289.c                 |   4 -
 drivers/staging/fbtft/fb_ssd1325.c                 |   2 -
 drivers/staging/fbtft/fb_ssd1331.c                 |   6 +-
 drivers/staging/fbtft/fb_ssd1351.c                 |   1 -
 drivers/staging/fbtft/fb_upd161704.c               |   4 -
 drivers/staging/fbtft/fb_watterott.c               |   1 -
 drivers/staging/fbtft/fbtft-bus.c                  |   3 +-
 drivers/staging/fbtft/fbtft-core.c                 |  13 +--
 drivers/staging/fbtft/fbtft-io.c                   |  12 +-
 drivers/staging/gdm724x/gdm_lte.c                  |  20 +++-
 drivers/staging/media/imx/imx-media-csi.c          |  14 ++-
 drivers/staging/media/imx/imx7-mipi-csis.c         |   6 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |   2 +-
 drivers/staging/rtl8712/hal_init.c                 |   3 +
 drivers/staging/rtl8712/usb_intf.c                 |  10 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   5 +-
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c           |  19 ++--
 drivers/target/iscsi/cxgbit/cxgbit_target.c        |  21 +++-
 drivers/target/target_core_sbc.c                   |  35 +++---
 .../int340x_thermal/processor_thermal_device.c     |  20 ++--
 drivers/thermal/rcar_gen3_thermal.c                |   2 +-
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/tty/nozomi.c                               |   9 +-
 drivers/tty/serial/8250/8250_port.c                |  19 +++-
 drivers/tty/serial/8250/serial_cs.c                |  13 ++-
 drivers/tty/serial/fsl_lpuart.c                    |   3 +
 drivers/tty/serial/mvebu-uart.c                    |  18 +--
 drivers/tty/serial/sh-sci.c                        |   8 ++
 drivers/tty/serial/uartlite.c                      |  27 +----
 drivers/usb/cdns3/gadget.c                         |   8 +-
 drivers/usb/class/cdc-acm.c                        |   5 +
 drivers/usb/core/hub.c                             | 120 ++++++++++++++------
 drivers/usb/core/quirks.c                          |   4 -
 drivers/usb/dwc2/core.c                            |  30 +++--
 drivers/usb/dwc2/gadget.c                          |  10 +-
 drivers/usb/dwc3/core.c                            |   3 +-
 drivers/usb/gadget/function/f_eem.c                |  43 +++++++-
 drivers/usb/gadget/function/f_fs.c                 |  65 ++++++-----
 drivers/usb/gadget/function/f_hid.c                |   2 +-
 drivers/usb/gadget/legacy/hid.c                    |   4 +-
 drivers/usb/host/max3421-hcd.c                     |  44 +++-----
 drivers/usb/host/xhci-hub.c                        |   3 +-
 drivers/usb/host/xhci-mem.c                        |   1 +
 drivers/usb/host/xhci-ring.c                       |  58 +++++++---
 drivers/usb/host/xhci.h                            |   3 +-
 drivers/usb/renesas_usbhs/fifo.c                   |   7 ++
 drivers/usb/serial/cp210x.c                        |   5 +-
 drivers/usb/serial/option.c                        |   3 +
 drivers/usb/storage/unusual_uas.h                  |   7 ++
 drivers/usb/typec/class.c                          |   4 +-
 drivers/vfio/pci/vfio_pci.c                        |  29 +++--
 drivers/video/backlight/lm3630a_bl.c               |  16 +--
 drivers/video/fbdev/core/fbmem.c                   |  12 +-
 drivers/video/fbdev/imxfb.c                        |   2 +-
 drivers/visorbus/visorchipset.c                    |   6 +-
 drivers/w1/slaves/w1_ds2438.c                      |   4 +-
 drivers/watchdog/aspeed_wdt.c                      |   2 +-
 drivers/watchdog/iTCO_wdt.c                        |  12 +-
 drivers/watchdog/imx_sc_wdt.c                      |  11 +-
 drivers/watchdog/lpc18xx_wdt.c                     |   2 +-
 drivers/watchdog/sbc60xxwdt.c                      |   2 +-
 drivers/watchdog/sc520_wdt.c                       |   2 +-
 drivers/watchdog/w83877f_wdt.c                     |   2 +-
 drivers/xen/events/events_base.c                   |  23 +++-
 fs/afs/cmservice.c                                 |  25 ++---
 fs/btrfs/Kconfig                                   |   2 +
 fs/btrfs/compression.c                             |   2 +-
 fs/btrfs/delayed-inode.c                           |  18 ++-
 fs/btrfs/extent-tree.c                             |   3 +
 fs/btrfs/inode.c                                   |   2 +-
 fs/btrfs/send.c                                    |  11 ++
 fs/btrfs/transaction.c                             |   6 +-
 fs/btrfs/tree-log.c                                |   1 +
 fs/btrfs/volumes.c                                 |   1 +
 fs/ceph/addr.c                                     |  10 +-
 fs/cifs/cifs_dfs_ref.c                             |   3 +
 fs/cifs/cifsglob.h                                 |   3 +-
 fs/cifs/connect.c                                  |   5 +-
 fs/cifs/smb2ops.c                                  |   4 +-
 fs/configfs/file.c                                 |  10 +-
 fs/crypto/fname.c                                  |   9 +-
 fs/dax.c                                           |   3 +-
 fs/dlm/config.c                                    |   9 ++
 fs/dlm/lowcomms.c                                  |   2 +-
 fs/ext4/extents.c                                  |   3 +
 fs/ext4/extents_status.c                           |   4 +-
 fs/ext4/ialloc.c                                   |  11 +-
 fs/ext4/mballoc.c                                  |   9 +-
 fs/ext4/super.c                                    |  10 +-
 fs/f2fs/super.c                                    |   1 +
 fs/f2fs/sysfs.c                                    |   4 +
 fs/fs-writeback.c                                  |  39 ++-----
 fs/fuse/dev.c                                      |  12 +-
 fs/hfs/bfind.c                                     |  14 ++-
 fs/hfs/bnode.c                                     |  25 ++++-
 fs/hfs/btree.h                                     |   7 ++
 fs/hfs/super.c                                     |  10 +-
 fs/hugetlbfs/inode.c                               |   2 +-
 fs/internal.h                                      |   1 -
 fs/iomap/seek.c                                    |  25 ++---
 fs/jfs/inode.c                                     |   3 +-
 fs/jfs/jfs_logmgr.c                                |   1 +
 fs/nfs/inode.c                                     |   4 +
 fs/nfs/nfs3proc.c                                  |   4 +-
 fs/nfs/nfs4client.c                                |  82 +++++++-------
 fs/nfs/pnfs_nfs.c                                  |  52 ++++-----
 fs/ntfs/inode.c                                    |   2 +-
 fs/ocfs2/file.c                                    | 103 ++++++++++-------
 fs/ocfs2/filecheck.c                               |   6 +-
 fs/ocfs2/stackglue.c                               |   8 +-
 fs/orangefs/super.c                                |   2 +-
 fs/proc/base.c                                     |   2 +-
 fs/reiserfs/journal.c                              |  14 +++
 fs/seq_file.c                                      |   3 +
 fs/ubifs/dir.c                                     |   7 ++
 fs/ubifs/super.c                                   |   1 +
 fs/ubifs/ubifs.h                                   |   2 +
 fs/ubifs/xattr.c                                   |  44 ++++++--
 fs/udf/namei.c                                     |   4 +
 fs/userfaultfd.c                                   |  22 ++--
 include/crypto/internal/hash.h                     |   8 +-
 include/drm/drm_ioctl.h                            |   1 +
 include/linux/bio.h                                |  12 +-
 include/linux/fs_context.h                         |   1 +
 include/linux/iio/common/cros_ec_sensors_core.h    |   2 +-
 include/linux/mfd/abx500/ux500_chargalg.h          |   2 +-
 include/linux/netdev_features.h                    |   2 +-
 include/linux/nfs_fs.h                             |   1 +
 include/linux/prandom.h                            |   2 +-
 include/linux/sched/signal.h                       |  19 ++--
 include/linux/tracepoint.h                         |  10 ++
 include/linux/wait.h                               |   2 +-
 include/media/media-dev-allocator.h                |   2 +-
 include/media/v4l2-subdev.h                        |   4 +
 include/net/busy_poll.h                            |   2 +-
 include/net/dst_metadata.h                         |   4 +-
 include/net/ip.h                                   |  12 +-
 include/net/ip6_route.h                            |  18 ++-
 include/net/llc_pdu.h                              |  31 ++++--
 include/net/sch_generic.h                          |  12 ++
 include/net/sctp/constants.h                       |   4 +-
 include/net/sctp/structs.h                         |   2 +-
 include/net/tc_act/tc_vlan.h                       |   1 +
 include/net/xfrm.h                                 |   1 +
 include/scsi/libiscsi.h                            |  11 +-
 include/scsi/scsi_transport_iscsi.h                |   2 +
 include/trace/events/afs.h                         |  67 ++++++++++-
 include/uapi/linux/ethtool.h                       |   4 +-
 kernel/bpf/core.c                                  |  61 ++++++++---
 kernel/cgroup/cgroup-v1.c                          |   6 +-
 kernel/cpu.c                                       |  49 +++++++++
 kernel/kthread.c                                   |  19 ++--
 kernel/locking/lockdep.c                           | 120 +++++++++++++++++++-
 kernel/rcu/rcu.h                                   |   2 +
 kernel/rcu/srcutree.c                              |   3 +
 kernel/rcu/tree.c                                  |  18 ++-
 kernel/sched/core.c                                |  43 +++++---
 kernel/sched/deadline.c                            |   2 +
 kernel/sched/fair.c                                |  12 +-
 kernel/sched/rt.c                                  |  17 ++-
 kernel/sched/wait.c                                |   9 +-
 kernel/time/clocksource.c                          |  53 ++++++++-
 kernel/trace/bpf_trace.c                           |   3 +-
 kernel/trace/ring_buffer.c                         |  28 ++++-
 kernel/trace/trace.c                               |  95 ++++++++++------
 kernel/trace/trace_events_hist.c                   |  35 ++++--
 kernel/tracepoint.c                                |  33 +++++-
 kernel/workqueue.c                                 |  20 ++--
 lib/decompress_unlz4.c                             |   8 ++
 lib/iov_iter.c                                     |   9 +-
 lib/kstrtox.c                                      |  13 ++-
 lib/kstrtox.h                                      |   2 +
 lib/seq_buf.c                                      |   8 +-
 lib/vsprintf.c                                     |  82 ++++++++------
 localversion-rt                                    |   2 +-
 mm/huge_memory.c                                   |   2 +-
 mm/slab_common.c                                   |  18 +--
 mm/z3fold.c                                        |   1 +
 net/802/garp.c                                     |  14 +++
 net/802/mrp.c                                      |  14 +++
 net/bluetooth/hci_core.c                           |  16 +--
 net/bluetooth/hci_event.c                          |  13 ++-
 net/bluetooth/mgmt.c                               |   6 +
 net/bpfilter/main.c                                |   2 +-
 net/bridge/br_if.c                                 |  17 ++-
 net/caif/caif_socket.c                             |   3 +-
 net/can/bcm.c                                      |   7 +-
 net/can/gw.c                                       |   3 +
 net/can/j1939/main.c                               |   4 +
 net/can/j1939/socket.c                             |   3 +
 net/can/j1939/transport.c                          |  11 +-
 net/can/raw.c                                      |  20 +++-
 net/core/dev.c                                     |  11 +-
 net/core/filter.c                                  |   4 -
 net/core/sock.c                                    |   2 +-
 net/decnet/af_decnet.c                             |  27 ++---
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/fib_frontend.c                            |   2 +
 net/ipv4/ip_output.c                               |  32 +++---
 net/ipv4/ip_tunnel.c                               |  20 +++-
 net/ipv4/route.c                                   |   3 +-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv4/tcp_fastopen.c                            |  19 +++-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_output.c                              |   1 +
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/esp6.c                                    |   2 +-
 net/ipv6/exthdrs.c                                 |  31 +++---
 net/ipv6/ip6_output.c                              |  64 ++++++++---
 net/ipv6/output_core.c                             |  28 +----
 net/ipv6/route.c                                   |   2 +-
 net/ipv6/tcp_ipv6.c                                |  23 +++-
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/xfrm6_output.c                            |   2 +-
 net/llc/af_llc.c                                   |  10 +-
 net/llc/llc_s_ac.c                                 |   2 +-
 net/mac80211/mlme.c                                |   9 --
 net/mac80211/sta_info.c                            |   5 -
 net/netfilter/nf_conntrack_core.c                  |   7 +-
 net/netfilter/nf_conntrack_netlink.c               |   3 +
 net/netfilter/nft_exthdr.c                         |   3 +
 net/netfilter/nft_nat.c                            |   4 +-
 net/netfilter/nft_osf.c                            |   5 +
 net/netfilter/nft_tproxy.c                         |   9 +-
 net/netlabel/netlabel_mgmt.c                       |  19 ++--
 net/netrom/nr_timer.c                              |  20 ++--
 net/sched/act_api.c                                |   5 +-
 net/sched/act_ct.c                                 |   3 +-
 net/sched/act_skbmod.c                             |  12 +-
 net/sched/act_vlan.c                               |   7 +-
 net/sched/cls_api.c                                |   2 +-
 net/sched/cls_tcindex.c                            |   7 +-
 net/sched/sch_qfq.c                                |   8 +-
 net/sctp/auth.c                                    |   2 +
 net/sctp/bind_addr.c                               |  19 ++--
 net/sctp/input.c                                   |   8 +-
 net/sctp/ipv6.c                                    |   7 +-
 net/sctp/protocol.c                                |  10 +-
 net/sctp/sm_make_chunk.c                           |  29 ++---
 net/sunrpc/sched.c                                 |  12 +-
 net/tipc/socket.c                                  |   9 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/unix/af_unix.c                                 |  51 ++++++++-
 net/vmw_vsock/af_vsock.c                           |   2 +-
 net/wireless/scan.c                                |   6 +-
 net/wireless/wext-spy.c                            |  14 +--
 net/xfrm/xfrm_state.c                              |  14 ++-
 net/xfrm/xfrm_user.c                               |  28 ++---
 samples/bpf/xdp_redirect_user.c                    |   2 +-
 scripts/Kbuild.include                             |   7 +-
 scripts/Makefile.build                             |   9 +-
 scripts/mkcompile_h                                |  14 ++-
 scripts/tools-support-relr.sh                      |   3 +-
 security/integrity/evm/evm_main.c                  |   5 +-
 security/integrity/evm/evm_secfs.c                 |  13 ++-
 security/integrity/platform_certs/load_uefi.c      |   5 -
 security/selinux/avc.c                             |  13 ++-
 security/smack/smackfs.c                           |   2 +
 sound/ac97/bus.c                                   |   2 +-
 sound/firewire/Kconfig                             |   5 +-
 sound/firewire/bebob/bebob.c                       |   5 +-
 sound/firewire/oxfw/oxfw.c                         |   2 +-
 sound/isa/cmi8330.c                                |   2 +-
 sound/isa/sb/sb16_csp.c                            |  12 +-
 sound/pci/hda/hda_tegra.c                          |   3 +
 sound/pci/hda/patch_hdmi.c                         |   1 +
 sound/pci/hda/patch_realtek.c                      |  43 ++++++--
 sound/pci/intel8x0.c                               |   2 +-
 sound/ppc/powermac.c                               |   6 +-
 sound/soc/atmel/atmel-i2s.c                        |  34 ++++--
 sound/soc/codecs/cs42l42.h                         |   2 +-
 sound/soc/codecs/rk3328_codec.c                    |  28 ++++-
 sound/soc/codecs/rt5631.c                          |   2 +
 sound/soc/hisilicon/hi6210-i2s.c                   |  14 ++-
 sound/soc/img/img-i2s-in.c                         |   2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c      |   4 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   2 +-
 sound/soc/mediatek/common/mtk-btcvsd.c             |  24 +++-
 sound/soc/sh/rcar/adg.c                            |   4 +-
 sound/soc/soc-core.c                               |   2 +-
 sound/soc/tegra/tegra_alc5632.c                    |   1 +
 sound/soc/tegra/tegra_max98090.c                   |   1 +
 sound/soc/tegra/tegra_rt5640.c                     |   1 +
 sound/soc/tegra/tegra_rt5677.c                     |   1 +
 sound/soc/tegra/tegra_sgtl5000.c                   |   1 +
 sound/soc/tegra/tegra_wm8753.c                     |   1 +
 sound/soc/tegra/tegra_wm8903.c                     |   1 +
 sound/soc/tegra/tegra_wm9712.c                     |   1 +
 sound/soc/tegra/trimslice.c                        |   1 +
 sound/usb/format.c                                 |   2 +
 sound/usb/mixer.c                                  |  16 ++-
 sound/usb/mixer.h                                  |   1 +
 sound/usb/mixer_scarlett_gen2.c                    |  46 +++++---
 sound/usb/quirks.c                                 |   3 +
 sound/usb/usx2y/usb_stream.c                       |   7 +-
 tools/bpf/bpftool/common.c                         |   5 +
 tools/bpf/bpftool/jit_disasm.c                     |   6 +-
 tools/bpf/bpftool/main.c                           |   4 +-
 tools/perf/bench/sched-messaging.c                 |   4 +-
 tools/perf/builtin-inject.c                        |   8 +-
 tools/perf/builtin-script.c                        |   7 ++
 tools/perf/tests/bpf.c                             |   2 +
 tools/perf/tests/event_update.c                    |   2 +-
 tools/perf/tests/topology.c                        |   1 +
 tools/perf/util/data.c                             |   2 +-
 tools/perf/util/dso.c                              |   4 +-
 tools/perf/util/env.c                              |   1 +
 tools/perf/util/llvm-utils.c                       |   2 +
 tools/perf/util/lzma.c                             |   8 +-
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/probe-file.c                       |   4 +-
 tools/scripts/Makefile.include                     |  12 +-
 tools/testing/selftests/net/icmp_redirect.sh       |   5 +-
 .../selftests/powerpc/pmu/ebb/no_handler_test.c    |   2 -
 .../selftests/tc-testing/plugin-lib/scapyPlugin.py |   2 +-
 tools/testing/selftests/timers/rtcpie.c            |  10 +-
 tools/testing/selftests/vm/userfaultfd.c           |   6 +-
 tools/testing/selftests/x86/protection_keys.c      |   3 +-
 virt/kvm/coalesced_mmio.c                          |   2 +-
 virt/kvm/kvm_main.c                                |  28 +++++
 900 files changed, 6105 insertions(+), 3090 deletions(-)

