Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944734BFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhC1XGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC1XGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 19:06:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E6C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 16:06:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b4so15658847lfi.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=paMojb0RQo3J7x+VJmc9idf/cK+gvGWO+wT9Qr1iKSI=;
        b=FPaeZK+bjGMbNlxXdwFP0SektqlnZn/W6bk/YIArN3HdRpHgVkA0rLZvECE38rhudk
         6+fWZmSjHQGDTxRi52d5RtF5Ai1PkyhKaMiVDTkMnkfrSz1FZOc6WAqKADWkvyU+IqZf
         vnavMlg65iyo//h59EHY6v9qk7fs30rl+m8eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=paMojb0RQo3J7x+VJmc9idf/cK+gvGWO+wT9Qr1iKSI=;
        b=OkmJFzHpQSJAIzb/Ht0pHaj5XN14q7RqQFyqydUh5fN/La/5pO1yBCTHrDKcD5Kbpc
         ubGWKwZNM5kufDyAHDnxgSYkwdGeWP1V+Ih+ygXxzZF6P57UbTiV+Qb/45PeN+JndyyM
         YkEHQz3jKmPu6HUf8GFZK+K0biMkwDguqCUcxKZrorSx9HgrFIWmKQ76tt/yVDHddKP1
         0Z8Uzg/GMRsSAoh/90tVNxhunomleOYJP1wyWucoQ6KOBaSVDMFkLMLhC66tKM9JsoE4
         KodF8h8XZA/pu7yU6nI/GTdHu6kV8v9Oxvrho2jIj+nnGtd1pMe1nOpHfSe8eMzTNG5A
         Nfrg==
X-Gm-Message-State: AOAM531BhMpbzWmoA2WoZm60Z76kwWbyd5el4KZUs5Dh7i4K5djiEdNV
        grc+Ng1X9jBd+KAicXgxAFX+FIjlqvwqgQ==
X-Google-Smtp-Source: ABdhPJxWYLlzlw4Sxj+gbuNfOdM5Nnf9KAe5TBmcuQjbYxsWN0FKwbbaj8AmMPtKfuqFdR5U8i2cbw==
X-Received: by 2002:a19:6801:: with SMTP id d1mr14667469lfc.561.1616972771004;
        Sun, 28 Mar 2021 16:06:11 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z28sm2286556ljn.117.2021.03.28.16.06.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 16:06:10 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a198so15661409lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 16:06:10 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr13933154lfo.201.1616972770090;
 Sun, 28 Mar 2021 16:06:10 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Mar 2021 16:05:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
Message-ID: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
Subject: Linux 5.12-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So if rc4 was perhaps a bit smaller than average, it looks like rc5 is
a bigger than average.  We're not breaking any records, but it
certainly isn't tiny, and the rc's aren't shrinking.

I'm not overly worried yet, but let's just say that the trend had
better not continue, or I'll start feeling like we will need to make
this one of those releases that need an rc8.

Most of the changes are drivers (gpu and networking stand out, but
there's various other smaller driver updates elsewhere too) with core
networking (including bpf) fixes being another noticeable subsystem.

Other than that, there's a smattering of noise all over: minor arch
fixes, some filesystem fixes (btrfs, cifs, squashfs), selinux, perf
tools, documentation.

io_uring continues to have noise in it, this time mainly due to some
signal handling fixes. That removed a fair amount of problematic
special casing, but the timing certainly isn't great.

So again, nothing really scary, just rather more than I would have
liked to have in an rc5.

Shortlog appended for people who want to delve into the details,

               Linus

---

Adrian Hunter (1):
      perf auxtrace: Fix auxtrace queue conflict

Alaa Hleihel (1):
      net/mlx5e: Allow to match on MPLS parameters only for MPLS over UDP

Alban Bedel (1):
      platform/x86: intel-hid: Support Lenovo ThinkPad X1 Tablet Gen 2

Alex Deucher (11):
      drm/amdgpu: rework S3/S4/S0ix state handling
      drm/amdgpu: don't evict vram on APUs for suspend to ram (v4)
      drm/amdgpu: clean up non-DC suspend/resume handling
      drm/amdgpu: move s0ix check into amdgpu_device_ip_suspend_phase2 (v3)
      drm/amdgpu: re-enable suspend phase 2 for S0ix
      drm/amdgpu/swsmu: skip gfx cgpg on s0ix suspend
      drm/amdgpu: update comments about s0ix suspend/resume
      drm/amdgpu: drop S0ix checks around CG/PG in suspend
      drm/amdgpu: skip kfd suspend/resume for S0ix
      drm/amdgpu: Add additional Sienna Cichlid PCI ID
      drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x

Alex Elder (3):
      net: ipa: terminate message handler arrays
      arm64: csum: cast to the proper type
      net: ipa: fix init header command validation

Alexander Lobakin (1):
      flow_dissector: fix byteorder of dissected ICMP ID

Alexander Ovechkin (1):
      tcp: relookup sock for RST+ACK packets handled by obsolete req sock

Alexei Starovoitov (4):
      bpf: Dont allow vmlinux BTF to be used in map_create and prog_load.
      ftrace: Fix modify_ftrace_direct.
      bpf: Fix fexit trampoline.
      selftest/bpf: Add a test to check trampoline freeing logic.

Andre Guedes (1):
      igc: Fix igc_ptp_rx_pktstamp()

Andre Przywara (1):
      kselftest/arm64: sve: Do not use non-canonical FFR register value

Andrey Konovalov (2):
      kasan: fix per-page tags for non-page_alloc pages
      mailmap: update Andrey Konovalov's email address

Andy Shevchenko (2):
      ACPI: scan: Use unique number for instance_no
      mfd: intel_quark_i2c_gpio: Revert "Constify static struct resources"

Angelo Dureghello (1):
      can: flexcan: flexcan_chip_freeze(): fix chip freeze for missing bitr=
ate

Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

Arnd Bergmann (3):
      isdn: capi: fix mismatched prototypes
      x86/build: Turn off -fcf-protection for realmode targets
      ch_ktls: fix enum-conversion warning

Aya Levin (4):
      net/mlx5e: Accumulate port PTP TX stats with other channels stats
      net/mlx5e: Set PTP channel pointer explicitly to NULL
      net/mlx5: Fix turn-off PPS command
      net/mlx5e: Fix error path for ethtool set-priv-flag

Bart Van Assche (1):
      scsi: Revert "qla2xxx: Make sure that aborted commands are freed"

Bhaskar Chowdhury (3):
      sch_red: Fix a typo
      docs: networking: Fix a typo
      arm64: cpuinfo: Fix a typo

Brian Norris (1):
      mac80211: Allow HE operation to be longer than expected.

Carlos Llamas (1):
      selftests/net: fix warnings on reuseaddr_ports_exhausted

Chris Chiu (3):
      ACPI: video: Add missing callback back for Sony VPCEH3U1E
      block: clear GD_NEED_PART_SCAN later in bdev_disk_changed
      mailmap: update the email address for Chris Chiu

Christian Brauner (1):
      cachefiles: do not yet allow on idmapped mounts

Christophe Leroy (1):
      net: marvell: Remove reference to CONFIG_MV64X60

Claudiu Beznea (1):
      ARM: dts: at91-sama5d27_som1: fix phy address to 7

Colin Ian King (2):
      octeontx2-af: Fix memory leak of object buf
      io_uring: remove unsued assignment to pointer io

Corentin Labbe (1):
      net: stmmac: dwmac-sun8i: Provide TX and RX fifo sizes

Dan Carpenter (1):
      mptcp: fix bit MPTCP_PUSH_PENDING tests

Daniel Borkmann (2):
      net: Consolidate common blackhole dst ops
      net, bpf: Fix ip6ip6 crash with collect_md populated skbs

Daniel Phan (1):
      mac80211: Check crypto_aead_encrypt for errors

Daniel Vetter (2):
      drm/etnaviv: Use FOLL_FORCE for userptr
      drm/etnaviv: User FOLL_LONGTERM in userptr

David Brazdil (1):
      selinux: vsock: Set SID for socket returned by accept()

David E. Box (4):
      platform/x86: intel_pmt_class: Initial resource to 0
      platform/x86: intel_pmt_crashlog: Fix incorrect macros
      platform/x86: intel_pmc_core: Update Kconfig
      platform/x86: intel_pmc_core: Ignore GBE LTR on Tiger Lake platforms

David Gow (2):
      kunit: tool: Fix a python tuple typing error
      kunit: tool: Disable PAGE_POISONING under --alltests

David Jeffery (1):
      block: recalculate segment count for multi-segment discards correctly

David S. Miller (2):
      Revert "net: bonding: fix error return code of bond_neigh_init()"
      math: Export mul_u64_u64_div_u64

David Sterba (1):
      btrfs: fix build when using M=3Dfs/btrfs

Davide Caratti (1):
      mptcp: fix ADD_ADDR HMAC in case port is specified

Dima Chumak (1):
      net/mlx5e: Offload tuple rewrite for non-CT flows

Dinghao Liu (1):
      e1000e: Fix error handling in e1000_set_d0_lplu_state_82571

Dmitry Baryshkov (4):
      drm/msm/dsi: fix check-before-set in the 7nm dsi_pll code
      drm/msm/dsi_pll_7nm: Solve TODO for multiplier frac_bits assignment
      drm/msm/dsi_pll_7nm: Fix variable usage for pll_lockdet_rate
      drm/msm: fix shutdown hook in case GPU components failed to bind

Douglas Anderson (2):
      drm/msm: Fix speed-bin support not to access outside valid memory
      clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1 clk

Dylan Hung (1):
      ftgmac100: Restart MAC HW once

Eric Dumazet (4):
      macvlan: macvlan_count_rx() needs to be aware of preemption
      net: sched: validate stab values
      net: qrtr: fix a kernel-infoleak in qrtr_recvmsg()
      tipc: better validate user input in tipc_nl_retrieve_key()

Esteve Varela Colominas (1):
      platform/x86: thinkpad_acpi: Allow the FnLock LED to change state

Eva Dengler (1):
      devlink: fix typo in documentation

Fabio Estevam (2):
      ARM: imx6ul-14x14-evk: Do not reset the Ethernet PHYs independently
      drm/msm: Fix suspend/resume on i.MX5

Federico Pellegrin (1):
      ARM: dts: at91: sam9x60: fix mux-mask for PA7 so it can be set
to A, B and C

Filipe Manana (2):
      btrfs: fix subvolume/snapshot deletion not triggered on mount
      btrfs: fix sleep while in non-sleep context during qgroup removal

Florian Fainelli (4):
      net: dsa: b53: VLAN filtering is global to all users
      net: dsa: bcm_sf2: Qualify phydev->dev_flags based on port
      net: phy: broadcom: Add power down exit reset state delay
      net: phy: broadcom: Fix RGMII delays for BCM50160 and BCM50610M

Florian Westphal (1):
      netfilter: ctnetlink: fix dump of the expect mask attribute

Geert Uytterhoeven (1):
      net: broadcom: BCM4908_ENET should not default to y, unconditionally

Geetha sowjanya (2):
      octeontx2-af: Fix irq free in rvu teardown
      octeontx2-pf: Clear RSS enable flag on interace down

Geoff Levand (1):
      MAINTAINERS: Update Spidernet network driver

George McCollister (1):
      net: dsa: don't assign an error value to tag_ops

Georgi Valkov (1):
      libbpf: Fix INSTALL flag order

Grygorii Strashko (1):
      bus: omap_l3_noc: mark l3 irqs as IRQF_NO_THREAD

Hangbin Liu (2):
      selftests/bpf: Set gopt opt_class to 0 if get tunnel opt failed
      selftests: forwarding: vxlan_bridge_1d: Fix vxlan ecn decapsulate val=
ue

Hans de Goede (9):
      platform/x86: thinkpad_acpi: Disable DYTC CQL mode around
switching to balanced mode
      platform/x86: dell-wmi-sysman: Fix crash caused by calling
kset_unregister twice
      platform/x86: dell-wmi-sysman: Fix possible NULL pointer deref on exi=
t
      platform/x86: dell-wmi-sysman: Make it safe to call
exit_foo_attributes() multiple times
      platform/x86: dell-wmi-sysman: Fix release_attributes_data()
getting called twice on init_bios_attributes() failure
      platform/x86: dell-wmi-sysman: Cleanup sysman_init() error-exit handl=
ing
      platform/x86: dell-wmi-sysman: Make sysman_init() return -ENODEV
of the interfaces are not found
      platform/x86: dell-wmi-sysman: Cleanup
create_attributes_level_sysfs_files()
      platform/x86: intel-vbtn: Stop reporting SW_DOCK events

Hariprasad Kelam (1):
      octeontx2-af: fix infinite loop in unmapping NPC counter

Hayes Wang (1):
      r8152: limit the RX buffer size of RTL8153A for USB 2.0

Heiner Kallweit (1):
      r8169: fix DMA being used after buffer free if WoL is enabled

Horia Geant=C4=83 (3):
      arm64: dts: ls1046a: mark crypto engine dma coherent
      arm64: dts: ls1043a: mark crypto engine dma coherent
      arm64: dts: ls1012a: mark crypto engine dma coherent

Huy Nguyen (1):
      net/mlx5: Add back multicast stats for uplink representor

Ian Rogers (1):
      perf synthetic events: Avoid write of uninitialized memory when
generating PERF_RECORD_MMAP* records

Ido Schimmel (2):
      drop_monitor: Perform cleanup upon probe registration failure
      psample: Fix user API breakage

Ilya Lipnitskiy (1):
      net: dsa: mt7530: setup core clock even in TRGMII mode

Imre Deak (4):
      drm/i915/ilk-glk: Fix link training on links with LTTPRs
      drm/i915: Disable LTTPR support when the DPCD rev < 1.4
      drm/i915: Disable LTTPR support when the LTTPR rev < 1.4
      drm/i915: Fix the GT fence revocation runtime PM logic

Ira Weiny (1):
      mm/highmem: fix CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP

Isaku Yamahata (1):
      x86/mem_encrypt: Correct physical address calculation in
__set_clr_pte_enc()

Jackie Liu (1):
      perf top: Fix BPF support related crash with
perf_event_paranoid=3D3 + kptr_restrict

Jakub Kicinski (1):
      ipv6: weaken the v4mapped source check

Jani Nikula (1):
      drm/i915/dsc: fix DSS CTL register usage for ICL DSI transcoders

Jarod Wilson (1):
      wireless/nl80211: fix wdev_id may be used uninitialized

Jean-Philippe Brucker (2):
      libbpf: Fix BTF dump of pointer-to-array-of-struct
      selftests/bpf: Add selftest for pointer-to-array-of-struct BTF dump

Jens Axboe (9):
      io_uring: don't use {test,clear}_tsk_thread_flag() for current
      io-wq: fix race around pending work on teardown
      kernel: don't call do_exit() for PF_IO_WORKER threads
      io_uring: handle signals for IO threads like a normal thread
      kernel: stop masking signals in create_io_thread()
      Revert "signal: don't allow sending any signals to PF_IO_WORKER threa=
ds"
      Revert "kernel: treat PF_IO_WORKER like PF_KTHREAD for ptrace/signals=
"
      Revert "kernel: freezer should treat PF_IO_WORKER like
PF_KTHREAD for freezing"
      Revert "signal: don't allow STOP on PF_IO_WORKER threads"

JeongHyeon Lee (1):
      dm verity: fix DM_VERITY_OPTS_MAX value

Jesper Dangaard Brouer (2):
      bpf: BPF-helper for MTU checking add length input
      selftests/bpf: Tests using bpf_check_mtu BPF-helper input mtu_len par=
am

Jesse Brandeburg (1):
      igb: check timestamp validity

Jia-Ju Bai (2):
      scsi: qedi: Fix error return code of qedi_alloc_global_queues()
      scsi: mpt3sas: Fix error return code of mpt3sas_base_attach()

Jimmy Assarsson (2):
      can: kvaser_pciefd: Always disable bus load reporting
      can: kvaser_usb: Add support for USBcan Pro 4xHS

Jin Yao (1):
      perf pmu: Validate raw event with sysfs exported format bits

Jiri Bohac (1):
      net: check all name nodes in __dev_alloc_name

Jiri Olsa (2):
      perf daemon: Force waipid for all session on SIGCHLD delivery
      perf daemon: Return from kill functions

Johan Hovold (1):
      net: cdc-phonet: fix data-interface release on probe failure

Johannes Berg (3):
      mac80211: fix rate mask reset
      mac80211: minstrel_ht: remove unused variable 'mg'
      nl80211: fix locking for wireless device netns change

Johannes Thumshirn (2):
      btrfs: zoned: remove outdated WARN_ON in direct IO
      block: support zone append bvecs

Jonathan Marek (1):
      drm/msm: fix a6xx_gmu_clear_oob

Jonathan Neusch=C3=A4fer (1):
      MAINTAINERS: Combine "QLOGIC QLGE 10Gb ETHERNET DRIVER" sections into=
 one

Jordan Crouse (1):
      drm/msm: a6xx: Make sure the SQE microcode is safe

Josef Bacik (3):
      btrfs: do not initialize dev stats if we have no dev_root
      btrfs: initialize device::fs_info always
      btrfs: do not initialize dev replace for bad dev root

Kalyan Thota (1):
      drm/msm/disp/dpu1: icc path needs to be set before dpu runtime resume

Karthikeyan Kathirvel (1):
      mac80211: choose first enabled channel for monitor

Kenneth Feng (1):
      drm/amd/pm: workaround for audio noise issue

Kieran Bingham (1):
      drm: rcar-du: Use drmm_encoder_alloc() to manage encoder

Konrad Dybcio (1):
      drm/msm/adreno: a5xx_power: Don't apply A540 lm_setup to other GPUs

Kumar Kartikeya Dwivedi (1):
      libbpf: Use SOCK_CLOEXEC when opening the netlink socket

Lang Cheng (1):
      RDMA/hns: Fix bug during CMDQ initialization

Leo Yan (1):
      perf test: Change to use bash for daemon test

Li RongQing (1):
      igb: avoid premature Rx buffer reuse

Lijun Pan (1):
      ibmvnic: update MAINTAINERS

Linus Torvalds (1):
      Linux 5.12-rc5

Louis Peens (3):
      nfp: flower: fix unsupported pre_tunnel flows
      nfp: flower: add ipv6 bit to pre_tunnel control message
      nfp: flower: fix pre_tun mask id allocation

Ludovic Senecaux (1):
      netfilter: conntrack: Fix gre tunneling over ipv6

Lukas Bulwahn (1):
      MAINTAINERS: rectify BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER

Lukasz Luba (1):
      PM: EM: postpone creating the debugfs dir till fs_initcall

Lv Yunlong (1):
      net/qlcnic: Fix a use after free in qlcnic_83xx_get_minidump_template

Lyude Paul (1):
      drm/nouveau/kms/nve4-nv108: Limit cursors to 128x128

Maciej Fijalkowski (4):
      veth: Store queue_mapping independently of XDP prog presence
      i40e: move headroom initialization to i40e_configure_rx_ring
      ice: move headroom initialization to ice_setup_rx_ctx
      ixgbe: move headroom initialization to ixgbe_configure_rx_ring

Magnus Karlsson (1):
      ice: fix napi work done reporting in xsk path

Maninder Singh (1):
      arm64/process.c: fix Wmissing-prototypes build warnings

Mans Rullgard (1):
      ARM: dts: am33xx: add aliases for mmc interfaces

Maor Dickman (2):
      net/mlx5e: Don't match on Geneve options in case option masks are all=
 zero
      net/mlx5: Disable VF tunnel TX offload if ignore_flow_level
isn't supported

Maor Gottlieb (2):
      net/mlx5: Set QP timestamp mode to default
      RDMA/mlx5: Fix timestamp default mode

Marc Kleine-Budde (3):
      can: isotp: isotp_setsockopt(): only allow to set low level TX
flags for CAN-FD
      can: isotp: TX-path: ensure that CAN frame flags are initialized
      can: peak_usb: Revert "can: peak_usb: add forgotten supported devices=
"

Marcelo Ricardo Leitner (1):
      net/sched: act_ct: clear post_ct if doing ct_clear

Marco Elver (1):
      kfence: make compatible with kmemleak

Marijn Suijten (1):
      clk: qcom: rcg2: Rectify clk_gfx3d rate rounding without mux division

Mark Pearson (1):
      platform/x86: thinkpad_acpi: check dytc version for lapmode sysfs

Mark Rutland (1):
      arm64: stacktrace: don't trace arch_stack_walk()

Mark Tomlinson (3):
      Revert "netfilter: x_tables: Update remaining dereference to RCU"
      Revert "netfilter: x_tables: Switch synchronization to RCU"
      netfilter: x_tables: Use correct memory barriers.

Mark Zhang (1):
      RDMA/mlx5: Fix typo in destroy_mkey inbox

Markus Theil (1):
      mac80211: fix double free in ibss_leave

Martin Wilck (2):
      scsi: target: pscsi: Avoid OOM in pscsi_map_sg()
      scsi: target: pscsi: Clean up after failure in pscsi_map_sg()

Martin Willi (1):
      can: dev: Move device back to init netns on owning netns delete

Mat Martineau (2):
      selftests: mptcp: Restore packet capture option in join tests
      mptcp: Change mailing list address

Matthew Wilcox (Oracle) (3):
      fs/cachefiles: Remove wait_bit_key layout dependency
      mm/writeback: Add wait_on_page_writeback_killable
      afs: Use wait_on_page_writeback_killable

Maxim Mikityanskiy (5):
      net/mlx5e: When changing XDP program without reset, take refs for XSK=
 RQs
      net/mlx5e: Revert parameters on errors when changing PTP state
without reset
      sch_htb: Fix select_queue for non-offload mode
      sch_htb: Fix offload cleanup in htb_destroy on htb_init failure
      net/mlx5e: Fix division by 0 in mlx5e_select_queue

Mian Yousaf Kaukab (1):
      netsec: restore phy power state after controller reset

Miaohe Lin (1):
      hugetlb_cgroup: fix imbalanced css_get and css_put pair for
shared mappings

Mike Rapoport (1):
      mm: memblock: fix section mismatch warning again

Mikulas Patocka (2):
      dm: don't report "detected capacity change" on device creation
      dm ioctl: fix out of bounds array access when no devices

Mimi Zohar (1):
      integrity: double check iint_cache was initialized

Ming Lei (1):
      block: don't create too many partitions

Muhammad Husaini Zulkifli (2):
      igc: Fix Pause Frame Advertising
      igc: Fix Supported Pause Frame Link Setting

Namhyung Kim (2):
      libbpf: Fix error path in bpf_object__elf_init()
      perf record: Fix memory leak in vDSO found using ASAN

Nick Desaulniers (1):
      gcov: fix clang-11+ support

Nicolas Ferre (1):
      ARM: dts: at91: sam9x60: fix mux-mask to match product's datasheet

Oliver Hartkopp (1):
      can: isotp: tx-path: zero initialize outgoing CAN frames

Omar Sandoval (1):
      btrfs: fix check_data_csum() error message for direct I/O

Ondrej Mosnacek (3):
      selinux: don't log MAC_POLICY_LOAD record on failed policy load
      selinux: fix variable scope issue in live sidtab conversion
      selinuxfs: unify policy load error reporting

Ong Boon Leong (1):
      net: phylink: Fix phylink_err() function name error in
phylink_major_config

Pablo Neira Ayuso (3):
      netfilter: nftables: report EOPNOTSUPP on unsupported flowtable flags
      netfilter: nftables: allow to update flowtable flags
      netfilter: nftables: skip hook overlap logic if flowtable is stale

Parav Pandit (3):
      net/mlx5e: E-switch, Fix rate calculation division
      net/mlx5: SF, Correct vhca context size
      net/mlx5: SF, do not use ecpu bit for vhca state processing

Patrice Chotard (3):
      MAINTAINERS: Update some st.com email addresses to foss.st.com
      MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
      MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer

Pavel Andrianov (1):
      net: pxa168_eth: Fix a potential data race in pxa168_eth_remove

Pavel Begunkov (9):
      io_uring: correct io_queue_async_work() traces
      io_uring: don't skip file_end_write() on reissue
      io_uring: fix provide_buffers sign extension
      io_uring: do ctx sqd ejection in a clear context
      io_uring: maintain CQE order of a failed link
      io_uring: fix timeout cancel return code
      io_uring: do post-completion chore on t-out cancel
      io_uring: don't cancel-track common timeouts
      io_uring: don't cancel extra on files match

Pavel Machek (1):
      remove Dan Murphy from TI from MAINTAINERS

Pavel Tatashin (2):
      arm64: kdump: update ppos when reading elfcorehdr
      arm64: mm: correct the inside linear map range during hotplug check

Phillip Lougher (1):
      squashfs: fix xattr id and id lookup sanity checks

Piotr Krysiuk (5):
      bpf: Prohibit alu ops for pointer types not defining ptr_limit
      bpf: Fix off-by-one for area size in creating mask to left
      bpf: Simplify alu_limit masking for pointer arithmetic
      bpf: Add sanity check for upper ptr_limit
      bpf, selftests: Fix up some test_verifier cases for unprivileged

Potnuri Bharat Teja (1):
      RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6
listening server

Pratik Vishwakarma (1):
      drm/amdgpu: skip CG/PG for gfx during S0ix

Prike Liang (1):
      drm/amdgpu: fix the hibernation suspend with s0ix

Rafael J. Wysocki (1):
      PM: runtime: Defer suspending suppliers

Rafa=C5=82 Mi=C5=82ecki (1):
      net: dsa: bcm_sf2: use 2 Gbps IMP port link on BCM4908

Rakesh Babu (1):
      octeontx2-af: Formatting debugfs entry rsrc_alloc.

Rich Wiley (1):
      arm64: kernel: disable CNP on Carmel

Rob Clark (1):
      drm/msm: Ratelimit invalid-fence message

Robert Hancock (1):
      net: axienet: Fix probe error cleanup

Roger Pau Monne (2):
      xen/x86: make XEN_BALLOON_MEMORY_HOTPLUG_LIMIT depend on MEMORY_HOTPL=
UG
      Revert "xen: fix p2m size in dom0 for disabled memory hotplug case"

Roi Dayan (2):
      net/mlx5e: Check correct ip_version in decapsulation route resolution
      net/mlx5e: Fix error flow in change profile

Rong Chen (1):
      selftests/vm: fix out-of-tree build

Ronnie Sahlberg (1):
      cifs: revalidate mapping when we open files for SMB1 POSIX

Saravana Kannan (1):
      ARM: imx: avic: Convert to using IRQCHIP_DECLARE

Sasha Neftin (1):
      igc: reinit_locked() should be called with rtnl_lock

Sean Christopherson (1):
      mm/mmu_notifiers: ensure range_end() is paired with range_start()

Sean Nyekjaer (1):
      squashfs: fix inode lookup sanity checks

Sebastian Andrzej Siewior (1):
      auxdisplay: Remove in_interrupt() usage.

Sergei Trofimovich (2):
      ia64: mca: allocate early mca with GFP_ATOMIC
      ia64: fix format strings for err_inject

Shannon Nelson (1):
      ionic: linearize tso skb with too many frags

Shay Drory (2):
      net/mlx5: SF: Fix memory leak of work item
      net/mlx5: SF: Fix error flow of SFs allocation flow

Shin'ichiro Kawasaki (1):
      dm table: Fix zoned model check and zone sectors check

Shyam Prasad N (2):
      cifs: Adjust key sizes and key generation routines for AES256 encrypt=
ion
      cifs: Fix chmod with modefromsid when an older ACE already exists.

Stanislav Fomichev (1):
      bpf: Use NOP_ATOMIC5 instead of emit_nops(&prog, 5) for
BPF_TRAMP_F_CALL_ORIG

Stephane Grosjean (1):
      can: peak_usb: add forgotten supported devices

Stephen Boyd (2):
      drm/msm/kms: Use nested locking for crtc lock instead of custom class=
es
      drm/msm/dp: Restore aux retry tuning logic

Steve French (1):
      smb3: fix cached file size problems in duplicate extents (reflink)

Subbaraya Sundeep (4):
      octeontx2-pf: Do not modify number of rules
      octeontx2-af: Remove TOS field from MKEX TX
      octeontx2-af: Return correct CGX RX fifo size
      octeontx2-af: Fix uninitialized variable warning

Tal Lossos (1):
      bpf: Change inode_storage's lookup_elem return value from NULL to -EB=
ADF

Taniya Das (1):
      clk: qcom: rpmh: Update the XO clock source for SC7280

Tariq Toukan (2):
      net/mlx5e: Enforce minimum value check for ICOSQ size
      net/mlx5e: RX, Mind the MPWQE gaps when calculating offsets

Teresa Remmet (1):
      arm64: dts: imx8mp-phyboard-pollux-rdk: Add missing pinctrl entry

Thomas Gleixner (1):
      locking/mutex: Fix non debug version of mutex_lock_io_nested()

Thomas Hebb (1):
      z3fold: prevent reclaim/free race for headless pages

Thomas Richter (2):
      perf synthetic-events: Fix uninitialized 'kernel_thread' variable
      perf test: Remove now useless failing sub test "BPF relocation checke=
r"

Tom Saeger (1):
      Documentation: arm64/acpi : clarify arm64 support of IBFT

Tom Seewald (2):
      e1000e: Fix duplicate include guard
      igb: Fix duplicate include guard

Tong Zhang (4):
      mISDN: fix crash in fritzpci
      net: arcnet: com20020 fix error handling
      can: c_can_pci: c_can_pci_remove(): fix use-after-free
      can: c_can: move runtime PM enable/disable to c_can_platform

Tonghao Zhang (1):
      net: sock: simplify tw proto registration

Tony Lindgren (4):
      soc: ti: omap-prm: Fix reboot issue with invalid pcie reset map for d=
ra7
      ARM: OMAP2+: Fix smartreflex init regression after dropping legacy da=
ta
      bus: ti-sysc: Fix warning on unbind if reset is not deasserted
      soc: ti: omap-prm: Fix occasional abort on reset deassert for dra7 iv=
a

Torin Cooper-Bennun (2):
      can: m_can: m_can_do_rx_poll(): fix extraneous msg loss warning
      can: m_can: m_can_rx_peripheral(): fix RX being blocked by errors

Tyrel Datwyler (2):
      scsi: ibmvfc: Fix potential race in ibmvfc_wait_for_ops()
      scsi: ibmvfc: Make ibmvfc_wait_for_ops() MQ aware

Vegard Nossum (1):
      ACPICA: Always create namespace nodes using acpi_ns_create_node()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix enabled_planes bitmask

Vincent Whitchurch (1):
      cifs: Silently ignore unknown oplock break handle

Vitaly Lifshits (1):
      e1000e: add rtnl_lock() to e1000_reset_task

Vladimir Oltean (2):
      net: ipconfig: ic_dev can be NULL in ic_close_devs
      net: bridge: don't notify switchdev for local FDB addresses

Wei Wang (2):
      ipv6: fix suspecious RCU usage warning
      net: fix race between napi kthread mode and busy poll

Xie He (1):
      net: hdlc_x25: Prevent racing between "x25_close" and "x25_xmit"/"x25=
_rx"

Xin Long (1):tools/testing/selftests/
      sctp: move sk_route_caps check and set into sctp_outq_flush_transport=
s

Yangbo Lu (1):
      ptp_qoriq: fix overflow in ptp_qoriq_adjfine() u64 calcalation

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix potential shift wrapping of 32-bit value in STEv1 g=
etter

Yinjun Zhang (1):
      netfilter: flowtable: Make sure GC works periodically in idle system

Yonghong Song (2):
      bpf: Don't do bpf_cgroup_storage_set() for kuprobe/tp programs
      bpf, x86: Use kvmalloc_array instead kmalloc_array in bpf_jit_comp

Zenghui Yu (1):
      docs: net: ena: Fix ena_start_xmit() function name typo

Zqiang (1):
      bpf: Fix umd memory leak in copy_process()

dillon min (1):
      ARM: dts: imx6ull: fix ubi filesystem mount failed

liuyacan (1):
      net: correct sk_acceptq_is_full()

wenxu (2):
      net/sched: act_api: fix miss set post_ct for ovs after do
conntrack in act_ct
      net/sched: cls_flower: fix only mask bit check in the validate_ct_sta=
te
