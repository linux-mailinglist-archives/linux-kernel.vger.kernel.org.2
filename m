Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F273353B02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhDEDDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhDEDDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:03:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EBC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 20:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2g6L/9w3OS4UlT+NvfqBmNsfRXMTlPyKwhbgW61DNqs=; b=pP8FA+6IMlHNX64FQz2IIKo4Sh
        0fnbkEmlimF7dZL3Wl+8Z6aputcwfUudCX9pExWS4VdMoIJ4LSBpzntuOWzuYbJixb93SUqQ3M2I2
        JbDifxLrYk8YDnrPZ5aG/NvB+TenWrvycXKSW4Obut0aguuuZZBI8IcFq0gKkE2JPwkEWiTqBWN6p
        zrXQ5+waj/qjIiErlE8jFRPCLNRaUBoClVeGnMlEGyYy0thRRDiwDycbzfSn0L31FZsaXwrdoP/WP
        GHj+wS+OmLSe64crrj+R7H4H+CmGQ0DqAmCxPasZhnA8B8kEa6Vf/RimtwBL6jD9txNzRlsRSpyZ+
        UpvwM16A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTFVs-00Ar1A-75; Mon, 05 Apr 2021 03:02:55 +0000
Date:   Mon, 5 Apr 2021 04:02:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+d7dd989878658902c6d6@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: suspicious RCU usage in list_lru_destroy
Message-ID: <20210405030252.GC2531743@casper.infradead.org>
References: <00000000000035b58705bf270c19@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000035b58705bf270c19@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING: suspicious RCU usage in getname_flags

On Sun, Apr 04, 2021 at 08:15:13AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15556cced00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7dd989878658902c6d6
> compiler:       Debian clang version 11.0.1-2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d7dd989878658902c6d6@syzkaller.appspotmail.com
> 
> EXT4-fs (loop0): mount failed
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
> no locks held by syz-executor.0/10672.
> 
> stack backtrace:
> CPU: 0 PID: 10672 Comm: syz-executor.0 Not tainted 5.12.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x176/0x24e lib/dump_stack.c:120
>  ___might_sleep+0x6e/0x530 kernel/sched/core.c:8294
>  down_read+0x17/0x50 kernel/locking/rwsem.c:1352
>  list_lru_destroy+0x49/0x390 mm/list_lru.c:628
>  deactivate_locked_super+0xbf/0xf0 fs/super.c:343
>  mount_bdev+0x288/0x3a0 fs/super.c:1369
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>  vfs_get_tree+0x86/0x270 fs/super.c:1497
>  do_new_mount fs/namespace.c:2903 [inline]
>  path_mount+0x188a/0x29a0 fs/namespace.c:3233
>  do_mount fs/namespace.c:3246 [inline]
>  __do_sys_mount fs/namespace.c:3454 [inline]
>  __se_sys_mount+0x28c/0x320 fs/namespace.c:3431
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46797a
> Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f77bde01fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 000000000046797a
> RDX: 0000000020000300 RSI: 0000000020000100 RDI: 00007f77bde02000
> RBP: 00007f77bde02040 R08: 00007f77bde02040 R09: 0000000020000300
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000300
> R13: 0000000020000100 R14: 00007f77bde02000 R15: 00000000200000c0
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
