Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34753BA80F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGCJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 05:32:52 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53171 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGCJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 05:32:49 -0400
Received: by mail-io1-f69.google.com with SMTP id r3-20020a6b8f030000b02904e159249245so8799888iod.19
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 02:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o2l0rJ7Rnj+4SKIrPbKdho9je+rDDlVekZtE0ABNFjA=;
        b=MN7azXBHlggpTENDowpVabZS3oXiw5RJpmnadniO1nhs7vijOn3h/UIzIXQAU+uZlL
         ViMMhtjjaoCgBkmEEitz5vtOYwclajQAGwDV90xTc75kjC211k9reJ+popdbEibgKGND
         niZsmC0U0Owj8nPW/+Lw1PSc/6a7hwSxcSVL0pPCAV/X0LwcWozeKb3H04PDpdJU2veV
         +Klvjz9JYkUm9YhP64ynuTkfIPYWnoyHdZqwWZP8psHKQC+mfpnBgznOHuipeQy9kYW0
         /v87uGPSKcQGmW7fTJ1Cneyr2P7RarRuqVuKl6QT2G6J4+SJ/rVQf/0eTmH2EhyFlBUn
         E9XA==
X-Gm-Message-State: AOAM530z3hPtHWWEePdQuPevOdJODqxzUBhd/dvqEwDYZclkpN1OpIP6
        oNXJzFtgNqIcAjHy55P5BxbXGOPY3Emj+GJsoC8vrM3znxsU
X-Google-Smtp-Source: ABdhPJxNTHvT+vnR7UYHLMiGRVyLPApxyFH9C4MNLiMT2mit8hCIt4nXk0CdhhNN94LGhHVNoy9ELf/HsEZ0Sn95FqY+27t3MW3b
MIME-Version: 1.0
X-Received: by 2002:a5d:904c:: with SMTP id v12mr3399653ioq.95.1625304616099;
 Sat, 03 Jul 2021 02:30:16 -0700 (PDT)
Date:   Sat, 03 Jul 2021 02:30:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b654905c634b8e5@google.com>
Subject: [syzbot] upstream boot error: kernel panic: VFS: Unable to mount root
 fs on unknown-block(0,0)
From:   syzbot <syzbot+86ab74ebbf8800b62803@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org, hare@suse.de,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b820e16 Revert "ALSA: usb-audio: Reduce latency at playba..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f16ac4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=476b9a5c50907dd0
dashboard link: https://syzkaller.appspot.com/bug?extid=86ab74ebbf8800b62803
compiler:       Debian clang version 11.0.1-2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86ab74ebbf8800b62803@syzkaller.appspotmail.com

e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
sky2: driver version 1.30
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
usbcore: registered new interface driver usb-storage
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
i8042: Warning: Keylock active
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
rtc_cmos 00:00: RTC can wake from S4
rtc_cmos 00:00: registered as rtc0
rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
intel_pstate: CPU model not supported
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
nf_conntrack_irc: failed to register helpers
nf_conntrack_sip: failed to register helpers
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
9pnet: Installing 9P2000 support
Key type dns_resolver registered
IPI shorthand broadcast: enabled
sched_clock: Marking stable (2235106141, 17179042)->(2259812022, -7526839)
registered taskstats version 1
Loading compiled-in X.509 certificates
PM:   Magic number: 13:586:166
printk: console [netcon0] enabled
netconsole: network logging started
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
ALSA device list:
  No soundcards found.
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "sda1" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xb7/0x103 lib/dump_stack.c:96
 dump_stack+0x11/0x1a lib/dump_stack.c:103
 panic+0x1df/0x5ea kernel/panic.c:232
 mount_block_root+0x259/0x2ae init/do_mounts.c:452
 mount_root+0x97/0xae init/do_mounts.c:555
 prepare_namespace+0x27f/0x2ba init/do_mounts.c:607
 kernel_init_freeable+0x233/0x289 init/main.c:1612
 kernel_init+0x17/0x2d0 init/main.c:1491
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
