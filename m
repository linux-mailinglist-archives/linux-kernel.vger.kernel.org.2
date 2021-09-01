Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756863FE5E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbhIAW6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:58:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37727 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhIAW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:58:16 -0400
Received: by mail-io1-f72.google.com with SMTP id h3-20020a056602008300b005b7c0e23e11so38423iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JzvGf/ZVsO1K+NhAfNaPsZwtB/ckIo0GMG+20Hi/iqI=;
        b=gNB0oJQOapO0ma7B1mhvrdljP/CGYMp4oTJapHudj/q9gK3Ir1GZHHWvOgWAUoTKEX
         g6i2R8OH4uKInBRxPZV4umZ0x3U8nnnzV1l73NiuMhF6XWOihZOBvmjlJr+daTE6Fsth
         DnGs1h7/3Xf4HfDLsqKZHNlF/smL6T3hV25tBRxDX2xL/PTAbZGaRGI49cwucf74regU
         asUHaTw75SZrt/y3qO9ktM9OzglNlODwwW/f1PusTn20TFnK7QG3u5+lPKzSPqyTInSL
         8/o6vQMqNpJdp95RGHYzRzAsDdq+ksl7ED92Cs5u0nNfUEXuOIXZQ0RyCl2mDqduQzwI
         MPqw==
X-Gm-Message-State: AOAM530y0EmNGz0Eue9wIbBYCSMiGYruBZJ3aIPlSOMzUdMNSq1wvRDR
        uFfcL3kRYISU83zNfFmttDazH5IJEshbPuutRRnGbKHZtq05
X-Google-Smtp-Source: ABdhPJxxydaj2qVdJGcTWNWOC0RkCOqYZYrKfwzYt3Mem6Lq4W0obWV6dYAXHZZ+C8Y525O6vrUhpfnLov5HW7B1LCA5aVKI92Na
MIME-Version: 1.0
X-Received: by 2002:a5e:dd42:: with SMTP id u2mr165245iop.157.1630537039084;
 Wed, 01 Sep 2021 15:57:19 -0700 (PDT)
Date:   Wed, 01 Sep 2021 15:57:19 -0700
In-Reply-To: <00000000000034712e05ca9741e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002044305caf6fd02@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1374b85d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c32e23fada3a0e4
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fde215300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa9149300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com

Bluetooth: : Invalid header checksum
Bluetooth: : Invalid header checksum
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
BUG: KASAN: null-ptr-deref in __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
Write of size 4 at addr 0000000000000388 by task kworker/u4:4/244

CPU: 1 PID: 244 Comm: kworker/u4:4 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 __kasan_report mm/kasan/report.c:423 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
 __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
 pm_runtime_get include/linux/pm_runtime.h:370 [inline]
 h5_recv+0x2c4/0x680 drivers/bluetooth/hci_h5.c:590
 hci_uart_tty_receive+0x24d/0x710 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x14d/0x190 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x6e/0xa0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x20d/0x380 drivers/tty/tty_buffer.c:543
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 244 Comm: kworker/u4:4 Tainted: G    B             5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 panic+0x306/0x73d kernel/panic.c:232
 end_report mm/kasan/report.c:103 [inline]
 end_report.cold+0x5a/0x5a mm/kasan/report.c:88
 __kasan_report mm/kasan/report.c:426 [inline]
 kasan_report.cold+0x71/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
 __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
 pm_runtime_get include/linux/pm_runtime.h:370 [inline]
 h5_recv+0x2c4/0x680 drivers/bluetooth/hci_h5.c:590
 hci_uart_tty_receive+0x24d/0x710 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x14d/0x190 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x6e/0xa0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x20d/0x380 drivers/tty/tty_buffer.c:543
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Kernel Offset: disabled
Rebooting in 86400 seconds..

