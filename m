Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2843F5D38
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhHXLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:41:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42842 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhHXLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:41:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA17220C8;
        Tue, 24 Aug 2021 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629805260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmfCeTkNM8LU2XTfhyJxD2iUHsTJNZpwiLjx5URyJpM=;
        b=WTA0ExprQw93kmIO86i4v5hTufBuXrz/twK1x/aNzxibhAoV1+A9tzXo0CidDPSG42eKpS
        y2095eh1Xc9SzEj2ahyZ5eojNgysKuXcrmMtpgPZcHolmZ/Vkn6MWr42fOZmqE6sse79Ax
        WGdWUquGxboTTMgCkVNyu83SzwUSAPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629805260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmfCeTkNM8LU2XTfhyJxD2iUHsTJNZpwiLjx5URyJpM=;
        b=K46j01ryrauJRZmZK2dze4wTCWqbieTmQyOQm7jz4ScR6mm3dJ3Dq1RuEi/DokH6qgElYk
        XIgLhodAYLrFBHCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 007E513A50;
        Tue, 24 Aug 2021 11:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id erF5OsvaJGEmHgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 11:40:59 +0000
Message-ID: <03606e7d-dc38-a439-cd39-3f62b5739db0@suse.cz>
Date:   Tue, 24 Aug 2021 13:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [syzbot] WARNING in split_huge_page_to_list
Content-Language: en-US
To:     syzbot <syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <00000000000030563005ca006ffd@google.com>
Cc:     yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <00000000000030563005ca006ffd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
CC folks involved in 504e070dc08f ("mm: thp: replace DEBUG_VM BUG with VM_WARN
when unmap fails for split")

On 8/20/21 18:48, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f87d64319e6f Merge tag 'net-5.14-rc7' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1205bd55300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3205625db2f96ac9
> dashboard link: https://syzkaller.appspot.com/bug?extid=0c65e03871b364e714a3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com
> 
>  __do_munmap+0x627/0x11c0 mm/mmap.c:2911
>  do_munmap mm/mmap.c:2922 [inline]
>  munmap_vma_range mm/mmap.c:604 [inline]
>  mmap_region+0x85a/0x1760 mm/mmap.c:1753
>  do_mmap+0x86e/0x1180 mm/mmap.c:1584
>  vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
>  ksys_mmap_pgoff+0x4a8/0x620 mm/mmap.c:1635
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 unmap_page mm/huge_memory.c:2327 [inline]
> WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
> Modules linked in:
> CPU: 0 PID: 2144 Comm: kswapd1 Not tainted 5.14.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:unmap_page mm/huge_memory.c:2327 [inline]
> RIP: 0010:split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
> Code: 89 de e8 28 e1 b6 ff 84 db 0f 85 54 e0 ff ff e8 6b d9 b6 ff 48 c7 c6 e0 d8 97 89 48 89 ef e8 9c 72 e9 ff c6 05 05 dd 99 0b 01 <0f> 0b e9 32 e0 ff ff bb 02 00 00 00 e9 64 ef ff ff e8 3f d9 b6 ff
> RSP: 0018:ffffc900084f76d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88801c44c000 RSI: ffffffff81be0514 RDI: 0000000000000003
> RBP: ffffea00021c0000 R08: 0000000000000029 R09: 00000000ffffffff
> R10: ffffffff88ea7679 R11: 00000000ffffffff R12: ffff88814018d2d8
> R13: ffffea00021c0008 R14: ffffea00021c0000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f14895d5000 CR3: 0000000017350000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  split_huge_page include/linux/huge_mm.h:192 [inline]
>  deferred_split_scan+0x5fa/0xbd0 mm/huge_memory.c:2860
>  do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:709
>  shrink_slab+0x17c/0x6e0 mm/vmscan.c:869
>  shrink_node_memcgs mm/vmscan.c:2868 [inline]
>  shrink_node+0x8d1/0x1df0 mm/vmscan.c:2983
>  kswapd_shrink_node mm/vmscan.c:3726 [inline]
>  balance_pgdat+0x7ce/0x13b0 mm/vmscan.c:3917
>  kswapd+0x5b6/0xdb0 mm/vmscan.c:4176
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
> 

