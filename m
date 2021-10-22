Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6D437ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhJVQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:28:02 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:58441 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233427AbhJVQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:28:01 -0400
Received: from MTA-06-4.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 708EB80C2D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:25:43 -0400 (EDT)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id 0130218000A0;
        Fri, 22 Oct 2021 12:25:42 -0400 (EDT)
Received: from APP-03 (unknown [10.50.14.153])
        by mta-06.privateemail.com (Postfix) with ESMTPA id B938318000A2;
        Fri, 22 Oct 2021 12:25:41 -0400 (EDT)
Date:   Fri, 22 Oct 2021 12:25:41 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Message-ID: <1491925661.1465925.1634919941738@privateemail.com>
In-Reply-To: <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev24
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a quick scan, it appears to be a false-positive.

This because nothing appears to be being freed. 

In any case, you probably don't want warnings everywhere.

I believe we should probably do something along the lines of:

if (refcount_read(&secretmem_users) == 0) {
    refcount_set(&secretmem_users, 1);
} else {
    refcount_inc(&secretmem_users);
}

Does this appear to be a feasible patch? :)

Best Regards,

Jordy

> On 10/22/2021 11:07 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> 
>  
> On Fri, 22 Oct 2021 at 17:02, syzbot
> <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    64222515138e Merge tag 'drm-fixes-2021-10-22' of git://ano..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=178e86c4b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com
> 
> +Mike, Jordy for secretmem.c
> 
> > ------------[ cut here ]------------
> > refcount_t: addition on 0; use-after-free.
> > WARNING: CPU: 2 PID: 32193 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> > Modules linked in:
> > CPU: 2 PID: 32193 Comm: syz-executor.0 Not tainted 5.15.0-rc6-syzkaller #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
> > Code: 09 31 ff 89 de e8 f7 b9 9b fd 84 db 0f 85 36 ff ff ff e8 3a b2 9b fd 48 c7 c7 c0 65 e3 89 c6 05 6f 6c 7f 09 01 e8 7e 4a 19 05 <0f> 0b e9 17 ff ff ff e8 1b b2 9b fd 0f b6 1d 54 6c 7f 09 31 ff 89
> > RSP: 0018:ffffc90009f9ff10 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000040000 RSI: ffffffff815dbf58 RDI: fffff520013f3fd4
> > RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
> > R10: ffffffff815d5cce R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f476a1e7700(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b32c24000 CR3: 00000000494c4000 CR4: 0000000000150ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  __refcount_add include/linux/refcount.h:199 [inline]
> >  __refcount_inc include/linux/refcount.h:250 [inline]
> >  refcount_inc include/linux/refcount.h:267 [inline]
> >  __do_sys_memfd_secret mm/secretmem.c:221 [inline]
> >  __se_sys_memfd_secret mm/secretmem.c:194 [inline]
> >  __x64_sys_memfd_secret+0x182/0x1e0 mm/secretmem.c:194
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f476cc71a39
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f476a1e7188 EFLAGS: 00000246 ORIG_RAX: 00000000000001bf
> > RAX: ffffffffffffffda RBX: 00007f476cd74f60 RCX: 00007f476cc71a39
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00007f476cccbe8f R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffc5b5eb85f R14: 00007f476a1e7300 R15: 0000000000022000
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000062d0fc05cef24c57%40google.com.
