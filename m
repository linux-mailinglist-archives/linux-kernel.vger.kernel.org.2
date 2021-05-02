Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D69370E14
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhEBQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:56:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50009 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhEBQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:56:09 -0400
Received: by mail-io1-f72.google.com with SMTP id i204-20020a6bb8d50000b02903f266b8e1c5so1689061iof.16
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eP4mQN7C2zr3b/3zqQgZ9cfbl/yTznWZNvkQ6osR27g=;
        b=M72BOKPWrAWPhmYgtirCtdVJUKvhOPQc9pur3/FL2Gfz0AqXbPlnOnB2FxZHWnBxxc
         rgOjVMgGgmvNCAPsxkGXKNTVZX96ZJE5U2P05Vs8RttLTr3oEDb8AAqL7hwOSjBd7QYs
         2D+QrITG8dyCnCJ4wFwG2akpU51qbQmSpFAj8KdBOVvVDWxxWl+P4UuaSp0YxxczWgLd
         9t2K6QaxjHAtxMcLJYZTuDOYSjFCdwrQG3Z1m4Fwaf862mYHNmYp6FeG/JYXWt31BxxN
         WN+bfHx9I4b0zoxCUXAFEidUnJAn/j8Uv8ZDpfhPz/pvAu3bIoI369WuA1UzUJV1+Zma
         zINg==
X-Gm-Message-State: AOAM530llmjes3A+hXPwGEtlw3rxNj8ytm1vtvF/h7/IhtsYRCOfOCiY
        sSH+hoVR5W4od9KyTNgjsyU3v3jLHz4iClWx4gVb+u1lfxN/
X-Google-Smtp-Source: ABdhPJxBrNGUkDeYHa62khBXomhZqIUnBPjzWZ7xG2jJOLOMH5qryQQiguVNne0zB5KXxNOu50vnwiFl1sc4uJiZ9JzH7PX8iisn
MIME-Version: 1.0
X-Received: by 2002:a5d:9659:: with SMTP id d25mr11877096ios.146.1619974516550;
 Sun, 02 May 2021 09:55:16 -0700 (PDT)
Date:   Sun, 02 May 2021 09:55:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009aaf5905c15bb5f0@google.com>
Subject: [syzbot] general protection fault in do_swap_page (2)
From:   syzbot <syzbot+9bedf8ef6e51e0bb3401@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e3d35712 Add linux-next specific files for 20210423
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b953f5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e370221d7500b26a
dashboard link: https://syzkaller.appspot.com/bug?extid=9bedf8ef6e51e0bb3401

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bedf8ef6e51e0bb3401@syzkaller.appspotmail.com

get_swap_device: Bad swap file entry 3fffa5f80000a
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 8451 Comm: syz-fuzzer Not tainted 5.12.0-rc8-next-20210423-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_swap_page+0x9fa/0x2430 mm/memory.c:3349
Code: e8 bb a2 6d 07 e9 cb fa ff ff e8 01 c1 cb ff 48 8b 7c 24 10 e8 97 b7 0a 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 60 17 00 00 48 8b 18 31 ff 81 e3 00 10 00 00 48
RSP: 0000:ffffc900015ffc78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880124035b0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81b3f0de RDI: 0000000000000003
RBP: ffffc900015ffd88 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b3f09f R11: 0000000000000000 R12: 0000000000000000
R13: ffff888029ea0e00 R14: ffff888024424040 R15: 0000000000000000
FS:  000000c00027c490(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001000000 CR3: 0000000014778000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 handle_pte_fault mm/memory.c:4371 [inline]
 __handle_mm_fault+0x1b8b/0x5150 mm/memory.c:4502
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4600
 do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:0x420a5d
Code: 0c 48 ff c7 d1 eb 48 83 c6 08 0f 1f 00 48 83 ff 08 0f 8d f9 00 00 00 48 39 f1 0f 86 f0 00 00 00 0f ba e3 00 73 db 4c 8d 04 16 <4d> 8b 00 4d 85 c0 74 cf 48 89 7c 24 40 4c 89 44 24 38 48 89 74 24
RSP: 002b:000000c0002bde18 EFLAGS: 00010203
RAX: 00007fafa7949000 RBX: 0000000000000009 RCX: 0000000000040000
RDX: 0000000000fcd820 RSI: 00000000000327e0 RDI: 0000000000000004
RBP: 000000c0002bde68 R08: 0000000001000000 R09: 0000000000000045
R10: 0000000001880e68 R11: 0000000000000053 R12: 0000000000000003
R13: 000000c000082780 R14: 000000000000000f R15: 0000000000000c96
Modules linked in:
---[ end trace bfcda609218a3121 ]---
RIP: 0010:do_swap_page+0x9fa/0x2430 mm/memory.c:3349
Code: e8 bb a2 6d 07 e9 cb fa ff ff e8 01 c1 cb ff 48 8b 7c 24 10 e8 97 b7 0a 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 60 17 00 00 48 8b 18 31 ff 81 e3 00 10 00 00 48
RSP: 0000:ffffc900015ffc78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880124035b0 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81b3f0de RDI: 0000000000000003
RBP: ffffc900015ffd88 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b3f09f R11: 0000000000000000 R12: 0000000000000000
R13: ffff888029ea0e00 R14: ffff888024424040 R15: 0000000000000000
FS:  000000c00027c490(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000c7c010 CR3: 0000000014778000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
