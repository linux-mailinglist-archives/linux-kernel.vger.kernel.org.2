Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D942C103
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJMNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:12:08 -0400
Received: from m12-16.163.com ([220.181.12.16]:36389 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhJMNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sUtf0XVHSTX2ol/mZr
        WRCxgBkBPfPmN/2f2tz+1TqbI=; b=poQndgCxhffIodp3KZIUC6RR3Vl3WsaUSz
        6o5/FFb60Pnb451TEO6aeKE/sxe0aNRYtFsVh9dxnaGdym/TW9lIzY3pAWUlwLPP
        1OCJf8DQ2eUZCsICnMxt+A0L1pQ7Oh0dvacNI0jhP4C3z4AsPfJYbb58T+yXrTz2
        OATwSdsQI=
Received: from localhost.localdomain (unknown [171.221.151.0])
        by smtp12 (Coremail) with SMTP id EMCowABHXi1y2mZheO5fEA--.28928S2;
        Wed, 13 Oct 2021 21:09:19 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     will@kernel.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn,
        Chen Lin <chen45464546@163.com>
Subject: Re:Re: [PATCH] arm64: traps: add dump instr before BUG in kernel
Date:   Wed, 13 Oct 2021 21:08:43 +0800
Message-Id: <1634130523-2634-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20211011100649.GB3681@willie-the-truck>
References: <20211011100649.GB3681@willie-the-truck>
X-CM-TRANSID: EMCowABHXi1y2mZheO5fEA--.28928S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF48KFyfWF4xJF1xXrW5ZFb_yoW5uw47pF
        W7u3WYyFWDWw4UCw1Utw4rK3W3tws8Jr47WFn8ta4Sywn0qF1IqF4vqr13CayqvrWxuw42
        vFyjqF1293W7ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOjjkUUUUU=
X-Originating-IP: [171.221.151.0]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbBqhsrnl75b4w9DAAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 2021-10-11 17:06:50, "Will Deacon" <will@kernel.org> wrote:
>On Thu, Sep 30, 2021 at 10:41:30PM +0800, Chen Lin wrote:
>> At 2021-09-30 15:42:47, "Will Deacon" <will@kernel.org> wrote:
>> 
>> >On Wed, Sep 29, 2021 at 09:29:46PM +0800, Chen Lin wrote:
>> >> From: Chen Lin <chen.lin5@zte.com.cn>
>> >> 
>> >> we should dump the real instructions before BUG in kernel mode, and
>> >> compare this to the instructions from objdump.
>> >> 
>> >> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
>> >> ---
>> >>  arch/arm64/kernel/traps.c |    7 ++++++-
>> >>  1 file changed, 6 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> >> index b03e383..621a9dd 100644
>> >> --- a/arch/arm64/kernel/traps.c
>> >> +++ b/arch/arm64/kernel/traps.c
>> >> @@ -495,7 +495,12 @@ void do_undefinstr(struct pt_regs *regs)
>> >>  	if (call_undef_hook(regs) == 0)
>> >>  		return;
>> >>  
>> >> -	BUG_ON(!user_mode(regs));
>> >> +	if (!user_mode(regs)) {
>> >> +		pr_emerg("Undef instruction in kernel, dump instr:");
>> >> +		dump_kernel_instr(KERN_EMERG, regs);
>> >> +		BUG();
>> >> +	}
>> >
>> >Hmm, I'm not completely convinced about this as the instruction in the
>> >i-cache could be completely different. I think the PC value (for addr2line)
>> >is a lot more useful, and we should be printing that already.
>> >
>> >Maybe you can elaborate on a situation where this information was helpful?
>> >
>> >Thanks,
>> >
>> >Will
>> 
>> Undef instruction occurs in some cases
>> 
>> 1. CPU do not have the permission to execute the instruction or the current CPU
>>  version does not support the instruction. For example, execute 
>>  'mrs x0, tcr_el3' under el1.
>
>This really shouldn't happen, but if it did, the PC would surely be enough
>to debug the problem?
>

yes, PC is enough in this situation.

>> 2. The instruction is a normal instruction, but it is changed during board 
>> running in some abnormal situation. eg: DDR bit flip, the normal instruction 
>> will become an undefined one. By printing the instruction, we can see the 
>> accurate instruction code and compare it with the instruction code from objdump
>> to determine that it is a DDR issue.
>
>Is this really something we should be designing our exception handlers for?
>If we're getting DDR bit flips for kernel .text, then it sounds like we need
>ECC and/or RAS features to deal with them.
>
>So I'm not really sold on this change.

1. About the DDR bit flip, YES, the instruction code information is really useless 
in the ideal state. The ideal state includes the following conditions like: the DDR 
controller do supports ECC, and also is configured correctly, such as ECC enabled 
and ECC fixing enabled. There may exist various old boards or abnormal DDR 
configurations in embedded systems.


2. DDR flip is just one example. Other examples include text segment being overwritten 
by DMA and other accidental writes, we want more info about what it writes. 
Another example, some instructions may change at runtime by ALTERNATIVE(oldinstr, newinstr, feature) 
or live patch, we want both the pc and the instruction code to double check what 
happened if illegal instruction exception happen at such points.


Personally, I think adding more information can make it easier to locate the above problems. 
Anyway, Thank you for your patience in reading and replying.
>
>Will

