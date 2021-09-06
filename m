Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76F5401C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbhIFNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:01:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41221 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243806AbhIFNAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:00:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UnTmxSQ_1630933157;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UnTmxSQ_1630933157)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Sep 2021 20:59:17 +0800
Subject: Re: kernel BUG in truncate_inode_page
To:     Hao Sun <sunhao.th@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <23adb5bc-13f6-7550-2ec1-b19b713639d6@linux.alibaba.com>
Date:   Mon, 6 Sep 2021 20:59:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, we also reproduce such bug recently, and have sent out our patch[1].

In addition, another issue related with xfs and file THP is also
fixed[2].

Looking forward to reviews.

[1]https://patchwork.kernel.org/project/linux-mm/patch/20210906121200.57905-2-rongwei.wang@linux.alibaba.com/
[2]https://patchwork.kernel.org/project/linux-mm/patch/20210906121200.57905-3-rongwei.wang@linux.alibaba.com/


On 9/6/21 2:15 PM, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 9e9fb7655ed58 Merge tag 'net-next-5.15'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1_eEgvafiNcZHqHlmjIy4d420gQTvkf3r/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1zgxbwaYkrM26KEmJ-5sUZX57gfXtRrwA/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/1ZLAhA14JN9prY7Fei_WWnuhNXCg8AM8C/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1TejG8gPgiAkJsKBlwFdHIADKXDK-H6j8/view?usp=sharing
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> 
> page:ffffea0004730040 refcount:514 mapcount:1 mapping:ffff88800d7d13e8
> index:0x1 pfn:0x11cc01
> head:ffffea0004730000 order:9 compound_mapcount:1 compound_pincount:0
> memcg:ffff888009ba2000
> aops:def_blk_aops ino:fa00000
> flags: 0x57ff0000001001f(locked|referenced|uptodate|dirty|lru|head|node=1|zone=2|lastcpupid=0x7ff)
> raw: 057ff00000000000 ffffea0004730001 0000000000000903 dead000000000200
> raw: 0000000000000100 0000000000000000 0000000000000000 0000000000000000
> head: 057ff0000001001f ffffea00044edec8 ffffea00044c2708 ffff88800d7d13e8
> head: 0000000000000000 0000000000000000 0000020200000000 ffff888009ba2000
> page dumped because: VM_BUG_ON_PAGE(PageTail(page))
> page_owner tracks the page as allocated
> page last allocated via order 9, migratetype Movable, gfp_mask
> 0x13c24ca(GFP_TRANSHUGE|__GFP_THISNODE), pid 1665, ts 469126509176,
> free_ts 440578020808
>   prep_new_page+0x16/0x50 mm/page_alloc.c:2436
>   get_page_from_freelist+0x64d/0x29a0 mm/page_alloc.c:4168
>   __alloc_pages+0xde/0x2a0 mm/page_alloc.c:5390
>   __alloc_pages_node include/linux/gfp.h:570 [inline]
>   khugepaged_alloc_page+0x4e/0xc0 mm/khugepaged.c:881
>   collapse_file+0x124/0x2110 mm/khugepaged.c:1655
>   khugepaged_scan_file mm/khugepaged.c:2051 [inline]
>   khugepaged_scan_mm_slot mm/khugepaged.c:2146 [inline]
>   khugepaged_do_scan mm/khugepaged.c:2230 [inline]
>   khugepaged+0x1f8a/0x3540 mm/khugepaged.c:2275
>   kthread+0x178/0x1b0 kernel/kthread.c:319
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> page last free stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1346 [inline]
>   free_pcp_prepare+0x1d7/0x480 mm/page_alloc.c:1397
>   free_unref_page_prepare mm/page_alloc.c:3332 [inline]
>   free_unref_page+0x19/0x1c0 mm/page_alloc.c:3411
>   release_pages+0x212/0x1130 mm/swap.c:948
>   tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
>   tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
>   tlb_flush_mmu+0x60/0x1e0 mm/mmu_gather.c:249
>   zap_pte_range mm/memory.c:1432 [inline]
>   zap_pmd_range mm/memory.c:1481 [inline]
>   zap_pud_range mm/memory.c:1510 [inline]
>   zap_p4d_range mm/memory.c:1531 [inline]
>   unmap_page_range+0xea6/0x15c0 mm/memory.c:1552
>   unmap_single_vma+0xae/0x140 mm/memory.c:1597
>   unmap_vmas+0xed/0x190 mm/memory.c:1629
>   exit_mmap+0xc9/0x2a0 mm/mmap.c:3195
>   __mmput kernel/fork.c:1103 [inline]
>   mmput+0x8a/0x1a0 kernel/fork.c:1124
>   exit_mm kernel/exit.c:501 [inline]
>   do_exit+0x462/0x11c0 kernel/exit.c:812
>   do_group_exit+0x57/0xe0 kernel/exit.c:922
>   get_signal+0x1d0/0x10b0 kernel/signal.c:2823
>   arch_do_signal_or_restart+0xa9/0x860 arch/x86/kernel/signal.c:865
>   handle_signal_work kernel/entry/common.c:148 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>   exit_to_user_mode_prepare+0xf2/0x280 kernel/entry/common.c:209
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>   do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
> ------------[ cut here ]------------
> kernel BUG at mm/truncate.c:213!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 27281 Comm: syz-executor Not tainted 5.14.0+ #12
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:truncate_inode_page+0x5a/0x70 mm/truncate.c:213
> Code: ff ff 48 89 ef e8 56 9e fd ff e8 71 2d f0 ff 89 d8 5b 5d 41 5c
> c3 e8 65 2d f0 ff 48 c7 c6 20 19 2d 85 48 89 ef e8 f6 f7 03 00 <0f> 0b
> bb fb ff ff ff eb d7 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0018:ffffc9000361fc88 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90001356000
> RDX: 0000000000040000 RSI: ffffffff8147479a RDI: 00000000ffffffff
> RBP: ffffea0004730040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 637379735f6f6420 R12: ffff88800d7d13e8
> R13: ffffc9000361fd48 R14: 0000000000000001 R15: ffffc9000361fcd0
> FS:  00007f3c4f6a0700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000204001ff CR3: 000000010f099000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   truncate_inode_pages_range+0x3b9/0xc30 mm/truncate.c:397
>   truncate_bdev_range+0x87/0xd0 fs/block_dev.c:125
>   blk_ioctl_zeroout block/ioctl.c:173 [inline]
>   blkdev_common_ioctl+0x2c3/0xad0 block/ioctl.c:472
>   blkdev_ioctl+0x2c2/0x370 block/ioctl.c:583
>   block_ioctl+0x55/0x70 fs/block_dev.c:1421
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:874 [inline]
>   __se_sys_ioctl fs/ioctl.c:860 [inline]
>   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46a9a9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3c4f69fc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000078c210 RCX: 000000000046a9a9
> RDX: 00000000200003c0 RSI: 000000000000127f RDI: 0000000000000004
> RBP: 00000000004e4042 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c210
> R13: 0000000000000000 R14: 000000000078c210 R15: 00007fff7770d6e0
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 4d3d97b8450ac449 ]---
> RIP: 0010:truncate_inode_page+0x5a/0x70 mm/truncate.c:213
> Code: ff ff 48 89 ef e8 56 9e fd ff e8 71 2d f0 ff 89 d8 5b 5d 41 5c
> c3 e8 65 2d f0 ff 48 c7 c6 20 19 2d 85 48 89 ef e8 f6 f7 03 00 <0f> 0b
> bb fb ff ff ff eb d7 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0018:ffffc9000361fc88 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90001356000
> RDX: 0000000000040000 RSI: ffffffff8147479a RDI: 00000000ffffffff
> RBP: ffffea0004730040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 637379735f6f6420 R12: ffff88800d7d13e8
> R13: ffffc9000361fd48 R14: 0000000000000001 R15: ffffc9000361fcd0
> FS:  00007f3c4f6a0700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000204001ff CR3: 000000010f099000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> 

-- 
Thanks,
Yu
