Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4B3A740E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFOChE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:37:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6488 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFOCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3sKd50G2zZcKn;
        Tue, 15 Jun 2021 10:12:53 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:15:48 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:15:47 +0800
Subject: Re: [PATCH v3 0/6] ARM: mm: cleanup page fault and fix pxn process
 issue
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b00d0123-673a-0bc8-9ac2-282af64e7131@huawei.com>
Date:   Tue, 15 Jun 2021 10:15:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/10 20:35, Kefeng Wang wrote:
> The patchset cleanup ARM page fault handle to improve readability,
> fix the page table entries printing and fix infinite loop in the
> page fault handler when user code execution with privilege mode if
> ARM_LPAE enabled.
>
> echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>
> Before:
> -------
>   lkdtm: Performing direct entry EXEC_USERSPACE
>   lkdtm: attempting ok execution at c0717674
>   lkdtm: attempting bad execution at b6fd6000
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu:	1-....: (2100 ticks this GP) idle=7e2/1/0x40000002 softirq=136/136 fqs=1050
> 	(t=2101 jiffies g=-1027 q=16)
>   NMI backtrace for cpu 1
>   CPU: 1 PID: 57 Comm: sh Not tainted 5.13.0-rc4 #126
>   ...
>    r9:c1f04000 r8:c0e04cc8 r7:c1f05cbc r6:ffffffff r5:60000113 r4:c03724f8
>   [<c03722e0>] (handle_mm_fault) from [<c02152f4>] (do_page_fault+0x1a0/0x3d8)
>    r10:c180ec48 r9:c11b1aa0 r8:c11b1ac0 r7:8000020f r6:b6fd6000 r5:c180ec00
>    r4:c1f05df8
>   [<c0215154>] (do_page_fault) from [<c02157cc>] (do_PrefetchAbort+0x40/0x94)
>    r10:0000000f r9:c1f04000 r8:c1f05df8 r7:b6fd6000 r6:c0215154 r5:0000020f
>    r4:c0e09b18
>   [<c021578c>] (do_PrefetchAbort) from [<c0200c50>] (__pabt_svc+0x50/0x80)
>   Exception stack(0xc1f05df8 to 0xc1f05e40)
>   5de0: 0000002b 2e34f000
>   5e00: 3ee77213 3ee77213 b6fd6000 c0b51020 c140d000 c0a4b5dc 0000000f c1f05f58
>   5e20: 0000000f c1f05e64 c1f05d88 c1f05e48 c0717a6c b6fd6000 60000013 ffffffff
>    r8:0000000f r7:c1f05e2c r6:ffffffff r5:60000013 r4:b6fd6000
>   [<c07179a8>] (lkdtm_EXEC_USERSPACE) from [<c09a51b8>] (lkdtm_do_action+0x48/0x4c)
>    r4:00000027
>   ...
>
>
> After:
> -------
>   lkdtm: Performing direct entry EXEC_USERSPACE
>   lkdtm: attempting ok execution at c07176d4
>   lkdtm: attempting bad execution at b6f57000
>   8<--- cut here ---
>   Unable to handle kernel execution of memory at virtual address b6f57000
>   pgd = 81e20f00
>   [b6f57000] *pgd=81e23003, *pmd=13ee9c003
>   Internal error: Oops: 8000020f [#1] SMP ARM
>   Modules linked in:
>   CPU: 0 PID: 57 Comm: sh Not tainted 5.13.0-rc4+ #127
>   Hardware name: ARM-Versatile Express
>   PC is at 0xb6f57000
>   LR is at lkdtm_EXEC_USERSPACE+0xc4/0xd4
>   pc : [<b6f57000>]    lr : [<c0717acc>]    psr: 60000013
>   sp : c1f3de48  ip : c1f3dd88  fp : c1f3de64
>   r10: 0000000f  r9 : c1f3df58  r8 : 0000000f
>   r7 : c0a4b5dc  r6 : c1f1d000  r5 : c0b51070  r4 :b6f57000
>   r3 : 7e62f7da  r2 : 7e62f7da  r1 : 2e330000  r0 :0000002b
>   Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>   ...

Hi Russell， I fix patches according your comment.

Especially the patch 6，any new suggest about it, thanks.


>
> v3:
> - drop the fix about page table printing
> - kill page table base print instead of printing the physical address
> - only die when permission fault both kernel-mode and user code execution
>    with privilege mode
> - drop LPAE specific
>
> v2:
> - split patch into smaller changes suggested by Russell
> - fix page table printing in show_pte()
> - add new die_kernel_fault() helper
> - report "execution of user memory" when user code execution with
>    privilege mode
>
>
> Kefeng Wang (6):
>    ARM: mm: Rafactor the __do_page_fault()
>    ARM: mm: Kill task_struct argument for __do_page_fault()
>    ARM: mm: Cleanup access_error()
>    ARM: mm: Kill page table base print in show_pte()
>    ARM: mm: Provide die_kernel_fault() helper
>    ARM: mm: Fix PXN process with LPAE feature
>
>   arch/arm/mm/fault.c | 119 +++++++++++++++++++++++---------------------
>   arch/arm/mm/fault.h |   4 ++
>   2 files changed, 67 insertions(+), 56 deletions(-)
>
