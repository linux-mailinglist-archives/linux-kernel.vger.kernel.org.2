Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362E7347F99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhCXRgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:36:46 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41060 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhCXRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:36:15 -0400
Received: by mail-io1-f72.google.com with SMTP id n1so1922816iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=d3+3d6jtDAfbf+GrVq1Qg39NvVvFXf+9538V36yRUSU=;
        b=FqN1s9klHm/JusYcHwLquZcOE9xxSi9oWhxaBvoiYmTixODjIKgqEYjZEbjYWM12e8
         FJpCnhMHsu8PGhehHsn6IxXInHU8kf5oBEUGpVrJhcHM4jHYbhJxkVUZnyF3kC/OJjSM
         an8fTCzQj79wIOKmruyXcW2XctxmvvzQTp4pwMs5kGrqHRtPV1gdXWsD3prcnXdKVt4Z
         RoyiiWQFsvGaswiLwt8ZrZbEkxoU/iflNYw5pYMiLn4YocXn+bSkd6BFdtZifZjRIKuc
         HSsF7DaD7/eFadhYC+krYCOJOJqohB8HTa+zy1fk/V9Jxuu8+zql8rc7ptDiy4v2so86
         YFwA==
X-Gm-Message-State: AOAM531UT8n7/Im+kybDITYKRsUt2w+D3EEdTW1jlzoVLye8wuY5B/Wz
        PFlkFOoJtqrMpsFfnotqb5NmyubMDCIEqj19ZoAOZoM8umpU
X-Google-Smtp-Source: ABdhPJxsi/nKXBOjK9tKvCSkjNR1gE52sVVkbu7LTJLTQBAOqNn/1bIURKBzhOmyPltX4xwB0IKh/VWOKGvqjov4yWz8/ppbJf8I
MIME-Version: 1.0
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr3281038iop.50.1616607374591;
 Wed, 24 Mar 2021 10:36:14 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:36:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dcb8c05be4bbcf8@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in vhci_hub_control (2)
From:   syzbot <syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    84196390 Merge tag 'selinux-pr-20210322' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ea778ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5adab0bdee099d7a
dashboard link: https://syzkaller.appspot.com/bug?extid=3dea30b047f41084de66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15449662d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f81026d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in drivers/usb/usbip/vhci_hcd.c:605:42
shift exponent 768 is too large for 32-bit type 'int'
CPU: 0 PID: 8421 Comm: syz-executor852 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 vhci_hub_control.cold+0x20b/0x5f0 drivers/usb/usbip/vhci_hcd.c:605
 rh_call_control drivers/usb/core/hcd.c:683 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
 usb_hcd_submit_urb+0xcaf/0x22d0 drivers/usb/core/hcd.c:1544
 usb_submit_urb+0x6e4/0x1540 drivers/usb/core/urb.c:585
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 do_proc_control+0x4af/0x980 drivers/usb/core/devio.c:1165
 proc_control drivers/usb/core/devio.c:1191 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2535 [inline]
 usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443499
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd96535f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443499
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 0000000000403040 R08: 0000000000000000 R09: 00000000004004a0
R10: 000000000000000f R11: 0000000000000246 R12: 00000000004030d0
R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
