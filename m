Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01A40C6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhION62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:58:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237842AbhION6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:58:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F2236D;
        Wed, 15 Sep 2021 06:57:00 -0700 (PDT)
Received: from [10.163.44.48] (unknown [10.163.44.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281F43F719;
        Wed, 15 Sep 2021 06:56:57 -0700 (PDT)
Subject: Re: [PATCH] arm64/traps: Avoid unnecessary kernel/user pointer
 conversion
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20210914152742.27047-1-amit.kachhap@arm.com>
 <20210914160056.GA35239@C02TD0UTHF1T.local>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <6662988b-b891-b6b0-cd7a-bd7f661fc737@arm.com>
Date:   Wed, 15 Sep 2021 19:26:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210914160056.GA35239@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/21 9:30 PM, Mark Rutland wrote:
> On Tue, Sep 14, 2021 at 08:57:42PM +0530, Amit Daniel Kachhap wrote:
>> Annotating a pointer from kernel to __user and then back again might
>> confuse sparse. In call_undef_hook() it can be avoided by not using the
>> intermediate user pointer variable.
> 
> When you say "might confuse sparse", does it complain today? If so, can
> you include an example of what goes wrong?

No it does not give warning. The __force option silences the warning. My
idea is to remove the unwanted __force annotations and not mix user and
kernel pointers.

> 
>> Note: This patch adds no functional changes to code.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   arch/arm64/kernel/traps.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index b03e383d944a..357d10a8bbf5 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -404,7 +404,8 @@ static int call_undef_hook(struct pt_regs *regs)
>>   
>>   	if (!user_mode(regs)) {
>>   		__le32 instr_le;
>> -		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
>> +		if (get_kernel_nofault(instr_le,
>> +				       (__le32 *)instruction_pointer(regs)))
> 
> Can we make `pc` an unsigned long, instead?

I think it can be done.

> 
> It'd be nice to handle all three cases consistently, even if that means
> adding __force to the two user cases.

Agree with your suggestion. Even in the 2 user cases, __force may not be
needed as the typecast will be from from unsigned long to user pointer.

BR,
Amit
> 
> Thanks,
> Mark.
> 
>>   			goto exit;
>>   		instr = le32_to_cpu(instr_le);
>>   	} else if (compat_thumb_mode(regs)) {
>> -- 
>> 2.17.1
>>
