Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F293B705C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhF2KE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:04:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhF2KEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:04:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF651042;
        Tue, 29 Jun 2021 03:01:39 -0700 (PDT)
Received: from [10.57.46.146] (unknown [10.57.46.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36AC3F694;
        Tue, 29 Jun 2021 03:01:36 -0700 (PDT)
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
 <20210629083052.GA10900@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ddfb6ec3-6bd4-10c7-b449-ca49e65af3cd@arm.com>
Date:   Tue, 29 Jun 2021 11:01:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629083052.GA10900@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-29 09:30, Catalin Marinas wrote:
> On Mon, Jun 28, 2021 at 05:22:30PM +0100, Robin Murphy wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Subject: [PATCH] arm64: Avoid premature usercopy failure
>>
>> Al reminds us that the usercopy API must only return complete failure
>> if absolutely nothing could be copied. Currently, if userspace does
>> something silly like giving us an unaligned pointer to Device memory,
>> or a size which overruns MTE tag bounds, we may fail to honour that
>> requirement when faulting on a multi-byte access even though a smaller
>> access could have succeeded.
>>
>> Add a mitigation to the fixup routines to fall back to a single-byte
>> copy if we faulted on a larger access before anything has been written
>> to the destination, to guarantee making *some* forward progress. We
>> needn't be too concerned about the overall performance since this should
>> only occur when callers are doing something a bit dodgy in the first
>> place. Particularly broken userspace might still be able to trick
>> generic_perform_write() into an infinite loop by targeting write() at
>> an mmap() of some read-only device register where the fault-in load
>> succeeds but any store synchronously aborts such that copy_to_user() is
>> genuinely unable to make progress, but, well, don't do that...
>>
>> Reported-by: Chen Huang <chenhuang5@huawei.com>
>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks Robin for putting this together. I'll write some MTE kselftests
> to check for regressions in the future.
> 
>> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
>> index 95cd62d67371..5b720a29a242 100644
>> --- a/arch/arm64/lib/copy_from_user.S
>> +++ b/arch/arm64/lib/copy_from_user.S
>> @@ -29,7 +29,7 @@
>>   	.endm
>>   	.macro ldrh1 reg, ptr, val
>> -	user_ldst 9998f, ldtrh, \reg, \ptr, \val
>> +	user_ldst 9997f, ldtrh, \reg, \ptr, \val
>>   	.endm
>>   	.macro strh1 reg, ptr, val
>> @@ -37,7 +37,7 @@
>>   	.endm
>>   	.macro ldr1 reg, ptr, val
>> -	user_ldst 9998f, ldtr, \reg, \ptr, \val
>> +	user_ldst 9997f, ldtr, \reg, \ptr, \val
>>   	.endm
>>   	.macro str1 reg, ptr, val
>> @@ -45,7 +45,7 @@
>>   	.endm
>>   	.macro ldp1 reg1, reg2, ptr, val
>> -	user_ldp 9998f, \reg1, \reg2, \ptr, \val
>> +	user_ldp 9997f, \reg1, \reg2, \ptr, \val
>>   	.endm
>>   	.macro stp1 reg1, reg2, ptr, val
>> @@ -53,8 +53,10 @@
>>   	.endm
>>   end	.req	x5
>> +srcin	.req	x15
>>   SYM_FUNC_START(__arch_copy_from_user)
>>   	add	end, x0, x2
>> +	mov	srcin, x1
>>   #include "copy_template.S"
>>   	mov	x0, #0				// Nothing to copy
>>   	ret
>> @@ -63,6 +65,12 @@ EXPORT_SYMBOL(__arch_copy_from_user)
>>   	.section .fixup,"ax"
>>   	.align	2
>> +9997:	cmp	dst, dstin
>> +	b.ne	9998f
>> +	// Before being absolutely sure we couldn't copy anything, try harder
>> +USER(9998f, ldtrb tmp1w, [srcin])
>> +	strb	tmp1w, [dstin]
>> +	add	dst, dstin, #1
> 
> Nitpick: can we do just strb tmb1w, [dst], #1? It matches the strb1
> macro in this file.

Oh, of course; I think I befuddled myself there and failed to consider 
that by this point we've already mandated that dstin == dst (so that we 
can use srcin because src may have advanced already), so in fact we 
*can* use dst as the base register to avoid the shuffling, and 
post-index this one. I'll clean that up.

> Either way, it looks fine to me.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

Robin.
