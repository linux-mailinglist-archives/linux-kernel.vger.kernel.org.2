Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BA454037
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKQFdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:33:25 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40650 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhKQFdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:33:24 -0500
Received: by mail-io1-f71.google.com with SMTP id d12-20020a0566022d4c00b005ebda1035b1so733584iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=98wsYtbJBUxkht3umTVN37OFtkvVEcsR/ACRagqyIuQ=;
        b=YoaZcP/7dNj12IbX+KCn30C7d4vWY0FaJ2cKuWqYij0wF7dARca5NmdsLa37Boa4Ym
         DyZyEmbH3yJDUbVv7nqFJQCcM//CAaIiMuw6VioQPoik92l/8Xr9yRzjVTapGrIeI8Co
         ggD/eqKjqlGaJ5MTRsnKigE85AP9GQT5LBK6D6GBBTnpu6d7b2l4o2M6I5TerXGwPnFt
         fi1Nf5ql9shQ7llkyhRng1kKTEo76QofSs2DKqmzHZ3W2+S/GfYKGdp64PwveaZT7mOq
         /43m5YXwU7f2KhhZxZVtbTPypMSBkZTlf1nKZIZpjHYYOOjEghKQGMivTwR0NMI/NOyz
         R43A==
X-Gm-Message-State: AOAM530+zj5H05V+NH5gkQ006XpNeN1LS0v9r8EU75EWj0rpIH/gPzWR
        3HNHko3/6Boq5aCpOAZJWUL3k26T6SvlplATPE458Z4mkqTN
X-Google-Smtp-Source: ABdhPJycSOZLGUCjaAzL3w514tBVrxdhDrcHoeYsPtalFkNNj/1Kak2QUizVn6V9rlOjYCHHP73MTK8o0q3ANBMBzpzdsNSSHkvM
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cce:: with SMTP id j14mr8963580iow.67.1637127026653;
 Tue, 16 Nov 2021 21:30:26 -0800 (PST)
Date:   Tue, 16 Nov 2021 21:30:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0400405d0f5563a@google.com>
Subject: [syzbot] WARNING in kvm_dirty_ring_push
From:   syzbot <syzbot+ae494efef39fa113ab5b@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7246f4dcaccc tools/lib/lockdep: drop liblockdep
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1297f26eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=ae494efef39fa113ab5b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae494efef39fa113ab5b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 25218 at arch/x86/kvm/../../../virt/kvm/dirty_ring.c:164 kvm_dirty_ring_push+0x3bf/0x490 arch/x86/kvm/../../../virt/kvm/dirty_ring.c:164
Modules linked in:
CPU: 0 PID: 25218 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_dirty_ring_push+0x3bf/0x490 arch/x86/kvm/../../../virt/kvm/dirty_ring.c:164
Code: 00 48 c7 c2 c0 4b 82 89 be 7a 01 00 00 48 c7 c7 00 4d 82 89 c6 05 66 7c 51 0c 01 e8 2a 17 ed 07 e9 76 ff ff ff e8 81 07 6d 00 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 0f b6 04
RSP: 0018:ffffc9001814f690 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000400 RCX: ffffc9000ab83000
RDX: 0000000000040000 RSI: ffffffff810abeef RDI: 0000000000000003
RBP: ffff888033a8a1b8 R08: 0000000000000400 R09: 0000000000000001
R10: ffffffff810abbd3 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000400 R15: ffff888033a8a1c0
FS:  00007f02f9b0c700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003b0be000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mark_page_dirty_in_slot arch/x86/kvm/../../../virt/kvm/kvm_main.c:3090 [inline]
 mark_page_dirty_in_slot arch/x86/kvm/../../../virt/kvm/kvm_main.c:3081 [inline]
 __kvm_write_guest_page+0x2e3/0x3b0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2875
 kvm_vcpu_write_guest_page arch/x86/kvm/../../../virt/kvm/kvm_main.c:2893 [inline]
 kvm_vcpu_write_guest+0x88/0x120 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2927
 emulator_write_phys arch/x86/kvm/x86.c:6674 [inline]
 write_emulate+0x2f/0x70 arch/x86/kvm/x86.c:6714
 emulator_read_write_onepage+0x3bb/0xb30 arch/x86/kvm/x86.c:6782
 emulator_read_write+0x1c4/0x5a0 arch/x86/kvm/x86.c:6837
 segmented_write.isra.0+0xee/0x140 arch/x86/kvm/emulate.c:1391
 writeback+0x612/0x950 arch/x86/kvm/emulate.c:1753
 x86_emulate_insn+0x19f5/0x39c0 arch/x86/kvm/emulate.c:5626
 x86_emulate_instruction+0x714/0x1460 arch/x86/kvm/x86.c:8058
 handle_io arch/x86/kvm/vmx/vmx.c:4934 [inline]
 handle_io+0x11d/0x1d0 arch/x86/kvm/vmx/vmx.c:4922
 __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6066 [inline]
 vmx_handle_exit+0x4be/0x1860 arch/x86/kvm/vmx/vmx.c:6083
 vcpu_enter_guest+0x2b2c/0x4410 arch/x86/kvm/x86.c:9878
 vcpu_run arch/x86/kvm/x86.c:9945 [inline]
 kvm_arch_vcpu_ioctl_run+0x4fc/0x21a0 arch/x86/kvm/x86.c:10140
 kvm_vcpu_ioctl+0x570/0xf30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3787
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f02fc596ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02f9b0c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f02fc6a9f60 RCX: 00007f02fc596ae9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00007f02fc5f0f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f02fcbddb2f R14: 00007f02f9b0c300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
