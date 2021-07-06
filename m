Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672E3BD8DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhGFOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhGFOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:50:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826AC0613A8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 07:47:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so2446813wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDEcMj8d/SJcnR+H5XLZF6dc7/5jUPJVbrvLZZz2H8s=;
        b=Rez/SxfbicaUrSpHaiZd4iVPKJI/d84G4I132x+Dt2g8Exb7M8Z6cCmoJXjQSvHxMN
         WwLLjcRJuC6ONK6YSOowgtxojTzy258TaApf10gHTQfik5puTtV0CXIcUmlhKri8EDQZ
         WH7B4SE0KTQyucg3/pFVp9JFP52gG1CxPpZx7tpoZbikvDWw2ahOioOCsAsyW6O7fz/G
         d/laQh4Z6LhT63vcR5mxbuRqJ6Lrl+YGU0UfZ3CaCmOl1xD+3oPmnMs3anhpX1YMAPB1
         Cp4u/FdgywSfh4ffkD0eWOAOweqTQ5K2aTiMUxH7U8b2SjnyMJ8wwQtNVN3x43N0feUp
         9j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDEcMj8d/SJcnR+H5XLZF6dc7/5jUPJVbrvLZZz2H8s=;
        b=flbvbFUB4DbFtsMxitavBGzE4zUkW0jGYUJoCL5vbKmiHd6/NDBhAtPkP7/TMcs1vH
         qoWH6Fgg9i4UqdAQFU2ewdzRFYQ0Tdtm/PdwZ44drmNxeeiLCr3jOrF1LWy8I7Udsr7i
         8zcf9Ojm9sBLLSyJ6Ir36OaoNNQdRiKjAACaJvQzNU3sORe0xSiwHtMiiE7pjTxJzUj5
         aouwn/yxQLaZTZ8cO8fWjvIIZ9/BNPj6wNs9qH+jWfw2xrG/CdWk7Uywd4OOTuDK0NSR
         kPy14wY27DyExRpO1m6jjcRLK/izkEridIvspAtsAQ1uRXTta0N8VKST9qBt0XK59k2l
         AtSw==
X-Gm-Message-State: AOAM533y2H/feThh8pgEMxpeLazioPlk3+Xe1VAGlzX3YWnQRtcbwUgm
        6nc1jfVzOMpJSckKRkQwG5IwdA==
X-Google-Smtp-Source: ABdhPJxELuWRsAu6AsPmiPDke7tBeUI8brsk24J5LkV0wOTjyx1hpkCaq10AhD/lHeQ1wHBLH4ik8g==
X-Received: by 2002:a05:600c:ada:: with SMTP id c26mr1186832wmr.189.1625582854260;
        Tue, 06 Jul 2021 07:47:34 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:396a:6bf2:9c33:26ce])
        by smtp.gmail.com with ESMTPSA id a12sm2880677wrh.26.2021.07.06.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:47:33 -0700 (PDT)
Date:   Tue, 6 Jul 2021 16:47:28 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+86ab74ebbf8800b62803@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org, hare@suse.de,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] upstream boot error: kernel panic: VFS: Unable to mount
 root fs on unknown-block(0,0)
Message-ID: <YORtAHVRnl+65hhQ@elver.google.com>
References: <0000000000004b654905c634b8e5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004b654905c634b8e5@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2021 at 02:30AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4b820e16 Revert "ALSA: usb-audio: Reduce latency at playba..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f16ac4300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=476b9a5c50907dd0
> dashboard link: https://syzkaller.appspot.com/bug?extid=86ab74ebbf8800b62803
> compiler:       Debian clang version 11.0.1-2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+86ab74ebbf8800b62803@syzkaller.appspotmail.com
> 
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> e1000e: Intel(R) PRO/1000 Network Driver
> e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> sky2: driver version 1.30
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> ohci-pci: OHCI PCI platform driver
> uhci_hcd: USB Universal Host Controller Interface driver
> usbcore: registered new interface driver usblp
> usbcore: registered new interface driver usb-storage
> i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> i8042: Warning: Keylock active
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> rtc_cmos 00:00: RTC can wake from S4
> rtc_cmos 00:00: registered as rtc0
> rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
> device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
> intel_pstate: CPU model not supported
> hid: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> nf_conntrack_irc: failed to register helpers
> nf_conntrack_sip: failed to register helpers
> Initializing XFRM netlink socket
> NET: Registered PF_INET6 protocol family
> Segment Routing with IPv6
> sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> NET: Registered PF_PACKET protocol family
> 9pnet: Installing 9P2000 support
> Key type dns_resolver registered
> IPI shorthand broadcast: enabled
> sched_clock: Marking stable (2235106141, 17179042)->(2259812022, -7526839)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> PM:   Magic number: 13:586:166
> printk: console [netcon0] enabled
> netconsole: network logging started
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> ALSA device list:
>   No soundcards found.
> md: Waiting for all devices to be available before autodetect
> md: If you don't use raid, use raid=noautodetect
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> VFS: Cannot open root device "sda1" or unknown-block(0,0): error -6
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xb7/0x103 lib/dump_stack.c:96
>  dump_stack+0x11/0x1a lib/dump_stack.c:103
>  panic+0x1df/0x5ea kernel/panic.c:232
>  mount_block_root+0x259/0x2ae init/do_mounts.c:452
>  mount_root+0x97/0xae init/do_mounts.c:555
>  prepare_namespace+0x27f/0x2ba init/do_mounts.c:607
>  kernel_init_freeable+0x233/0x289 init/main.c:1612
>  kernel_init+0x17/0x2d0 init/main.c:1491
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

I bisected this to "scsi: core: Kill DRIVER_SENSE":

	https://groups.google.com/g/syzkaller-bugs/c/ck9AY2Re2FU

... and per Martin's response should therefore be:

#syz fix: scsi: virtio_scsi: Do not overwrite SCSI status
