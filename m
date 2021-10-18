Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD774310BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJRGoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:44:38 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57104 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJRGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:44:36 -0400
Received: by mail-io1-f71.google.com with SMTP id d7-20020a056602228700b005ddba37de42so9832966iod.23
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=g1EUMfW/2BhC262mhPB9a5eovFTCDNnyuHI77tNgHF8=;
        b=w67xHenhUhPABiXpgHraNdrWx7+kF0O/Ua+lacEL6rkiXU7ye2BPR+2417kImDiEaa
         zVDKsVW/UxTbE3e8yyFm0603iuecV79z/DxeVVahUAnqjH5UiAizjGXaUE4pzctwUMD0
         mhKYQck90Qld+MxYr22flsxFi1+UWu+hMPBg0w245PuZN0au1dpwFipttlOA0X1U+hlW
         Eggu7bJzPMlnohhwcBvUxpIw4LaPxICHE3FYKYdjjitTGK0M15nRbAyytnt6MlbUahmQ
         x2FcOALbKpWcFhMQCYzyMmllrB2kTJKRjxpM+dI8r08WKoFiL/wfZrvXyD8lIfe+gO4I
         mWzg==
X-Gm-Message-State: AOAM530tixN6OwAV37EgNpD+AzZgvCI622t9JhJGgfDH8rVhvWH2KkMp
        +LAiDDB/s8prs2FLUAQs3KwzM2jcFqkrb0PVCKQZaeohHKdW
X-Google-Smtp-Source: ABdhPJwFVE8VS6HKMCE1Q3jMxk/Ew6OTg3xe15kyq1RbQnDDFzOXvwn9ZUQ5/CH7qdDVipTAFC9Kj1+pH5YEw0LFVnnhFrZcQLUp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba8:: with SMTP id n8mr12354746ili.74.1634539346064;
 Sun, 17 Oct 2021 23:42:26 -0700 (PDT)
Date:   Sun, 17 Oct 2021 23:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017f90605ce9ad95d@google.com>
Subject: [syzbot] WARNING: kmalloc bug in kvm_page_track_create_memslot
From:   syzbot <syzbot+d9c9b7cff3d4ec7a589e@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d999ade1cc86 Merge tag 'perf-tools-fixes-for-v5.15-2021-10..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161ab644b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d9c9b7cff3d4ec7a589e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcdc34b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14785d34b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9c9b7cff3d4ec7a589e@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6533 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
Modules linked in:
CPU: 0 PID: 6533 Comm: syz-executor711 Not tainted 5.15.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
Code: 01 00 00 00 4c 89 e7 e8 ad 18 0d 00 49 89 c5 e9 69 ff ff ff e8 60 91 d0 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 4f 91 d0 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 36
RSP: 0018:ffffc900011ef6e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807a7e8000 RSI: ffffffff81a646c1 RDI: 0000000000000003
RBP: 0000000000400dc0 R08: 000000007fffffff R09: ffff8880b9d32a0b
R10: ffffffff81a6467e R11: 000000000000003f R12: 00000000e0000000
R13: 0000000000000000 R14: 00000000ffffffff R15: ffffc900011ef950
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0063) knlGS:0000000056d512c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055ad809529a0 CR3: 000000001ae94000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvmalloc include/linux/mm.h:805 [inline]
 kvmalloc_array include/linux/mm.h:823 [inline]
 kvcalloc include/linux/mm.h:828 [inline]
 kvm_page_track_create_memslot+0x50/0x110 arch/x86/kvm/mmu/page_track.c:39
 kvm_alloc_memslot_metadata arch/x86/kvm/x86.c:11501 [inline]
 kvm_arch_prepare_memory_region+0x350/0x610 arch/x86/kvm/x86.c:11538
 kvm_set_memslot+0x172/0x1a40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1592
 __kvm_set_memory_region+0xc1c/0x13d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1755
 kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1776 [inline]
 kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1788 [inline]
 kvm_vm_ioctl+0x520/0x23d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4363
 kvm_vm_compat_ioctl+0x288/0x350 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4588
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7e67549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff89659c EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000004020ae46
RDX: 00000000200001c0 RSI: 00000000ff8965f0 RDI: 00000000f7f0a000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
