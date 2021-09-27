Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8813F418D63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhI0BMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 21:12:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50997 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231907AbhI0BMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:12:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UpfZeZ3_1632705049;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UpfZeZ3_1632705049)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Sep 2021 09:10:50 +0800
Subject: Re: [PATCH V2 01/41] x86/entry: Fix swapgs fence
To:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-2-jiangshanlai@gmail.com> <87r1dbawzq.ffs@tglx>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <9312a767-f1d3-d283-80a9-e6b3854252e1@linux.alibaba.com>
Date:   Mon, 27 Sep 2021 09:10:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r1dbawzq.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/27 04:43, Thomas Gleixner wrote:
> Lai,
> 
> On Sun, Sep 26 2021 at 23:07, Lai Jiangshan wrote:
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -898,17 +898,12 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>>   	rdmsr
>>   	testl	%edx, %edx
>>   	jns	.Lparanoid_entry_swapgs
>> +	FENCE_SWAPGS_KERNEL_ENTRY
> 
> Good catch.
> 
>>   	ret
>>   
>>   .Lparanoid_entry_swapgs:
>>   	swapgs
>> -
>> -	/*
>> -	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
>> -	 * unconditional CR3 write, even in the PTI case.  So do an lfence
>> -	 * to prevent GS speculation, regardless of whether PTI is enabled.
>> -	 */
>> -	FENCE_SWAPGS_KERNEL_ENTRY
>> +	FENCE_SWAPGS_USER_ENTRY
> 
> This change is wrong.
> 
> In the paranoid entry path even if user GS base is set then the entry
> does not necessarily come from user space so there is no guarantee that
> there was a CR3 write on PTI enabled systems before the SWAPGS.
> 
> FENCE_SWAPGS_USER_ENTRY does not emit a LFENCE when PTI is enabled, so
> both the comment and FENCE_SWAPGS_KERNEL_ENTRY which emits LFENCE on
> affected CPUs unconditionaly are correct. Though the comment could do
> with some polishing to make this entirely clear.


I didn't notice FENCE_SWAPGS_USER_ENTRY depends on PTI.

I will add FENCE_SWAPGS_KERNEL_ENTRY only on the kernel path.

Thanks
Lai
