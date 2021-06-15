Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE463A74F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFODWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhFODWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623727215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3yZVN4ljJYUzZcm7+4UNi5dVO+02pPtYO5V/2nittg=;
        b=EJkuna3Hfwp7FlkB0cbXSKt7iyoJ7+t5GWKAEoKoAI1ljNk5KWu+sLLjwUvSF1OiUe+2Kr
        qmGeuHWdIVug44Lvfm/qClYZMdCP15fKX5sUp0eTsFETJljNIL4gZw9r4RaKw/uCeBEa32
        t5Y0f0DBc2ns9sUVQp9ArxFjAwg20Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-AHNj-ibaO5eP8H-cGAaa6A-1; Mon, 14 Jun 2021 23:20:14 -0400
X-MC-Unique: AHNj-ibaO5eP8H-cGAaa6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A9514EE;
        Tue, 15 Jun 2021 03:20:13 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-254.pek2.redhat.com [10.72.12.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9D3A60CCC;
        Tue, 15 Jun 2021 03:20:06 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:20:03 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
Message-ID: <20210615032003.GB4301@dhcp-128-65.nay.redhat.com>
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
 <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
 <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
 <CA+QYu4rF6Bx5OwLzBSam_VXJ6gWqSjTocxTNxanfHuV5nZuzrA@mail.gmail.com>
 <4434f245-db3b-c02a-36c4-0111a0dfb78d@rasmusvillemoes.dk>
 <CA+QYu4q4HBCRo_e9i0WZ2mvm0w2xRC5RkPDQ4h=r9ybOtNXqWg@mail.gmail.com>
 <CA+QYu4pMHaUna48RJtn2cBZD0bHjoQEQcdrUKZbHT0-cm7g4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4pMHaUna48RJtn2cBZD0bHjoQEQcdrUKZbHT0-cm7g4Zw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruno,

[cced kexec and petiboot list]
On 06/14/21 at 10:03am, Bruno Goncalves wrote:
> On Mon, Jun 14, 2021 at 7:47 AM Bruno Goncalves <bgoncalv@redhat.com> wrote:
> >
> > On Fri, Jun 11, 2021 at 11:49 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > >
> > > On 11/06/2021 17.06, Bruno Goncalves wrote:
> > > > On Fri, Jun 11, 2021 at 9:13 AM Rasmus Villemoes
> > > > <linux@rasmusvillemoes.dk> wrote:
> > > >>
> > > >> On 10/06/2021 17.14, Bruno Goncalves wrote:
> > > >>> On Thu, Jun 10, 2021 at 3:02 PM Rasmus Villemoes
> > > >>> <linux@rasmusvillemoes.dk> wrote:
> > > >>>>
> > > >>>> On 10/06/2021 13.47, Bruno Goncalves wrote:
> > > >>>>> Hello,
> > > >>>>>
> > > >>>>> We've observed in some cases kernel panic when trying to boot on
> > > >>>>> ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
> > > >>>>> could be related to patch
> > > >>>>> https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
> > > >>>>>
> > > >>>>
> > > >>>> Thanks for the report. It's possible, but I'll need some help from you
> > > >>>> to get more info.
> > > >>>>
> > > >>>> First, can you send me the .config?
> > > >>>
> > > >>> The .config is on
> > > >>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/kernel-block-ppc64le-d3f02e52f5548006f04358d407bbb7fe51255c41.config
> > > >>
> > > >> Thanks.
> > > >>
> > > >>>>
> > > >>>>>
> > > >>>>> [    1.516075] wait_for_initramfs() called before rootfs_initcalls
> > > >>>>
> > > >>>> This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
> > > >>>> non-empty path (/sbin/hotplug perhaps). This did get reported once before:
> > > >>>>
> > > >>>
> > > >>> CONFIG_UEVENT_HELPER_PATH is not set. In the .config we have "#
> > > >>> CONFIG_UEVENT_HELPER is not set"
> > > >>
> > > >> OK. Then I assume some quite early initcall does a request_module() or
> > > >> request_firmware() (or similar). I don't think this matters - that call
> > > >> would be done before the initramfs was unpacked with or without my
> > > >> patch, so it won't find anything in the empty rootfs. It's just my patch
> > > >> added a note. But just to figure out where that triggers, can you do
> > > >>
> > > >> -               pr_warn_once("wait_for_initramfs() called before
> > > >> rootfs_initcalls\n");
> > > >> +               WARN_ONCE(1, "wait_for_initramfs() called before
> > > >> rootfs_initcalls\n");
> > > >>
> > > >> in init/initramfs.c.
> > > >>
> > > >
> > > > I've managed to reproduce the panic with the patch.
> > > >
> > > > [    1.498654] NIP [c0000000000137d4] wait_for_initramfs+0x94/0xa4
> > > > [    1.498661] LR [c0000000000137d0] wait_for_initramfs+0x90/0xa4
> > > > [    1.498668] Call Trace:
> > > > [    1.498671] [c000000027debd60] [c0000000000137d0]
> > > > wait_for_initramfs+0x90/0xa4 (unreliable)
> > > > [    1.498680] [c000000027debdc0] [c000000000172fc8]
> > > > call_usermodehelper_exec_async+0x178/0x2c0
> > > > [    1.498691] [c000000027debe10] [c00000000000d6ec]
> > > > ret_from_kernel_thread+0x5c/0x70
> > >
> > > Thanks, but unfortunately (and I should have known better) that doesn't
> > > tell us who actually initated that call_usermodehelper - it's most
> > > likely some request_module() call. But again, I don't think this is
> > > related to the later crash.
> > >
> > > >>>>> [    1.764430] Initramfs unpacking failed: no cpio magic
> > > >>>>
> > > >>>> Whoa, that's not good. Did something scramble over the initramfs memory
> > > >>>> while it was being unpacked? It's been .2 seconds since the start of the
> > > >>>> unpacking, so it's unlikely the very beginning of the initramfs is corrupt.
> > > >>>>
> > > >>>> Can you try booting with initramfs_async=0 on the command line and see
> > > >>>> if the kernel still crashes?
> > > >
> > > > Using initramfs_async=0 I was also able to reproduce the panic.
> > >
> > > Hm, that's very interesting. Can you share the log for that as well?
> >
> > [    0.000000] Kernel command line:
> > root=UUID=72f391f6-e71f-41a6-ba16-2c25460203ed ro initramfs_async=0
> > [    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
> > [    0.000000] printk: log_buf_len total cpu_extra contributions: 782336 bytes
> > [    0.000000] printk: log_buf_len min size: 262144 bytes
> > [    0.000000] printk: log_buf_len: 1048576 bytes
> > [    0.000000] printk: early log buf free: 253968(96%)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Memory: 1017540928K/1073741824K available (17472K
> > kernel code, 3072K rwdata, 4992K rodata, 5760K init, 1818K bss,
> > 2510528K reserved, 53690368K cma-reserved)
> > [    0.000000] random: get_random_u64 called from
> > __kmem_cache_create+0x3c/0x770 with crng_init=0
> > <snip>
> > [    1.366341] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
> > [    1.366348] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
> > [    1.560635] alg: No test for 842 (842-generic)
> > [    1.560677] alg: No test for 842 (842-scomp)
> > [    1.560824] wait_for_initramfs() called before rootfs_initcalls
> > [    1.565123] raid6: skip pq benchmark and using algorithm vpermxor8
> > [    1.565132] raid6: using intx1 recovery algorithm
> > [    1.565318] iommu: Default domain type: Translated
> > [    1.565402] vgaarb: loaded
> > [    1.565663] SCSI subsystem initialized
> > [    1.565829] usbcore: registered new interface driver usbfs
> > [    1.565841] usbcore: registered new interface driver hub
> > [    1.565917] usbcore: registered new device driver usb
> > [    1.565944] pps_core: LinuxPPS API ver. 1 registered
> > [    1.565949] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> > Rodolfo Giometti <giometti@linux.it>
> > [    1.565957] PTP clock support registered
> > [    1.566137] EDAC MC: Ver: 3.0.0
> > [    1.566551] NetLabel: Initializing
> > [    1.566555] NetLabel:  domain hash size = 128
> > [    1.566559] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> > [    1.566578] NetLabel:  unlabeled traffic allowed by default
> > [    1.568021] clocksource: Switched to clocksource timebase
> > [    1.591752] VFS: Disk quotas dquot_6.6.0
> > [    1.591918] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> > [    1.594487] NET: Registered protocol family 2
> > [    1.594673] IP idents hash table entries: 262144 (order: 5, 2097152
> > bytes, vmalloc)
> > [    1.600286] tcp_listen_portaddr_hash hash table entries: 65536
> > (order: 4, 1048576 bytes, vmalloc)
> > [    1.600585] TCP established hash table entries: 524288 (order: 6,
> > 4194304 bytes, vmalloc)
> > [    1.601814] TCP bind hash table entries: 65536 (order: 4, 1048576
> > bytes, vmalloc)
> > [    1.601991] TCP: Hash tables configured (established 524288 bind 65536)
> > [    1.602677] MPTCP token hash table entries: 65536 (order: 4,
> > 1572864 bytes, vmalloc)
> > [    1.602943] UDP hash table entries: 65536 (order: 5, 2097152 bytes, vmalloc)
> > [    1.603347] UDP-Lite hash table entries: 65536 (order: 5, 2097152
> > bytes, vmalloc)
> > [    1.604431] NET: Registered protocol family 1
> > [    1.604443] NET: Registered protocol family 44
> > [    1.604571] pci 0005:03:00.0: enabling device (0140 -> 0142)
> > [    1.604656] PCI: CLS 128 bytes, default 128
> > [    1.604850] Trying to unpack rootfs image as initramfs...
> > [    1.774342] Initramfs unpacking failed: no cpio magic
> > [    1.775307] Freeing initrd memory: 18176K
> > [    1.775594] rtas_flash: no firmware flash support
> > [    1.780166] Initialise system trusted keyrings
> > [    1.780190] Key type blacklist registered
> > [    1.780364] workingset: timestamp_bits=38 max_order=24 bucket_order=0
> > [    1.782469] zbud: loaded
> > [    1.825156] NET: Registered protocol family 38
> > [    1.825169] xor: measuring software checksum speed
> > [    1.825925]    8regs           : 13170 MB/sec
> > [    1.826748]    8regs_prefetch  : 12031 MB/sec
> > [    1.827473]    32regs          : 13662 MB/sec
> > [    1.828249]    32regs_prefetch : 12820 MB/sec
> > [    1.828635]    altivec         : 25906 MB/sec
> > [    1.828639] xor: using function: altivec (25906 MB/sec)
> > [    1.828645] Key type asymmetric registered
> > [    1.828649] Asymmetric key parser 'x509' registered
> > [    1.828661] Block layer SCSI generic (bsg) driver version 0.4
> > loaded (major 245)
> > [    1.828820] io scheduler mq-deadline registered
> > [    1.828825] io scheduler kyber registered
> > [    1.828932] io scheduler bfq registered
> > [    1.831304] atomic64_test: passed
> > [    1.832070] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > [    1.832277] hvc0: raw protocol on /ibm,opal/consoles/serial@0 (boot console)
> > [    1.832527] hvc1: hvsi protocol on /ibm,opal/consoles/serial@1
> > [    1.832555] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> > [    1.834347] Non-volatile memory driver v1.3
> > [    1.836184] libphy: Fixed MDIO Bus: probed
> > [    1.836295] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > [    1.836311] ehci-pci: EHCI PCI platform driver
> > [    1.836325] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > [    1.836342] ohci-pci: OHCI PCI platform driver
> > [    1.836356] uhci_hcd: USB Universal Host Controller Interface driver
> > [    1.836523] xhci_hcd 0005:03:00.0: xHCI Host Controller
> > [    1.836635] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
> > bus number 1
> > [    1.836788] xhci_hcd 0005:03:00.0: hcc params 0x0270f06d hci
> > version 0x96 quirks 0x0000000004000000
> > [    1.837236] usb usb1: New USB device found, idVendor=1d6b,
> > idProduct=0002, bcdDevice= 5.13
> > [    1.837245] usb usb1: New USB device strings: Mfr=3, Product=2,
> > SerialNumber=1
> > [    1.837252] usb usb1: Product: xHCI Host Controller
> > [    1.837257] usb usb1: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
> > [    1.837263] usb usb1: SerialNumber: 0005:03:00.0
> > [    1.837418] hub 1-0:1.0: USB hub found
> > [    1.837433] hub 1-0:1.0: 4 ports detected
> > [    1.837605] xhci_hcd 0005:03:00.0: xHCI Host Controller
> > [    1.837662] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
> > bus number 2
> > [    1.837679] xhci_hcd 0005:03:00.0: Host supports USB 3.0 SuperSpeed
> > [    1.837710] usb usb2: We don't know the algorithms for LPM for this
> > host, disabling LPM.
> > [    1.837742] usb usb2: New USB device found, idVendor=1d6b,
> > idProduct=0003, bcdDevice= 5.13
> > [    1.837750] usb usb2: New USB device strings: Mfr=3, Product=2,
> > SerialNumber=1
> > [    1.837756] usb usb2: Product: xHCI Host Controller
> > [    1.837761] usb usb2: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
> > [    1.837767] usb usb2: SerialNumber: 0005:03:00.0
> > [    1.837884] hub 2-0:1.0: USB hub found
> > [    1.837897] hub 2-0:1.0: 4 ports detected
> > [    1.838074] usbcore: registered new interface driver usbserial_generic
> > [    1.838086] usbserial: USB Serial support registered for generic
> > [    1.838123] mousedev: PS/2 mouse device common for all mice
> > [    1.841900] device-mapper: uevent: version 1.0.3
> > [    1.842050] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
> > initialised: dm-devel@redhat.com
> > [    1.842352] powernv-cpufreq: cpufreq pstate min 0xffffffda nominal
> > 0xfffffff7 max 0x0
> > [    1.842358] powernv-cpufreq: Workload Optimized Frequency is
> > disabled in the platform
> > [    1.847336] hid: raw HID events driver (C) Jiri Kosina
> > [    1.847386] usbcore: registered new interface driver usbhid
> > [    1.847391] usbhid: USB HID core driver
> > [    1.847646] drop_monitor: Initializing network drop monitor service
> > [    1.847817] Initializing XFRM netlink socket
> > [    1.848236] NET: Registered protocol family 10
> > [    1.861274] Segment Routing with IPv6
> > [    1.861288] RPL Segment Routing with IPv6
> > [    1.861313] mip6: Mobile IPv6
> > [    1.861318] NET: Registered protocol family 17
> > [    1.861392] secvar-sysfs: secvar: failed to retrieve secvar operations.
> > [    1.861424] drmem: No dynamic reconfiguration memory found
> > [    1.861631] registered taskstats version 1
> > [    1.861650] Loading compiled-in X.509 certificates
> > [    1.862965] Loaded X.509 cert 'Build time autogenerated kernel key:
> > 97604d93c367cf27b215cdfd062467d582f7e126'
> > [    1.864430] zswap: loaded using pool lzo/zbud
> > [    1.864634] debug_vm_pgtable: [debug_vm_pgtable         ]:
> > Validating architecture page table helpers
> > [    1.865112] Key type ._fscrypt registered
> > [    1.865118] Key type .fscrypt registered
> > [    1.865124] Key type fscrypt-provisioning registered
> > [    1.866849] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
> > [    1.866898] pstore: Using crash dump compression: deflate
> > [    1.867485] Key type encrypted registered
> > [    1.867690] Secure boot mode disabled
> > [    1.867725] ima: No TPM chip found, activating TPM-bypass!
> > [    1.867735] Loading compiled-in module X.509 certificates
> > [    1.869037] Loaded X.509 cert 'Build time autogenerated kernel key:
> > 97604d93c367cf27b215cdfd062467d582f7e126'
> > [    1.869049] ima: Allocated hash algorithm: sha256
> > [    1.869223] Secure boot mode disabled
> > [    1.869378] Trusted boot mode disabled
> > [    1.869385] ima: No architecture policies found
> > [    1.869411] evm: Initialising EVM extended attributes:
> > [    1.869418] evm: security.selinux
> > [    1.869423] evm: security.ima
> > [    1.869428] evm: security.capability
> > [    1.869433] evm: HMAC attrs: 0x1
> > [    1.872544] Freeing unused kernel memory: 5760K
> > [    1.872555] Kernel memory protection not selected by kernel config.
> > [    1.872566] Run /init as init process
> > [    1.872706] Failed to execute /init (error -2)
> > [    1.872713] Run /sbin/init as init process
> > [    1.872755] Run /etc/init as init process
> > [    1.872794] Run /bin/init as init process
> > [    1.872834] Run /bin/sh as init process
> > [    1.872891] Kernel panic - not syncing: No working init found.  Try
> > passing init= option to kernel. See Linux
> > Documentation/admin-guide/init.rst for guidance.
> > [    1.872906] CPU: 42 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc3 #1
> > [    1.872917] Call Trace:
> > [    1.872922] [c0000080010d7cc0] [c0000000009f2640]
> > dump_stack+0xc4/0x114 (unreliable)
> > [    1.872939] [c0000080010d7d10] [c00000000014b9e0] panic+0x168/0x408
> > [    1.872952] [c0000080010d7da0] [c000000000012964] kernel_init+0x14c/0x168
> > [    1.872964] [c0000080010d7e10] [c00000000000d6ec]
> > ret_from_kernel_thread+0x5c/0x70
> >
> > >
> > > And, perhaps asking a silly question, does the crash go away if you
> > > revert e7cb072eb988e46295512617c39d004f9e1c26f8 ?
> 
> Okay, indeed the problem is not with this commit , I've just hit the
> panic with reverted commit.
> 
> [    1.302017] EEH: Capable adapter found: recovery enabled.
> [    1.308206] opal-power: OPAL EPOW, DPO support detected.
> [    1.308866] powernv-rng: Registering arch random hook.
> [    1.310984] Kprobes globally optimized
> [    1.311466] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
> [    1.311473] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
> [    1.505658] alg: No test for 842 (842-generic)
> [    1.505699] alg: No test for 842 (842-scomp)
> [    1.510121] raid6: skip pq benchmark and using algorithm vpermxor8
> [    1.510128] raid6: using intx1 recovery algorithm
> [    1.510314] iommu: Default domain type: Translated
> [    1.510402] vgaarb: loaded
> [    1.510579] SCSI subsystem initialized
> [    1.510732] usbcore: registered new interface driver usbfs
> [    1.510745] usbcore: registered new interface driver hub
> [    1.510803] usbcore: registered new device driver usb
> [    1.510829] pps_core: LinuxPPS API ver. 1 registered
> [    1.510834] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    1.510843] PTP clock support registered
> [    1.511011] EDAC MC: Ver: 3.0.0
> [    1.511399] NetLabel: Initializing
> [    1.511404] NetLabel:  domain hash size = 128
> [    1.511408] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    1.511427] NetLabel:  unlabeled traffic allowed by default
> [    1.512949] clocksource: Switched to clocksource timebase
> [    1.536237] VFS: Disk quotas dquot_6.6.0
> [    1.536380] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> [    1.538890] NET: Registered protocol family 2
> [    1.539074] IP idents hash table entries: 262144 (order: 5, 2097152
> bytes, vmalloc)
> [    1.544621] tcp_listen_portaddr_hash hash table entries: 65536
> (order: 4, 1048576 bytes, vmalloc)
> [    1.544887] TCP established hash table entries: 524288 (order: 6,
> 4194304 bytes, vmalloc)
> [    1.546117] TCP bind hash table entries: 65536 (order: 4, 1048576
> bytes, vmalloc)
> [    1.546298] TCP: Hash tables configured (established 524288 bind 65536)
> [    1.546993] MPTCP token hash table entries: 65536 (order: 4,
> 1572864 bytes, vmalloc)
> [    1.547255] UDP hash table entries: 65536 (order: 5, 2097152 bytes, vmalloc)
> [    1.547648] UDP-Lite hash table entries: 65536 (order: 5, 2097152
> bytes, vmalloc)
> [    1.548726] NET: Registered protocol family 1
> [    1.548739] NET: Registered protocol family 44
> [    1.548864] pci 0005:03:00.0: enabling device (0140 -> 0142)
> [    1.548936] PCI: CLS 128 bytes, default 128
> [    1.549005] Trying to unpack rootfs image as initramfs...
> [    1.723810] Initramfs unpacking failed: junk within compressed archive

This sounds similar to an old bug we had on Amazon instances which was
fixed below commit:
commit 428c491332bca498c8eb2127669af51506c346c7
Author: Guilherme G. Piccoli <gpiccoli@canonical.com>
Date:   Fri Mar 20 09:55:34 2020 -0300

    net: ena: Add PCI shutdown handler to allow safe kexec

I think it would helpful if petiboot people can do some debugging to see
if anything wrong happened on the petiboot kernel/drivers.


> [    1.725056] Freeing initrd memory: 20992K
> [    1.725342] rtas_flash: no firmware flash support
> [    1.729768] Initialise system trusted keyrings
> [    1.729792] Key type blacklist registered
> [    1.729965] workingset: timestamp_bits=38 max_order=24 bucket_order=0
> [    1.732064] zbud: loaded
> [    1.775945] NET: Registered protocol family 38
> [    1.775963] xor: measuring software checksum speed
> [    1.776740]    8regs           : 13166 MB/sec
> [    1.777564]    8regs_prefetch  : 12024 MB/sec
> [    1.778289]    32regs          : 13652 MB/sec
> [    1.779061]    32regs_prefetch : 12819 MB/sec
> [    1.779447]    altivec         : 25821 MB/sec
> [    1.779452] xor: using function: altivec (25821 MB/sec)
> [    1.779457] Key type asymmetric registered
> [    1.779462] Asymmetric key parser 'x509' registered
> [    1.779495] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 245)
> [    1.779652] io scheduler mq-deadline registered
> [    1.779657] io scheduler kyber registered
> [    1.779790] io scheduler bfq registered
> [    1.782225] atomic64_test: passed
> [    1.783089] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.783314] hvc0: raw protocol on /ibm,opal/consoles/serial@0 (boot console)
> [    1.783555] hvc1: hvsi protocol on /ibm,opal/consoles/serial@1
> [    1.783582] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.785366] Non-volatile memory driver v1.3
> [    1.787231] libphy: Fixed MDIO Bus: probed
> [    1.787345] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.787360] ehci-pci: EHCI PCI platform driver
> [    1.787374] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.787391] ohci-pci: OHCI PCI platform driver
> [    1.787404] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.787580] xhci_hcd 0005:03:00.0: xHCI Host Controller
> [    1.787693] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
> bus number 1
> [    1.787844] xhci_hcd 0005:03:00.0: hcc params 0x0270f06d hci
> version 0x96 quirks 0x0000000004000000
> [    1.788305] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002, bcdDevice= 5.13
> [    1.788314] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.788322] usb usb1: Product: xHCI Host Controller
> [    1.788327] usb usb1: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
> [    1.788333] usb usb1: SerialNumber: 0005:03:00.0
> [    1.788498] hub 1-0:1.0: USB hub found
> [    1.788514] hub 1-0:1.0: 4 ports detected
> [    1.788685] xhci_hcd 0005:03:00.0: xHCI Host Controller
> [    1.788745] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
> bus number 2
> [    1.788763] xhci_hcd 0005:03:00.0: Host supports USB 3.0 SuperSpeed
> [    1.788787] usb usb2: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    1.788819] usb usb2: New USB device found, idVendor=1d6b,
> idProduct=0003, bcdDevice= 5.13
> [    1.788827] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.788834] usb usb2: Product: xHCI Host Controller
> [    1.788839] usb usb2: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
> [    1.788845] usb usb2: SerialNumber: 0005:03:00.0
> [    1.788961] hub 2-0:1.0: USB hub found
> [    1.788974] hub 2-0:1.0: 4 ports detected
> [    1.789146] usbcore: registered new interface driver usbserial_generic
> [    1.789157] usbserial: USB Serial support registered for generic
> [    1.789196] mousedev: PS/2 mouse device common for all mice
> [    1.793122] device-mapper: uevent: version 1.0.3
> [    1.793282] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
> initialised: dm-devel@redhat.com
> [    1.793588] powernv-cpufreq: cpufreq pstate min 0xffffffda nominal
> 0xfffffff7 max 0x0
> [    1.793595] powernv-cpufreq: Workload Optimized Frequency is
> disabled in the platform
> [    1.798302] hid: raw HID events driver (C) Jiri Kosina
> [    1.798344] usbcore: registered new interface driver usbhid
> [    1.798349] usbhid: USB HID core driver
> [    1.798600] drop_monitor: Initializing network drop monitor service
> [    1.798750] Initializing XFRM netlink socket
> [    1.799148] NET: Registered protocol family 10
> [    1.811611] Segment Routing with IPv6
> [    1.811627] RPL Segment Routing with IPv6
> [    1.811653] mip6: Mobile IPv6
> [    1.811658] NET: Registered protocol family 17
> [    1.811729] secvar-sysfs: secvar: failed to retrieve secvar operations.
> [    1.811761] drmem: No dynamic reconfiguration memory found
> [    1.811937] registered taskstats version 1
> [    1.811955] Loading compiled-in X.509 certificates
> [    1.812905] Loaded X.509 cert 'Build time autogenerated kernel key:
> 5a49ad3d49566246c5ef57be0cf7d450502ed699'
> [    1.813953] zswap: loaded using pool lzo/zbud
> [    1.814131] debug_vm_pgtable: [debug_vm_pgtable         ]:
> Validating architecture page table helpers
> [    1.814498] Key type ._fscrypt registered
> [    1.814503] Key type .fscrypt registered
> [    1.814506] Key type fscrypt-provisioning registered
> [    1.815660] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
> [    1.815695] pstore: Using crash dump compression: deflate
> [    1.816338] Key type encrypted registered
> [    1.816484] Secure boot mode disabled
> [    1.816490] ima: No TPM chip found, activating TPM-bypass!
> [    1.816496] Loading compiled-in module X.509 certificates
> [    1.817293] Loaded X.509 cert 'Build time autogenerated kernel key:
> 5a49ad3d49566246c5ef57be0cf7d450502ed699'
> [    1.817300] ima: Allocated hash algorithm: sha256
> [    1.817409] Secure boot mode disabled
> [    1.817506] Trusted boot mode disabled
> [    1.817510] ima: No architecture policies found
> [    1.817525] evm: Initialising EVM extended attributes:
> [    1.817529] evm: security.selinux
> [    1.817532] evm: security.ima
> [    1.817535] evm: security.capability
> [    1.817539] evm: HMAC attrs: 0x1
> [    1.819569] Freeing unused kernel memory: 5760K
> [    1.819575] Kernel memory protection not selected by kernel config.
> [    1.819583] Run /init as init process
> [    1.819652] Failed to execute /init (error -2)
> [    1.819658] Run /sbin/init as init process
> [    1.819684] Run /etc/init as init process
> [    1.819710] Run /bin/init as init process
> [    1.819738] Run /bin/sh as init process
> [    1.819777] Kernel panic - not syncing: No working init found.  Try
> passing init= option to kernel. See Linux
> Documentation/admin-guide/init.rst for guidance.
> [    1.819787] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc3 #1
> [    1.819794] Call Trace:
> [    1.819796] [c0000040010e3cc0] [c0000000009f25c0]
> dump_stack+0xc4/0x114 (unreliable)
> [    1.819809] [c0000040010e3d10] [c00000000014b960] panic+0x168/0x408
> [    1.819818] [c0000040010e3da0] [c000000000012964] kernel_init+0x14c/0x168
> [    1.819825] [c0000040010e3e10] [c00000000000d6ec]
> ret_from_kernel_thread+0x5c/0x70
> [    1.835866] ---[ end Kernel panic - not syncing: No working init
> found.  Try passing init= option to kernel. See Linux
> Documentation/admin-guide/init.rst for guidance. ]
> 
> Bruno
> >
> > Sure, I'll try it and let you know.
> >
> > Bruno
> >
> > >
> > > Thanks,
> > > Rasmus
> > >
> 

Thanks
Dave

