Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2828447639
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 23:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhKGWQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 17:16:01 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50931 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhKGWQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 17:16:00 -0500
Received: by mail-io1-f70.google.com with SMTP id e14-20020a6bf10e000000b005e23f0f5e08so203527iog.17
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 14:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bPfsg/Agpm0y6CwU65DpRj7Amo5nv5xgnrhep6n5zOk=;
        b=sJK8FjZ6IMAHOhKGIQlvxGUOAJHpPFwDxrwiFPwm41gpb68aFEwk8jiCn5L2b7QWzb
         QbPBNgZt1YePm8bfTfLb0z0SWgo3NrpStjI/HYs36p/JN0PcjHdfzeIoP9/smMToIzFI
         CmtmVG/ZECyfo53bwU9GFDCe8EWfB1tWayW7uVVeBs++MJUofD3Pij/hBVU6AbCj/hFT
         Rzk1kpcdktkeoVlYUu7HkPig4cwT9gD8uXpVng7jjeFk1rvWODV6G1socg7Mhpof2dVP
         Y9DJaMQiCDQ6PxlYqY73j3E92O9UOgaCGrk7Rz8aZH22N9WSCkSaZQv/cKljVM4bD7Wk
         GW7g==
X-Gm-Message-State: AOAM5321TN5mmHz3fN7Y4wcsOS8aATZMgR5vIq30xULtuKdZhWJcbvW5
        p0S9X4bujH1GTNmCWWM4FmC9QM/TiuYkKpnqJPKx+UJccLMN
X-Google-Smtp-Source: ABdhPJz/hBFgCzrMekkTtxNCWnVF6Q3MnUiQG7J4I42pIzJXW0+nltqXGWhTrCLi0GK/jyKs7dTfXTGd4tWrKNuSfnAjQHJk80Yj
MIME-Version: 1.0
X-Received: by 2002:a92:c56b:: with SMTP id b11mr40405364ilj.243.1636323196684;
 Sun, 07 Nov 2021 14:13:16 -0800 (PST)
Date:   Sun, 07 Nov 2021 14:13:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e04f2f05d03a2e3f@google.com>
Subject: [syzbot] general protection fault in virtio_gpu_poll
From:   syzbot <syzbot+4af2eec0d32a135ba67e@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fe91c4725aee Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173a8aeab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d0e8aeec50207a6
dashboard link: https://syzkaller.appspot.com/bug?extid=4af2eec0d32a135ba67e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4af2eec0d32a135ba67e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 27453 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:virtio_gpu_poll+0x7c/0x440 drivers/gpu/drm/virtio/virtgpu_drv.c:169
Code: 48 c1 ea 03 80 3c 02 00 0f 85 2b 03 00 00 4c 8b ab b0 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7d 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 03 00 00 4d 8b 6d 18 31 ff 4c 89 ee e8 8c 50
RSP: 0018:ffffc90024f0f708 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888078deb000 RCX: ffffc9002783b000
RDX: 0000000000000003 RSI: ffffffff8462b2d5 RDI: 0000000000000018
RBP: ffff88801f33ba80 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81cd631d R11: 0000000000000000 R12: ffffc90024f0f898
R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000004
FS:  00007f5ce5906700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ce84009e8 CR3: 000000006c1f7000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_poll include/linux/poll.h:90 [inline]
 do_select+0x8cb/0x16a0 fs/select.c:534
 core_sys_select+0x3c2/0x9c0 fs/select.c:677
 do_pselect.constprop.0+0x17b/0x1c0 fs/select.c:759
 __do_sys_pselect6 fs/select.c:800 [inline]
 __se_sys_pselect6 fs/select.c:791 [inline]
 __x64_sys_pselect6+0x1c5/0x2b0 fs/select.c:791
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5ce8390ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5ce5906188 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 00007f5ce84a3f60 RCX: 00007f5ce8390ae9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000040
RBP: 00007f5ce83eaf25 R08: 0000000020000380 R09: 0000000000000000
R10: 0000000020000140 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd10da36cf R14: 00007f5ce5906300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 1158ebbbb6efaa79 ]---
RIP: 0010:virtio_gpu_poll+0x7c/0x440 drivers/gpu/drm/virtio/virtgpu_drv.c:169
Code: 48 c1 ea 03 80 3c 02 00 0f 85 2b 03 00 00 4c 8b ab b0 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7d 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 03 00 00 4d 8b 6d 18 31 ff 4c 89 ee e8 8c 50
RSP: 0018:ffffc90024f0f708 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888078deb000 RCX: ffffc9002783b000
RDX: 0000000000000003 RSI: ffffffff8462b2d5 RDI: 0000000000000018
RBP: ffff88801f33ba80 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81cd631d R11: 0000000000000000 R12: ffffc90024f0f898
R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000004
FS:  00007f5ce5906700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ce84009e8 CR3: 000000006c1f7000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 2b 03 00 00    	jne    0x339
   e:	4c 8b ab b0 01 00 00 	mov    0x1b0(%rbx),%r13
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	49 8d 7d 18          	lea    0x18(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 19 03 00 00    	jne    0x34d
  34:	4d 8b 6d 18          	mov    0x18(%r13),%r13
  38:	31 ff                	xor    %edi,%edi
  3a:	4c 89 ee             	mov    %r13,%rsi
  3d:	e8                   	.byte 0xe8
  3e:	8c                   	.byte 0x8c
  3f:	50                   	push   %rax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
