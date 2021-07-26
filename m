Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B388D3D52C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhGZEiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhGZEiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A0260241;
        Mon, 26 Jul 2021 05:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627276715;
        bh=2f2kBgXCHjekRKd0IKPmV3NbzoC23HXEiHYAkFiW1TQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nJcTaW0uK1dpqbJrnSeFGRR0AetZrwnx2VRfgxCk9J3as2dNe4rsUz4QnnF+MTGtQ
         QkEe5Z+ECdFMQlY/dct6kVdSqrU7MAihbPK7gpnD26IhdC4gZyw8hb7kk1mQ5K073q
         XfruEzV968uVilZbLAYYYWuM9gxt9iJVYjImtbBc=
Date:   Sun, 25 Jul 2021 22:18:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+bb4c69145b4a52b40b27@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 folio_copy
Message-Id: <20210725221834.35e077daff0005f3d78d08d7@linux-foundation.org>
In-Reply-To: <000000000000f84cad05c7ee4778@google.com>
References: <000000000000f84cad05c7ee4778@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc Matthew)

(It might not be a folio thing at all - I haven't checked yet)

On Sun, 25 Jul 2021 01:18:27 -0700 syzbot <syzbot+bb4c69145b4a52b40b27@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b1347210b01d Add linux-next specific files for 20210721
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1417aeca300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=86c6d14fadc3db60
> dashboard link: https://syzkaller.appspot.com/bug?extid=bb4c69145b4a52b40b27
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202e6ca300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ca875a300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bb4c69145b4a52b40b27@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at mm/util.c:761
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1660, name: kcompactd0
> 1 lock held by kcompactd0/1660:
>  #0: ffff8880111a4f70 (&mapping->private_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
>  #0: ffff8880111a4f70 (&mapping->private_lock){+.+.}-{2:2}, at: __buffer_migrate_page+0x3a8/0xa80 mm/migrate.c:722
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 1660 Comm: kcompactd0 Not tainted 5.14.0-rc2-next-20210721-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  ___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9182
>  folio_copy+0x10c/0x1a0 mm/util.c:761
>  folio_migrate_copy+0x19/0x30 mm/migrate.c:619
>  __buffer_migrate_page+0x820/0xa80 mm/migrate.c:757
>  move_to_new_page+0x339/0xf00 mm/migrate.c:904
>  __unmap_and_move mm/migrate.c:1069 [inline]
>  unmap_and_move mm/migrate.c:1210 [inline]
>  migrate_pages+0x2867/0x3890 mm/migrate.c:1487
>  compact_zone+0x1abb/0x3860 mm/compaction.c:2393
>  kcompactd_do_work+0x2c9/0x730 mm/compaction.c:2808
>  kcompactd+0x262/0xd10 mm/compaction.c:2903
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> BUG: sleeping function called from invalid context at mm/util.c:761
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1660, name: kcompactd0
> 1 lock held by kcompactd0/1660:
>  #0: ffff8880111a4f70 (&mapping->private_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
>  #0: ffff8880111a4f70 (&mapping->private_lock){+.+.}-{2:2}, at: __buffer_migrate_page+0x3a8/0xa80 mm/migrate.c:722
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 1660 Comm: kcompactd0 Tainted: G        W         5.14.0-rc2-next-20210721-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  ___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9182
>  folio_copy+0x10c/0x1a0 mm/util.c:761
>  folio_migrate_copy+0x19/0x30 mm/migrate.c:619
>  __buffer_migrate_page+0x820/0xa80 mm/migrate.c:757
>  move_to_new_page+0x339/0xf00 mm/migrate.c:904
>  __unmap_and_move mm/migrate.c:1069 [inline]
>  unmap_and_move mm/migrate.c:1210 [inline]
>  migrate_pages+0x2867/0x3890 mm/migrate.c:1487
>  compact_zone+0x1abb/0x3860 mm/compaction.c:2393
>  kcompactd_do_work+0x2c9/0x730 mm/compaction.c:2808
>  kcompactd+0x262/0xd10 mm/compaction.c:2903
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
