Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB43C3D9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhGKP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:28:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56115 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhGKP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:28:06 -0400
Received: by mail-io1-f71.google.com with SMTP id i13-20020a5d88cd0000b02904e5ab8bdc6cso9827291iol.22
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NIgq3uh+Hjjwi2oxrtORLjfC9P7t2E8mL5wuw+P+97E=;
        b=Qi/fIgt6rrBSC1B74X+Pj0bBPKEdvyho/UKxtQFWYfzJmswzMUrHNicJUrFQLUcBeB
         bCZ4bXicUbI/KDwE60HA02ZWAKzmXbBX/jwbnoU8Q9y5UgZld2zcVSa0l6TRskgNrQ5p
         W/g3ahtRRnaMwfIFyTey0JtPGvLP+xSSs5R43+IHlZ1q5nN2bvpIrT1mlrD3byyLtAG3
         T1r+FNvhv7RlRNL2PTXgDFKVOKelXOcgFwcwWvvjr8JeApZzvhRE98BTNQAtEGRtfZed
         1GOiJvtggvWfq/So71tBTJ7EzoCQhJvdWUqe+MS1G3tYGNzF8PH458Koi/IYKUITIo33
         dX6Q==
X-Gm-Message-State: AOAM531yjsosW82GzYoXOmhIWtYcEqCW9fFbouVoKKl58fy8BRHO1IfK
        lf6swDNRPrhy0DovERBNZDNR/uhCdHSyln3ez00Px3K3AW/q
X-Google-Smtp-Source: ABdhPJyWaAHrLW1elRgVV+7cbOyIFhtTK+7A6xQtj6HSJZmbYtmoamFG2SdlnBtuSsx7DOKuaq+rx3Scb9mqmuTjz3F6yV3k3NfR
MIME-Version: 1.0
X-Received: by 2002:a5e:dd42:: with SMTP id u2mr25445953iop.135.1626017119844;
 Sun, 11 Jul 2021 08:25:19 -0700 (PDT)
Date:   Sun, 11 Jul 2021 08:25:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3be7905c6da9c25@google.com>
Subject: [syzbot] WARNING in usb_remove_ep_devs
From:   syzbot <syzbot+a0c54eb26c7b8130c9b9@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7756f1d6 phy: qcom-qusb2: Add configuration for SM4250 and..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15d03bac300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df8c74fda98ee5f
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c54eb26c7b8130c9b9

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0c54eb26c7b8130c9b9@syzkaller.appspotmail.com

usb 6-1: ath9k_htc: USB layer deinitialized
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 7255 at kernel/locking/mutex.c:941 __mutex_lock_common kernel/locking/mutex.c:941 [inline]
WARNING: CPU: 0 PID: 7255 at kernel/locking/mutex.c:941 __mutex_lock+0xb8d/0x1080 kernel/locking/mutex.c:1104
Modules linked in:
CPU: 0 PID: 7255 Comm: kworker/0:7 Not tainted 5.13.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:941 [inline]
RIP: 0010:__mutex_lock+0xb8d/0x1080 kernel/locking/mutex.c:1104
Code: 08 84 d2 0f 85 ab 04 00 00 8b 05 46 7c b6 02 85 c0 0f 85 8f f5 ff ff 48 c7 c6 60 3a 07 86 48 c7 c7 20 38 07 86 e8 22 77 d3 ff <0f> 0b e9 75 f5 ff ff 65 48 8b 1c 25 40 ef 01 00 be 08 00 00 00 48
RSP: 0018:ffffc9000566f810 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812a6723 RDI: fffff52000acdef4
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b9bef R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888147adc120 R14: ffff88811a3e10a8 R15: ffff88810f5fe008
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005635c64e9457 CR3: 000000013faf2000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 device_lock include/linux/device.h:763 [inline]
 device_del+0x9e/0xd40 drivers/base/core.c:3502
 device_unregister+0x22/0xc0 drivers/base/core.c:3573
 usb_remove_ep_devs+0x3e/0x80 drivers/usb/core/endpoint.c:188
 usb_disconnect.cold+0x4ab/0x791 drivers/usb/core/hub.c:2240
 hub_port_connect drivers/usb/core/hub.c:5151 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
