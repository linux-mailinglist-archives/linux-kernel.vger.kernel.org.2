Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192F34410ED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJaVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:11:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E5C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 14:09:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so26336187ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h59PM3G1Hcvzt/od1AV2TNgyedKIqF5E7ezIIyoxcDM=;
        b=emysq2SIHqFNJY8ULnm9xBfjrph7y9p6FZ5Be+ucagodFwST2REhaXM/TLQuspZdvt
         YLmKEd8Ez/xw+zufB5sfD1W8357fzXhSK0R1kpirbnkt3aPhM/z4/cpwuIqAAeApREpY
         OGnWdyVRSMG6+ybZhMKilcsUYdIW41vH6hOtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h59PM3G1Hcvzt/od1AV2TNgyedKIqF5E7ezIIyoxcDM=;
        b=3txNDSGU4lW8whcP8yHhT0CzGMawh7bgNkAkELNEacY9snLUff5zFMA/R3dIBnRbg9
         +XtFsdzFOqrjM+KfiP71dr2K7BjoQL1R7du9j/PscwVNgdF7ElxpHH9R7xbNdSktb/Vl
         /XzAYqbfUQ/doXYsogUTdqAZupMg8h7A3WN+ehvDeTATJ2oAwf3Z3yC4RpFB9eJIQxCB
         R/mSKso8MpDmLCTNrxyAVMeu/kTJycaHa1DJPDx1WdwjsEWz+VFxS7RUTd1FrLgoVgAd
         cWcGK7vtb88gXvSfOMz6Zs65Dntlumgf1ZtL8Psy5dOdJwrGg8S4wjyFkUCZfPvS8UHy
         u2/w==
X-Gm-Message-State: AOAM530GT9NfL1vYNxV09Xkg6vB8GzGF0kxmAujvrhfiaTHRru/Vklob
        9DMWy6CpK4u/X1XUy8dQiQ9da+w+oiPyXMBJ
X-Google-Smtp-Source: ABdhPJwyl34kZ8b0GYmedjRWY8GBQNLTOVxQQD+W19wXmyBnkobW2NpOs9aXeryILgOcY3RhLcG31w==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr27236914ljp.114.1635714564515;
        Sun, 31 Oct 2021 14:09:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y19sm1238358lfa.123.2021.10.31.14.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 14:09:24 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j2so32615121lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 14:09:24 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr21600815lfu.402.1635714563560;
 Sun, 31 Oct 2021 14:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Oct 2021 14:09:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
Message-ID: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
Subject: Linux 5.15
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been calm, and I have no excuse to add an extra rc, so here we
are, with v5.15 pushed out, and the merge window starting tomorrow.

Which is going to be a bit inconvenient for me, since I also have some
conference travel coming up. But it's only a couple of days and I'll
have my laptop with me. Sometimes the release timing works out, and
sometimes it doesn't..

Anyway, the last week of 5.15 was mainly networking and gpu fixes,
with some random sprinkling of other things (a few btrfs reverts, some
kvm updates, minor other fixes here and there - a few architecture
fixes, couple of tracing, small driver fixes etc). Full shortlog
appended.

This release may have started out with some -Werror pain, but it
calmed down fairly quickly and on the whole 5.15 was fair small and
calm. Let's hope for more of the same - without Werror issues this
time - for the upcoming merge window.

                 Linus

---

Aaron Liu (1):
      drm/amdgpu: support B0&B1 external revision id for yellow carp

Adrian Hunter (1):
      perf build: Suppress 'rm dlfilter' build message

Aharon Landau (1):
      RDMA/mlx5: Initialize the ODP xarray when creating an ODP MR

Alexandre Ghiti (2):
      riscv: Do not re-populate shadow memory with kasan_populate_early_sha=
dow
      riscv: Fix asan-stack clang build

Alexey Kardashevskiy (3):
      powerpc/pseries/iommu: Use correct vfree for it_map
      powerpc/pseries/iommu: Check if the default window in use before
removing it
      powerpc/pseries/iommu: Create huge DMA window if no MMIO32 is present

Amit Engel (1):
      nvmet-tcp: fix header digest verification

Amit Pundir (1):
      Revert "arm64: dts: qcom: sm8250: remove bus clock from the mdss
node for sm8250 target"

Andrew Lunn (4):
      phy: phy_ethtool_ksettings_get: Lock the phy for consistency
      phy: phy_ethtool_ksettings_set: Move after phy_start_aneg
      phy: phy_start_aneg: Add an unlocked version
      phy: phy_ethtool_ksettings_set: Lock the PHY while changing settings

Andy Shevchenko (1):
      mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield

Asmaa Mnebhi (1):
      gpio: mlxbf2.c: Add check for bgpio_init failure

Avri Altman (1):
      scsi: ufs: ufshpb: Remove HPB2.0 flows

Bastien Roucari=C3=A8s (1):
      ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode

Bj=C3=B6rn T=C3=B6pel (1):
      riscv, bpf: Fix potential NULL dereference

Brian King (1):
      scsi: ibmvfc: Fix up duplicate response detection

Bryant Mairs (1):
      drm: panel-orientation-quirks: Add quirk for Aya Neo 2021

Chanho Park (1):
      scsi: ufs: ufs-exynos: Correct timeout value setting registers

Chen Lu (1):
      riscv: fix misalgned trap vector base address

Chen Wandun (1):
      mm/vmalloc: fix numa spreading for large hash tables

Christian K=C3=B6nig (1):
      drm/ttm: fix memleak in ttm_transfered_destroy

Christoph Hellwig (1):
      nvdimm/pmem: stop using q_usage_count as external pgmap refcount

Christoph Niedermaier (1):
      MAINTAINERS: Add maintainers for DHCOM i.MX6 and DHCOM/DHCOR STM32MP1

Cl=C3=A9ment B=C5=93sch (1):
      arm64: dts: allwinner: h5: NanoPI Neo 2: Fix ethernet node

Cong Wang (3):
      net: Rename ->stream_memory_read to ->sock_is_readable
      skmsg: Extract and reuse sk_msg_is_readable()
      net: Implement ->sock_is_readable() for UDP and AF_UNIX

Cyril Strejc (1):
      net: multicast: calculate csum of looped-back and forwarded packets

Dan Carpenter (1):
      RDMA/rdmavt: Fix error code in rvt_create_qp()

Daniel Jordan (2):
      net/tls: Fix flipped sign in tls_err_abort() calls
      net/tls: Fix flipped sign in async_wait.err assignment

Daniel Vetter (2):
      drm/i915/selftests: Properly reset mock object propers for each test
      MAINTAINERS: dri-devel is for all of drivers/gpu

Dave Ertman (1):
      ice: Respond to a NETDEV_UNREGISTER event for LAG

David Sterba (4):
      Revert "btrfs: compression: drop kmap/kunmap from generic helpers"
      Revert "btrfs: compression: drop kmap/kunmap from zstd"
      Revert "btrfs: compression: drop kmap/kunmap from zlib"
      Revert "btrfs: compression: drop kmap/kunmap from lzo"

David Woodhouse (3):
      KVM: x86: switch pvclock_gtod_sync_lock to a raw spinlock
      KVM: x86/xen: Fix kvm_xen_has_interrupt() sleeping in kvm_vcpu_block(=
)
      KVM: x86: Take srcu lock in post_kvm_run_save()

David Yang (1):
      tools/testing/selftests/vm/split_huge_page_test.c: fix
application of sizeof to pointer

Davide Caratti (1):
      mptcp: fix corrupt receiver key in MPC + data + checksum

Dongli Zhang (2):
      xen/netfront: stop tx queues during live migration
      vmxnet3: do not stop tx queues after netif_device_detach()

Eric Yang (1):
      drm/amd/display: increase Z9 latency to workaround underflow in Z9

Florian Westphal (1):
      fcnal-test: kill hanging ping/nettest binaries on cleanup

Frieder Schrempf (5):
      arm64: dts: imx8mm-kontron: Make sure SOC and DRAM supply
voltages are correct
      arm64: dts: imx8mm-kontron: Set lower limit of VDD_SNVS to 800 mV
      arm64: dts: imx8mm-kontron: Fix polarity of reg_rst_eth2
      arm64: dts: imx8mm-kontron: Fix CAN SPI clock frequency
      arm64: dts: imx8mm-kontron: Fix connection type for VSC8531 RGMII PHY

Gautham Ananthakrishna (1):
      ocfs2: fix race between searching chunks and release
journal_head from buffer_head

Geert Uytterhoeven (1):
      reset: pistachio: Re-enable driver selection

Guangbin Huang (5):
      net: hns3: fix pause config problem after autoneg disabled
      net: hns3: ignore reset event before initialization process is done
      net: hns3: expand buffer len for some debugfs command
      net: hns3: adjust string spaces of some parameters of tx bd info
in debugfs
      Revert "net: hns3: fix pause config problem after autoneg disabled"

Guenter Roeck (3):
      Revert "watchdog: iTCO_wdt: Account for rebooting on second timeout"
      watchdog: ixp4xx_wdt: Fix address space warning
      nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset
standard tuning circuit

Halil Pasic (2):
      KVM: s390: clear kicked_mask before sleeping again
      KVM: s390: preserve deliverable_mask in __airqs_kick_single_vcpu

Ido Schimmel (1):
      mlxsw: pci: Recycle received packet upon allocation failure

Imre Deak (1):
      drm/i915/dp: Skip the HW readout of DPCD on disabled encoders

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

Jake Wang (1):
      drm/amd/display: Moved dccg init to after bios golden init

Jamie Iles (1):
      watchdog: sbsa: only use 32-bit accessors

Janghyub Seo (1):
      r8169: Add device 10ec:8162 to driver r8169

Janusz Dziedzic (1):
      cfg80211: correct bridge/4addr mode check

Jie Wang (2):
      net: hns3: fix data endian problem of some functions of debugfs
      net: hns3: add more string spaces for dumping packets number of
queue info in debugfs

Jim Quinlan (1):
      reset: brcmstb-rescal: fix incorrect polarity of status bit

Jiri Olsa (1):
      perf callchain: Fix compilation on powerpc with gcc11+

Johan Hovold (2):
      net: lan78xx: fix division by zero in send path
      mmc: vub300: fix control-message timeouts

Johannes Berg (3):
      mac80211: mesh: fix HE operation element length check
      cfg80211: scan: fix RCU in cfg80211_add_nontrans_list()
      cfg80211: fix management registrations locking

Jonas Gorski (1):
      gpio: xgs-iproc: fix parsing of ngpios property

Joonas Lahtinen (1):
      drm/i915: Revert 'guc_id' from i915_request tracepoint

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Remove memory frequency calculation

Kan Liang (1):
      perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support

Kees Cook (1):
      mm/secretmem: avoid letting secretmem_users drop to zero

Krzysztof Kozlowski (2):
      nfc: port100: fix using -ERRNO as command type mask
      watchdog: sbsa: drop unneeded MODULE_ALIAS

Linus Torvalds (1):
      Linux 5.15

Liu Jian (1):
      tcp_bpf: Fix one concurrency problem in the tcp_bpf_send_verdict func=
tion

Lorenz Bauer (3):
      bpf: Define bpf_jit_alloc_exec_limit for riscv JIT
      bpf: Define bpf_jit_alloc_exec_limit for arm64 JIT
      bpf: Prevent increasing bpf_jit_limit above max

Mario (1):
      drm: panel-orientation-quirks: Add quirk for GPD Win3

Mark Zhang (1):
      RDMA/sa_query: Use strscpy_pad instead of memcpy to copy a string

Martin Blumenstingl (1):
      clk: composite: Also consider .determine_rate for rate + mux composit=
es

Martin K. Petersen (1):
      scsi: mpt3sas: Fix reference tag handling for WRITE_INSERT

Maurizio Lombardi (1):
      nvmet-tcp: fix a memory leak when releasing a queue

Max VA (1):
      tipc: fix size validations for the MSG_CRYPTO type

Michael Chan (1):
      net: Prevent infinite while loop in skb_tx_hash()

Michael Strauss (1):
      drm/amd/display: Fallback to clocks which meet requested voltage on D=
CN31

Mike Marciniszyn (2):
      IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt fiel=
ds
      IB/hfi1: Fix abba locking issue with sc_disable()

Mikko Perttunen (1):
      reset: tegra-bpmp: Handle errors in BPMP response

Ming Lei (1):
      block: drain queue after disk is removed from sysfs

Mustafa Ismail (2):
      RDMA/irdma: Set VLAN in UD work completion correctly
      RDMA/irdma: Do not hold qos mutex twice on QP resume

Naohiro Aota (1):
      block: schedule queue restart after BLK_STS_ZONE_RESOURCE

Nicholas Kazlauskas (3):
      drm/amd/display: Fix prefetch bandwidth calculation for DCN3.1
      drm/amd/display: Require immediate flip support for DCN3.1 planes
      drm/amd/display: Fix deadlock when falling back to v2 from v3

Nikola Cornij (2):
      drm/amd/display: Limit display scaling to up to true 4k for DCN 3.1
      drm/amd/display: Increase watermark latencies for DCN3.1

Paolo Bonzini (1):
      KVM: SEV-ES: fix another issue with string I/O VMGEXITs

Patrik Jakobsson (1):
      drm/amdgpu: Fix even more out of bound writes from debugfs

Patrisious Haddad (1):
      RDMA/mlx5: Set user priority for DCT

Pavel Skripkin (1):
      net: batman-adv: fix error handling

Pawe=C5=82 Anikiel (1):
      reset: socfpga: add empty driver allowing consumers to probe

Prabhakar Kushwaha (1):
      rdma/qedr: Fix crash due to redundant release of device's qp memory

Quanyang Wang (1):
      cgroup: Fix memory leak caused by missing cgroup_bpf_offline

Rakesh Babu (1):
      octeontx2-af: Display all enabled PF VF rsrc_alloc entries.

Rakesh Babu Saladi (1):
      octeontx2-af: Fix possible null pointer dereference.

Randy Dunlap (2):
      mmc: winbond: don't build on M68K
      ptp: Document the PTP_CLK_MAGIC ioctl number

Rongwei Wang (1):
      mm, thp: bail out early in collapse_file for writeback page

Russ Weight (1):
      spi: altera: Change to dynamic allocation of spi id

Sagi Grimberg (1):
      nvme-tcp: fix H2CData PDU send accounting (again)

SeongJae Park (1):
      mm/damon/core-test: fix wrong expectations for 'damon_split_regions_o=
f()'

Shakeel Butt (1):
      memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Shin'ichiro Kawasaki (1):
      block: Fix partition check for host-aware zoned block devices

Shiraz Saleem (1):
      RDMA/irdma: Process extended CQ entries correctly

Song Liu (1):
      perf script: Check session->header.env.arch before using it

Steven Rostedt (VMware) (4):
      ftrace/nds32: Update the proto for ftrace_trace_function to
match ftrace_stub
      tracing: Do not warn when connecting eprobe to non existing event
      ftrace: Fix kernel-doc formatting issues
      tracing: Fix misspelling of "missing"

Subbaraya Sundeep (1):
      octeontx2-af: Check whether ipolicers exists

Suren Baghdasaryan (1):
      mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap

Tejun Heo (1):
      bpf: Move BPF_MAP_TYPE for INODE_STORAGE and TASK_STORAGE
outside of CONFIG_NET

Thelford Williams (1):
      drm/amdgpu: fix out of bounds write

Thomas Perrot (1):
      spi: spl022: fix Microwire full duplex mode

Tianjia Zhang (1):
      crypto: x86/sm4 - Fix invalid section entry size

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      bpf: Fix potential race in tail call compatibility check

Tony Lu (1):
      net/smc: Fix smc_link->llc_testlink_time overflow

Trevor Woerner (1):
      net: nxp: lpc_eth.c: avoid hang when bringing interface down

Vadym Kochan (1):
      MAINTAINERS: please remove myself from the Prestera driver

Varun Prakash (3):
      nvme-tcp: fix possible req->offset corruption
      nvme-tcp: fix data digest pointer calculation
      nvmet-tcp: fix data digest pointer calculation

Vasily Averin (1):
      skb_expand_head() adjust skb->truesize incorrectly

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Convert unconditional clflush to drm_clflush_virt_range()
      drm/i915: Catch yet another unconditioal clflush

Vincent Whitchurch (1):
      virtio-ring: fix DMA metadata flags

Walter Stoll (1):
      watchdog: Fix OMAP watchdog early handling

Wang Hai (1):
      usbnet: fix error return code in usbnet_probe()

Wen Gu (1):
      net/smc: Correct spelling mistake to TCPF_SYN_RECV

Wenbin Mei (2):
      mmc: cqhci: clear HALT state after CQE enable
      mmc: mediatek: Move cqhci init behind ungate clock

Wolfram Sang (1):
      mmc: tmio: reenable card irqs after the reset callback

Xie Yongji (2):
      vduse: Disallow injecting interrupt before DRIVER_OK is set
      vduse: Fix race condition between resetting and irq injecting

Xin Long (8):
      sctp: use init_tag from inithdr for ABORT chunk
      sctp: fix the processing for INIT chunk
      sctp: fix the processing for INIT_ACK chunk
      sctp: fix the processing for COOKIE_ECHO chunk
      sctp: add vtag check in sctp_sf_violation
      sctp: add vtag check in sctp_sf_do_8_5_1_E_sa
      sctp: add vtag check in sctp_sf_ootb
      net-sysfs: initialize uid and gid before calling net_ns_get_ownership

Xu Kuohai (1):
      bpf: Fix error usage of map_fd and fdget() in generic_map_update_batc=
h()

Yang Shi (3):
      mm: hwpoison: remove the unnecessary THP check
      mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
      mm: khugepaged: skip huge page collapse for special files

Yang Yingliang (1):
      regmap: Fix possible double-free in regcache_rbtree_exit()

Yongxin Liu (1):
      ice: check whether PTP is initialized in ice_ptp_release()

Yu Xiao (1):
      nfp: bpf: relax prog rejection for mtu check through max_pkt_offset

Yucong Sun (1):
      selftests/bpf: Use recv_timeout() instead of retries

Yufeng Mo (1):
      net: hns3: change hclge/hclgevf workqueue to WQ_UNBOUND mode

Yuiko Oshino (3):
      net: ethernet: microchip: lan743x: Fix driver crash when
lan743x_pm_resume fails
      net: ethernet: microchip: lan743x: Fix dma allocation failure by
using dma_set_mask_and_coherent
      net: ethernet: microchip: lan743x: Fix skb allocation failure
