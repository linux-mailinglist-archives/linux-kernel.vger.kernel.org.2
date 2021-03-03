Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5B32BF09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577234AbhCCRse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4262 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238560AbhCCOyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:54:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DrH6K5yVWz9tyY7;
        Wed,  3 Mar 2021 15:52:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rUeZkj7gGtB7; Wed,  3 Mar 2021 15:52:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DrH6K50QRz9tyY3;
        Wed,  3 Mar 2021 15:52:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 85C278B7E6;
        Wed,  3 Mar 2021 15:52:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SVrpgpT8WrDo; Wed,  3 Mar 2021 15:52:41 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E37758B7DB;
        Wed,  3 Mar 2021 15:52:40 +0100 (CET)
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
To:     Marco Elver <elver@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
 <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
Date:   Wed, 3 Mar 2021 15:52:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/03/2021 à 15:38, Marco Elver a écrit :
> On Wed, 3 Mar 2021 at 15:09, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> It seems like all other sane architectures, namely x86 and arm64
>> at least, include the running function as top entry when saving
>> stack trace.
>>
>> Functionnalities like KFENCE expect it.
>>
>> Do the same on powerpc, it allows KFENCE to properly identify the faulting
>> function as depicted below. Before the patch KFENCE was identifying
>> finish_task_switch.isra as the faulting function.
>>
>> [   14.937370] ==================================================================
>> [   14.948692] BUG: KFENCE: invalid read in test_invalid_access+0x54/0x108
>> [   14.948692]
>> [   14.956814] Invalid read at 0xdf98800a:
>> [   14.960664]  test_invalid_access+0x54/0x108
>> [   14.964876]  finish_task_switch.isra.0+0x54/0x23c
>> [   14.969606]  kunit_try_run_case+0x5c/0xd0
>> [   14.973658]  kunit_generic_run_threadfn_adapter+0x24/0x30
>> [   14.979079]  kthread+0x15c/0x174
>> [   14.982342]  ret_from_kernel_thread+0x14/0x1c
>> [   14.986731]
>> [   14.988236] CPU: 0 PID: 111 Comm: kunit_try_catch Tainted: G    B             5.12.0-rc1-01537-g95f6e2088d7e-dirty #4682
>> [   14.999795] NIP:  c016ec2c LR: c02f517c CTR: c016ebd8
>> [   15.004851] REGS: e2449d90 TRAP: 0301   Tainted: G    B              (5.12.0-rc1-01537-g95f6e2088d7e-dirty)
>> [   15.015274] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 22000004  XER: 00000000
>> [   15.022043] DAR: df98800a DSISR: 20000000
>> [   15.022043] GPR00: c02f517c e2449e50 c1142080 e100dd24 c084b13c 00000008 c084b32b c016ebd8
>> [   15.022043] GPR08: c0850000 df988000 c0d10000 e2449eb0 22000288
>> [   15.040581] NIP [c016ec2c] test_invalid_access+0x54/0x108
>> [   15.046010] LR [c02f517c] kunit_try_run_case+0x5c/0xd0
>> [   15.051181] Call Trace:
>> [   15.053637] [e2449e50] [c005a68c] finish_task_switch.isra.0+0x54/0x23c (unreliable)
>> [   15.061338] [e2449eb0] [c02f517c] kunit_try_run_case+0x5c/0xd0
>> [   15.067215] [e2449ed0] [c02f648c] kunit_generic_run_threadfn_adapter+0x24/0x30
>> [   15.074472] [e2449ef0] [c004e7b0] kthread+0x15c/0x174
>> [   15.079571] [e2449f30] [c001317c] ret_from_kernel_thread+0x14/0x1c
>> [   15.085798] Instruction dump:
>> [   15.088784] 8129d608 38e7ebd8 81020280 911f004c 39000000 995f0024 907f0028 90ff001c
>> [   15.096613] 3949000a 915f0020 3d40c0d1 3d00c085 <8929000a> 3908adb0 812a4b98 3d40c02f
>> [   15.104612] ==================================================================
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> Thank you, I think this looks like the right solution. Just a question below:
> 
...

>> @@ -59,23 +70,26 @@ void save_stack_trace(struct stack_trace *trace)
>>
>>          sp = current_stack_frame();
>>
>> -       save_context_stack(trace, sp, current, 1);
>> +       save_context_stack(trace, sp, (unsigned long)save_stack_trace, current, 1);
> 
> This causes ip == save_stack_trace and also below for
> save_stack_trace_tsk. Does this mean save_stack_trace() is included in
> the trace? Looking at kernel/stacktrace.c, I think the library wants
> to exclude itself from the trace, as it does '.skip = skipnr + 1' (and
> '.skip   = skipnr + (current == tsk)' for the _tsk variant).
> 
> If the arch-helper here is included, should this use _RET_IP_ instead?
> 

Don't really know, I was inspired by arm64 which has:

void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
		     struct task_struct *task, struct pt_regs *regs)
{
	struct stackframe frame;

	if (regs)
		start_backtrace(&frame, regs->regs[29], regs->pc);
	else if (task == current)
		start_backtrace(&frame,
				(unsigned long)__builtin_frame_address(0),
				(unsigned long)arch_stack_walk);
	else
		start_backtrace(&frame, thread_saved_fp(task),
				thread_saved_pc(task));

	walk_stackframe(task, &frame, consume_entry, cookie);
}


But looking at x86 you may be right, so what should be done really ?

Thanks
Christophe
