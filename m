Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAA399661
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFBXcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:32:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40955 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:32:13 -0400
Received: by mail-il1-f198.google.com with SMTP id b4-20020a920b040000b02901dc81bf7e72so2758438ilf.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 16:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GV/AIilugT/5Wz21/OeFjAxmdYQUrgH8hNHBx1xl4tE=;
        b=c9tqne39KCMIuLsrSxydDAZASyMyY0SVB13aMWwpxszmE5AkT4lHviHLqtCwpd6erh
         lwnkJ6rCySHS/QWLLfFf+PzMnj5SdgE+6PvtyTuDclo6HSmfiAetBUuDiGaZn0OKp0fy
         dDeA+PTYicdrfaSW25DSWmefrZfZf5XR7zEFoR07BgWtN9CjdqXfIrXNbs4cbsnD0T4I
         MMILXz6newVLY7TBVTvUd3k++MpWcPTPS0MG2bGQ53Fmtx621E6w9+iQZ2/u+/R79zN/
         TTqGRI2R7ysgdtN3TRpMm2vwTAeytwIbfT06ml5SEqkxiteaCj15LdgpLq8P1enpK2R3
         +B0w==
X-Gm-Message-State: AOAM530w4PcXeCTUiGjC/Uf5Z5VRABcjTOX/K2ujjDCPJuB7eCmiSb4w
        tAk6yqtenXz4HDXhUcUZSAGhZjK+qVNF3WTQSuW4WA3uhgMF
X-Google-Smtp-Source: ABdhPJxqU+rOJRL6YlsRpunbQ/cpyxY5eqC1jGAZ0e+/gdIi4VMGzYIxusIiE9R5EWCIzde2SfZ+eetA9w3q/AoUmZm8qL1vvVPe
MIME-Version: 1.0
X-Received: by 2002:a92:9411:: with SMTP id c17mr29886165ili.264.1622676618984;
 Wed, 02 Jun 2021 16:30:18 -0700 (PDT)
Date:   Wed, 02 Jun 2021 16:30:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075c23d05c3d0d730@google.com>
Subject: [syzbot] WARNING in usb_new_device/usb_submit_urb
From:   syzbot <syzbot+7dbcd9ff34dc4ed45240@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7652dd2c USB: core: Check buffer length matches wLength fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1712b99dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
dashboard link: https://syzkaller.appspot.com/bug?extid=7dbcd9ff34dc4ed45240
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b82e13d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac418dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7dbcd9ff34dc4ed45240@syzkaller.appspotmail.com

usb 1-1: config 0 interface 186 altsetting 4 has a duplicate endpoint with address 0x8, skipping
usb 1-1: config 0 interface 166 has no altsetting 0
usb 1-1: config 0 interface 186 has no altsetting 0
------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType 80
WARNING: CPU: 1 PID: 2632 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 2632 Comm: kworker/1:2 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 c5 1f b3 fd 48 8b 7c 24 40 e8 6b a6 1b ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 80 0a 63 86 e8 15 ec fb 01 <0f> 0b e9 a5 ee ff ff e8 97 1f b3 fd 0f b6 1d db a7 34 05 31 ff 41
RSP: 0018:ffffc90000207680 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881182df058 RCX: 0000000000000000
RDX: ffff888114871b40 RSI: ffffffff812a6033 RDI: fffff52000040ec2
RBP: ffff88810cfffc80 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b998b R11: 0000000000000000 R12: ffff88810cfff6b8
R13: 0000000000000080 R14: 0000000080000280 R15: ffff88810e736f00
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13a00114f0 CR3: 0000000108807000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usb_get_string+0xa6/0x190 drivers/usb/core/message.c:837
 usb_string_sub+0x35e/0x3d0 drivers/usb/core/message.c:883
 usb_get_langid drivers/usb/core/message.c:913 [inline]
 usb_string+0x1cc/0x540 drivers/usb/core/message.c:977
 usb_cache_string+0x82/0x120 drivers/usb/core/message.c:1023
 usb_enumerate_device drivers/usb/core/hub.c:2399 [inline]
 usb_new_device+0x15b/0x7d0 drivers/usb/core/hub.c:2527
 hub_port_connect drivers/usb/core/hub.c:5298 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5438 [inline]
 port_event drivers/usb/core/hub.c:5584 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5666
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
