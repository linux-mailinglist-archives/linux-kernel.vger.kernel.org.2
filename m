Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D93418B33
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 23:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhIZVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:23:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69327C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:22:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so68135043lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rpIP7QVwXSoJFgkfrXTAER451W3tbukmcNX+f2AjzdA=;
        b=PFBuKBbaHGd3UlCg7yPMl42a97WeinuBC92IgUEAB1CRPWrPS+CvRkTdV0jxTZTUW8
         cqU2ib98LZLooV78J/7zsHglrUIVFnATHsrXMXmNZ54IorCf7PJ+wnXFGJuvsId2A6FT
         Oy12vrZt6oWjh0bkAKfPagrvvIVecKgsixrhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rpIP7QVwXSoJFgkfrXTAER451W3tbukmcNX+f2AjzdA=;
        b=2vn9eWbn64D9n+OyRoNLb+g3tlijsi4xI0bmvDpMVh43OtqK4urwAroBsFziBVi4Cw
         lTtHyiTiqflJuA4JPOFpKSc0comj5zdjjm1qrzXg9Xxk1PTl+XovlFHEfVQMl55CnQ+x
         ZU0B0IQWhhJXAOsTCsYiEu359HkKpg0MgMK0JK0MUiSLhjbU/x3T/ZNzFjviIVkTEOoU
         Srm1e3ojbVpMb0xjzfWg1lJcwp45IWeo/SjwOnpPN1BbXKQx5h3nCn6udrp+J8n6JIXZ
         zbeYyWOzNRwCooRZb1hcB7nYeEImAZXocA3AccQLwffeTSrIHv6xQbdsS6d+D9ylhEq7
         LzQA==
X-Gm-Message-State: AOAM531oWRqf82gIxdunUG0d2dTOaqgHzUY9CACVKohqM6HasinP0hWO
        jfeAKW6YEOOakDX6Q3vQJhsALw6OCN5MzTOUwho=
X-Google-Smtp-Source: ABdhPJwOQ5Fq1WhLWWvUOAWncl9LNOZy1ylY5SD+OnhV1okWwR+50w61zy+WP4gST80ehG/49s4qiQ==
X-Received: by 2002:a19:ae15:: with SMTP id f21mr20726993lfc.402.1632691329285;
        Sun, 26 Sep 2021 14:22:09 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b20sm1391079lfc.75.2021.09.26.14.22.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 14:22:08 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y26so28466598lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:22:08 -0700 (PDT)
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr21334394lfv.655.1632691328358;
 Sun, 26 Sep 2021 14:22:08 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Sep 2021 14:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
Message-ID: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
Subject: Linux 5.15-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So after a somewhat rocky merge window and second rc, things are now
actually looking pretty normal for rc3. Knock wood.

There are fixes all over, and the statistics look fairly regular, with
drivers dominating as they should (since they are most of the tree).
And outside of drivers, we have a fairly usual mix of changes -
architecture fixes, networking, filesystems, and tooling (the latter
being mostly kvm selftests).

Shortlog appended, it's not too long and easy to scan through to get a
flavor for the details if you happen to care.

Please do give it a whirl,

             Linus

---

Adam Borowski (1):
      mm/damon: don't use strnlen() with known-bogus source length

Adrian Hunter (2):
      scsi: ufs: ufs-pci: Fix Intel LKF link stability
      scsi: ufs: core: Revert "scsi: ufs: Synchronize SCSI and UFS
error handling"

Alejandro Concepcion-Rodriguez (1):
      docs: net: dsa: sja1105: fix reference to sja1105.txt

Alex Deucher (1):
      MAINTAINERS: fix up entry for AMD Powerplay

Alexandra Winter (2):
      s390/qeth: Fix deadlock in remove_discipline
      s390/qeth: fix deadlock during failing recovery

Andy Shevchenko (1):
      platform/x86/intel: punit_ipc: Drop wrong use of ACPI_PTR()

Ansuel Smith (1):
      thermal/drivers/tsens: Fix wrong check for tzd in irq handlers

Antoine Tenart (1):
      thermal/drivers/int340x: Do not set a wrong tcc offset on resume

Arnd Bergmann (4):
      ptp: ocp: add COMMON_CLK dependency
      staging: r8188eu: fix -Wrestrict warnings
      scsi: lpfc: Fix gcc -Wstringop-overread warning, again
      drm/amd/display: fix empty debug macros

Aya Levin (1):
      net/mlx4_en: Don't allow aRFS for encapsulated packets

Baokun Li (1):
      scsi: iscsi: Adjust iface sysfs attr detection

Bart Van Assche (2):
      scsi: sd_zbc: Support disks with more than 2**32 logical blocks
      scsi: ufs: core: Unbreak the reset handler

Bixuan Cui (1):
      irqdomain: Change the type of 'size' in __irq_domain_add() to be
consistent

Borislav Petkov (1):
      EDAC/dmc520: Assign the proper type to dimm->edac_mode

Carlo Lobrano (1):
      USB: serial: option: add Telit LN920 compositions

ChanWoo Lee (1):
      scsi: ufs: ufshpb: Remove unused parameters

Changbin Du (1):
      tools/vm/page-types: remove dependency on opt_file for idle page trac=
king

Chen Jun (1):
      mm: fix uninitialized use in overcommit_policy_handler

Chi Minghao (1):
      scsi: lpfc: Remove unneeded variable

Chris Wilson (1):
      drm/i915: Free all DMC payloads

Christian Lamparter (1):
      net: bgmac-bcma: handle deferred probe error due to mac-address

Christoph Hellwig (2):
      nvme: keep ctrl->namespaces ordered
      md: fix a lock order reversal in md_alloc

Christophe JAILLET (1):
      misc: genwqe: Fixes DMA mask setting

Chuck Lever (1):
      NLM: Fix svcxdr_encode_owner()

Claudiu Manoil (2):
      enetc: Fix illegal access when reading affinity_hint
      enetc: Fix uninitialized struct dim_sample field usage

Colin Foster (2):
      net: mscc: ocelot: remove buggy and useless write to ANA_PFC_PFC_CFG
      net: mscc: ocelot: remove buggy duplicate write to DEV_CLOCK_CFG

Colin Ian King (5):
      scsi: sr: Fix spelling mistake "does'nt" -> "doesn't"
      scsi: megaraid: Clean up some inconsistent indenting
      scsi: mpt3sas: Clean up some inconsistent indenting
      habanalabs: Fix spelling mistake "FEADBACK" -> "FEEDBACK"
      scsi: target: Fix spelling mistake "CONFLIFT" -> "CONFLICT"

Cristian Marussi (1):
      kselftest/arm64: signal: Skip tests if required features are missing

Dai Ngo (1):
      nfsd: back channel stuck in SEQ4_STATUS_CB_PATH_DOWN

Dan Carpenter (9):
      usb: gadget: r8a66597: fix a loop in set_feature()
      mcb: fix error handling in mcb_alloc_bus()
      thermal/core: Potential buffer overflow in
thermal_build_list_of_policies()
      usb: musb: tusb6010: uninitialized data in tusb_fifo_write_unaligned(=
)
      ceph: fix off by one bugs in unsafe_request_wait()
      cifs: fix a sign extension bug
      scsi: lpfc: Fix sprintf() overflow in lpfc_display_fpin_wwpn()
      scsi: lpfc: Use correct scnprintf() limit
      ext2: fix sleeping in atomic bugs on error

Daniel Wagner (1):
      nvme-fc: update hardware queues before using them

David Howells (9):
      afs: Fix missing put on afs_read objects and missing get on the
key therein
      afs: Fix page leak
      afs: Add missing vnode validation checks
      afs: Fix incorrect triggering of sillyrename on 3rd-party invalidatio=
n
      afs: Fix mmap coherency vs 3rd-party changes
      afs: Try to avoid taking RCU read lock when checking vnode validity
      afs: Fix corruption in reads at fpos 2G-4G from an OpenAFS server
      afs: Fix updating of i_blocks on file/dir extension
      cifs: Deal with some warnings from W=3D1

Dinh Nguyen (1):
      MAINTAINERS: update entry for NIOS2

Dmitry Baryshkov (1):
      regulator: qcom-rpmh-regulator: fix pm8009-1 ldo7 resource name

Dmitry Bogdanov (1):
      scsi: qla2xxx: Restore initiator in dual mode

Douglas Anderson (1):
      nvmem: core: Add stubs for nvmem_cell_read_variable_le_u32/64 if
!CONFIG_NVMEM

Faizel K B (1):
      usb: testusb: Fix for showing the connection speed

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: avoid creating duplicate offload entries

Filipe Manana (2):
      btrfs: fix transaction handle leak after verity rollback failure
      btrfs: fix mount failure due to past and transient device flush error

Florian Fainelli (1):
      net: dsa: bcm_sf2: Fix array overrun in bcm_sf2_num_active_ports()

Frederic Weisbecker (1):
      posix-cpu-timers: Prevent spuriously armed 0-value itimer

Gao Xiang (2):
      erofs: fix up erofs_lookup tracepoint
      erofs: fix misbehavior of unsupported chunk format check

Geert Uytterhoeven (4):
      nvmem: NVMEM_NINTENDO_OTP should depend on WII
      irqchip/renesas-rza1: Use semicolons instead of commas
      init: Revert accidental changes to print irqs_disabled()
      sh: pgtable-3level: fix cast to pointer from integer of different siz=
e

Guenter Roeck (4):
      spi: tegra20-slink: Declare runtime suspend and resume functions
conditionally
      usb: ehci: Simplify platform driver registration
      drm/nouveau/nvkm: Replace -ENOSYS with -ENODEV
      xtensa: increase size of gcc stack frame check

Guvenc Gulce (1):
      MAINTAINERS: remove Guvenc Gulce as net/smc maintainer

Hannes Reinecke (3):
      scsi: fas216: Kill scmd->tag
      scsi: acornscsi: Remove tagged queuing vestiges
      scsi: core: Remove 'current_tag'

Hans de Goede (3):
      platform/x86: touchscreen_dmi: Add info for the Chuwi HiBook
(CWI514) tablet
      platform/x86: touchscreen_dmi: Update info for the Chuwi Hi10
Plus (CWI527) tablet
      gpiolib: acpi: Make set-debounce-timeout failures non fatal

Hao Xu (3):
      io_uring: fix race between poll completion and cancel_hash insertion
      io_uring: fix missing set of EPOLLONESHOT for CQ ring overflow
      io_uring: fix potential req refcount underflow

Heiko Stuebner (2):
      gpio/rockchip: extended debounce support is only available on v2
      gpio/rockchip: fix get_direction value handling

Heiner Kallweit (1):
      scsi: sd: Make sd_spinup_disk() less noisy

Helge Deller (1):
      scsi: ncr53c8xx: Remove unused retrieve_from_waiting_list() function

Hyunchul Lee (2):
      ksmbd: prevent out of share access
      ksmbd: use LOOKUP_BENEATH to prevent the out of share access

Ian Abbott (1):
      comedi: Fix memory leak in compat_insnlist()

Ido Schimmel (2):
      nexthop: Fix division by zero while replacing a resilient group
      nexthop: Fix memory leaks in nexthop notification chain listeners

Ilya Leoshkevich (3):
      s390/bpf: Fix branch shortening during codegen pass
      s390/bpf: Fix 64-bit subtraction of the -0x80000000 constant
      s390/bpf: Fix optimizing out zero-extensions

Jack Pham (2):
      usb: gadget: f_uac2: Add missing companion descriptor for feedback EP
      usb: gadget: f_uac2: Populate SS descriptors' wBytesPerInterval

James Smart (6):
      scsi: elx: efct: Fix void-pointer-to-enum-cast warning for
efc_nport_topology
      scsi: lpfc: Fix CPU to/from endian warnings introduced by ELS process=
ing
      scsi: lpfc: Fix compilation errors on kernels with no CONFIG_DEBUG_FS
      scsi: elx: efct: Do not hold lock while calling fc_vport_terminate()
      nvme-fc: avoid race between time out and tear down
      nvme-fc: remove freeze/unfreeze around update_nr_hw_queues

Jan Beulich (8):
      xen-netback: correct success/error reporting for the
SKB-with-fraglist case
      xen/x86: drop redundant zeroing from cpu_initialize_context()
      Xen/gntdev: don't ignore kernel unmapping error
      swiotlb-xen: ensure to issue well-formed XENMEM_exchange requests
      PCI: only build xen-pcifront in PV-enabled environments
      xen/pci-swiotlb: reduce visibility of symbols
      swiotlb-xen: this is PV-only on x86
      xen/x86: fix PV trap handling on secondary processors

Jason Wang (1):
      virtio-net: fix pages leaking when building skb in big mode

Jens Axboe (5):
      scsi: Remove SCSI CDROM MAINTAINERS entry
      io-wq: ensure we exit if thread group is exiting
      io_uring: allow conditional reschedule for intensive iterators
      io_uring: put provided buffer meta data under memcg accounting
      io_uring: don't punt files update to io-wq unconditionally

Jia He (1):
      Revert "ACPI: Add memory semantics to acpi_os_map_memory()"

Jian Cai (1):
      coresight: syscfg: Fix compiler warning

Jian Shen (2):
      net: hns3: fix change RSS 'hfunc' ineffective issue
      net: hns3: fix inconsistent vf id print

Jiapeng Chong (1):
      fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()

Jiaran Zhang (1):
      net: hns3: fix misuse vf id and vport id in some logs

Jiashuo Liang (1):
      x86/fault: Fix wrong signal when vsyscall fails with pkey

Jiri Slaby (3):
      tty: unexport tty_ldisc_release
      MAINTAINERS: usb, update Peter Korsgaard's entries
      MAINTAINERS: ARM/VT8500, remove defunct e-mail

Johan Hovold (6):
      staging: greybus: uart: fix tty use after free
      USB: cdc-acm: fix minor-number release
      net: hso: fix muxed tty registration
      misc: bcm-vk: fix tty registration race
      USB: serial: cp210x: fix dropped characters with CP2102
      USB: serial: cp210x: add part-number debug printk

Jos=C3=A9 Exp=C3=B3sito (1):
      platform/x86/intel: hid: Add DMI switches allow list

Juergen Gross (2):
      xen/balloon: fix balloon kthread freezing
      x86/setup: Call early_reserve_memory() earlier

Julian Sikorski (1):
      Re-enable UAS for LaCie Rugged USB3-FW with fk quirk

Julian Wiedmann (1):
      s390/qeth: fix NULL deref in qeth_clear_working_pool_list()

Kaige Fu (1):
      irqchip/gic-v3-its: Fix potential VPE leak on error

Karsten Graul (2):
      net/smc: add missing error check in smc_clc_prfx_set()
      net/smc: fix 'workqueue leaked lock' in smc_conn_abort_work

Kees Cook (1):
      x86/asm: Fix SETZ size enqcmds() build failure

Kishon Vijay Abraham I (3):
      usb: core: hcd: Add support for deferring roothub registration
      xhci: Set HCD flag to defer primary roothub registration
      usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()

Konrad Rzeszutek Wilk (2):
      MAINTAINERS: Update SWIOTLB maintainership
      MAINTAINERS: Update Xen-[PCI,SWIOTLB,Block] maintainership

Krzysztof Kozlowski (4):
      regulator: max14577: Revert "regulator: max14577: Add proper
module aliases strings"
      net: freescale: drop unneeded MODULE_ALIAS
      USB: serial: mos7840: remove duplicated 0xac24 device ID
      USB: serial: option: remove duplicate USB device ID

Kunihiko Hayashi (1):
      gpio: uniphier: Fix void functions to remove return value

Lama Kayal (1):
      net/mlx4_en: Resolve bad operstate value

Laurentiu Tudor (1):
      software node: balance refcount for managed software nodes

Leon Romanovsky (1):
      init: don't panic if mount_nodev_root failed

Li Jun (1):
      usb: dwc3: core: balance phy init and exit

Li Li (1):
      binder: fix freeze race

Li Zhijian (1):
      selftests: be sure to make khdr before other targets

Lijo Lazar (1):
      drm/amd/pm: Update intermediate power state for SI

Linus Torvalds (3):
      sparc64: fix pci_iounmap() when CONFIG_PCI is not set
      qnx4: work around gcc false positive warning bug
      Linux 5.15-rc3

Liu Yuntao (1):
      mm/shmem.c: fix judgment error in shmem_is_huge()

Maarten Lankhorst (1):
      drm/i915: Move __i915_gem_free_object to ttm_bo_destroy

Marc Zyngier (3):
      Documentation: Fix irq-domain.rst build warning
      irqchip/armada-370-xp: Fix ack/eoi breakage
      irqchip/gic: Work around broken Renesas integration

Marco Elver (1):
      kasan: fix Kconfig check of CC_HAS_WORKING_NOSANITIZE_ADDRESS

Mario Limonciello (1):
      platform/x86: amd-pmc: Increase the response register timeout

Mark Brown (2):
      spi: Revert modalias changes
      nfc: st-nci: Add SPI ID matching DT compatible

Masanari Iida (1):
      Doc: networking: Fox a typo in ice.rst

Matan Ziv-Av (1):
      lg-laptop: Correctly handle dmi_get_system_info() returning NULL

Maurizio Lombardi (1):
      scsi: target: Fix the pgr/alua_support_store functions

Michael Chan (1):
      bnxt_en: Fix TX timeout when TX ring size is set to the smallest

Mike Galbraith (1):
      ksmbd: transport_rdma: Don't include rwlock.h directly

Miles Chen (1):
      scripts/sorttable: riscv: fix undeclared identifier 'EM_RISCV' error

Minas Harutyunyan (2):
      usb: dwc2: gadget: Fix ISOC flow for BDMA and Slave
      usb: dwc2: gadget: Fix ISOC transfer complete handling for DDMA

Minchan Kim (1):
      mm: fs: invalidate bh_lrus for only cold path

Ming Lei (3):
      scsi: sd: Free scsi_disk device via put_device()
      block: don't call rq_qos_ops->done_bio if the bio isn't tracked
      block: hold ->invalidate_lock in blkdev_fallocate

Namjae Jeon (4):
      ksmbd: add validation for FILE_FULL_EA_INFORMATION of smb2_get_info
      ksmbd: add default data stream name in FILE_STREAM_INFORMATION
      ksmbd: check protocol id in ksmbd_verify_smb_message()
      ksmbd: remove follow symlinks support

Naohiro Aota (1):
      scsi: sd_zbc: Ensure buffer size is aligned to SECTOR_SIZE

Naoya Horiguchi (1):
      mm, hwpoison: add is_free_buddy_page() in HWPoisonHandlable()

Nathan Chancellor (2):
      scsi: st: Add missing break in switch statement in st_ioctl()
      kasan: always respect CONFIG_KASAN_STACK

Nishanth Menon (1):
      serial: 8250: 8250_omap: Fix RX_LVL register offset

Numfor Mbiziwo-Tiapo (1):
      x86/insn, tools/x86: Fix undefined behavior due to potential
unaligned accesses

Oded Gabbay (1):
      habanalabs/gaudi: fix LBW RR configuration

Ofir Bitton (4):
      habanalabs: fix potential race in interrupt wait ioctl
      habanalabs: fail collective wait when not supported
      habanalabs: rate limit multi CS completion errors
      habanalabs: expose a single cs seq in staged submissions

Omer Shpigelman (1):
      habanalabs/gaudi: use direct MSI in single mode

Ondrej Zary (1):
      usb-storage: Add quirk for ScanLogic SL11R-IDE older than 2.6c

Pali Roh=C3=A1r (1):
      serial: mvebu-uart: fix driver's tx_empty callback

Paolo Abeni (1):
      mptcp: ensure tx skbs always have the MPTCP ext

Paul Menzel (1):
      lib/zlib_inflate/inffast: check config in C to avoid unused
function warning

Paul Moore (1):
      selinux,smack: fix subjective/objective credential use mixups

Pavel Begunkov (2):
      io_uring: kill extra checks in io_write()
      io_uring: make OP_CLOSE consistent with direct open

Pavel Hofman (1):
      usb: gadget: u_audio: EP-OUT bInterval in fback frequency

Pawel Laszczak (1):
      usb: cdns3: fix race condition before setting doorbell

Peter Collingbourne (1):
      arm64: add MTE supported check to thread switching and syscall entry/=
exit

Philip Yang (4):
      drm/amdkfd: SVM map to gpus check vma boundary
      drm/amdkfd: fix dma mapping leaking warning
      drm/amdkfd: handle svm migrate init error
      drm/amdkfd: fix svm_migrate_fini warning

Qi Zheng (1):
      mm/memory_failure: fix the missing pte_unmap() call

Qu Wenruo (2):
      btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error han=
dling
      btrfs: prevent __btrfs_dump_space_info() to underflow its free space

Radhakrishna Sripada (1):
      drm/i915: Update memory bandwidth parameters

Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "USB: bcma: Add a check for devm_gpiod_get"

Randy Dunlap (5):
      tty: synclink_gt: rename a conflicting function name
      igc: fix build errors for PTP
      platform/x86: dell: fix DELL_WMI_PRIVACY dependencies & build error
      irqchip/mbigen: Repair non-kernel-doc notation
      irqchip/goldfish-pic: Select GENERIC_IRQ_CHIP to fix build

Robert Marko (1):
      arm64: dts: qcom: ipq8074: remove USB tx-fifo-resize property

Robin Murphy (1):
      arm64: Mitigate MTE issues with str{n}cmp()

Rohith Surabattula (3):
      cifs: Deferred close performance improvements
      cifs: Fix soft lockup during fsstress
      cifs: Not to defer close on file when lock is set

Russ Weight (1):
      fpga: dfl: Avoid reads to AFU CSRs during enumeration

Sagi Grimberg (1):
      nvme-tcp: fix incorrect h2cdata pdu offset accounting

Sai Krishna Potthuri (1):
      EDAC/synopsys: Fix wrong value type assignment for edac_mode

Sean Christopherson (5):
      KVM: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM g=
uest
      entry: rseq: Call rseq_handle_notify_resume() in tracehook_notify_res=
ume()
      tools: Move x86 syscall number fallbacks to .../uapi/
      KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration =
bugs
      KVM: selftests: Remove __NR_userfaultfd syscall fallback

Sebastian Andrzej Siewior (1):
      mm: Fully initialize invalidate_lock, amend lock class later

Shai Malin (1):
      qed: rdma - don't wait for resources under hw error recovery flow

Shakeel Butt (1):
      memcg: flush lruvec stats in the refault

Shuah Khan (6):
      selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
      selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return wa=
rn
      selftests: kvm: move get_run_delay() into lib/test_util
      selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
      selftests: net: af_unix: Fix incorrect args in test result msg
      selftests: net: af_unix: Fix makefile to use TEST_GEN_PROGS

Slark Xiao (1):
      USB: serial: option: add device id for Foxconn T99W265

Sreekanth Reddy (1):
      scsi: mpt3sas: Call cpu_relax() before calling udelay()

Steve French (7):
      cifs: remove pathname for file from SPDX header
      cifs: fix incorrect kernel doc comments
      ksmbd: log that server is experimental at module load
      cifs: Clear modified attribute bit from inode flags
      smb3: correct smb3 ACL security descriptor
      smb3: correct server pointer dereferencing check to be more consisten=
t
      cifs: fix incorrect check for null pointer in header_assemble

Steven Lee (1):
      gpio: gpio-aspeed-sgpio: Fix wrong hwirq in irq handler.

Sudarsana Reddy Kalluru (1):
      atlantic: Fix issue in the pm resume flow.

Thomas Gleixner (1):
      net: core: Correct the sock::sk_lock.owned lockdep annotations

Tobias Jakobi (1):
      platform/x86: gigabyte-wmi: add support for B550I Aorus Pro AX

Tobias Schramm (1):
      spi: rockchip: handle zero length transfers without timing out

Todd Kjos (1):
      binder: make sure fd closes complete

Tom Rix (1):
      fpga: machxo2-spi: Return an error on failure

Uwe Brandt (1):
      USB: serial: cp210x: add ID for GW Instek GDM-834x Digital Multimeter

Vivek Goyal (1):
      init/do_mounts.c: Harden split_fs_names() against buffer overflow

Vladimir Oltean (11):
      net: update NXP copyright text
      net: mdio: introduce a shutdown method to mdio device drivers
      net: dsa: be compatible with masters which unregister on shutdown
      net: dsa: hellcreek: be compatible with masters which unregister
on shutdown
      net: dsa: microchip: ksz8863: be compatible with masters which
unregister on shutdown
      net: dsa: xrs700x: be compatible with masters which unregister on shu=
tdown
      net: dsa: tear down devlink port regions when tearing down the
devlink port on error
      net: dsa: fix dsa_tree_setup error path
      net: dsa: don't allocate the slave_mii_bus using devres
      net: dsa: realtek: register the MDIO bus under devres
      net: mscc: ocelot: fix forwarding from BLOCKING ports remaining enabl=
ed

Weizhao Ouyang (2):
      mm/debug: sync up MR_CONTIG_RANGE and MR_LONGTERM_PIN
      mm/debug: sync up latest migrate_reason to migrate_reason_names

Wen Xiong (1):
      scsi: ses: Retry failed Send/Receive Diagnostic commands

Wengang Wang (1):
      ocfs2: drop acl cache for directories too

Xuan Zhuo (1):
      napi: fix race inside napi_enable

Yang Yingliang (1):
      usb: dwc2: check return value after calling platform_get_resource()

Yue Hu (1):
      erofs: clear compacted_2b if compacted_4b_initial > totalidx

Yufeng Mo (2):
      net: hns3: check queue id range before using
      net: hns3: fix a return value error in hclge_get_reset_status()

Zenghui Yu (1):
      scsi: bsg: Fix device unregistration

Zhihao Cheng (1):
      blktrace: Fix uaf in blk_trace access after removing by sysfs

dann frazier (1):
      arm64: Restore forced disabling of KPTI on ThunderX

farah kassabri (2):
      habanalabs: fix kernel OOPs related to staged cs
      habanalabs: fix wait offset handling

jing yangyang (1):
      scsi: megaraid: Fix Coccinelle warning

liaoguojia (1):
      net: hns3: check vlan id before using it
