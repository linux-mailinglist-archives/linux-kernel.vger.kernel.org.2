Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1A3FAEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhH2WUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhH2WUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:20:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC238C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:19:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j12so22544143ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2XzIdPGQr6fXGRSi9RAppv4bK+5VmbVhxf35NSJuFHU=;
        b=JPDlt6P6ScD+o7OG8l7f2XhaIPkNVnbL+hesKBRW0tB6DJQ4s1zOJGDOxfELQVyqUf
         9JMUYxa/0YsgDOJdvyiWb/25/deN3nLf5dBejHGq9vYb5MPpGlUYsd91Mbhfj4Sl00mJ
         Fw8puhfcvG03lVa3pnTXJifx9XxjQg9pQ349w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2XzIdPGQr6fXGRSi9RAppv4bK+5VmbVhxf35NSJuFHU=;
        b=iBU1RFG9FNRcvJWISYTaB6yG0b+iightQMjMnWwQljZA2YTrpBUX+ikhAshXvtXnIf
         VsYLGWUdLJSKD1j+j3KUE6N7t+a7FssXez7miGSE712+uwLuXaKEe9rclBCWMPQxaCYA
         GeZBo+kdiLsskB5wSoCLDAGB65KETAtC6S2UGs4YzjhPEU0J/S3qE+sLWJR3FAmYGYCr
         HmlTDFnI1g1/+IqC0c5vgcgOBUZtnaziB1w1zXQtMVlTJt126rse1bHhFGw9JDHsKfe/
         4UdHTFn2WA5Wal4GE38n1ooa1HY+oWNm1nEZXLXHiYU77y14WfqgkDuIjpnOWaHrpyAE
         Rk8w==
X-Gm-Message-State: AOAM530e42VqG812InOOSexaBT3jGJE4ZFPGIsYRrQpzL99Fx1zaF5Cr
        4sb0wWtNXYFqcf1wGNPaPDjMXOfSNirzITyr
X-Google-Smtp-Source: ABdhPJzMn1OogybbTNrTzMOz8Cep3hWfRvPTBbViMRU57Wv+FSXhcHKD0H7HAcTBWYFez1PKlW9H0A==
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr17560043lji.463.1630275579856;
        Sun, 29 Aug 2021 15:19:39 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v14sm1605423lji.32.2021.08.29.15.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 15:19:39 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k5so27416069lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:19:39 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr7059836lfu.377.1630275579022;
 Sun, 29 Aug 2021 15:19:39 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Aug 2021 15:19:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
Message-ID: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
Subject: Linux 5.14
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I realize you must all still be busy with all the galas and fancy
balls and all the other 30th anniversary events, but at some point you
must be getting tired of the constant glitz, the fireworks, and the
champagne. That ball gown or tailcoat isn't the most comfortable
thing, either. The celebrations will go on for a few more weeks yet,
but you all may just need a breather from them.

And when that happens, I have just the thing for you - a new kernel
release to test and enjoy. Because 5.14 is out there, just waiting for
you to kick the tires and remind yourself what all the festivities are
about.

Of course, the poor tireless kernel maintainers won't have time for
the festivities, because for them, this just means that the merge
window will start tomorrow. We have another 30 years to look forward
to, after all. But for the rest of you, take a breather, build a
kernel, test it out, and then you can go back to the seemingly endless
party that I'm sure you just crawled out of.

                    Linus

---

Aaron Ma (1):
      igc: fix page fault when thunderbolt is unplugged

Adam Ford (1):
      clk: renesas: rcar-usb2-clock-sel: Fix kernel NULL pointer dereferenc=
e

Alexey Gladkov (1):
      ucounts: Increase ucounts reference counter before the security hook

Andrey Ignatov (1):
      rtnetlink: Return correct error on changing device netns

Andy Shevchenko (1):
      media: ipu3-cio2: Drop reference on error path in
cio2_bridge_connect_sensor()

Babu Moger (1):
      x86/resctrl: Fix a maybe-uninitialized build warning treated as error

Bart Van Assche (1):
      mq-deadline: Fix request accounting

Bin Meng (2):
      riscv: dts: microchip: Use 'local-mac-address' for emac1
      riscv: dts: microchip: Add ethernet0 to the aliases node

Bob Pearson (1):
      RDMA/rxe: Fix memory allocation while in a spin lock

Borislav Petkov (1):
      drm/amdgpu: Fix build with missing pm_suspend_target_state module exp=
ort

Christian K=C3=B6nig (1):
      drm/amdgpu: use the preferred pin domain after the check

Christoph Hellwig (1):
      cryptoloop: add a deprecation warning

Christophe JAILLET (1):
      xgene-v2: Fix a resource leak in the error handling path of 'xge_prob=
e()'

Colin Ian King (1):
      perf/x86/intel/uncore: Fix integer overflow on 23 bit left shift of a=
 u32

DENG Qingfang (1):
      net: phy: mediatek: add the missing suspend/resume callbacks

Dan Carpenter (1):
      pd: fix a NULL vs IS_ERR() check

Daniel Borkmann (1):
      bpf: Fix ringbuf helper function compatibility

David Hildenbrand (1):
      virtio-mem: fix sleeping in RCU read side section in
virtio_mem_online_page_cb()

Davide Caratti (1):
      net/sched: ets: fix crash when flipping from 'strict' to 'quantum'

Dinghao Liu (1):
      RDMA/bnxt_re: Remove unpaired rtnl unlock in bnxt_re_dev_init()

Dmitry Osipenko (1):
      PM: domains: Improve runtime PM performance state handling

Eric Dumazet (2):
      ipv6: use siphash in rt6_exception_hash()
      ipv4: use siphash instead of Jenkins in fnhe_hashfun()

Eric W. Biederman (1):
      ucounts: Fix regression preventing increasing of rlimits in init_user=
_ns

Gal Pressman (2):
      RDMA/uverbs: Track dmabuf memory regions
      RDMA/efa: Free IRQ vectors on error flow

Geert Uytterhoeven (1):
      reset: RESET_MCHP_SPARX5 should depend on ARCH_SPARX5

Guangbin Huang (1):
      net: hns3: fix get wrong pfc_en when query PFC configuration

Guojia Liao (1):
      net: hns3: fix duplicate node in VLAN list

Harini Katakam (1):
      net: macb: Add a NULL check on desc_ptp

Helge Deller (1):
      Revert "parisc: Add assembly implementations for memset, strlen,
strcpy, strncpy and strcat"

Jacob Keller (1):
      ice: do not abort devlink info if board identifier can't be found

Jens Axboe (1):
      Revert "block/mq-deadline: Prioritize high-priority requests"

Jerome Brunet (2):
      usb: gadget: f_uac2: fixup feedback endpoint stop
      usb: gadget: u_audio: fix race condition on endpoint stop

Joerg Roedel (1):
      x86/efi: Restore Firmware IDT before calling ExitBootServices()

Johan Hovold (1):
      Revert "USB: serial: ch341: fix character loss at high transfer rates=
"

Kalle Valo (1):
      Revert "net: really fix the build..."

Kim Phillips (3):
      perf/x86/amd/ibs: Work around erratum #1197
      perf/x86/amd/ibs: Extend PERF_PMU_CAP_NO_EXCLUDE to IBS Op
      perf/x86/amd/power: Assign pmu.module

Krzysztof Ha=C5=82asa (1):
      gpu: ipu-v3: Fix i.MX IPU-v3 offset calculations for
(semi)planar U/V formats

Kurt Kanzenbach (2):
      net: dsa: hellcreek: Fix incorrect setting of GCL
      net: dsa: hellcreek: Adjust schedule look ahead window

Kyle Tso (1):
      usb: typec: tcpm: Raise vdm_sm_running flag only when VDM SM is runni=
ng

Li Jinlin (1):
      scsi: core: Fix hang of freezing queue between blocking and running d=
evice

Linus Torvalds (3):
      Revert "media: dvb header files: move some headers to staging"
      pipe: do FASYNC notifications for every pipe IO, not just state chang=
es
      Linux 5.14

Linus Walleij (1):
      ARM: 9104/2: Fix Keystone 2 kernel mapping regression

Lukas Bulwahn (2):
      RDMA/irdma: Use correct kconfig symbol for AUXILIARY_BUS
      powerpc: Re-enable ARCH_ENABLE_SPLIT_PMD_PTLOCK

Maor Gottlieb (1):
      RDMA/mlx5: Fix crash when unbind multiport slave

Marc Zyngier (1):
      stmmac: Revert "stmmac: align RX buffers"

Marek Marczykowski-G=C3=B3recki (1):
      PCI/MSI: Skip masking MSI-X on Xen PV

Marijn Suijten (1):
      opp: core: Check for pending links before reading required_opp pointe=
rs

Matthew Brost (1):
      drm/i915: Fix syncmap memory leak

Maxim Kiselev (1):
      net: marvell: fix MVNETA_TX_IN_PRGRS bit number

Miaohe Lin (1):
      mm/memory_hotplug: fix potential permanent lru cache disable

Michael Riesch (1):
      net: stmmac: dwmac-rk: fix unbalanced pm_runtime_enable warnings

Michel D=C3=A4nzer (1):
      drm/amdgpu: Cancel delayed work when GFXOFF is disabled

Namjae Jeon (1):
      MAINTAINERS: exfat: update my email address

Naresh Kumar PBS (1):
      RDMA/bnxt_re: Add missing spin lock initialization

Nathan Rossi (1):
      net: dsa: mv88e6xxx: Update mv88e6393x serdes errata

Nicholas Piggin (1):
      powerpc/64s: Fix scv implicit soft-mask table for relocated kernels

Oleksij Rempel (2):
      net: usb: asix: ax88772: move embedded PHY detection as early as poss=
ible
      net: usb: asix: do not call phy_disconnect() for ax88178

Peter Zijlstra (1):
      sched: Fix Core-wide rq->lock for uninitialized CPUs

Petko Manolov (1):
      net: usb: pegasus: fixes of set_register(s) return value evaluation;

Philipp Zabel (1):
      drm/imx: ipuv3-plane: fix accidental partial revert of 8 pixel
alignment fix

Qu Wenruo (1):
      Revert "btrfs: compression: don't try to compress if we don't
have enough pages"

Rahul Lakkireddy (1):
      cxgb4: dont touch blocked freelist bitmap after free

Sai Krishna Potthuri (1):
      reset: reset-zynqmp: Fixed the argument data type

Sasha Neftin (2):
      e1000e: Fix the max snoop/no-snoop latency for 10M
      e1000e: Do not take care about recovery NVM checksum

Sebastian Andrzej Siewior (1):
      sched: Fix get_push_task() vs migrate_disable()

Shai Malin (2):
      qed: Fix the VF msix vectors flow
      qede: Fix memset corruption

Shreyansh Chouhan (2):
      ip_gre: add validation for csum_start
      ip6_gre: add validation for csum_start

Song Yoong Siang (2):
      net: stmmac: fix kernel panic due to NULL pointer dereference of xsk_=
pool
      net: stmmac: fix kernel panic due to NULL pointer dereference of buf-=
>xdp

Stefan M=C3=A4tje (1):
      can: usb: esd_usb2: esd_usb2_rx_event(): fix the interchange of
the CAN RX and TX error counters

Swati Sharma (1):
      drm/i915/dp: Drop redundant debug print

Takashi Iwai (1):
      usb: renesas-xhci: Prefer firmware loading on unknown ROM state

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix dwc3_calc_trbs_left()

Toshiki Nishioka (1):
      igc: Use num_tx_queues when iterating over tx_ring queue

Trond Myklebust (1):
      SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...

Tuo Li (2):
      IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_des=
cs()
      ceph: fix possible null-pointer dereference in ceph_mdsmap_decode()

Ulf Hansson (1):
      Revert "mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
on BCM2711"

Vincent Chen (1):
      riscv: Ensure the value of FP registers in the core dump file is
up to date

Wesley Cheng (1):
      usb: dwc3: gadget: Stop EP0 transfers during pullup disable

Will Deacon (1):
      Partially revert "arm64/mm: drop HAVE_ARCH_PFN_VALID"

Wong Vee Khee (1):
      net: stmmac: fix kernel panic due to NULL pointer dereference of plat=
->est

Xiao Yang (1):
      RDMA/rxe: Zero out index member of struct rxe_queue

Xiaolong Huang (1):
      net: qrtr: fix another OOB Read in qrtr_endpoint_post

Xiaoyao Li (1):
      perf/x86/intel/pt: Fix mask of num_address_ranges

Xiubo Li (1):
      ceph: correctly handle releasing an embedded cap flush

Yonglong Liu (1):
      net: hns3: fix speed unknown issue in bond 4

Yufeng Mo (4):
      net: hns3: clear hardware resource when loading driver
      net: hns3: add waiting time before cmdq memory is released
      net: hns3: change the method of getting cmd index in debugfs
      net: hns3: fix GRO configuration error after reset

Zhengjun Zhang (1):
      USB: serial: option: add new VID/PID to support Fibocom FG150

kernel test robot (1):
      net: usb: asix: ax88772: fix boolconv.cocci warnings

zhang kai (1):
      ipv6: correct comments about fib6_node sernum

=E7=8E=8B=E8=B4=87 (1):
      net: fix NULL pointer reference in cipso_v4_doi_free
