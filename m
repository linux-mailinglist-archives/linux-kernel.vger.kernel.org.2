Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86992446CF7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhKFIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 04:03:15 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53659 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231241AbhKFICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 04:02:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UvGePNU_1636185580;
Received: from 30.25.225.61(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UvGePNU_1636185580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 06 Nov 2021 15:59:41 +0800
Message-ID: <63969f82-93bd-f5b0-297b-a64c60a797d6@linux.alibaba.com>
Date:   Sat, 6 Nov 2021 15:59:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0)
 Gecko/20100101 Thunderbird/94.0
Subject: Re: [syzbot] kernel BUG in trans_pgd_create_copy
Content-Language: en-US
To:     syzbot <syzbot+a0d68c9c9123000ed5ab@syzkaller.appspotmail.com>,
        catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
References: <000000000000f1c1fa05d019fb10@google.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <000000000000f1c1fa05d019fb10@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/21 3:48 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d4439a1189f9 Merge tag 'hsi-for-5.16' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b5f782b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8eccc5e89b1d525c
> dashboard link: https://syzkaller.appspot.com/bug?extid=a0d68c9c9123000ed5ab
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: arm
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a0d68c9c9123000ed5ab@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at arch/arm64/include/asm/pgalloc.h:79!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 12093 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller-10158-gd4439a1189f9 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : pmd_populate_kernel arch/arm64/include/asm/pgalloc.h:79 [inline]
> pc : copy_pte arch/arm64/mm/trans_pgd.c:70 [inline]
> pc : copy_pmd arch/arm64/mm/trans_pgd.c:105 [inline]
> pc : copy_pud arch/arm64/mm/trans_pgd.c:141 [inline]
> pc : copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
> pc : copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
> pc : trans_pgd_create_copy+0x5bc/0x7f0 arch/arm64/mm/trans_pgd.c:213
> lr : trans_alloc arch/arm64/mm/trans_pgd.c:30 [inline]
> lr : copy_pte arch/arm64/mm/trans_pgd.c:67 [inline]
> lr : copy_pmd arch/arm64/mm/trans_pgd.c:105 [inline]
> lr : copy_pud arch/arm64/mm/trans_pgd.c:141 [inline]
> lr : copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
> lr : copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
> lr : trans_pgd_create_copy+0x480/0x7f0 arch/arm64/mm/trans_pgd.c:213
> sp : ffff80001b977a60
> x29: ffff80001b977a60 x28: 1fffe0000ffff000 x27: ffff800010059c90
> x26: ffff00003fffffff x25: ffff000032476000 x24: dfff800000000000
> x23: ffff000000200000 x22: ffff80001b977c30 x21: ffff000040000000
> x20: ffff00007fff8000 x19: ffff000000000000 x18: fffffbffeff9c3c8
> x17: 0000000000000000 x16: 0000000000000000 x15: d503201fd503201f
> x14: 1ffff0000372ee30 x13: 0000000000000000 x12: ffff60000648f000
> x11: 1fffe0000648efff x10: ffff60000648efff x9 : 0000000000000000
> x8 : ffff000032478000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
> x2 : fffffc0000000000 x1 : ffff800015f1e560 x0 : ffff000032477000
> Call trace:
>   set_p4d arch/arm64/include/asm/pgtable.h:695 [inline]
>   __p4d_populate arch/arm64/include/asm/pgalloc.h:46 [inline]
>   p4d_populate arch/arm64/include/asm/pgalloc.h:54 [inline]
>   copy_pud arch/arm64/mm/trans_pgd.c:129 [inline]
>   copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
>   copy_page_tables arch/arm64/mm/trans_pgd.c:186 [inline]
>   trans_pgd_create_copy+0x5bc/0x7f0 arch/arm64/mm/trans_pgd.c:213
>   machine_kexec_post_load+0x178/0x6d0 arch/arm64/kernel/machine_kexec.c:146
>   do_kexec_load+0x194/0x520 kernel/kexec.c:155
>   __do_compat_sys_kexec_load kernel/kexec.c:292 [inline]
>   __se_compat_sys_kexec_load kernel/kexec.c:257 [inline]
>   __arm64_compat_sys_kexec_load+0x36c/0x47c kernel/kexec.c:257
>   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>   invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
>   el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
>   do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:187
>   el0_svc_compat+0x64/0x280 arch/arm64/kernel/entry-common.c:736
>   el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:746
>   el0t_32_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:577
> Code: 17fffee0 aa1503e0 97ffdd37 17ffff17 (d4210000)
> ---[ end trace a6c0112af29130b0 ]---
> 
> 
This bug seems like that I described in last week:
link: 
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211030183200.51295-2-rongwei.wang@linux.alibaba.com/

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
