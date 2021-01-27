Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59D3061E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbhA0RZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhA0RZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:25:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:24:34 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id n3so1402805qvf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+T9WW2t0eLXWm4ldUVqyOgoINJcqY85/YDqVsYwVYo=;
        b=OP+0zWLa5OcRmF9NbiZTz9TRF80TDeQo1M9ixIDxKmfEAfyLbmN/qZAMFyQO2hrofo
         epFkWL3OFNZ7Za6BtU+q4EkKnuIGNdPQldHf3HCz8FTFdqCncrbgYtZK95ponwrH0uUC
         4Stg5ofr6l1v0+jf2Y2xzjNPX+8t49pboUAQRWDJVhIOqHIhNWilCsvbXT20knAn+OOO
         0ZSRruP5OE3AxiyW7INFjAxAn90r1L2cBYtUFbyGxzckPyy4+63YvMNrrgWLd71bXjeO
         TahAXrUEhSv5/LT9aN4Ot50xhMJAHpLOMZZcVrEbSz9/Eu4OBRXruN3lRmHvYB77j23l
         kpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+T9WW2t0eLXWm4ldUVqyOgoINJcqY85/YDqVsYwVYo=;
        b=OwZfyvw5GedEBWzjX+M1zz1caRutiqAeg2m50RsEa0pZ/6tFcpzPR1BOAiKPFR0/zd
         7RSHbybQxA/c4iC/Z1efOLxW+nHW/wXYk6fIZMGHdl0FjgLt2sOfiPDnzUvhQzxxSaVE
         YTRkHLS/R7eNlmc139nwA3uTOKhtPwwrciT6a8QqpdOgDchjjNGcHOQqUf67Y8IQHd/c
         J7uUEi8t+4IdivHHWw7c8isSZxjBNZmUH4WB1dyTqmb9mRX9kDTn8s+mGf7fqW35iQj8
         tud71/7QmKUMdIosP2aQ1FVCIHxyBcJTfSa1gAgITcvur0+0hQoXzp3RGgvfSox/bq90
         eJGQ==
X-Gm-Message-State: AOAM532E6+U+aUBBc3P+L9Gw96qxQi0ZUAg3QN3u7Ed5oyp04eO0zD9e
        u96LwPkDIXyt6h7m96agl5l+xNubh85NVbG+jxjB/A==
X-Google-Smtp-Source: ABdhPJz/PbEPrEoNinOT51hgz9ZRZeQND/dn17pX3Yx6ZYswB3G5FPqwe1dGAeRgbYwjsXMyAPLmNHViQzWsyXhH1cQ=
X-Received: by 2002:a0c:fd8e:: with SMTP id p14mr11550426qvr.37.1611768273412;
 Wed, 27 Jan 2021 09:24:33 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck>
In-Reply-To: <20210127171453.GC358@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 18:24:22 +0100
Message-ID: <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
Subject: Re: WARNING in __do_kernel_fault
To:     Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:15 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 27, 2021 at 5:56 PM syzbot
> > <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> >
> > This happens on arm64 instance with mte enabled.
> > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > so I would assume it's just a plain NULL deref. Is this WARNING not
> > indicative of a kernel bug? Or there is something special about this
> > particular NULL deref?
>
> Congratulations, you're the first person to trigger this warning!
>
> This fires if we take an unexpected data abort in the kernel but when we
> get into the fault handler the page-table looks ok (according to the CPU via
> an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> handling of AT isn't quite right.

Hi Will,

Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
Do you see any way forward for this issue? Can somehow prove/disprove
it's qemu at fault?
The instance just started running, but it seems to be the most common
crash so far and it seems to happen on _all_ gpf's.
You can see all arm64 crashes so far here:
https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte
They all happen in reiserfs_security_init, but locally I got a bunch
of different stacks, e.g.:


------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff8000170f5fe0
WARNING: CPU: 1 PID: 16450 at arch/arm64/mm/fault.c:364
__do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
Modules linked in:
CPU: 1 PID: 16450 Comm: syz-executor.1 Not tainted 5.11.0-rc3 #36
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
pc : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
lr : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
sp : ffff800015443550
x29: ffff800015443550 x28: fcff00002db4bc00
x27: 0000000000000020 x26: 0000000000000001
x25: 0000000000000018 x24: 0000000000000008
x23: 0000000080400009 x22: ffff8000170f5fe0
x21: 0000000000000025 x20: ffff800015443620
x19: 0000000097800047 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 00003d8e94eba1ca x14: 0000000000000017
x13: 0000000000000017 x12: 0000000000000000
x11: 0000000000000010 x10: 68b6895a9d433f2e
x9 : f39ec128c34c6307 x8 : fcff00002db4ca98
x7 : f5ff00000e65a400 x6 : 000000403e245885
x5 : 0000000000000000 x4 : ffff00007dbe1948
x3 : ffff00007dbe84b0 x2 : ffff00007dbe1948
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
 do_bad_area arch/arm64/mm/fault.c:462 [inline]
 do_translation_fault+0x5c/0xc4 arch/arm64/mm/fault.c:662
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:792
 el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
 el1_sync_handler+0xb0/0xcc arch/arm64/kernel/entry-common.c:209
 el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
 sys_imageblit+0x3b4/0x440 drivers/video/fbdev/core/sysimgblt.c:275
 drm_fb_helper_sys_imageblit drivers/gpu/drm/drm_fb_helper.c:794 [inline]
 drm_fbdev_fb_imageblit+0x5c/0x80 drivers/gpu/drm/drm_fb_helper.c:2266
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x23c/0x470 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0xfc/0x120 drivers/video/fbdev/core/fbcon.c:1304
 do_update_region+0x158/0x1b4 drivers/tty/vt/vt.c:676
 invert_screen+0xe4/0x1f4 drivers/tty/vt/vt.c:800
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection drivers/tty/vt/selection.c:84 [inline]
 clear_selection+0x50/0x70 drivers/tty/vt/selection.c:80
 vc_do_resize+0x4f8/0x574 drivers/tty/vt/vt.c:1241
 vc_resize+0x24/0x30 drivers/tty/vt/vt.c:1346
 fbcon_do_set_font+0xd8/0x2c0 drivers/video/fbdev/core/fbcon.c:2402
 fbcon_set_font+0x200/0x260 drivers/video/fbdev/core/fbcon.c:2488
 con_font_set drivers/tty/vt/vt.c:4667 [inline]
 con_font_op+0x2b8/0x444 drivers/tty/vt/vt.c:4711
 vt_io_ioctl drivers/tty/vt/vt_ioctl.c:587 [inline]
 vt_ioctl+0x17b0/0x2020 drivers/tty/vt/vt_ioctl.c:817
 tty_ioctl+0xa60/0xe5c drivers/tty/tty_io.c:2658
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:158
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:204
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699


WARNING: CPU: 1 PID: 399 at arch/arm64/mm/fault.c:364
__do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
Modules linked in:

CPU: 1 PID: 399 Comm: syz-executor.1 Not tainted 5.11.0-rc3 #36
Hardware name: linux,dummy-virt (DT)
pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
pc : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
lr : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
sp : ffff800030b33a80
x29: ffff800030b33a80
x28: f0ff00000c0d4b00

x27: ffff800012d79098
x26: ffff80001333ce68

x25: f0ff00001aaa4a00
x24: faff00000f219680

x23: 0000000097810006 x22: 0000000000000114
x21: 0000000000000025 x20: ffff800030b33bb0
x19: 0000000097810006 x18: 0000000000000020
x17: 0000000000000000 x16: 0000000000000000
x15: f0ff00000c0d5010 x14: 6c656e72656b2073
x13: 756f697275707320 x12: 756166206e6f6974
x11: 616c736e61727420 x10: 6461206c61757472
x9 : 697620746120746c x8 : 3030303030303030
x7 : 3030207373657264 x6 : ffff8000132e79bf
x5 : 000000000000000a x4 : 0000000000000000
x3 : 0000000000000001 x2 : ffff00007dbe1950
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
 do_page_fault+0x1c0/0x3a0 arch/arm64/mm/fault.c:649
 do_translation_fault+0xb4/0xc4 arch/arm64/mm/fault.c:660
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:792
 el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
 el1_sync_handler+0xb0/0xcc arch/arm64/kernel/entry-common.c:209
 el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
 spin_unlock_irq include/linux/spinlock.h:404 [inline]
 io_ring_set_wakeup_flag fs/io_uring.c:6930 [inline]
 io_disable_sqo_submit+0x5c/0x90 fs/io_uring.c:8891
 io_uring_create fs/io_uring.c:9711 [inline]
 io_uring_setup+0x6b8/0xe10 fs/io_uring.c:9739
 __do_sys_io_uring_setup fs/io_uring.c:9745 [inline]
 __se_sys_io_uring_setup fs/io_uring.c:9742 [inline]
 __arm64_sys_io_uring_setup+0x20/0x30 fs/io_uring.c:9742
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:158
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:204
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
