Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73235311699
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhBEXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:07:10 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197]:51463 "EHLO
        mail-pg1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhBEOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:35:49 -0500
Received: by mail-pg1-f197.google.com with SMTP id z20so5397739pgh.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=COK0jar7QCaPbpiILJ8gBR8WTNlmrabRXDL400SLEHU=;
        b=CJ1UlgnQO4RkxHQVvLmPLW8+qQi5W1Ms+33b+8I8Zkh7ORVB9+eMBGVvtfPBuPxaUk
         CnqbaefOMIEMAEMWRoJdQKHISO2VceQ9BUSKDGeOMgvPeI37pHfmRYwMlJbRNkcHs4Tv
         yvv5bzxox35lpeUL7pHD4ep5ubfjXVcmfKNnXv+KYnn1JcjUx3stipfYmHc2yr3uLa69
         wpuOmBM5pYnz1LOf1HzH1iZKSLOKU/ErQS9/wM4wlKH2RiLoAEOH6TMRTSn36hLCyNqF
         08lmlvxPGZ477Obu6xIAtfKM007yJtD+0VNYNXLrpy+/soaWhP10Fbb/74gm7ZE2vwt7
         gb7A==
X-Gm-Message-State: AOAM5324jgOW+2Y6rfoptQHjxNXuOrKr3sMnVqKE9wr2WStn0LKJPSKB
        zavbE06JEA+tR2vEgruxRU/Gn+cTyOeutnXYmaLnnSXu4FJ4
X-Google-Smtp-Source: ABdhPJy3pstMGPURM6PMaQSauQLwpFDbN8XmssQ/05c82tcTlHUCJKCKg/IIQTdVlyROKtWpJqZRfSaQoDe3s/B61QgyC6LcijL3
MIME-Version: 1.0
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr4528032ioc.158.1612536620371;
 Fri, 05 Feb 2021 06:50:20 -0800 (PST)
Date:   Fri, 05 Feb 2021 06:50:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071d34805ba97f0f4@google.com>
Subject: kernel BUG in attach_store
From:   syzbot <syzbot+a30e620779ec2718f731@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0e2c50f4 Add linux-next specific files for 20210204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1294915f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5009c5bf1512a87
dashboard link: https://syzkaller.appspot.com/bug?extid=a30e620779ec2718f731
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1047b68cd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150f3f6f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a30e620779ec2718f731@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at drivers/usb/usbip/vhci_sysfs.c:396!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9885 Comm: syz-executor837 Not tainted 5.11.0-rc6-next-20210204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:attach_store.cold+0x376/0x396 drivers/usb/usbip/vhci_sysfs.c:396
Code: e8 b9 3d d0 f8 48 8b 5d 70 48 c7 c7 00 f0 ff ff 48 89 de e8 66 97 8c f8 48 81 fb 00 f0 ff ff 0f 87 56 ff ff ff e8 64 8f 8c f8 <0f> 0b e8 5d 8f 8c f8 8b b4 24 90 00 00 00 48 89 ef e8 fe 31 b4 fc
RSP: 0018:ffffc9000ad47b58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880206c1c00 RCX: 0000000000000000
RDX: ffff888020909c00 RSI: ffffffff88e65b5c RDI: 0000000000000003
RBP: ffff8881445785d0 R08: fffffffffffff000 R09: ffff88802282d8a7
R10: ffffffff88e65b4a R11: 000000000000003f R12: fffffffffffffffc
R13: ffff888144578640 R14: ffff8881445785e8 R15: ffff888031a38fc0
FS:  00007f294068c700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004df500 CR3: 0000000029449000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dev_attr_store+0x50/0x80 drivers/base/core.c:1936
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:1977 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:519
 vfs_write+0x791/0xa30 fs/read_write.c:606
 ksys_write+0x12d/0x250 fs/read_write.c:659
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x40b5ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 cc fd ff ff 48
RSP: 002b:00007f294068bd60 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 000000000040b5ff
RDX: 0000000000000008 RSI: 00007f294068bdb0 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f294068bd00
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f294068bdb0
R13: 0000000000000000 R14: 00007f294068c400 R15: 0000000000022000
Modules linked in:

---[ end trace 375e0f0107ff6180 ]---
RIP: 0010:attach_store.cold+0x376/0x396 drivers/usb/usbip/vhci_sysfs.c:396
Code: e8 b9 3d d0 f8 48 8b 5d 70 48 c7 c7 00 f0 ff ff 48 89 de e8 66 97 8c f8 48 81 fb 00 f0 ff ff 0f 87 56 ff ff ff e8 64 8f 8c f8 <0f> 0b e8 5d 8f 8c f8 8b b4 24 90 00 00 00 48 89 ef e8 fe 31 b4 fc
RSP: 0018:ffffc9000ad47b58 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff8880206c1c00 RCX: 0000000000000000
RDX: ffff888020909c00 RSI: ffffffff88e65b5c RDI: 0000000000000003
RBP: ffff8881445785d0 R08: fffffffffffff000 R09: ffff88802282d8a7
R10: ffffffff88e65b4a R11: 000000000000003f R12: fffffffffffffffc
R13: ffff888144578640 R14: ffff8881445785e8 R15: ffff888031a38fc0
FS:  00007f294068c700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d1974 CR3: 0000000029449000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
