Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7413AD3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhFRUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:43:21 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:48557 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhFRUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:43:19 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 16:43:17 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1624048869; h=From: Date: Message-Id: To: Subject: Sender;
 bh=a3wB58XHsUNaWK+LJ5d6x3iGaM8k7BpSdSiLvW1S4DM=; b=NUhM2d5r9qUON5QcMMnS2n0vM5pjV5AYCq7OyrZj5OccU30yAcC7sqnqq53q6KQOizapZRVN
 DWloPXPv96zjhi4hrSszJv+XAyL9d/zKBLtcpHjqEtnU8lzgqeGjtOmYJfs1KTsV27k3InBl
 TyiA19+gCB2oxlVAKnCIALz4O8U=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli.it
 (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60cd03a3e27c0cc77f5e52ea (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 18 Jun 2021 20:35:46 GMT
Sender: jose.r.r=metztli.com@mixtli.metztli.it
Received: by huitzilopochtli.metztli.it (Postfix, from userid 1000)
        id EE0AD808DD42; Fri, 18 Jun 2021 13:35:54 -0700 (PDT)
Subject: Successful Reiser4 4.0.2 -enhanced Debian Bullseye kernel 5.10.42 installation into Supermicro H12SSW-NT AMD Epyc 7302P 16 cores/32 threads, 128 GB RAM server
To:     <edward.shishkin@gmail.com>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
X-Mailer: mail (GNU Mailutils 3.9)
Message-Id: <20210618203554.EE0AD808DD42@huitzilopochtli.metztli.it>
Date:   Fri, 18 Jun 2021 13:35:54 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Metztli Information Technology <jose@metztli.it>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: installation-reports: Successful Reiser4 4.0.2 -enhanced Debian Bullseye installation into Supermicro H12SSW-NT AMD Epyc 7302P 16 cores/32 threads, 128 GB RAM server
Bcc: Metztli Information Technology <jose.r.r@metztli.com>

Package: installation-reports
Severity: normal

(Please provide enough information to help the Debian
maintainers evaluate the report efficiently - e.g., by filling
in the sections below.)

Boot method: netboot ISO image copied onto 0.3 Gb disk partition carved out
from existing swap partition.
Image version: (enhanced with non-free firmware)
< https://metztli.it/bullseye/netboot/metztli-reiser4-z.iso >
< https://metztli.it/bullseye/netboot/metztli-reiser4-z.iso.SHA256SUM >
Date: Jun 12, 2021 22:23 PST

Machine: Supermicro H12SSW-NT AMD Epyc 7302P 16 cores / 128 GB RAM
Partitions: 
Filesystem     Type     1K-blocks    Used Available Use% Mounted on
udev           devtmpfs  65792784       0  65792784   0% /dev
tmpfs          tmpfs     13162128    8316  13153812   1% /run
/dev/sda6      reiser4   33089784 3056832  30032952  10% /
tmpfs          tmpfs     65810632       0  65810632   0% /dev/shm
tmpfs          tmpfs         5120       0      5120   0% /run/lock
/dev/sda2      jfs         972564   46412    926152   5% /boot
tmpfs          tmpfs     13162124       0  13162124   0% /run/user/1000
/dev/sda4      reiser4  890486624   28808 890457816   1% /mnt/nahui

Base System Installation Checklist:
[O] = OK, [E] = Error (please elaborate below), [ ] = didn't try it

Initial boot:           [O]
Detect network card:    [O]
Configure network:      [O]
Detect media:           [O]
Load installer modules: [O]
Clock/timezone setup:   [O]
User/password setup:    [O]
Detect hard drives:     [O]
Partition hard drives:  [O]
Install base system:    [O]
Install tasks:          [O]
Install boot loader:    [O]
Overall install:        [O]

Comments/Problems: Expert install -- patience and inductive reasoning -- no other way.
	Alse, inclusion of non-free firmware in the netboot d-i is a must!

Remotely provisioned Buster extX LVM preconfigured server had no CDROM device nor
bootable ISO image support via available KVM/VNC environment.

Precautions:
Make a backup of the original /etc directory as it contains important
info of the preconfigured automatically provisioned server -- especially the
/etc/network/interfaces file which may be recycled after a successful
Debian 11 installation -- as the below cited procedure will leave your
Bullseye with no network connectivity upon reboot after successfull
installation.

I carved out a ~300 MB slice from the preconfigured swap partition;
subsequently formatted slice to JFS and I copied into my 'Metztli Reiser4 z'
-enhanced installer netboot ISO image.

Again, below is the tepito [snippet] that I wrote to /etc/grub.d/40_custom file
to boot Metztli Reiser4:

menuentry 'Metztli Reiser4 Expert Moiocoiani Bullseye AMD Epyc install' {
set isofile='metztli-reiser4-z.iso'
insmod gzio
insmod part_gpt
insmod jfs
insmod loopback
loopback loop (hd0,gpt5)/ISOs/$isofile
linux (loop)/linux priority=low vga=788 ---
initrd (loop)/initrd.gz
}

then executed (wielding root privilege): update-grub

Gateway was local ip (netmask 255.255.255.255), i.e., required 'pointopoint'
field currently not valid nor enabled in Debian Bullseye GUI d-i. Thus, during
the manual network configuration I left the gateway entry blank and
proceeded until the 'Choose a mirror of the Debian archive' menu entry
was highlighted.

I then scrolled down in the menu to highlight 'Execute a shell' entry
and, subsequently, manually typed directives:

ip route add <gatewayip> dev <devicename>
ip route add default via <gatewayip> dev <devicename>

< https://steffenschiffel.de/debian-installer-pointopoint-netzwerkkonfiguration/ >

After exiting the shell, I proceeded to select the previously highlighed
menu entry, 'Choose a mirror of the Debian archive', and the network installation proceeded.

Overview of procedure was recorded/edited/redacted; indeed, I had a degree of difficulty
typing text into the VNC/KVM GUI -- which had noticeable
latency/redrawing/capturing the keyboard events. Also the link contains
four Cyrillic chars, Вики, which some browsers may have trouble
accessing if link not enclosed within double quotes:

< https://metztli.blog/media/blogs/calli/Moiocoiatzin/Moiocoiani-Вики-Xochiquetzal.mp4?mtime=1624037634 >


Please make sure that any installation logs that you think would
be useful are attached to this report. Please compress large
files using gzip.


-- Package-specific info:

==============================================
Installer lsb-release:
==============================================
DISTRIB_ID=Debian
DISTRIB_DESCRIPTION="Debian GNU/Linux installer"
DISTRIB_RELEASE="11 (bullseye) - installer build 20210609-11:02:06"
X_INSTALLATION_MEDIUM=netboot

==============================================
Installer hardware-summary:
==============================================
uname -a: Linux moiocoiani 5.10.0-7+reizer4.0.2-amd64 #1 SMP Debian 5.10.42-2+reizer4.0.2 (2021-06-08) x86_64 Metztli Reiser4/SFRN4
lspci -knn: 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:790b]
lspci -knn: 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:790e]
lspci -knn: 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 0 [1022:1490]
lspci -knn: 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 1 [1022:1491]
lspci -knn: 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 2 [1022:1492]
lspci -knn: 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 3 [1022:1493]
lspci -knn: 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 4 [1022:1494]
lspci -knn: 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 5 [1022:1495]
lspci -knn: 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 6 [1022:1496]
lspci -knn: 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship Device 24; Function 7 [1022:1497]
lspci -knn: 01:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 01:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 02:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 02:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 02:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:145c]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 40:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 40:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 40:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 40:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 41:00.0 RAID bus controller [0104]: Broadcom / LSI MegaRAID Tri-Mode SAS3408 [1000:0017] (rev 01)
lspci -knn: 	Subsystem: Broadcom / LSI Device [1000:9440]
lspci -knn: 	Kernel driver in use: megaraid_sas
lspci -knn: 	Kernel modules: megaraid_sas
lspci -knn: 42:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 42:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 43:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 43:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
lspci -knn: 43:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 43:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:145c]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 44:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:7901]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: 45:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:7901]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: 80:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 80:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 80:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:03.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 80:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 83:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 83:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 84:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 84:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: c0:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: c0:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: c0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:03.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:03.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:03.5 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:03.6 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:03.7 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: c0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c1:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller [1b21:1142]
lspci -knn: 	DeviceName: ASMedia USB 3.1 #1
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: c2:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller [1b21:1142]
lspci -knn: 	DeviceName: ASMedia USB 3.1 #2
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: c3:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
lspci -knn: c4:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
lspci -knn: 	DeviceName: ASPEED Video AST2500
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: c5:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial ATA Controller [1b21:0612] (rev 02)
lspci -knn: 	DeviceName: ASMedia SATA 6G
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:1b2b]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: c6:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57416 NetXtreme-E Dual-Media 10G RDMA Ethernet Controller [14e4:16d8] (rev 01)
lspci -knn: 	DeviceName: Broadcom 10G Ethernet #1
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:16d8]
lspci -knn: 	Kernel driver in use: bnxt_en
lspci -knn: 	Kernel modules: bnxt_en
lspci -knn: c6:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57416 NetXtreme-E Dual-Media 10G RDMA Ethernet Controller [14e4:16d8] (rev 01)
lspci -knn: 	DeviceName: Broadcom 10G Ethernet #2
lspci -knn: 	Subsystem: Super Micro Computer Inc Device [15d9:16d8]
lspci -knn: 	Kernel driver in use: bnxt_en
lspci -knn: 	Kernel modules: bnxt_en
lspci -knn: c7:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: c7:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: c8:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: c8:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
usb-list: 
usb-list: Bus 01 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 02 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 03 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 04 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 05 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 06 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 07 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 07 Device 02: xHCI Host Controller [0557:7000]
usb-list:    Level 01 Parent 01 Port 01  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 07 Device 03: xHCI Host Controller [0557:2419]
usb-list:    Level 02 Parent 02 Port 00  Class 00(>ifc ) Subclass 00 Protocol 00
usb-list:    Interface 00: Class 03(HID  ) Subclass 01 Protocol 01 Driver usbhid
usb-list:    Interface 01: Class 03(HID  ) Subclass 01 Protocol 02 Driver usbhid
usb-list: 
usb-list: Bus 08 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.10.0-7+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
lsmod: Module                  Size  Used by
lsmod: fuse                  167936  0
lsmod: ufs                    94208  0
lsmod: qnx4                   16384  0
lsmod: hfsplus               126976  0
lsmod: hfs                    73728  0
lsmod: cdrom                  73728  2 hfsplus,hfs
lsmod: minix                  45056  0
lsmod: msdos                  20480  0
lsmod: battery                20480  0
lsmod: dm_mod                163840  6
lsmod: md_mod                184320  0
lsmod: xfs                  1773568  0
lsmod: reiser4               569344  1
lsmod: jfs                   212992  1
lsmod: btrfs                1564672  0
lsmod: xor                    24576  1 btrfs
lsmod: raid6_pq              122880  1 btrfs
lsmod: libcrc32c              16384  2 btrfs,xfs
lsmod: vfat                   20480  0
lsmod: fat                    86016  2 msdos,vfat
lsmod: ext4                  921600  0
lsmod: crc16                  16384  1 ext4
lsmod: mbcache                16384  1 ext4
lsmod: jbd2                  151552  1 ext4
lsmod: crc32c_generic         16384  2
lsmod: usb_storage            81920  0
lsmod: hid_generic            16384  0
lsmod: usbhid                 65536  0
lsmod: hid                   147456  2 usbhid,hid_generic
lsmod: sd_mod                 61440  5
lsmod: t10_pi                 16384  1 sd_mod
lsmod: crc_t10dif             20480  1 t10_pi
lsmod: crct10dif_common       16384  1 crc_t10dif
lsmod: ahci                   40960  0
lsmod: xhci_pci               20480  0
lsmod: libahci                45056  1 ahci
lsmod: xhci_hcd              307200  1 xhci_pci
lsmod: crc32_pclmul           16384  0
lsmod: libata                290816  2 libahci,ahci
lsmod: megaraid_sas          180224  4
lsmod: usbcore               323584  4 xhci_hcd,usbhid,usb_storage,xhci_pci
lsmod: bnxt_en               286720  0
lsmod: scsi_mod              262144  4 sd_mod,usb_storage,megaraid_sas,libata
lsmod: usb_common             16384  2 xhci_hcd,usbcore
df: Filesystem           1K-blocks      Used Available Use% Mounted on
df: tmpfs                 13162132       108  13162024   0% /run
df: devtmpfs              65725168         0  65725168   0% /dev
df: /dev/sda6             33089784   1251828  31837956   4% /target
df: /dev/sda2               972564     43996    928568   5% /target/boot
df: /dev/sda6             33089784   1251828  31837956   4% /dev/.static/dev
df: devtmpfs              65725168         0  65725168   0% /target/dev
free:               total        used        free      shared  buff/cache   available
free: Mem:      131621296      513996   129073664      444768     2033636   129522080
free: Swap:       2929660           0     2929660
/proc/cmdline: BOOT_IMAGE=(loop)/linux priority=low vga=788 ---
/proc/cpuinfo: processor	: 0
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1799.722
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 0
/proc/cpuinfo: initial apicid	: 0
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 1
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1800.164
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 2
/proc/cpuinfo: initial apicid	: 2
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 2
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1744.527
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 8
/proc/cpuinfo: initial apicid	: 8
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 3
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2166.010
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 10
/proc/cpuinfo: initial apicid	: 10
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 4
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2187.385
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 8
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 16
/proc/cpuinfo: initial apicid	: 16
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 5
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1741.788
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 9
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 18
/proc/cpuinfo: initial apicid	: 18
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 6
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1817.333
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 12
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 24
/proc/cpuinfo: initial apicid	: 24
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 7
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1799.294
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 13
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 26
/proc/cpuinfo: initial apicid	: 26
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 8
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2621.479
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 16
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 32
/proc/cpuinfo: initial apicid	: 32
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 9
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2651.638
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 17
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 34
/proc/cpuinfo: initial apicid	: 34
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 10
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2549.848
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 20
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 40
/proc/cpuinfo: initial apicid	: 40
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 11
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1730.085
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 21
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 42
/proc/cpuinfo: initial apicid	: 42
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 12
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1602.754
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 24
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 48
/proc/cpuinfo: initial apicid	: 48
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 13
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2431.830
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 25
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 50
/proc/cpuinfo: initial apicid	: 50
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 14
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1609.485
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 28
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 56
/proc/cpuinfo: initial apicid	: 56
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 15
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1875.215
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 29
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 58
/proc/cpuinfo: initial apicid	: 58
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 16
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1711.715
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 1
/proc/cpuinfo: initial apicid	: 1
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 17
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1724.894
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 3
/proc/cpuinfo: initial apicid	: 3
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 18
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1599.832
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 9
/proc/cpuinfo: initial apicid	: 9
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 19
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1883.833
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 11
/proc/cpuinfo: initial apicid	: 11
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 20
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1919.701
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 8
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 17
/proc/cpuinfo: initial apicid	: 17
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 21
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1683.701
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 9
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 19
/proc/cpuinfo: initial apicid	: 19
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 22
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1608.805
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 12
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 25
/proc/cpuinfo: initial apicid	: 25
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 23
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1597.269
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 13
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 27
/proc/cpuinfo: initial apicid	: 27
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 24
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2073.892
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 16
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 33
/proc/cpuinfo: initial apicid	: 33
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 25
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 3302.685
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 17
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 35
/proc/cpuinfo: initial apicid	: 35
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 26
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 3294.834
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 20
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 41
/proc/cpuinfo: initial apicid	: 41
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 27
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1678.550
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 21
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 43
/proc/cpuinfo: initial apicid	: 43
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 28
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1739.558
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 24
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 49
/proc/cpuinfo: initial apicid	: 49
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 29
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2169.238
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 25
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 51
/proc/cpuinfo: initial apicid	: 51
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 30
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 1689.966
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 28
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 57
/proc/cpuinfo: initial apicid	: 57
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 31
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 49
/proc/cpuinfo: model name	: AMD EPYC 7302P 16-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x830104d
/proc/cpuinfo: cpu MHz		: 2643.355
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 29
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 59
/proc/cpuinfo: initial apicid	: 59
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 6000.23
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/ioports: 0000-02ff : PCI Bus 0000:00
/proc/ioports:   0000-001f : dma1
/proc/ioports:   0020-0021 : pic1
/proc/ioports:   0040-0043 : timer0
/proc/ioports:   0050-0053 : timer1
/proc/ioports:   0060-0060 : keyboard
/proc/ioports:   0061-0061 : PNP0800:00
/proc/ioports:   0064-0064 : keyboard
/proc/ioports:   0070-0071 : rtc0
/proc/ioports:   0080-008f : dma page reg
/proc/ioports:   00a0-00a1 : pic2
/proc/ioports:   00b2-00b2 : APEI ERST
/proc/ioports:   00c0-00df : dma2
/proc/ioports:   00f0-00ff : fpu
/proc/ioports:   02f8-02ff : serial
/proc/ioports: 0300-03af : PCI Bus 0000:00
/proc/ioports: 03b0-03df : PCI Bus 0000:c0
/proc/ioports:   03c0-03df : vesafb
/proc/ioports: 03e0-0cf7 : PCI Bus 0000:00
/proc/ioports:   03f8-03ff : serial
/proc/ioports:   040b-040b : pnp 00:05
/proc/ioports:   04d0-04d1 : pnp 00:05
/proc/ioports:   04d6-04d6 : pnp 00:05
/proc/ioports:   0800-089f : pnp 00:05
/proc/ioports:     0800-0803 : ACPI PM1a_EVT_BLK
/proc/ioports:     0804-0805 : ACPI PM1a_CNT_BLK
/proc/ioports:     0808-080b : ACPI PM_TMR
/proc/ioports:     0820-0827 : ACPI GPE0_BLK
/proc/ioports:   0900-090f : pnp 00:05
/proc/ioports:   0910-091f : pnp 00:05
/proc/ioports:   0a00-0a0f : pnp 00:02
/proc/ioports:   0a10-0a1f : pnp 00:02
/proc/ioports:   0a20-0a2f : pnp 00:02
/proc/ioports:   0a30-0a3f : pnp 00:02
/proc/ioports:   0a40-0a4f : pnp 00:02
/proc/ioports:   0b00-0b0f : pnp 00:05
/proc/ioports:   0b20-0b3f : pnp 00:05
/proc/ioports:   0c00-0c01 : pnp 00:05
/proc/ioports:   0c14-0c14 : pnp 00:05
/proc/ioports:   0c50-0c51 : pnp 00:05
/proc/ioports:   0c52-0c52 : pnp 00:05
/proc/ioports:   0c6c-0c6c : pnp 00:05
/proc/ioports:   0c6f-0c6f : pnp 00:05
/proc/ioports:   0ca2-0ca2 : IPMI Address 1
/proc/ioports:   0ca3-0ca3 : IPMI Address 2
/proc/ioports:   0ca4-0ca4 : IPI0001:00
/proc/ioports:   0ca5-0ca5 : IPI0001:00
/proc/ioports:   0cd0-0cd1 : pnp 00:05
/proc/ioports:   0cd2-0cd3 : pnp 00:05
/proc/ioports:   0cd4-0cd5 : pnp 00:05
/proc/ioports:   0cd6-0cd7 : pnp 00:05
/proc/ioports:   0cd8-0cdf : pnp 00:05
/proc/ioports: 0cf8-0cff : PCI conf1
/proc/ioports: 1000-3fff : PCI Bus 0000:00
/proc/ioports: 4000-7fff : PCI Bus 0000:40
/proc/ioports:   7000-7fff : PCI Bus 0000:41
/proc/ioports:     7000-70ff : 0000:41:00.0
/proc/ioports: 8000-bfff : PCI Bus 0000:80
/proc/ioports:   8000-8fff : PCI Bus 0000:81
/proc/ioports:   9000-9fff : PCI Bus 0000:82
/proc/ioports: c000-ffff : PCI Bus 0000:c0
/proc/ioports:   e000-efff : PCI Bus 0000:c5
/proc/ioports:     e000-e01f : 0000:c5:00.0
/proc/ioports:       e000-e01f : ahci
/proc/ioports:     e020-e023 : 0000:c5:00.0
/proc/ioports:       e020-e023 : ahci
/proc/ioports:     e030-e037 : 0000:c5:00.0
/proc/ioports:       e030-e037 : ahci
/proc/ioports:     e040-e043 : 0000:c5:00.0
/proc/ioports:       e040-e043 : ahci
/proc/ioports:     e050-e057 : 0000:c5:00.0
/proc/ioports:       e050-e057 : ahci
/proc/ioports:   f000-ffff : PCI Bus 0000:c3
/proc/ioports:     f000-ffff : PCI Bus 0000:c4
/proc/ioports:       f000-f07f : 0000:c4:00.0
/proc/iomem: 00000000-00000fff : Reserved
/proc/iomem: 00001000-00099fff : System RAM
/proc/iomem: 0009a000-0009ffff : Reserved
/proc/iomem: 000a0000-000bffff : PCI Bus 0000:c0
/proc/iomem: 000c0000-000dffff : PCI Bus 0000:00
/proc/iomem: 000e0000-000fffff : Reserved
/proc/iomem:   000f0000-000fffff : System ROM
/proc/iomem: 00100000-73ffffff : System RAM
/proc/iomem: 74000000-74021fff : ACPI Non-volatile Storage
/proc/iomem: 74022000-75daffff : System RAM
/proc/iomem: 75db0000-75ffffff : Reserved
/proc/iomem: 76000000-9b3d6fff : System RAM
/proc/iomem: 9b3d7000-9d27bfff : Reserved
/proc/iomem:   9d240018-9d240019 : APEI ERST
/proc/iomem:   9d24001c-9d240021 : APEI ERST
/proc/iomem:   9d240028-9d240039 : APEI ERST
/proc/iomem:   9d240040-9d24004c : APEI ERST
/proc/iomem:   9d240050-9d24204f : APEI ERST
/proc/iomem: 9d27c000-9d366fff : ACPI Tables
/proc/iomem: 9d367000-9d7e7fff : ACPI Non-volatile Storage
/proc/iomem: 9d7e8000-a89bbfff : Reserved
/proc/iomem: a89bc000-abffffff : System RAM
/proc/iomem: ac000000-afffffff : Reserved
/proc/iomem: b0000000-b07fffff : PCI Bus 0000:40
/proc/iomem:   b0000000-b02fffff : PCI Bus 0000:43
/proc/iomem:     b0000000-b00fffff : 0000:43:00.3
/proc/iomem:       b0000000-b00fffff : xhci-hcd
/proc/iomem:     b0100000-b01fffff : 0000:43:00.1
/proc/iomem:     b0200000-b027ffff : 0000:43:00.2
/proc/iomem:     b0280000-b0281fff : 0000:43:00.2
/proc/iomem:     b0282000-b0283fff : 0000:43:00.1
/proc/iomem:   b0300000-b04fffff : PCI Bus 0000:41
/proc/iomem:     b0300000-b03fffff : 0000:41:00.0
/proc/iomem:     b0400000-b04fffff : 0000:41:00.0
/proc/iomem:   b0500000-b05fffff : PCI Bus 0000:45
/proc/iomem:     b0500000-b05007ff : 0000:45:00.0
/proc/iomem:       b0500000-b05007ff : ahci
/proc/iomem:   b0600000-b06fffff : PCI Bus 0000:44
/proc/iomem:     b0600000-b06007ff : 0000:44:00.0
/proc/iomem:       b0600000-b06007ff : ahci
/proc/iomem:   b0700000-b07fffff : PCI Bus 0000:42
/proc/iomem:     b0700000-b077ffff : 0000:42:00.2
/proc/iomem:     b0780000-b0781fff : 0000:42:00.2
/proc/iomem: b4000000-b5ffffff : Reserved
/proc/iomem:   b4100000-b417ffff : amd_iommu
/proc/iomem:   b4180000-b41803ff : IOAPIC 3
/proc/iomem:   b5200000-b527ffff : amd_iommu
/proc/iomem:   b5280000-b52803ff : IOAPIC 1
/proc/iomem: b6000000-b80fffff : PCI Bus 0000:c0
/proc/iomem:   b6000000-b70fffff : PCI Bus 0000:c3
/proc/iomem:     b6000000-b70fffff : PCI Bus 0000:c4
/proc/iomem:       b6000000-b6ffffff : 0000:c4:00.0
/proc/iomem:         b6000000-b60effff : vesafb
/proc/iomem:       b7000000-b701ffff : 0000:c4:00.0
/proc/iomem:   b7200000-b72fffff : PCI Bus 0000:c8
/proc/iomem:     b7200000-b727ffff : 0000:c8:00.2
/proc/iomem:     b7280000-b7281fff : 0000:c8:00.2
/proc/iomem:   b7300000-b73fffff : PCI Bus 0000:c7
/proc/iomem:     b7300000-b737ffff : 0000:c7:00.2
/proc/iomem:     b7380000-b7381fff : 0000:c7:00.2
/proc/iomem:   b7400000-b74fffff : PCI Bus 0000:c6
/proc/iomem:     b7400000-b747ffff : 0000:c6:00.1
/proc/iomem:     b7480000-b74fffff : 0000:c6:00.0
/proc/iomem:   b7500000-b75fffff : PCI Bus 0000:c5
/proc/iomem:     b7500000-b75001ff : 0000:c5:00.0
/proc/iomem:       b7500000-b75001ff : ahci
/proc/iomem:   b7600000-b76fffff : PCI Bus 0000:c2
/proc/iomem:     b7600000-b7607fff : 0000:c2:00.0
/proc/iomem:       b7600000-b7607fff : xhci-hcd
/proc/iomem:   b7700000-b77fffff : PCI Bus 0000:c1
/proc/iomem:     b7700000-b7707fff : 0000:c1:00.0
/proc/iomem:       b7700000-b7707fff : xhci-hcd
/proc/iomem: e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
/proc/iomem:   e0000000-efffffff : pnp 00:00
/proc/iomem: f0000000-f03fffff : PCI Bus 0000:80
/proc/iomem:   f0000000-f00fffff : PCI Bus 0000:84
/proc/iomem:     f0000000-f007ffff : 0000:84:00.2
/proc/iomem:     f0080000-f0081fff : 0000:84:00.2
/proc/iomem:   f0100000-f01fffff : PCI Bus 0000:83
/proc/iomem:     f0100000-f017ffff : 0000:83:00.2
/proc/iomem:     f0180000-f0181fff : 0000:83:00.2
/proc/iomem:   f0200000-f02fffff : PCI Bus 0000:82
/proc/iomem:   f0300000-f03fffff : PCI Bus 0000:81
/proc/iomem: f4000000-f5ffffff : Reserved
/proc/iomem:   f4100000-f417ffff : amd_iommu
/proc/iomem:   f4180000-f41803ff : IOAPIC 2
/proc/iomem:   f5100000-f517ffff : amd_iommu
/proc/iomem:   f5180000-f51803ff : IOAPIC 4
/proc/iomem: f6000000-f62fffff : PCI Bus 0000:00
/proc/iomem:   f6000000-f61fffff : PCI Bus 0000:02
/proc/iomem:     f6000000-f60fffff : 0000:02:00.3
/proc/iomem:       f6000000-f60fffff : xhci-hcd
/proc/iomem:     f6100000-f617ffff : 0000:02:00.2
/proc/iomem:     f6180000-f6181fff : 0000:02:00.2
/proc/iomem:   f6200000-f62fffff : PCI Bus 0000:01
/proc/iomem:     f6200000-f627ffff : 0000:01:00.2
/proc/iomem:     f6280000-f6281fff : 0000:01:00.2
/proc/iomem: fe000000-ffffffff : Reserved
/proc/iomem:   fec00000-fec003ff : IOAPIC 0
/proc/iomem:   fec10000-fec10fff : pnp 00:05
/proc/iomem:   fed00000-fed003ff : HPET 0
/proc/iomem:   fed80000-fed814ff : pnp 00:05
/proc/iomem:   fed81500-fed817ff : AMDI0030:00
/proc/iomem:   fed81900-fed8ffff : pnp 00:05
/proc/iomem:   fedc0000-fedc0fff : pnp 00:05
/proc/iomem:   fee00000-fee00fff : Local APIC
/proc/iomem:     fee00000-fee00fff : pnp 00:05
/proc/iomem:   ff000000-ffffffff : pnp 00:05
/proc/iomem: 100000000-204f1fffff : System RAM
/proc/iomem:   ddd800000-dde401e76 : Kernel code
/proc/iomem:   dde600000-ddea00fff : Kernel rodata
/proc/iomem:   ddec00000-ddee8453f : Kernel data
/proc/iomem:   ddf470000-ddf9fffff : Kernel bss
/proc/iomem: 204f200000-204fffffff : Reserved
/proc/iomem: 10000000000-100201fffff : Reserved
/proc/iomem: 10021000000-18020ffffff : PCI Bus 0000:c0
/proc/iomem:   18020d00000-18020ffffff : PCI Bus 0000:c6
/proc/iomem:     18020d00000-18020dfffff : 0000:c6:00.1
/proc/iomem:       18020d00000-18020dfffff : bnxt_en
/proc/iomem:     18020e00000-18020efffff : 0000:c6:00.0
/proc/iomem:       18020e00000-18020efffff : bnxt_en
/proc/iomem:     18020f00000-18020f0ffff : 0000:c6:00.1
/proc/iomem:       18020f00000-18020f0ffff : bnxt_en
/proc/iomem:     18020f10000-18020f1ffff : 0000:c6:00.0
/proc/iomem:       18020f10000-18020f1ffff : bnxt_en
/proc/iomem:     18020f20000-18020f21fff : 0000:c6:00.1
/proc/iomem:       18020f20000-18020f21fff : bnxt_en
/proc/iomem:     18020f22000-18020f23fff : 0000:c6:00.0
/proc/iomem:       18020f22000-18020f23fff : bnxt_en
/proc/iomem: 18021000000-20020ffffff : PCI Bus 0000:80
/proc/iomem:   18021000000-180211fffff : PCI Bus 0000:81
/proc/iomem:   18021200000-180213fffff : PCI Bus 0000:82
/proc/iomem: 20030000000-200403fffff : Reserved
/proc/iomem: 20060000000-200801fffff : Reserved
/proc/iomem: 20081000000-28080ffffff : PCI Bus 0000:40
/proc/iomem:   28080e00000-28080ffffff : PCI Bus 0000:41
/proc/iomem:     28080e00000-28080efffff : 0000:41:00.0
/proc/iomem:     28080f00000-28080ffffff : 0000:41:00.0
/proc/iomem:       28080f00000-28080ffffff : megasas: LSI
/proc/iomem: 28081000000-38080ffffff : PCI Bus 0000:00
/proc/iomem: 38090000000-380a03fffff : Reserved
/proc/iomem: 7fc00000000-7fc03ffffff : Reserved
/proc/interrupts:             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12      CPU13      CPU14      CPU15      CPU16      CPU17      CPU18      CPU19      CPU20      CPU21      CPU22      CPU23      CPU24      CPU25      CPU26      CPU27      CPU28      CPU29      CPU30      CPU31      
/proc/interrupts:    0:         35          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    2-edge      timer
/proc/interrupts:    7:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    7-fasteoi   pinctrl_amd
/proc/interrupts:    8:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          1          0          0          0          0          0          0  IR-IO-APIC    8-edge      rtc0
/proc/interrupts:    9:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    9-fasteoi   acpi
/proc/interrupts:   26:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100667392-edge      AMD-Vi
/proc/interrupts:   27:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67112960-edge      AMD-Vi
/proc/interrupts:   28:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 33558528-edge      AMD-Vi
/proc/interrupts:   29:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 4096-edge      AMD-Vi
/proc/interrupts:   30:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100718592-edge      PCIe PME
/proc/interrupts:   31:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100720640-edge      PCIe PME
/proc/interrupts:   32:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100722688-edge      PCIe PME
/proc/interrupts:   33:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100724736-edge      PCIe PME
/proc/interrupts:   34:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100726784-edge      PCIe PME
/proc/interrupts:   36:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100780032-edge      PCIe PME
/proc/interrupts:   38:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 100796416-edge      PCIe PME
/proc/interrupts:   39:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 67160064-edge      PCIe PME, pciehp
/proc/interrupts:   40:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 67162112-edge      PCIe PME, pciehp
/proc/interrupts:   42:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 67225600-edge      PCIe PME
/proc/interrupts:   44:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 67241984-edge      PCIe PME
/proc/interrupts:   45:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 33605632-edge      PCIe PME
/proc/interrupts:   47:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 33671168-edge      PCIe PME
/proc/interrupts:   48:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 33687552-edge      PCIe PME
/proc/interrupts:   49:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 33689600-edge      PCIe PME
/proc/interrupts:   50:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 33691648-edge      PCIe PME
/proc/interrupts:   52:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 116736-edge      PCIe PME
/proc/interrupts:   53:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 133120-edge      PCIe PME
/proc/interrupts:   55:       6012          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809024-edge      eno1np0-TxRx-0
/proc/interrupts:   56:          0       9158          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809025-edge      eno1np0-TxRx-1
/proc/interrupts:   57:          0          0       4110          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809026-edge      eno1np0-TxRx-2
/proc/interrupts:   58:          0          0          0       7076          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809027-edge      eno1np0-TxRx-3
/proc/interrupts:   59:          0          0          0          0       8150          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809028-edge      eno1np0-TxRx-4
/proc/interrupts:   60:          0          0          0          0          0      14606          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809029-edge      eno1np0-TxRx-5
/proc/interrupts:   61:          0          0          0          0          0          0       4393          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809030-edge      eno1np0-TxRx-6
/proc/interrupts:   62:          0          0          0          0          0          0          0       4155          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103809031-edge      eno1np0-TxRx-7
/proc/interrupts:   64:          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811072-edge    
/proc/interrupts:   65:          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811073-edge    
/proc/interrupts:   66:          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811074-edge    
/proc/interrupts:   67:          0          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811075-edge    
/proc/interrupts:   68:          0          0          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811076-edge    
/proc/interrupts:   69:          0          0          0          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811077-edge    
/proc/interrupts:   70:          0          0          0          0          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811078-edge    
/proc/interrupts:   71:          0          0          0          0          0          0          0          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103811079-edge    
/proc/interrupts:   73:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        237          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078720-edge      megasas0-msix0
/proc/interrupts:   74:      32385          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078721-edge      megasas0-msix1
/proc/interrupts:   75:          0      18267          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078722-edge      megasas0-msix2
/proc/interrupts:   76:          0          0      11393          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078723-edge      megasas0-msix3
/proc/interrupts:   77:          0          0          0      20206          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078724-edge      megasas0-msix4
/proc/interrupts:   78:          0          0          0          0      10084          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078725-edge      megasas0-msix5
/proc/interrupts:   79:          0          0          0          0          0      23101          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078726-edge      megasas0-msix6
/proc/interrupts:   80:          0          0          0          0          0          0      21141          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078727-edge      megasas0-msix7
/proc/interrupts:   81:          0          0          0          0          0          0          0      20742          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078728-edge      megasas0-msix8
/proc/interrupts:   82:          0          0          0          0          0          0          0          0      51108          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078729-edge      megasas0-msix9
/proc/interrupts:   83:          0          0          0          0          0          0          0          0          0      16178          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078730-edge      megasas0-msix10
/proc/interrupts:   84:          0          0          0          0          0          0          0          0          0          0      23990          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078731-edge      megasas0-msix11
/proc/interrupts:   85:          0          0          0          0          0          0          0          0          0          0          0      18863          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078732-edge      megasas0-msix12
/proc/interrupts:   86:          0          0          0          0          0          0          0          0          0          0          0          0      27312          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078733-edge      megasas0-msix13
/proc/interrupts:   87:          0          0          0          0          0          0          0          0          0          0          0          0          0      15706          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078734-edge      megasas0-msix14
/proc/interrupts:   88:          0          0          0          0          0          0          0          0          0          0          0          0          0          0      20926          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078735-edge      megasas0-msix15
/proc/interrupts:   89:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      36659          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078736-edge      megasas0-msix16
/proc/interrupts:   90:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      21370          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078737-edge      megasas0-msix17
/proc/interrupts:   91:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      24031          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078738-edge      megasas0-msix18
/proc/interrupts:   92:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      14534          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078739-edge      megasas0-msix19
/proc/interrupts:   93:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      16943          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078740-edge      megasas0-msix20
/proc/interrupts:   94:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       6662          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078741-edge      megasas0-msix21
/proc/interrupts:   95:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      14656          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078742-edge      megasas0-msix22
/proc/interrupts:   96:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      20078          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078743-edge      megasas0-msix23
/proc/interrupts:   97:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      22875          0          0          0          0          0          0          0          0  IR-PCI-MSI 34078744-edge      megasas0-msix24
/proc/interrupts:   98:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      25939          0          0          0          0          0          0          0  IR-PCI-MSI 34078745-edge      megasas0-msix25
/proc/interrupts:   99:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      25531          0          0          0          0          0          0  IR-PCI-MSI 34078746-edge      megasas0-msix26
/proc/interrupts:  100:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      16171          0          0          0          0          0  IR-PCI-MSI 34078747-edge      megasas0-msix27
/proc/interrupts:  101:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      13145          0          0          0          0  IR-PCI-MSI 34078748-edge      megasas0-msix28
/proc/interrupts:  102:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      18750          0          0          0  IR-PCI-MSI 34078749-edge      megasas0-msix29
/proc/interrupts:  103:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      32376          0          0  IR-PCI-MSI 34078750-edge      megasas0-msix30
/proc/interrupts:  104:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      14116          0  IR-PCI-MSI 34078751-edge      megasas0-msix31
/proc/interrupts:  105:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      27502  IR-PCI-MSI 34078752-edge      megasas0-msix32
/proc/interrupts:  107:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103284736-edge      ahci[0000:c5:00.0]
/proc/interrupts:  108:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187584-edge      xhci_hcd
/proc/interrupts:  109:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187585-edge      xhci_hcd
/proc/interrupts:  110:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187586-edge      xhci_hcd
/proc/interrupts:  111:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187587-edge      xhci_hcd
/proc/interrupts:  112:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187588-edge      xhci_hcd
/proc/interrupts:  113:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187589-edge      xhci_hcd
/proc/interrupts:  114:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187590-edge      xhci_hcd
/proc/interrupts:  115:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101187591-edge      xhci_hcd
/proc/interrupts:  117:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651584-edge      ahci0
/proc/interrupts:  118:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651585-edge      ahci1
/proc/interrupts:  119:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651586-edge      ahci2
/proc/interrupts:  120:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651587-edge      ahci3
/proc/interrupts:  121:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651588-edge      ahci4
/proc/interrupts:  122:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651589-edge      ahci5
/proc/interrupts:  123:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651590-edge      ahci6
/proc/interrupts:  124:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35651591-edge      ahci7
/proc/interrupts:  134:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711872-edge      xhci_hcd
/proc/interrupts:  135:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711873-edge      xhci_hcd
/proc/interrupts:  136:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711874-edge      xhci_hcd
/proc/interrupts:  137:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711875-edge      xhci_hcd
/proc/interrupts:  138:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711876-edge      xhci_hcd
/proc/interrupts:  139:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711877-edge      xhci_hcd
/proc/interrupts:  140:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711878-edge      xhci_hcd
/proc/interrupts:  141:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 101711879-edge      xhci_hcd
/proc/interrupts:  143:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133440-edge      xhci_hcd
/proc/interrupts:  144:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133441-edge      xhci_hcd
/proc/interrupts:  145:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133442-edge      xhci_hcd
/proc/interrupts:  146:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133443-edge      xhci_hcd
/proc/interrupts:  147:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133444-edge      xhci_hcd
/proc/interrupts:  148:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133445-edge      xhci_hcd
/proc/interrupts:  149:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133446-edge      xhci_hcd
/proc/interrupts:  150:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 35133447-edge      xhci_hcd
/proc/interrupts:  152:          0          0          0          0       1458          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054720-edge      xhci_hcd
/proc/interrupts:  153:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054721-edge      xhci_hcd
/proc/interrupts:  154:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054722-edge      xhci_hcd
/proc/interrupts:  155:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054723-edge      xhci_hcd
/proc/interrupts:  156:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054724-edge      xhci_hcd
/proc/interrupts:  157:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054725-edge      xhci_hcd
/proc/interrupts:  158:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054726-edge      xhci_hcd
/proc/interrupts:  159:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1054727-edge      xhci_hcd
/proc/interrupts:  161:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175872-edge      ahci0
/proc/interrupts:  162:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175873-edge      ahci1
/proc/interrupts:  163:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175874-edge      ahci2
/proc/interrupts:  164:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175875-edge      ahci3
/proc/interrupts:  165:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175876-edge      ahci4
/proc/interrupts:  166:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175877-edge      ahci5
/proc/interrupts:  167:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175878-edge      ahci6
/proc/interrupts:  168:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 36175879-edge      ahci7
/proc/interrupts:  NMI:          0          0          1          0          0          0          0          0          0          0          2          0          0          0          2          2          3          0          1          0          0          2          0          0          2          1          0          0          0          0          0          2   Non-maskable interrupts
/proc/interrupts:  LOC:       7560       8750      11708       9286      11130      10597       8956       9307      31634      12282      11679       8244      10557       8668      13771      11993      14947       8822      11159       8148       8255      11536      17650       8014      12636      21251       9484       9904       9457      12724       7647      11104   Local timer interrupts
/proc/interrupts:  SPU:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Spurious interrupts
/proc/interrupts:  PMI:          0          0          1          0          0          0          0          0          0          0          2          0          0          0          2          2          3          0          1          0          0          2          0          0          2          1          0          0          0          0          0          2   Performance monitoring interrupts
/proc/interrupts:  IWI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IRQ work interrupts
/proc/interrupts:  RTR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   APIC ICR read retries
/proc/interrupts:  RES:       9528       6569       8322       9253       7799       8108       5981       6907       7173       9103       6651       8604       7123      10200       6950       6682       6897       8586       7802       8833      10986       8936       7126      10932       5970       6402       8582       6911       8902       8436       6588       6230   Rescheduling interrupts
/proc/interrupts:  CAL:      45847      30160      37394      32257      32186      32157      30927      30895      31102      35207      30837      30380      31723      38619      31089      30777      31510      34835      31168      36627      31298      30565      31551      39867      31401      31926      30456      31263      35892      35233      30887      31661   Function call interrupts
/proc/interrupts:  TLB:       9422      11693       8683      13777       9131      19408      10576      13780       8521       8075      10555      13329       9846      10377       9955      15651      12807      11139      10638      10407      12974      12628      16233      14462      14821      12134      11373      10276      12011      10562      10935      12602   TLB shootdowns
/proc/interrupts:  TRM:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Thermal event interrupts
/proc/interrupts:  THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Threshold APIC interrupts
/proc/interrupts:  DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Deferred Error APIC interrupts
/proc/interrupts:  MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Machine check exceptions
/proc/interrupts:  MCP:          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6          6   Machine check polls
/proc/interrupts:  ERR:          1
/proc/interrupts:  MIS:          0
/proc/interrupts:  PIN:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt notification event
/proc/interrupts:  NPI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Nested posted-interrupt event
/proc/interrupts:  PIW:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt wakeup event
/proc/meminfo: MemTotal:       131621296 kB
/proc/meminfo: MemFree:        129073672 kB
/proc/meminfo: MemAvailable:   129522100 kB
/proc/meminfo: Buffers:            2944 kB
/proc/meminfo: Cached:          1848200 kB
/proc/meminfo: SwapCached:            0 kB
/proc/meminfo: Active:          1660948 kB
/proc/meminfo: Inactive:         214736 kB
/proc/meminfo: Active(anon):     373680 kB
/proc/meminfo: Inactive(anon):    95628 kB
/proc/meminfo: Active(file):    1287268 kB
/proc/meminfo: Inactive(file):   119108 kB
/proc/meminfo: Unevictable:           0 kB
/proc/meminfo: Mlocked:               0 kB
/proc/meminfo: SwapTotal:       2929660 kB
/proc/meminfo: SwapFree:        2929660 kB
/proc/meminfo: Dirty:              2380 kB
/proc/meminfo: Writeback:             0 kB
/proc/meminfo: AnonPages:         24644 kB
/proc/meminfo: Mapped:             5496 kB
/proc/meminfo: Shmem:            444768 kB
/proc/meminfo: KReclaimable:     182504 kB
/proc/meminfo: Slab:             331248 kB
/proc/meminfo: SReclaimable:     182504 kB
/proc/meminfo: SUnreclaim:       148744 kB
/proc/meminfo: KernelStack:        6848 kB
/proc/meminfo: PageTables:          720 kB
/proc/meminfo: NFS_Unstable:          0 kB
/proc/meminfo: Bounce:                0 kB
/proc/meminfo: WritebackTmp:          0 kB
/proc/meminfo: CommitLimit:    68740308 kB
/proc/meminfo: Committed_AS:     474912 kB
/proc/meminfo: VmallocTotal:   34359738367 kB
/proc/meminfo: VmallocUsed:      142200 kB
/proc/meminfo: VmallocChunk:          0 kB
/proc/meminfo: Percpu:            36864 kB
/proc/meminfo: HardwareCorrupted:     0 kB
/proc/meminfo: AnonHugePages:     16384 kB
/proc/meminfo: ShmemHugePages:        0 kB
/proc/meminfo: ShmemPmdMapped:        0 kB
/proc/meminfo: FileHugePages:         0 kB
/proc/meminfo: FilePmdMapped:         0 kB
/proc/meminfo: HugePages_Total:       0
/proc/meminfo: HugePages_Free:        0
/proc/meminfo: HugePages_Rsvd:        0
/proc/meminfo: HugePages_Surp:        0
/proc/meminfo: Hugepagesize:       2048 kB
/proc/meminfo: Hugetlb:               0 kB
/proc/meminfo: DirectMap4k:      763556 kB
/proc/meminfo: DirectMap2M:     9420800 kB
/proc/meminfo: DirectMap1G:    124780544 kB
/proc/bus/input/devices: I: Bus=0003 Vendor=0557 Product=2419 Version=0100
/proc/bus/input/devices: N: Name="HID 0557:2419"
/proc/bus/input/devices: P: Phys=usb-0000:02:00.3-2.1/input0
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:08.1/0000:02:00.3/usb7/7-2/7-2.1/7-2.1:1.0/0003:0557:2419.0001/input/input0
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=sysrq kbd leds 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=120013
/proc/bus/input/devices: B: KEY=1000000000007 ff800000000007ff f2beffdf73cfffff fffffffffffffffe
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: B: LED=1f
/proc/bus/input/devices: 
/proc/bus/input/devices: I: Bus=0003 Vendor=0557 Product=2419 Version=0100
/proc/bus/input/devices: N: Name="HID 0557:2419"
/proc/bus/input/devices: P: Phys=usb-0000:02:00.3-2.1/input1
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:08.1/0000:02:00.3/usb7/7-2/7-2.1/7-2.1:1.1/0003:0557:2419.0002/input/input1
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=mouse0 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=1f
/proc/bus/input/devices: B: KEY=70000 0 0 0 0
/proc/bus/input/devices: B: REL=900
/proc/bus/input/devices: B: ABS=3
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: 
dmidecode: # dmidecode 3.3
dmidecode: Getting SMBIOS data from sysfs.
dmidecode: SMBIOS 3.2.0 present.
dmidecode: Table at 0xA8509000.
dmidecode: 
dmidecode: Handle 0x0000, DMI type 0, 26 bytes
dmidecode: BIOS Information
dmidecode: 	Vendor: American Megatrends Inc.
dmidecode: 	Version: 1.3
dmidecode: 	Release Date: 11/25/2020
dmidecode: 	Address: 0xF0000
dmidecode: 	Runtime Size: 64 kB
dmidecode: 	ROM Size: 32 MB
dmidecode: 	Characteristics:
dmidecode: 		PCI is supported
dmidecode: 		BIOS is upgradeable
dmidecode: 		BIOS shadowing is allowed
dmidecode: 		Boot from CD is supported
dmidecode: 		Selectable boot is supported
dmidecode: 		BIOS ROM is socketed
dmidecode: 		EDD is supported
dmidecode: 		5.25"/1.2 MB floppy services are supported (int 13h)
dmidecode: 		3.5"/720 kB floppy services are supported (int 13h)
dmidecode: 		3.5"/2.88 MB floppy services are supported (int 13h)
dmidecode: 		Print screen service is supported (int 5h)
dmidecode: 		Serial services are supported (int 14h)
dmidecode: 		Printer services are supported (int 17h)
dmidecode: 		ACPI is supported
dmidecode: 		USB legacy is supported
dmidecode: 		BIOS boot specification is supported
dmidecode: 		Targeted content distribution is supported
dmidecode: 		UEFI is supported
dmidecode: 	BIOS Revision: 5.14
dmidecode: 
dmidecode: Handle 0x0001, DMI type 1, 27 bytes
dmidecode: System Information
dmidecode: 	Manufacturer: RAUSCH
dmidecode: 	Product Name: 520012
dmidecode: 	Version: 4500108544
dmidecode: 	Serial Number: RNT20201101666
dmidecode: 	UUID: 00000000-0000-0000-0000-ac1f6be79e9e
dmidecode: 	Wake-up Type: Power Switch
dmidecode: 	SKU Number: To be filled by O.E.M.
dmidecode: 	Family: To be filled by O.E.M.
dmidecode: 
dmidecode: Handle 0x0002, DMI type 2, 15 bytes
dmidecode: Base Board Information
dmidecode: 	Manufacturer: Supermicro
dmidecode: 	Product Name: H12SSW-NT
dmidecode: 	Version: 1.01
dmidecode: 	Serial Number: ZM208S602597
dmidecode: 	Asset Tag: To be filled by O.E.M.
dmidecode: 	Features:
dmidecode: 		Board is a hosting board
dmidecode: 		Board is removable
dmidecode: 		Board is replaceable
dmidecode: 	Location In Chassis: To be filled by O.E.M.
dmidecode: 	Chassis Handle: 0x0003
dmidecode: 	Type: Motherboard
dmidecode: 	Contained Object Handles: 0
dmidecode: 
dmidecode: Handle 0x0003, DMI type 3, 22 bytes
dmidecode: Chassis Information
dmidecode: 	Manufacturer: Rausch
dmidecode: 	Type: Main Server Chassis
dmidecode: 	Lock: Not Present
dmidecode: 	Version: 0123456789
dmidecode: 	Serial Number: 0123456789
dmidecode: 	Asset Tag: To be filled by O.E.M.
dmidecode: 	Boot-up State: Safe
dmidecode: 	Power Supply State: Safe
dmidecode: 	Thermal State: Safe
dmidecode: 	Security Status: None
dmidecode: 	OEM Information: 0x00000000
dmidecode: 	Height: Unspecified
dmidecode: 	Number Of Power Cords: 1
dmidecode: 	Contained Elements: 0
dmidecode: 	SKU Number: To be filled by O.E.M.
dmidecode: 
dmidecode: Handle 0x0004, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JVGA1
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: VGA
dmidecode: 	External Connector Type: DB-15 female
dmidecode: 	Port Type: Video Port
dmidecode: 
dmidecode: Handle 0x0005, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JCOM1
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: COM1
dmidecode: 	External Connector Type: DB-9 male
dmidecode: 	Port Type: Serial Port 16550A Compatible
dmidecode: 
dmidecode: Handle 0x0006, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JLAN1
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: LAN1
dmidecode: 	External Connector Type: RJ-45
dmidecode: 	Port Type: Network Port
dmidecode: 
dmidecode: Handle 0x0007, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JLAN2
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: LAN2
dmidecode: 	External Connector Type: RJ-45
dmidecode: 	Port Type: Network Port
dmidecode: 
dmidecode: Handle 0x0008, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JUSB1
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: USB2/3(3.0)
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x0009, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: JUSBRJ45
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: USB0/1(3.0) IPMI_LAN
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x000A, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: M.2-HC1
dmidecode: 	Type: x4 M.2 Socket 3
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Short
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:ff:00.0
dmidecode: 
dmidecode: Handle 0x000B, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: M.2-HC2
dmidecode: 	Type: x2 M.2 Socket 3
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Short
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:ff:00.0
dmidecode: 
dmidecode: Handle 0x000C, DMI type 11, 5 bytes
dmidecode: OEM Strings
dmidecode: 	String 1: AMD EPYC Soc/Rome                                 
dmidecode: 	String 2: Supermicro motherboard-H12 Series                 
dmidecode: 
dmidecode: Handle 0x000D, DMI type 32, 20 bytes
dmidecode: System Boot Information
dmidecode: 	Status: No errors detected
dmidecode: 
dmidecode: Handle 0x000E, DMI type 39, 22 bytes
dmidecode: System Power Supply
dmidecode: 	Power Unit Group: 1
dmidecode: 	Location: PSU1
dmidecode: 	Name: CPR-7011-7M1
dmidecode: 	Manufacturer: COMPUWARE
dmidecode: 	Serial Number: 701171K33QB0101
dmidecode: 	Asset Tag: N/A
dmidecode: 	Model Part Number: CPR-7011-7M1
dmidecode: 	Revision: 1.3
dmidecode: 	Max Power Capacity: 0 W
dmidecode: 	Status: Present, OK
dmidecode: 	Type: Switching
dmidecode: 	Input Voltage Range Switching: Auto-switch
dmidecode: 	Plugged: Yes
dmidecode: 	Hot Replaceable: No
dmidecode: 
dmidecode: Handle 0x000F, DMI type 39, 22 bytes
dmidecode: System Power Supply
dmidecode: 	Power Unit Group: 2
dmidecode: 	Location: PSU2
dmidecode: 	Name: CPR-7011-7M1
dmidecode: 	Manufacturer: COMPUWARE
dmidecode: 	Serial Number: 701171K33QB0180
dmidecode: 	Asset Tag: N/A
dmidecode: 	Model Part Number: CPR-7011-7M1
dmidecode: 	Revision: 1.3
dmidecode: 	Max Power Capacity: 0 W
dmidecode: 	Status: Present, OK
dmidecode: 	Type: Switching
dmidecode: 	Input Voltage Range Switching: Auto-switch
dmidecode: 	Plugged: Yes
dmidecode: 	Hot Replaceable: No
dmidecode: 
dmidecode: Handle 0x0010, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: ASMedia USB 3.1 #1
dmidecode: 	Type: Other
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:c1:00.0
dmidecode: 
dmidecode: Handle 0x0011, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: ASMedia USB 3.1 #2
dmidecode: 	Type: Other
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 2
dmidecode: 	Bus Address: 0000:c2:00.0
dmidecode: 
dmidecode: Handle 0x0012, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: ASPEED Video AST2500
dmidecode: 	Type: Video
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:c4:00.0
dmidecode: 
dmidecode: Handle 0x0013, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: ASMedia SATA 6G
dmidecode: 	Type: SATA Controller
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:c5:00.0
dmidecode: 
dmidecode: Handle 0x0014, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Broadcom 10G Ethernet #1
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:c6:00.0
dmidecode: 
dmidecode: Handle 0x0015, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Broadcom 10G Ethernet #2
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 2
dmidecode: 	Bus Address: 0000:c6:00.1
dmidecode: 
dmidecode: Handle 0x0016, DMI type 38, 18 bytes
dmidecode: IPMI Device Information
dmidecode: 	Interface Type: KCS (Keyboard Control Style)
dmidecode: 	Specification Version: 2.0
dmidecode: 	I2C Slave Address: 0x10
dmidecode: 	NV Storage Device: Not Present
dmidecode: 	Base Address: 0x0000000000000CA2 (I/O)
dmidecode: 	Register Spacing: Successive Byte Boundaries
dmidecode: 
dmidecode: Handle 0x0017, DMI type 42, 17 bytes
dmidecode: Management Controller Host Interface
dmidecode: 	Host Interface Type: KCS: Keyboard Controller Style
dmidecode: 
dmidecode: Handle 0x0021, DMI type 15, 73 bytes
dmidecode: System Event Log
dmidecode: 	Area Length: 65535 bytes
dmidecode: 	Header Start Offset: 0x0000
dmidecode: 	Header Length: 16 bytes
dmidecode: 	Data Start Offset: 0x0010
dmidecode: 	Access Method: Memory-mapped physical 32-bit address
dmidecode: 	Access Address: 0xFF51B000
dmidecode: 	Status: Valid, Not Full
dmidecode: 	Change Token: 0x00000001
dmidecode: 	Header Format: Type 1
dmidecode: 	Supported Log Type Descriptors: 25
dmidecode: 	Descriptor 1: Single-bit ECC memory error
dmidecode: 	Data Format 1: Multiple-event handle
dmidecode: 	Descriptor 2: Multi-bit ECC memory error
dmidecode: 	Data Format 2: Multiple-event handle
dmidecode: 	Descriptor 3: Parity memory error
dmidecode: 	Data Format 3: Multiple-event handle
dmidecode: 	Descriptor 4: Bus timeout
dmidecode: 	Data Format 4: None
dmidecode: 	Descriptor 5: I/O channel block
dmidecode: 	Data Format 5: None
dmidecode: 	Descriptor 6: Software NMI
dmidecode: 	Data Format 6: None
dmidecode: 	Descriptor 7: POST memory resize
dmidecode: 	Data Format 7: None
dmidecode: 	Descriptor 8: POST error
dmidecode: 	Data Format 8: POST results bitmap
dmidecode: 	Descriptor 9: PCI parity error
dmidecode: 	Data Format 9: Multiple-event handle
dmidecode: 	Descriptor 10: PCI system error
dmidecode: 	Data Format 10: Multiple-event handle
dmidecode: 	Descriptor 11: CPU failure
dmidecode: 	Data Format 11: None
dmidecode: 	Descriptor 12: EISA failsafe timer timeout
dmidecode: 	Data Format 12: None
dmidecode: 	Descriptor 13: Correctable memory log disabled
dmidecode: 	Data Format 13: None
dmidecode: 	Descriptor 14: Logging disabled
dmidecode: 	Data Format 14: None
dmidecode: 	Descriptor 15: System limit exceeded
dmidecode: 	Data Format 15: None
dmidecode: 	Descriptor 16: Asynchronous hardware timer expired
dmidecode: 	Data Format 16: None
dmidecode: 	Descriptor 17: System configuration information
dmidecode: 	Data Format 17: None
dmidecode: 	Descriptor 18: Hard disk information
dmidecode: 	Data Format 18: None
dmidecode: 	Descriptor 19: System reconfigured
dmidecode: 	Data Format 19: None
dmidecode: 	Descriptor 20: Uncorrectable CPU-complex error
dmidecode: 	Data Format 20: None
dmidecode: 	Descriptor 21: Log area reset/cleared
dmidecode: 	Data Format 21: None
dmidecode: 	Descriptor 22: System boot
dmidecode: 	Data Format 22: None
dmidecode: 	Descriptor 23: End of log
dmidecode: 	Data Format 23: None
dmidecode: 	Descriptor 24: OEM-specific
dmidecode: 	Data Format 24: OEM-specific
dmidecode: 	Descriptor 25: OEM-specific
dmidecode: 	Data Format 25: OEM-specific
dmidecode: 
dmidecode: Handle 0x0022, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0023, DMI type 16, 23 bytes
dmidecode: Physical Memory Array
dmidecode: 	Location: System Board Or Motherboard
dmidecode: 	Use: System Memory
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	Maximum Capacity: 4 TB
dmidecode: 	Error Information Handle: 0x0022
dmidecode: 	Number Of Devices: 8
dmidecode: 
dmidecode: Handle 0x0024, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x000AFFFFFFF
dmidecode: 	Range Size: 2816 MB
dmidecode: 	Physical Array Handle: 0x0023
dmidecode: 	Partition Width: 8
dmidecode: 
dmidecode: Handle 0x0025, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x00100000000
dmidecode: 	Ending Address: 0x0204FFFFFFF
dmidecode: 	Range Size: 128256 MB
dmidecode: 	Physical Array Handle: 0x0023
dmidecode: 	Partition Width: 8
dmidecode: 
dmidecode: Handle 0x0026, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L1 Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 1
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 1 MB
dmidecode: 	Maximum Size: 1 MB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x0027, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L2 Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 2
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 8 MB
dmidecode: 	Maximum Size: 8 MB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x0028, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L3 Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 3
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 128 MB
dmidecode: 	Maximum Size: 128 MB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 16-way Set-associative
dmidecode: 
dmidecode: Handle 0x0029, DMI type 4, 48 bytes
dmidecode: Processor Information
dmidecode: 	Socket Designation: CPU
dmidecode: 	Type: Central Processor
dmidecode: 	Family: Zen
dmidecode: 	Manufacturer: Advanced Micro Devices, Inc.
dmidecode: 	ID: 10 0F 83 00 FF FB 8B 17
dmidecode: 	Signature: Family 23, Model 49, Stepping 0
dmidecode: 	Flags:
dmidecode: 		FPU (Floating-point unit on-chip)
dmidecode: 		VME (Virtual mode extension)
dmidecode: 		DE (Debugging extension)
dmidecode: 		PSE (Page size extension)
dmidecode: 		TSC (Time stamp counter)
dmidecode: 		MSR (Model specific registers)
dmidecode: 		PAE (Physical address extension)
dmidecode: 		MCE (Machine check exception)
dmidecode: 		CX8 (CMPXCHG8 instruction supported)
dmidecode: 		APIC (On-chip APIC hardware supported)
dmidecode: 		SEP (Fast system call)
dmidecode: 		MTRR (Memory type range registers)
dmidecode: 		PGE (Page global enable)
dmidecode: 		MCA (Machine check architecture)
dmidecode: 		CMOV (Conditional move instruction supported)
dmidecode: 		PAT (Page attribute table)
dmidecode: 		PSE-36 (36-bit page size extension)
dmidecode: 		CLFSH (CLFLUSH instruction supported)
dmidecode: 		MMX (MMX technology supported)
dmidecode: 		FXSR (FXSAVE and FXSTOR instructions supported)
dmidecode: 		SSE (Streaming SIMD extensions)
dmidecode: 		SSE2 (Streaming SIMD extensions 2)
dmidecode: 		HTT (Multi-threading)
dmidecode: 	Version: AMD EPYC 7302P 16-Core Processor               
dmidecode: 	Voltage: 1.1 V
dmidecode: 	External Clock: 100 MHz
dmidecode: 	Max Speed: 3300 MHz
dmidecode: 	Current Speed: 3000 MHz
dmidecode: 	Status: Populated, Enabled
dmidecode: 	Upgrade: Socket SP3
dmidecode: 	L1 Cache Handle: 0x0026
dmidecode: 	L2 Cache Handle: 0x0027
dmidecode: 	L3 Cache Handle: 0x0028
dmidecode: 	Serial Number: Unknown
dmidecode: 	Asset Tag: Unknown
dmidecode: 	Part Number: Unknown
dmidecode: 	Core Count: 16
dmidecode: 	Core Enabled: 16
dmidecode: 	Thread Count: 32
dmidecode: 	Characteristics:
dmidecode: 		64-bit capable
dmidecode: 		Multi-Core
dmidecode: 		Hardware Thread
dmidecode: 		Execute Protection
dmidecode: 		Enhanced Virtualization
dmidecode: 		Power/Performance Control
dmidecode: 
dmidecode: Handle 0x002A, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x002B, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x002A
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMA1
dmidecode: 	Bank Locator: P0_Node0_Channel0_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441D50B
dmidecode: 	Asset Tag: DIMMA1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x002C, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x003FFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x002B
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x002D, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x002E, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x002D
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMB1
dmidecode: 	Bank Locator: P0_Node0_Channel1_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441E06A
dmidecode: 	Asset Tag: DIMMB1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x002F, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00400000000
dmidecode: 	Ending Address: 0x007FFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x002E
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0030, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0031, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x0030
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMC1
dmidecode: 	Bank Locator: P0_Node0_Channel2_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441D9AA
dmidecode: 	Asset Tag: DIMMC1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0032, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00C00000000
dmidecode: 	Ending Address: 0x00FFFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x0031
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0033, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0034, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x0033
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMD1
dmidecode: 	Bank Locator: P0_Node0_Channel3_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441D9CF
dmidecode: 	Asset Tag: DIMMD1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0035, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00800000000
dmidecode: 	Ending Address: 0x00BFFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x0034
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0036, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0037, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x0036
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMME1
dmidecode: 	Bank Locator: P0_Node0_Channel4_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441E069
dmidecode: 	Asset Tag: DIMME1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0038, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x01800000000
dmidecode: 	Ending Address: 0x01BFFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x0037
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0039, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x003A, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x0039
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMF1
dmidecode: 	Bank Locator: P0_Node0_Channel5_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441E05D
dmidecode: 	Asset Tag: DIMMF1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x003B, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x01C00000000
dmidecode: 	Ending Address: 0x01FFFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x003A
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x003C, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x003D, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x003C
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMG1
dmidecode: 	Bank Locator: P0_Node0_Channel6_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441DC90
dmidecode: 	Asset Tag: DIMMG1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x003E, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x01400000000
dmidecode: 	Ending Address: 0x017FFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x003D
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x003F, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0040, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0023
dmidecode: 	Error Information Handle: 0x003F
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMMH1
dmidecode: 	Bank Locator: P0_Node0_Channel7_Dimm0
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 3200 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 4441E05B
dmidecode: 	Asset Tag: DIMMH1_AssetTag (date:42/00)
dmidecode: 	Part Number: M393A2K43DB3-CWE    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 3200 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: M393A2K43DB3-CWE    
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0041, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x01000000000
dmidecode: 	Ending Address: 0x013FFFFFFFF
dmidecode: 	Range Size: 16 GB
dmidecode: 	Physical Device Handle: 0x0040
dmidecode: 	Memory Array Mapped Address Handle: 0x0025
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0042, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: RSC-W-66G4 SLOT1 PCI-E 4.0 X16
dmidecode: 	Type: x16 PCI Express 4 x16
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Long
dmidecode: 	ID: 1
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:41:00.0
dmidecode: 
dmidecode: Handle 0x0043, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: RSC-W-66G4 SLOT2 PCI-E 4.0 X16
dmidecode: 	Type: x16 PCI Express 4 x16
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Long
dmidecode: 	ID: 2
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:ff:00.0
dmidecode: 
dmidecode: Handle 0x0044, DMI type 130, 46 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		82 2E 44 00 00 00 00 00 00 00 01 00 00 00 00 01
dmidecode: 		20 20 22 24 26 28 2A 2C 00 00 00 00 00 00 00 00
dmidecode: 		10 10 00 00 01 02 10 10 02 03 E0 E0 04 05
dmidecode: 	Strings:
dmidecode: 		RSC-W-66G4
dmidecode: 		SLOT1 PCI-E 4.0 X16
dmidecode: 		SLOT2 PCI-E 4.0 X16
dmidecode: 
dmidecode: Handle 0x0045, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: RSC-WR-6 SLOT1 PCI-E 4.0 X16
dmidecode: 	Type: x16 PCI Express 4 x16
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Long
dmidecode: 	ID: 1
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:ff:00.0
dmidecode: 
dmidecode: Handle 0x0046, DMI type 130, 39 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		82 27 46 00 00 00 00 00 00 00 02 00 00 00 00 01
dmidecode: 		10 20 21 22 23 24 25 26 00 00 00 00 00 00 00 00
dmidecode: 		10 00 01 10 02 00 00
dmidecode: 	Strings:
dmidecode: 		RSC-WR-6
dmidecode: 		SLOT1 PCI-E 4.0 X16
dmidecode: 
dmidecode: Handle 0x0047, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x000a
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x0048, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x000b
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x0049, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0042
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004A, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0043
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004B, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0045
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004C, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0010
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004D, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0011
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004E, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0012
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x004F, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0013
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x0050, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0014
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x0051, DMI type 40, 27 bytes
dmidecode: Additional Information 1
dmidecode: 	Referenced Handle: 0x0015
dmidecode: 	Referenced Offset: 0x00
dmidecode: 	String: Not Specified
dmidecode: 	Value: Unexpected size
dmidecode: 
dmidecode: Handle 0x0052, DMI type 199, 5 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C7 05 52 00 01
dmidecode: 	Strings:
dmidecode: 		                                                                                                                                                                                                                                                         
dmidecode: 
dmidecode: Handle 0x0053, DMI type 127, 4 bytes
dmidecode: End Of Table
dmidecode: 
