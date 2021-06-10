Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852773A2A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFJLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhFJLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623325637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9tXhl7TyO+eKgnM6BiaDHLNgW86/Zlou8WamSSCIHl4=;
        b=Lv9UwJLxryv3DfHTVm5ldt14ichsh+t4Sh6Nq1tAu1gMYBpRgDAs9KlZQKDmnP6tKW126w
        IGYcUIsj9DmMvFadYUMOaV0kqK0O/n6fvvPOeidUeA3LbyBvW4bclYaau7KA8qjUPoAaud
        D0cnJgUdBVKHZYnAqXmIjZnLmmmsveg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-SZ46ApAjOMyHaJrv01-7uA-1; Thu, 10 Jun 2021 07:47:16 -0400
X-MC-Unique: SZ46ApAjOMyHaJrv01-7uA-1
Received: by mail-oo1-f70.google.com with SMTP id c25-20020a4a28590000b029024a664285fdso664070oof.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9tXhl7TyO+eKgnM6BiaDHLNgW86/Zlou8WamSSCIHl4=;
        b=fD7nlmtu5Y5AcwPXzxVDMe2VNwkrRtRdEfwHb8Zrc6FNw/yjOb8FH3BNWSyzWeppcm
         J5If+8HN/SMF9Y2wWMTRdvb3xfaDtGanbb+pNZ7unt8onl3VidLpc5TqWQKJjjSLXsGJ
         kA2c7xMQk0HhRf6St7oKqwFztKj75ein6av7Fj3ZPdx1uUam7eTEIA8EHT7s4H+e5ClX
         NqAyqp0EHSb+GgG5AbI+gw5NovxeZICcLJMfJjUAfMTPUdaU7y1p4uhY1GYjQp7mpu7D
         2MXMubiuK5WQcH1jsaIdLXCC+SarOR+qyUKpQASkP2idUQIxGcBHzAl+FsTSFWPNJHdC
         bn4Q==
X-Gm-Message-State: AOAM531kq9qrXxSpJTxyxz0SSWkhhJA1kXqGYwwlXKCLX+EP89nSqRUv
        7MqkFu04eDMPM/lSSO27uQlbFN1Oz6bCebEgfrP8eBuEU4gwC7a2OBpY/kkEFaI8FHDae8zJbXv
        z5j1lTeF7h+fFoVPJ6n9bJbUmTdIDV3GUhHkmzkcO
X-Received: by 2002:a9d:19e5:: with SMTP id k92mr2084238otk.189.1623325635451;
        Thu, 10 Jun 2021 04:47:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHwdap4cb8wdxh3RTAQLD4JIzjj5UxtL5Z2qVBzHWIg/BEzzRx2R4Dy5JF7b0DkUs9Ka5+dWydWirv9lNd51w=
X-Received: by 2002:a9d:19e5:: with SMTP id k92mr2084224otk.189.1623325635199;
 Thu, 10 Jun 2021 04:47:15 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 10 Jun 2021 13:47:04 +0200
Message-ID: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
Subject: Panic on ppc64le using kernel 5.13.0-rc3
To:     linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've observed in some cases kernel panic when trying to boot on
ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
could be related to patch
https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/


[    1.516075] wait_for_initramfs() called before rootfs_initcalls
[    1.520467] raid6: skip pq benchmark and using algorithm vpermxor8
[    1.520475] raid6: using intx1 recovery algorithm
[    1.520654] iommu: Default domain type: Translated
[    1.520733] vgaarb: loaded
[    1.520937] SCSI subsystem initialized
[    1.521104] usbcore: registered new interface driver usbfs
[    1.521118] usbcore: registered new interface driver hub
[    1.521179] usbcore: registered new device driver usb
[    1.521207] pps_core: LinuxPPS API ver. 1 registered
[    1.521212] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.521220] PTP clock support registered
[    1.521388] EDAC MC: Ver: 3.0.0
[    1.521784] NetLabel: Initializing
[    1.521789] NetLabel:  domain hash size = 128
[    1.521793] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.521812] NetLabel:  unlabeled traffic allowed by default
[    1.523330] clocksource: Switched to clocksource timebase
[    1.546838] VFS: Disk quotas dquot_6.6.0
[    1.546981] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    1.549556] NET: Registered protocol family 2
[    1.549749] IP idents hash table entries: 262144 (order: 5, 2097152
bytes, vmalloc)
[    1.555300] tcp_listen_portaddr_hash hash table entries: 65536
(order: 4, 1048576 bytes, vmalloc)
[    1.555559] TCP established hash table entries: 524288 (order: 6,
4194304 bytes, vmalloc)
[    1.556874] TCP bind hash table entries: 65536 (order: 4, 1048576
bytes, vmalloc)
[    1.557053] TCP: Hash tables configured (established 524288 bind 65536)
[    1.557788] MPTCP token hash table entries: 65536 (order: 4,
1572864 bytes, vmalloc)
[    1.558051] UDP hash table entries: 65536 (order: 5, 2097152 bytes, vmalloc)
[    1.558449] UDP-Lite hash table entries: 65536 (order: 5, 2097152
bytes, vmalloc)
[    1.559536] NET: Registered protocol family 1
[    1.559548] NET: Registered protocol family 44
[    1.559681] pci 0005:03:00.0: enabling device (0140 -> 0142)
[    1.559757] PCI: CLS 128 bytes, default 128
[    1.560150] Trying to unpack rootfs image as initramfs...
[    1.560203] rtas_flash: no firmware flash support
[    1.575826] Initialise system trusted keyrings
[    1.575859] Key type blacklist registered
[    1.576031] workingset: timestamp_bits=38 max_order=24 bucket_order=0
[    1.578756] zbud: loaded
[    1.620652] NET: Registered protocol family 38
[    1.620705] xor: measuring software checksum speed
[    1.621978]    8regs           :  7789 MB/sec
[    1.623409]    8regs_prefetch  :  7482 MB/sec
[    1.624493]    32regs          :  9208 MB/sec
[    1.625666]    32regs_prefetch :  8471 MB/sec
[    1.626333]    altivec         : 15060 MB/sec
[    1.626339] xor: using function: altivec (15060 MB/sec)
[    1.626348] Key type asymmetric registered
[    1.626354] Asymmetric key parser 'x509' registered
[    1.626417] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 245)
[    1.626604] io scheduler mq-deadline registered
[    1.626610] io scheduler kyber registered
[    1.626812] io scheduler bfq registered
[    1.635490] atomic64_test: passed
[    1.636168] random: crng init done
[    1.636563] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.636815] hvc0: raw protocol on /ibm,opal/consoles/serial@0 (boot console)
[    1.637064] hvc1: hvsi protocol on /ibm,opal/consoles/serial@1
[    1.637091] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.638860] Non-volatile memory driver v1.3
[    1.640714] libphy: Fixed MDIO Bus: probed
[    1.640864] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.640880] ehci-pci: EHCI PCI platform driver
[    1.640895] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.640912] ohci-pci: OHCI PCI platform driver
[    1.640925] uhci_hcd: USB Universal Host Controller Interface driver
[    1.641099] xhci_hcd 0005:03:00.0: xHCI Host Controller
[    1.641232] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
bus number 1
[    1.641379] xhci_hcd 0005:03:00.0: hcc params 0x0270f06d hci
version 0x96 quirks 0x0000000004000000
[    1.641849] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.13
[    1.641858] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.641865] usb usb1: Product: xHCI Host Controller
[    1.641871] usb usb1: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
[    1.641876] usb usb1: SerialNumber: 0005:03:00.0
[    1.642025] hub 1-0:1.0: USB hub found
[    1.642040] hub 1-0:1.0: 4 ports detected
[    1.642211] xhci_hcd 0005:03:00.0: xHCI Host Controller
[    1.642275] xhci_hcd 0005:03:00.0: new USB bus registered, assigned
bus number 2
[    1.642283] xhci_hcd 0005:03:00.0: Host supports USB 3.0 SuperSpeed
[    1.642305] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.642383] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.13
[    1.642391] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.642398] usb usb2: Product: xHCI Host Controller
[    1.642403] usb usb2: Manufacturer: Linux 5.13.0-rc3 xhci-hcd
[    1.642409] usb usb2: SerialNumber: 0005:03:00.0
[    1.642543] hub 2-0:1.0: USB hub found
[    1.642557] hub 2-0:1.0: 4 ports detected
[    1.642732] usbcore: registered new interface driver usbserial_generic
[    1.642744] usbserial: USB Serial support registered for generic
[    1.642786] mousedev: PS/2 mouse device common for all mice
[    1.646583] device-mapper: uevent: version 1.0.3
[    1.646730] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
initialised: dm-devel@redhat.com
[    1.647019] powernv-cpufreq: cpufreq pstate min 0xffffffda nominal
0xfffffff7 max 0x0
[    1.647027] powernv-cpufreq: Workload Optimized Frequency is
disabled in the platform
[    1.652136] hid: raw HID events driver (C) Jiri Kosina
[    1.652178] usbcore: registered new interface driver usbhid
[    1.652183] usbhid: USB HID core driver
[    1.652441] drop_monitor: Initializing network drop monitor service
[    1.652599] Initializing XFRM netlink socket
[    1.653049] NET: Registered protocol family 10
[    1.764430] Initramfs unpacking failed: no cpio magic
[    1.766204] Freeing initrd memory: 18176K
[    1.768734] Segment Routing with IPv6
[    1.768747] RPL Segment Routing with IPv6
[    1.768792] mip6: Mobile IPv6
[    1.768801] NET: Registered protocol family 17
[    1.768912] secvar-sysfs: secvar: failed to retrieve secvar operations.
[    1.768961] drmem: No dynamic reconfiguration memory found
[    1.769297] registered taskstats version 1
[    1.769329] Loading compiled-in X.509 certificates
[    1.771836] Loaded X.509 cert 'Build time autogenerated kernel key:
97604d93c367cf27b215cdfd062467d582f7e126'
[    1.774441] zswap: loaded using pool lzo/zbud
[    1.774697] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    1.775440] Key type ._fscrypt registered
[    1.775450] Key type .fscrypt registered
[    1.775458] Key type fscrypt-provisioning registered
[    1.778036] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
[    1.778099] pstore: Using crash dump compression: deflate
[    1.778765] Key type encrypted registered
[    1.779101] Secure boot mode disabled
[    1.779113] ima: No TPM chip found, activating TPM-bypass!
[    1.779126] Loading compiled-in module X.509 certificates
[    1.781448] Loaded X.509 cert 'Build time autogenerated kernel key:
97604d93c367cf27b215cdfd062467d582f7e126'
[    1.781465] ima: Allocated hash algorithm: sha256
[    1.781727] Secure boot mode disabled
[    1.781963] Trusted boot mode disabled
[    1.781972] ima: No architecture policies found
[    1.782008] evm: Initialising EVM extended attributes:
[    1.782017] evm: security.selinux
[    1.782024] evm: security.ima
[    1.782032] evm: security.capability
[    1.782040] evm: HMAC attrs: 0x1
[    1.787618] Freeing unused kernel memory: 5760K
[    1.787634] Kernel memory protection not selected by kernel config.
[    1.787649] Run /init as init process
[    1.787793] Failed to execute /init (error -2)
[    1.787801] Run /sbin/init as init process
[    1.787842] Run /etc/init as init process
[    1.787880] Run /bin/init as init process
[    1.787921] Run /bin/sh as init process
[    1.787978] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance.
[    1.787993] CPU: 24 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc3 #1
[    1.788004] Call Trace:
[    1.788009] [c000004001083cc0] [c0000000009f2640]
dump_stack+0xc4/0x114 (unreliable)
[    1.788027] [c000004001083d10] [c00000000014b9e0] panic+0x168/0x408
[    1.788040] [c000004001083da0] [c000000000012964] kernel_init+0x14c/0x168
[    1.788052] [c000004001083e10] [c00000000000d6ec]
ret_from_kernel_thread+0x5c/0x70
[    1.813436] ---[ end Kernel panic - not syncing: No working init
found.  Try passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance. ]---

More logs:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/tests/10112063_ppc64le_2_console.log
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/08/317255035/build_ppc64le_redhat:1329401048/tests/10107307_ppc64le_2_console.log
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/08/105424895c02858922e1bf27ef01127e12caca9a/build_ppc64le_redhat:1326137946/tests/1/results_0001/console.log/console.log


Thanks,
Bruno Goncalves

