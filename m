Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01963CD48D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhGSLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:38:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11450 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhGSLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:38:36 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GT15k09Z7zcg7Z;
        Mon, 19 Jul 2021 20:15:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 20:19:15 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 20:19:14 +0800
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
Message-ID: <c96d7688-a8cd-85cd-9e2b-bdce5bd84db0@huawei.com>
Date:   Mon, 19 Jul 2021 20:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,  kindly ping after 5.14-rc2, any comments, thanks.

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
