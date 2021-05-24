Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F198838E313
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhEXJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:14:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36523 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXJOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:14:46 -0400
Received: by mail-io1-f69.google.com with SMTP id i15-20020a6bee0f0000b029043af67da217so25322208ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pgi2JLVCvhlhR/OUsqKkFhesvj8JKPlQ3TDGmLaru8Y=;
        b=BaIbGB0Ll+smsJSfNwmvidWH23plY6QjkvFzLj/JbviS82DOpYemrj0TFXuuwWydHV
         PaXgPF7hxw82AHxLl88isE6o7C8StYUG+0U6aNoXzx3xjxeOUT016/QlaeF5EDRePqdH
         3uLEuq7tWpr05PFKfJZa66ZOI69fwBkaHjeaRCuR0TmRGYDsM0+VNfH8/WfvhDYYlw0C
         lgFHxGEBMSakDV+JNDGkW9s1PsuxRQIOlMeCK5ELDe3JPGJBTRt317D47lnvDtycjDLI
         PTceC556L+TYLdbaIyD12t0IOSMdxN28kcBbJBBc78opdhf0RhywfxgIkwDyuWGizGq1
         1K1Q==
X-Gm-Message-State: AOAM530mByrmO7SWZnlJeKMYxM0N9XWRk42bFHpSjGZeo4q45Bswkpwt
        pq1BD8MKU0QCUiI8MMnzYXE4BELXw7/hmryshcp8snAjucMu
X-Google-Smtp-Source: ABdhPJy63Cua6MUscnPgVPif6Zww6dvKjWFOwpdR43kyo07f1DKKRl+MkMxstBj701sZ+Hyo4rhLiZvg7skOu+bX9OzIc2QOTi/v
MIME-Version: 1.0
X-Received: by 2002:a02:1c81:: with SMTP id c123mr24481489jac.42.1621847598261;
 Mon, 24 May 2021 02:13:18 -0700 (PDT)
Date:   Mon, 24 May 2021 02:13:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f96caf05c30fd10f@google.com>
Subject: [syzbot] WARNING in rtl28xxu_ctrl_msg/usb_submit_urb
From:   syzbot <syzbot+faf11bbadc5a372564da@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12a839d1d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
dashboard link: https://syzkaller.appspot.com/bug?extid=faf11bbadc5a372564da

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+faf11bbadc5a372564da@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80004380 doesn't match bRequestType c0
WARNING: CPU: 1 PID: 17 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
RSP: 0018:ffffc9000012ed50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881130d8058 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812a6013 RDI: fffff52000025d9c
RBP: ffff8881039b28c0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080004380
R13: 00000000000000c0 R14: ffff8881130d80a8 R15: ffff88813d761500
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002f52b38 CR3: 000000013d74a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 rtl28xxu_ctrl_msg+0x4b7/0x700 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:43
 rtl28xxu_identify_state+0xb6/0x320 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:624
 dvb_usbv2_probe+0x55b/0x7d0 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:947
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4b0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4b0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2556
 hub_port_connect drivers/usb/core/hub.c:5297 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5437 [inline]
 port_event drivers/usb/core/hub.c:5583 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5665
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
