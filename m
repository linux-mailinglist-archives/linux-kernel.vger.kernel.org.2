Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49AF438399
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhJWMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 08:04:45 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44569 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhJWMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 08:04:44 -0400
Received: by mail-io1-f72.google.com with SMTP id a1-20020a5d9801000000b005de11aa60b8so5180198iol.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 05:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Y2xC9KlucvmvQkSgxHIj3ttz+G0LYRa6dVH8rX+XzUc=;
        b=3Uc4pC8mHFTo5zCEDeCaj5gRAJGc/j4DkRkW4vXYnKHeb3p/uhsXjoPIf0VN8DeNAo
         PajNK/Lttk0OmFWKKYhbyZdftzf0BH6jnXlzOGWXzBRnlBV7matCELqkcEveJYfgACfa
         0qo0T4OHh62L0VJFSsFV/lT1wr8dxEAilQ5V9ST4HsCOhZ1zHZT50Zw5rS6mQSNq1Zov
         jNde4QWcGPG2kEyGDbXbLBrINYWGcyZ6pr1pHOWd39qBefHWtz8h3CGkMyU0Wv0OlMfO
         LKTg3EBfyn2zrJHM731Qvs4pi2/BzIx50fTaHCQe7R/aen7jcd/Zl/5R0aoUDmKezslw
         25RA==
X-Gm-Message-State: AOAM5317NR0NVsuWVLsa/fgUUtDS19y0lBdXXRRZoiPkr++iK43jcDnN
        gL+UA40Mm8DJHrzaY9/orPq6muNq8a7qZOTXgSDIHlD+Q7o6
X-Google-Smtp-Source: ABdhPJy72EfZXcfTgRqc2R8GDIg4UUKG//MesO7jAOin4uJgmXayeBRMZhm1DC/T5e3gss2PIdvRZKr5MKvdD/mJ8TNrcKwdzRit
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:: with SMTP id y14mr3432063ill.189.1634990545581;
 Sat, 23 Oct 2021 05:02:25 -0700 (PDT)
Date:   Sat, 23 Oct 2021 05:02:25 -0700
In-Reply-To: <00000000000062d0fc05cef24c57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae3a7905cf03e639@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
From:   syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        jordy@pwning.systems, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    cf6c9d12750c Add linux-next specific files for 20211022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10bdd272b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd1cd3d631599df5
dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12790a72b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13eb76dcb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 6528 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Modules linked in:
CPU: 1 PID: 6528 Comm: syz-executor149 Not tainted 5.15.0-rc6-next-20211022-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 09 31 ff 89 de e8 27 1f 9f fd 84 db 0f 85 36 ff ff ff e8 3a 1b 9f fd 48 c7 c7 00 2e 04 8a c6 05 c7 25 a3 09 01 e8 92 ce 31 05 <0f> 0b e9 17 ff ff ff e8 1b 1b 9f fd 0f b6 1d ac 25 a3 09 31 ff 89
RSP: 0018:ffffc90001a4ff10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801d369d40 RSI: ffffffff815f06f8 RDI: fffff52000349fd4
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ea4ce R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555565e9300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f842b6f56c0 CR3: 000000001bc33000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 __do_sys_memfd_secret mm/secretmem.c:221 [inline]
 __se_sys_memfd_secret mm/secretmem.c:194 [inline]
 __x64_sys_memfd_secret+0x182/0x1e0 mm/secretmem.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbeb6a4cf89
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde5076be8 EFLAGS: 00000246 ORIG_RAX: 00000000000001bf
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbeb6a4cf89
RDX: 00007fbeb6a0fe93 RSI: 0000000000000012 RDI: 0000000000080000
RBP: 00007fbeb6a10f70 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fbeb6a11000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

