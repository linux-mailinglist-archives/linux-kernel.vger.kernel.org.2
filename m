Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E59336D98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhCKIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:17:47 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48176 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCKIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:17:19 -0500
Received: by mail-il1-f200.google.com with SMTP id o1so1428319ilg.15
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bC/CQmldrtXQfQKRGB87mv7ghFtpceScOYXwx+xXaqk=;
        b=NT+Ib20CPLJh8rXooJ5scFK9y5SMweKcQZeU+fbMr3gjdmETOmnv8RJAymB7+E6j6w
         c6xa5m+Nm2HT6EOqDn5YW+nWG1FvgRkC8zOcZgvGdrm+ZsvxfcQqb9yMHNykkzWcKPyd
         sAT3mBkGeFer0gsUnIHKOCR+2k026ONp9Sh8tz00AyD+0etVMzgq+vxhuRjvsrPmevX9
         HjqNFmqg+Q7C5qTWdaEbvyO2urO45d+Pao4gmuVZpwfWvTNvLU0+AbhJGdpYjgzdhduF
         tnaV/hN4bCwD5puImo3F6OSZ0xZJKMK7IETUE/yRCVygUJXlIDyIvu2z8JuE9HbhksOs
         cNiA==
X-Gm-Message-State: AOAM530BAZgvhYriR+GZpvSpnI5hjTkYAvxynJzc0KeXzXMiT9rLUumy
        NII1cfJvFmrORb2xQVlEdLfQ5tLwiRnftFs90zl5o1cxqr0U
X-Google-Smtp-Source: ABdhPJwgrrReRlXkPN8CxrAJRWtOGzh4o02tD7J8hhCzPHmCOZtUGS/iiimLtYXQwINpVQgQB43P849C263aOL0OZ3LvBDMgwZA8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr5952795ilr.220.1615450638515;
 Thu, 11 Mar 2021 00:17:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 00:17:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007604cb05bd3e6968@google.com>
Subject: [syzbot] BUG: using smp_processor_id() in preemptible code in __do_user_fault
From:   syzbot <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
To:     alexandre.chartre@oracle.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f67ae6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7ac5ce2d1160e16
dashboard link: https://syzkaller.appspot.com/bug?extid=a7ee43e564223f195c84
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.0/15841
caller is debug_smp_processor_id+0x20/0x24 lib/smp_processor_id.c:64
CPU: 0 PID: 15841 Comm: syz-executor.0 Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<82107738>] (dump_backtrace) from [<821079ac>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
 r7:00000000 r6:60000113 r5:00000000 r4:83966184
[<82107994>] (show_stack) from [<82110980>] (__dump_stack lib/dump_stack.c:79 [inline])
[<82107994>] (show_stack) from [<82110980>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
[<821108c8>] (dump_stack) from [<82133120>] (check_preemption_disabled+0x118/0x11c lib/smp_processor_id.c:53)
 r7:8294d26c r6:00000000 r5:82133144 r4:86d725b0
[<82133008>] (check_preemption_disabled) from [<82133144>] (debug_smp_processor_id+0x20/0x24 lib/smp_processor_id.c:64)
 r7:00000a07 r6:86d72080 r5:0000000b r4:ffffc000
[<82133124>] (debug_smp_processor_id) from [<80217a00>] (harden_branch_predictor arch/arm/include/asm/system_misc.h:24 [inline])
[<82133124>] (debug_smp_processor_id) from [<80217a00>] (__do_user_fault+0x98/0x108 arch/arm/mm/fault.c:142)
[<80217968>] (__do_user_fault) from [<80217c90>] (do_page_fault+0x190/0x378 arch/arm/mm/fault.c:357)
 r9:00000800 r8:84649ebc r7:84649e40 r6:00000a07 r5:ffffc000 r4:89063fb0
[<80217b00>] (do_page_fault) from [<80218054>] (do_DataAbort+0x38/0xb8 arch/arm/mm/fault.c:522)
 r10:7ef2f914 r9:76f276d0 r8:80217b00 r7:89063fb0 r6:ffffc000 r5:00000a07
 r4:83837b38
[<8021801c>] (do_DataAbort) from [<80200dc4>] (__dabt_usr+0x44/0x60 arch/arm/kernel/entry-armv.S:421)
Exception stack(0x89063fb0 to 0x89063ff8)
3fa0:                                     ffffff00 20000280 ffffc000 20000250
3fc0: 00000004 20070517 00000140 20ffb000 7ef2f79a 76f276d0 7ef2f914 76f2720c
3fe0: 00000000 76f27020 00000006 00013b18 80000010 ffffffff
 r8:30c5387d r7:30c5387d r6:ffffffff r5:80000010 r4:00013b18


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
