Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2ED3AE1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFUC75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:59:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5408 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:59:55 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7Yyp5jN0z72H7;
        Mon, 21 Jun 2021 10:54:26 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 10:57:40 +0800
Received: from [10.174.177.134] (10.174.177.134) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 10:57:39 +0800
Subject: Re: [PATCH] riscv: stacktrace: Fix NULL pointer dereference
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210619001332.2c0c9a05@xhacker>
From:   Chen Huang <chenhuang5@huawei.com>
Message-ID: <237c3d40-17ad-1e69-a66c-b94af92dd075@huawei.com>
Date:   Mon, 21 Jun 2021 10:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210619001332.2c0c9a05@xhacker>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/6/19 0:13, Jisheng Zhang Ð´µÀ:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> When CONFIG_FRAME_POINTER=y, calling dump_stack() can always trigger
> NULL pointer dereference panic similar as below:
> 
> [    0.396060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> [    0.396692] Hardware name: riscv-virtio,qemu (DT)
> [    0.397176] Call Trace:
> [    0.398191] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000960
> [    0.399487] Oops [#1]
> [    0.399739] Modules linked in:
> [    0.400135] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc5+ #47
> [    0.400570] Hardware name: riscv-virtio,qemu (DT)
> [    0.400926] epc : walk_stackframe+0xc4/0xdc
> [    0.401291]  ra : dump_backtrace+0x30/0x38
> [    0.401630] epc : ffffffff80004922 ra : ffffffff8000496a sp : ffffffe000f3bd00
> [    0.402115]  gp : ffffffff80cfdcb8 tp : ffffffe000f30000 t0 : ffffffff80d0b0cf
> [    0.402602]  t1 : ffffffff80d0b0c0 t2 : 0000000000000000 s0 : ffffffe000f3bd60
> [    0.403071]  s1 : ffffffff808bc2e8 a0 : 0000000000001000 a1 : 0000000000000000
> [    0.403448]  a2 : ffffffff803d7088 a3 : ffffffff808bc2e8 a4 : 6131725dbc24d400
> [    0.403820]  a5 : 0000000000001000 a6 : 0000000000000002 a7 : ffffffffffffffff
> [    0.404226]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> [    0.404634]  s5 : ffffffff803d7088 s6 : ffffffff808bc2e8 s7 : ffffffff80630650
> [    0.405085]  s8 : ffffffff80912a80 s9 : 0000000000000008 s10: ffffffff804000fc
> [    0.405388]  s11: 0000000000000000 t3 : 0000000000000043 t4 : ffffffffffffffff
> [    0.405616]  t5 : 000000000000003d t6 : ffffffe000f3baa8
> [    0.405793] status: 0000000000000100 badaddr: 0000000000000960 cause: 000000000000000d
> [    0.406135] [<ffffffff80004922>] walk_stackframe+0xc4/0xdc
> [    0.407032] [<ffffffff8000496a>] dump_backtrace+0x30/0x38
> [    0.407797] [<ffffffff803d7100>] show_stack+0x40/0x4c
> [    0.408234] [<ffffffff803d9e5c>] dump_stack+0x90/0xb6
> [    0.409019] [<ffffffff8040423e>] ptdump_init+0x20/0xc4
> [    0.409681] [<ffffffff800015b6>] do_one_initcall+0x4c/0x226
> [    0.410110] [<ffffffff80401094>] kernel_init_freeable+0x1f4/0x258
> [    0.410562] [<ffffffff803dba88>] kernel_init+0x22/0x148
> [    0.410959] [<ffffffff800029e2>] ret_from_exception+0x0/0x14
> [    0.412241] ---[ end trace b2ab92c901b96251 ]---
> [    0.413099] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> The reason is the task is NULL when we finally call walk_stackframe()
> the NULL is passed from __dump_stack():
> 
> |static void __dump_stack(void)
> |{
> |        dump_stack_print_info(KERN_DEFAULT);
> |        show_stack(NULL, NULL, KERN_DEFAULT);
> |}
> 
> Fix this issue by checking "task == NULL" case in walk_stackframe().
> 
> Fixes: eac2f3059e02 ("riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled"
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index bde85fc53357..7bc8af75933a 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -27,7 +27,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  		fp = frame_pointer(regs);
>  		sp = user_stack_pointer(regs);
>  		pc = instruction_pointer(regs);
> -	} else if (task == current) {
> +	} else if (task == NULL || task == current) {
>  		fp = (unsigned long)__builtin_frame_address(1);
>  		sp = (unsigned long)__builtin_frame_address(0);
>  		pc = (unsigned long)__builtin_return_address(0);
> 

I'm sorry I made a mistake for confusing the function pr_cont's stack with the stack when task
is NULL. Anyway, I tested the patch and it looks good.

Reviewed-by: Chen Huang <chenhuang5@huawei.com>

Thanks.


