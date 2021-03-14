Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49C33A867
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCNWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCNWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:00:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:00:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t18so6115864lfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yCgy7/lIwugUThL1BMKXJu8tnkavpVG6NEElM+V4WJM=;
        b=Vl7zwaJW8KCQcWNibjaESAgW4nFKVvrE7Xn6YiVbuv7ZYSb6P2LFiFxwRBBTSNSvww
         NsaqHev+Vw/hs7Clq+lh6lq/2DU23CW4aBnQz2jvQhesZkpRXhpkwQCOG9tVCyAlyIV/
         B0mchcXQWa2sEkltbn/kRe07fPrNK4wNxjSqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yCgy7/lIwugUThL1BMKXJu8tnkavpVG6NEElM+V4WJM=;
        b=MSuRh9FB+3WGEPHWCMitxFtbwgdaJgEKAHgSH9M7HgsSts7SZE7wDq8g8P9/WgvTHx
         /O01g7eJe3NiUWKccUBsDMcq8WDEkDDp0TGMlFrrahltsXRz7UBPp9/CSW/UyaRY7ETG
         EcUKbKLRlfZYUGa2wAIVPiiaAqZfMCb8WUmu9YFmkTs4R+MnkDtks+17Y0UpNBpm1D/5
         f4sVTYF39BU3FuPnsBm8fQneVcJDNDB6bjnx8Of8g2a60EB0td4TcypNlryD8gC3NM9o
         o96Mg0ZphmRriEPRCgdnflvYcE1SV7fH5cg97EPedjxMwDXMHAGEOPXfxhHkq6nmJmx9
         U6PQ==
X-Gm-Message-State: AOAM530HYIJyd1j1aaxKIR5kuhY469mB/5sfzCiLskgQauV8MwHaCMkI
        DnHzGYMv6IukiX3XfjHJ3VMlmI5uqQfz2A==
X-Google-Smtp-Source: ABdhPJxSc4fHTrr51bekwt9rfMD7UtcxCf1FZgRuKDbjmygVsu2QpN3er7sFRDzCNQyrJf+ZWvvWmw==
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr6189470lfs.586.1615759238678;
        Sun, 14 Mar 2021 15:00:38 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u13sm2450832lfr.124.2021.03.14.15.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 15:00:37 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id q25so53871279lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:00:37 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr5865310lfb.421.1615759236761;
 Sun, 14 Mar 2021 15:00:36 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Mar 2021 15:00:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
Message-ID: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
Subject: Linux 5.12-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So rc3 is pretty big this time around, but that's entirely artificial,
and due to how I released rc2 early. So I'm not going to read anything
more into this, 5.12 still seems to actually be on the smaller side
overall. Also, because of the rc1 debacle, there has been a bit more
rebasing than usual, so the history of some of the commits sometimes
looks more recent than it necessarily is.

Other than that, things look fairly normal - there's a big peak in the
diffstat around the io_uring fallout from the new thread creation
model, and sparc makes an unusual showing on the architecture updates
side, but other than that it's all the usual things: drivers (gpu,
net, usb, staging, sound... all over), architectures (x86, arm64,
s390, powerpc in addition to the already-mentioned sparc), filesystems
(cifs, nfs) and core kernel (networking, VM, timers, scheduler..).

And the (by now) quite usual documentation and tooling updates (mainly
perf tooling and selftests).

And random other patches.

Full shortlog appended, although it is a bit larger than usual, so
maybe not as easy to eyeball as I'd hope.

With this, we're obviously back to the usual "Sunday afternoon" rc
schedule, and I think we should be all back to normal in general for
this release.

Go beat on it,

             Linus

---

Adrian Hunter (1):
      mmc: core: Fix partition switch time for eMMC

Al Viro (9):
      sparc32: don't bother with lookup_fault() in __bzero()
      sparc32: kill lookup_fault()
      sparc32: switch __bzero() away from range exception table entries
      sparc32: get rid of range exception table entries in checksum_32.S
      sparc32: switch copy_user.S away from range exception table entries
      sparc32: switch to generic extables
      sparc64: get rid of fake_swapper_regs
      sparc32: get rid of fake_swapper_regs
      sparc32: take ->thread.flags out

Alex Deucher (4):
      drm/amdgpu/display: simplify backlight setting
      drm/amdgpu/display: don't assert in set backlight function
      drm/amdgpu/display: handle aux backlight in backlight_get_brightness
      drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=3Dm

Alex Marginean (1):
      net: enetc: set MAC RX FIFO to recommended value

Alexander Egorenkov (3):
      s390/zcore: no need to check return value of debugfs_create functions
      s390/zcore: release dump save area on restart or power down
      s390: remove IBM_PARTITION and CONFIGFS_FS from zfcpdump defconfig

Alexander Shiyan (1):
      Revert "serial: max310x: rework RX interrupt handling"

Alexey Dobriyan (1):
      prctl: fix PR_SET_MM_AUXV kernel stack leak

Andrea Parri (Microsoft) (1):
      hv_netvsc: Fix validation in netvsc_linkstatus_callback()

Andreas Wendleder (1):
      perf tools: Clean 'generated' directory used for creating the
syscall table on x86

Andrew Scull (1):
      KVM: arm64: Fix nVHE hyp panic host context restore

Andrey Konovalov (3):
      arm64: kasan: fix page_alloc tagging with DEBUG_VIRTUAL
      kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
      kasan: fix KASAN_STACK dependency for HW_TAGS

Andy Lutomirski (1):
      x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls

Andy Shevchenko (4):
      gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
      gpiolib: acpi: Allow to find GpioInt() resource by name and index
      gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2
      gpiolib: Read "gpio-line-names" from a firmware node

Anna-Maria Behnsen (1):
      hrtimer: Update softirq_expires_next correctly after
__hrtimer_get_next_event()

Anshuman Khandual (4):
      arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE
      arm64/mm: Drop THP conditionality from FORCE_MAX_ZONEORDER
      arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
      arm64/mm: Reorganize pfn_valid()

Anthony DeRossi (1):
      drm/ttm: Fix TTM page pool accounting

Antonio Terceiro (1):
      perf build: Fix ccache usage in $(CC) when generating arch errno tabl=
e

Antony Antony (1):
      ixgbe: fail to create xfrm offload of IPsec tunnel mode SA

Ard Biesheuvel (3):
      efi: stub: omit SetVirtualAddressMap() if marked unsupported in
RT_PROP table
      arm64: mm: use a 48-bit ID map when possible on 52-bit VA builds
      arm64: mm: remove unused __cpu_uses_extended_idmap[_level()]

Arjun Roy (1):
      tcp: Fix sign comparison bug in getsockopt(TCP_ZEROCOPY_RECEIVE)

Arnaldo Carvalho de Melo (12):
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync openat2.h with the kernel sources
      perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
      tools headers UAPI s390: Sync ptrace.h kernel headers
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers: Update syscall.tbl files to support mount_setattr
      tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync KVM's kvm.h and vmx.h headers with the
kernel sources
      perf tests x86: Move insn.h include to make sure it finds stddef.h
      perf map: Tighten snprintf() string precision to pass gcc check
on some 32-bit arches

Arnd Bergmann (8):
      mt76: mt7921: remove incorrect error handling
      mt76: mt7915: fix unused 'mode' variable
      net: mscc: ocelot: select NET_DEVLINK
      net: dsa: tag_ocelot_8021q: fix driver dependency
      net: phy: make mdio_bus_phy_suspend/resume as __maybe_unused
      memblock: fix section mismatch warning
      stop_machine: mark helpers __always_inline
      linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*

Artem Lapkin (1):
      drm: meson_drv add shutdown function

Athira Rajeev (2):
      powerpc/perf: Fix handling of privilege level checks in perf
interrupt context
      perf bench numa: Fix the condition checks for max number of NUMA node=
s

Atish Patra (1):
      net: macb: Add default usrio config to default gem config

Aurelien Aptel (2):
      cifs: fix credit accounting for extra channel
      cifs: ask for more credit on async read/write code paths

Axel Lin (2):
      regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: mt6315: Fix off-by-one for .n_voltages

Balazs Nemeth (2):
      net: check if protocol extracted by virtio_net_hdr_set_proto is corre=
ct
      net: avoid infinite loop in mpls_gso_segment when mpls_hlen =3D=3D 0

Bartosz Golaszewski (1):
      selftests: gpio: update .gitignore

Beata Michalska (1):
      opp: Don't drop extra references to OPPs accidentally

Benjamin Coddington (1):
      SUNRPC: Set memalloc_nofs_save() for sync tasks

Bernhard Rosenkr=C3=A4nzer (1):
      kbuild: Fix ld-version.sh script if LLD was built with LLD_VENDOR

Bhaskar Chowdhury (1):
      net: ethernet: chelsio: inline_crypto: Mundane typos fixed
throughout the file chcr_ktls.c

Biao Huang (1):
      net: ethernet: mtk-star-emac: fix wrong unmap in RX handling

Biju Das (2):
      media: v4l: vsp1: Fix bru null pointer access
      media: v4l: vsp1: Fix uif null pointer access

Bj=C3=B8rn Mork (1):
      MIPS: vmlinux.lds.S: align raw appended dtb to 8 bytes

Bob Peterson (3):
      gfs2: fix use-after-free in trans_drain
      gfs2: bypass signal_our_withdraw if no journal
      gfs2: bypass log flush if the journal is not live

Brendan Jackman (2):
      bpf, x86: Fix BPF_FETCH atomic and/or/xor with r0 as src
      bpf: Explicitly zero-extend R0 after 32-bit cmpxchg

Can Guo (2):
      scsi: ufs: Minor adjustments to error handling
      scsi: ufs: Remove redundant checks of !hba in suspend/resume callback=
s

Catalin Marinas (1):
      arm64: mte: Map hotplugged memory as Normal Tagged

Chaitanya Kulkarni (2):
      nvme: set max_zone_append_sectors nvme_revalidate_zones
      nvme-core: check ctrl css before setting up zns

Christian Brauner (1):
      mount: fix mounting of detached mounts onto targets that reside
on shared mounts

Christian K=C3=B6nig (3):
      drm/radeon: also init GEM funcs in radeon_gem_prime_import_sg_table
      drm/radeon: fix AGP dependency
      drm/ttm: soften TTM warnings

Christoph Hellwig (2):
      block: rename BIO_MAX_PAGES to BIO_MAX_VECS
      nvme: fix the nsid value to print in nvme_validate_or_alloc_ns

Christophe Leroy (5):
      powerpc/603: Fix protection of user pages mapped with PROT_NONE
      powerpc/syscall: Force inlining of __prep_irq_for_enabled_exit()
      powerpc: Force inlining of mmu_has_feature to fix build failure
      powerpc: Fix missing declaration of [en/dis]able_kernel_vsx()
      powerpc/traps: unrecoverable_exception() is not an interrupt handler

Colin Ian King (1):
      qxl: Fix uninitialised struct field head.surface_id

Cong Wang (1):
      bpf: Clear percpu pointers in bpf_prog_clone_free()

Corentin Labbe (1):
      sparc: sparc64_defconfig: remove duplicate CONFIGs

DENG Qingfang (3):
      net: dsa: mt7530: don't build GPIO support if !GPIOLIB
      net: dsa: tag_rtl4_a: fix egress tags
      net: dsa: tag_mtk: fix 802.1ad VLAN egress

Dafna Hirschfeld (1):
      media: rkisp1: params: fix wrong bits settings

Daiyue Zhang (1):
      configfs: fix a use-after-free in __configfs_open_file

Damien Le Moal (1):
      block: Fix REQ_OP_ZONE_RESET_ALL handling

Dan Carpenter (8):
      bpf: Fix a warning message in mark_ptr_not_null_reg()
      octeontx2-af: cn10k: fix an array overflow in is_lmac_valid()
      staging: rtl8712: unterminated string leads to read overflow
      staging: ks7010: prevent buffer overflow in ks_wlan_set_scan()
      staging: rtl8192u: fix ->ssid overflow in r8192_wx_set_scan()
      staging: rtl8188eu: fix potential memory corruption in
rtw_check_beacon_data()
      staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()
      USB: gadget: u_ether: Fix a configfs return code

Daniel Axtens (1):
      powerpc/64s/exception: Clean up a missed SRR specifier

Daniel Borkmann (1):
      net: Fix gro aggregation for udp encaps with zero csum

Daniel Vetter (1):
      drm/compat: Clear bounce structures

Daniel Wagner (1):
      block: Suppress uevent for hidden device when removed

Daniele Palmas (1):
      net: usb: qmi_wwan: allow qmimux add/del with master up

Danielle Ratson (2):
      selftests: forwarding: Fix race condition in mirror installation
      mlxsw: spectrum_ethtool: Add an external speed to PTYS register

Dave Airlie (1):
      drm/nouveau: fix dma syncing for loops (v2)

Davide Caratti (1):
      mptcp: fix length of ADD_ADDR with port sub-option

Denis Efremov (2):
      net/hamradio/6pack: remove redundant check in sp_encaps()
      sun/niu: fix wrong RXMAC_BC_FRM_CNT_COUNT count

Dillon Varone (1):
      drm/amd/display: Enabled pipe harvesting in dcn30

Dinghao Liu (1):
      ixgbe: Fix memleak in ixgbe_configure_clsu32

Dmitrii Banshchikov (2):
      bpf: Drop imprecise log message
      selftests/bpf: Fix a compiler warning in global func test

Dmitry Baryshkov (1):
      misc: fastrpc: restrict user apps from sending kernel RPC messages

Dmitry Monakhov (1):
      nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a

Dmitry Safonov (1):
      perf diff: Don't crash on freeing errno-session on the error path

Dmitry V. Levin (1):
      uapi: nfnetlink_cthelper.h: fix userspace compilation error

Drew Fustini (1):
      net: sctp: trivial: fix typo in comment

Edwin Peer (1):
      bnxt_en: reliably allocate IRQ table on reset to avoid crash

Eric Dumazet (1):
      tcp: add sanity tests to TCP_QUEUE_SEQ

Eric Farman (1):
      s390/cio: return -EFAULT if copy_to_user() fails

Eric W. Biederman (1):
      Revert 95ebabde382c ("capabilities: Don't allow writing
ambiguous v3 file capabilities")

Evan Quan (1):
      drm/amd/pm: correct the watermark settings for Polaris

Felix Fietkau (3):
      ath9k: fix transmitting to stations in dynamic SMPS mode
      mt76: fix tx skb error handling in mt76_dma_tx_queue_skb
      mt76: mt7915: only modify tx buffer list after allocating tx token id

Fenghua Yu (1):
      mm/fork: clear PASID for new mm

Florian Westphal (7):
      netfilter: nf_nat: undo erroneous tcp edemux lookup
      netfilter: conntrack: avoid misleading 'invalid' in log message
      selftests: netfilter: test nat port clash resolution interaction
with tcp early demux
      mptcp: reset last_snd on subflow close
      mptcp: put subflow sock on connect error
      mptcp: dispose initial struct socket when its subflow is closed
      mptcp: reset 'first' and ack_hint on subflow close

Forest Crossman (1):
      usb: xhci: Fix ASMedia ASM1042A and ASM3242 DMA addressing

Frank Li (1):
      mmc: cqhci: Fix random crash when remove mmc module/card

Frank Sorenson (1):
      NFS: Correct size calculation for create reply length

Frieder Schrempf (2):
      regulator: pca9450: Fix return value when failing to get sd-vsel GPIO
      regulator: pca9450: Clear PRESET_EN bit to fix BUCK1/2/3 voltage sett=
ing

Gao Xiang (1):
      erofs: fix bio->bi_max_vecs behavior change

Geert Uytterhoeven (2):
      ath11k: qmi: use %pad to format dma_addr_t
      m68k: Fix virt_addr_valid() W=3D1 compiler warnings

Geliang Tang (1):
      mptcp: free resources when the port number is mismatched

George McCollister (2):
      lan743x: trim all 4 bytes of the FCS; not just 2
      net: dsa: xrs700x: check if partner is same as port in hsr join

Gerd Hoffmann (2):
      drm/qxl: unpin release objects
      drm/qxl: fix lockdep issue in qxl_alloc_release_reserved

Grant Grundler (2):
      net: usb: cdc_ncm: emit dev_err on error paths
      net: usb: log errors to dmesg/syslog

Greg Kroah-Hartman (4):
      irqdomain: Remove debugfs_file from struct irq_domain
      drivers: habanalabs: remove unused dentry pointer for debugfs files
      Revert "staging: wfx: remove unused included header files"
      Revert "drivers:tty:pty: Fix a race causing data loss on close"

Greg Kurz (1):
      powerpc/pseries: Don't enforce MSI affinity with kdump

Guangbin Huang (1):
      net: phy: fix save wrong speed and duplex problem if autoneg is on

Hangbin Liu (2):
      bpf: Remove blank line in bpf helper description comment
      selftests/bpf: No need to drop the packet when there is no geneve opt

Hannes Reinecke (4):
      nvme: simplify error logic in nvme_validate_ns()
      nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
      nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
      nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been abor=
ted

Hans Verkuil (1):
      media: rc: compile rc-cec.c into rc-core

Hayes Wang (2):
      Revert "r8152: adjust the settings about MAC clock speed down for RTL=
8153"
      r8169: fix r8168fp_adjust_ocp_cmd function

Heikki Krogerus (2):
      software node: Fix node registration
      software node: Fix device_add_software_node()

Heiko Carstens (4):
      s390/time,idle: get rid of unsigned long long
      s390/topology: remove always false if check
      s390,alpha: make TMPFS_INODE64 available again
      s390: update defconfigs

Heiko Thiery (1):
      net: fec: ptp: avoid register access when ipg clock is disabled

Helge Deller (1):
      parisc: Enable -mlong-calls gcc option with CONFIG_COMPILE_TEST

Hillf Danton (1):
      netdevsim: init u64 stats for 32bit hardware

Holger Hoffst=C3=A4tte (2):
      drm/amd/display: Fix nested FPU context in dcn21_validate_bandwidth()
      drm/amdgpu/display: use GFP_ATOMIC in dcn21_validate_bandwidth_fp()

Ian Abbott (14):
      staging: comedi: addi_apci_1032: Fix endian problem for COS sample
      staging: comedi: addi_apci_1500: Fix endian problem for command sampl=
e
      staging: comedi: adv_pci1710: Fix endian problem for AI command data
      staging: comedi: das6402: Fix endian problem for AI command data
      staging: comedi: das800: Fix endian problem for AI command data
      staging: comedi: dmm32at: Fix endian problem for AI command data
      staging: comedi: me4000: Fix endian problem for AI command data
      staging: comedi: pcl711: Fix endian problem for AI command data
      staging: comedi: pcl818: Fix endian problem for AI command data
      staging: comedi: amplc_pc236_common: Use 16-bit 0 for interrupt data
      staging: comedi: comedi_parport: Use 16-bit 0 for interrupt data
      staging: comedi: ni_6527: Use 16-bit 0 for interrupt data
      staging: comedi: ni_65xx: Use 16-bit 0 for interrupt data
      staging: comedi: pcl726: Use 16-bit 0 for interrupt data

Ian Rogers (2):
      perf traceevent: Ensure read cmdlines are null terminated.
      perf tools: Fix documentation of verbose options

Ido Schimmel (3):
      mlxsw: spectrum_router: Ignore routes using a deleted nexthop object
      nexthop: Do not flush blackhole nexthops when loopback goes down
      selftests: fib_nexthops: Test blackhole nexthops when loopback goes d=
own

Ilya Leoshkevich (2):
      selftests/bpf: Use the last page in test_snprintf_btf on s390
      bpf: Account for BPF_FETCH in insn_has_def32()

Ioana Ciornei (1):
      net: phy: ti: take into account all possible interrupt sources

J. Bruce Fields (1):
      nfs: we don't support removing system.nfs4_acl

Jakub Kicinski (2):
      docs: networking: drop special stable handling
      ethernet: alx: fix order of calls on resume

James Morse (1):
      arm64/mm: Fix __enable_mmu() for new TGRAN range values

James Smart (1):
      nvme-fc: fix racing controller reset and create association

Jan Beulich (5):
      xen-netback: use local var in xenvif_tx_check_gop() instead of
re-calculating
      Xen: drop exports of {set,clear}_foreign_p2m_mapping()
      Xen/gntdev: don't needlessly allocate k{,un}map_ops[]
      Xen/gnttab: introduce common INVALID_GRANT_{HANDLE,REF}
      Xen/gntdev: don't needlessly use kvcalloc()

Jan Kara (1):
      block: Try to handle busy underlying device on discard

Jason A. Donenfeld (1):
      net: always use icmp{,v6}_ndo_send from ndo_start_xmit

Jens Axboe (9):
      io-wq: fix race in freeing 'wq' and worker access
      io-wq: always track creds for async issue
      io_uring: SQPOLL parking fixes
      io-wq: remove unused 'user' member of io_wq
      io_uring: move all io_kiocb init early in io_init_req()
      io_uring: always wait for sqd exited when stopping SQPOLL thread
      kernel: make IO threads unfreezable by default
      io_uring: force creation of separate context for ATTACH_WQ and non-th=
reads
      io_uring: perform IOPOLL reaping if canceler is thread itself

Jia He (1):
      KVM: arm64: Fix range alignment when walking page tables

Jia-Ju Bai (7):
      net: tehuti: fix error return code in bdx_probe()
      net: intel: iavf: fix error return code of iavf_init_get_resources()
      net: hisilicon: hns: fix error return code of hns_nic_clear_all_rx_fe=
tch()
      net: wan: fix error return code of uhdlc_init()
      net: bonding: fix error return code of bond_neigh_init()
      net: qrtr: fix error return code of qrtr_sendmsg()
      block: rsxx: fix error return code of rsxx_pci_probe()

Jian Shen (3):
      net: hns3: fix error mask definition of flow director
      net: hns3: fix query vlan mask value error for flow director
      net: hns3: fix bug when calculating the TCAM table info

Jiapeng Chong (2):
      scsi: ufs: Convert sysfs sprintf/snprintf family to sysfs_emit
      s390/cpumf: remove unneeded semicolon

Jin Yao (1):
      perf stat: Fix wrong skipping for per-die aggregation

Jiri Kosina (1):
      iwlwifi: don't call netif_napi_add() with rxq->lock held (was
Re: Lockdep warning in iwl_pcie_rx_handle())

Jiri Olsa (4):
      perf build: Move feature cleanup under tools/build
      perf daemon: Fix control fifo permissions
      perf daemon: Fix running test for non root user
      perf tools: Fix event's PMU name parsing

Jiri Slaby (2):
      kbuild: dummy-tools: fix inverted tests for gcc
      kbuild: dummy-tools: support MPROFILE_KERNEL checks for ppc

Jiri Wiesner (1):
      ibmvnic: always store valid MAC address

Jisheng Zhang (1):
      net: 9p: advance iov on empty read

Joakim Zhang (8):
      net: stmmac: stop each tx channel independently
      net: stmmac: fix watchdog timeout during suspend/resume stress test
      net: stmmac: fix dma physical address of descriptor when display ring
      net: stmmac: fix wrongly set buffer2 valid when sph unsupport
      net: stmmac: re-init rx buffers when mac resume back
      can: flexcan: assert FRZ bit in flexcan_chip_freeze()
      can: flexcan: enable RX FIFO after FRZ/HALT valid
      can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode

Joe Perches (1):
      s390/tty3270: avoid comma separated statements

Joerg Roedel (4):
      x86/sev-es: Introduce ip_within_syscall_gap() helper
      x86/sev-es: Check regs->sp is trusted before adjusting #VC IST stack
      x86/sev-es: Correctly track IRQ states in runtime #VC handler
      x86/sev-es: Use __copy_from_user_inatomic()

Johan Hovold (3):
      gpio: fix NULL-deref-on-deregistration regression
      gpio: fix gpio-device list corruption
      USB: serial: xr: fix NULL-deref on disconnect

Johannes Berg (1):
      iwlwifi: avoid crash on unsupported debug collection

John Ernberg (1):
      ALSA: usb: Add Plantronics C320-M USB ctrl msg delay quirk

Jordan Niethe (1):
      powerpc/sstep: Fix VSX instruction emulation

Josh Poimboeuf (2):
      x86/unwind/orc: Disable KASAN checking in the ORC unwinder, part 2
      x86/unwind/orc: Silence warnings caused by missing ORC data

Juergen Gross (3):
      xen/events: reset affinity of 2-level event when tearing it down
      xen/events: don't unmask an event channel when an eoi is pending
      xen/events: avoid handling the same event on two cpus at the same tim=
e

Julian Braha (1):
      staging: rtl8192e: fix kconfig dependency on CRYPTO

Julian Wiedmann (4):
      s390/qeth: fix memory leak after failed TX Buffer allocation
      s390/qeth: improve completion of pending TX buffers
      s390/qeth: schedule TX NAPI on QAOB completion
      s390/qeth: fix notification for pending buffers during teardown

Junlin Yang (1):
      ibmvnic: remove excessive irqsave

Kai-Heng Feng (1):
      ALSA: usb-audio: Disable USB autosuspend properly in
setup_disable_autosuspend()

Kalle Valo (2):
      ath11k: fix AP mode for QCA6390
      iwlwifi: pcie: fix iwl_so_trans_cfg link error when
CONFIG_IWLMVM is disabled

Kan Liang (4):
      perf/core: Flush PMU internal buffers for per-CPU events
      perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large PEBS and LBR
      perf test: Fix sample-parsing failure on non-x86 platforms
      perf test: Support the ins_lat check in the X86 specific test

Karan Singhal (1):
      USB: serial: cp210x: add ID for Acuity Brands nLight Air Adapter

Kenneth Feng (1):
      drm/amd/pm: bug fix for pcie dpm

Kevin(Yudong) Yang (1):
      net/mlx4_en: update moderation when config reset

Klemen Ko=C5=A1ir (1):
      netfilter: conntrack: Remove a double space in a log message

Kun-Chuan Hsieh (1):
      tools/resolve_btfids: Fix build error with older host toolchains

Lee Gibson (2):
      staging: rtl8192e: Fix possible buffer overflow in _rtl92e_wx_set_sca=
n
      staging: rtl8712: Fix possible buffer overflow in r8712_sitesurvey_cm=
d

Linus Torvalds (2):
      Revert "mm, slub: consider rest of partial list if acquire_slab() fai=
ls"
      Linux 5.12-rc3

Lior Ribak (1):
      binfmt_misc: fix possible deadlock in bm_register_write

Lorenzo Bianconi (1):
      mt76: dma: do not report truncated frames to mac80211

Lv Yunlong (1):
      nvme-rdma: Fix a use after free in nvmet_rdma_write_data_done

Maciej Fijalkowski (3):
      xsk: Remove dangling function declaration from header file
      samples, bpf: Add missing munmap in xdpsock
      libbpf: Clear map_info before each bpf_obj_get_info_by_fd

Maciej W. Rozycki (1):
      crypto: mips/poly1305 - enable for all MIPS processors

Marc Kleine-Budde (1):
      can: mcp251xfd: revert "can: mcp251xfd: add BQL support"

Marc Zyngier (9):
      KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
      KVM: arm64: Don't access PMSELR_EL0/PMUSERENR_EL0 when no PMU is avai=
lable
      KVM: arm64: Rename __vgic_v3_get_ich_vtr_el2() to
__vgic_v3_get_gic_config()
      KVM: arm64: Workaround firmware wrongly advertising GICv2-on-v3
compatibility
      ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly
      irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER
      KVM: arm64: Ensure I-cache isolation between vcpus of a same VM
      KVM: arm64: Reject VM creation when the default IPA size is unsupport=
ed
      KVM: arm64: Fix exclusive limit for IPA size

Marco Elver (3):
      kfence: fix printk format for ptrdiff_t
      kfence, slab: fix cache_alloc_debugcheck_after() for bulk allocations
      kfence: fix reports if constant function prefixes exist

Mark Brown (1):
      kselftest: arm64: Fix exit code of sve-ptrace

Mark Pearson (1):
      ALSA: hda: ignore invalid NHLT table

Masahiro Yamada (8):
      kbuild: add image_name to no-sync-config-targets
      kbuild: rebuild GCC plugins when the compiler is upgraded
      kbuild: dummy-tools: adjust to scripts/cc-version.sh
      kbuild: remove unneeded -O option to dtc
      kbuild: remove LLVM=3D1 test from HAS_LTO_CLANG
      kbuild: remove meaningless parameter to $(call if_changed_rule,dtc)
      kbuild: fix ld-version.sh to not be affected by locale
      init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM

Masanari Iida (1):
      docs: networking: bonding.rst Fix a typo in bonding.rst

Mathias Nyman (2):
      xhci: Improve detection of device initiated wake signal.
      xhci: Fix repeated xhci wake after suspend due to uncleared
internal wake state

Mathieu Desnoyers (1):
      sched/membarrier: fix missing local execution of ipi_sync_rq_state()

Matthew Wilcox (Oracle) (2):
      io_uring: Convert personality_idr to XArray
      include/linux/sched/mm.h: use rcu_dereference in in_vfork()

Matthias Kaehlcke (1):
      usb: dwc3: qcom: Honor wakeup enabled/disabled state

Matthias Schiffer (1):
      net: l2tp: reduce log level of messages in receive path, add
counter instead

Maxim Mikityanskiy (1):
      media: usbtv: Fix deadlock on suspend

Maximilian Heyne (1):
      net: sched: avoid duplicates in classes dump

Michael Braun (1):
      gianfar: fix jumbo packets+napi+rx overrun crash

Michael Ellerman (2):
      powerpc/4xx: Fix build errors from mfdcr()
      powerpc/64s: Use symbolic macros for function entry encoding

Michael Petlan (1):
      perf trace: Fix race in signal handling

Michal Suchanek (1):
      ibmvnic: Fix possibly uninitialized old_num_tx_queues variable warnin=
g.

Mike Rapoport (1):
      mm/page_alloc.c: refactor initialization of struct page for
holes in memory layout

Minchan Kim (2):
      zram: fix return value on writeback_store
      zram: fix broken page writeback

Muhammad Usama Anjum (2):
      kvm: x86: use NULL instead of using plain integer as pointer
      kvm: x86: annotate RCU pointers

Nadav Amit (1):
      mm/userfaultfd: fix memory corruption due to writeprotect

Namhyung Kim (14):
      perf test: Fix cpu and thread map leaks in basic mmap test
      perf test: Fix a memory leak in attr test
      perf test: Fix cpu and thread map leaks in task_exit test
      perf test: Fix cpu and thread map leaks in sw_clock_freq test
      perf test: Fix cpu and thread map leaks in code_reading test
      perf test: Fix cpu and thread map leaks in keep_tracking test
      perf test: Fix cpu and thread map leaks in switch_tracking test
      perf test: Fix a thread map leak in thread_map_synthesize test
      perf test: Fix a memory leak in thread_map_remove test
      perf test: Fix cpu map leaks in cpu_map_print test
      perf test: Fix cpu and thread map leaks in perf_time_to_tsc test
      libperf: Add perf_evlist__reset_id_hash()
      perf stat: Fix use-after-free when -r option is used
      perf daemon: Fix compile error with Asan

Naveen N. Rao (1):
      powerpc/64s: Fix instruction encoding for lis in ppc_function_entry()

Neil Roberts (2):
      drm/shmem-helper: Check for purged buffers in fault handler
      drm/shmem-helper: Don't remove the offset in vm_area_struct pgoff

Nicholas Fraser (1):
      perf archive: Fix filtering of empty build-ids

Nicholas Piggin (1):
      powerpc: Fix inverted SET_FULL_REGS bitop

Nirmoy Das (1):
      drm/amdgpu: fb BO should be ttm_bo_type_device

Nitin Rawat (1):
      scsi: ufs: ufs-qcom: Disable interrupt in reset path

Niv Sardi (1):
      USB: serial: ch341: add new Product ID

Noralf Tr=C3=B8nnes (1):
      drm/shmem-helpers: vunmap: Don't put pages for dma-buf

OGAWA Hirofumi (1):
      mm/highmem.c: fix zero_user_segments() with start > end

Oded Gabbay (1):
      habanalabs: mark hl_eq_inc_ptr() as static

Oleksij Rempel (1):
      can: skb: can_skb_set_owner(): fix ref counting if socket was
closed before setting skb ownership

Ondrej Mosnacek (1):
      NFSv4.2: fix return value of _nfs4_get_security_label()

Ong Boon Leong (2):
      net: stmmac: fix incorrect DMA channel intr enable setting of EQoS v4=
.10
      net: stmmac: Fix VLAN filter delete timeout issue in Intel mGBE SGMII

Pablo Neira Ayuso (3):
      netfilter: nftables: disallow updates on table ownership
      netfilter: nftables: fix possible double hook unregistration
with table owner
      netfilter: nftables: bogus check for netlink portID with table owner

Paolo Abeni (4):
      mptcp: fix memory accounting on allocation error
      mptcp: factor out __mptcp_retrans helper()
      mptcp: fix race in release_cb
      mptcp: fix missing wakeup

Paul Cercueil (6):
      MIPS: boot/compressed: Copy DTB to aligned address
      net: davicom: Fix regulator not turned off on failed probe
      net: davicom: Fix regulator not turned off on driver removal
      net: davicom: Use platform_get_irq_optional()
      dt-bindings/irq: Add compatible string for the JZ4760B
      irqchip/ingenic: Add support for the JZ4760

Paul Moore (1):
      cipso,calipso: resolve a number of problems with the DOI refcounts

Paulo Alcantara (4):
      cifs: print MIDs in decimal notation
      cifs: change noisy error message to FYI
      cifs: return proper error code in statfs(2)
      cifs: do not send close in compound create+close requests

Pavel Begunkov (20):
      io_uring: make del_task_file more forgiving
      io_uring: introduce ctx to tctx back map
      io_uring: do ctx initiated file note removal
      io_uring: don't take task ring-file notes
      io_uring: index io_uring->xa by ctx not file
      io_uring: warn when ring exit takes too long
      io_uring: cancel reqs of all iowq's on ring exit
      io-wq: warn on creating manager while exiting
      io_uring: fix unrelated ctx reqs cancellation
      io_uring: clean R_DISABLED startup mess
      io_uring: fix io_sq_offload_create error handling
      io_uring: add io_disarm_next() helper
      io_uring: fix complete_post races for linked req
      io_uring: fix invalid ctx->sq_thread_idle
      io_uring: remove indirect ctx into sqo injection
      io_uring: cancel deferred requests in try_cancel
      io_uring: remove useless ->startup completion
      io_uring: prevent racy sqd->thread checks
      io_uring: cancel sqpoll via task_work
      io_uring: fix OP_ASYNC_CANCEL across tasks

Pavel Skripkin (4):
      net/qrtr: fix __netdev_alloc_skb call
      ALSA: usb-audio: fix NULL ptr dereference in usb_audio_probe
      ALSA: usb-audio: fix use after free in usb_audio_disconnect
      USB: serial: io_edgeport: fix memory leak in edge_startup

Pavel Turinsk=C3=BD (1):
      MAINTAINERS: update drm bug reporting URL

Pete Zaitcev (1):
      USB: usblp: fix a hang in poll() if disconnected

Peter Xu (5):
      hugetlb: dedup the code to add a new file_region
      hugetlb: break earlier in add_reservation_in_range() when we can
      mm: introduce page_needs_cow_for_dma() for deciding whether cow
      mm: use is_cow_mapping() across tree where proper
      hugetlb: do early cow when page pinned on src mm

Peter Zijlstra (10):
      sched: Fix migration_cpu_stop() requeueing
      sched: Simplify migration_cpu_stop()
      sched: Collate affine_move_task() stoppers
      sched: Optimize migration_cpu_stop()
      sched: Fix affine_move_task() self-concurrency
      sched: Simplify set_affinity_pending refcounts
      static_call: Fix the module key fixup
      u64_stats,lockdep: Fix u64_stats_init() vs lockdep
      seqlock,lockdep: Fix seqcount_latch_init()
      objtool,x86: Fix uaccess PUSHF/POPF validation

Philipp Zabel (1):
      net: dsa: bcm_sf2: simplify optional reset handling

Pierre Gondois (1):
      perf tools: Cast (struct timeval).tv_sec when printing

Pierre-Louis Bossart (1):
      iwlwifi: fix ARCH=3Di386 compilation warnings

Qingqing Zhuo (1):
      drm/amd/display: Enable pflip interrupt upon pipe enable

Rafa=C5=82 Mi=C5=82ecki (1):
      net: broadcom: bcm4908_enet: enable RX after processing packets

Randy Dunlap (2):
      fbdev: atyfb: always declare aty_{ld,st}_lcd()
      fbdev: atyfb: use LCD management functions for PPC_PMAC also

Ravi Bangoria (1):
      perf report: Fix -F for branch & mem modes

Rob Gardner (1):
      sparc64: Fix opcode filtering in handling of no fault loads

Rob Herring (1):
      arm64: perf: Fix 64-bit event counter read truncation

Ruslan Bilovol (2):
      usb: gadget: f_uac2: always increase endpoint max_packet_size by
one audio slot
      usb: gadget: f_uac1: stop playback on function disable

Sami Tolvanen (2):
      KVM: arm64: Don't use cbz/adr with external symbols
      kbuild: Allow LTO to be selected with KASAN_HW_TAGS

Sean Christopherson (4):
      KVM: x86: Ensure deadline timer has truly expired before posting its =
IRQ
      KVM: SVM: Connect 'npt' module param to KVM's internal 'npt_enabled'
      x86/perf: Use RET0 as default for guest_get_msrs to handle "no PMU" c=
ase
      KVM: x86/mmu: Skip !MMU-present SPTEs when removing SP in exclusive m=
ode

Sebastian Reichel (1):
      USB: serial: cp210x: add some more GE USB IDs

Serge Semin (1):
      usb: dwc3: qcom: Add missing DWC3 OF node refcount decrement

Sergei Trofimovich (2):
      ia64: fix ia64_syscall_get_set_arguments() for break-based syscalls
      ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign

Sergey Nazarov (1):
      CIPSO: Fix unaligned memory access in cipso_v4_gentag_hdr

Sergey Shtylyov (3):
      sh_eth: fix TRSCER mask for SH771x
      sh_eth: fix TRSCER mask for R7S72100
      sh_eth: fix TRSCER mask for R7S9210

Sharvari Harisangam (1):
      MAINTAINERS: update for mwifiex driver maintainers

Shawn Guo (2):
      cpufreq: qcom-hw: fix dereferencing freed memory 'data'
      usb: dwc3: qcom: add ACPI device id for sc8180x

Shile Zhang (1):
      misc/pvpanic: Export module FDT device table

Shin'ichiro Kawasaki (1):
      block: Discard page cache of zone reset target range

Shuah Khan (6):
      usbip: fix stub_dev to check for stream socket
      usbip: fix vhci_hcd to check for stream socket
      usbip: fix vudc to check for stream socket
      usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
      usbip: fix vhci_hcd attach_store() races leading to gpf
      usbip: fix vudc usbip_sockfd_store races leading to gpf

Shuo Liu (3):
      cpu/hotplug: Fix build error of using {add,remove}_cpu() with !CONFIG=
_SMP
      virt: acrn: Make remove_cpu sysfs invisible with !CONFIG_HOTPLUG_CPU
      virt: acrn: Correct type casting of argument of copy_from_user()

Simeon Simeonoff (1):
      ALSA: hda/ca0132: Add Sound BlasterX AE-5 Plus support

Stanislaw Gruszka (1):
      usb: xhci: do not perform Soft Retry for some xHCI hosts

Stefan Haberland (2):
      s390/dasd: fix hanging DASD driver unbind
      s390/dasd: fix hanging IO request during DASD driver unbind

Stefan Metzmacher (2):
      io_uring: run __io_sq_thread() with the initial creds from
io_uring_setup()
      io_uring: kill io_sq_thread_fork() and return -EOWNERDEAD if the
sq_thread is gone

Sudeep Holla (1):
      cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

Sung Lee (1):
      drm/amd/display: Revert dram_clock_change_latency for DCN2.1

Suren Baghdasaryan (1):
      mm/madvise: replace ptrace attach requirement for process_madvise

Suzuki K Poulose (2):
      KVM: arm64: nvhe: Save the SPE context early
      perf cs-etm: Fix bitmap for option

Takashi Iwai (8):
      ALSA: usb-audio: Fix "cannot get freq eq" errors on Dell AE515 sound =
bar
      ALSA: usb-audio: Apply the control quirk to Plantronics headsets
      ALSA: hda/conexant: Add quirk for mute LED control on HP ZBook G5
      ALSA: hda: Drop the BATCH workaround for AMD controllers
      ALSA: hda: Flush pending unsolicited events before suspend
      ALSA: hda: Avoid spurious unsol event handling during S3/S4
      ALSA: hda/hdmi: Cancel pending works before suspend
      drm/amd/display: Add a backlight module option

Thomas Bogendoerfer (1):
      MIPS: kernel: Reserve exception base early to prevent corruption

Thomas Richter (2):
      s390/cpumf: remove 60 seconds read limit
      s390/cpumf: rename header file to hwctrset.h

Thomas Zimmermann (1):
      drm: Use USB controller's DMA mask when importing dmabufs

Timo Rothenpieler (1):
      nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default

Tomer Tayar (2):
      habanalabs: Call put_pid() when releasing control device
      habanalabs: Disable file operations after device is removed

Tong Zhang (6):
      atm: eni: dont release is never initialized
      atm: lanai: dont run lanai_dev_close if not open
      atm: fix a typo in the struct description
      atm: uPD98402: fix incorrect allocation
      atm: idt77252: fix null-ptr-dereference
      drm/fb-helper: only unmap if buffer not null

Torin Cooper-Bennun (1):
      can: tcan4x5x: tcan4x5x_init(): fix initialization - clear MRAM
before entering Normal Mode

Trond Myklebust (5):
      NFS: Don't revalidate the directory permissions on a lookup failure
      NFS: Don't gratuitously clear the inode cache when lookup failed
      NFS: Clean up function nfs_mark_dir_for_revalidate()
      NFS: Fix open coded versions of nfs_set_cache_invalid()
      NFS: Fix open coded versions of nfs_set_cache_invalid() in NFSv4

Tvrtko Ursulin (1):
      drm/i915: Wedge the GPU if command parser setup fails

Tyrel Datwyler (5):
      scsi: ibmvfc: Simplify handling of sub-CRQ initialization
      scsi: ibmvfc: Fix invalid sub-CRQ handles after hard reset
      scsi: ibmvfc: Treat H_CLOSED as success during sub-CRQ registration
      scsi: ibmvfc: Store return code of H_FREE_SUB_CRQ during cleanup
      scsi: ibmvfc: Reinitialize sub-CRQs and perform channel enquiry after=
 LPM

Uwe Kleine-K=C3=B6nig (3):
      vio: make remove callback return void
      leds: trigger: Fix error path to not unlock the unlocked mutex
      leds: trigger/tty: Use led_set_brightness_sync() from workqueue

Vasily Averin (1):
      netfilter: x_tables: gpf inside xt_find_revision()

Vasundhara Volam (1):
      bnxt_en: Fix race between firmware reset and driver remove.

Vishal Bhakta (1):
      scsi: vmw_pvscsi: MAINTAINERS: Update maintainer

Vladimir Oltean (13):
      net: enetc: don't overwrite the RSS indirection table when initializi=
ng
      net: enetc: initialize RFS/RSS memories for unused ports too
      net: enetc: take the MDIO lock only once per NAPI poll cycle
      net: enetc: fix incorrect TPID when receiving 802.1ad tagged packets
      net: enetc: don't disable VLAN filtering in IFF_PROMISC mode
      net: enetc: force the RGMII speed and duplex instead of
operating in inband mode
      net: enetc: remove bogus write to SIRXIDR from enetc_setup_rxbdr
      net: enetc: keep RX ring consumer index in sync with hardware
      net: mscc: ocelot: properly reject destination IP keys in VCAP IS1
      net: dsa: sja1105: fix SGMII PCS being forced to SPEED_UNKNOWN
instead of SPEED_10
      net: dsa: sja1105: fix ucast/bcast flooding always remaining enabled
      net: dsa: fix switchdev objects on bridge master mistakenly
being applied on ports
      net: enetc: allow hardware timestamping on TX queues with tc-etf enab=
led

Vlastimil Babka (1):
      MAINTAINERS: exclude uapi directories in API/ABI section

Wang Qing (2):
      s390/cio: return -EFAULT if copy_to_user() fails
      s390/crypto: return -EFAULT if copy_to_user() fails

Wanpeng Li (2):
      KVM: kvmclock: Fix vCPUs > 64 can't be online/hotpluged
      KVM: LAPIC: Advancing the timer expiration on guest initiated write

Wei Yongjun (6):
      iwlwifi: mvm: add terminate entry for dmi_system_id tables
      cpufreq: qcom-hw: Fix return value check in qcom_cpufreq_hw_cpu_init(=
)
      umem: fix error return code in mm_pci_probe()
      USB: gadget: udc: s3c2410_udc: fix return value check in
s3c2410_udc_probe()
      regulator: rt4831: Fix return value check in rt4831_regulator_probe()
      perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe=
()

Will Deacon (3):
      KVM: arm64: Avoid corrupting vCPU context register in guest exit
      arm64: cpufeatures: Fix handling of CONFIG_CMDLINE for idreg override=
s
      arm64: Drop support for CMDLINE_EXTEND

Willem de Bruijn (1):
      net: expand textsearch ts_state to fit skb_seq_state

Wong Vee Khee (2):
      stmmac: intel: Fix mdio bus registration issue for TGL-H/ADL-S
      stmmac: intel: Fixes clock registration error seen for multiple inter=
faces

Xie He (1):
      net: lapbether: Remove netif_start_queue / netif_stop_queue

Xu Wang (1):
      selftest/net/ipsec.c: Remove unneeded semicolon

Xunlei Pang (1):
      blk-cgroup: Fix the recursive blkg rwstat

Yang Li (3):
      gfs2: make function gfs2_make_fs_ro() to void type
      gpiolib: acpi: Add missing IRQF_ONESHOT
      io_uring: remove unneeded variable 'ret'

Yann Gautier (1):
      mmc: mmci: Add MMC_CAP_NEED_RSP_BUSY for the stm32 variants

Yauheni Kaliuta (1):
      selftests/bpf: Mask bpf_csum_diff() return value to 16 bits in
test_verifier

Yejune Deng (3):
      inetpeer: use div64_ul() and clamp_val() calculate inet_peer_threshol=
d
      virt: acrn: Use vfs_poll() instead of f_op->poll()
      virt: acrn: Use EPOLLIN instead of POLLIN

Yinjun Zhang (1):
      ethtool: fix the check logic of at least one channel for RX/TX

Yorick de Wid (1):
      Goodix Fingerprint device is not a modem

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Clear PIPECFG for re-enabling pipe with other EPN=
UM

Zhan Liu (1):
      drm/amdgpu/display: Use wm_table.entries for dcn301 calculate_wm

Zhang Yunkai (1):
      arch/parisc/kernel: remove duplicate include in ptrace

Zhou Guanghui (2):
      mm/memcg: rename mem_cgroup_split_huge_fixup to split_page_memcg
and add nr_pages argument
      mm/memcg: set memcg when splitting page

farah kassabri (1):
      habanalabs: fix debugfs address translation

satya priya (2):
      regulator: qcom-rpmh: Correct the pmic5_hfsmps515 buck
      regulator: qcom-rpmh: Use correct buck for S1C regulator

yangerkun (1):
      io-wq: fix ref leak for req in case of exit cancelations

zhang kai (1):
      rtnetlink: using dev_base_seq from target net
