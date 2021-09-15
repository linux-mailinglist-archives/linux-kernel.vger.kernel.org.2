Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E37940BD77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhIOB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:58:34 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53393 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhIOB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:58:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoQf.bx_1631671032;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UoQf.bx_1631671032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 09:57:13 +0800
Subject: Re: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Abbott <labbott@kernel.org>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
 <20210914101709.GA29127@C02TD0UTHF1T.local>
From:   ashimida <ashimida@linux.alibaba.com>
Message-ID: <f02816a4-5b8e-d1c6-88a2-1db282a7479e@linux.alibaba.com>
Date:   Wed, 15 Sep 2021 09:57:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210914101709.GA29127@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi King, Rutland:

Thanks for the reply and let me understand the reason here.

Then may I first submit a patch to modify the attributes of
__stack_chk_guard of the arm/aarch64 platform?

On 9/14/21 6:17 PM, Mark Rutland wrote:
> On Tue, Sep 14, 2021 at 05:44:02PM +0800, Dan Li wrote:
>> __stack_chk_guard is setup once while init stage and never changed
>> after that.
>>
>> Although the modification of this variable at runtime will usually
>> cause the kernel to crash (so dose the attacker), it should be marked
>> as _ro_after_init, and it should not affect performance if it is
>> placed in the ro_after_init section.
>>
>> This should also be the case on the ARM platform, or am I missing
>> something?
>>
>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> 
> FWIW, this makes sense to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Looking at the history, this was added to arm64 in commit:
> 
>    c0c264ae5112d1cd ("arm64: Add CONFIG_CC_STACKPROTECTOR")
> 
> ... whereas __ro_after_init was introduced around 2 years later in
> commit:
> 
>    c74ba8b3480da6dd ("arch: Introduce post-init read-only memory")
> 
> ... so we weren't deliberately avoiding __ro_after_init, and there are
> probably a significant number of other variables we could apply it to.
> 
> Mark.
> 
>> ---
>>   arch/arm64/kernel/process.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index c8989b9..c858b85 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -60,7 +60,7 @@
>>   
>>   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>>   #include <linux/stackprotector.h>
>> -unsigned long __stack_chk_guard __read_mostly;
>> +unsigned long __stack_chk_guard __ro_after_init;
>>   EXPORT_SYMBOL(__stack_chk_guard);
>>   #endif
>>   
>> -- 
>> 2.7.4
>>
