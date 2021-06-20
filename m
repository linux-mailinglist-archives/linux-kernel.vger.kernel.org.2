Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FD3AE0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 00:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFTWmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 18:42:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C258C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 15:40:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x14so22434293ljp.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GdbPYMA/3wIcZtGG3NIt8JKzuPbuO8RPNbc20LcarMM=;
        b=CSLsxDv3c37scAiSekOQaw0uRe5QE9X2fIo8ewpj9fQdY268GCuR6jujFIMBA4v4m6
         hq0NrT1mxNwPaNBzjL509VvPnYHEzoqIw5aefclWVj7DCLO9jH7a3UCCoLDfQMI2ygE1
         kasObCgwL19nwCaHJ8CjPHpr3UvECRTBNSlXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GdbPYMA/3wIcZtGG3NIt8JKzuPbuO8RPNbc20LcarMM=;
        b=lgObDTh84tvphrtULGRrDuzSTN0xowcF8SgWpiIWya5RVrB+n5ETL2/IhVNTutzU8L
         62r1VdH2yJdQXWPPZ8gp1LsQnteA2SMdixhpoDHubrkp2sFBJYKOyXyp95CVj0qp8JRW
         oKfqZXVX1SmEVXNzq6SpB8jaeYa2H76SIZV6a7N61Zf187OHvYQKJZ90cb3zDxXKTR5i
         0A5aItO7qMXWrszpFB3mB+PIZiFDBSlZvHjHSRGoQ2SUv+wRNLiSRRgAHtFRYszb+W7J
         ZCB6k0B/JfJTMl4/5dVs6v/VKqGNstXXbonfut07NphipL7LXnJihyv5PHu1Sv2lfUcY
         IO9Q==
X-Gm-Message-State: AOAM5302jEuchqvFkBjlG1ZHmGQevbFBi1Q4+xA9C1TeoFRt1XeWyYzL
        yX8Q9JerMnWVGJqia8lnGOLjbnagdiMHAM1X
X-Google-Smtp-Source: ABdhPJznZyY/SsAwROAkT+roLowTrIB4JVG2I5IjEPAWl2c5iIe98Pp1PRZw6j1x19xdFz+cZpbS8g==
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr19325989ljj.196.1624228832741;
        Sun, 20 Jun 2021 15:40:32 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q21sm1666463lfp.233.2021.06.20.15.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 15:40:32 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z22so22395545ljh.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 15:40:32 -0700 (PDT)
X-Received: by 2002:a2e:7a14:: with SMTP id v20mr18604286ljc.465.1624228832029;
 Sun, 20 Jun 2021 15:40:32 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Jun 2021 15:40:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjj38E8hW+unHZ9EaJrS6x+4Tnz0qffjvLcGf70dXkKnQ@mail.gmail.com>
Message-ID: <CAHk-=wjj38E8hW+unHZ9EaJrS6x+4Tnz0qffjvLcGf70dXkKnQ@mail.gmail.com>
Subject: Linux 5.13-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we've had a very calm last week, and in fact if it hadn't been for
the networking side, it would have been positively tiny.

Just over half the commits are from the networking tree, and honestly,
though networking changes dominate, it's not like there's a ton of
networking changes - it's all  pretty small.

The two largest commits are a revert and a code movement patch for a
build issue.

So there's not a huge number of patches in here, and most of the
patches are pretty small too. A fair number of one-liners and
"few-liners".

Which is just how I like it.

Let's hope the trend continues for next week, and I'll be a happy camper.

Go test,

            Linus

---

Aleksander Jan Bajkowski (2):
      net: lantiq: disable interrupt before sheduling NAPI
      lantiq: net: fix duplicated skb in rx descriptor ring

Alex Elder (1):
      net: qualcomm: rmnet: don't over-count statistics

Alex Vesker (1):
      net/mlx5: DR, Fix STEv1 incorrect L3 decapsulation padding

Alexander Gordeev (2):
      s390/mcck: fix calculation of SIE critical section size
      s390/mcck: fix invalid KVM guest condition check

Alper Gun (1):
      KVM: SVM: Call SEV Guest Decommission if ASID binding fails

Andrea Righi (2):
      selftests: net: veth: make test compatible with dash
      selftests: net: use bash to run udpgro_fwd test case

Andrew Lunn (1):
      usb: core: hub: Disable autosuspend for Cypress CY7C65632

Andrew Morton (1):
      mm/slub.c: include swab.h

Andy Lutomirski (1):
      x86/fpu: Invalidate FPU state after a failed XRSTOR from a user buffe=
r

Antti J=C3=A4rvinen (1):
      PCI: Mark TI C667X to avoid bus reset

Arnaldo Carvalho de Melo (3):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync asm-generic/unistd.h with the kernel origina=
l
      tools headers UAPI: Sync linux/in.h copy with the kernel sources

Athira Rajeev (1):
      powerpc/perf: Fix crash in perf_instruction_pointer() when ppmu is no=
t set

Austin Kim (1):
      net: ethtool: clear heap allocations for ethtool function

Avraham Stern (1):
      cfg80211: avoid double free of PMSR request

Aya Levin (5):
      net/mlx5e: Don't update netdev RQs with PTP-RQ
      net/mlx5e: Fix select queue to consider SKBTX_HW_TSTAMP
      net/mlx5e: Block offload of outer header csum for UDP tunnels
      net/mlx5e: Block offload of outer header csum for GRE tunnel
      net/mlx5: Reset mkey index on creation

Breno Lima (1):
      usb: chipidea: imx: Fix Battery Charger 1.2 CDP detection

Brian Norris (1):
      mac80211: correct ieee80211_iterate_active_interfaces_mtx()
locking comments

Bumyong Lee (1):
      dmaengine: pl330: fix wrong usage of spinlock flags in dma_cyclc

Changbin Du (2):
      net: make get_net_ns return error if NET_NS is disabled
      net: inline function get_net_ns_by_fd if NET_NS is disabled

ChenXiaoSong (1):
      KVM: SVM: fix doc warnings

Chengyang Fan (1):
      net: ipv4: fix memory leak in ip_mc_add1_src

Chiqijun (1):
      PCI: Work around Huawei Intelligent NIC VF FLR erratum

Chris Mi (1):
      net/mlx5e: Verify dev is present in get devlink port ndo

Christophe JAILLET (4):
      alx: Fix an error handling path in 'alx_probe()'
      qlcnic: Fix an error handling path in 'qlcnic_probe()'
      netxen_nic: Fix an error handling path in 'netxen_nic_probe()'
      be2net: Fix an error handling path in 'be_probe()'

Christophe Leroy (1):
      powerpc/mem: Add back missing header to fix 'no previous prototype' e=
rror

Dan Carpenter (1):
      afs: Fix an IS_ERR() vs NULL check

Daniel Borkmann (4):
      bpf: Inherit expanded/patched seen count from old aux data
      bpf: Do not mark insn as seen under speculative path verification
      bpf: Fix leakage under speculation on mispredicted branches
      bpf, selftests: Adjust few selftest outcomes wrt unreachable code

Dave Jiang (3):
      dmaengine: idxd: add engine 'struct device' missing bus type assignme=
nt
      dmaengine: idxd: add missing dsa driver unregister
      dmaengine: idxd: Add missing cleanup for early error out in probe cal=
l

David Abdurachmanov (1):
      riscv: dts: fu740: fix cache-controller interrupts

David Ahern (2):
      neighbour: allow NUD_NOARP entries to be forced GCed
      ipv4: Fix device used for dst_alloc with local routes

Dima Chumak (1):
      net/mlx5e: Fix page reclaim for dead peer hairpin

Dmytro Linkin (1):
      net/mlx5e: Don't create devices during unload flow

Dongliang Mu (1):
      net: usb: fix possible use-after-free in smsc75xx_bind

Du Cheng (2):
      cfg80211: call cfg80211_leave_ocb when switching away from OCB
      mac80211: fix skb length check in ieee80211_scan_rx()

Eric Dumazet (7):
      inet: annotate data race in inet_send_prepare() and inet_dgram_connec=
t()
      net: annotate data race in sock_error()
      inet: annotate date races around sk->sk_txhash
      net/packet: annotate data race in packet_sendmsg()
      net/packet: annotate accesses to po->bind
      net/packet: annotate accesses to po->ifindex
      net/af_unix: fix a data-race in unix_dgram_sendmsg / unix_release_soc=
k

Esben Haabendal (4):
      net: ll_temac: Make sure to free skb when it is completely used
      net: ll_temac: Add memory-barriers for TX BD access
      net: ll_temac: Fix TX BD buffer overwrite
      net: ll_temac: Avoid ndo_start_xmit returning NETDEV_TX_BUSY

Evan Quan (1):
      PCI: Mark AMD Navi14 GPU ATS as broken

Fan Du (1):
      x86/mm: Avoid truncating memblocks for SGX memory

Felix Fietkau (1):
      mac80211: minstrel_ht: fix sample time check

Florian Westphal (2):
      selftests: netfilter: add fib test case
      netfilter: nft_fib_ipv6: skip ipv6 packets from any to link-local

Fuad Tabba (1):
      KVM: selftests: Fix kvm_check_cap() assertion

Fugang Duan (1):
      net: fec_ptp: add clock rate zero check

Guillaume Ranquet (3):
      dmaengine: mediatek: free the proper desc in desc_free handler
      dmaengine: mediatek: do not issue a new desc if one is still current
      dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma

Gustavo A. R. Silva (1):
      KVM: x86: Fix fall-through warnings for Clang

Harald Freudenberger (1):
      s390/ap: Fix hanging ioctl caused by wrong msg counter

Hugh Dickins (5):
      mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
      mm/thp: make is_huge_zero_pmd() safe and quicker
      mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
      mm/thp: fix vma_address() if virtual address below file offset
      mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()

Huy Nguyen (1):
      net/mlx5e: Remove dependency in IPsec initialization flows

Ian Rogers (1):
      perf test: Fix non-bash issue with stat bpf counters

Ido Schimmel (2):
      ethtool: Fix NULL pointer dereference during module EEPROM dump
      rtnetlink: Fix regression in bridge VLAN configuration

Jakub Kicinski (2):
      ethtool: strset: fix message length calculation
      ptp: improve max_adj check against unreasonable values

Jiapeng Chong (1):
      dmaengine: idxd: Fix missing error code in idxd_cdev_open()

Jim Mattson (1):
      kvm: LAPIC: Restore guard to prevent illegal APIC register access

Jisheng Zhang (3):
      net: stmmac: dwmac1000: Fix extended MAC address registers definition
      riscv: kasan: Fix MODULES_VADDR evaluation due to local variables' na=
me
      riscv: Ensure BPF_JIT_REGION_START aligned with PMD size

Joakim Zhang (2):
      net: stmmac: disable clocks in stmmac_remove_config_dt()
      net: fec_ptp: fix issue caused by refactor the fec_devtype

Johannes Berg (12):
      mac80211: remove warning in ieee80211_get_sband()
      mac80211_hwsim: drop pending frames on stop
      staging: rtl8723bs: fix monitor netdev register/unregister
      mac80211: fix deadlock in AP/VLAN handling
      mac80211: fix 'reset' debugfs locking
      cfg80211: fix phy80211 symlink creation
      cfg80211: shut down interfaces on failed resume
      mac80211: move interface shutdown out of wiphy lock
      mac80211: drop multicast fragments
      cfg80211: make certificate generation more robust
      mac80211: reset profile_periodicity/ema_ap
      mac80211: handle various extensible elements correctly

John Garry (2):
      perf metricgroup: Fix find_evsel_group() event selector
      perf metricgroup: Return error code from
metricgroup__add_metric_sys_event_iter()

Jon Hunter (1):
      PCI: tegra194: Fix MCFG quirk build regressions

Jue Wang (1):
      mm/thp: fix page_address_in_vma() on file THP tails

Kai Huang (1):
      x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed

Karsten Graul (1):
      MAINTAINERS: add Guvenc as SMC maintainer

Kees Cook (7):
      mm/slub: clarify verification reporting
      mm/slub: fix redzoning for small allocations
      mm/slub: actually fix freelist pointer vs redzoning
      r8152: Avoid memcpy() over-reading of ETH_SS_STATS
      sh_eth: Avoid memcpy() over-reading of ETH_SS_STATS
      r8169: Avoid memcpy() over-reading of ETH_SS_STATS
      net: qed: Fix memcpy() overflow of qed_dcbx_params()

Kev Jackson (1):
      libbpf: Fixes incorrect rx_ring_setup_done

Khem Raj (1):
      riscv32: Use medany C model for modules

Kristian Evensen (1):
      qmi_wwan: Do not call netif_rx from rx_fixup

Laurent Pinchart (2):
      dmaengine: xilinx: dpdma: Add missing dependencies to Kconfig
      dmaengine: xilinx: dpdma: Limit descriptor IDs to 16 bits

Leon Romanovsky (2):
      net/mlx5: Fix error path for set HCA defaults
      net/mlx5: Check that driver was probed prior attaching the device

Linus Torvalds (2):
      proc: only require mm_struct for writing
      Linux 5.13-rc7

Linyu Yuan (1):
      net: cdc_eem: fix tx fixup skb leak

Luiz Augusto von Dentz (1):
      Bluetooth: SMP: Fix crash when receiving new connection when
debug is enabled

Maciej Fijalkowski (2):
      ice: add ndo_bpf callback for safe mode netdev ops
      ice: parameterize functions responsible for Tx ring management

Maciej =C5=BBenczykowski (1):
      net: cdc_ncm: switch to eth%d interface naming

Maor Gottlieb (2):
      net/mlx5: Consider RoCE cap before init RDMA resources
      net/mlx5: DR, Don't use SW steering when RoCE is not supported

Marc Zyngier (1):
      irqchip/gic-v3: Workaround inconsistent PMR setting on NMI entry

Marcelo Ricardo Leitner (1):
      net/sched: act_ct: handle DNAT tuple collision

Marcin Juszkiewicz (1):
      quota: finish disable quotactl_path syscall

Mathy Vanhoef (1):
      mac80211: Fix NULL ptr deref for injected rate info

Matthew Bobrowski (1):
      fanotify: fix copy_event_to_user() fid error clean up

Matthew Wilcox (Oracle) (1):
      afs: Re-enable freezing once a page fault is interrupted

Maxim Mikityanskiy (3):
      netfilter: synproxy: Fix out of bounds when parsing TCP options
      mptcp: Fix out of bounds when parsing TCP options
      sch_cake: Fix out of bounds when parsing TCP options and header

Michael Chan (1):
      bnxt_en: Rediscover PHY capabilities after firmware reset

Michael Ellerman (2):
      powerpc/signal64: Copy siginfo before changing regs->nip
      powerpc: Fix initrd corruption with relative jump labels

Mike Kravetz (1):
      mm/hugetlb: expand restore_reserve_on_error functionality

Mikel Rychliski (1):
      PCI: Add AMD RS690 quirk to enable 64-bit DMA

Miles Chen (1):
      mm/sparse: fix check_usemap_section_nr warnings

Mykola Kostenok (1):
      mlxsw: core: Set thermal zone polling delay argument to real value at=
 init

Nanyong Sun (1):
      net: ipv4: fix memory leak in netlbl_cipsov4_add_std

Naohiro Aota (1):
      btrfs: zoned: fix negative space_info->bytes_readonly

Naoya Horiguchi (1):
      mm,hwpoison: fix race with hugetlb page allocation

Nicolas Dichtel (1):
      vrf: fix maximum MTU

Nikolay Aleksandrov (2):
      net: bridge: fix vlan tunnel dst null pointer dereference
      net: bridge: fix vlan tunnel dst refcnt when egressing

Norbert Slusarek (1):
      can: bcm: fix infoleak in struct bcm_msg_head

Odin Ugedal (1):
      sched/fair: Correctly insert cfs_rq's to list on unthrottle

Oleksij Rempel (1):
      can: j1939: fix Use-after-Free, hold skb ref while in use

Pablo Neira Ayuso (1):
      netfilter: nf_tables: initialize set before expression setup

Pali Roh=C3=A1r (1):
      PCI: aardvark: Fix kernel panic during PIO transfer

Paolo Abeni (6):
      udp: fix race between close() and udp_abort()
      mptcp: try harder to borrow memory from subflow under pressure
      mptcp: wake-up readers only for in sequence data
      mptcp: do not warn on bad input from the network
      selftests: mptcp: enable syncookie only in absence of reorders
      mptcp: fix soft lookup in subflow_error_report()

Parav Pandit (3):
      net/mlx5: E-Switch, Read PF mac address
      net/mlx5: E-Switch, Allow setting GUID for host PF vport
      net/mlx5: SF_DEV, remove SF device on invalid state

Pavel Machek (1):
      cxgb4: fix wrong shift.

Pavel Skripkin (7):
      revert "net: kcm: fix memory leak in kcm_sendmsg"
      net: rds: fix memory leak in rds_recvmsg
      net: caif: fix memory leak in ldisc_open
      net: qrtr: fix OOB Read in qrtr_endpoint_post
      can: mcba_usb: fix memory leak in mcba_usb
      net: hamradio: fix memory leak in mkiss_close
      net: ethernet: fix potential use-after-free in ec_bhf_remove

Peter Chen (1):
      usb: dwc3: core: fix kernel panic when do reboot

Peter Xu (1):
      mm/swap: fix pte_same_as_swp() not removing uffd-wp bit when compare

Peter Zijlstra (1):
      recordmcount: Correct st_shndx handling

Petr Machata (2):
      mlxsw: reg: Spectrum-3: Enforce lowest max-shaper burst size of 11
      mlxsw: spectrum_qdisc: Pass handle, not band number to find_class()

Pingfan Liu (1):
      crash_core, vmcoreinfo: append 'SECTION_SIZE_BITS' to vmcoreinfo

Praneeth Bajjuri (1):
      net: phy: dp83867: perform soft reset and retain established link

Punit Agrawal (2):
      printk: Move EXPORT_SYMBOL() closer to vprintk definition
      PCI: of: Clear 64-bit flag for non-prefetchable memory below 4GB

Quanyang Wang (1):
      dmaengine: xilinx: dpdma: initialize registers before request_irq

Rahul Lakkireddy (4):
      cxgb4: fix endianness when flashing boot image
      cxgb4: fix sleep in atomic when flashing PHY firmware
      cxgb4: halt chip before flashing PHY firmware image
      cxgb4: fix wrong ethtool n-tuple rule lookup

Randy Dunlap (4):
      dmaengine: ALTERA_MSGDMA depends on HAS_IOMEM
      dmaengine: QCOM_HIDMA_MGMT depends on HAS_IOMEM
      dmaengine: SF_PDMA depends on HAS_IOMEM
      riscv: sifive: fix Kconfig errata warning

Riccardo Mancini (1):
      perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL

Rukhsana Ansari (1):
      bnxt_en: Fix TQM fastpath ring backing store computation

Sean Christopherson (2):
      KVM: x86: Immediately reset the MMU context when the SMM flag is clea=
red
      KVM: x86/mmu: Calculate and check "full" mmu_role for nested MMU

Shanker Donthineni (1):
      PCI: Mark some NVIDIA GPUs to avoid bus reset

Shay Agroskin (1):
      net: ena: fix DMA mapping function issues in XDP

Shay Drory (1):
      Revert "net/mlx5: Arm only EQs with EQEs"

Somnath Kotur (1):
      bnxt_en: Call bnxt_ethtool_free() in bnxt_init_one() error path

Sriharsha Basavapatna (1):
      PCI: Add ACS quirk for Broadcom BCM57414 NIC

Steven Rostedt (VMware) (3):
      tracing: Do not stop recording cmdlines when tracing is off
      tracing: Do not stop recording comms if the trace file is being read
      tracing: Do no increment trace_clock_global() by one

Subash Abhinov Kasiviswanathan (1):
      net: mhi_net: Update the transmit handler prototype

Sven Eckelmann (1):
      batman-adv: Avoid WARN_ON timing related checks

Tetsuo Handa (1):
      can: bcm/raw/isotp: use per module netdevice notifier

Thomas Gleixner (4):
      x86/fpu: Prevent state corruption in __fpu__restore_sig()
      x86/process: Check PF_KTHREAD and not current->mm for kernel threads
      x86/pkru: Write hardware init value to PKRU when xstate is init
      x86/fpu: Reset state for all signal restore failures

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      icmp: don't send out ICMP messages with a source address of 0.0.0.0
      selftests/net: Add icmp.sh for testing ICMP dummy address responses

Tom Lendacky (1):
      x86/ioremap: Map EFI-reserved memory as encrypted for SEV

Tor Vic (1):
      Makefile: lto: Pass -warn-stack-size only on LLD < 13.0.0

Tyson Moore (1):
      sch_cake: revise docs for RFC 8622 LE PHB support

Vineet Gupta (2):
      ARCv2: save ABI registers across signal handling
      ARC: fix CONFIG_HARDENED_USERCOPY

Viresh Kumar (1):
      Revert "cpufreq: CPPC: Add support for frequency invariance"

Vlad Buslov (1):
      net/mlx5e: Fix use-after-free of encap entry in neigh update handler

Vladimir Oltean (1):
      net: dsa: felix: re-enable TX flow control in ocelot_port_flush()

Wanpeng Li (1):
      KVM: X86: Fix x86_emulator slab cache leak

Willem de Bruijn (1):
      skbuff: fix incorrect msg_zerocopy copy notifications

Xu Yu (1):
      mm, thp: use head page in __migration_entry_wait()

Yanan Wang (1):
      KVM: selftests: Fix compiling errors when initializing the
static structure

Yang Li (1):
      net/mlx5e: Fix an error code in mlx5e_arfs_create_tables()

Yang Shi (1):
      mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap fails for split

Yang Yingliang (2):
      dmaengine: stedma40: add missing iounmap() on error in d40_probe()
      dmaengine: ipu: fix doc warning in ipu_irq.c

Yifan Zhang (2):
      drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue.
      drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover
full doorbell.

Yu Kuai (2):
      dmaengine: zynqmp_dma: Fix PM reference leak in
zynqmp_dma_alloc_chan_resourc()
      dmaengine: stm32-mdma: fix PM reference leak in
stm32_mdma_alloc_chan_resourc()

Zhen Lei (1):
      dmaengine: fsl-dpaa2-qdma: Fix error return code in two functions

Zheng Yongjun (2):
      net: ipv4: Remove unneed BUG() function
      ping: Check return value of function 'ping_queue_rcv_skb'

Zou Wei (1):
      dmaengine: rcar-dmac: Fix PM reference leak in rcar_dmac_probe()

gushengxian (1):
      net: appletalk: fix the usage of preposition

yangerkun (1):
      mm/memory-failure: make sure wait for page writeback in memory_failur=
e
