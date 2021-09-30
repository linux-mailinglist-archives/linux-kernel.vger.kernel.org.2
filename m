Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B041DD74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbhI3Pah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:30:37 -0400
Received: from m12-15.163.com ([220.181.12.15]:37222 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245604AbhI3Paf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=11Z+EQIuOgiThyZL/z
        m7yTs1InxlpsewWg/rDKPl+z4=; b=U3s6Mu4l1mkNi8cedq7VdCsxggNXdTCghQ
        4dJ2iDW8B8hEJjDplXWcD42h25em/GkrMzIBWykxmnomAWozDrAdWway+u3Y4qju
        jRN56ALM+eiuqsT1975ZgS3ll7oIz3oPqqqcNMAdQHhUCkI7rP49FQC9bz7kp/y8
        GZofnFMWI=
Received: from localhost.localdomain (unknown [171.221.149.2])
        by smtp11 (Coremail) with SMTP id D8CowAD3+22wzFVh1aIpBA--.36381S2;
        Thu, 30 Sep 2021 22:42:03 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     will@kernel.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn,
        Chen Lin <chen45464546@163.com>
Subject: Re:Re: [PATCH] arm64: traps: add dump instr before BUG in kernel
Date:   Thu, 30 Sep 2021 22:41:30 +0800
Message-Id: <1633012890-3118-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20210930084247.GC23389@willie-the-truck>
References: <20210930084247.GC23389@willie-the-truck>
X-CM-TRANSID: D8CowAD3+22wzFVh1aIpBA--.36381S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw48Zr4xtry3ur4xCr45Wrg_yoW5Jry8pF
        43C3W5tF4DWayDu34UJw48CFyaka1fJr47GFnrJa4Sy3s0qF92qFn7tryaka4qvrW0kw42
        vryjqF1q9asrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uov38UUUUU=
X-Originating-IP: [171.221.149.2]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiQgMenlaEAqVahwAAsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 2021-09-30 15:42:47, "Will Deacon" <will@kernel.org> wrote:

>On Wed, Sep 29, 2021 at 09:29:46PM +0800, Chen Lin wrote:
>> From: Chen Lin <chen.lin5@zte.com.cn>
>> 
>> we should dump the real instructions before BUG in kernel mode, and
>> compare this to the instructions from objdump.
>> 
>> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
>> ---
>>  arch/arm64/kernel/traps.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index b03e383..621a9dd 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -495,7 +495,12 @@ void do_undefinstr(struct pt_regs *regs)
>>  	if (call_undef_hook(regs) == 0)
>>  		return;
>>  
>> -	BUG_ON(!user_mode(regs));
>> +	if (!user_mode(regs)) {
>> +		pr_emerg("Undef instruction in kernel, dump instr:");
>> +		dump_kernel_instr(KERN_EMERG, regs);
>> +		BUG();
>> +	}
>
>Hmm, I'm not completely convinced about this as the instruction in the
>i-cache could be completely different. I think the PC value (for addr2line)
>is a lot more useful, and we should be printing that already.
>
>Maybe you can elaborate on a situation where this information was helpful?
>
>Thanks,
>
>Will

Undef instruction occurs in some cases

1. CPU do not have the permission to execute the instruction or the current CPU
 version does not support the instruction. For example, execute 
 'mrs x0, tcr_el3' under el1.

2. The instruction is a normal instruction, but it is changed during board 
running in some abnormal situation. eg: DDR bit flip, the normal instruction 
will become an undefined one. By printing the instruction, we can see the 
accurate instruction code and compare it with the instruction code from objdump
to determine that it is a DDR issue.

3. It is rare that the instructions seen through the CPU are inconsistent with 
the instructions in the actual DDR.You can also compare the printed instructions
with the instructions in memory(may through kdump) to determine that it is the
CPU cache or some other issue.

However, now the instruction code causing the sync 'undef instr exception' cannot be
seen. The second and third type problem above cannot be determined.

Before the commit 8a60419d36762a1 "arm64: force_signal_inject: WARN if called 
from kernel context", the instructions can be printed when the CPU encounters an
undef instruction in kernel mode. 

