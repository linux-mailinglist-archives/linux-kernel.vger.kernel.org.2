Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E2340821
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhCROu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:50:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14398 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCROuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:50:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F1VJT3grTzkbMB;
        Thu, 18 Mar 2021 22:48:25 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Mar 2021 22:49:55 +0800
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in riscv_intc_irq
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     syzbot <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <00000000000056b18b05bd7c6511@google.com>
 <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
 <c82390e5-33f6-75f6-6b93-c618537413e5@huawei.com>
 <CACT4Y+ZpfAiQKagp5xr0HY85SRr2h6pe10emm4_B5RLfVraN9A@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <093ff4d1-3977-1085-404f-ec46a3b1d8f0@huawei.com>
Date:   Thu, 18 Mar 2021 22:49:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZpfAiQKagp5xr0HY85SRr2h6pe10emm4_B5RLfVraN9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/18 22:11, Dmitry Vyukov wrote:
> On Thu, Mar 18, 2021 at 1:21 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> On 2021/3/14 18:47, Dmitry Vyukov wrote:
>>> On Sun, Mar 14, 2021 at 11:14 AM syzbot
>>> <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15a35756d00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=005654dd9b8f26bd4c07
>>>> userspace arch: riscv64
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: slab-out-of-bounds in riscv_intc_irq+0x24/0xcc drivers/irqchip/irq-riscv-intc.c:24
>>>> Read of size 8 at addr ffffffe00c963bd0 by task kworker/1:1/4388
>>>>
>>>> CPU: 1 PID: 4388 Comm: kworker/1:1 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
>>>> Hardware name: riscv-virtio,qemu (DT)
>>>> Workqueue: events nsim_dev_trap_report_work
>>>> Call Trace:
>>>> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
>>>>
>>>> Allocated by task 76347056:
>>>> (stack is not available)
>>>>
>>>> Last potentially related work creation:
>>> There seems to be some issue with riscv stack unwinder.
>>> This does not have stacks.
>> Hi, could you test with the following  patch about the no stack
>> issue(from v5.11-rc4), I made a mistake when do some cleanup...
>>
>> https://lore.kernel.org/linux-riscv/ce5b3533-b75d-c31c-4319-9d29769bbbd5@huawei.com/T/#t
> Hi Kefeng,
>
> Please see:
> http://bit.do/syzbot#no-custom-patches
>
> Is a unit-test for this possible? Fuzzing is not a replacement for unit testing.

ok, I mean that the issue about stack unwinder which may cause by my 
previous patch,

if some one want the stack back, it could try the bugfix.

> .
>
