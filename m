Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC63EDF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhHPWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:01:58 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51895 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhHPWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:01:57 -0400
Received: by mail-io1-f72.google.com with SMTP id p22-20020a5d8d160000b02905a150b13b20so9981261ioj.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 15:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fmq6DkW9N4P+Fks5JBQMGCSMaDogGqZTLA5gyaQ3iDU=;
        b=LrpL0bdggotj6hKnv/VcAbCYS+xiXQYB5NrXdUxQizqrPJ/aR3jqlmiYctu1BZ+G9L
         /96+7Ht72QHBo4F+BUiyE31Z4vmD1ZkDAfQ3vnb3VvAt3i4zTnnsoTuFblRCWBWHusjx
         gxrh7w6MMDYSJJCsik5HGFIUbQ3EAvifA7DZsoEehpwdB+7h+Pe1khFT8+q7MOi4esJW
         E2Yk3VoGbXGOEi9g8IJbWq56vqqAMhPXJ7DljXoz5BayiS/GTE5mYA33OgajiM2SBtfB
         BamvTRT7Owf1u5wC3dytCnEMnrPo4ThR3mvKCpOAy2z1tKNmjjaKsMZwldi73mY++cNS
         wJVA==
X-Gm-Message-State: AOAM531BwxhkylGtKvIL/6rNTct74xCeRFD5KG1LaXhU40c3wf+rw9Ur
        3n+4/DJUOVvEJLFB3vFrh3FR6539mn/8qOkotD8QQGJ5Epbj
X-Google-Smtp-Source: ABdhPJyxEKL/Oe87ydwFsejhcaA7+jyKzdNW66j/nYERasDsDbpRwZsYF91tRPilOiOtdLa9qzItiUg4m9FX5772dQ1MN+fkMBG7
MIME-Version: 1.0
X-Received: by 2002:a02:cb46:: with SMTP id k6mr24280jap.15.1629151285172;
 Mon, 16 Aug 2021 15:01:25 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:01:25 -0700
In-Reply-To: <00000000000080486305c9a8f818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3605b05c9b45777@google.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177d4006300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6a/0x1058

Use-after-free read at 0xffff88823bd7e020 (in kfence-#190):
 kvm_fastop_exception+0xf6a/0x1058
 d_lookup+0xd8/0x170 fs/dcache.c:2370
 lookup_dcache+0x1e/0x130 fs/namei.c:1520
 __lookup_hash+0x29/0x180 fs/namei.c:1543
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

kfence-#190: 0xffff88823bd7e000-0xffff88823bd7efff, size=4096, cache=names_cache

allocated by task 22 on cpu 0 at 75.061659s:
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

freed by task 22 on cpu 0 at 75.061679s:
 putname.part.0+0xe1/0x120 fs/namei.c:270
 putname include/linux/err.h:41 [inline]
 filename_parentat fs/namei.c:2547 [inline]
 kern_path_locked+0xc2/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-rc5-next-20210816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
Code: d3 ed e9 f7 ae 6c f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 4d bc 6c f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 3d c6 6c f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 30317974746d7367 RBX: ffff88806c915068 RCX: ffff88823bd7e020
RDX: ffffed100d922a14 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 0000000000000008 R08: 0000000000000000 R09: ffff88806c915098
R10: ffffed100d922a13 R11: 0000000000000000 R12: ffff88823bd7e020
R13: ffff88823bd7e020 R14: ffff88806c915098 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bd7e020 CR3: 000000006fc3b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 d_lookup+0xd8/0x170 fs/dcache.c:2370
 lookup_dcache+0x1e/0x130 fs/namei.c:1520
 __lookup_hash+0x29/0x180 fs/namei.c:1543
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
==================================================================
----------------
Code disassembly (best guess):
   0:	d3 ed                	shr    %cl,%ebp
   2:	e9 f7 ae 6c f8       	jmpq   0xf86caefe
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 4d bc 6c f8       	jmpq   0xf86cbc6f
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
  2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 3d c6 6c f8       	jmpq   0xf86cc67c
  3f:	bd                   	.byte 0xbd

