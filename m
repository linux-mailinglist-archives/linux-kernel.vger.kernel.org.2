Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C113BDDEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhGFTSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:18:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhGFTSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4132F1042;
        Tue,  6 Jul 2021 12:15:54 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FABB3F5A1;
        Tue,  6 Jul 2021 12:15:52 -0700 (PDT)
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org> <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk> <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
 <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
 <20210706175052.GD15218@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
Date:   Tue, 6 Jul 2021 20:15:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706175052.GD15218@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-06 18:50, Catalin Marinas wrote:
> On Mon, Jun 28, 2021 at 05:22:30PM +0100, Robin Murphy wrote:
>> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
>> index 043da90f5dd7..cfb598ae4812 100644
>> --- a/arch/arm64/lib/copy_to_user.S
>> +++ b/arch/arm64/lib/copy_to_user.S
>> @@ -32,7 +32,7 @@
>>   	.endm
>>   	.macro strh1 reg, ptr, val
>> -	user_ldst 9998f, sttrh, \reg, \ptr, \val
>> +	user_ldst 9997f, sttrh, \reg, \ptr, \val
>>   	.endm
>>   	.macro ldr1 reg, ptr, val
>> @@ -40,7 +40,7 @@
>>   	.endm
>>   	.macro str1 reg, ptr, val
>> -	user_ldst 9998f, sttr, \reg, \ptr, \val
>> +	user_ldst 9997f, sttr, \reg, \ptr, \val
>>   	.endm
>>   	.macro ldp1 reg1, reg2, ptr, val
>> @@ -48,12 +48,14 @@
>>   	.endm
>>   	.macro stp1 reg1, reg2, ptr, val
>> -	user_stp 9998f, \reg1, \reg2, \ptr, \val
>> +	user_stp 9997f, \reg1, \reg2, \ptr, \val
>>   	.endm
>>   end	.req	x5
>> +srcin	.req	x15
>>   SYM_FUNC_START(__arch_copy_to_user)
>>   	add	end, x0, x2
>> +	mov	srcin, x1
>>   #include "copy_template.S"
>>   	mov	x0, #0
>>   	ret
>> @@ -62,6 +64,12 @@ EXPORT_SYMBOL(__arch_copy_to_user)
>>   	.section .fixup,"ax"
>>   	.align	2
>> +9997:	cmp	dst, dstin
>> +	b.ne	9998f
>> +	// Before being absolutely sure we couldn't copy anything, try harder
>> +	ldrb	tmp1w, [srcin]
>> +USER(9998f, sttrb tmp1w, [dstin])
>> +	add	dst, dstin, #1
>>   9998:	sub	x0, end, dst			// bytes not copied
>>   	ret
>>   	.previous
> 
> I think it's worth doing the copy_to_user() fallback in a loop until it
> faults or hits the end of the buffer. This would solve the problem we
> currently have with writing more bytes than actually reported. The
> copy_from_user() is not necessary, a byte would suffice.

The thing is, we don't really have that problem since the set_fs cleanup 
removed IMP-DEF STP behaviour from the picture - even with the current 
mess we could perfectly well know which of the two STTRs faulted if we 
just put a little more effort in. Even, at worst, simply this:

diff --git a/arch/arm64/include/asm/asm-uaccess.h 
b/arch/arm64/include/asm/asm-uaccess.h
index ccedf548dac9..7513758bab3a 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -74,8 +74,9 @@ alternative_else_nop_endif

         .macro user_stp l, reg1, reg2, addr, post_inc
  8888:          sttr    \reg1, [\addr];
-8889:          sttr    \reg2, [\addr, #8];
-               add     \addr, \addr, \post_inc;
+               add     \addr, \addr, \post_inc / 2;
+8889:          sttr    \reg2, [\addr];
+               add     \addr, \addr, \post_inc / 2;

                 _asm_extable    8888b,\l;
                 _asm_extable    8889b,\l;

But yuck... If you think the potential under-reporting is worth fixing 
right now, rather than just letting it disappear in a future rewrite, 
then I'd still rather do it by passing the actual fault address to the 
current copy_to_user fixup. A retry loop could still technically 
under-report if the page disappears (or tag changes) between faulting on 
the second word of a pair and retrying from the first, so we'd want to 
pin the initial fault down to a single access anyway. All the loop would 
achieve after that is potentially fill in an extra 1-7 bytes right up to 
the offending page/tag boundary for the sake of being nice, which I 
remain unconvinced is worth the bother :)

Cheers,
Robin.
