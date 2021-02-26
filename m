Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1F326026
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBZJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:35:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:34874 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBZJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:33:56 -0500
Received: by mail-io1-f69.google.com with SMTP id a1so6714208ios.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=THYLeXXwOJM3i5c20cB4pRajHL018nJ1FMhoVbpcroA=;
        b=dlb1lwsalz7u0pkEHGkHYx42iCf1s/MHXugf2vugnGbyArBVJroeKjaSO7swjSRTZ/
         hvgtXR7NIFGJRei12cZZ4lUCSL1L5OV767rnEWLag3DDsHh4M9rKryK6BUxlFLFpGLxo
         4DcNGYw2DmEYyxssowbdiTW9KF/ex41A7sWmeIhvuYPpVxvLTz729zcMWzNd2J08NbUW
         riYyJoERGVfDicDdsMTR9KZ20Gf2i1ljEJmMd6R5QEqjPIWLpFpYoE5kjX3YVNbw1ya9
         xY9ki62pSlXKvk+5NKd4gh17qZZxEkA6iYjc4lnjDr2bNTH273RqSlvngqw9STfxu652
         0oOg==
X-Gm-Message-State: AOAM531BhYSKUqb6tMtzLR+PNVn3gjXv1h9SICumDVVM9oQyJQMWRlB1
        8OAvfpyMqiOwYul9EUhaHa7zHAcKQzQ8pzqi6KuHl/sN+6O+
X-Google-Smtp-Source: ABdhPJzRcavYFpGfLxQpLP1P+swzqB8AKNY3SwOzdv5E40P+CYLZcbFX+yau32xAelk9H2pNA6xFQcJoYr43OiIRIgdBvv73Bbnd
MIME-Version: 1.0
X-Received: by 2002:a02:4c8:: with SMTP id 191mr2031284jab.27.1614331995416;
 Fri, 26 Feb 2021 01:33:15 -0800 (PST)
Date:   Fri, 26 Feb 2021 01:33:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022ebeb05bc39f582@google.com>
Subject: KASAN: null-ptr-deref Write in io_uring_cancel_sqpoll
From:   syzbot <syzbot+be51ca5a4d97f017cd50@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d01f2f7e Add linux-next specific files for 20210226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108dc5a8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1746d2802a82a05
dashboard link: https://syzkaller.appspot.com/bug?extid=be51ca5a4d97f017cd50

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be51ca5a4d97f017cd50@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc include/asm-generic/atomic-instrumented.h:240 [inline]
BUG: KASAN: null-ptr-deref in io_uring_cancel_sqpoll+0x2c7/0x450 fs/io_uring.c:8871
Write of size 4 at addr 0000000000000110 by task iou-sqp-19439/19447

CPU: 0 PID: 19447 Comm: iou-sqp-19439 Not tainted 5.11.0-next-20210226-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:403 [inline]
 kasan_report.cold+0x5f/0xd8 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/asm-generic/atomic-instrumented.h:240 [inline]
 io_uring_cancel_sqpoll+0x2c7/0x450 fs/io_uring.c:8871
 io_sq_thread+0x1109/0x1ae0 fs/io_uring.c:6782
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 19447 Comm: iou-sqp-19439 Tainted: G    B             5.11.0-next-20210226-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 panic+0x306/0x73d kernel/panic.c:231
 end_report mm/kasan/report.c:102 [inline]
 end_report.cold+0x5a/0x5a mm/kasan/report.c:88
 __kasan_report mm/kasan/report.c:406 [inline]
 kasan_report.cold+0x6a/0xd8 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/asm-generic/atomic-instrumented.h:240 [inline]
 io_uring_cancel_sqpoll+0x2c7/0x450 fs/io_uring.c:8871
 io_sq_thread+0x1109/0x1ae0 fs/io_uring.c:6782
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
