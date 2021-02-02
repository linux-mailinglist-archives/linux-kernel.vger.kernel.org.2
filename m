Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF830B8C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhBBHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:37:59 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33181 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBBHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:37:57 -0500
Received: by mail-io1-f70.google.com with SMTP id m3so13990266ioy.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RaaaFb/FsJvO/g1ivtUAIUikFA3tVEf/1+9ztYf1vwU=;
        b=l/lgS2+pk3V2SOfA1FyfnxvCDCpfm8GfQifxxJ8+7bpTpG3m74LCiLLW6GdtppARhb
         Ae2X8dCTx+mE5M6J5PE1msOqBYgInSCEJqYiUqyVa/WzTl1clckAoIHU+HhNwR1DtjVU
         7efdqS17FkdlNNzXOjz9eOeoPTd2MWZDcyHI7EL2NgCPfPoVrywRlLOXZeXnIKNYhn0y
         ABeeEzOvK714xEcggE9eoRCqc31PASocJ7MHWWrtLPGqQOMQQsDSLJ42HHkszgSig9vm
         4oNcwRDiAAvaXghJRdYVxg3DJOIwIGZ0wk8NX8XfPHmUWTYUo6ldbmglRzpyzGWCD2qB
         ZKZg==
X-Gm-Message-State: AOAM532NGtRcfowLZ9SuMAP1ZdsJa73Wp00QHndjOUI5J4NGPNlDHk2c
        maNnHnZVe1sGcM/RSvY0PcJojEyWFBsOujgNzNfro3inGeUu
X-Google-Smtp-Source: ABdhPJzm/FMTL/y5VGWVV8XN4BkZ2Tjq3Kpve7nvbkO3aNldgDBQN2tnw2yF0Lp49K+9h0ZGO/61NUhhTbNf+dpRUaoBlSTcyaGu
MIME-Version: 1.0
X-Received: by 2002:a5d:9ad4:: with SMTP id x20mr4255172ion.31.1612251436391;
 Mon, 01 Feb 2021 23:37:16 -0800 (PST)
Date:   Mon, 01 Feb 2021 23:37:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027a68305ba558a86@google.com>
Subject: WARNING: refcount bug in uprobe_mmap
From:   syzbot <syzbot+e61dd1b2a6fb2ffd2dee@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fd821bf0 Add linux-next specific files for 20210201
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17255354d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80ac9f64e6e2c06
dashboard link: https://syzkaller.appspot.com/bug?extid=e61dd1b2a6fb2ffd2dee

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e61dd1b2a6fb2ffd2dee@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 10416 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 10416 Comm: syz-executor.5 Not tainted 5.11.0-rc6-next-20210201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 09 31 ff 89 de e8 87 b5 b0 fd 84 db 0f 85 36 ff ff ff e8 fa ae b0 fd 48 c7 c7 60 f7 be 89 c6 05 4a a8 4e 09 01 e8 be 96 fd 04 <0f> 0b e9 17 ff ff ff e8 db ae b0 fd 0f b6 1d 2f a8 4e 09 31 ff 89
RSP: 0018:ffffc9000262fb80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815b3b35 RDI: fffff520004c5f62
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815acd0e R11: 0000000000000000 R12: ffff888011d9d800
R13: ffffc9000262fc10 R14: ffffc9000262fc10 R15: ffff888011d9d818
FS:  00007f3dcdee1700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d27000 CR3: 00000000291a8000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_uprobe kernel/events/uprobes.c:597 [inline]
 build_probe_list kernel/events/uprobes.c:1312 [inline]
 uprobe_mmap+0x8ff/0x1080 kernel/events/uprobes.c:1382
 mmap_region+0x56c/0x1730 mm/mmap.c:1881
 do_mmap+0xcff/0x11d0 mm/mmap.c:1580
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x49c/0x620 mm/mmap.c:1631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3dcdee1188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020007000
RBP: 00000000004b069f R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000412 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffcf33596cf R14: 00007f3dcdee1300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
