Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28123F1F32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhHSRfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:35:48 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44583 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:35:47 -0400
Received: by mail-io1-f70.google.com with SMTP id d15-20020a0566022befb02905b2e9040807so3727353ioy.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0R0ynF43DtKfVAQyXYymDNkQJ+FRIubVXxPXYp+aqZI=;
        b=fvoIRIOXbjxMo50W3QxQkEcg3FVFleCYKVOcpSX1SSIDOeQWNZ5XmJyPGV+JgAJq1n
         OJh6ee3EaGMfYTm+qa5YJU4wI/nAzj48mERO7ypBN/plJOJOQ6wmjpCh8UReO5jM16xU
         iDw9rR3YhXizArHeU2gVM68OePtxBHlKA7rCa8tX2YNQiZy57XTAwjLp6VQHcFhDlqHc
         jdSZmwEzHkS4RvKvHJCyxEXfiqFcXfPK5NCTySN8G23lzP/cRmEs+V70EoV4ySEkr2bM
         njgptWCEr7X3jis9hqlQ7AKd5icwp9NXheKqk02Lf7FOeKaUO5uIZ24y2BZe1rvwo/VH
         0zew==
X-Gm-Message-State: AOAM531KkvAby3l+CAsxE45Owq9JZM4ziHVNbbul2TKCvvsWBVsdtquE
        dbVbojXXVc0JB1A9KWSHuv9jZjxZLnLILi6vh2b3xePIWmio
X-Google-Smtp-Source: ABdhPJw8Bjt4ozl2ih3lb1x5m4i+6rJZmPurJG6acmUbTq0ERyKk1NNV3YKmQ7+k0bAXNnufrtr26ZGP5E/hWZG71IyusrvShCv3
MIME-Version: 1.0
X-Received: by 2002:a5d:8596:: with SMTP id f22mr12778912ioj.147.1629394511191;
 Thu, 19 Aug 2021 10:35:11 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:35:11 -0700
In-Reply-To: <20210819152626.GD228422@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009e24705c9ecf9b3@google.com>
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
From:   syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mkubecek@suse.cz,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hid_submit_ctrl/usb_submit_urb

cm6533_jd 0003:0D8C:0022.0001: submit_ctrl: maxpacket 64 len 0 padlen 0
------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType a1
WARNING: CPU: 0 PID: 10203 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 0 PID: 10203 Comm: syz-executor.0 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 45 64 1f fc 48 8b 7c 24 40 e8 4b fc 0b ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 e0 b2 27 8a e8 01 ec 91 03 <0f> 0b e9 a5 ee ff ff e8 17 64 1f fc 0f b6 1d 59 ca 01 08 31 ff 41
RSP: 0018:ffffc9000a7f7bd0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888033e83058 RCX: 0000000000000000
RDX: ffff88802bfd8000 RSI: ffffffff815d85c5 RDI: fffff520014fef6c
RBP: ffff8880168b2410 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d23fe R11: 0000000000000000 R12: ffff8880217a0230
R13: 00000000000000a1 R14: 0000000080000280 R15: ffff88801803aa00
FS:  00007f92577f8700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000050eab0 CR3: 000000003dd81000 CR4: 0000000000350ef0
Call Trace:
 hid_submit_ctrl+0x6db/0xa70 drivers/hid/usbhid/hid-core.c:418
 usbhid_restart_ctrl_queue.isra.0+0x244/0x3a0 drivers/hid/usbhid/hid-core.c:258
 __usbhid_submit_report+0x6f0/0xd50 drivers/hid/usbhid/hid-core.c:605
 usbhid_submit_report drivers/hid/usbhid/hid-core.c:642 [inline]
 usbhid_init_reports+0xd7/0x3b0 drivers/hid/usbhid/hid-core.c:782
 hiddev_ioctl+0xb27/0x1630 drivers/hid/usbhid/hiddev.c:689
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92577f8188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 0000000000004805 RDI: 0000000000000004
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffcad46f49f R14: 00007f92577f8300 R15: 0000000000022000


Tested on:

commit:         794c7931 Merge branch 'linus' of git://git.kernel.org/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107e8c99300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=9b57a46bf1801ce2a2ca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dde499300000

