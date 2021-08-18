Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8513F0029
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHRJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:15:06 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52222 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhHRJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:14:58 -0400
Received: by mail-il1-f197.google.com with SMTP id r5-20020a92d985000000b002246fb2807cso854819iln.18
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nVWhK4cQDXyby++FlrRCSICOsNIa8m6BHgR2s+fOqjk=;
        b=DWALdkdXgql4XZAWhhbbnsFz4rXXFtUf0Q3xtlRRmdE9G88RBFKn1jpPoAv566GU5x
         ORQ5HF1zYKYHa+RjMlrA9vzMF56Of1irXQoK972O81DmG1rgUbNAPjLL2vOCf30/ZHXQ
         oHALdySwgzSN0xaxBIrXQR8G/oJcrOzWHN9on85+k1/a4+lJPbncE5JROhW3RBL/o3s5
         WtU3jTiy+YLIfN1QLh/UAkW8pODXFPu9I+hNh4i4ynPuYfEsaqMdiHBf08YPwA0YeF+T
         LbRq9Q2OwaTsk4FycImwjie7iGoCzaBcdnQolWEKtuQUOAEuqGaoNeoqZb1OzUZML+SK
         6x/g==
X-Gm-Message-State: AOAM533QcJjWhhOcIpTmeRWNK+gB+gtjs75rm39bQTquGtrxBpK4VQBx
        nNeafGehmFqtVDCY/xwm60kR3XBDN9RbP4RnCXHaOUCafd7B
X-Google-Smtp-Source: ABdhPJwETxoSv9A/LHlkyJimAET8MJOM+95bPE4OlxYrGxsjgWP2LcMj/M+jNwC1+6HCFL1vN4vC+VQpv59Ch3E1bPGZFZw7T9m2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1294:: with SMTP id y20mr5242782ilq.42.1629278063605;
 Wed, 18 Aug 2021 02:14:23 -0700 (PDT)
Date:   Wed, 18 Aug 2021 02:14:23 -0700
In-Reply-To: <000000000000d77b6505c767b8f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038c55d05c9d1dc3b@google.com>
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
From:   syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    794c7931a242 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13af2205300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=9b57a46bf1801ce2a2ca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae58ce300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d71731300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType a1
WARNING: CPU: 0 PID: 8434 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 0 PID: 8434 Comm: syz-executor752 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 45 64 1f fc 48 8b 7c 24 40 e8 4b fc 0b ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 e0 b2 27 8a e8 01 fc 91 03 <0f> 0b e9 a5 ee ff ff e8 17 64 1f fc 0f b6 1d 19 ca 01 08 31 ff 41
RSP: 0018:ffffc90000effbd0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888027944058 RCX: 0000000000000000
RDX: ffff8880235db880 RSI: ffffffff815d85c5 RDI: fffff520001dff6c
RBP: ffff888021618140 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d23fe R11: 0000000000000000 R12: ffff888018aff118
R13: 00000000000000a1 R14: 0000000080000280 R15: ffff888021900400
FS:  000000000223d300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005614a6c2a160 CR3: 00000000222ca000 CR4: 0000000000350ef0
Call Trace:
 hid_submit_ctrl+0x6ec/0xd80 drivers/hid/usbhid/hid-core.c:416
 usbhid_restart_ctrl_queue.isra.0+0x244/0x3a0 drivers/hid/usbhid/hid-core.c:258
 __usbhid_submit_report+0x6f0/0xd50 drivers/hid/usbhid/hid-core.c:603
 usbhid_submit_report drivers/hid/usbhid/hid-core.c:640 [inline]
 usbhid_init_reports+0xd7/0x3b0 drivers/hid/usbhid/hid-core.c:780
 hiddev_ioctl+0xb27/0x1630 drivers/hid/usbhid/hiddev.c:689
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444619
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe70eb96d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000444619
RDX: 0000000000000000 RSI: 0000000000004805 RDI: 0000000000000004
RBP: 0000000000403ea0 R08: 0000000000000001 R09: 00000000004004a0
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000403f30
R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
----------------
Code disassembly (best guess):
   0:	7c 24                	jl     0x26
   2:	40 e8 45 64 1f fc    	rex callq 0xfc1f644d
   8:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
   d:	e8 4b fc 0b ff       	callq  0xff0bfc5d
  12:	45 89 e8             	mov    %r13d,%r8d
  15:	44 89 f1             	mov    %r14d,%ecx
  18:	4c 89 e2             	mov    %r12,%rdx
  1b:	48 89 c6             	mov    %rax,%rsi
  1e:	48 c7 c7 e0 b2 27 8a 	mov    $0xffffffff8a27b2e0,%rdi
  25:	e8 01 fc 91 03       	callq  0x391fc2b
  2a:	0f 0b                	ud2     <-- trapping instruction
  2c:	e9 a5 ee ff ff       	jmpq   0xffffeed6
  31:	e8 17 64 1f fc       	callq  0xfc1f644d
  36:	0f b6 1d 19 ca 01 08 	movzbl 0x801ca19(%rip),%ebx        # 0x801ca56
  3d:	31 ff                	xor    %edi,%edi
  3f:	41                   	rex.B

