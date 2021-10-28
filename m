Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5009C43D83F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJ1Ayb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:54:31 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52377 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhJ1Ay3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:54:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UtwmmjM_1635382319;
Received: from 192.168.2.97(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UtwmmjM_1635382319)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Oct 2021 08:52:00 +0800
Message-ID: <ed97c3be-da36-05a0-1409-56d8955e6eb7@linux.alibaba.com>
Date:   Thu, 28 Oct 2021 08:51:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V4 01/50] x86/entry: Add fence for kernel entry swapgs in
 paranoid_entry()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
 <20211026141420.17138-2-jiangshanlai@gmail.com> <YXlDu38aFAeBut5k@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YXlDu38aFAeBut5k@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/27 20:19, Borislav Petkov wrote:
> On Tue, Oct 26, 2021 at 10:13:31PM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
>> v1 swapgs mitigations") adds FENCE_SWAPGS_{KERNEL|USER}_ENTRY
>> for conditional swapgs.  And in paranoid_entry(), it uses only
>> FENCE_SWAPGS_KERNEL_ENTRY for both branches.  It is because the fence
>> is required for both cases since the CR3 write is conditinal even PTI
>> is enabled.
>>
>> But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
>> paranoid entry") switches the code order and changes the branches.
>> And it misses the needed FENCE_SWAPGS_KERNEL_ENTRY for user gsbase case.
>>
>> Add it back.
>>
>> Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: Chang S. Bae <chang.seok.bae@intel.com>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/entry/entry_64.S | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index e38a4cf795d9..1f98188e83ef 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -898,6 +898,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>>   	rdmsr
>>   	testl	%edx, %edx
>>   	jns	.Lparanoid_entry_swapgs
>> +	FENCE_SWAPGS_KERNEL_ENTRY
> 
> Wouldn't it be cleaner to simply move the FENCE up from under the swapgs
> to before the jns instruction?

Sure, I will move it just before the testl instruction.

> 
> This way you kill speculation for both cases and have a single fence.
> 
