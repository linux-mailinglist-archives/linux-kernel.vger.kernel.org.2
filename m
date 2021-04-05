Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1A353B04
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhDEDEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhDEDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:04:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A93C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cN/Spv35x0pwWsjEgNwu5WxmajnEowdx5QFLvVqU3nk=; b=NBUEnMuljaH7bseZP/nM/BXy4l
        dpVzSfQXkpoVGhvsoaYdbFLK0b/6Rg69PXgF+gcKYdhRI2SQjibmsjbjg58rzmq8doUsdofKBl6CH
        rDTxafMRBRMhhY6ZicRngICI/VUpR5bFGxVbYCjzUaQpTmHVum0bActiJ/dOjB1al2zuLvZcIKw0K
        C8JVSTVV35MhbmKpcmXi0njFVH7wYiCom+wOy6HsfxUxrDxFNWihZT/Dbq7DnqXjsqGFqGu4VQxtn
        qCFeKMX1EgIk+lQjp9RVy3w7IEJdZfD9onvWHYWlv66eJvIMMNUsEls05VyddAkG6DjmP8Oe2x+K6
        BQLMBlBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTFX7-00ArAo-Bo; Mon, 05 Apr 2021 03:04:14 +0000
Date:   Mon, 5 Apr 2021 04:04:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+26ad5e106ca477175819@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: suspicious RCU usage in remove_vma (2)
Message-ID: <20210405030409.GE2531743@casper.infradead.org>
References: <00000000000019114805bf0fb1bc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000019114805bf0fb1bc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING: suspicious RCU usage in getname_flags

On Sat, Apr 03, 2021 at 04:23:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1052e1d6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a3d65a48dbd1bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=26ad5e106ca477175819
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+26ad5e106ca477175819@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.12.0-rc5-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by syz-executor.0/29105.
> 
> stack backtrace:
> CPU: 0 PID: 29105 Comm: syz-executor.0 Not tainted 5.12.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
>  remove_vma+0x44/0x170 mm/mmap.c:178
>  exit_mmap+0x33f/0x590 mm/mmap.c:3229
>  __mmput+0x122/0x470 kernel/fork.c:1090
>  mmput+0x58/0x60 kernel/fork.c:1111
>  exit_mm kernel/exit.c:501 [inline]
>  do_exit+0xb0a/0x2a60 kernel/exit.c:812
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  get_signal+0x47f/0x2150 kernel/signal.c:2781
>  arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
>  handle_signal_work kernel/entry/common.c:147 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x466459
> Code: Unable to access opcode bytes at RIP 0x46642f.
> RSP: 002b:00007fdfaa117218 EFLAGS: 00000246
>  ORIG_RAX: 00000000000000ca
> RAX: 0000000000000000 RBX: 000000000056bf68 RCX: 0000000000466459
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf68
> RBP: 000000000056bf60 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf6c
> R13: 00007fff64c569cf R14: 00007fdfaa117300 R15: 0000000000022000
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
