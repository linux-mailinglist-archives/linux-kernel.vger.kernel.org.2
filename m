Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6C3C42C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 06:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhGLERP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 00:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGLERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:17:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A19C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 21:14:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p12-20020a05683019ccb02904b7e9d93563so5468613otp.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VANxTdVh97CSfH7N/lChv9t+TSMaAeLyjlrdOzCJDEs=;
        b=isOCw1wroBg68p/hv1+8af1biM+dG481H21wHFHwnkBVx5q5f6gZZA88+D2z9jey1d
         A5tlhtm75W+NnBQwQGCj2+gbHeCPM200TmmW+b4j0rLjwQact2JoCUTITu9EcblJaeR0
         7lyNxnMXNWJIcAhcC9lsg9TBfJ+v/rU2B/HLCtj1DmS5EVoUf0l0bFKe4AbYIBNcYiyS
         Djkdn5JQJMWi3q/rzilHh1Yc/NlQ1X1Y6BDhi6neDcUXWEr+Furcvv93r2EnmoTPFCuX
         dd8AOFtIOU2W9jlAhsF8h8uFXOT62ar7cxtj8q3/1DEiIdGM3Hv/qa2KufTJQVBvXzPE
         7SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VANxTdVh97CSfH7N/lChv9t+TSMaAeLyjlrdOzCJDEs=;
        b=cTPlGoMzFMQCcrKSwyt8aQXIljbKxMSq0y0td0vAr+vrZaHe0xd3IXLAK90aeKAp8A
         spRs/Przmh9oxN3xZtQ6WIxP+63+sIm+OcVWxkPbKrvFEY+yQx28DcsQgvArC5Kwm2xp
         3aVXXMKIW79Bd7nfo992za/l7AsSn1lzAs1F/627Le91GZTlo99w/11PaYJ/x0bUHCic
         tYxJN+S7EBmLxVqfs8xAdNCUMlTuu64nobvuahWbefp75ro/1iXOkVHHAqFSMxzLZ8+G
         9rjB6zSC7FOi6AnlJfge38iPGD2uJKHLKanz/i2twtlMglF922t2Cuv1furNn8TxvFqQ
         T2nQ==
X-Gm-Message-State: AOAM530Aimz8iQDIfFtW5F5QTVj9iHg7GdRiRJkjcZxGl0HRghT03Mw5
        uGLbkcep1cHT6424K6D+7Lw=
X-Google-Smtp-Source: ABdhPJwPngaMYSZLT0HDxwhDO4qCrffy/NUBRVjJIwnho2+rYApHvLJtxoqj5PZUKuhsJbGpOoo9ow==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr15151267otk.209.1626063266085;
        Sun, 11 Jul 2021 21:14:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g66sm2375773oob.27.2021.07.11.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 21:14:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Jul 2021 21:14:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Linux 5.14-rc1
Message-ID: <20210712041423.GA97217@roeck-us.net>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <20210712015619.GA3547193@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712015619.GA3547193@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 06:56:21PM -0700, Guenter Roeck wrote:
> On Sun, Jul 11, 2021 at 03:49:31PM -0700, Linus Torvalds wrote:
> > You all know the drill by now. It's been the usual two weeks of merge
> > window, and not it's closed, and 5.14-rc1 is out there.
> > 
> [ ... ] 
> > Please do test, and we can get the whole calming-down period rolling
> > and hopefully get a timely final 5.14 release.
> > 
> 
[ ... ]
> 
> WARNING: CPU: 0 PID: 24 at block/genhd.c:484 __device_add_disk+0x248/0x286
> 
> This is seen with riscv64 images when booting from usb or scsi drives.
> I don't recall seeing this warning before, but I may have missed it
> in the flurry of other warnings. It may have been introduced with commit
> 7c3f828b522b0 ("block: refactor device number setup in __device_add_disk")
> but I did not try to bisect it yet.
> 
My guess was correct. Bisect points to the above commit. Bisect log as well
as complete backtrace and example qemu command attached.

Copying Christoph and Jens.

Guenter

---
# bad: [3dbdb38e286903ec220aaf1fb29a8d94297da246] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
# good: [007b350a58754a93ca9fe50c498cc27780171153] Merge tag 'dlm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
git bisect start '3dbdb38e2869' '007b350a5875'
# good: [b6df00789e2831fff7a2c65aa7164b2a4dcbe599] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good b6df00789e2831fff7a2c65aa7164b2a4dcbe599
# good: [990ec3014deedfed49e610cdc31dc6930ca63d8d] drm/amdgpu: add psp runtime db structures
git bisect good 990ec3014deedfed49e610cdc31dc6930ca63d8d
# bad: [c288d9cd710433e5991d58a0764c4d08a933b871] Merge tag 'for-5.14/io_uring-2021-06-30' of git://git.kernel.dk/linux-block
git bisect bad c288d9cd710433e5991d58a0764c4d08a933b871
# bad: [df668a5fe461bb9d7e899c538acc7197746038f4] Merge tag 'for-5.14/block-2021-06-29' of git://git.kernel.dk/linux-block
git bisect bad df668a5fe461bb9d7e899c538acc7197746038f4
# good: [4b5e35ce075817bc36d7c581b22853be984e5b41] Merge tag 'edac_updates_for_v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras
git bisect good 4b5e35ce075817bc36d7c581b22853be984e5b41
# bad: [e42cfb1da0bf33c313318da201730324c423351d] block: Remove unnecessary elevator operation checks
git bisect bad e42cfb1da0bf33c313318da201730324c423351d
# bad: [c97d93c31e5734a16bfe663085ec91b8c9fb20f9] block: factor out a part_devt helper
git bisect bad c97d93c31e5734a16bfe663085ec91b8c9fb20f9
# bad: [7681750bd35fe92dd915f4df177d45265e78a933] zram: convert to blk_alloc_disk/blk_cleanup_disk
git bisect bad 7681750bd35fe92dd915f4df177d45265e78a933
# good: [56b68085e536eff2676108f2f8356889a7dbbf55] blk-mq: Some tag allocation code refactoring
git bisect good 56b68085e536eff2676108f2f8356889a7dbbf55
# bad: [958229a7c55f219b1cff99f939dabbc1b6ba7161] block: add a flag to make put_disk on partially initalized disks safer
git bisect bad 958229a7c55f219b1cff99f939dabbc1b6ba7161
# bad: [7c3f828b522b07adb341b08fde1660685c5ba3eb] block: refactor device number setup in __device_add_disk
git bisect bad 7c3f828b522b07adb341b08fde1660685c5ba3eb
# good: [d97e594c51660bea510a387731637b894651e4b5] blk-mq: Use request queue-wide tags for tagset-wide sbitmap
git bisect good d97e594c51660bea510a387731637b894651e4b5
# first bad commit: [7c3f828b522b07adb341b08fde1660685c5ba3eb] block: refactor device number setup in __device_add_disk

---
[   11.940230] Waiting for root device /dev/sda...
[   12.066026] usb 1-1: new full-speed USB device number 2 using ohci-pci
[   12.306673] usb-storage 1-1:1.0: USB Mass Storage device detected
[   12.310957] scsi host0: usb-storage 1-1:1.0
[   13.354722] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[   13.370433] sd 0:0:0:0: Power-on or device reset occurred
[   13.390621] sd 0:0:0:0: [sda] 32768 512-byte logical blocks: (16.8 MB/16.0 MiB)
[   13.396348] sd 0:0:0:0: [sda] Write Protect is off
[   13.402622] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.403994] ------------[ cut here ]------------
[   13.404165] WARNING: CPU: 0 PID: 7 at block/genhd.c:484 __device_add_disk+0x248/0x286
[   13.404393] Modules linked in:
[   13.404601] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.14.0-rc1 #1
[   13.404830] Hardware name: riscv-virtio,qemu (DT)
[   13.405081] Workqueue: events_unbound async_run_entry_fn
[   13.405309] epc : __device_add_disk+0x248/0x286
[   13.405496]  ra : __device_add_disk+0x1b2/0x286
[   13.405657] epc : ffffffff8042a4cc ra : ffffffff8042a436 sp : ffffffd00024bb80
[   13.405863]  gp : ffffffff819d15a8 tp : ffffffe0027a8040 t0 : ffffffe01f6f48f8
[   13.406087]  t1 : 000000006faf79ac t2 : 00000000000001a5 s0 : ffffffd00024bbc0
[   13.406293]  s1 : ffffffe004450e00 a0 : 0000000000006000 a1 : ffffffe0027a88b0
[   13.406499]  a2 : ffffffff819e2890 a3 : 0000000000000000 a4 : 0000000000000008
[   13.406703]  a5 : 0000000000000000 a6 : 0000000000001fff a7 : 0000000000000000
[   13.406908]  s2 : ffffffe004450e00 s3 : 0000000000000001 s4 : 0000000000000000
[   13.407135]  s5 : ffffffe00438c268 s6 : 0000000000000000 s7 : 0000000000000000
[   13.407344]  s8 : ffffffff819d41b8 s9 : ffffffff819d4298 s10: ffffffe00261a858
[   13.407550]  s11: ffffffe00261a8d0 t3 : 0000000045db8cae t4 : 000000000000000c
[   13.407752]  t5 : fffffffff04a2835 t6 : 0000000000001fff
[   13.407912] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
[   13.408179] [<ffffffff8042a4cc>] __device_add_disk+0x248/0x286
[   13.408394] [<ffffffff8042a518>] device_add_disk+0xe/0x16
[   13.408555] [<ffffffff806e3886>] sd_probe+0x2b8/0x366
[   13.408711] [<ffffffff8067bce4>] really_probe.part.0+0x188/0x222
[   13.408886] [<ffffffff8067be16>] __driver_probe_device+0x98/0xbe
[   13.409079] [<ffffffff8067be68>] driver_probe_device+0x2c/0xb0
[   13.409247] [<ffffffff8067c330>] __device_attach_driver+0x62/0x9a
[   13.409419] [<ffffffff80679c7e>] bus_for_each_drv+0x5c/0xa2
[   13.409580] [<ffffffff8067b458>] __device_attach_async_helper+0x88/0x92
[   13.409766] [<ffffffff80032e12>] async_run_entry_fn+0x22/0xc4
[   13.409930] [<ffffffff80027e28>] process_one_work+0x1f4/0x53a
[   13.410114] [<ffffffff800281ec>] worker_thread+0x7e/0x324
[   13.410272] [<ffffffff8002fa1e>] kthread+0x100/0x116
[   13.410419] [<ffffffff80003648>] ret_from_exception+0x0/0x10
[   13.410614] irq event stamp: 59724
[   13.410733] hardirqs last  enabled at (59723): [<ffffffff80a1471c>] _raw_spin_unlock_irqrestore+0x54/0x62
[   13.411019] hardirqs last disabled at (59724): [<ffffffff80003592>] _save_context+0x7c/0xe0
[   13.411249] softirqs last  enabled at (34082): [<ffffffff80a1510a>] __do_softirq+0x39a/0x520
[   13.411496] softirqs last disabled at (34073): [<ffffffff80014354>] irq_exit+0xd2/0xde
[   13.411733] ---[ end trace 644c7abe39308f0f ]---
[   13.480431] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.511335] EXT4-fs (sda): mounting ext2 file system using the ext4 subsystem
[   13.536810] EXT4-fs (sda): mounted filesystem without journal. Opts: (null). Quota mode: disabled.
[   13.537632] VFS: Mounted root (ext2 filesystem) readonly on device 8:0.

---

Sample qemu command:

qemu-system-riscv64 -M virt -m 512M \
     -no-reboot -bios default -kernel arch/riscv/boot/Image \
     -snapshot -device virtio-net-device,netdev=net0 -netdev user,id=net0 \
     -usb -device pci-ohci,id=ohci -device usb-storage,bus=ohci.0,drive=d0 \
     -drive file=/var/cache/buildbot/riscv64/rootfs.ext2,if=none,id=d0,format=raw \
     -append "root=/dev/sda rootwait console=ttyS0,115200 earlycon=uart8250,mmio,0x10000000,115200" \
     -nographic -monitor none

The problem is seen with various USB boot variants (ohcu, ehci, xhci, uas-ehci,
uas-xhci) and all SCSI controllers supported by qemu.

