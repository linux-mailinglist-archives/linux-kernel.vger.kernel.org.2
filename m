Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5373F41C2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhHVVgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhHVVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 17:36:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:35:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so27832852ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OKBlx295QJaayNw7E0tSdMj5Axd3vgeCttdsVEUunRA=;
        b=ev/86+9VYFhNpG9c3Qu+/kbq4idm5Pg2HCeOk4R9ERuv+rOuqgHLRfZyuk/vy/iojq
         U/UTa1TUT4vtTwHlnHtRKxJCLnGCkpBkgM+XPNSs5CkVEzgrqiCyuYDmnVppl1oHDT7D
         qt77IdhRO6jNb48r1YqrAZgL3svmrUB2lCCco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OKBlx295QJaayNw7E0tSdMj5Axd3vgeCttdsVEUunRA=;
        b=F1UGDrgOpP1XLvL46QDNLrxc9g+/ymSH5xF23z3sboFibasuNkJYHm5ivI/rAakQjg
         X1rf1mixvE0VrEDlPl8jhTKaC0ukeCv1+4THYxmmdyTB7oLlxFcRxxUt3p1M9noCPfmT
         A+r4vF41GiLvkeUECkVRMvGCghEG5uEuLyNgJo2ky4Icg0NTTxNj1CQFbPBLQ+H8XkOF
         GHoLzvIIaOg5tSJZJ4Cj/s4Yh31VXHH8QaixNlZtBtlblfoff096zLm2sHG+nYL12fJV
         k36IfSmnDdzsEHOdaLMQmfqyZ6NJ3hMOE9NyPr7dbmHu7nzriT0wu2nJsZRSKlrOV/GW
         Vd+g==
X-Gm-Message-State: AOAM533KMaU+tc5woQoI2TxQjYv2vdxDVfTdWhIuDC0jH7DgazVPxzW5
        CYZ4uK3om2PCOlQJf/S85Y6FSkAn6wLNGIbllIU=
X-Google-Smtp-Source: ABdhPJyRWqvcCdSE0NpVFVtrlVQr5HV2lhqlIXDr/LAoKj/GeGv4kTrSKuf2lc1IXAYpA0aptvPglg==
X-Received: by 2002:a2e:b019:: with SMTP id y25mr10638253ljk.397.1629668154711;
        Sun, 22 Aug 2021 14:35:54 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y7sm1230298ljn.26.2021.08.22.14.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 14:35:54 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l18so20256659lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:35:54 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr24799199ljc.251.1629668153816;
 Sun, 22 Aug 2021 14:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Aug 2021 14:35:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ_W7ZF84Mtq6KRjF4FEoYh14dnw+Oc0avZz_6WrCkfw@mail.gmail.com>
Message-ID: <CAHk-=wgZ_W7ZF84Mtq6KRjF4FEoYh14dnw+Oc0avZz_6WrCkfw@mail.gmail.com>
Subject: Linux 5.14-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So things continue to look normal, and unless there is any last-minute
panic this upcoming week, this is likely the last rc before a final
5.14. Much of the discussion I saw last week was about things slated
for the next merge window, and nothing in here looks particularly
strange or scary.

Most of the changes here are drivers (GPU and networking stand out),
and the rest is pretty random stuff: arch, tracing, core networking, a
couple of VM fixes..

So please give this all some final testing to make sure we're all
ready for the release,

            Linus

---

Andreas Persson (1):
      mtd: cfi_cmdset_0002: fix crash when erasing/writing AMD cards

Andrew Delgadillo (1):
      arm64: clean vdso & vdso32 files

Andy Shevchenko (1):
      ptp_pch: Restore dependency on PCI

Anshuman Gupta (1):
      drm/i915: Tweaked Wa_14010685332 for all PCHs

Arkadiusz Kubalewski (1):
      i40e: Fix ATR queue selection

Arnd Bergmann (2):
      mt76: fix enum type mismatch
      ARM: ixp4xx: fix building both pci drivers

Aubrey Li (1):
      ACPI: PRM: Deal with table not present or no module found

Ben Skeggs (6):
      drm/nouveau: recognise GA107
      drm/nouveau/disp: power down unused DP links during init
      drm/nouveau/kms/nv50: workaround EFI GOP window channel format differ=
ences
      drm/nouveau/fifo/nv50-: rip out dma channels
      drm/nouveau: block a bunch of classes from userspace
      drm/nouveau: rip out nvkm_client.super

Bjorn Andersson (2):
      cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev
      clk: qcom: gdsc: Ensure regulator init state matches GDSC state

Caleb Connolly (1):
      arm64: dts: qcom: sdm845-oneplus: fix reserved-mem

Christophe Kerello (1):
      mmc: mmci: stm32: Check when the voltage switch procedure should be d=
one

Christophe Leroy (1):
      powerpc/32s: Fix random crashes by adding isync() after
locking/unlocking KUEP

Colin Ian King (1):
      mtd: devices: mchp48l640: Fix memory leak on cmd

Dan Carpenter (3):
      mtd: rawnand: Add a check in of_get_nand_secure_regions()
      mtd: mchp48l640: silence some uninitialized variable warnings
      net: iosm: Prevent underflow in ipc_chnl_cfg_get()

Dan Moulding (1):
      drm: ttm: Don't bail from ttm_global_init if debugfs_create_dir fails

Daniel Bristot de Oliveira (3):
      trace/osnoise: Add a header with PREEMPT_RT additional fields
      trace/timerlat: Add a header with PREEMPT_RT additional fields
      trace/osnoise: Print a stop tracing message

Desmond Cheong Zhi Xi (2):
      mtd: break circular locks in register_mtd_blktrans
      mtd: fix lock hierarchy in deregister_mtd_blktrans

Dinghao Liu (1):
      net: qlcnic: add missed unlock in qlcnic_83xx_flash_read32

Dmitry Osipenko (1):
      opp: Drop empty-table checks from _put functions

Dong Aisheng (1):
      clk: imx6q: fix uart earlycon unwork

Dongliang Mu (2):
      ipack: tpci200: fix many double free issues in tpci200_pci_probe
      ipack: tpci200: fix memory leak in the tpci200_register

Doug Berger (1):
      mm/page_alloc: don't corrupt pcppage_migratetype

Eli Cohen (2):
      vdpa/mlx5: Avoid destroying MR on empty iotlb
      vdpa/mlx5: Fix queue type selection logic

Elliot Berman (1):
      cfi: Use rcu_read_{un}lock_sched_notrace

Ezequiel Garcia (1):
      iommu/dma: Fix leak in non-contiguous API

Fenghua Yu (1):
      iommu/vt-d: Fix PASID reference leak

Frank Wunderlich (1):
      iommu: Check if group is NULL before remove device

Georgi Djakov (1):
      Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit list in
pre_aggregate"

Gerd Rausch (1):
      net/rds: dma_map_sg is entitled to merge entries

Hans de Goede (3):
      platform/x86: asus-nb-wmi: Allow configuring SW_TABLET_MODE
method with a module option
      platform/x86: asus-nb-wmi: Add tablet_mode_sw=3Dlid-flip quirk for
the TP200s
      usb: typec: tcpm: Fix VDMs sometimes not being forwarded to
alt-mode drivers

Hayes Wang (2):
      r8152: fix writing USB_BP2_EN
      r8152: fix the maximum number of PLA bp for RTL8153C

Ido Schimmel (1):
      Revert "flow_offload: action should not be NULL when it is referenced=
"

Ilya Leoshkevich (2):
      bpf: Clear zext_dst of dead insns
      selftests, bpf: Test that dead ldx_w insns are accepted

Imre Deak (1):
      ALSA: hda: Fix hang during shutdown due to link reset

Jake Wang (1):
      drm/amd/display: Ensure DCN save after VM setup

Jakub Kicinski (4):
      bnxt: don't lock the tx queue from napi poll
      bnxt: disable napi before canceling DIM
      bnxt: make sure xmit_more + errors does not miss doorbells
      bnxt: count Tx drops

Jani Nikula (2):
      drm/i915/edp: fix eDP MSO pipe sanity checks for ADL-P
      drm/i915/dp: remove superfluous EXPORT_SYMBOL()

Jaroslav Kysela (1):
      ALSA: hda - fix the 'Capture Switch' value change notifications

Jason Wang (1):
      virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO

Jeff Layton (1):
      fs: warn about impending deprecation of mandatory locks

Jens Axboe (2):
      io_uring: only assign io_uring_enter() SQPOLL error in actual error c=
ase
      io_uring: fix xa_alloc_cycle() error return value check

Jim Quinlan (1):
      MAINTAINERS: Add Jim Quinlan et al as Broadcom STB PCIe maintainers

Johannes Berg (2):
      iwlwifi: pnvm: accept multiple HW-type TLVs
      mac80211: fix locking in ieee80211_restart_work()

Johannes Weiner (2):
      mm: memcontrol: fix occasional OOMs due to proportional memory.low re=
claim
      mm: vmscan: fix missing psi annotation for node_reclaim()

Kai-Heng Feng (1):
      ALSA: hda/realtek: Limit mic boost on HP ProBook 445 G8

Kenneth Feng (2):
      Revert "drm/amd/pm: fix workload mismatch on vega10"
      drm/amd/pm: change the workload type for some cards

Kristin Paget (1):
      ALSA: hda/realtek: Enable 4-speaker output for Dell XPS 15 9510 lapto=
p

Krzysztof Wilczy=C5=84ski (1):
      PCI/sysfs: Use correct variable for the legacy_mem sysfs object

Lahav Schlesinger (1):
      vrf: Reset skb conntrack connection on VRF rcv

Linus Torvalds (2):
      pipe: avoid unnecessary EPOLLET wakeups under normal loads
      Linux 5.14-rc7

Linus Walleij (1):
      ARM: configs: Update the nhk8815_defconfig

Liu Yi L (1):
      iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry=
()

Lukas Bulwahn (1):
      tracing: define needed config DYNAMIC_FTRACE_WITH_ARGS

Lukasz Luba (1):
      cpufreq: arm_scmi: Fix error path when allocation failed

Maciej Machnikowski (1):
      ice: Fix perout start time rounding

Manivannan Sadhasivam (1):
      mtd: rawnand: Fix probe failure due to of_get_nand_secure_regions()

Marcin Bachry (1):
      PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI

Marco Elver (1):
      kfence: fix is_kfence_address() for addresses below KFENCE_POOL_SIZE

Marek Beh=C3=BAn (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Mario Limonciello (1):
      ACPI: PM: s2idle: Invert Microsoft UUID entry and exit

Mark Rutland (1):
      arm64: initialize all of CNTHCTL_EL2

Mark Yacoub (1):
      drm: Copy drm_wait_vblank to user before returning

Masami Hiramatsu (1):
      init: Suppress wrong warning for bootconfig cmdline parameter

Matthieu Baerts (1):
      mptcp: full fully established support after ADD_ADDR

Maxim Kochetkov (2):
      soc: fsl: qe: convert QE interrupt controller to platform_device
      soc: fsl: qe: fix static checker warning

Maxim Levitsky (2):
      KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl
(CVE-2021-3653)
      KVM: nSVM: always intercept VMLOAD/VMSAVE when nested (CVE-2021-3656)

Michael Chan (2):
      bnxt_en: Disable aRFS if running on 212 firmware
      bnxt_en: Add missing DMA memory barriers

Michael Ellerman (1):
      powerpc/mm: Fix set_memory_*() against concurrent accesses

Michael S. Tsirkin (3):
      vringh: pull in spinlock header
      virtio_ring: pull in spinlock header
      tools/virtio: fix build

Michael Walle (1):
      mtd: core: handle flashes without OTP gracefully

Micha=C5=82 Miros=C5=82aw (1):
      opp: remove WARN when no valid OPPs remain

Mike Kravetz (1):
      hugetlb: don't pass page cache pages to restore_reserve_on_error

Mike Rapoport (1):
      mmflags.h: add missing __GFP_ZEROTAGS and __GFP_SKIP_KASAN_POISON nam=
es

Ming Lei (3):
      blk-mq: don't grab rq's refcount in blk_mq_check_expired()
      blk-mq: fix kernel panic during iterating over flush request
      blk-mq: fix is_flush_rq

Naoya Horiguchi (1):
      mm/hwpoison: retry with shake_page() for unhandlable pages

Nathan Chancellor (2):
      powerpc/xive: Do not mark xive_request_ipi() as __init
      MAINTAINERS: update ClangBuiltLinux IRC chat

Neeraj Upadhyay (1):
      vringh: Use wiov->used to check for read/write desc order

NeilBrown (1):
      btrfs: prevent rename2 from exchanging a subvol with a directory
from different parents

Nicolas Saenz Julienne (2):
      mmc: sdhci-iproc: Cap min clock frequency on BCM2711
      mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711

Niklas Schnelle (1):
      s390/pci: fix use after free of zpci_dev

Paolo Abeni (1):
      mptcp: fix memory leak on address flush

Parav Pandit (4):
      virtio: Improve vq->broken access to avoid any compiler optimization
      virtio: Keep vring_del_virtqueue() mirror of VQ create
      virtio: Protect vqs list access
      virtio_pci: Support surprise removal of virtio pci device

Pavel Begunkov (1):
      io_uring: pin ctx on fallback execution

Pavel Skripkin (2):
      net: 6pack: fix slab-out-of-bounds in decode_data
      net: asix: fix uninit value bugs

Petr Pavlu (1):
      riscv: Fix a number of free'd resources in init_resources()

Petr Vorel (3):
      arm64: dts: qcom: msm8992-bullhead: Remove PSCI
      arm64: dts: qcom: msm8992-bullhead: Fix cont_splash_mem mapping
      arm64: dts: qcom: msm8994-angler: Disable cont_splash_mem

Pingfan Liu (1):
      tracing: Apply trace filters on all output channels

Rahul Tanwar (1):
      MAINTAINERS: Add Rahul Tanwar as Intel LGM Gateway PCIe maintainer

Rob Herring (1):
      dt-bindings: sifive-l2-cache: Fix 'select' matching

Saravana Kannan (3):
      net: mdio-mux: Delete unnecessary devm_kfree
      net: mdio-mux: Don't ignore memory allocation errors
      net: mdio-mux: Handle -EPROBE_DEFER correctly

Shai Malin (2):
      qed: qed ll2 race condition fixes
      qed: Fix null-pointer dereference in qed_rdma_create_qp()

Shaik Sajida Bhanu (1):
      mmc: sdhci-msm: Update the software timeout value for sdhc

Sibi Sankar (1):
      arm64: dts: qcom: sc7280: Fixup cpufreq domain info for cpu7

Srinivas Kandagatla (5):
      arm64: dts: qcom: c630: fix correct powerdown pin for WSA881x
      slimbus: messaging: start transaction ids from 1 instead of zero
      slimbus: messaging: check for valid transaction id
      slimbus: ngd: set correct device for pm
      slimbus: ngd: reset dma setup during runtime pm

Stephan Mueller (1):
      crypto: drbg - select SHA512

Steven Rostedt (VMware) (1):
      tracing / histogram: Fix NULL pointer dereference on strcmp() on
NULL event name

Sylwester Dziedziuch (1):
      iavf: Fix ping is lost after untrusted VF had tried to change MAC

Takashi Iwai (2):
      ALSA: hda/via: Apply runtime PM workaround for ASUS B23E
      ASoC: intel: atom: Fix breakage for PCM buffer address setup

Takashi Sakamoto (1):
      ALSA: oxfw: fix functioal regression for silence in Apogee Duet FireW=
ire

Thara Gopinath (1):
      cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev

Thomas Wei=C3=9Fschuh (2):
      platform/x86: gigabyte-wmi: add support for X570 GAMING X
      platform/x86: gigabyte-wmi: add support for B450M S2H V2

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      sch_cake: fix srchost/dsthost hashing mode

Tony Lindgren (1):
      bus: ti-sysc: Fix error handling for sysc_check_active_timer()

Vincent Whitchurch (2):
      mmc: dw_mmc: Fix hang on data CRC error
      virtio_vdpa: reject invalid vq indices

Vladimir Oltean (3):
      net: dsa: sja1105: fix use-after-free after calling
of_find_compatible_node, or worse
      net: mscc: ocelot: allow forwarding from bridge ports to the
tag_8021q CPU port
      net: dpaa2-switch: disable the control interface on error path

Wang Hai (1):
      ixgbe, xsk: clean up the resources in ixgbe_xsk_pool_enable error pat=
h

Xie Yongji (7):
      vhost-vdpa: Fix integer overflow in vhost_vdpa_process_iotlb_update()
      vhost: Fix the calculation in vhost_overflow()
      vdpa_sim: Fix return value check for vdpa_alloc_device()
      vp_vdpa: Fix return value check for vdpa_alloc_device()
      vDPA/ifcvf: Fix return value check for vdpa_alloc_device()
      vdpa: Add documentation for vdpa_alloc_device() macro
      virtio-blk: Add validation for block size in config space

Xin Long (1):
      tipc: call tipc_wait_for_connect only when dlen is not 0

Yaara Baruch (2):
      iwlwifi: add new SoF with JF devices
      iwlwifi: add new so-jf devices

Yang Shi (2):
      Revert "mm/shmem: fix shmem_swapin() race with swapoff"
      Revert "mm: swap: check if swap backing device is congested or not"

Yifan Zhang (1):
      drm/amdkfd: fix random KFDSVMRangeTest.SetGetAttributesTest test fail=
ure

Yonghong Song (1):
      bpf: Add rcu_read_lock in bpf_get_current_[ancestor_]cgroup_id() help=
ers

Zhan Liu (1):
      drm/amd/display: Use DCN30 watermark calc for DCN301

Zhihao Cheng (1):
      mtd: mtd_blkdevs: Initialize rq.limits.discard_granularity

jason-jh.lin (2):
      drm/mediatek: Add AAL output size configuration
      drm/mediatek: Add component_del in OVL and COLOR remove function

kaixi.fan (1):
      ovs: clear skb->tstamp in forwarding path
