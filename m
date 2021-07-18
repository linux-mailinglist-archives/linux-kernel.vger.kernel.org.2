Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353E3CCAFB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhGRVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhGRVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:35:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5385C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:32:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f30so19845378lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=en9QKi6ZM6w0mJQZAnZEVKwvK4Qtlg8qb2lHw5guDHA=;
        b=CYm35YcRHrjddCWUjFwhuXWk4C4dBZO1WIWF+9Ib14uUrmmAlTcn+HMfLjXa4d/FzN
         ziU+FYRYsllM2uycV/ZQj6V+W5+e74UqUKm0gTmQRkhC0FJ1QUXjNgU82OlgiBoIzaY6
         BG1OTPtmfCnv041qtyYWLXzNgFfC+FNjPHmas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=en9QKi6ZM6w0mJQZAnZEVKwvK4Qtlg8qb2lHw5guDHA=;
        b=deRVRZBoo2Yw6dQswezc3Z4NuC5JVfMpbdEuk4u5iL16nuSpy1p5rIOjeZ11wI1P3A
         jaFxSklKcyOXSZbBzbGFHJg7Z9jQTMoYTH5EksKP1U1s1XQFQRAlMS2a0jh2dBl82QrR
         Cf/ybwQgB3U/o3Q3nBJF7+UWjEhIb6dJCW+lD1VzEGHKFiDoxYVj7L+q1YnEDhMmSAFK
         RojGJVO7m+hHKGSbcDofqrp2L4roLY/PpLCG9+LxenXEHFy4NC5yPDe4MBqsOIVAqSs0
         1NY9Y1yHL4eoV291D9vy7ss7S5hhbnl+euG2c6VLc45vlPJytcyly3k8FxXCMGYpKPG+
         eoJg==
X-Gm-Message-State: AOAM533HXx8Rp64hxWRK8hsjxcvIDnaWGJKNAG7jQsiVtYDDfP3v6gGk
        lFIxKXcpnvZzvcoUkp2B2JyelZvS1bRxxQ==
X-Google-Smtp-Source: ABdhPJyCg5Pi+sMDFS4PypInS/NRsrAOIkYCzoTd3WFASxkDHFijBOzZhMynovW9oYvdzxj1BOeqQA==
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr16800562lfu.299.1626643968688;
        Sun, 18 Jul 2021 14:32:48 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e20sm1790626lji.140.2021.07.18.14.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 14:32:48 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id f30so19845281lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:32:48 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr15856420lfl.41.1626643967677;
 Sun, 18 Jul 2021 14:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Jul 2021 14:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYghA5O+ZsWKVNApMK3j4V1EibO5P+c4MrHnqp8YhY=g@mail.gmail.com>
Message-ID: <CAHk-=wjYghA5O+ZsWKVNApMK3j4V1EibO5P+c4MrHnqp8YhY=g@mail.gmail.com>
Subject: Linux 5.14-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Often rc2 ends up being fairly small and calm - either because people
take a breather after the merge window, or because it takes a while
for people to start reporting bugs.

Not so this time.

At least in pure number of commits, this is the biggest rc2 we've had
during the 5.x cycle. Whether that is meaningful or not, who knows -
it might be just random timing effects, or it might indicate that this
release is not going to be one of those nice and calm ones. We'll just
have to wait and see.

But it's not like anything looks super-scary, and it really is too
early to start worrying about it, so let's just say that rc2's are
usually smaller than this, and just leave it at that.

The changes are a bit all over the map, with gpu and networking driver
fixes accounting for about half of the patch. But some of that is -
again - AMD GPU header file noise, so that may not be all that
important. The rest tends to be a mix of things: filesystem fixes,
networking, perf tool and selftest fixes, and various random noise.

While being larger than usual, it's by no means _huge_, and anybody
who cares about the details can easily scan the appended shortlog.

                 Linus

---

Aaron Liu (1):
      drm/amd/pm: Add waiting for response of mode-reset message for yellow=
 carp

Aaron Ma (1):
      mt76: mt7921: continue to probe driver when fw already downloaded

Aleksandr Loktionov (1):
      igb: Check if num of q_vectors is smaller than max before array acces=
s

Alexander Ovechkin (1):
      net: send SYNACK packet with accepted fwmark

Ali Abdallah (2):
      netfilter: conntrack: improve RST handling when tuple is re-used
      netfilter: conntrack: add new sysctl to disable RST check

Alistair Popple (1):
      lib/test_hmm: remove set but unused page variable

Andreas Gruenbacher (3):
      iomap: Permit pages without an iop to enter writeback
      iomap: Don't create iomap_page objects for inline files
      iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor

Andrew Jeffery (2):
      ARM: dts: tacoma: Add phase corrections for eMMC
      ARM: dts: everest: Add phase corrections for eMMC

Antoine Tenart (1):
      net: do not reuse skbuff allocated from skbuff_fclone_cache in
the skb cache

Arnaldo Carvalho de Melo (3):
      tools headers UAPI: Sync files changed by the memfd_secret new syscal=
l
      perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into
sysconf(__SC_THREAD_STACK_MIN_VALUE)
      tools headers: Remove broken definition of __LITTLE_ENDIAN

B. J. Wyman (1):
      ARM: dts: aspeed: everest: PSU #3 address change

Bailey Forrest (1):
      gve: DQO: Remove incorrect prefetch

Baowen Zheng (1):
      openvswitch: Optimize operation for key comparison

Bart Van Assche (3):
      scsi: core: Fix the documentation of the scsi_execute() time paramete=
r
      scsi: fas216: Fix a build error
      configfs: fix the read and write iterators

Benjamin Gaignard (1):
      iommu/rockchip: Fix physical address decoding

Biju Das (5):
      clk: renesas: rzg2l: Add multi clock PM support
      clk: renesas: r9a07g044: Rename divider table
      clk: renesas: r9a07g044: Fix P1 Clock
      clk: renesas: r9a07g044: Add P2 Clock support
      dt-bindings: clock: r9a07g044-cpg: Update clock/reset definitions

Carlos Bilbao (1):
      arm64: Add missing header <asm/smp.h> in two files

Casey Chen (2):
      nvme-pci: fix multiple races in nvme_setup_io_queues
      nvme-pci: do not call nvme_dev_remove_admin from nvme_remove

Chengming Gui (1):
      drm/amd/pm: Fix BACO state setting for Beige_Goby

Christian Borntraeger (2):
      KVM: selftests: introduce P44V64 for z196 and EC12
      KVM: selftests: do not require 64GB in set_memory_region_test

Christian Brauner (2):
      cgroup: verify that source is a string
      fs: add vfs_parse_fs_param_source() helper

Christian K=C3=B6nig (1):
      drm/qxl: add NULL check for bo->resource

Christoph Hellwig (6):
      net: remove the caif_hsi driver
      sd: don't mess with SD_MINORS for CONFIG_DEBUG_BLOCK_EXT_DEVT
      xen-blkfront: sanitize the removal state machine
      iomap: remove the length variable in iomap_seek_data
      iomap: remove the length variable in iomap_seek_hole
      mm: fix the try_to_unmap prototype for !CONFIG_MMU

Christophe JAILLET (9):
      ixgbe: Fix an error handling path in 'ixgbe_probe()'
      igc: Fix an error handling path in 'igc_probe()'
      igb: Fix an error handling path in 'igb_probe()'
      fm10k: Fix an error handling path in 'fm10k_probe()'
      e1000e: Fix an error handling path in 'e1000_probe()'
      iavf: Fix an error handling path in 'iavf_probe()'
      gve: Fix an error handling path in 'gve_probe()'
      gve: Propagate error codes to caller
      gve: Simplify code and axe the use of a deprecated API

Chuck Lever (1):
      mm/page_alloc: further fix __alloc_pages_bulk() return value

Colin Ian King (3):
      netfilter: nf_tables: Fix dereference of null pointer flow
      octeontx2-pf: Fix assigned error return value that is never used
      octeontx2-pf: Fix uninitialized boolean variable pps

Cristian Marussi (3):
      firmware: arm_scmi: Fix kernel doc warnings about return values
      firmware: arm_scmi: Avoid padding in sensor message structure
      firmware: arm_scmi: Fix range check for the maximum number of
pending messages

Dan Carpenter (2):
      sctp: prevent info leak in sctp_make_heartbeat()
      sock: unlock on error in sock_setsockopt()

Daniel Latypov (2):
      Documentation: kunit: drop obsolete note about uml_abort for coverage
      kunit: tool: remove unnecessary "annotations" import

Darrick J. Wong (7):
      xfs: check for sparse inode clusters that cross new EOAG when shrinki=
ng
      xfs: reset child dir '..' entry when unlinking child
      xfs: correct the narrative around misaligned rtinherit/extszinherit d=
irs
      xfs: don't expose misaligned extszinherit hints to userspace
      xfs: improve FSGROWFSRT precondition checking
      xfs: fix an integer overflow error in xfs_growfs_rt
      xfs: detect misaligned rtinherit directory extent size hints

David Sterba (1):
      btrfs: zoned: fix types for u64 division in btrfs_reclaim_bgs_work

Desmond Cheong Zhi Xi (3):
      hfs: add missing clean-up in hfs_fill_super
      hfs: fix high memory mapping in hfs_bnode_read
      hfs: add lock nesting notation to hfs_find_init

Dmytro Laktyushkin (1):
      drm/amd/display: remove faulty assert

Doug Berger (1):
      net: bcmgenet: ensure EXT_ENERGY_DET_MASK is clear

Duncan Roe (1):
      netfilter: uapi: refer to nfnetlink_conntrack.h, not
nf_conntrack_netlink.h

Emily Deng (1):
      drm/amdgpu: Correct the irq numbers for virtual crtc

Emily.Deng (1):
      drm/amdgpu: Restore msix after FLR

Eric Dumazet (5):
      net: annotate data race around sk_ll_usec
      udp: annotate data races around unix_sk(sk)->gso_size
      tcp: annotate data races around tp->mtu_info
      sock: fix error in sock_setsockopt()
      ipv6: tcp: drop silly ICMPv6 packet too big messages

Eric Huang (5):
      Revert "drm/amdkfd: Add memory sync before TLB flush on unmap"
      Revert "drm/amdgpu: Fix warning of Function parameter or member
not described"
      Revert "drm/amdkfd: Make TLB flush conditional on mapping"
      Revert "drm/amdgpu: Add table_freed parameter to amdgpu_vm_bo_update"
      Revert "drm/amdkfd: Add heavy-weight TLB flush after unmapping"

Felix Kuehling (1):
      drm/amdkfd: Allow CPU access for all VRAM BOs

Filipe Manana (3):
      btrfs: fix deadlock with concurrent chunk allocations involving
system chunks
      btrfs: rework chunk allocation to avoid exhaustion of the system
chunk array
      btrfs: zoned: fix wrong mutex unlock on failure to allocate log root =
tree

Florian Fainelli (2):
      skbuff: Fix build with SKB extensions disabled
      net: bcmgenet: Ensure all TX/RX queues DMAs are disabled

Florian Westphal (2):
      selftest: netfilter: add test case for unreplied tcp connections
      netfilter: conntrack: do not renew entry stuck in tcp SYN_SENT state

Gatis Peisenieks (1):
      atl1c: fix Mikrotik 10/25G NIC detection

Geert Uytterhoeven (5):
      ARM: dts: qcom-apq8060: Correct Ethernet node name and drop
bogus irq property
      dt-bindings: net: sms911x: Convert to json-schema
      ARM: shmobile: defconfig: Restore graphical consoles
      dt-bindings: display: renesas,du: Make resets optional on R-Car H1
      arm: Typo s/PCI_IXP4XX_LEGACY/IXP4XX_PCI_LEGACY/

Geetha sowjanya (2):
      octeontx2-af: cn10k: Support configurable LMTST regions
      octeontx2-pf: cn10k: Use runtime allocated LMTLINE region

Gu Shengxian (1):
      bpftool: Properly close va_list 'ap' by va_end() on error

Guoqing Jiang (1):
      pd: fix order of cleaning up the queue and freeing the tagset

Gustavo A. R. Silva (27):
      xfs: Fix multiple fall-through warnings for Clang
      mt76: mt7921: Fix fall-through warning for Clang
      nfp: flower-ct: Fix fall-through warning for Clang
      drm/i915: Fix fall-through warning for Clang
      kernel: debug: Fix unreachable code in gdb_serial_stub()
      fcntl: Fix unreachable code in do_fcntl()
      mtd: cfi_util: Fix unreachable code issue
      drm/msm: Fix fall-through warning in msm_gem_new_impl()
      cpufreq: Fix fall-through warning for Clang
      math-emu: Fix fall-through warning
      video: fbdev: Fix fall-through warning for Clang
      scsi: libsas: Fix fall-through warning for Clang
      PCI: Fix fall-through warning for Clang
      mmc: jz4740: Fix fall-through warning for Clang
      iommu/arm-smmu-v3: Fix fall-through warning for Clang
      dmaengine: ipu: Fix fall-through warning for Clang
      s390: Fix fall-through warnings for Clang
      dmaengine: ti: k3-udma: Fix fall-through warning for Clang
      power: supply: Fix fall-through warnings for Clang
      ASoC: Mediatek: MT8183: Fix fall-through warning for Clang
      MIPS: Fix fall-through warnings for Clang
      MIPS: Fix unreachable code issue
      powerpc/powernv: Fix fall-through warning for Clang
      usb: gadget: fsl_qe_udc: Fix fall-through warning for Clang
      dmaengine: mpc512x: Fix fall-through warning for Clang
      powerpc/smp: Fix fall-through warning for Clang
      Makefile: Enable -Wimplicit-fallthrough for Clang

Hangbin Liu (3):
      selftests: icmp_redirect: remove from checking for IPv6 route get
      selftests: icmp_redirect: IPv6 PMTU info should be cleared after redi=
rect
      net: ip_tunnel: fix mtu calculation for ETHER tunnel devices

Hans de Goede (4):
      vboxsf: Honor excl flag to the dir-inode create op
      vboxsf: Make vboxsf_dir_create() return the handle for the created fi=
le
      vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
      vboxsf: Add support for the atomic_open directory-inode op

Hariprasad Kelam (2):
      octeontx2-af: Debugfs support for DMAC filters
      octeontx2-pf: offload DMAC filters to CGX/RPM block

Harman Kalra (1):
      octeontx2-af: cn10k: Setting up lmtst map table

Heiko Carstens (1):
      libperf: Fix build error with LIBPFM4=3D1

Hu Haowen (1):
      docs/zh_CN: add a missing space character

Hugh Dickins (1):
      mm/rmap: fix munlocking Anon THP with mlocked ptes

Hyunchul Lee (1):
      cifs: fix the out of range assignment to bit fields in
parse_server_interfaces

Ingo Molnar (2):
      Documentation/features: Update the ARCH_HAS_TICK_BROADCAST entry
      Documentation/features: Add THREAD_INFO_IN_TASK feature matrix

Ivan Mikhaylov (3):
      net/ncsi: fix restricted cast warning of sparse
      net/ncsi: add NCSI Intel OEM command to keep PHY up
      net/ncsi: add dummy response handler for Intel boards

Jaegeuk Kim (1):
      scsi: ufs: core: Add missing host_lock in ufshcd_vops_setup_xfer_req(=
)

James Clark (1):
      perf cs-etm: Split Coresight decode by aux records

Jason Ekstrand (1):
      dma-buf/sync_file: Don't leak fences on merge failure

Jedrzej Jagielski (1):
      igb: Fix position of assignment to *ring

Jesper Dangaard Brouer (1):
      net/sched: sch_taprio: fix typo in comment

Jianguo Wu (5):
      mptcp: fix warning in __skb_flow_dissect() when do syn cookie
for subflow join
      mptcp: remove redundant req destruct in subflow_check_req()
      mptcp: fix syncookie process if mptcp can not_accept new subflow
      mptcp: avoid processing packet if a subflow reset
      selftests: mptcp: fix case multiple subflows limited by server

Jin Yao (5):
      perf pmu: Skip invalid hybrid pmu
      perf tests: Fix 'Parse event definition strings' on core-only system
      perf tests: Fix 'Roundtrip evsel->name' on core-only system
      perf tests: Fix 'Convert perf time to TSC' on core-only system
      perf stat: Merge uncore events by default for hybrid platform

Jingwen Chen (1):
      drm/amdgpu: SRIOV flr_work should take write_lock

Jinzhou Su (1):
      drm/amdgpu: add another Renoir DID

Joao Martins (1):
      mm/hugetlb: fix refs calculation from unaligned @vaddr

Joel Stanley (1):
      ARM: dts: aspeed: Fix AST2600 machines line names

Johannes Thumshirn (2):
      btrfs: zoned: print unusable percentage when reclaiming block groups
      btrfs: don't block if we can't acquire the reclaim lock

John Fastabend (2):
      bpf: Track subprog poke descriptors correctly and fix use-after-free
      bpf: Selftest to verify mixing bpf2bpf calls and tailcalls with insn =
patch

Jonathan Lemon (1):
      ptp: Relocate lookup cookie to correct block.

Kees Cook (1):
      s390: iucv: Avoid field over-reading memcpy()

Kefeng Wang (1):
      KVM: mmio: Fix use-after-free Read in
kvm_vm_ioctl_unregister_coalesced_mmio

Lai Jiangshan (1):
      KVM: X86: Disable hardware breakpoints unconditionally before
kvm_x86->run()

Lecopzer Chen (1):
      Kbuild: lto: fix module versionings mismatch in GNU make 3.X

Like Xu (1):
      KVM: x86/pmu: Clear anythread deprecated bit when 0xa leaf is
unsupported on the SVM

Linus Torvalds (3):
      Revert "Makefile: Enable -Wimplicit-fallthrough for Clang"
      Revert "mm/slub: use stackdepot to save stack trace in objects"
      Linux 5.14-rc2

Linus Walleij (6):
      drm/panel: nt35510: Do not fail if DSI read fails
      ARM: configs: Update Integrator defconfig
      ARM: configs: Update RealView defconfigbening
      ARM: configs: Update Versatile defconfig
      ARM: configs: Update Vexpress defconfig
      ARM: configs: Update u8500_defconfig

Lorenzo Bianconi (1):
      net: marvell: always set skb_shared_info in mvneta_swbm_add_rx_fragme=
nt

Louis Peens (2):
      net/sched: act_ct: remove and free nf_table callbacks
      nfp: flower-ct: remove callback delete deadlock

Lu Baolu (1):
      iommu/vt-d: Fix clearing real DMA device's scalable-mode context entr=
ies

Luben Tuikov (1):
      drm/amdgpu: Return error if no RAS

M Chetan Kumar (5):
      net: wwan: iosm: fix uevent reporting
      net: wwan: iosm: remove reduandant check
      net: wwan: iosm: correct link-id handling
      net: wwan: iosm: fix netdev tx stats
      net: wwan: iosm: set default mtu

Manfred Spraul (1):
      netfilter: conntrack: Mark access for KCSAN

Marc Zyngier (1):
      KVM: selftests: x86: Address missing
vm_install_exception_handler conversions

Marco Elver (2):
      mm: move helper to check slub_debug_enabled
      kasan: fix build by including kernel.h

Marek Beh=C3=BAn (7):
      net: dsa: mv88e6xxx: enable .port_set_policy() on Topaz
      net: dsa: mv88e6xxx: use correct .stats_set_histogram() on Topaz
      net: dsa: mv88e6xxx: enable .rmu_disable() on Topaz
      net: dsa: mv88e6xxx: enable devlink ATU hash param for Topaz
      net: dsa: mv88e6xxx: enable SerDes RX stats for Topaz
      net: dsa: mv88e6xxx: enable SerDes PCS register dump via ethtool
-d on Topaz
      net: phy: marvell10g: fix differentiation of 88X3310 from 88X3340

Marek Szyprowski (1):
      iommu/qcom: Revert "iommu/arm: Cleanup resources in case of
probe error path"

Mark Rutland (4):
      arm64: fix strlen() with CONFIG_KASAN_HW_TAGS
      arm64: mte: fix restoration of GCR_EL1 from suspend
      arm64: entry: add missing noinstr
      arm64: entry: fix KCOV suppression

Masahiro Yamada (1):
      kbuild: do not suppress Kconfig prompts for silent build

Matteo Croce (1):
      Revert "mm/page_alloc: make should_fail_alloc_page() static"

Matthew Auld (1):
      drm/i915/gtt: drop the page table optimisation

Matthew Wilcox (Oracle) (1):
      mm: Make copy_huge_page() always available

Maxim Levitsky (3):
      KVM: SVM: #SMI interception must not skip the instruction
      KVM: SVM: remove INIT intercept handler
      KVM: SVM: add module param to control the #SMI interception

Mel Gorman (1):
      mm/page_alloc: avoid page allocator recursion with pagesets.lock held

Mikulas Patocka (1):
      scripts/setlocalversion: fix a bug when LOCALVERSION is empty

Mohammad Athari Bin Ismail (1):
      net: stmmac: Terminate FPE workqueue in suspend

Naohiro Aota (1):
      btrfs: properly split extent_map for REQ_OP_ZONE_APPEND

Nathan Chancellor (1):
      arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer

Nguyen Dinh Phi (1):
      tcp: fix tcp_init_transfer() to not reset icsk_ca_initialized

Nicholas Kazlauskas (1):
      drm/amd/display: Fix updating infoframe for DCN3.1 eDP

Nicolas Dichtel (1):
      ipv6: fix 'disable_policy' for fwd packets

Nikolay Aleksandrov (2):
      net: bridge: multicast: fix PIM hello router port marking race
      net: bridge: multicast: fix MRD advertisement router port marking rac=
e

Nishanth Menon (2):
      scripts/spdxcheck.py: Strictly read license files in utf-8
      LICENSES/dual/CC-BY-4.0: Git rid of "smart quotes"

Oleksij Rempel (1):
      net: usb: asix: ax88772: suspend PHY on driver probe

Pablo Neira Ayuso (2):
      netfilter: nft_last: honor NFTA_LAST_SET on restoration
      netfilter: nft_last: incorrect arithmetics when restoring last used

Paolo Abeni (3):
      tcp: consistently disable header prediction for mptcp
      udp: properly flush normal packet at GRO time
      mptcp: properly account bulk freed memory

Paolo Pisati (1):
      selftests: memory-hotplug: avoid spamming logs with dump_page(),
ratio limit hot-remove error test

Paul Blakey (1):
      skbuff: Release nfct refcount on napi stolen or re-used skbs

Paul E. McKenney (5):
      scftorture: Avoid false-positive warnings in scftorture_invoker()
      refscale: Avoid false-positive warnings in ref_scale_reader()
      rcu-tasks: Don't delete holdouts within trc_inspect_reader()
      rcu-tasks: Don't delete holdouts within trc_wait_for_one_reader()
      rcu: Fix pr_info() formats and values in show_rcu_gp_kthreads()

Paulo Alcantara (2):
      cifs: handle reconnect of tcon when there is no cached dfs referral
      cifs: do not share tcp sessions of dfs connections

Pavel Begunkov (2):
      io_uring: use right task for exiting checks
      io_uring: fix io_drain_req()

Pavel Skripkin (5):
      net: moxa: fix UAF in moxart_mac_probe
      net: qcom/emac: fix UAF in emac_remove
      net: ti: fix UAF in tlan_remove_one
      net: fddi: fix UAF in fza_probe
      kvm: debugfs: fix memory leak in kvm_create_vm_debugfs

Philip Yang (1):
      drm/amdkfd: handle fault counters on invalid address

Prabhakar Kushwaha (1):
      nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_=
IFACE

Rae Moar (1):
      kunit: tool: Fix error messages for cases of no tests and wrong TAP h=
eader

Randy Dunlap (4):
      net: microchip: sparx5: fix kconfig warning
      net: hdlc: rename 'mod_init' & 'mod_exit' functions to be module-spec=
ific
      scsi: pm8001: Clean up kernel-doc and comments
      EDAC/igen6: fix core dependency AGAIN

Ricardo Koller (1):
      KVM: selftests: Address extra memslot parameters in vm_vaddr_alloc

Riccardo Mancini (23):
      perf inject: Fix dso->nsinfo refcounting
      perf map: Fix dso->nsinfo refcounting
      perf probe: Fix dso->nsinfo refcounting
      perf env: Fix sibling_dies memory leak
      perf test session_topology: Delete session->evlist
      perf test event_update: Fix memory leak of evlist
      perf test event_update: Fix memory leak of unit
      perf dso: Fix memory leak in dso__new_map()
      perf test maps__merge_in: Fix memory leak of maps
      perf env: Fix memory leak of cpu_pmu_caps
      perf report: Free generated help strings for sort option
      perf inject: Close inject.output on exit
      perf session: Cleanup trace_event
      perf script: Release zstd data
      perf script: Fix memory 'threads' and 'cpus' leaks on exit
      perf lzma: Close lzma stream on exit
      perf trace: Free malloc'd trace fields on exit
      perf trace: Free syscall->arg_fmt
      perf trace: Free syscall tp fields in evsel->priv
      perf trace: Free strings in trace__parse_events_option()
      perf test bpf: Free obj_buf
      perf probe-file: Delete namelist in del_events() on the error path
      perf data: Close all files in close_dir()

Rob Herring (2):
      dt-bindings: More dropping redundant minItems/maxItems
      dt-bindings: Move fixed string 'patternProperties' to 'properties'

Robert Richter (1):
      Documentation: Fix intiramfs script name

Robin Murphy (1):
      arm64: Avoid premature usercopy failure

Ronak Doshi (1):
      vmxnet3: fix cksum offload issues for tunnels with non-default udp po=
rts

Ronnie Sahlberg (1):
      cifs: Do not use the original cruid when following DFS links for
multiuser mounts

Roy, UjjaL (1):
      ipmr: Fix indentation issue

Sanjay Kumar (1):
      iommu/vt-d: Global devTLB flush when present context entry changed

SanjayKumar Jeyakumar (1):
      tools/runqslower: Use __state instead of state

Sean Christopherson (7):
      Revert "KVM: x86: WARN and reject loading KVM if NX is supported
but not enabled"
      KVM: x86: Use guest MAXPHYADDR from CPUID.0x8000_0008 iff TDP is enab=
led
      KVM: x86: Use kernel's x86_phys_bits to handle reduced MAXPHYADDR
      KVM: x86/mmu: Do not apply HPA (memory encryption) mask to GPAs
      KVM: SVM: Revert clearing of C-bit on GPA in #NPF handler
      KVM: SVM: Return -EFAULT if copy_to_user() for SEV mig packet header =
fails
      KVM: SVM: Fix sev_pin_memory() error checks in SEV migration utilitie=
s

SeongJae Park (1):
      kunit: tool: Assert the version requirement

Shahjada Abul Husain (1):
      cxgb4: fix IRQ free race during driver unload

Shyam Prasad N (2):
      cifs: use the expiry output of dns_query to schedule next resolution
      cifs: added WARN_ON for all the count decrements

Sreekanth Reddy (1):
      scsi: mpi3mr: Fix W=3D1 compilation warnings

Stefan Wahren (1):
      ARM: multi_v7_defconfig: Make NOP_USB_XCEIV driver built-in

Steffen Maier (1):
      scsi: zfcp: Report port fc_security as unknown early during
remote cable pull

Steve French (2):
      cifs: fix missing null session check in mount
      SMB3.1.1: fix mount failure to some servers when compression enabled

Steven Rostedt (VMware) (1):
      tracing: Do not reference char * as a string in histograms

Sudeep Holla (8):
      firmware: arm_scmi: Simplify device probe function on the bus
      firmware: arm_scmi: Ensure drivers provide a probe function
      firmware: arm_scmi: Fix possible scmi_linux_errmap buffer overflow
      firmware: arm_ffa: Fix the comment style
      firmware: arm_ffa: Fix a possible ffa_linux_errmap buffer overflow
      firmware: arm_scmi: Fix kernel doc warnings
      firmware: arm_scpi: Fix kernel doc warnings
      ARM: dts: versatile: Fix up interrupt controller node names

Sukadev Bhattiprolu (1):
      ibmvnic: retry reset if there are no other resets

Sunil Kumar Kori (1):
      octeontx2-af: DMAC filter support in MAC block

Suravee Suthikulpanit (1):
      MAINTAINERS: Add Suravee Suthikulpanit as Reviewer for AMD IOMMU (AMD=
-Vi)

Taehee Yoo (10):
      bonding: fix suspicious RCU usage in bond_ipsec_add_sa()
      bonding: fix null dereference in bond_ipsec_add_sa()
      net: netdevsim: use xso.real_dev instead of xso.dev in callback
functions of struct xfrmdev_ops
      ixgbevf: use xso.real_dev instead of xso.dev in callback
functions of struct xfrmdev_ops
      bonding: fix suspicious RCU usage in bond_ipsec_del_sa()
      bonding: disallow setting nested bonding + ipsec offload
      bonding: Add struct bond_ipesc to manage SA
      bonding: fix suspicious RCU usage in bond_ipsec_offload_ok()
      bonding: fix incorrect return value of bond_ipsec_offload_ok()
      net: validate lwtstate->data before returning from skb_tunnel_info()

Talal Ahmad (1):
      tcp: call sk_wmem_schedule before sk_mem_charge in zerocopy path

Thierry Reding (5):
      memory: tegra: Add compile-test stub for tegra_mc_probe_device()
      dt-bindings: arm-smmu: Fix json-schema syntax
      arm64: tegra: Enable audio IOMMU support on Tegra194
      arm64: tegra: Enable SMMU support for USB on Tegra194
      dt-bindings: net: dsa: sja1105: Fix indentation warnings

Toke H=C3=B8iland-J=C3=B8rgensen (3):
      bpf, devmap: Convert remaining READ_ONCE() to rcu_dereference_check()
      bpf, samples: Add -fno-asynchronous-unwind-tables to BPF Clang invoca=
tion
      libbpf: Restore errno return for functions that were already returnin=
g it

Tom Rix (1):
      igc: change default return of igc_read_phy_reg()

Tyrel Datwyler (1):
      scsi: core: Fix bad pointer dereference when ehandler kthread is inva=
lid

Uwe Kleine-K=C3=B6nig (7):
      pwm: sprd: Ensure configuring period and duty_cycle isn't wrongly ski=
pped
      pwm: spear: Ensure configuring period and duty_cycle isn't wrongly sk=
ipped
      pwm: tiecap: Ensure configuring period and duty_cycle isn't
wrongly skipped
      pwm: berlin: Ensure configuring period and duty_cycle isn't
wrongly skipped
      pwm: ep93xx: Ensure configuring period and duty_cycle isn't
wrongly skipped
      firmware: arm_ffa: Ensure drivers provide a probe function
      firmware: arm_ffa: Simplify probe function

Vadim Fedorenko (1):
      net: ipv6: fix return value of ip6_skb_dst_mtu

Vasily Averin (3):
      netfilter: conntrack: nf_ct_gre_keymap_flush() removal
      netfilter: ctnetlink: suspicious RCU usage in ctnetlink_dump_helpinfo
      ipv6: allocate enough headroom in ip6_finish_output2()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/gt: Fix -EDEADLK handling regression

Vinicius Costa Gomes (2):
      igc: Fix use-after-free error during reset
      igb: Fix use-after-free error during reset

Vitaly Kuznetsov (6):
      KVM: nSVM: Check the value written to MSR_VM_HSAVE_PA
      KVM: nSVM: Check that VM_HSAVE_PA MSR was set before VMRUN
      KVM: nSVM: Introduce svm_copy_vmrun_state()
      KVM: nSVM: Fix L1 state corruption upon return from SMM
      KVM: nSVM: Restore nested control upon leaving SMM
      KVM: selftests: smm_test: Test SMM enter from L2

Vladimir Oltean (4):
      net: dsa: return -EOPNOTSUPP when driver does not implement .port_lag=
_join
      net: ocelot: fix switchdev objects synced for wrong netdev with
LAG offload
      net: dsa: sja1105: fix address learning getting disabled on the CPU p=
ort
      net: dsa: properly check for the bridge_leave methods in
dsa_switch_bridge_leave()

Wang Hai (1):
      bpf, samples: Fix xdpsock with '-M' parameter missing unload process

Wang Qing (1):
      nbd: fix order of cleaning up the queue and freeing the tagset

Wei Li (1):
      tools: bpf: Fix error in 'make -C tools/ bpf_install'

Wesley Chalmers (1):
      Revert "drm/amd/display: Always write repeater mode regardless of LTT=
PR"

Will Deacon (1):
      Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)"

Wolfgang Bumiller (1):
      net: bridge: sync fdb to new unicast-filtering ports

Xianting Tian (1):
      zonefs: remove redundant null bio check

Xiaoliang Yang (3):
      net: stmmac: separate the tas basetime calculation function
      net: stmmac: add mutex lock to protect est parameters
      net: stmmac: ptp: update tas basetime after ptp adjust

Xiaomeng Hou (2):
      drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
      drm/amd/display: update header file name

Xin Long (3):
      sctp: check pl.raise_count separately from its increment
      sctp: move 198 addresses from unusable to private scope
      Documentation: add more details in tipc.rst

Yajun Deng (1):
      net: Use nlmsg_unicast() instead of netlink_unicast()

Yanfei Xu (1):
      mm/page_alloc: correct return value when failing at preparing

Yang Jihong (2):
      perf probe: Fix add event failure when running 32-bit perf in a
64-bit kernel
      perf sched: Fix record failure when CONFIG_SCHEDSTATS is not set

Yang Yingliang (2):
      net/802/mrp: fix memleak in mrp_request_join()
      net/802/garp: fix memleak in garp_request_join()

Yangbo Lu (13):
      ptp: add ptp virtual clock driver framework
      ptp: support ptp physical/virtual clocks conversion
      ptp: track available ptp vclocks information
      ptp: add kernel API ptp_get_vclocks_index()
      ethtool: add a new command for getting PHC virtual clocks
      ptp: add kernel API ptp_convert_timestamp()
      mptcp: setsockopt: convert to mptcp_setsockopt_sol_socket_timestampin=
g()
      net: sock: extend SO_TIMESTAMPING for PHC binding
      net: socket: support hardware timestamp conversion to PHC bound
      selftests/net: timestamping: support binding PHC
      MAINTAINERS: add entry for PTP virtual clock driver
      ptp: fix NULL pointer dereference in ptp_clock_register
      ptp: fix format string mismatch in ptp_sysfs.c

Yee Lee (1):
      kasan: add memzero init for unaligned size at DEBUG

Yu Zhang (1):
      KVM: VMX: Remove vmx_msr_index from vmx.h

YueHaibing (2):
      stmmac: dwmac-loongson: Fix unsigned comparison to zero
      stmmac: platform: Fix signedness bug in stmmac_probe_config_dt()

Yunjian Wang (1):
      virtio_net: check virtqueue_add_sgs() return value

Zack Rusin (2):
      drm/vmwgfx: Fix implicit declaration error
      drm/vmwgfx: Fix a bad merge in otable batch takedown

Zev Weiss (1):
      ARM: dts: aspeed: Update e3c246d4i vuart properties

Zhan Liu (1):
      drm/amdgpu/display - only update eDP's backlight level when necessary

Zhen Lei (1):
      fbmem: Do not delete the mode that is still in use

Zheyu Ma (1):
      drm/ttm: add a check against null pointer dereference

kernel test robot (1):
      dsa: fix for_each_child.cocci warnings

wenxu (1):
      net/sched: act_ct: fix err check for nf_conntrack_confirm

=C3=8D=C3=B1igo Huguet (3):
      sfc: fix lack of XDP TX queues - error XDP TX failed (-22)
      sfc: ensure correct number of XDP queues
      sfc: add logs explaining XDP_TX/REDIRECT is not available
