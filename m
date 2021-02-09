Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8367314DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhBILGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBILB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:01:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1183C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:01:10 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so15695990ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 03:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ci6eTDmOtfIEvGKSHUjNoclyPzj6iObmLf7V2RrdB4=;
        b=tphFIV4BtXi537wyyeWM9tawgfFpAl8fgOzRE1cW/Kd1fk6xKpkuCw56L8vno1LEfx
         rkNNv9m09b2mq0CmYzKrJZMY+k+NOZqO4/0Uptxdva8+TLto7QOlDjgKC+ELIZFJT5MK
         vv+pajA5h7DdXbx/WkUwpxWyvBSaEXSCqPCgA8PTwDGqBT5d/2rdwwD0oIZto9xjbSeM
         7J/cRXt55ydmKsGmTe8f3otsDvWUPPKWNkEWyoX3Kp4d7pMzlNeND0Q1qwTd7QjcT+op
         nsmRGEza3N8l+bvcD/Mv/xSij2I9GzFyTBZ/CSvUrtrOFlpSaWKNkgsB3WX8GVS7B4Ls
         QnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ci6eTDmOtfIEvGKSHUjNoclyPzj6iObmLf7V2RrdB4=;
        b=HP8ln7cGXHzrtJFoGS5t94geI/Z2Ps8QyDlKOXtRLCspVQsM4r+O8rMmhGm6ZoxFOB
         3/DYnCmrka5qloKXZnnsjW1EZxix3DQqX/cYQNyqoNuq6xEgyQpNoMm9BR00zfMdwTP1
         RKZEs7q8hja08hVrW2HH1Skd70sYAvUxLOIWSc3X4wZ3vhRmksiWjP2TxRT34DqnuEgt
         pGi2Ul7MyagmwUZNVP1nOW/znXhtii22yWhjUrojCEsKx6+XA6OA/FwIXKKXL4JhH5Ua
         JdixKvXiDoNnhO+sMqwZGYXAYMD/OzTpLxnT/KNf5gyRhXZ45r/QIQiBShImEnGSpo4T
         iuoQ==
X-Gm-Message-State: AOAM530HLw3AS3rotsA/uBqNGaQyo5LWecsOLZy54aJeX1kES02toCc2
        yf5yAJpXfEz+nJe1nzozuQkJiEKs1h9tNZ52G34=
X-Google-Smtp-Source: ABdhPJzo+QuUAj94KElTYUbHn3F+LIxzMRgD1Li1pOUVtR1gEtM7dDKWipF8DK+mQRK/2LbnzNaigWmCMBMje6oO4ZM=
X-Received: by 2002:a92:360a:: with SMTP id d10mr19169786ila.198.1612868470314;
 Tue, 09 Feb 2021 03:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20210208145810.230485165@linuxfoundation.org>
In-Reply-To: <20210208145810.230485165@linuxfoundation.org>
From:   Igor Torrente <igormtorrente@gmail.com>
Date:   Tue, 9 Feb 2021 08:00:00 -0300
Message-ID: <CAOA8r4Gzz=F-T=+Du9-YgGeygz3mkx03TOJ5pPsHUp4fAEFBZw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/65] 5.4.97-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.97 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.97-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>

Compiled and booted on my machine(x86_64) without any dmesg regression.
My compilation uses the default Debian 10 .config(From kernel
4.19.0-14-amd64), followed by olddefconfig.

Tested-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

Best regards
---
Igor Matheus Andrade Torrente

> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.4.97-rc1
>
> Pali Roh=C3=A1r <pali@kernel.org>
>     usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720
>
> Alexander Ovechkin <ovov@yandex-team.ru>
>     net: sched: replaced invalid qdisc tree flush helper in qdisc_replace
>
> DENG Qingfang <dqfext@gmail.com>
>     net: dsa: mv88e6xxx: override existent unicast portvec in port_fdb_ad=
d
>
> Vadim Fedorenko <vfedorenko@novek.ru>
>     net: ip_tunnel: fix mtu calculation
>
> Chinmay Agarwal <chinagar@codeaurora.org>
>     neighbour: Prevent a dead entry from updating gc_list
>
> Kai-Heng Feng <kai.heng.feng@canonical.com>
>     igc: Report speed and duplex as unknown when device is runtime suspen=
ded
>
> Xiao Ni <xni@redhat.com>
>     md: Set prev_flush_start and flush_bio in an atomic way
>
> Nadav Amit <namit@vmware.com>
>     iommu/vt-d: Do not use flush-queue when caching-mode is on
>
> Benjamin Valentin <benpicco@googlemail.com>
>     Input: xpad - sync supported devices with fork on GitHub
>
> Luca Coelho <luciano.coelho@intel.com>
>     iwlwifi: mvm: don't send RFH_QUEUE_CONFIG_CMD with no queues
>
> Dave Hansen <dave.hansen@linux.intel.com>
>     x86/apic: Add extra serialization for non-serializing MSRs
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     x86/build: Disable CET instrumentation in the kernel
>
> Hugh Dickins <hughd@google.com>
>     mm: thp: fix MADV_REMOVE deadlock on shmem THP
>
> Rokudo Yan <wu-yan@tcl.com>
>     mm, compaction: move high_pfn to the for loop scope
>
> Muchun Song <songmuchun@bytedance.com>
>     mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
>
> Muchun Song <songmuchun@bytedance.com>
>     mm: hugetlb: fix a race between isolating and freeing page
>
> Muchun Song <songmuchun@bytedance.com>
>     mm: hugetlb: fix a race between freeing and dissolving the page
>
> Muchun Song <songmuchun@bytedance.com>
>     mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
>
> Russell King <rmk+kernel@armlinux.org.uk>
>     ARM: footbridge: fix dc21285 PCI configuration accessors
>
> Sean Christopherson <seanjc@google.com>
>     KVM: x86: Update emulator context mode if SYSENTER xfers to 64-bit mo=
de
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Treat SVM as unsupported when running as an SEV guest
>
> Thorsten Leemhuis <linux@leemhuis.info>
>     nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs
>
> Stylon Wang <stylon.wang@amd.com>
>     drm/amd/display: Revert "Fix EDID parsing after resume from suspend"
>
> Fengnan Chang <fengnanchang@gmail.com>
>     mmc: core: Limit retries when analyse of SDIO tuples fails
>
> Pavel Shilovsky <pshilov@microsoft.com>
>     smb3: fix crediting for compounding when only one request in flight
>
> Gustavo A. R. Silva <gustavoars@kernel.org>
>     smb3: Fix out-of-bounds bug in SMB2_negotiate()
>
> Aurelien Aptel <aaptel@suse.com>
>     cifs: report error instead of invalid when revalidating a dentry fail=
s
>
> Mathias Nyman <mathias.nyman@linux.intel.com>
>     xhci: fix bounce buffer usage for non-sg list case
>
> Marc Zyngier <maz@kernel.org>
>     genirq/msi: Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is =
set
>
> Dan Williams <dan.j.williams@intel.com>
>     libnvdimm/dimm: Avoid race between probe and available_slots_show()
>
> Wang ShaoBo <bobo.shaobowang@huawei.com>
>     kretprobe: Avoid re-registration of the same kretprobe earlier
>
> Steven Rostedt (VMware) <rostedt@goodmis.org>
>     fgraph: Initialize tracing_graph_pause at task creation
>
> Felix Fietkau <nbd@nbd.name>
>     mac80211: fix station rate table updates on assoc
>
> Liangyan <liangyan.peng@linux.alibaba.com>
>     ovl: fix dentry leak in ovl_get_redirect
>
> Peter Chen <peter.chen@nxp.com>
>     usb: host: xhci-plat: add priv quirk for skip PHY initialization
>
> Chunfeng Yun <chunfeng.yun@mediatek.com>
>     usb: xhci-mtk: break loop when find the endpoint to drop
>
> Chunfeng Yun <chunfeng.yun@mediatek.com>
>     usb: xhci-mtk: skip dropping bandwidth of unchecked endpoints
>
> Ikjoon Jang <ikjn@chromium.org>
>     usb: xhci-mtk: fix unreleased bandwidth data
>
> Gary Bisson <gary.bisson@boundarydevices.com>
>     usb: dwc3: fix clock issue during resume in OTG mode
>
> Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>     usb: dwc2: Fix endpoint direction check in ep_from_windex
>
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>     usb: renesas_usbhs: Clear pipe running flag in usbhs_pkt_pop()
>
> Jeremy Figgins <kernel@jeremyfiggins.com>
>     USB: usblp: don't call usb_set_interface if there's a single alt
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     USB: gadget: legacy: fix an error code in eth_bind()
>
> Roman Gushchin <guro@fb.com>
>     memblock: do not start bottom-up allocations with kernel_end
>
> Sagi Grimberg <sagi@grimberg.me>
>     nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata P=
DUs
>
> Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
>     ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
>
> Heiner Kallweit <hkallweit1@gmail.com>
>     r8169: fix WoL on shutdown if CONFIG_DEBUG_SHIRQ is set
>
> Stefan Chulski <stefanc@marvell.com>
>     net: mvpp2: TCAM entry enable should be written after SRAM data
>
> Xie He <xie.he.0141@gmail.com>
>     net: lapb: Copy the skb before sending a packet
>
> Maor Gottlieb <maorg@nvidia.com>
>     net/mlx5: Fix leak upon failure of rule creation
>
> Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>     i40e: Revert "i40e: don't report link up for a VF who hasn't enabled =
queues"
>
> Kevin Lo <kevlo@kevlo.org>
>     igc: check return value of ret_val in igc_config_fc_after_link_up
>
> Kevin Lo <kevlo@kevlo.org>
>     igc: set the default return value to -IGC_ERR_NVM in igc_write_nvm_sr=
wr
>
> Zyta Szpak <zr@semihalf.com>
>     arm64: dts: ls1046a: fix dcfg address range
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix deadlock around release of dst cached on udp tunnel
>
> Johannes Berg <johannes.berg@intel.com>
>     um: virtio: free vu_dev only with the contained struct device
>
> Loris Reiff <loris.reiff@liblor.ch>
>     bpf, cgroup: Fix problematic bounds check
>
> Loris Reiff <loris.reiff@liblor.ch>
>     bpf, cgroup: Fix optlen WARN_ON_ONCE toctou
>
> Sandy Huang <hjc@rock-chips.com>
>     arm64: dts: rockchip: fix vopl iommu irq on px30
>
> Serge Semin <Sergey.Semin@baikalelectronics.ru>
>     arm64: dts: amlogic: meson-g12: Set FL-adj property value
>
> Alexey Dobriyan <adobriyan@gmail.com>
>     Input: i8042 - unbreak Pegatron C15B
>
> Shawn Guo <shawn.guo@linaro.org>
>     arm64: dts: qcom: c630: keep both touchpad devices enabled
>
> Christoph Schemmel <christoph.schemmel@gmail.com>
>     USB: serial: option: Adding support for Cinterion MV31
>
> Chenxin Jin <bg4akv@hotmail.com>
>     USB: serial: cp210x: add new VID/PID for supporting Teraoka AD2000
>
> Pho Tran <Pho.Tran@silabs.com>
>     USB: serial: cp210x: add pid/vid for WSDA-200-USB
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |  10 +-
>  arch/arm/boot/dts/sun7i-a20-bananapro.dts          |   2 +-
>  arch/arm/mach-footbridge/dc21285.c                 |  12 +-
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  10 +-
>  arch/arm64/boot/dts/rockchip/px30.dtsi             |   2 +-
>  arch/um/drivers/virtio_uml.c                       |   3 +-
>  arch/x86/Makefile                                  |   3 +
>  arch/x86/include/asm/apic.h                        |  10 --
>  arch/x86/include/asm/barrier.h                     |  18 +++
>  arch/x86/kernel/apic/apic.c                        |   4 +
>  arch/x86/kernel/apic/x2apic_cluster.c              |   6 +-
>  arch/x86/kernel/apic/x2apic_phys.c                 |   9 +-
>  arch/x86/kvm/emulate.c                             |   2 +
>  arch/x86/kvm/svm.c                                 |   5 +
>  arch/x86/mm/mem_encrypt.c                          |   1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 -
>  drivers/input/joystick/xpad.c                      |  17 ++-
>  drivers/input/serio/i8042-x86ia64io.h              |   2 +
>  drivers/iommu/intel-iommu.c                        |   6 +
>  drivers/md/md.c                                    |   2 +
>  drivers/mmc/core/sdio_cis.c                        |   6 +
>  drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  13 +--
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 -
>  drivers/net/ethernet/intel/igc/igc_ethtool.c       |   3 +-
>  drivers/net/ethernet/intel/igc/igc_i225.c          |   3 +-
>  drivers/net/ethernet/intel/igc/igc_mac.c           |   2 +-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     |  10 +-
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   5 +
>  drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   9 +-
>  drivers/nvdimm/dimm_devs.c                         |  18 ++-
>  drivers/nvme/host/pci.c                            |   2 +
>  drivers/nvme/target/tcp.c                          |   3 +-
>  drivers/usb/class/usblp.c                          |  19 +--
>  drivers/usb/dwc2/gadget.c                          |   8 +-
>  drivers/usb/dwc3/core.c                            |   2 +-
>  drivers/usb/gadget/legacy/ether.c                  |   4 +-
>  drivers/usb/host/xhci-mtk-sch.c                    | 130 +++++++++++++++=
------
>  drivers/usb/host/xhci-mtk.c                        |   2 +
>  drivers/usb/host/xhci-mtk.h                        |  15 +++
>  drivers/usb/host/xhci-mvebu.c                      |  42 +++++++
>  drivers/usb/host/xhci-mvebu.h                      |   6 +
>  drivers/usb/host/xhci-plat.c                       |  26 ++++-
>  drivers/usb/host/xhci-plat.h                       |   1 +
>  drivers/usb/host/xhci-ring.c                       |  31 +++--
>  drivers/usb/host/xhci.c                            |   8 +-
>  drivers/usb/host/xhci.h                            |   5 +
>  drivers/usb/renesas_usbhs/fifo.c                   |   1 +
>  drivers/usb/serial/cp210x.c                        |   2 +
>  drivers/usb/serial/option.c                        |   6 +
>  fs/afs/main.c                                      |   6 +-
>  fs/cifs/dir.c                                      |  22 +++-
>  fs/cifs/smb2pdu.h                                  |   2 +-
>  fs/cifs/transport.c                                |  18 ++-
>  fs/hugetlbfs/inode.c                               |   3 +-
>  fs/overlayfs/dir.c                                 |   2 +-
>  include/linux/hugetlb.h                            |   2 +
>  include/linux/msi.h                                |   6 +
>  include/net/sch_generic.h                          |   2 +-
>  init/init_task.c                                   |   3 +-
>  kernel/bpf/cgroup.c                                |   7 +-
>  kernel/irq/msi.c                                   |  44 ++++---
>  kernel/kprobes.c                                   |   4 +
>  kernel/trace/fgraph.c                              |   2 -
>  mm/compaction.c                                    |   3 +-
>  mm/huge_memory.c                                   |  37 +++---
>  mm/hugetlb.c                                       |  48 +++++++-
>  mm/memblock.c                                      |  49 +-------
>  net/core/neighbour.c                               |   7 +-
>  net/ipv4/ip_tunnel.c                               |  16 ++-
>  net/lapb/lapb_out.c                                |   3 +-
>  net/mac80211/driver-ops.c                          |   5 +-
>  net/mac80211/rate.c                                |   3 +-
>  net/rxrpc/af_rxrpc.c                               |   6 +-
>  77 files changed, 558 insertions(+), 265 deletions(-)
>
>
