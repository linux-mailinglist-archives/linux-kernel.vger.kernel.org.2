Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCF433FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhJSUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:46:40 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54093 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhJSUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:46:38 -0400
Received: by mail-io1-f69.google.com with SMTP id g9-20020a056602150900b005d6376bdce7so14185579iow.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7/QuVQVY77P8PX5pIWl+8vwMQXGJf7/M09+1P7+2iO4=;
        b=DeYIf1GBcQumMsemdu9JEB84XXjTbb6h41Y3I5FD3mE7Uvu7gob1DtMPb6PQoAwNOD
         PNhZ2NCvRLmQC0pjVk1OA6g/BA21PdJPLyKZ9fxcftHqA1++MiqhGhGr0hOnjiZBNdQJ
         AYp/ov8VVVA5ri6tHrkH7nA1/iK68KtORtflUwzLw2zzTcFVJUET3IlOIu4/DEs0pVES
         54txMxm5aDdcTxsEnkBTUlX6Vq4UvVw17SXUKh8bt4W/CvsMyvwsb6MU4jKcOvRxFc1g
         +n48UOrDFhXaXLsVjt8zDaNrXV3rxT8LLblQbAlUmg97DToBAdLJ7EF8T6T50pyqAqlm
         9PVg==
X-Gm-Message-State: AOAM5313gOat7P9RQBK8CjedZRpxz1W1DVPM2zEqKErw4CW3Kdzn+Ur+
        TFC0IdFm6OAGuWKfM3enLf2R+D5As3mUC8T3XjAiH7rxIGws
X-Google-Smtp-Source: ABdhPJwUnO5eC01NJJ+51z35GWixE8YfGC8soh8Wa0tgMNOZv2+nFmpEyYsOPA1yKxLgJczX0lhD1C/cXA/4y8x7KMx84JfdIfGJ
MIME-Version: 1.0
X-Received: by 2002:a6b:148:: with SMTP id 69mr19869569iob.54.1634676264799;
 Tue, 19 Oct 2021 13:44:24 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001611e605cebabab5@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in ehci_hub_control
From:   syzbot <syzbot+9df2568864dedf79db36@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d999ade1cc86 Merge tag 'perf-tools-fixes-for-v5.15-2021-10..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d85d34b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5d8cfd89abd92bf
dashboard link: https://syzkaller.appspot.com/bug?extid=9df2568864dedf79db36
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9df2568864dedf79db36@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in drivers/usb/host/ehci-hub.c:754:39
index 254 is out of range for type 'u32 [15]'
CPU: 0 PID: 11514 Comm: syz-executor.1 Not tainted 5.15.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:291
 ehci_hub_control+0x22ad/0x2720 drivers/usb/host/ehci-hub.c:754
 rh_call_control drivers/usb/core/hcd.c:683 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
 usb_hcd_submit_urb+0xcaf/0x22d0 drivers/usb/core/hcd.c:1544
 usb_submit_urb+0x86d/0x18a0 drivers/usb/core/urb.c:594
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 do_proc_control+0x40a/0x9f0 drivers/usb/core/devio.c:1165
 proc_control drivers/usb/core/devio.c:1191 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2540 [inline]
 usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2713
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fdbaec43a39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdbac1b9188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdbaed46f60 RCX: 00007fdbaec43a39
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 00007fdbaec9dc5f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5b9cffbf R14: 00007fdbac1b9300 R15: 0000000000022000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
