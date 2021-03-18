Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59B340563
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCRMVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:21:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14397 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCRMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:21:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F1R0z5n77zkYmq;
        Thu, 18 Mar 2021 20:19:47 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Mar 2021 20:21:15 +0800
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in riscv_intc_irq
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <00000000000056b18b05bd7c6511@google.com>
 <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c82390e5-33f6-75f6-6b93-c618537413e5@huawei.com>
Date:   Thu, 18 Mar 2021 20:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/14 18:47, Dmitry Vyukov wrote:
> On Sun, Mar 14, 2021 at 11:14 AM syzbot
> <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15a35756d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
>> dashboard link: https://syzkaller.appspot.com/bug?extid=005654dd9b8f26bd4c07
>> userspace arch: riscv64
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in riscv_intc_irq+0x24/0xcc drivers/irqchip/irq-riscv-intc.c:24
>> Read of size 8 at addr ffffffe00c963bd0 by task kworker/1:1/4388
>>
>> CPU: 1 PID: 4388 Comm: kworker/1:1 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
>> Hardware name: riscv-virtio,qemu (DT)
>> Workqueue: events nsim_dev_trap_report_work
>> Call Trace:
>> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
>>
>> Allocated by task 76347056:
>> (stack is not available)
>>
>> Last potentially related work creation:
> There seems to be some issue with riscv stack unwinder.
> This does not have stacks.

Hi, could you test with the following  patch about the no stack 
issue(from v5.11-rc4), I made a mistake when do some cleanup...

https://lore.kernel.org/linux-riscv/ce5b3533-b75d-c31c-4319-9d29769bbbd5@huawei.com/T/#t

> "BUG: unable to handle kernel access to user memory in schedule_tail"
> does not have proper stacks:
> https://syzkaller.appspot.com/bug?id=9de8c24d24004fd5e482555f5ad8314da2fb1cee
>
> I also found 2 riscv reports in "KASAN: use-after-free Read in
> idr_for_each (2)":
> https://syzkaller.appspot.com/bug?id=7f84dfc3902878befc22e52eb5c7298d0ad70cf3
>
> both don't have any stacks:
>
> ==================================================================
> BUG: KASAN: use-after-free in radix_tree_next_slot
> include/linux/radix-tree.h:422 [inline]
> BUG: KASAN: use-after-free in idr_for_each+0xf4/0x160 lib/idr.c:202
> Read of size 8 at addr ffffffe010c00878 by task syz-executor.1/4828
>
> CPU: 0 PID: 4828 Comm: syz-executor.1 Not tainted
> 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
>
> Allocated by task 4828:
> (stack is not available)
>
> Freed by task 4473:
> (stack is not available)
>
>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> .
>
