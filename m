Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77DA418DED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 05:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhI0D3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 23:29:41 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:54604 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229572AbhI0D3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 23:29:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UpgMq9c_1632713278;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UpgMq9c_1632713278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Sep 2021 11:27:59 +0800
Subject: Re: [PATCH V2 01/41] x86/entry: Fix swapgs fence
From:   Lai Jiangshan <laijs@linux.alibaba.com>
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
 <9312a767-f1d3-d283-80a9-e6b3854252e1@linux.alibaba.com>
Message-ID: <445de475-c223-be11-325f-fa6679e45cb0@linux.alibaba.com>
Date:   Mon, 27 Sep 2021 11:27:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9312a767-f1d3-d283-80a9-e6b3854252e1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/27 09:10, Lai Jiangshan wrote:

>>
>> This change is wrong.
>>
>> In the paranoid entry path even if user GS base is set then the entry
>> does not necessarily come from user space so there is no guarantee that
>> there was a CR3 write on PTI enabled systems before the SWAPGS.
>>
>> FENCE_SWAPGS_USER_ENTRY does not emit a LFENCE when PTI is enabled, so
>> both the comment and FENCE_SWAPGS_KERNEL_ENTRY which emits LFENCE on
>> affected CPUs unconditionaly are correct. Though the comment could do
>> with some polishing to make this entirely clear.
> 
> 
> I didn't notice FENCE_SWAPGS_USER_ENTRY depends on PTI.

The commit c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
( https://lore.kernel.org/all/20200419144049.1906-2-laijs@linux.alibaba.com/ )
also made it wrong.

When the SWITCH_TO_KERNEL_CR3 in the path is removed, FENCE_SWAPGS_USER_ENTRY
should also be changed to FENCE_SWAPGS_KERNEL_ENTRY. (Or just jmp to
.Lerror_entry_done_lfence which has FENCE_SWAPGS_KERNEL_ENTRY already.)

And FENCE_SWAPGS_USER_ENTRY could be documented with "it should be followed with
serializing operations such as SWITCH_TO_KERNEL_CR3".  Or we can add a
SWAPGS_AND_SWITCH_TO_KERNEL_CR3 to combine them.

I will fix it in v3. (Or should I do it separately before v3?)

Sorry for my fault.
Lai

> 
> I will add FENCE_SWAPGS_KERNEL_ENTRY only on the kernel path.
> 
> Thanks
> Lai
