Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D874064E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhIJBHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:07:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48018 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhIJAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:35:43 -0400
Received: by mail-il1-f198.google.com with SMTP id j17-20020a926e11000000b0022487646515so186659ilc.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 17:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZOfokQluW4H1eh7MH8JkbSFmUHfUl+1/obY6V/OI4Ko=;
        b=5j59GSKXMRIi1sJACqlPxhtZJll1aHq+xL3VwLVbW1t2a2K9Psz8OEzhVVH01Iu78x
         Pu3HFKo3mc0njwvhq/W1u4sdhHwLpbmvpDEUNlcFFxogtiL0WF+HPevRycId84F4F0LL
         YcCUNGaAXErP+1FClhiNerIp/4OwEoVCjqkSZ6Jqlb5KkKaMiiiv9iMIs5Ryx67rvwDn
         RY+on9eDO7PM0Tj5ZnD5TZQl4TGRjB865cun6AEyx5SDweV0SVAyPsaD8n9fxsSeZeYv
         6OQD+vWxzHoUYdovTxsA+lWZ12YtiPH4S5BdOOibwU0BDU6qDsD9IU/DY5gWDAgV6iFd
         AkJA==
X-Gm-Message-State: AOAM533HYbk1Jj2Je09xsSV24FKU9wn04EtKpDTge/beKWqf1n2U6KeO
        KID3O7BIZR4Opa5hh4Od8VGnYfYJXNkdvUm9z9pox1cX68Z5
X-Google-Smtp-Source: ABdhPJxTHUntAKZNvhK3LU0ydoOpDwDJQ43p5rOgqaIMxNiZCOdn5GeC//eUzX3b9dblv7mNBB5/RGIdSCmw1CX+G6Hm1Z8Ti4F/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2051:: with SMTP id t17mr2114321jaj.143.1631234073006;
 Thu, 09 Sep 2021 17:34:33 -0700 (PDT)
Date:   Thu, 09 Sep 2021 17:34:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007799db05cb99479c@google.com>
Subject: [syzbot] net test error: KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+616920e690af4ff00db3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    276aae377206 net: stmmac: fix system hang caused by eee_ct..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=102589b3300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
dashboard link: https://syzkaller.appspot.com/bug?extid=616920e690af4ff00db3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+616920e690af4ff00db3@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6a/0x1058

Use-after-free read at 0xffff88823bdbe020 (in kfence-#222):
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

kfence-#222 [0xffff88823bdbe000-0xffff88823bdbefff, size=4096, cache=names_cache] allocated by task 22:
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

freed by task 22:
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

CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
Code: d3 ed e9 ef d4 6e f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 45 e2 6e f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 35 ec 6e f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 0000000032736376 RBX: ffff88806e9e1ab0 RCX: ffff88823bdbe020
RDX: ffffed100dd3c35d RSI: 0000000000000004 RDI: 0000000000000007
RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88806e9e1ae0
R10: ffffed100dd3c35c R11: 0000000000000000 R12: ffff88823bdbe020
R13: ffff88823bdbe020 R14: ffff88806e9e1ae0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bdbe020 CR3: 0000000074f8f000 CR4: 00000000001506e0
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
   2:	e9 ef d4 6e f8       	jmpq   0xf86ed4f6
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 45 e2 6e f8       	jmpq   0xf86ee267
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
* 2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 35 ec 6e f8       	jmpq   0xf86eec74
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
