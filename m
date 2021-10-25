Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A645F439EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhJYSy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhJYSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:54:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:52:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q16so11187004ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JPTbPwx7jxhiUO943aXFAsfXRXlcy+11O2trmW1sVAs=;
        b=ecwpcGgGqcbhr6rS0cbzLwloXntd6ueNDzIR/9LEsyqoTUBoFy7vfCn/KgWwv2ZRaL
         2H/SERAiqxc3gaHZvp4M3lY7V2T4+4YyBAYmeRjvoU9VQCLXoFonP3rfUNkXHZmX4ADc
         7eE8jN7HBwOCKD0KDbpo4cfhaoii6qqKR1/gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JPTbPwx7jxhiUO943aXFAsfXRXlcy+11O2trmW1sVAs=;
        b=gtRZ5trxh8tS+oB4YaAmGyhb5zNAbLKPBnHu7fNnrkmZEpesiwSnBrmk0niRWlcjX4
         tjQ9R1+qTKlrT/tknxG8Vgbuz3LVErCzVyDxzl6n5MRB4y/QLNcgK3XXUp9XjFwo+SeN
         S+P3Ngnc6ckzH5vkhal22YtM1d+OFGc29hOoQAJS/+S3aJmA4lMZAyGTCChddCxDqhS+
         En3Ot6F/N6jICURuOeVVKmvlgg5bovefG4HDzm0kA3LnRI1gvQxfkZHSvYCTzFg01maP
         kEBztbK0u0tdik/2pKAwRFp2XqQwNPp0UG/J4Y7kgaZXzC/9MUkxyYlquQiW0Dx/dUo5
         xZrA==
X-Gm-Message-State: AOAM530c0eKRh+b1H66tRjKZpzK+XEnSAH7j+bzBehbPChZa4IVpc8gC
        OWPPf3AsViR9ZrNpoFHBiLv/x/J7Zn1VJ73h
X-Google-Smtp-Source: ABdhPJz5MAT34Hv86x8ZJdLDnAkkfL3oTC7pYEr7TRqDPnYytdfAYhYR3MJ1isJPyDMKGwm9Sr1QNg==
X-Received: by 2002:a2e:9585:: with SMTP id w5mr20941076ljh.240.1635187919922;
        Mon, 25 Oct 2021 11:51:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o24sm1716754lfb.97.2021.10.25.11.51.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 11:51:59 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s19so11026436ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:51:59 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr21323652ljm.191.1635187918947;
 Mon, 25 Oct 2021 11:51:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 11:51:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1+boAQyckdiYXuBkybN4H_7OT569MwgyetWAfTExeEA@mail.gmail.com>
Message-ID: <CAHk-=wi1+boAQyckdiYXuBkybN4H_7OT569MwgyetWAfTExeEA@mail.gmail.com>
Subject: Linux 5.15-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the normal Sunday release was spoiled by me spending more time in
airplanes without wifi, and I didn't feel like doing an evening
release while tired, so here we are, midday Monday, and with tc7 a day
later than usual.

But the delay isn't because of any kernel trouble. In fact, the worry
I had last week about a big rc6 turned out to be just a false alarm
due to timing of pulls, and rc7 looks nice and small, right in the
range of normal. Both the number of commits and the diffstat looks
fine. It's all pretty small and flat (meaning mostly small trivial
changes) with just a couple of  peaks for some x86 kvm code, and some
ksmbd changes.

Nothing particularly interesting or scary stands out, and it's a
fairly eclectic mix with networking, kvm, selftests, and some core mm
stuff. With all the usual random small fixes. The appended shortlog
isn't too long to scan to get a feel for the details, but I think the
take-way here is that it all looks pretty normal, and if nothing
special happens this week, this is likely the last rc before final
5.15.

But please do give it a good testing to make sure we've shaken out any
issues. I have yet more travel coming up next week, so it would be
very convenient for me to delay the merge window if I get the excuse
to do so, but right now that looks unlikely.

                             Linus

---

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Force a full restore after suspend-to-disk

Aleksander Jan Bajkowski (1):
      net: dsa: lantiq_gswip: fix register definition

Andrea Parri (Microsoft) (1):
      scsi: storvsc: Fix validation for unsolicited incoming packets

Andrej Shadura (1):
      mailmap: add Andrej Shadura

Andy Shevchenko (4):
      ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
      ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
      ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
      ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log
saturation

Anitha Chrisanthus (4):
      drm/kmb: Work around for higher system clock
      drm/kmb: Limit supported mode to 1080p
      drm/kmb: Corrected typo in handle_lcd_irq
      drm/kmb: Enable ADV bridge after modeset

Antoine Tenart (1):
      netfilter: ipvs: make global sysctl readonly in non-init netns

Ard Biesheuvel (1):
      ARM: 9125/1: fix incorrect use of get_kernel_nofault()

Arnd Bergmann (5):
      ARM: 9134/1: remove duplicate memcpy() definition
      ARM: 9138/1: fix link warning with XIP + frame-pointer
      ARM: 9139/1: kprobes: fix arch_init_kprobes() prototype
      ARM: 9141/1: only warn about XIP address when not compile testing
      hyperv/vmbus: include linux/bitops.h

Aswath Govindraju (1):
      can: m_can: fix iomap_read_fifo() and iomap_write_fifo()

Brendan Grieve (1):
      ALSA: usb-audio: Provide quirk for Sennheiser GSP670 Headset

Brett Creeley (2):
      ice: Fix failure to re-add LAN/RDMA Tx queues
      ice: Print the api_patch as part of the fw.mgmt.api

Chenyi Qiang (1):
      KVM: MMU: Reset mmu->pkru_mask to avoid stale data

Christian Borntraeger (1):
      KVM: kvm_stat: do not show halt_wait_ns

Christophe JAILLET (1):
      net: dsa: Fix an error handling path in 'dsa_switch_parse_ports_of()'

DENG Qingfang (1):
      net: dsa: mt7530: correct ds->num_ports

Dan Johansen (1):
      drm/panel: ilitek-ili9881c: Fix sync for Feixin K101-IM2BYL02 panel

Dave Ertman (1):
      ice: Avoid crash from unnecessary IDA free

Dave Hansen (2):
      mm/migrate: optimize hotplug-time demotion order updates
      mm/migrate: add CPU hotplug to demotion #ifdef

Davide Baldo (1):
      ALSA: hda/realtek: Fixes HP Spectre x360 15-eb1xxx speakers

Davidlohr Bueso (1):
      netfilter: ebtables: allocate chainstack on CPU local nodes

Dexuan Cui (1):
      scsi: core: Fix shost->cmd_per_lun calculation in scsi_add_host_with_=
dma()

Dmitry Bogdanov (1):
      scsi: qla2xxx: Fix unmap of already freed sgl

Dmytro Linkin (1):
      net/mlx5: E-switch, Return correct error code on group creation failu=
re

Edmund Dea (2):
      drm/kmb: Remove clearing DPHY regs
      drm/kmb: Disable change of plane parameters

Emeel Hakim (2):
      net/mlx5e: IPsec: Fix a misuse of the software parser's fields
      net/mlx5e: IPsec: Fix work queue entry ethernet segment checksum flag=
s

Eric Dumazet (1):
      mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING |
MPOL_LOCAL in mbind()

Eric W. Biederman (4):
      ucounts: Fix signal ucount refcounting
      ucounts: Pair inc_rlimit_ucounts with dec_rlimit_ucoutns in commit_cr=
eds
      ucounts: Proper error handling in set_cred_ucounts
      ucounts: Move get_ucounts from cred_alloc_blank to
key_change_session_keyring

Erik Ekman (2):
      sfc: Export fibre-specific supported link modes
      sfc: Don't use netif_info before net_device setup

Eugene Crosser (1):
      vrf: Revert "Reset skb conntrack connection..."

Fabien Dessenne (1):
      pinctrl: stm32: use valid pin identifier in stm32_pinctrl_resume()

Florian Westphal (3):
      netfilter: nf_tables: skip netdev events generated on netns removal
      selftests: nft_nat: add udp hole punch test case
      selftests: netfilter: remove stray bash debug line

Gaosheng Cui (1):
      audit: fix possible null-pointer dereference in audit_filter_rules

Gerald Schaefer (1):
      dma-debug: fix sg checks in debug_dma_map_sg()

Greg Kroah-Hartman (1):
      ALSA: usb-audio: add Schiit Hel device to quirk table

Guangbin Huang (2):
      net: hns3: reset DWRR of unused tc to zero
      net: hns3: add limit ets dwrr bandwidth cannot be 0

Hamza Mahfooz (1):
      dma-debug: teach add_dma_entry() about DMA_ATTR_SKIP_CPU_SYNC

Hans de Goede (1):
      ASoC: nau8824: Fix headphone vs headset, button-press detection
no longer working

Hao Xiang (1):
      KVM: VMX: Remove redundant handling of bus lock vmexit

Huang Ying (1):
      mm/migrate: fix CPUHP state to update node demotion order

Hyunchul Lee (3):
      ksmbd: improve credits management
      ksmbd: add buffer validation for smb direct
      ksmbd: validate OutputBufferLength of QUERY_DIR, QUERY_INFO,
IOCTL requests

Ian Kent (1):
      autofs: fix wait name hash calculation in autofs_wait()

Jan Kara (1):
      ocfs2: fix data corruption after conversion from inline format

Janosch Frank (1):
      KVM: s390: Function documentation fixes

Jeff Layton (2):
      ceph: skip existing superblocks that are blocklisted or shut
down when mounting
      ceph: fix handling of "meta" errors

Jeremy Kerr (2):
      mctp: unify sockaddr_mctp types
      mctp: Be explicit about struct sockaddr_mctp padding

Jiaran Zhang (1):
      net: hns3: Add configuration of TM QCN error event

Joy Gu (1):
      scsi: qla2xxx: Fix a memory leak in an error path of qla2x00_process_=
els()

Juhee Kang (1):
      netfilter: xt_IDLETIMER: fix panic that occurs when timer_type
has garbage value

Kele Huang (1):
      ptp: fix error print of ptp_kvm on X86_64 platform

Kim Phillips (1):
      Revert "drm/ast: Add detect function support"

Kurt Kanzenbach (1):
      net: stmmac: Fix E2E delay mechanism

LABBE Corentin (1):
      ARM: 9148/1: handle CONFIG_CPU_ENDIAN_BE32 in arch/arm/kernel/head.S

Leonard Crestez (4):
      tcp: md5: Fix overlap between vrf and non-vrf keys
      tcp: md5: Allow MD5SIG_FLAG_IFINDEX with ifindex=3D0
      selftests: nettest: Add --{force,no}-bind-key-ifindex
      selftests: net/fcnal: Test --{force,no}-bind-key-ifindex

Lexi Shao (1):
      ARM: 9132/1: Fix __get_user_check failure with ARM KASAN images

Linus Torvalds (3):
      Revert "mm/secretmem: use refcount_t instead of atomic_t"
      spi: Fix tegra20 build with CONFIG_PM=3Dn once again
      Linux 5.15-rc7

Logan Gunthorpe (1):
      dma-mapping: fix the kerneldoc for dma_map_sgtable()

Lukas Bulwahn (1):
      elfcore: correct reference to CONFIG_UML

Maor Dickman (1):
      net/mlx5: Lag, change multipath and bonding to be mutually exclusive

Marc Kleine-Budde (1):
      can: isotp: isotp_sendmsg(): fix return error on FC timeout on TX pat=
h

Marco Giunta (1):
      ALSA: usb-audio: Fix microphone sound on Jieli webcam.

Marek Szyprowski (1):
      mm/thp: decrease nr_thps in file's mapping on THP split

Marek Vasut (1):
      drm: mxsfb: Fix NULL pointer dereference crash on unload

Marios Makassikis (1):
      ksmbd: add buffer validation in session setup

Mark Brown (2):
      ASoC: pcm179x: Add missing entries SPI to device ID table
      ASoC: cs4341: Add SPI device ID table

Masahiro Kozuka (1):
      KVM: SEV: Flush cache on non-coherent systems before RECEIVE_UPDATE_D=
ATA

Matthew Wilcox (Oracle) (2):
      vfs: check fd has read access in kernel_read_file_from_fd()
      secretmem: Prevent secretmem_users from wrapping to zero

Miaohe Lin (5):
      mm, slub: fix two bugs in slab_debug_trace_open()
      mm, slub: fix mismatch between reconstructed freelist depth and cnt
      mm, slub: fix potential memoryleak in kmem_cache_open()
      mm, slub: fix potential use-after-free in slab_debugfs_fops
      mm, slub: fix incorrect memcg slab count for bulk free

Michael Ellerman (1):
      powerpc/idle: Don't corrupt back chain when going idle

Michal Swiatkowski (1):
      ice: fix getting UDP tunnel entry

Miguel Bernal Marin (1):
      ACPI: tools: fix compilation error

Mike Christie (1):
      scsi: iscsi: Fix set_param() handling

Mike Rapoport (2):
      Revert "memblock: exclude NOMAP regions from kmemleak"
      memblock: exclude MEMBLOCK_NOMAP regions from kmemleak

Miklos Szeredi (5):
      fuse: check s_root when destroying sb
      fuse: get rid of fuse_put_super()
      fuse: clean up fuse_mount destruction
      fuse: always initialize sb->s_fs_info
      fuse: clean up error exits in fuse_fill_super()

Miles Chen (1):
      scsi: sd: Fix crashes in sd_resume_runtime()

Ming Lei (1):
      scsi: core: Put LLD module refcnt after SCSI device is released

Moshe Shemesh (1):
      net/mlx5e: Fix vlan data lost during suspend flow

Nadav Amit (1):
      userfaultfd: fix a race between writeprotect and exit_mmap()

Namjae Jeon (5):
      ksmbd: add validation in smb2_ioctl
      ksmbd: fix potencial 32bit overflow from data area check in smb2_writ=
e
      ksmbd: validate compound response buffer
      ksmbd: limit read/write/trans buffer size not to exceed 8MB
      ksmbd: throttle session setup failures to avoid dictionary attacks

Nathan Chancellor (1):
      nfp: bpf: silence bitwise vs. logical OR warning

Nathan Lynch (1):
      powerpc/smp: do not decrement idle task preempt count in CPU offline

Nick Desaulniers (2):
      ARM: 9122/1: select HAVE_FUTEX_CMPXCHG
      ARM: 9133/1: mm: proc-macros: ensure *_tlb_fns are 4B aligned

Nikolay Aleksandrov (1):
      net: bridge: mcast: use multicast_membership_interval for IGMPv3

Oliver Neukum (1):
      usbnet: sanity check for maxpacket

Paolo Bonzini (12):
      KVM: SEV-ES: fix length of string I/O
      KVM: X86: fix lazy allocation of rmaps
      KVM: SEV-ES: reduce ghcb_sa_len to 32 bits
      KVM: x86: check for interrupts before deciding whether to exit
the fast path
      KVM: nVMX: promptly process interrupts delivered while in guest mode
      KVM: SEV-ES: rename guest_ins_data to sev_pio_data
      KVM: x86: leave vcpu->arch.pio.count alone in emulator_pio_in_out
      KVM: SEV-ES: clean up kvm_sev_es_ins/outs
      KVM: x86: split the two parts of emulator_pio_in
      KVM: x86: remove unnecessary arguments from complete_emulator_pio_in
      KVM: SEV-ES: keep INS functions together
      KVM: SEV-ES: go over the sev_pio_data buffer in multiple passes if ne=
eded

Paul Blakey (1):
      net/sched: act_ct: Fix byte count on fragmented packets

Pavel Begunkov (4):
      io-wq: max_worker fixes
      io_uring: apply max_workers limit to all future users
      io_uring: fix ltimeout unprep
      io_uring: apply worker limits to previous users

Peng Fan (1):
      memblock: check memory total_size

Peng Li (1):
      net: hns3: disable sriov before unload hclge layer

Peter Gonda (1):
      KVM: SEV-ES: Set guest_state_protected after VMSA update

Peter Rosin (1):
      ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2 registers

Peter Xu (1):
      mm/userfaultfd: selftests: fix memory corruption with thp enabled

Quentin Perret (3):
      KVM: arm64: Fix host stage-2 PGD refcount
      KVM: arm64: Report corrupted refcount at EL2
      KVM: arm64: Release mmap_lock when using VM_SHARED with MTE

Rafael J. Wysocki (1):
      ACPI: PM: Do not turn off power resources in unknown state

Rafa=C5=82 Mi=C5=82ecki (3):
      Revert "dt-bindings: pinctrl: bcm4708-pinmux: rework binding to
use syscon"
      dt-bindings: pinctrl: brcm,ns-pinmux: drop unneeded CRU from example
      Revert "pinctrl: bcm: ns: support updated DT binding as syscon subnod=
e"

Ralph Boehme (1):
      ksmbd: validate credit charge after validating SMB2 PDU body size

Randy Dunlap (2):
      hamradio: baycom_epp: fix build for UML
      NIOS2: irqflags: rename a redefined register name

Rob Clark (1):
      drm/msm/devfreq: Restrict idle clamping to a618 for now

Sachi King (1):
      pinctrl: amd: disable and mask interrupts on probe

Sasha Neftin (3):
      e1000e: Separate TGP board type from SPT
      e1000e: Fix packet loss on Tiger Lake and later
      igc: Update I226_K device ID

Sean Christopherson (3):
      Revert "KVM: x86: Open code necessary bits of
kvm_lapic_set_base() at vCPU RESET"
      KVM: x86: WARN if APIC HW/SW disable static keys are non-zero on unlo=
ad
      mm/secretmem: fix NULL page->mapping dereference in page_is_secretmem=
()

Shengjiu Wang (2):
      ASoC: fsl_xcvr: Fix channel swap issue with ARC
      ASoC: wm8960: Fix clock configuration on slave mode

Sreekanth Reddy (1):
      scsi: mpi3mr: Fix duplicate device entries when scanning through sysf=
s

Srinivasa Rao Mandadapu (2):
      ASoC: wcd938x: Fix jack detection issue
      ASoC: codec: wcd938x: Add irq config support

Stefan Binding (1):
      ASoC: cs42l42: Ensure 0dB full scale volume is used for headsets

Stefano Garzarella (1):
      vsock_diag_test: remove free_sock_stat() call in test_no_sockets

Stephane Grosjean (2):
      can: peak_usb: pcan_usb_fd_decode_status(): fix back to
ERROR_ACTIVE state notification
      can: peak_usb: pcan_usb_fd_decode_status(): remove unnecessary
test on the nullity of a pointer

Stephen Suryaputra (1):
      ipv6: When forwarding count rx stats on the orig netdev

Steven Clarkson (1):
      ALSA: hda/realtek: Add quirk for Clevo PC50HS

Steven Rostedt (VMware) (1):
      tracing: Have all levels of checks prevent recursion

Takashi Iwai (1):
      ASoC: DAPM: Fix missing kctl change notifications

Tejun Heo (1):
      blk-cgroup: blk_cgroup_bio_start() should use irq-safe
operations on blkg->iostat_cpu

Thomas Gleixner (1):
      MAINTAINERS: Add Dave Hansen to the x86 maintainer team

Tianjia Zhang (1):
      selftests/tls: add SM4 algorithm dependency for tls selftests

Tony Nguyen (1):
      ice: Add missing E810 device ids

Uwe Kleine-K=C3=B6nig (1):
      nfc: st95hf: Make spi remove() callback return zero

Valentin Vidic (1):
      ocfs2: mount fails with buffer overflow in strlen

Vegard Nossum (2):
      netfilter: Kconfig: use 'default y' instead of 'm' for bool config op=
tion
      lan78xx: select CRC32

Vladimir Oltean (2):
      net: enetc: fix ethtool counter name for PM0_TERR
      net: enetc: make sure all traffic classes can send large frames

Wan Jiabing (2):
      net: sparx5: Add of_node_put() before goto
      net: mscc: ocelot: Add of_node_put() before goto

Woody Lin (1):
      sched/scs: Reset the shadow stack when idle_task_exit

Xin Long (2):
      netfilter: ip6t_rt: fix rt0_hdr parsing in rt_mt6
      sctp: fix transport encap_port update in sctp_vtag_verify

Yang Yingliang (3):
      ASoC: soc-core: fix null-ptr-deref in snd_soc_del_component_unlocked(=
)
      ptp: Fix possible memory leak in ptp_clock_register()
      ptp: free 'vclock_index' in ptp_clock_release()

Yoshihiro Shimoda (1):
      can: rcar_can: fix suspend/resume

Yufeng Mo (1):
      net: hns3: fix vf reset workqueue cannot exit

Yunsheng Lin (3):
      net: hns3: fix the max tx size according to user manual
      net: hns3: fix for miscalculation of rx unused desc
      net: hns3: schedule the polling again when allocation fails

Zhang Changzhong (2):
      can: j1939: j1939_xtp_rx_dat_one(): cancel session if receive
TP.DT with error length
      can: j1939: j1939_xtp_rx_rts_session_new(): abort TP less than 9 byte=
s

Zheyu Ma (6):
      can: peak_pci: peak_pci_remove(): fix UAF
      cavium: Return negative value when pci_alloc_irq_vectors() fails
      scsi: qla2xxx: Return -ENOMEM if kzalloc() fails
      mISDN: Fix return values of the probe function
      cavium: Fix return values of the probe function
      ata: sata_mv: Fix the error handling of mv_chip_id()

Ziyang Xuan (4):
      can: j1939: j1939_tp_rxtimer(): fix errant alert in j1939_tp_rxtimer
      can: j1939: j1939_netdev_start(): fix UAF for rx_kref of j1939_priv
      can: isotp: isotp_sendmsg(): add result check for
wait_event_interruptible()
      can: isotp: isotp_sendmsg(): fix TX buffer concurrent access in
isotp_sendmsg()

Zqiang (1):
      block: fix incorrect references to disk objects
