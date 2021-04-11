Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691FB35B746
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhDKWlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhDKWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:41:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D08C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:41:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p23so9375976ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TmpmbBhs78wgF7zTN5UbJNoj2UskdAKjkPjYYxjEG3k=;
        b=fCrmPAqsntooAB2mDdjHjyrAQY+9CNrceU2kOAYs1fcagW90u9BprRKIERT52haE5A
         RI6MYVRCqh0XlayeyQiM/fU7E2W7rJEs3QS2XGf16teEPrnTklKYomRPxxPA4QtfSCAi
         fccUA9cwW78W17MC+aDNIMluGoUFZMBB7EYJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TmpmbBhs78wgF7zTN5UbJNoj2UskdAKjkPjYYxjEG3k=;
        b=JoziXNl6dEkjsA9OpdP0pGiHdbl6gaUE7LPcjrvCVgdX2QKml5gzDIbYT1yW2dD85C
         Kt69fR98uD52EmbolpzAy59FfG16xnt1bOq7c6kbQQIEmMq1d8JClYZsQ+VIVpN9pwwM
         LAKBRBhP8kZhoF9wztsCnjFjRQa12HPXbSqJzCwJ+zT0zqNGHblSECVLKcwgzNwMWyYY
         GU0Ngca5kJcHWwQPn5b2uFje8AlHgZeHjEpNQ3nPBuC9hyJp6/SEFH7DPiGXWnelI2im
         wbcEHO0UwmDXemKnVvkSPyLXWE56pdIG58G/LahzR7l+w2b6yyRc+WrZA9CJY0eU1wrf
         hGNA==
X-Gm-Message-State: AOAM531beEM0T/VMAZ8jcN2ERyRVwCTlu3bbjD5AbOdTCB8NGEU1E1qi
        ZkpX/i7gDGCHKpF8Q2181ub3cZmHthaxuEdl
X-Google-Smtp-Source: ABdhPJy4PFxTLZRI0PYTZVqC34q3qEeP++uRYROSBFrNsD4dH+HDmS+Hz5yIcOkX3yQzF+FmVYw5gA==
X-Received: by 2002:a2e:a48a:: with SMTP id h10mr2897129lji.337.1618180895429;
        Sun, 11 Apr 2021 15:41:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j26sm2197474lji.132.2021.04.11.15.41.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 15:41:35 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 12so18222378lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 15:41:34 -0700 (PDT)
X-Received: by 2002:ac2:5974:: with SMTP id h20mr13506268lfp.40.1618180894196;
 Sun, 11 Apr 2021 15:41:34 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Apr 2021 15:41:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
Message-ID: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
Subject: Linux 5.12-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh well. rc5 was big. rc6 was small. And now rc7 is big again. In
fact, it's the biggest rc7 (at least in number of commits) we've had
in the 5.x series.

It's mostly due to networking fixes (of which rc6 had none), and none
of them should be all that scary, but it's never great when we have
such a big rc. It's particularly annoying at the end of the release
window like this.

End result: I'm still waffling about the final 5.12 release.  The fact
that we have a big rc7 does make me think that I'll probably do an rc8
this time around. But it ends up depending a bit on how the upcoming
week goes, and if things are deathly quiet, I may end up deciding that
an rc8 doesn't really make sense.

So we'll see.

Anyway, networking (both core and drivers) is over half of the rc7
patch, with the rest being a fairly random collection of fixes all
over. We've got other driver updates (sound, rdma, scsi, usb..) some
fs fixes (io_uring, umount, btrfs, cifs, ocfs), minor arch fixes (arc,
arm, parisc, powerpc, s390, x86), and other misc fixes.

The shortlog is appended, although it's obviously not as nice and
small and readable as I'd have liked at this point in the release..

Please do test,

               Linus

---

A. Cody Schuffelen (1):
      virt_wifi: Return micros for BSS TSF values

Aditya Pakki (1):
      net/rds: Avoid potential use after free in rds_send_remove_from_sock

Adrian Hunter (1):
      perf inject: Fix repipe usage

Ahmed S. Darwish (2):
      net: xfrm: Localize sequence counter per network namespace
      net: xfrm: Use sequence counter with associated spinlock

Aili Yao (1):
      mm/gup: check page posion status for coredump.

Al Viro (3):
      hostfs: fix memory handling in follow_link()
      Make sure nd->path.mnt and nd->path.dentry are always valid pointers
      LOOKUP_MOUNTPOINT: we are cleaning "jumped" flag too late

Alex Deucher (1):
      drm/amdgpu/smu7: fix CAC setting on TOPAZ

Alex Shi (1):
      net/ieee802154: remove unused macros to tame gcc

Alexander Aring (19):
      net: ieee802154: fix nl802154 del llsec key
      net: ieee802154: fix nl802154 del llsec dev
      net: ieee802154: fix nl802154 add llsec key
      net: ieee802154: fix nl802154 del llsec devkey
      net: ieee802154: nl-mac: fix check on panid
      net: ieee802154: forbid monitor for set llsec params
      net: ieee802154: stop dump llsec keys for monitors
      net: ieee802154: forbid monitor for add llsec key
      net: ieee802154: forbid monitor for del llsec key
      net: ieee802154: stop dump llsec devs for monitors
      net: ieee802154: forbid monitor for add llsec dev
      net: ieee802154: forbid monitor for del llsec dev
      net: ieee802154: stop dump llsec devkeys for monitors
      net: ieee802154: forbid monitor for add llsec devkey
      net: ieee802154: forbid monitor for del llsec devkey
      net: ieee802154: stop dump llsec seclevels for monitors
      net: ieee802154: forbid monitor for add llsec seclevel
      net: ieee802154: forbid monitor for del llsec seclevel
      net: ieee802154: stop dump llsec params for monitors

Alexander Gordeev (1):
      s390/cpcmd: fix inline assembly register clobbering

Alexander Shiyan (1):
      ASoC: fsl_esai: Fix TDM slot setup for I2S mode

Andrew Morton (1):
      lib/test_kasan_module.c: suppress unused var warning

Andrey Konovalov (1):
      kasan: fix conflict with page poisoning

Andy Shevchenko (1):
      i2c: designware: Adjust bus_freq_hz when refuse high speed mode set

Anirudh Rayabharam (1):
      net: hso: fix null-ptr-deref during tty device unregistration

Anirudh Venkataramanan (2):
      ice: Continue probe on link/PHY errors
      ice: Use port number instead of PF ID for WoL

Antoine Tenart (2):
      vxlan: do not modify the shared tunnel info when PMTU triggers
an ICMP reply
      geneve: do not modify the shared tunnel info when PMTU triggers
an ICMP reply

Ariel Levkovich (1):
      net/mlx5e: Fix mapping of ct_label zero

Arkadiusz Kubalewski (6):
      i40e: Fix oops at i40e_rebuild()
      i40e: Fix inconsistent indenting
      i40e: Fix sparse errors in i40e_txrx.c
      i40e: Fix sparse error: uninitialized symbol 'ring'
      i40e: Fix sparse error: 'vsi->netdev' could be null
      i40e: Fix sparse warning: missing error code 'err'

Arnd Bergmann (7):
      remoteproc: qcom: pil_info: avoid 64-bit division
      lockdep: Address clang -Wformat warning printing for %hd
      ARM: keystone: fix integer overflow warning
      soc/fsl: qbman: fix conflicting alignment attributes
      ARM: omap1: fix building with clang IAS
      ARM: pxa: mainstone: avoid -Woverride-init warning
      ARM: mvebu: avoid clang -Wtautological-constant warning

Aya Levin (3):
      net/mlx5e: Fix ethtool indication of connector type
      net/mlx5: Fix PPLM register mapping
      net/mlx5: Fix PBMC register mapping

Bastian Germann (1):
      ASoC: sunxi: sun4i-codec: fill ASoC card owner

Ben Greear (1):
      mac80211: fix time-is-after bug in mlme

Bhaskar Chowdhury (2):
      i2c: stm32f4: Mundane typo fix
      parisc: math-emu: Few spelling fixes in the file fpu.h

Bruce Allan (1):
      ice: fix memory allocation call

Can Guo (2):
      scsi: ufs: core: Fix task management request completion timeout
      scsi: ufs: core: Fix wrong Task Tag used in task management request U=
PIUs

Carlos Leija (1):
      ARM: OMAP4: PM: update ROM return address for OSWR and OFF

Chinh T Cao (1):
      ice: Recognize 860 as iSCSI port in CEE mode

Christian Brauner (1):
      file: fix close_range() for unshare+cloexec

Christophe Leroy (3):
      powerpc/ptrace: Don't return error when getting/setting FP regs
without CONFIG_PPC_FPU_REGS
      powerpc/signal32: Fix Oops on sigreturn with unmapped VDSO
      powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime
vdso.so is rebuilt

Ciara Loftus (3):
      libbpf: Ensure umem pointer is non-NULL before dereferencing
      libbpf: Restore umem state after socket create failure
      libbpf: Only create rx and tx XDP rings when necessary

Claudiu Beznea (1):
      net: macb: restore cmp registers on resume path

Claudiu Manoil (1):
      gianfar: Handle error code at MAC address change

Dan Carpenter (2):
      thunderbolt: Fix a leak in tb_retimer_add()
      thunderbolt: Fix off by one in tb_port_find_retimer()

Daniel Jurgens (1):
      net/mlx5: Don't request more than supported EQs

Daniel Mack (1):
      net: axienet: allow setups without MDIO

Danielle Ratson (2):
      ethtool: Remove link_mode param and derive link params from driver
      ethtool: Add lanes parameter for ETHTOOL_LINK_MODE_10000baseR_FEC_BIT

Dave Ertman (1):
      ice: remove DCBNL_DEVRESET bit from PF state

Dave Marchevsky (1):
      bpf: Refcount task stack in bpf_get_task_stack

Dima Chumak (1):
      net/mlx5e: Consider geneve_opts for encap contexts

Dimitar Dimitrov (1):
      remoteproc: pru: Fix loading of GNU Binutils ELF

Dinh Nguyen (1):
      dt-bindings: net: micrel-ksz90x1.txt: correct documentation

Dmitry Baryshkov (2):
      drm/msm: a6xx: fix version check for the A650 SQE microcode
      clk: fixed: fix double free in resource managed fixed-factor clock

Dmitry Safonov (1):
      xfrm/compat: Cleanup WARN()s that can be user-triggered

Dom Cobley (1):
      drm/vc4: crtc: Reduce PV fifo threshold on hvs4

Du Cheng (1):
      cfg80211: remove WARN_ON() in cfg80211_sme_connect

Eli Cohen (5):
      net/mlx5: Fix HW spec violation configuring uplink
      vdpa/mlx5: Use the correct dma device when registering memory
      vdpa/mlx5: Retrieve BAR address suitable any function
      vdpa/mlx5: Fix wrong use of bit numbers
      vdpa/mlx5: Fix suspend/resume index restoration

Eric Dumazet (4):
      sch_red: fix off-by-one checks in red_check_params()
      net: ensure mac header is set in virtio_net_hdr_to_skb()
      Revert "net: correct sk_acceptq_is_full()"
      virtio_net: Do not pull payload in skb->head

Eryk Rybak (2):
      i40e: Fix kernel oops when i40e driver removes VF's
      i40e: Fix display statistics for veb_tc

Evan Nimmo (1):
      xfrm: Use actual socket sk instead of skb socket for xfrm_output_resu=
me

Eyal Birger (3):
      xfrm: interface: fix ipv4 pmtu check to honor ip header df
      vti: fix ipv4 pmtu check to honor ip header df
      vti6: fix ipv4 pmtu check to honor ip header df

Fabio Pricoco (1):
      ice: Increase control queue timeout

Florian Fainelli (2):
      Revert "ARM: dts: bcm2711: Add the BSC interrupt controller"
      net: phy: broadcom: Only advertise EEE for supported modes

Frank Rowand (2):
      of: properly check for error returned by fdt_get_name()
      of: unittest: overlay: ensure proper alignment of copied FDT

Gao Xiang (1):
      parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers

Geert Uytterhoeven (3):
      regulator: bd9571mwv: Fix AVS and DVFS voltage range
      regulator: bd9571mwv: Fix regulator name printed on registration fail=
ure
      regulator: bd9571mwv: Convert device attribute to sysfs_emit()

Gregory CLEMENT (1):
      Revert "arm64: dts: marvell: armada-cp110: Switch to per-port
SATA interrupts"

Gregory Greenman (1):
      iwlwifi: mvm: rfi: don't lock mvm->mutex when sending config command

Grzegorz Siwik (1):
      i40e: Fix parameters in aq_get_phy_register()

Guangbin Huang (1):
      net: hns3: clear VF down state bit before request link status

Guennadi Liakhovetski (1):
      ASoC: SOF: Intel: HDA: fix core status verification

Guenter Roeck (1):
      pcnet32: Use pci_resource_len to validate PCI resource

Hans de Goede (5):
      brcmfmac: p2p: Fix recently introduced deadlock issue
      ASoC: intel: atom: Stop advertising non working S24LE support
      ASoC: intel: atom: Remove 44100 sample-rate from the media and
deep-buffer DAI descriptions
      platform/x86: intel-hid: Fix spurious wakeups caused by
tablet-mode events during suspend
      Bluetooth: btusb: Revert Fix the autosuspend enable and disable

Hao Fang (1):
      i2c: hix5hd2: use the correct HiSilicon copyright

Heiko Carstens (2):
      s390/irq: fix reading of ext_params2 field from lowcore
      s390/setup: use memblock_free_late() to free old stack

Helge Deller (1):
      parisc: parisc-agp requires SBA IOMMU driver

Ian Rogers (1):
      perf arm-spe: Avoid potential buffer overrun

Ido Schimmel (2):
      mlxsw: spectrum: Fix ECN marking in tunnel decapsulation
      selftests: forwarding: vxlan_bridge_1d: Add more ECN decap test cases

Ilya Lipnitskiy (1):
      of: property: fw_devlink: do not link ".*,nr-gpios"

Ilya Maximets (1):
      openvswitch: fix send of uninitialized stack memory in ct limit reply

Jacek Bu=C5=82atek (1):
      ice: Fix for dereference of NULL pointer

Jack Qiu (1):
      fs: direct-io: fix missing sdio->boundary

Jakub Kicinski (4):
      docs: ethtool: fix some copy-paste errors
      ethtool: un-kdocify extended link state
      ethtool: document reserved fields in the uAPI
      ethtool: fix kdoc in headers

Jin Yao (1):
      perf report: Fix wrong LBR block sorting

Jiri Kosina (1):
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()

Jiri Olsa (1):
      bpf: Take module reference for trampoline in module

Johannes Berg (8):
      iwlwifi: pcie: properly set LTR workarounds on 22000 devices
      iwlwifi: fw: fix notification wait locking
      iwlwifi: mvm: fix beacon protection checks
      rfkill: revert back to old userspace API by default
      mac80211: fix TXQ AC confusion
      cfg80211: check S1G beacon compat element length
      nl80211: fix potential leak of ACL params
      nl80211: fix beacon head validation

John Fastabend (2):
      bpf, sockmap: Fix sk->prot unhash op reset
      bpf, sockmap: Fix incorrect fwd_alloc accounting

John Stultz (1):
      drm/msm: Fix removal of valid error case when checking speed_bin

Jonas Holmberg (1):
      ALSA: aloop: Fix initialization of controls

Jordan Crouse (1):
      mailmap: update email address for Jordan Crouse

Julian Braha (1):
      lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS

Kalyan Thota (1):
      drm/msm/disp/dpu1: program 3d_merge only if block is attached

Kamal Heib (1):
      RDMA/qedr: Fix kernel panic when trying to access recv_cq

Krzysztof Goreczny (1):
      ice: prevent ice_open and ice_stop during reset

Krzysztof Kozlowski (2):
      clk: socfpga: fix iomem pointer cast on 64-bit
      i2c: exynos5: correct top kerneldoc

Kumar Kartikeya Dwivedi (1):
      net: sched: bump refcount for new action in ACT replace mode

Kurt Kanzenbach (1):
      net: hsr: Reset MAC header for Tx path

Leon Romanovsky (1):
      RDMA/addr: Be strict with gid size

Libin Yang (5):
      ASoC: SOF: Intel: TGL: fix EHL ops
      ASoC: SOF: Intel: TGL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: ICL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: CNL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: APL: set shutdown callback to hda_dsp_shutdown

Linus Torvalds (1):
      Linux 5.12-rc7

Loic Poulain (1):
      net: qrtr: Fix memory leak on qrtr_tx_wait failure

Lorenz Bauer (2):
      bpf: link: Refuse non-O_RDWR flags in BPF_OBJ_GET
      bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET

Lorenzo Bianconi (1):
      mt76: mt7921: fix airtime reporting

Luca Coelho (2):
      iwlwifi: fix 11ax disabled bit in the regulatory capability flags
      iwlwifi: pcie: add support for So-F devices

Luca Fancellu (1):
      xen/evtchn: Change irq_info lock to raw_spinlock_t

Lukasz Bartosik (2):
      clk: fix invalid usage of list cursor in register
      clk: fix invalid usage of list cursor in unregister

Lv Yunlong (7):
      gpu/xen: Fix a use after free in xen_drm_drv_init
      drivers/net/wan/hdlc_fr: Fix a double free in pvc_xmit
      ethernet: myri10ge: Fix a use after free in myri10ge_sw_tso
      net:tipc: Fix a double free in tipc_sk_mcast_rcv
      ethernet/netronome/nfp: Fix a use after free in nfp_bpf_ctrl_msg_rx
      net/rds: Fix a use after free in rds_message_map_pages
      net: broadcom: bcm4908enet: Fix a double free in bcm4908_enet_dma_all=
oc

Maciej =C5=BBenczykowski (1):
      net-ipv6: bugfix - raw & sctp - switch to ipv6_can_nonlocal_bind()

Maciek Borzecki (1):
      cifs: escape spaces in share names

Magnus Karlsson (1):
      i40e: fix receiving of single packets in xsk zero-copy mode

Manivannan Sadhasivam (1):
      MAINTAINERS: Add entry for Qualcomm IPC Router (QRTR) driver

Maor Dickman (2):
      net/mlx5: Delete auxiliary bus driver eth-rep first
      net/mlx5: E-switch, Create vport miss group only if src rewrite
is supported

Marc Kleine-Budde (2):
      can: uapi: can.h: mark union inside struct can_frame packed
      can: mcp251x: fix support for half duplex SPI host controllers

Marco Elver (1):
      kfence, x86: fix preemptible warning on KPTI-enabled systems

Marek Beh=C3=BAn (3):
      ARM: dts: turris-omnia: configure LED[2]/INTn pin as interrupt pin
      MAINTAINERS: update CZ.NIC's Turris information
      treewide: change my e-mail address, fix my name

Martin Blumenstingl (3):
      net: dsa: lantiq_gswip: Let GSWIP automatically set the xMII clock
      net: dsa: lantiq_gswip: Don't use PHY auto polling
      net: dsa: lantiq_gswip: Configure all remaining GSWIP_MII_CFG bits

Martin Wilck (1):
      scsi: scsi_transport_srp: Don't block target in SRP_PORT_LOST state

Mateusz Palczewski (1):
      i40e: Added Asym_Pause to supported link modes

Mathieu Poirier (1):
      MAINTAINERS: Add co-maintainer for remoteproc/RPMSG subsystems

Matt Chen (1):
      iwlwifi: add support for Qu with AX201 device

Matthew Wilcox (1):
      .mailmap: fix old email addresses

Mauro Carvalho Chehab (3):
      dt-bindings: don't use ../dir for doc references
      dt-bindings: fix references for iio-bindings.txt
      dt-bindings:iio:adc: update motorola,cpcap-adc.yaml reference

Maxim Kochetkov (1):
      net: dsa: Fix type was not set for devlink port

Maxime Ripard (1):
      drm/vc4: plane: Remove redundant assignment

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt
session files

Mike Marciniszyn (1):
      IB/hfi1: Fix probe time panic when AIP is enabled with a buggy BIOS

Mike Rapoport (1):
      nds32: flush_dcache_page: use page_mapping_file to avoid races
with swapoff

Milton Miller (1):
      net/ncsi: Avoid channel_monitor hrtimer deadlock

Muhammad Usama Anjum (1):
      net: ipv6: check for validity before dereferencing cfg->fc_nlinfo.nlh

Naohiro Aota (1):
      btrfs: zoned: move superblock logging zone location

Nick Desaulniers (1):
      gcov: re-fix clang-11+ support

Norbert Ciosek (1):
      virtchnl: Fix layout of RSS structures

Norman Maurer (1):
      net: udp: Add support for getsockopt(..., ..., UDP_GRO, ..., ...);

Oliver Hartkopp (2):
      can: bcm/raw: fix msg_namelen values depending on CAN_REQUIRED_SIZE
      can: isotp: fix msg_namelen values depending on CAN_REQUIRED_SIZE

Oliver St=C3=A4bler (1):
      arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0

Ondrej Mosnacek (3):
      selinux: make nslot handling in avtab more robust
      selinux: fix cond_list corruption when changing booleans
      selinux: fix race between old and new sidtab

Ong Boon Leong (1):
      xdp: fix xdp_return_frame() kernel BUG throw for page_pool memory mod=
el

Paolo Abeni (4):
      net: let skb_orphan_partial wake-up waiters.
      mptcp: forbit mcast-related sockopt on MPTCP sockets
      mptcp: revert "mptcp: provide subflow aware release function"
      net: fix hangup on napi_disable for threaded napi

Paolo Bonzini (1):
      KVM: x86/mmu: preserve pending TLB flush across calls to
kvm_tdp_mmu_zap_sp

Pavel Begunkov (3):
      io_uring: clear F_REISSUE right after getting it
      io_uring: fix rw req completion
      io-wq: cancel unbounded works on io-wq destroy

Pavel Skripkin (3):
      drivers: net: fix memory leak in atusb_probe
      drivers: net: fix memory leak in peak_usb_create_dev
      net: mac802154: Fix general protection fault

Pavel Tikhomirov (1):
      net: sched: sch_teql: fix null-pointer dereference

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing requests after disabling endpo=
int

Pedro Tammela (1):
      libbpf: Fix bail out from 'ringbuf_process_ring()' on error

Phillip Potter (1):
      net: tun: set tun->dev->addr_len during TUNSETLINK processing

Pierre-Louis Bossart (2):
      ASoC: SOF: core: harden shutdown helper
      ASoC: SOF: Intel: move ELH chip info

Piotr Krysiuk (2):
      bpf, x86: Validate computation of branch displacements for x86-64
      bpf, x86: Validate computation of branch displacements for x86-32

Potnuri Bharat Teja (1):
      RDMA/cxgb4: check for ipv6 address properly while destroying listener

Qingqing Zhuo (1):
      drm/amd/display: Add missing mask for DCN3

Raed Salem (1):
      net/mlx5: Fix placement of log_max_flow_counter

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: net: ethernet-controller: fix typo in NVMEM
      dt-bindings: net: bcm4908-enet: fix Ethernet generic properties

Rahul Lakkireddy (1):
      cxgb4: avoid collecting SGE_QBASE regs during traffic

Rob Clark (1):
      drm/msm: Fix a5xx/a6xx timestamps

Robert Malz (1):
      ice: Cleanup fltr list in case of allocation issues

Roman Bolshakov (1):
      scsi: target: iscsi: Fix zero tag inside a trace event

Roman Gushchin (1):
      percpu: make pcpu_nr_empty_pop_pages per chunk type

Rui Salvaterra (1):
      ARM: dts: turris-omnia: fix hardware buffer management

Ryan Lee (2):
      ASoC: max98373: Changed amp shutdown register as volatile
      ASoC: max98373: Added 30ms turn on/off time delay

Salil Mehta (3):
      net: hns3: Remove the left over redundant check & assignment
      net: hns3: Remove un-necessary 'else-if' in the hclge_reset_event()
      net: hns3: Trivial spell fix in hns3 driver

Saravana Kannan (1):
      driver core: Fix locking bug in deferred_probe_timeout_work_func()

Sebastian Reichel (1):
      drm/panel: panel-dsi-cm: disable TE for now

Seevalamuthu Mariappan (1):
      mac80211: clear sta->fast_rx when STA removed from 4-addr VLAN

Sergei Trofimovich (4):
      scsi: hpsa: Use __packed on individual structs, not header-wide
      scsi: hpsa: Fix boot on ia64 (atomic_t alignment)
      scsi: hpsa: Add an assert to prevent __packed reintroduction
      ia64: fix user_stack_pointer() for ptrace()

Shengjiu Wang (1):
      ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chip=
s

Shuah Khan (4):
      usbip: add sysfs_lock to synchronize sysfs code paths
      usbip: stub-dev synchronize sysfs code paths
      usbip: vudc synchronize sysfs code paths
      usbip: synchronize event handler with sysfs code paths

Shyam Prasad N (1):
      cifs: On cifs_reconnect, resolve the hostname again.
A. Cody Schuffelen (1):
      virt_wifi: Return micros for BSS TSF values

Aditya Pakki (1):
      net/rds: Avoid potential use after free in rds_send_remove_from_sock

Adrian Hunter (1):
      perf inject: Fix repipe usage

Ahmed S. Darwish (2):
      net: xfrm: Localize sequence counter per network namespace
      net: xfrm: Use sequence counter with associated spinlock

Aili Yao (1):
      mm/gup: check page posion status for coredump.

Al Viro (3):
      hostfs: fix memory handling in follow_link()
      Make sure nd->path.mnt and nd->path.dentry are always valid pointers
      LOOKUP_MOUNTPOINT: we are cleaning "jumped" flag too late

Alex Deucher (1):
      drm/amdgpu/smu7: fix CAC setting on TOPAZ

Alex Shi (1):
      net/ieee802154: remove unused macros to tame gcc

Alexander Aring (19):
      net: ieee802154: fix nl802154 del llsec key
      net: ieee802154: fix nl802154 del llsec dev
      net: ieee802154: fix nl802154 add llsec key
      net: ieee802154: fix nl802154 del llsec devkey
      net: ieee802154: nl-mac: fix check on panid
      net: ieee802154: forbid monitor for set llsec params
      net: ieee802154: stop dump llsec keys for monitors
      net: ieee802154: forbid monitor for add llsec key
      net: ieee802154: forbid monitor for del llsec key
      net: ieee802154: stop dump llsec devs for monitors
      net: ieee802154: forbid monitor for add llsec dev
      net: ieee802154: forbid monitor for del llsec dev
      net: ieee802154: stop dump llsec devkeys for monitors
      net: ieee802154: forbid monitor for add llsec devkey
      net: ieee802154: forbid monitor for del llsec devkey
      net: ieee802154: stop dump llsec seclevels for monitors
      net: ieee802154: forbid monitor for add llsec seclevel
      net: ieee802154: forbid monitor for del llsec seclevel
      net: ieee802154: stop dump llsec params for monitors

Alexander Gordeev (1):
      s390/cpcmd: fix inline assembly register clobbering

Alexander Shiyan (1):
      ASoC: fsl_esai: Fix TDM slot setup for I2S mode

Andrew Morton (1):
      lib/test_kasan_module.c: suppress unused var warning

Andrey Konovalov (1):
      kasan: fix conflict with page poisoning

Andy Shevchenko (1):
      i2c: designware: Adjust bus_freq_hz when refuse high speed mode set

Anirudh Rayabharam (1):
      net: hso: fix null-ptr-deref during tty device unregistration

Anirudh Venkataramanan (2):
      ice: Continue probe on link/PHY errors
      ice: Use port number instead of PF ID for WoL

Antoine Tenart (2):
      vxlan: do not modify the shared tunnel info when PMTU triggers
an ICMP reply
      geneve: do not modify the shared tunnel info when PMTU triggers
an ICMP reply

Ariel Levkovich (1):
      net/mlx5e: Fix mapping of ct_label zero

Arkadiusz Kubalewski (6):
      i40e: Fix oops at i40e_rebuild()
      i40e: Fix inconsistent indenting
      i40e: Fix sparse errors in i40e_txrx.c
      i40e: Fix sparse error: uninitialized symbol 'ring'
      i40e: Fix sparse error: 'vsi->netdev' could be null
      i40e: Fix sparse warning: missing error code 'err'

Arnd Bergmann (7):
      remoteproc: qcom: pil_info: avoid 64-bit division
      lockdep: Address clang -Wformat warning printing for %hd
      ARM: keystone: fix integer overflow warning
      soc/fsl: qbman: fix conflicting alignment attributes
      ARM: omap1: fix building with clang IAS
      ARM: pxa: mainstone: avoid -Woverride-init warning
      ARM: mvebu: avoid clang -Wtautological-constant warning

Aya Levin (3):
      net/mlx5e: Fix ethtool indication of connector type
      net/mlx5: Fix PPLM register mapping
      net/mlx5: Fix PBMC register mapping

Bastian Germann (1):
      ASoC: sunxi: sun4i-codec: fill ASoC card owner

Ben Greear (1):
      mac80211: fix time-is-after bug in mlme

Bhaskar Chowdhury (2):
      i2c: stm32f4: Mundane typo fix
      parisc: math-emu: Few spelling fixes in the file fpu.h

Bruce Allan (1):
      ice: fix memory allocation call

Can Guo (2):
      scsi: ufs: core: Fix task management request completion timeout
      scsi: ufs: core: Fix wrong Task Tag used in task management request U=
PIUs

Carlos Leija (1):
      ARM: OMAP4: PM: update ROM return address for OSWR and OFF

Chinh T Cao (1):
      ice: Recognize 860 as iSCSI port in CEE mode

Christian Brauner (1):
      file: fix close_range() for unshare+cloexec

Christophe Leroy (3):
      powerpc/ptrace: Don't return error when getting/setting FP regs
without CONFIG_PPC_FPU_REGS
      powerpc/signal32: Fix Oops on sigreturn with unmapped VDSO
      powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime
vdso.so is rebuilt

Ciara Loftus (3):
      libbpf: Ensure umem pointer is non-NULL before dereferencing
      libbpf: Restore umem state after socket create failure
      libbpf: Only create rx and tx XDP rings when necessary

Claudiu Beznea (1):
      net: macb: restore cmp registers on resume path

Claudiu Manoil (1):
      gianfar: Handle error code at MAC address change

Dan Carpenter (2):
      thunderbolt: Fix a leak in tb_retimer_add()
      thunderbolt: Fix off by one in tb_port_find_retimer()

Daniel Jurgens (1):
      net/mlx5: Don't request more than supported EQs

Daniel Mack (1):
      net: axienet: allow setups without MDIO

Danielle Ratson (2):
      ethtool: Remove link_mode param and derive link params from driver
      ethtool: Add lanes parameter for ETHTOOL_LINK_MODE_10000baseR_FEC_BIT

Dave Ertman (1):
      ice: remove DCBNL_DEVRESET bit from PF state

Dave Marchevsky (1):
      bpf: Refcount task stack in bpf_get_task_stack

Dima Chumak (1):
      net/mlx5e: Consider geneve_opts for encap contexts

Dimitar Dimitrov (1):
      remoteproc: pru: Fix loading of GNU Binutils ELF

Dinh Nguyen (1):
      dt-bindings: net: micrel-ksz90x1.txt: correct documentation

Dmitry Baryshkov (2):
      drm/msm: a6xx: fix version check for the A650 SQE microcode
      clk: fixed: fix double free in resource managed fixed-factor clock

Dmitry Safonov (1):
      xfrm/compat: Cleanup WARN()s that can be user-triggered

Dom Cobley (1):
      drm/vc4: crtc: Reduce PV fifo threshold on hvs4

Du Cheng (1):
      cfg80211: remove WARN_ON() in cfg80211_sme_connect

Eli Cohen (5):
      net/mlx5: Fix HW spec violation configuring uplink
      vdpa/mlx5: Use the correct dma device when registering memory
      vdpa/mlx5: Retrieve BAR address suitable any function
      vdpa/mlx5: Fix wrong use of bit numbers
      vdpa/mlx5: Fix suspend/resume index restoration

Eric Dumazet (4):
      sch_red: fix off-by-one checks in red_check_params()
      net: ensure mac header is set in virtio_net_hdr_to_skb()
      Revert "net: correct sk_acceptq_is_full()"
      virtio_net: Do not pull payload in skb->head

Eryk Rybak (2):
      i40e: Fix kernel oops when i40e driver removes VF's
      i40e: Fix display statistics for veb_tc

Evan Nimmo (1):
      xfrm: Use actual socket sk instead of skb socket for xfrm_output_resu=
me

Eyal Birger (3):
      xfrm: interface: fix ipv4 pmtu check to honor ip header df
      vti: fix ipv4 pmtu check to honor ip header df
      vti6: fix ipv4 pmtu check to honor ip header df

Fabio Pricoco (1):
      ice: Increase control queue timeout

Florian Fainelli (2):
      Revert "ARM: dts: bcm2711: Add the BSC interrupt controller"
      net: phy: broadcom: Only advertise EEE for supported modes

Frank Rowand (2):
      of: properly check for error returned by fdt_get_name()
      of: unittest: overlay: ensure proper alignment of copied FDT

Gao Xiang (1):
      parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers

Geert Uytterhoeven (3):
      regulator: bd9571mwv: Fix AVS and DVFS voltage range
      regulator: bd9571mwv: Fix regulator name printed on registration fail=
ure
      regulator: bd9571mwv: Convert device attribute to sysfs_emit()

Gregory CLEMENT (1):
      Revert "arm64: dts: marvell: armada-cp110: Switch to per-port
SATA interrupts"

Gregory Greenman (1):
      iwlwifi: mvm: rfi: don't lock mvm->mutex when sending config command

Grzegorz Siwik (1):
      i40e: Fix parameters in aq_get_phy_register()

Guangbin Huang (1):
      net: hns3: clear VF down state bit before request link status

Guennadi Liakhovetski (1):
      ASoC: SOF: Intel: HDA: fix core status verification

Guenter Roeck (1):
      pcnet32: Use pci_resource_len to validate PCI resource

Hans de Goede (5):
      brcmfmac: p2p: Fix recently introduced deadlock issue
      ASoC: intel: atom: Stop advertising non working S24LE support
      ASoC: intel: atom: Remove 44100 sample-rate from the media and
deep-buffer DAI descriptions
      platform/x86: intel-hid: Fix spurious wakeups caused by
tablet-mode events during suspend
      Bluetooth: btusb: Revert Fix the autosuspend enable and disable

Hao Fang (1):
      i2c: hix5hd2: use the correct HiSilicon copyright

Heiko Carstens (2):
      s390/irq: fix reading of ext_params2 field from lowcore
      s390/setup: use memblock_free_late() to free old stack

Helge Deller (1):
      parisc: parisc-agp requires SBA IOMMU driver

Ian Rogers (1):
      perf arm-spe: Avoid potential buffer overrun

Ido Schimmel (2):
      mlxsw: spectrum: Fix ECN marking in tunnel decapsulation
      selftests: forwarding: vxlan_bridge_1d: Add more ECN decap test cases

Ilya Lipnitskiy (1):
      of: property: fw_devlink: do not link ".*,nr-gpios"

Ilya Maximets (1):
      openvswitch: fix send of uninitialized stack memory in ct limit reply

Jacek Bu=C5=82atek (1):
      ice: Fix for dereference of NULL pointer

Jack Qiu (1):
      fs: direct-io: fix missing sdio->boundary

Jakub Kicinski (4):
      docs: ethtool: fix some copy-paste errors
      ethtool: un-kdocify extended link state
      ethtool: document reserved fields in the uAPI
      ethtool: fix kdoc in headers

Jin Yao (1):
      perf report: Fix wrong LBR block sorting

Jiri Kosina (1):
      iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()

Jiri Olsa (1):
      bpf: Take module reference for trampoline in module

Johannes Berg (8):
      iwlwifi: pcie: properly set LTR workarounds on 22000 devices
      iwlwifi: fw: fix notification wait locking
      iwlwifi: mvm: fix beacon protection checks
      rfkill: revert back to old userspace API by default
      mac80211: fix TXQ AC confusion
      cfg80211: check S1G beacon compat element length
      nl80211: fix potential leak of ACL params
      nl80211: fix beacon head validation

John Fastabend (2):
      bpf, sockmap: Fix sk->prot unhash op reset
      bpf, sockmap: Fix incorrect fwd_alloc accounting

John Stultz (1):
      drm/msm: Fix removal of valid error case when checking speed_bin

Jonas Holmberg (1):
      ALSA: aloop: Fix initialization of controls

Jordan Crouse (1):
      mailmap: update email address for Jordan Crouse

Julian Braha (1):
      lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS

Kalyan Thota (1):
      drm/msm/disp/dpu1: program 3d_merge only if block is attached

Kamal Heib (1):
      RDMA/qedr: Fix kernel panic when trying to access recv_cq

Krzysztof Goreczny (1):
      ice: prevent ice_open and ice_stop during reset

Krzysztof Kozlowski (2):
      clk: socfpga: fix iomem pointer cast on 64-bit
      i2c: exynos5: correct top kerneldoc

Kumar Kartikeya Dwivedi (1):
      net: sched: bump refcount for new action in ACT replace mode

Kurt Kanzenbach (1):
      net: hsr: Reset MAC header for Tx path

Leon Romanovsky (1):
      RDMA/addr: Be strict with gid size

Libin Yang (5):
      ASoC: SOF: Intel: TGL: fix EHL ops
      ASoC: SOF: Intel: TGL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: ICL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: CNL: set shutdown callback to hda_dsp_shutdown
      ASoC: SOF: Intel: APL: set shutdown callback to hda_dsp_shutdown

Linus Torvalds (1):
      Linux 5.12-rc7

Loic Poulain (1):
      net: qrtr: Fix memory leak on qrtr_tx_wait failure

Lorenz Bauer (2):
      bpf: link: Refuse non-O_RDWR flags in BPF_OBJ_GET
      bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET

Lorenzo Bianconi (1):
      mt76: mt7921: fix airtime reporting

Luca Coelho (2):
      iwlwifi: fix 11ax disabled bit in the regulatory capability flags
      iwlwifi: pcie: add support for So-F devices

Luca Fancellu (1):
      xen/evtchn: Change irq_info lock to raw_spinlock_t

Lukasz Bartosik (2):
      clk: fix invalid usage of list cursor in register
      clk: fix invalid usage of list cursor in unregister

Lv Yunlong (7):
      gpu/xen: Fix a use after free in xen_drm_drv_init
      drivers/net/wan/hdlc_fr: Fix a double free in pvc_xmit
      ethernet: myri10ge: Fix a use after free in myri10ge_sw_tso
      net:tipc: Fix a double free in tipc_sk_mcast_rcv
      ethernet/netronome/nfp: Fix a use after free in nfp_bpf_ctrl_msg_rx
      net/rds: Fix a use after free in rds_message_map_pages
      net: broadcom: bcm4908enet: Fix a double free in bcm4908_enet_dma_all=
oc

Maciej =C5=BBenczykowski (1):
      net-ipv6: bugfix - raw & sctp - switch to ipv6_can_nonlocal_bind()

Maciek Borzecki (1):
      cifs: escape spaces in share names

Magnus Karlsson (1):
      i40e: fix receiving of single packets in xsk zero-copy mode

Manivannan Sadhasivam (1):
      MAINTAINERS: Add entry for Qualcomm IPC Router (QRTR) driver

Maor Dickman (2):
      net/mlx5: Delete auxiliary bus driver eth-rep first
      net/mlx5: E-switch, Create vport miss group only if src rewrite
is supported

Marc Kleine-Budde (2):
      can: uapi: can.h: mark union inside struct can_frame packed
      can: mcp251x: fix support for half duplex SPI host controllers

Marco Elver (1):
      kfence, x86: fix preemptible warning on KPTI-enabled systems

Marek Beh=C3=BAn (3):
      ARM: dts: turris-omnia: configure LED[2]/INTn pin as interrupt pin
      MAINTAINERS: update CZ.NIC's Turris information
      treewide: change my e-mail address, fix my name

Martin Blumenstingl (3):
      net: dsa: lantiq_gswip: Let GSWIP automatically set the xMII clock
      net: dsa: lantiq_gswip: Don't use PHY auto polling
      net: dsa: lantiq_gswip: Configure all remaining GSWIP_MII_CFG bits

Martin Wilck (1):
      scsi: scsi_transport_srp: Don't block target in SRP_PORT_LOST state

Mateusz Palczewski (1):
      i40e: Added Asym_Pause to supported link modes

Mathieu Poirier (1):
      MAINTAINERS: Add co-maintainer for remoteproc/RPMSG subsystems

Matt Chen (1):
      iwlwifi: add support for Qu with AX201 device

Matthew Wilcox (1):
      .mailmap: fix old email addresses

Mauro Carvalho Chehab (3):
      dt-bindings: don't use ../dir for doc references
      dt-bindings: fix references for iio-bindings.txt
      dt-bindings:iio:adc: update motorola,cpcap-adc.yaml reference

Maxim Kochetkov (1):
      net: dsa: Fix type was not set for devlink port

Maxime Ripard (1):
      drm/vc4: plane: Remove redundant assignment

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt
session files

Mike Marciniszyn (1):
      IB/hfi1: Fix probe time panic when AIP is enabled with a buggy BIOS

Mike Rapoport (1):
      nds32: flush_dcache_page: use page_mapping_file to avoid races
with swapoff

Milton Miller (1):
      net/ncsi: Avoid channel_monitor hrtimer deadlock

Muhammad Usama Anjum (1):
      net: ipv6: check for validity before dereferencing cfg->fc_nlinfo.nlh

Naohiro Aota (1):
      btrfs: zoned: move superblock logging zone location

Nick Desaulniers (1):
      gcov: re-fix clang-11+ support

Norbert Ciosek (1):
      virtchnl: Fix layout of RSS structures

Norman Maurer (1):
      net: udp: Add support for getsockopt(..., ..., UDP_GRO, ..., ...);

Oliver Hartkopp (2):
      can: bcm/raw: fix msg_namelen values depending on CAN_REQUIRED_SIZE
      can: isotp: fix msg_namelen values depending on CAN_REQUIRED_SIZE

Oliver St=C3=A4bler (1):
      arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0

Ondrej Mosnacek (3):
      selinux: make nslot handling in avtab more robust
      selinux: fix cond_list corruption when changing booleans
      selinux: fix race between old and new sidtab

Ong Boon Leong (1):
      xdp: fix xdp_return_frame() kernel BUG throw for page_pool memory mod=
el

Paolo Abeni (4):
      net: let skb_orphan_partial wake-up waiters.
      mptcp: forbit mcast-related sockopt on MPTCP sockets
      mptcp: revert "mptcp: provide subflow aware release function"
      net: fix hangup on napi_disable for threaded napi

Paolo Bonzini (1):
      KVM: x86/mmu: preserve pending TLB flush across calls to
kvm_tdp_mmu_zap_sp

Pavel Begunkov (3):
      io_uring: clear F_REISSUE right after getting it
      io_uring: fix rw req completion
      io-wq: cancel unbounded works on io-wq destroy

Pavel Skripkin (3):
      drivers: net: fix memory leak in atusb_probe
      drivers: net: fix memory leak in peak_usb_create_dev
      net: mac802154: Fix general protection fault

Pavel Tikhomirov (1):
      net: sched: sch_teql: fix null-pointer dereference

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing requests after disabling endpo=
int

Pedro Tammela (1):
      libbpf: Fix bail out from 'ringbuf_process_ring()' on error

Phillip Potter (1):
      net: tun: set tun->dev->addr_len during TUNSETLINK processing

Pierre-Louis Bossart (2):
      ASoC: SOF: core: harden shutdown helper
      ASoC: SOF: Intel: move ELH chip info

Piotr Krysiuk (2):
      bpf, x86: Validate computation of branch displacements for x86-64
      bpf, x86: Validate computation of branch displacements for x86-32

Potnuri Bharat Teja (1):
      RDMA/cxgb4: check for ipv6 address properly while destroying listener

Qingqing Zhuo (1):
      drm/amd/display: Add missing mask for DCN3

Raed Salem (1):
      net/mlx5: Fix placement of log_max_flow_counter

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: net: ethernet-controller: fix typo in NVMEM
      dt-bindings: net: bcm4908-enet: fix Ethernet generic properties

Rahul Lakkireddy (1):
      cxgb4: avoid collecting SGE_QBASE regs during traffic

Rob Clark (1):
      drm/msm: Fix a5xx/a6xx timestamps

Robert Malz (1):
      ice: Cleanup fltr list in case of allocation issues

Roman Bolshakov (1):
      scsi: target: iscsi: Fix zero tag inside a trace event

Roman Gushchin (1):
      percpu: make pcpu_nr_empty_pop_pages per chunk type

Rui Salvaterra (1):
      ARM: dts: turris-omnia: fix hardware buffer management

Ryan Lee (2):
      ASoC: max98373: Changed amp shutdown register as volatile
      ASoC: max98373: Added 30ms turn on/off time delay

Salil Mehta (3):
      net: hns3: Remove the left over redundant check & assignment
      net: hns3: Remove un-necessary 'else-if' in the hclge_reset_event()
      net: hns3: Trivial spell fix in hns3 driver

Saravana Kannan (1):
      driver core: Fix locking bug in deferred_probe_timeout_work_func()

Sebastian Reichel (1):
      drm/panel: panel-dsi-cm: disable TE for now

Seevalamuthu Mariappan (1):
      mac80211: clear sta->fast_rx when STA removed from 4-addr VLAN

Sergei Trofimovich (4):
      scsi: hpsa: Use __packed on individual structs, not header-wide
      scsi: hpsa: Fix boot on ia64 (atomic_t alignment)
      scsi: hpsa: Add an assert to prevent __packed reintroduction
      ia64: fix user_stack_pointer() for ptrace()

Shengjiu Wang (1):
      ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chip=
s

Shuah Khan (4):
      usbip: add sysfs_lock to synchronize sysfs code paths
      usbip: stub-dev synchronize sysfs code paths
      usbip: vudc synchronize sysfs code paths
      usbip: synchronize event handler with sysfs code paths

Shyam Prasad N (1):
      cifs: On cifs_reconnect, resolve the hostname again.

Shyam Sundar S K (1):
      amd-xgbe: Update DMA coherency values

Si-Wei Liu (1):
      vdpa/mlx5: should exclude header length and fcs from mtu

Srinivas Kandagatla (2):
      ASoC: codecs: lpass-tx-macro: set npl clock rate correctly
      ASoC: codecs: lpass-rx-macro: set npl clock rate correctly

Stefan Riedmueller (1):
      ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces

Steffen Klassert (2):
      xfrm: Fix NULL pointer dereference on policy lookup
      xfrm: Provide private skb extensions for segmented and hw
offloaded ESP packets

Stephen Boyd (1):
      drm/msm: Set drvdata to NULL when msm_drm_init() fails

Stephen Hemminger (1):
      ipv6: report errors for iftoken via netlink extack

Suman Anna (1):
      remoteproc: pru: Fix firmware loading crashes on K3 SoCs

Sven Van Asbroeck (1):
      lan743x: fix ethernet frame cutoff issue

Takashi Iwai (3):
      ALSA: hda/conexant: Apply quirk for another HP ZBook G5 model
      drm/i915: Fix invalid access to ACPI _DSM objects
      ALSA: hda/realtek: Fix speaker amp setup on Acer Aspire E1

Taniya Das (1):
      clk: qcom: camcc: Update the clock ops for the SC7180

Tariq Toukan (3):
      net/mlx5e: kTLS, Fix TX counters atomicity
      net/mlx5e: kTLS, Fix RX counters atomicity
      net/mlx5e: Guarantee room for XSK wakeup NOP on async ICOSQ

Tetsuo Handa (2):
      lockdep: Add a missing initialization hint to the "INFO: Trying
to register non-static key" message
      batman-adv: initialize "struct batadv_tvlv_tt_vlan_data"->reserved fi=
eld

Thomas Tai (1):
      x86/traps: Correct exc_general_protection() and math_error() return p=
aths

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      bpf: Enforce that struct_ops programs be GPL-only
      bpf/selftests: Test that kernel rejects a TCP CC with an invalid lice=
nse

Tong Zhu (1):
      neighbour: Disregard DEAD dst in neigh_update

Tony Lindgren (3):
      ARM: dts: Drop duplicate sha2md5_fck to fix clk_disable race
      ARM: dts: Fix moving mmc devices with aliases for omap4 & 5
      ARM: OMAP4: Fix PMIC voltage domains for bionic

Vasily Gorbik (1):
      s390/unwind: add machine check handler stack

Vineet Gupta (1):
      ARC: haps: bump memory to 1 GB

Viswas G (1):
      scsi: pm80xx: Fix chip initialization failure

Vitaly Kuznetsov (1):
      ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=3Dm

Vlad Buslov (3):
      Revert "net: sched: bump refcount for new action in ACT replace mode"
      net: sched: fix action overwrite reference counting
      net: sched: fix err handler in tcf_action_init()

Vladimir Oltean (1):
      net: dsa: only unset VLAN filtering when last port leaves last
VLAN-aware bridge

Wan Jiabing (3):
      drivers: gpu: drm: xen_drm_front_drm_info is declared twice
      parisc: Remove duplicate struct task_struct declaration
      fs: cifs: Remove unnecessary struct declaration

Wang Qing (2):
      arc: kernel: Return -EFAULT if copy_to_user() fails
      workqueue/watchdog: Make unbound workqueues aware of
touch_softlockup_watchdog() 84;0;0c84;0;0c There are two
workqueue-specific watchdog timestamps:

Wengang Wang (1):
      ocfs2: fix deadlock between setattr and dio_end_io_write

William Roche (1):
      RAS/CEC: Correct ce_add_elem()'s returned values

Wolfram Sang (4):
      i2c: turn recovery error on init to debug
      i2c: imx: drop me as maintainer of binding docs
      i2c: gpio: update email address in binding docs
      i2c: imx: mention Oleksij as maintainer of the binding docs

Wong Vee Khee (1):
      ethtool: fix incorrect datatype in set_eee ops

Xiaoming Ni (5):
      nfc: fix refcount leak in llcp_sock_bind()
      nfc: fix refcount leak in llcp_sock_connect()
      nfc: fix memory leak in llcp_sock_connect()
      nfc: Avoid endless loops caused by repeated llcp_sock_connect()
      net/mlx5: fix kfree mismatch in indir_table.c

Xin Long (3):
      esp: delete NETIF_F_SCTP_CRC bit from features for esp offload
      xfrm: BEET mode doesn't support fragments for inner packets
      tipc: increment the tmp aead refcnt before attaching it

Xu Kuohai (1):
      bpf: Fix a spelling typo in bpf_atomic_alu_string disasm

Yinjun Zhang (1):
      nfp: flower: ignore duplicate merge hints from FW

Yongxin Liu (1):
      ice: fix memory leak of aRFS after resuming from suspend

Yunjian Wang (2):
      sch_htb: fix null pointer dereference on a null new_q
      net: cls_api: Fix uninitialised struct field bo->unlocked_driver_cb

Zheng Yongjun (1):
      net: tipc: Fix spelling errors in net/tipc module

Zqiang (1):
      workqueue: Move the position of debug_work_activate() in __queue_work=
()

dean.yang_cp (1):
      ARC: treewide: avoid the pointer addition with NULL pointer

kernel test robot (1):
      ASoC: cygnus: fix for_each_child.cocci warnings

xinhui pan (2):
      drm/amdgpu: Fix size overflow
      drm/radeon: Fix size overflow

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (1):
      I2C: JZ4780: Fix bug for Ingenic X1000.

Shyam Sundar S K (1):
      amd-xgbe: Update DMA coherency values

Si-Wei Liu (1):
      vdpa/mlx5: should exclude header length and fcs from mtu

Srinivas Kandagatla (2):
      ASoC: codecs: lpass-tx-macro: set npl clock rate correctly
      ASoC: codecs: lpass-rx-macro: set npl clock rate correctly

Stefan Riedmueller (1):
      ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces

Steffen Klassert (2):
      xfrm: Fix NULL pointer dereference on policy lookup
      xfrm: Provide private skb extensions for segmented and hw
offloaded ESP packets

Stephen Boyd (1):
      drm/msm: Set drvdata to NULL when msm_drm_init() fails

Stephen Hemminger (1):
      ipv6: report errors for iftoken via netlink extack

Suman Anna (1):
      remoteproc: pru: Fix firmware loading crashes on K3 SoCs

Sven Van Asbroeck (1):
      lan743x: fix ethernet frame cutoff issue

Takashi Iwai (3):
      ALSA: hda/conexant: Apply quirk for another HP ZBook G5 model
      drm/i915: Fix invalid access to ACPI _DSM objects
      ALSA: hda/realtek: Fix speaker amp setup on Acer Aspire E1

Taniya Das (1):
      clk: qcom: camcc: Update the clock ops for the SC7180

Tariq Toukan (3):
      net/mlx5e: kTLS, Fix TX counters atomicity
      net/mlx5e: kTLS, Fix RX counters atomicity
      net/mlx5e: Guarantee room for XSK wakeup NOP on async ICOSQ

Tetsuo Handa (2):
      lockdep: Add a missing initialization hint to the "INFO: Trying
to register non-static key" message
      batman-adv: initialize "struct batadv_tvlv_tt_vlan_data"->reserved fi=
eld

Thomas Tai (1):
      x86/traps: Correct exc_general_protection() and math_error() return p=
aths

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      bpf: Enforce that struct_ops programs be GPL-only
      bpf/selftests: Test that kernel rejects a TCP CC with an invalid lice=
nse

Tong Zhu (1):
      neighbour: Disregard DEAD dst in neigh_update

Tony Lindgren (3):
      ARM: dts: Drop duplicate sha2md5_fck to fix clk_disable race
      ARM: dts: Fix moving mmc devices with aliases for omap4 & 5
      ARM: OMAP4: Fix PMIC voltage domains for bionic

Vasily Gorbik (1):
      s390/unwind: add machine check handler stack

Vineet Gupta (1):
      ARC: haps: bump memory to 1 GB

Viswas G (1):
      scsi: pm80xx: Fix chip initialization failure

Vitaly Kuznetsov (1):
      ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=3Dm

Vlad Buslov (3):
      Revert "net: sched: bump refcount for new action in ACT replace mode"
      net: sched: fix action overwrite reference counting
      net: sched: fix err handler in tcf_action_init()

Vladimir Oltean (1):
      net: dsa: only unset VLAN filtering when last port leaves last
VLAN-aware bridge

Wan Jiabing (3):
      drivers: gpu: drm: xen_drm_front_drm_info is declared twice
      parisc: Remove duplicate struct task_struct declaration
      fs: cifs: Remove unnecessary struct declaration

Wang Qing (2):
      arc: kernel: Return -EFAULT if copy_to_user() fails
      workqueue/watchdog: Make unbound workqueues aware of
touch_softlockup_watchdog() 84;0;0c84;0;0c There are two
workqueue-specific watchdog timestamps:

Wengang Wang (1):
      ocfs2: fix deadlock between setattr and dio_end_io_write

William Roche (1):
      RAS/CEC: Correct ce_add_elem()'s returned values

Wolfram Sang (4):
      i2c: turn recovery error on init to debug
      i2c: imx: drop me as maintainer of binding docs
      i2c: gpio: update email address in binding docs
      i2c: imx: mention Oleksij as maintainer of the binding docs

Wong Vee Khee (1):
      ethtool: fix incorrect datatype in set_eee ops

Xiaoming Ni (5):
      nfc: fix refcount leak in llcp_sock_bind()
      nfc: fix refcount leak in llcp_sock_connect()
      nfc: fix memory leak in llcp_sock_connect()
      nfc: Avoid endless loops caused by repeated llcp_sock_connect()
      net/mlx5: fix kfree mismatch in indir_table.c

Xin Long (3):
      esp: delete NETIF_F_SCTP_CRC bit from features for esp offload
      xfrm: BEET mode doesn't support fragments for inner packets
      tipc: increment the tmp aead refcnt before attaching it

Xu Kuohai (1):
      bpf: Fix a spelling typo in bpf_atomic_alu_string disasm

Yinjun Zhang (1):
      nfp: flower: ignore duplicate merge hints from FW

Yongxin Liu (1):
      ice: fix memory leak of aRFS after resuming from suspend

Yunjian Wang (2):
      sch_htb: fix null pointer dereference on a null new_q
      net: cls_api: Fix uninitialised struct field bo->unlocked_driver_cb

Zheng Yongjun (1):
      net: tipc: Fix spelling errors in net/tipc module

Zqiang (1):
      workqueue: Move the position of debug_work_activate() in __queue_work=
()

dean.yang_cp (1):
      ARC: treewide: avoid the pointer addition with NULL pointer

kernel test robot (1):
      ASoC: cygnus: fix for_each_child.cocci warnings

xinhui pan (2):
      drm/amdgpu: Fix size overflow
      drm/radeon: Fix size overflow

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (1):
      I2C: JZ4780: Fix bug for Ingenic X1000.
