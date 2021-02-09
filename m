Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6F314DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhBILGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhBILB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:01:26 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C4C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:00:44 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e7so15640579ile.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDXggwO7qxHQUaRAN0sEiVV1XzQE+HPYMksMWAe9GF0=;
        b=uiPRJLOSfVXpXX3saHZSNwqllXF4i0zQ1Ls20EfqOIExSXLFZ7Q0eeENMkmXfcDK5/
         mH9QP4ZnY2sTwmIXsxCy8bEopH46H7uwQRWGc5TrcTKqfTLY+tyq1z7JcBx1cOFQRlNy
         z1VISyHHPeJ92ZMvdxYPhwX170V30oRC+FU9fS9BvPSvcch4mCcheCdiFxiYdGAiK9Dt
         cL0FJEHklAkCD0pQhY9cTQzVoesvK4ifBlZiyKrDGfk1Trk6W8DmDIJ8NuqLoCdxRj3l
         COhFLNMsW171frvSIpYpoq/iijXOVm92bp9e3fxpVpwSIrTQ4qE8MwL9yeVfriXUA/m6
         kX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDXggwO7qxHQUaRAN0sEiVV1XzQE+HPYMksMWAe9GF0=;
        b=Y15dFVgfMqtJJlBEO8q2XRZ6Q1Cl1lA8WcgannnEFxfOHYBWEQZ+6GoR+WDxIUIsA2
         9mh4wtNSogoCQUV4QRWUUbpp9LSDpPfMkWoVSKUIUEGxZj/TqMLD5YAt/4S+hQq+7nJG
         QS/0+Os8rkKzpA67xDqM9jgGCL6WiVbuUlDhC6XUjSoA6w2nzGi1YJRadv7FM/PQ6bUR
         c9VtekjTxsVnlsVJxm/lDCPNq/zGdTmdGz40hlS+i155I9DcgQ80bYUf3a5OFIs4uoLV
         krM/cdYdV/jbL1WUDVH4FGDArcFRe4yRHmSu24SwMXs8BbJQ7BluaPRgXpQmAFoTKJPz
         NdsQ==
X-Gm-Message-State: AOAM531Hrc5r9/LkiDOm06naDlUVbJJe74bbYNsnvip4JVh7TaikgVLN
        WMOVnQqnyfsXGMhCd/ptev5kj8aF2fNoROSpOkkM2E9NCNuktw==
X-Google-Smtp-Source: ABdhPJzcZjEfc4wlrK9E/CtwZcBdNs8MKXjfOu0npsbRYgt2jvPYrX1AgPfozW/mooNlf6W/SpI9ZfADwGL/HXylyMo=
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr19074306ilb.77.1612868443521;
 Tue, 09 Feb 2021 03:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20210208145806.141056364@linuxfoundation.org>
In-Reply-To: <20210208145806.141056364@linuxfoundation.org>
From:   Igor Torrente <igormtorrente@gmail.com>
Date:   Tue, 9 Feb 2021 08:00:00 -0300
Message-ID: <CAOA8r4GLTTFWQa=V6ZsFOER=gHmbSOt14Q8ixLVyPh23KL03Pw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/38] 4.19.175-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.175 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.175-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
>     Linux 4.19.175-rc1
>
> DENG Qingfang <dqfext@gmail.com>
>     net: dsa: mv88e6xxx: override existent unicast portvec in port_fdb_add
>
> Vadim Fedorenko <vfedorenko@novek.ru>
>     net: ip_tunnel: fix mtu calculation
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
> Dave Hansen <dave.hansen@linux.intel.com>
>     x86/apic: Add extra serialization for non-serializing MSRs
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     x86/build: Disable CET instrumentation in the kernel
>
> Hugh Dickins <hughd@google.com>
>     mm: thp: fix MADV_REMOVE deadlock on shmem THP
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
>     KVM: SVM: Treat SVM as unsupported when running as an SEV guest
>
> Thorsten Leemhuis <linux@leemhuis.info>
>     nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs
>
> Fengnan Chang <fengnanchang@gmail.com>
>     mmc: core: Limit retries when analyse of SDIO tuples fails
>
> Gustavo A. R. Silva <gustavoars@kernel.org>
>     smb3: Fix out-of-bounds bug in SMB2_negotiate()
>
> Aurelien Aptel <aaptel@suse.com>
>     cifs: report error instead of invalid when revalidating a dentry fails
>
> Mathias Nyman <mathias.nyman@linux.intel.com>
>     xhci: fix bounce buffer usage for non-sg list case
>
> Marc Zyngier <maz@kernel.org>
>     genirq/msi: Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is set
>
> Wang ShaoBo <bobo.shaobowang@huawei.com>
>     kretprobe: Avoid re-registration of the same kretprobe earlier
>
> Felix Fietkau <nbd@nbd.name>
>     mac80211: fix station rate table updates on assoc
>
> Liangyan <liangyan.peng@linux.alibaba.com>
>     ovl: fix dentry leak in ovl_get_redirect
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
> Stefan Chulski <stefanc@marvell.com>
>     net: mvpp2: TCAM entry enable should be written after SRAM data
>
> Xie He <xie.he.0141@gmail.com>
>     net: lapb: Copy the skb before sending a packet
>
> Zyta Szpak <zr@semihalf.com>
>     arm64: dts: ls1046a: fix dcfg address range
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix deadlock around release of dst cached on udp tunnel
>
> Alexey Dobriyan <adobriyan@gmail.com>
>     Input: i8042 - unbreak Pegatron C15B
>
> Arnd Bergmann <arnd@arndb.de>
>     elfcore: fix building with clang
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
>  Makefile                                       | 10 ++----
>  arch/arm/mach-footbridge/dc21285.c             | 12 +++----
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  2 +-
>  arch/x86/Makefile                              |  3 ++
>  arch/x86/include/asm/apic.h                    | 10 ------
>  arch/x86/include/asm/barrier.h                 | 18 ++++++++++
>  arch/x86/kernel/apic/apic.c                    |  4 +++
>  arch/x86/kernel/apic/x2apic_cluster.c          |  6 ++--
>  arch/x86/kernel/apic/x2apic_phys.c             |  6 ++--
>  arch/x86/kvm/svm.c                             |  5 +++
>  drivers/input/joystick/xpad.c                  | 17 ++++++++-
>  drivers/input/serio/i8042-x86ia64io.h          |  2 ++
>  drivers/iommu/intel-iommu.c                    |  6 ++++
>  drivers/md/md.c                                |  2 ++
>  drivers/mmc/core/sdio_cis.c                    |  6 ++++
>  drivers/net/dsa/mv88e6xxx/chip.c               |  6 +++-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c | 10 +++---
>  drivers/nvme/host/pci.c                        |  2 ++
>  drivers/usb/class/usblp.c                      | 19 +++++-----
>  drivers/usb/dwc2/gadget.c                      |  8 +----
>  drivers/usb/dwc3/core.c                        |  2 +-
>  drivers/usb/gadget/legacy/ether.c              |  4 ++-
>  drivers/usb/host/xhci-ring.c                   | 31 ++++++++++------
>  drivers/usb/renesas_usbhs/fifo.c               |  1 +
>  drivers/usb/serial/cp210x.c                    |  2 ++
>  drivers/usb/serial/option.c                    |  6 ++++
>  fs/afs/main.c                                  |  6 ++--
>  fs/cifs/dir.c                                  | 22 ++++++++++--
>  fs/cifs/smb2pdu.h                              |  2 +-
>  fs/hugetlbfs/inode.c                           |  3 +-
>  fs/overlayfs/dir.c                             |  2 +-
>  include/linux/elfcore.h                        | 22 ++++++++++++
>  include/linux/hugetlb.h                        |  3 ++
>  include/linux/msi.h                            |  6 ++++
>  kernel/Makefile                                |  1 -
>  kernel/elfcore.c                               | 26 --------------
>  kernel/irq/msi.c                               | 44 +++++++++++------------
>  kernel/kprobes.c                               |  4 +++
>  mm/huge_memory.c                               | 37 +++++++++++--------
>  mm/hugetlb.c                                   | 48 ++++++++++++++++++++++---
>  mm/memblock.c                                  | 49 ++++----------------------
>  net/ipv4/ip_tunnel.c                           | 16 ++++-----
>  net/lapb/lapb_out.c                            |  3 +-
>  net/mac80211/driver-ops.c                      |  5 ++-
>  net/mac80211/rate.c                            |  3 +-
>  net/rxrpc/af_rxrpc.c                           |  6 ++--
>  46 files changed, 308 insertions(+), 200 deletions(-)
>
>
