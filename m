Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441873DE0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhHBUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHBUbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F5FD60D07;
        Mon,  2 Aug 2021 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627936267;
        bh=TeE0VCpvZ/nDJi29Ay8uoyosJZqkaBlv6XTXYRUX9pM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bdZFq7N2jXHQkrGXGjb1cA1m/yQQXI0uob7B1UFIy1OpPpFrnTqFFZOEHpnWJC6KR
         VHxLoI0VrqFhhhkVa+j1XYICFE3kdxT/AX+wtPPN8F2Umj9FlfjaKzNCU0DCY2RIjt
         cfw25qO1UxneAtMBmCE6h7e6PqNpW2rsHTBUXS4w=
Date:   Mon, 2 Aug 2021 13:31:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+6a04d6ba849df9d81239@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>
Subject: Re: [syzbot] divide error in wb_update_dirty_ratelimit
Message-Id: <20210802133106.7106b66013665ead219a1d15@linux-foundation.org>
In-Reply-To: <0000000000008bd88e05c897ad5f@google.com>
References: <0000000000008bd88e05c897ad5f@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 11:24:20 -0700 syzbot <syzbot+6a04d6ba849df9d81239@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d4b477da1a8 Add linux-next specific files for 20210730
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=128ede56300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4adf4987f875c210
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a04d6ba849df9d81239
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6a04d6ba849df9d81239@syzkaller.appspotmail.com
> 
> divide error: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 10430 Comm: syz-executor.3 Not tainted 5.14.0-rc3-next-20210730-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:wb_update_dirty_ratelimit+0x18d/0x7d0 mm/page-writeback.c:1197

Thanks.

Presumably wb_update_dirty_ratelimit() was passed elapsed==0.  Jan,
could your changes have caused this?

> Code: 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 4c 2b b5 30 02 00 00 49 8d 7f 58 31 d2 49 6b c6 64 <48> f7 f3 48 89 fa 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1
> RSP: 0018:ffffc9000551f750 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000fdb1000
> RDX: 0000000000000000 RSI: 0000000000006377 RDI: ffffc9000551f9a0
> RBP: ffff888089632060 R08: 0000000000000000 R09: ffffffff9023d363
> R10: fffffbfff2047a6c R11: 0000000000000000 R12: 0000000000006400
> R13: 000000000003c2b1 R14: 0000000000000000 R15: ffffc9000551f948
> FS:  00007fdc4e708700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000206000bf CR3: 0000000073f41000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __wb_update_bandwidth+0x3d7/0x5a0 mm/page-writeback.c:1350
>  balance_dirty_pages+0x12ab/0x29d0 mm/page-writeback.c:1719
>  balance_dirty_pages_ratelimited+0xda2/0x1820 mm/page-writeback.c:1920
>  generic_perform_write+0x320/0x510 mm/filemap.c:3789
>  __generic_file_write_iter+0x24e/0x610 mm/filemap.c:3882
>  generic_file_write_iter+0xd7/0x220 mm/filemap.c:3914
>  fuse_cache_write_iter fs/fuse/file.c:1298 [inline]
>  fuse_file_write_iter+0x56c/0xcd0 fs/fuse/file.c:1601
>  call_write_iter include/linux/fs.h:2152 [inline]
>  new_sync_write+0x426/0x650 fs/read_write.c:518
>  vfs_write+0x75a/0xa40 fs/read_write.c:605
>  ksys_write+0x12d/0x250 fs/read_write.c:658
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdc4e708188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
> RDX: 00000000fffffdef RSI: 00000000200000c0 RDI: 0000000000000006
> RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007fff2d6f27cf R14: 00007fdc4e708300 R15: 0000000000022000
> Modules linked in:
> ---[ end trace 01891e5696647ce8 ]---
> RIP: 0010:wb_update_dirty_ratelimit+0x18d/0x7d0 mm/page-writeback.c:1197
> Code: 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 05 00 00 4c 2b b5 30 02 00 00 49 8d 7f 58 31 d2 49 6b c6 64 <48> f7 f3 48 89 fa 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1
> RSP: 0018:ffffc9000551f750 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000fdb1000
> RDX: 0000000000000000 RSI: 0000000000006377 RDI: ffffc9000551f9a0
> RBP: ffff888089632060 R08: 0000000000000000 R09: ffffffff9023d363
> R10: fffffbfff2047a6c R11: 0000000000000000 R12: 0000000000006400
> R13: 000000000003c2b1 R14: 0000000000000000 R15: ffffc9000551f948
> FS:  00007fdc4e708700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000206000bf CR3: 0000000073f41000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

