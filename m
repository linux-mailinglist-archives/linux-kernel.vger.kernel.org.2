Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF453A44A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKPIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhFKPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623424006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hWOyCAfakgu6MZTZWMctopfZ7mqOTwEbTigc4QSocM=;
        b=D97/Y0KrLKcneuvPyuJtFlZB/UVw5gsBHZuezKxO297jJOFZgLqol/y3DgRGEPw67Lb1bh
        ElSESX5vygjnRexq52Imq/egw94lvJduwDy9/jBFq9pNknshoRP0naw1Xj5cbCaZzJsGFh
        R7kVtMB0QZwm6CtlW6hsy13q4urF4Hs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-Y8iUZT1EOUGhJW2fWXeLmg-1; Fri, 11 Jun 2021 11:06:44 -0400
X-MC-Unique: Y8iUZT1EOUGhJW2fWXeLmg-1
Received: by mail-ot1-f72.google.com with SMTP id z17-20020a9d46910000b02903fb81caa138so2057931ote.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hWOyCAfakgu6MZTZWMctopfZ7mqOTwEbTigc4QSocM=;
        b=ubHosYGtGbPvDJlVnwZ+YrQCdBX4jH6Fw/6TeKv2FXoVAO5GOLONIg1wdOJ+aVFZtf
         DzCopTlJ6P56Q1ENx+R2nuAmNzhkvN5GA9p2hnB9VdT3g16g1XYfxa2FsJET7pVvT0dm
         oKlyDAvVFzuhOot/pCOTvjZ0iEEr5DAqrqSs3H+PDTlbY0d8I7boQ9O0IgGFSDOVgofs
         sqTbD/Vx5arLEObz7C7nq/mdmfpEgXEwp984hkSotHkk6FIj1vhe79Rb3Wxc06liO3J7
         YEiX54ilpK8ifdkfkU7sqsTVrWUF09rTraZErjL2sXo5GEpVXcZUjj51/ilOEkahbhki
         02Tg==
X-Gm-Message-State: AOAM532ey4HGK2sNFBvAmHz3Tvz/54UqQbt6DaEiobBgOatTM40gdm3M
        hjCqH1AR3RmHzVyfwezQjP71hnoizjUrvsrfq5fBzUHKLXnbDDRL+S+oRMkYnVz4IgH5nupyJFs
        Dh/tcYKXw0iKRCTSwq2fKqnPL6+BHcNAmhTMH1p08
X-Received: by 2002:aca:3285:: with SMTP id y127mr2799550oiy.115.1623424003624;
        Fri, 11 Jun 2021 08:06:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydTzLgouJ0ufOdPoScQ4lJW1ullIKZOqb8Xk6RBzcilgAY7fGyLGeZ36/rNxBIj+2LJc90olg36Kt8y+zj47U=
X-Received: by 2002:aca:3285:: with SMTP id y127mr2799528oiy.115.1623424003344;
 Fri, 11 Jun 2021 08:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk> <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
 <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
In-Reply-To: <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 11 Jun 2021 17:06:32 +0200
Message-ID: <CA+QYu4rF6Bx5OwLzBSam_VXJ6gWqSjTocxTNxanfHuV5nZuzrA@mail.gmail.com>
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 9:13 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 10/06/2021 17.14, Bruno Goncalves wrote:
> > On Thu, Jun 10, 2021 at 3:02 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On 10/06/2021 13.47, Bruno Goncalves wrote:
> >>> Hello,
> >>>
> >>> We've observed in some cases kernel panic when trying to boot on
> >>> ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
> >>> could be related to patch
> >>> https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
> >>>
> >>
> >> Thanks for the report. It's possible, but I'll need some help from you
> >> to get more info.
> >>
> >> First, can you send me the .config?
> >
> > The .config is on
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/kernel-block-ppc64le-d3f02e52f5548006f04358d407bbb7fe51255c41.config
>
> Thanks.
>
> >>
> >>>
> >>> [    1.516075] wait_for_initramfs() called before rootfs_initcalls
> >>
> >> This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
> >> non-empty path (/sbin/hotplug perhaps). This did get reported once before:
> >>
> >
> > CONFIG_UEVENT_HELPER_PATH is not set. In the .config we have "#
> > CONFIG_UEVENT_HELPER is not set"
>
> OK. Then I assume some quite early initcall does a request_module() or
> request_firmware() (or similar). I don't think this matters - that call
> would be done before the initramfs was unpacked with or without my
> patch, so it won't find anything in the empty rootfs. It's just my patch
> added a note. But just to figure out where that triggers, can you do
>
> -               pr_warn_once("wait_for_initramfs() called before
> rootfs_initcalls\n");
> +               WARN_ONCE(1, "wait_for_initramfs() called before
> rootfs_initcalls\n");
>
> in init/initramfs.c.
>

I've managed to reproduce the panic with the patch.

[    1.303632] Kprobes globally optimized
[    1.304131] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
[    1.304138] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
[    1.498349] alg: No test for 842 (842-generic)
[    1.498395] alg: No test for 842 (842-scomp)
[    1.498517] ------------[ cut here ]------------
[    1.498524] wait_for_initramfs() called before rootfs_initcalls
[    1.498532] WARNING: CPU: 13 PID: 1218 at init/initramfs.c:719
wait_for_initramfs+0x94/0xa4
[    1.498545] Modules linked in:
[    1.498550] CPU: 13 PID: 1218 Comm: kworker/u385:0 Not tainted 5.13.0-rc3 #1
[    1.498558] NIP:  c0000000000137d4 LR: c0000000000137d0 CTR: c0000000000c9e70
[    1.498564] REGS: c000000027debac0 TRAP: 0700   Not tainted  (5.13.0-rc3)
[    1.498571] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
28000202  XER: 20000000
[    1.498586] CFAR: c00000000014b874 IRQMASK: 0
[    1.498586] GPR00: c0000000000137d0 c000000027debd60
c000000001e30e00 0000000000000033
[    1.498586] GPR04: 00000000ffff7fff c000000027deb9f8
c000000027deb9f0 0000000000000000
[    1.498586] GPR08: 0000003feb5b0000 c000000001bb5b50
c000000001bb5b50 0000000000000001
[    1.498586] GPR12: 0000000000000000 c000003fffff1680
c000000000172e58 c0000000267822e0
[    1.498586] GPR16: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[    1.498586] GPR20: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[    1.498586] GPR24: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[    1.498586] GPR28: 0000000000000000 0000000000000000
c000000028111c00 c0000000267822e0
[    1.498654] NIP [c0000000000137d4] wait_for_initramfs+0x94/0xa4
[    1.498661] LR [c0000000000137d0] wait_for_initramfs+0x90/0xa4
[    1.498668] Call Trace:
[    1.498671] [c000000027debd60] [c0000000000137d0]
wait_for_initramfs+0x90/0xa4 (unreliable)
[    1.498680] [c000000027debdc0] [c000000000172fc8]
call_usermodehelper_exec_async+0x178/0x2c0
[    1.498691] [c000000027debe10] [c00000000000d6ec]
ret_from_kernel_thread+0x5c/0x70
[    1.498699] Instruction dump:
[    1.498703] 7c0803a6 4e800020 60420000 7c0802a6 39200001 3d42fff4
3c62ff5e 3863fb08
[    1.498715] 992ab06c f8010070 48138041 60000000 <0fe00000> e8010070
7c0803a6 4bffff94
[    1.498728] ---[ end trace dca36620a70fa99e ]---
[    1.503062] raid6: skip pq benchmark and using algorithm vpermxor8
[    1.503070] raid6: using intx1 recovery algorithm
[    1.503258] iommu: Default domain type: Translated
[    1.503339] vgaarb: loaded
[    1.503535] SCSI subsystem initialized
[    1.503699] usbcore: registered new interface driver usbfs
[    1.503712] usbcore: registered new interface driver hub
[    1.503789] usbcore: registered new device driver usb
[    1.503816] pps_core: LinuxPPS API ver. 1 registered
[    1.503820] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.503829] PTP clock support registered
[    1.504012] EDAC MC: Ver: 3.0.0
[    1.504425] NetLabel: Initializing
[    1.504429] NetLabel:  domain hash size = 128
[    1.504433] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.504452] NetLabel:  unlabeled traffic allowed by default
[    1.505953] clocksource: Switched to clocksource timebase
[    1.528908] VFS: Disk quotas dquot_6.6.0
[    1.529034] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    1.531252] NET: Registered protocol family 2
[    1.531428] IP idents hash table entries: 262144 (order: 5, 2097152
bytes, vmalloc)
[    1.536616] tcp_listen_portaddr_hash hash table entries: 65536
(order: 4, 1048576 bytes, vmalloc)
[    1.536818] TCP established hash table entries: 524288 (order: 6,
4194304 bytes, vmalloc)
[    1.537868] TCP bind hash table entries: 65536 (order: 4, 1048576
bytes, vmalloc)
[    1.538003] TCP: Hash tables configured (established 524288 bind 65536)
[    1.538632] MPTCP token hash table entries: 65536 (order: 4,
1572864 bytes, vmalloc)
[    1.538841] UDP hash table entries: 65536 (order: 5, 2097152 bytes, vmalloc)
[    1.539112] UDP-Lite hash table entries: 65536 (order: 5, 2097152
bytes, vmalloc)
[    1.540030] NET: Registered protocol family 1
[    1.540040] NET: Registered protocol family 44
[    1.540140] pci 0005:03:00.0: enabling device (0140 -> 0142)
[    1.540202] PCI: CLS 128 bytes, default 128
[    1.540332] Trying to unpack rootfs image as initramfs...
[    1.540407] rtas_flash: no firmware flash support
[    1.550617] Initialise system trusted keyrings
[    1.550641] Key type blacklist registered
[    1.550787] workingset: timestamp_bits=38 max_order=24 bucket_order=0
[    1.552891] zbud: loaded
[    1.596393] NET: Registered protocol family 38
[    1.596434] xor: measuring software checksum speed
[    1.597187]    8regs           : 13172 MB/sec
[    1.598009]    8regs_prefetch  : 12027 MB/sec
[    1.598734]    32regs          : 13657 MB/sec
[    1.599504]    32regs_prefetch : 12869 MB/sec
[    1.599889]    altivec         : 25910 MB/sec
[    1.599893] xor: using function: altivec (25910 MB/sec)
[    1.599899] Key type asymmetric registered
[    1.599903] Asymmetric key parser 'x509' registered
[    1.599934] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 245)
[    1.600092] io scheduler mq-deadline registered
[    1.600097] io scheduler kyber registered
[    1.600233] io scheduler bfq registered
[    1.602775] atomic64_test: passed
[    1.603547] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.603754] hvc0: raw protocol on /ibm,opal/consoles/serial@0 (boot console)
[    1.603994] hvc1: hvsi protocol on /ibm,opal/consoles/serial@1
[    1.604021] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.605830] Non-volatile memory driver v1.3
[    1.607633] libphy: Fixed MDIO Bus: probed
[    1.607773] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.607790] ehci-pci: EHCI PCI platform driver
[    1.607804] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.607822] ohci-pci: OHCI PCI platform driver
[    1.607835] uhci_hcd: USB Universal Host Controller Interface driver
[    1.608005] xhci_hcd 0005:03:00.0: xHCI Host Controller
[    1.608116] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
bus number 1
[    1.608265] xhci_hcd 0005:03:00.0: hcc params 0x0270f06d hci
version 0x96 quirks 0x0000000004000000
[    1.608728] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.13
[    1.608737] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.608744] usb usb1: Product: xHCI Host Controller
[    1.608749] usb usb1: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
[    1.608755] usb usb1: SerialNumber: 0005:03:00.0
[    1.608915] hub 1-0:1.0: USB hub found
[    1.608931] hub 1-0:1.0: 4 ports detected
[    1.609104] xhci_hcd 0005:03:00.0: xHCI Host Controller
[    1.609162] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
bus number 2
[    1.609179] xhci_hcd 0005:03:00.0: Host supports USB 3.0 SuperSpeed
[    1.609203] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.609235] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.13
[    1.609243] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.609250] usb usb2: Product: xHCI Host Controller
[    1.609255] usb usb2: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
[    1.609261] usb usb2: SerialNumber: 0005:03:00.0
[    1.609378] hub 2-0:1.0: USB hub found
[    1.609391] hub 2-0:1.0: 4 ports detected
[    1.609565] usbcore: registered new interface driver usbserial_generic
[    1.609576] usbserial: USB Serial support registered for generic
[    1.609614] mousedev: PS/2 mouse device common for all mice
[    1.613393] device-mapper: uevent: version 1.0.3
[    1.613535] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
initialised: dm-devel@redhat.com
[    1.613831] powernv-cpufreq: cpufreq pstate min 0xffffffda nominal
0xfffffff7 max 0x0
[    1.613838] powernv-cpufreq: Workload Optimized Frequency is
disabled in the platform
[    1.618654] hid: raw HID events driver (C) Jiri Kosina
[    1.618692] usbcore: registered new interface driver usbhid
[    1.618697] usbhid: USB HID core driver
[    1.618938] drop_monitor: Initializing network drop monitor service
[    1.619088] Initializing XFRM netlink socket
[    1.619464] NET: Registered protocol family 10
[    1.708294] Initramfs unpacking failed: junk within compressed archive
[    1.709187] Freeing initrd memory: 18176K
[    1.710883] Segment Routing with IPv6
[    1.710893] RPL Segment Routing with IPv6
[    1.710925] mip6: Mobile IPv6
[    1.710932] NET: Registered protocol family 17
[    1.711010] secvar-sysfs: secvar: failed to retrieve secvar operations.
[    1.711047] drmem: No dynamic reconfiguration memory found
[    1.711278] registered taskstats version 1
[    1.711299] Loading compiled-in X.509 certificates
[    1.712740] Loaded X.509 cert 'Build time autogenerated kernel key:
ea17e1addc1b8e4973bc39f5bfb1273b281f4bec'
[    1.714417] zswap: loaded using pool lzo/zbud
[    1.714638] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    1.715174] Key type ._fscrypt registered
[    1.715181] Key type .fscrypt registered
[    1.715187] Key type fscrypt-provisioning registered
[    1.716999] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
[    1.717047] pstore: Using crash dump compression: deflate
[    1.717913] Key type encrypted registered
[    1.718118] Secure boot mode disabled
[    1.718127] ima: No TPM chip found, activating TPM-bypass!
[    1.718135] Loading compiled-in module X.509 certificates
[    1.719409] Loaded X.509 cert 'Build time autogenerated kernel key:
ea17e1addc1b8e4973bc39f5bfb1273b281f4bec'
[    1.719421] ima: Allocated hash algorithm: sha256
[    1.719594] Secure boot mode disabled
[    1.719748] Trusted boot mode disabled
[    1.719755] ima: No architecture policies found
[    1.719778] evm: Initialising EVM extended attributes:
[    1.719785] evm: security.selinux
[    1.719790] evm: security.ima
[    1.719795] evm: security.capability
[    1.719800] evm: HMAC attrs: 0x1
[    1.722870] Freeing unused kernel memory: 5760K
[    1.722880] Kernel memory protection not selected by kernel config.
[    1.722891] Run /init as init process
[    1.723033] Failed to execute /init (error -2)
[    1.723041] Run /sbin/init as init process
[    1.723082] Run /etc/init as init process
[    1.723121] Run /bin/init as init process
[    1.723161] Run /bin/sh as init process
[    1.723219] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance.
[    1.723234] CPU: 40 PID: 1 Comm: swapper/0 Tainted: G        W
   5.13.0-rc3 #1
[    1.723246] Call Trace:
[    1.723251] [c0000080010cfcc0] [c0000000009f2640]
dump_stack+0xc4/0x114 (unreliable)
[    1.723267] [c0000080010cfd10] [c00000000014b9e0] panic+0x168/0x408
[    1.723281] [c0000080010cfda0] [c000000000012964] kernel_init+0x14c/0x168
[    1.723293] [c0000080010cfe10] [c00000000000d6ec]
ret_from_kernel_thread+0x5c/0x70

> >>> [    1.764430] Initramfs unpacking failed: no cpio magic
> >>
> >> Whoa, that's not good. Did something scramble over the initramfs memory
> >> while it was being unpacked? It's been .2 seconds since the start of the
> >> unpacking, so it's unlikely the very beginning of the initramfs is corrupt.
> >>
> >> Can you try booting with initramfs_async=0 on the command line and see
> >> if the kernel still crashes?

Using initramfs_async=0 I was also able to reproduce the panic.

Bruno

> > We are not able to reproduce it 100% of the time, but sure I can try
> > with this option and see what happens.
> >
> > We've also seen:
> > Initramfs unpacking failed: junk within compressed archive
> >
> > This can be seen on the other 2 console logs that I provided the link to.
>
> Yes, I saw that. This, and the fact that it's not 100% reproducible, is
> consistent with the problem being some race that happens to write over
> the compressed initramfs image - sometimes, the decompressor can still
> make sense of the bits, but the output is no longer a valid cpio
> archive, and sometimes already the decompressor notices the corruption.
>
> I wonder if there is some way to mark the pages occupied by the
> compressed initramfs as read-only - what would hopefully trigger a nice
> crash with a backtrace to whoever writes to that memory.
>
> Rasmus
>

