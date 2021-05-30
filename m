Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB713395328
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhE3WVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 18:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhE3WVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 18:21:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 15:19:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a5so13968597lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=66t5Ft70AYUueVRD2HVlg93M5fhKARAtHpiFGDKTFRc=;
        b=RJ/7GIJSHn4SRYBdd3419JhGwc7nYhpXlCgReWaZ4LgFKJ4uELKC+58iq5B9fZ2dL7
         Q/RbrZAW86U0BgfaZa8L+1k0CUUePLylf5CA28b9O9OBqjVFDVe67Ovf0f6x8P2eOGiP
         4BT+MjfU6vbvS73cFulqSAF5JyPsYXppIYfhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=66t5Ft70AYUueVRD2HVlg93M5fhKARAtHpiFGDKTFRc=;
        b=fgxIjIBhd2t6ArcUxPMXwi6pgOuyvOasr0ZyaBuyC9hBlQshJD/7XkD2n8GP4lQ5Up
         9AqanUvy/2z42s16caGYCQ4B7qBPf4TW/qm86PEmpVevLZi9IgFeycKhZN9MpHAuu/z9
         DVj5ggxqmGwCubVNGeSPisD33fXCyo3k/jFmeal5Ytgr3S0//TarE9z0vc/liF3iP67F
         9Rs/IAYojmqifwZsTeH6jwwCcrVE7WEWwrLTyhU2K46cQ+ocv5GnaNfFLnCD+qm+6F2A
         PLikI4GRC+ybxgjB4a/bi7/6nJzQnx+jGYhwoCOHAyKowXXIhWAhkJo/LlpjRWual3M4
         s8jw==
X-Gm-Message-State: AOAM532olhIpK27LQCqScTU1nDhGZJJmmBSuy2DwfFCcY+0kZoMMCFCT
        rVvnS2QVa1CBXLsjRkFmKAGlNBsnSY7N0Bky
X-Google-Smtp-Source: ABdhPJxd0kT8vgh7PKtqGeEM6VQureSUpqh5CRZ9XKpwyWaSAgKSpgM4iQpooLFwdaX3vx7Yeaw16w==
X-Received: by 2002:a05:6512:20c6:: with SMTP id u6mr13136016lfr.38.1622413171775;
        Sun, 30 May 2021 15:19:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r195sm372621lff.69.2021.05.30.15.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 15:19:31 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a4so12528050ljd.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 15:19:31 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr14142378lja.48.1622413170658;
 Sun, 30 May 2021 15:19:30 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 May 2021 12:19:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjKJ5Mw7P=U0AyhFJbGB+4TT=SE=tmf=md0cqEn527HFg@mail.gmail.com>
Message-ID: <CAHk-=wjKJ5Mw7P=U0AyhFJbGB+4TT=SE=tmf=md0cqEn527HFg@mail.gmail.com>
Subject: Linux 5.13-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So after two small rc releases, the other show finally dropped, and
rc4 is fairly sizable.

It's not the biggest rc4 we've ever had, but it's certainly up there,
believably competing for the title.

That said, exactly because of the calm rc2 and rc3, the size of rc4
doesn't worry me, and I think the 5.13 release looks fairly normal.
This bump is just because we had some stable work finally hit my tree.
Notably the networking tree, but there's a lot of driver tree fixes
too.

The fixes are fairly spread out, and mostly small. Some of the bigger
chunks are for new self tests (both bpf and kvm), and outside of those
new tests the diffstat looks nice and flat (ie lots of smaller changes
rather than big peaks). Networking (both core and drivers) does stand
out, but there are filesystem fixes too (xfs, nfs, cifs), various
random driver subsystems (sound, i2c, tty, usb, iio, scsi, spi..). And
some arch updates (mostly kvm-related, but small arm64, s390, MIPS
fixes - and some powerpc perf event descriptions too).

Please do go test, and let's make sure 5.13 is solid.

                Linus

---

Aditya Srivastava (2):
      net: encx24j600: fix kernel-doc syntax in file headers
      NFC: nfcmrvl: fix kernel-doc syntax in file headers

Adrian Hunter (7):
      perf intel-pt: Fix transaction abort handling
      perf intel-pt: Fix sample instruction bytes
      perf intel-pt: Remove redundant setting of ptq->insn_len
      perf scripts python: exported-sql-viewer.py: Fix copy to
clipboard from Top Calls by elapsed Time report
      perf scripts python: exported-sql-viewer.py: Fix Array TypeError
      perf scripts python: exported-sql-viewer.py: Fix warning display
      perf script: Add missing PERF_IP_FLAG_CHARS for VM-Entry and VM-Exit

Alain Volmat (1):
      MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer

Alan Stern (1):
      USB: usbfs: Don't WARN about excessively large memory allocations

Aleksander Jan Bajkowski (1):
      net: lantiq: fix memory corruption in RX ring

Alex Elder (1):
      net: ipa: memory region array is variable size

Alexander Usyskin (1):
      mei: request autosuspend after sending rx flow control

Alexandru Ardelean (1):
      iio: adc: ad7192: handle regulator voltage error first

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: Fix kernel-doc warning

Andrew Jeffery (2):
      serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
      serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

Andrii Nakryiko (2):
      bpf: Prevent writable memory-mapping of read-only ringbuf pages
      selftests/bpf: Test ringbuf mmap read-only and read-write restriction=
s

Andy Gospodarek (1):
      bnxt_en: Include new P5 HV definition in VF check.

Andy Shevchenko (4):
      spi: Switch to signed types for *_native_cs SPI controller fields
      spi: Assume GPIO CS active high in ACPI case
      usb: typec: tcpm: Use LE to CPU conversion when accessing msg->header
      iio: dac: ad5770r: Put fwnode in error case during ->probe()

Anirudh Rayabharam (1):
      video: hgafb: correctly handle card detect failure during probe

Anna Schumaker (1):
      NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_ret=
urn()

Ariel Levkovich (1):
      net/mlx5: Set term table as an unmanaged flow table

Arnaldo Carvalho de Melo (6):
      libbpf: Provide GELF_ST_VISIBILITY() define for older libelf
      tools arch kvm: Sync kvm headers with the kernel sources
      perf parse-events: Check if the software events array slots are popul=
ated
      tools headers UAPI: Sync linux/fs.h with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      tools headers UAPI: Sync files changed by the quotactl_path unwiring

Arnd Bergmann (1):
      ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency

Aurelien Aptel (2):
      cifs: set server->cipher_type to AES-128-CCM for SMB3.0
      cifs: change format of CIFS_FULL_KEY_DUMP ioctl

Axel Rasmussen (9):
      KVM: selftests: trivial comment/logging fixes
      KVM: selftests: simplify setup_demand_paging error handling
      KVM: selftests: compute correct demand paging size
      KVM: selftests: allow different backing source types
      KVM: selftests: refactor vm_mem_backing_src_type flags
      KVM: selftests: add shmem backing source type
      KVM: selftests: create alias mappings when using shared memory
      KVM: selftests: allow using UFFD minor faults for demand paging
      KVM: selftests: add shared hugetlbfs backing source type

Aya Levin (1):
      net/mlx5e: Fix error path of updating netdev queues

Ayush Sawal (1):
      cxgb4/ch_ktls: Clear resources when pf4 device is removed

Bixuan Cui (2):
      ASoC: codecs: lpass-tx-macro: add missing MODULE_DEVICE_TABLE
      iommu/virtio: Add missing MODULE_DEVICE_TABLE

Bjorn Andersson (2):
      usb: typec: mux: Fix matching with typec_altmode_desc
      usb: typec: ucsi: Clear pending after acking connector change

Bodo Stroesser (1):
      scsi: target: tcmu: Fix xarray RCU warning

Catalin Marinas (1):
      arm64: Fix stale link in the arch_counter_enforce_ordering() comment

Catherine Sullivan (2):
      gve: Check TX QPL was actually assigned
      gve: Upgrade memory barrier in poll routine

Charles Keepax (5):
      ASoC: cs53l30: Add missing regmap use_single config
      ASoC: cs42l73: Add missing regmap use_single config
      ASoC: cs35l34: Add missing regmap use_single config
      ASoC: cs35l32: Add missing regmap use_single config
      ASoC: cs42l52: Minor tidy up of error paths

Chen Huang (1):
      riscv: stacktrace: fix the riscv stacktrace when
CONFIG_FRAME_POINTER enabled

Chris Packham (4):
      dt-bindings: i2c: mpc: Add fsl,i2c-erratum-a004447 flag
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P2041 i2c controlle=
rs
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P1010 i2c controlle=
rs
      i2c: mpc: implement erratum A-004447 workaround

Christian Gmeiner (1):
      serial: 8250_pci: handle FL_NOIRQ board flag

Christoph Hellwig (1):
      md/raid5: remove an incorrect assert in in_chunk_boundary

Christophe JAILLET (5):
      spi: spi-fsl-dspi: Fix a resource leak in an error handling path
      net: netcp: Fix an error message
      ptp: ocp: Fix a resource leak in an error handling path
      net: mdio: thunder: Fix a double free issue in the .remove function
      net: mdio: octeon: Fix some double free issues

Chuck Lever (1):
      xprtrdma: Revert 586a0787ce35

Chunyan Zhang (1):
      spi: sprd: Add missing MODULE_DEVICE_TABLE

Colin Ian King (2):
      serial: tegra: Fix a mask operation that is always true
      i2c: qcom-geni: fix spelling mistake "unepxected" -> "unexpected"

DENG Qingfang (1):
      net: dsa: mt7530: fix VLAN traffic leaks

Dan Carpenter (10):
      net: dsa: fix a crash if ->get_sset_count() fails
      octeontx2-pf: fix a buffer overflow in otx2_set_rxfh_context()
      chelsio/chtls: unlock on error in chtls_pt_recvmsg()
      net: hso: check for allocation failure in hso_create_bulk_serial_devi=
ce()
      net: mdiobus: get rid of a BUG_ON()
      iommu/vt-d: Check for allocation failure in aux_detach_device()
      staging: emxx_udc: fix loop in _nbu2ss_nuke()
      NFS: fix an incorrect limit in filelayout_decode_layout()
      ASoC: cs35l33: fix an error code in probe()
      scsi: libsas: Use _safe() loop in sas_resume_port()

Daniel Borkmann (9):
      bpf: Fix alu32 const subreg bound tracking on bitwise operations
      bpf, kconfig: Add consolidated menu entry for bpf with core options
      bpf: Add kconfig knob for disabling unpriv bpf by default
      bpf: Fix BPF_JIT kconfig symbol dependency
      bpf: Fix BPF_LSM kconfig symbol dependency
      bpf: Wrap aux data inside bpf_sanitize_info container
      bpf: Fix mask direction swap upon off reg sign change
      bpf: No need to simulate speculative domain for immediates
      bpf, selftests: Adjust few selftest result_unpriv outcomes

Daniele Palmas (1):
      USB: serial: option: add Telit LE910-S1 compositions 0x7010, 0x7011

Darrick J. Wong (4):
      xfs: check free AG space when making per-AG reservations
      xfs: standardize extent size hint validation
      xfs: validate extsz hints against rt extent size when rtinherit is se=
t
      xfs: add new IRC channel to MAINTAINERS

Dave Chinner (2):
      xfs: btree format inode forks can have zero extents
      xfs: bunmapi has unnecessary AG lock ordering issues

David Awogbemila (3):
      gve: Update mgmt_msix_idx if num_ntfy changes
      gve: Add NULL pointer checks when freeing irqs.
      gve: Correct SKB queue index validation.

David Howells (3):
      netfs: Pass flags through to grab_cache_page_write_begin()
      netfs: Make CONFIG_NETFS_SUPPORT auto-selected rather than manual
      afs: Fix the nlink handling of dir-over-dir rename

David Matlack (6):
      selftests: Add .gitignore for nci test suite
      KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()
      KVM: selftests: Ignore CPUID.0DH.1H in get_cpuid_test
      KVM: selftests: Fix hang in hardware_disable_test
      KVM: selftests: Print a message if /dev/kvm is missing
      KVM: x86/mmu: Fix comment mentioning skip_4k

Davide Caratti (3):
      net/sched: fq_pie: re-factor fix for fq_pie endless loop
      net/sched: fq_pie: fix OOB access in the traffic path
      mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer

Dima Chumak (3):
      net/mlx5e: Fix nullptr in add_vlan_push_action()
      net/mlx5e: Fix nullptr in mlx5e_tc_add_fdb_flow()
      net/mlx5e: Fix multipath lag activation

Dinghao Liu (1):
      usb: cdns3: Fix runtime PM imbalance on error

Dmitry Bogdanov (1):
      scsi: target: qla2xxx: Wait for stop_phase1 at WWN removal

Dominik Andreas Schorpp (1):
      USB: serial: ftdi_sio: add IDs for IDS GmbH Products

Dongliang Mu (2):
      NFC: nci: fix memory leak in nci_allocate_device
      misc/uss720: fix memory leak in uss720_probe

Eli Cohen (1):
      {net,vdpa}/mlx5: Configure interface MAC into mpfs L2 table

Eric Farman (3):
      vfio-ccw: Check initialized flag in cp_init()
      vfio-ccw: Reset FSM state to IDLE inside FSM
      vfio-ccw: Serialize FSM IDLE state with I/O completion

Evan Quan (1):
      drm/amd/pm: correct MGpuFanBoost setting

Fabio Estevam (1):
      usb: Restore the usb_header label

Felix Fietkau (1):
      perf jevents: Fix getting maximum number of fds

Florent Revest (3):
      bpf: Fix nested bpf_bprintf_prepare with more per-cpu buffers
      bpf: Clarify a bpf_bprintf_prepare macro
      bpf: Avoid using ARRAY_SIZE on an uninitialized pointer

Florian Fainelli (2):
      net: dsa: bcm_sf2: Fix bcm_sf2_reg_rgmii_cntrl() call for non-RGMII p=
ort
      net: phy: Document phydev::dev_flags bits allocation

Francesco Ruggeri (1):
      ipv6: record frag_max_size in atomic fragments in input path

Fugang Duan (2):
      net: fec: fix the potential memory leak in fec_enet_init()
      net: fec: add defer probe for of_get_mac_address

Geert Uytterhoeven (6):
      spi: altera: Make SPI_ALTERA_CORE invisible
      serial: sh-sci: Fix off-by-one error in FIFO threshold register setti=
ng
      dt-bindings: net: renesas,ether: Update Sergei's email address
      i2c: icy: Remove unused variable new_fwnode in icy_probe()
      i2c: I2C_HISI should depend on ACPI
      i2c: sh_mobile: Use new clock calculation formulas for RZ/G2E

Geoffrey D. Bennett (2):
      ALSA: usb-audio: scarlett2: Fix device hang with ehci-pci
      ALSA: usb-audio: scarlett2: Improve driver startup messages

George McCollister (2):
      net: hsr: fix mac_len checks
      net: dsa: microchip: enable phy errata workaround on 9567

Greg Kroah-Hartman (2):
      kgdb: fix gcc-11 warnings harder
      Revert "serial: 8250: 8250_omap: Fix possible interrupt storm"

Guoqing Jiang (1):
      nvme: fix potential memory leaks in nvme_cdev_add

Gustavo A. R. Silva (1):
      afs: Fix fall-through warnings for Clang

Hannes Reinecke (2):
      nvme-fc: short-circuit reconnect retries
      nvme-fabrics: decode host pathing error for connect

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Glavey TM800A550L tablet
      ASoC: Intel: bytcr_rt5640: Add quirk for the Lenovo Miix 3-830 tablet

Hayes Wang (1):
      r8152: check the informaton of the device

Hoang Le (2):
      tipc: make node link identity publish thread safe
      Revert "net:tipc: Fix a double free in tipc_sk_mcast_rcv"

Hou Pu (1):
      nvmet-tcp: fix inline data size comparison in nvmet_tcp_queue_respons=
e

Huazhong Tan (1):
      net: hns3: fix user's coalesce configuration lost issue

Hui Wang (2):
      ALSA: hda/realtek: Headphone volume is controlled by Front mixer
      ALSA: hda/realtek: the bass speaker can't output sound on Yoga 9i

Huilong Deng (1):
      nfs: Remove trailing semicolon in macros

Ian Rogers (2):
      libbpf: Add NULL check to add_dummy_ksym_var
      perf debug: Move debug initialization earlier

Imre Deak (1):
      drm/i915: Reenable LTTPR non-transparent LT mode for DPCD_REV<1.4

Ioana Ciornei (1):
      MAINTAINERS: remove Ioana Radulescu from dpaa2-eth

Jakub Kicinski (1):
      mlx5e: add add missing BH locking around napi_schdule()

James Zhu (7):
      drm/amdgpu/vcn1: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.0: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.5: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn3: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg2.0: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg2.5: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg3: add cancel_delayed_work_sync before power gate

Javed Hasan (1):
      scsi: bnx2fc: Return failure if io_req is already in ABTS processing

Jean Delvare (1):
      i2c: i801: Don't generate an interrupt on bus reset

Jean-Philippe Brucker (1):
      iommu/amd: Clear DMA ops when switching domain

Jeimon (1):
      net/nfc/rawsock.c: fix a permission check bug

Jeremy Szu (4):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP 855 G8
      ALSA: hda/realtek: fix mute/micmute LEDs and speaker for HP Zbook G8
      ALSA: hda/realtek: fix mute/micmute LEDs and speaker for HP
Zbook Fury 15 G8
      ALSA: hda/realtek: fix mute/micmute LEDs and speaker for HP
Zbook Fury 17 G8

Jerome Brunet (2):
      ASoC: stm32: do not request a new clock consummer reference
      ASoC: da7219: do not request a new clock consummer reference

Jesse Brandeburg (1):
      ixgbe: fix large MTU request from VF

Jian Shen (1):
      net: hns3: put off calling register_netdev() until client
initialize complete

Jianbo Liu (1):
      net/mlx5: Set reformat action when needed for termination rules

Jiapeng Chong (1):
      bnx2x: Fix missing error code in bnx2x_iov_init_one()

Jiaran Zhang (1):
      net: hns3: fix incorrect resp_msg issue

Jim Ma (1):
      tls splice: check SPLICE_F_NONBLOCK instead of MSG_DONTWAIT

Jiri Olsa (2):
      bpf: Forbid trampoline attach for functions with variable arguments
      bpf: Add deny list of btf ids check for tracing programs

Jisheng Zhang (3):
      riscv: kprobes: Fix build error when MMU=3Dn
      riscv: kexec: Fix W=3D1 build warnings
      arm64: mm: don't use CON and BLK mapping if KFENCE is enabled

Joakim Zhang (3):
      net: stmmac: Fix MAC WoL not working if PHY does not support WoL
      net: stmmac: correct clocks enabled in stmmac_vlan_rx_kill_vid()
      net: stmmac: fix system hang if change mac address after interface if=
down

Joe Richey (1):
      KVM: X86: Use _BITUL() macro in UAPI headers

Johan Hovold (4):
      net: hso: bail out on interrupt URB allocation failure
      ALSA: usb-audio: fix control-request direction
      USB: trancevibrator: fix control-request direction
      net: hso: fix control-request directions

Johannes Berg (7):
      mac80211: drop A-MSDUs on old ciphers
      mac80211: add fragment cache to sta_info
      mac80211: check defrag PN against current frame
      mac80211: prevent attacks on TKIP/WEP as well
      mac80211: do not accept/forward invalid EAPOL frames
      bonding: init notify_work earlier to avoid uninitialized use
      netlink: disable IRQs for netlink_lock_table()

John Keeping (1):
      dm verity: fix require_signatures module_param permissions

Jonathan Cameron (5):
      iio: adc: ad7124: Fix missbalanced regulator enable / disable on erro=
r.
      iio: adc: ad7124: Fix potential overflow due to non sequential
channel numbers
      iio: adc: ad7192: Avoid disabling a clock that was never enabled.
      iio: adc: ad7768-1: Fix too small buffer passed to
iio_push_to_buffers_with_timestamp()
      iio: adc: ad7923: Fix undersized rx buffer.

Jonathan Davies (1):
      net: cdc_eem: fix URL to CDC EEM 1.0 spec

Julian Wiedmann (2):
      net/smc: remove device from smcd_dev_list after failed device_add()
      MAINTAINERS: s390/net: add netdev list

Jussi Maki (3):
      selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.=
c
      bpf: Set mac_len in bpf_skb_change_head
      selftests/bpf: Add test for l3 use of bpf_redirect_peer

Kajol Jain (1):
      perf vendor events powerpc: Fix eventcode of power10 JSON events

Karen Dombroski (1):
      spi: spi-zynq-qspi: Fix stack violation bug

Kees Cook (1):
      proc: Check /proc/$pid/attr/ writes against file opener

Kefeng Wang (1):
      riscv: Select ARCH_USE_MEMTEST

Kevin Wang (1):
      drm/amdkfd: correct sienna_cichlid SDMA RLC register offset error

Krzysztof Kozlowski (5):
      MAINTAINERS: nfc: drop Cl=C3=A9ment Perrochaud from NXP-NCI
      MAINTAINERS: nfc: add Krzysztof Kozlowski as maintainer
      MAINTAINERS: nfc: include linux-nfc mailing list
      MAINTAINERS: net: remove stale website link
      i2c: s3c2410: fix possible NULL pointer deref on read message after w=
rite

Kuninori Morimoto (5):
      ASoC: simple-card: add simple_parse_node()
      ASoC: simple-card: add simple_link_init()
      ASoC: audio-graph: tidyup graph_dai_link_of_dpcm()
      ASoC: audio-graph: tidyup graph_parse_node()
      ASoC: soc-dai.h: Align the word of comment for SND_SOC_DAIFMT_CBC_CFC

Kyle Tso (2):
      usb: typec: tcpm: Properly interrupt VDM AMS
      usb: typec: tcpm: Respond Not_Supported if no snk_vdo

Lee Jones (10):
      i2c: busses: i2c-nomadik: Fix formatting issue pertaining to 'timeout=
'
      i2c: muxes: i2c-arb-gpio-challenge: Demote non-conformant
kernel-doc headers
      i2c: busses: i2c-ali1563: File headers are not good candidates
for kernel-doc
      i2c: busses: i2c-cadence: Fix incorrectly documented 'enum
cdns_i2c_slave_mode'
      i2c: busses: i2c-designware-master: Fix misnaming of
'i2c_dw_init_master()'
      i2c: busses: i2c-eg20t: Fix 'bad line' issue and provide
description for 'msgs' param
      i2c: busses: i2c-ocores: Place the expected function names into
the documentation headers
      i2c: busses: i2c-pnx: Provide descriptions for 'alg_data' data struct=
ure
      i2c: busses: i2c-st: Fix copy/paste function misnaming issues
      i2c: busses: i2c-stm32f4: Remove incorrectly placed ' ' from function=
 name

Leilk Liu (1):
      spi: take the SPI IO-mutex in the spi_set_cs_timing method

Leon Romanovsky (1):
      net/mlx5: Don't overwrite HCA capabilities when setting MSI-X count

Li Jun (1):
      usb: chipidea: udc: assign interrupt number to USB gadget structure

Linus Torvalds (1):
      Linux 5.13-rc4

Liu Jian (1):
      bpftool: Add sock_release help info for cgroup attach/prog load comma=
nd

Lu Baolu (1):
      iommu/vt-d: Use user privilege for RID2PASID translation

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Lukas Bulwahn (1):
      MAINTAINERS: adjust to removing i2c designware platform data

Maciej S. Szmigiero (2):
      KVM: selftests: Keep track of memslots more efficiently
      KVM: selftests: add a memslot-related performance benchmark

Magnus Karlsson (1):
      samples/bpf: Consider frame size in tx_only of xdpsock sample

Maor Gottlieb (1):
      {net, RDMA}/mlx5: Fix override of log_max_qp by other device

Marc Zyngier (4):
      KVM: arm64: Move __adjust_pc out of line
      KVM: arm64: Commit pending PC adjustemnts before returning to userspa=
ce
      KVM: arm64: Fix debug register indexing
      KVM: arm64: Prevent mixed-width VM creation

Marcelo Tosatti (3):
      KVM: x86: add start_assignment hook to kvm_x86_ops
      KVM: rename KVM_REQ_PENDING_TIMER to KVM_REQ_UNBLOCK
      KVM: VMX: update vcpu posted-interrupt descriptor when assigning devi=
ce

Marco Elver (2):
      init: verify that function is initcall_t at compile-time
      io_uring: fix data race to avoid potential NULL-deref

Marco Felsch (1):
      ASoC: max98088: fix ni clock divider calculation

Markus Bloechl (1):
      net: lan78xx: advertise tx software timestamping support

Martin KaFai Lau (1):
      bpf: Limit static tcp-cc functions in the .BTF_ids list to x86

Mathias Nyman (4):
      thunderbolt: dma_port: Fix NVM read buffer bounds and offset issue
      thunderbolt: usb4: Fix NVM read buffer bounds and offset issue
      xhci: fix giving back URB with incorrect status regression in 5.12
      xhci: Fix 5.12 regression of missing xHC cache clearing command
after a Stall

Mathy Vanhoef (4):
      mac80211: assure all fragments are encrypted
      mac80211: prevent mixed key and fragment cache attacks
      mac80211: properly handle A-MSDUs that start with an RFC 1042 header
      cfg80211: mitigate A-MSDU aggregation attacks

Matt Wang (1):
      scsi: vmw_pvscsi: Set correct residual data length

Maximilian Luz (1):
      serial: 8250_dw: Add device HID for new AMD UART controller

Michael Chan (2):
      bnxt_en: Fix and improve .ndo_features_check().
      bnxt_en: Fix context memory setup for 64K page size.

Michael Walle (2):
      net: dsa: felix: re-enable TAS guard band mode
      dt-bindings: spi: spi-mux: rename flash node

Mike Christie (1):
      scsi: target: iblock: Fix smp_processor_id() BUG messages

Mikulas Patocka (2):
      dm snapshot: revert "fix a crash when an origin has no snapshots"
      dm snapshot: properly fix a crash when an origin has no snapshots

Milian Wolff (1):
      perf buildid-list: Initialize zstd_data

Miquel Raynal (7):
      mtd: rawnand: cs553x: Fix external use of SW Hamming ECC helper
      mtd: rawnand: fsmc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: lpc32xx_slc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: ndfc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: sharpsl: Fix external use of SW Hamming ECC helper
      mtd: rawnand: tmio: Fix external use of SW Hamming ECC helper
      mtd: rawnand: txx9ndfmc: Fix external use of SW Hamming ECC helper

Nadav Amit (1):
      iommu/amd: Fix wrong parentheses on page-specific invalidations

Namhyung Kim (2):
      perf tools: Add 'cgroup-switches' software event
      perf stat: Fix error check for bpf_program__attach

Neil Armstrong (1):
      drm/meson: fix shutdown crash when component not probed

NeilBrown (1):
      SUNRPC in case of backlog, hand free slots directly to waiting task

Nick Desaulniers (1):
      Makefile: LTO: have linker check -Wframe-larger-than

Nikolay Borisov (2):
      percpu_ref: Don't opencode percpu_ref_is_dying
      MAINTAINERS: Add lib/percpu* as part of percpu entry

Norbert Slusarek (1):
      can: isotp: prevent race between isotp_bind() and isotp_setsockopt()

Ondrej Mosnacek (2):
      serial: core: fix suspicious security_locked_down() call
      debugfs: fix security_locked_down() call for SELinux

Paolo Abeni (5):
      mptcp: fix data stream corruption
      net: really orphan skbs tied to closing sk
      mptcp: avoid OOB access in setsockopt()
      mptcp: drop unconditional pr_warn on bad opt
      mptcp: avoid error message on infinite mapping

Paolo Bonzini (4):
      KVM: SVM: make the avic parameter a bool
      selftests: kvm: fix potential issue with ELF loading
      selftests: kvm: do only 1 memslot_perf_test run by default
      selftests: kvm: fix overlapping addresses in memslot_perf_test

Parav Pandit (1):
      net/mlx5: SF, Fix show state inactive when its inactivated

Pavel Begunkov (1):
      io_uring/io-wq: close io-wq full-stop gap

Pavel Skripkin (1):
      net: usb: fix memory leak in smsc75xx_bind

Pawel Laszczak (1):
      usb: cdnsp: Fix lack of removing request from pending list.

Peter Ujfalusi (1):
      ALSA: hda/realtek: Chain in pop reduction fixup for ThinkStation P340

Qii Wang (1):
      i2c: mediatek: Disable i2c start_en and clear intr_stat brfore reset

Quentin Perret (2):
      KVM: arm64: Mark pkvm_pgtable_mm_ops static
      KVM: arm64: Mark the host stage-2 memory pools static

Rafael J. Wysocki (3):
      drivers: base: Fix device link removal
      drivers: base: Reduce device link removal code duplication
      ACPI: power: Refine turning off unused power resources

Rafa=C5=82 Mi=C5=82ecki (1):
      mtd: parsers: ofpart: fix parsing subpartitions

Raju Rangoju (1):
      cxgb4: avoid accessing registers when clearing filters

Randy Dunlap (3):
      MIPS: alchemy: xxs1500: add gpio-au1000.h header file
      MIPS: launch.h: add include guard to prevent build errors
      MIPS: ralink: export rt_sysc_membase for rt2880_wdt.c

Randy Wright (1):
      serial: 8250_pci: Add support for new HPE serial device

Ranjani Sridharan (1):
      ASoC: SOF: Intel: hda: don't send DAI_CONFIG IPC for older firmware

Rao Shoaib (1):
      RDS tcp loopback connection can hang

Richard Fitzgerald (1):
      ASoC: cs42l42: Regmap must use_single_read/write

Richard Sanger (1):
      net: packetmmap: fix only tx timestamp on request

Roi Dayan (4):
      netfilter: flowtable: Remove redundant hw refresh bit
      net/mlx5: Fix err prints and return when creating termination table
      net/mlx5e: Fix null deref accessing lag dev
      net/mlx5e: Make sure fib dev exists in fib event

Rolf Eike Beer (1):
      iommu/vt-d: Fix sysfs leak in alloc_iommu()

Rui Miguel Silva (1):
      iio: gyro: fxas21002c: balance runtime power in error path

Saeed Mahameed (1):
      net/mlx5e: reset XPS on error flow if netdev isn't registered yet

Sagi Grimberg (2):
      nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
      nvmet: fix false keep-alive timeout when a controller is torn down

Saravana Kannan (2):
      spi: Fix spi device unregister flow
      spi: Don't have controller clean up spi device before driver unbind

Sargun Dhillon (2):
      Documentation: seccomp: Fix user notification documentation
      seccomp: Refactor notification handler to prepare for new semantics

Saubhik Mukherjee (1):
      net: appletalk: cops: Fix data race in cops_probe1

Sean MacLennan (1):
      USB: serial: ti_usb_3410_5052: add startech.com device id

Sergey Senozhatsky (1):
      wq: handle VM suspension in stall detection

Shakeel Butt (1):
      cgroup: disable controllers at parse time

Shannon Nelson (1):
      ionic: fix ptp support config breakage

Shengjiu Wang (1):
      ASoC: ak5558: Correct the dai name for ak5552

Shin'ichiro Kawasaki (1):
      scsi: target: core: Avoid smp_processor_id() in preemptible code

Shuming Fan (1):
      ASoC: rt711-sdca: fix the function number of SDCA control for
feature unit 0x1E

Shyam Prasad N (1):
      cifs: fix string declarations and assignments in tracepoints

Simon Horman (1):
      nfp: update maintainer and mailing list addresses

Song Liu (1):
      perf stat: Skip evlist__[enable|disable] when all events uses BPF

Srinivas Kandagatla (2):
      ASoC: codecs: lpass-rx-macro: add missing MODULE_DEVICE_TABLE
      soundwire: qcom: fix handling of qcom,ports-block-pack-mode

Srinivas Pandruvada (1):
      thermal/drivers/intel: Initialize RW trip to THERMAL_TEMP_INVALID

Sriram R (3):
      ath10k: Validate first subframe of A-MSDU before processing the list
      ath11k: Clear the fragment cache during key install
      ath11k: Drop multicast fragments

Stanislav Fomichev (1):
      selftests/bpf: Convert static to global in tc_redirect progs

Stefan Chulski (1):
      net: mvpp2: add buffer header handling in RX

Stefan Haberland (1):
      s390/dasd: add missing discipline function

Stefan Roese (2):
      net: ethernet: mtk_eth_soc: Fix DIM support for MT7628/88
      net: ethernet: mtk_eth_soc: Fix packet statistics support for MT7628/=
88

Stefano Brivio (1):
      netfilter: nft_set_pipapo_avx2: Add irq_fpu_usable() check,
fallback to non-AVX2 version

Stephen Boyd (1):
      ASoC: qcom: lpass-cpu: Use optional clk APIs

Subbaraman Narayanamurthy (1):
      interconnect: qcom: bcm-voter: add a missing of_node_put()

Taehee Yoo (2):
      mld: fix panic in mld_newpack()
      sch_dsmark: fix a NULL deref in qdisc_reset()

Tao Liu (1):
      openvswitch: meter: fix race when getting now_ms.

Thadeu Lima de Souza Cascardo (1):
      bpf, ringbuf: Deny reserve of buffers larger than ringbuf

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly track pending and queued SG

Thomas Richter (1):
      perf test: Fix libpfm4 support (63) test error for nested event group=
s

Tiezhu Yang (1):
      MIPS: Fix kernel hang under FUNCTION_GRAPH_TRACER and PREEMPT_TRACER

Tom Rix (2):
      scsi: aic7xxx: Restore several defines for aic7xxx firmware build
      scsi: aic7xxx: Remove multiple definition of globals

Trond Myklebust (5):
      SUNRPC: Fix Oops in xs_tcp_send_request() when transport is disconnec=
ted
      SUNRPC: More fixes for backlog congestion
      NFS: Fix an Oopsable condition in __nfs_pageio_add_request()
      NFS: Don't corrupt the value of pg_bytes_written in nfs_do_recoalesce=
()
      NFS: Clean up reset of the mirror accounting variables

Vignesh Raghavendra (1):
      serial: 8250: 8250_omap: Fix possible interrupt storm

Vijendar Mukunda (1):
      ASoC: amd: fix for pcm_read() error

Vinicius Costa Gomes (1):
      MAINTAINERS: Add entries for CBS, ETF and taprio qdiscs

Vitaly Kuznetsov (2):
      KVM: SVM: Drop unneeded CONFIG_X86_LOCAL_APIC check
      KVM: VMX: Drop unneeded CONFIG_X86_LOCAL_APIC check

Vlad Buslov (2):
      net/mlx5e: Reject mirroring on source port change encap rules
      net: zero-initialize tc skb extension on allocation

Vladimir Oltean (9):
      net: dsa: fix error code getting shifted with 4 in
dsa_slave_get_sset_count
      spi: sc18is602: don't consider the chip select byte in
sc18is602_check_transfer
      spi: sc18is602: implement .max_{transfer,message}_size() for the
controller
      net: dsa: sja1105: fix VL lookup command packing for P/Q/R/S
      net: dsa: sja1105: call dsa_unregister_switch when allocating memory =
fails
      net: dsa: sja1105: add error handling in sja1105_setup()
      net: dsa: sja1105: error out on unsupported PHY mode
      net: dsa: sja1105: use 4095 as the private VLAN for untagged traffic
      net: dsa: sja1105: update existing VLANs from the bridge VLAN list

Vladyslav Tarasiuk (1):
      net/mlx4: Fix EEPROM dump support

Wanpeng Li (7):
      KVM: PPC: exit halt polling on need_resched()
      KVM: X86: Bail out of direct yield in case of under-committed scenari=
os
      KVM: X86: Fix vCPU preempted state from guest's point of view
      KVM: X86: hyper-v: Task srcu lock when accessing kvm_memslots()
      KVM: LAPIC: Narrow the timer latency between wait_lapic_expire
and world switch
      KVM: X86: Fix warning caused by stale emulation context
      KVM: X86: Kill off ctxt->ud

Wei Yongjun (1):
      net: korina: Fix return value check in korina_probe()

Wen Gong (6):
      mac80211: extend protection against mixed key and fragment cache atta=
cks
      ath10k: add CCMP PN replay protection for fragmented frames for PCIe
      ath10k: drop fragments with multicast DA for PCIe
      ath10k: drop fragments with multicast DA for SDIO
      ath10k: drop MPDU which has discard flag set by firmware for SDIO
      ath10k: Fix TKIP Michael MIC verification for PCIe

Xin Long (5):
      tipc: skb_linearize the head skb when reassembling msgs
      tipc: wait and exit until all work queues are done
      tipc: simplify the finalize work queue
      sctp: add the missing setting for asoc encap_port
      sctp: fix the proc_handler for sysctl encap_port

Yang Li (3):
      pNFS/NFSv4: Remove redundant initialization of 'rd_size'
      thermal/ti-soc-thermal: Fix kernel-doc
      net: hns: Fix kernel-doc

Yang Yingliang (2):
      scsi: hisi_sas: Drop free_irq() of devm_request_irq() allocated irq
      thermal/drivers/qcom: Fix error code in adc_tm5_get_dt_channel_data()

Yinjun Zhang (1):
      bpf, offload: Reorder offload callback 'prepare' in verifier

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix a race in usb3_start_pipen()

Yuan Yao (1):
      KVM: X86: Use kvm_get_linear_rip() in single-step and #DB/#BP interce=
ption

YueHaibing (2):
      ethtool: stats: Fix a copy-paste error
      iio: adc: ad7793: Add missing error code in ad7793_setup()

Yunsheng Lin (4):
      net: sched: fix packet stuck problem for lockless qdisc
      net: sched: fix tx action rescheduling issue during deactivation
      net: sched: fix tx action reschedule issue with stopped queue
      net: hns3: check the return of skb_checksum_help()

Zenghui Yu (1):
      KVM: arm64: Resolve all pending PC updates before immediate exit

Zhang Xiaoxu (1):
      NFSv4: Fix v4.0/v4.1 SEEK_DATA return -ENOTSUPP when set NFS_V4_2 con=
fig

Zhen Lei (2):
      net: bnx2: Fix error return code in bnx2_init_board()
      cgroup: fix spelling mistakes

Zhenzhong Duan (1):
      selftests: kvm: make allocation of extra memory take effect

Zheyu Ma (3):
      isdn: mISDN: netjet: Fix crash in nj_probe:
      net/qla3xxx: fix schedule while atomic in ql_sem_spinlock
      serial: rp2: use 'request_firmware' instead of 'request_firmware_nowa=
it'

Zhu Lingshan (1):
      Revert "irqbypass: do not start cons/prod when failed connect"

Zolton Jheng (1):
      USB: serial: pl2303: add device id for ADLINK ND-6530 GC

Zong Li (1):
      net: macb: ensure the device is available before accessing
GEMGXL control registers

Zou Wei (2):
      interconnect: qcom: Add missing MODULE_DEVICE_TABLE
      ASoC: sti-sas: add missing MODULE_DEVICE_TABLE

Zqiang (1):
      io-wq: Fix UAF when wakeup wqe in hash waitqueue

kernel test robot (2):
      KVM: arm64: Fix boolreturn.cocci warnings
      ALSA: usb-audio: scarlett2: snd_scarlett_gen2_controls_create()
can be static

xinhui pan (1):
      drm/ttm: Skip swapout if ttm object is not populated

zhouchuangao (1):
      fs/nfs: Use fatal_signal_pending instead of signal_pending

=C3=8D=C3=B1igo Huguet (1):
      net:sfc: fix non-freed irq in legacy irq mode
