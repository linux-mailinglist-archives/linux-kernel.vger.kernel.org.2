Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B588A366693
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhDUH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:57:30 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58979 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235387AbhDUH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:57:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UWHHbmP_1618991814;
Received: from 30.0.161.206(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWHHbmP_1618991814)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Apr 2021 15:56:55 +0800
Subject: Re: [PATCH] soc: fsl: qe: remove unused function
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1618475663-100748-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <87blaeg1ig.fsf@linkitivity.dja.id.au>
 <76468b5b-0eb0-8772-b7b5-21bb708aa053@csgroup.eu>
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Message-ID: <fafbfcb2-e9d7-4992-a104-1523039807f9@linux.alibaba.com>
Date:   Wed, 21 Apr 2021 15:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <76468b5b-0eb0-8772-b7b5-21bb708aa053@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/16 15:06, Christophe Leroy wrote:
> 
> 
> Le 16/04/2021 à 08:57, Daniel Axtens a écrit :
>> Hi Jiapeng,
>>
>>> Fix the following clang warning:
> 
> You are not fixing a warning, you are removing a function in order to 
> fix a warning ...
> 
>>>
>>> drivers/soc/fsl/qe/qe_ic.c:234:29: warning: unused function
>>> 'qe_ic_from_irq' [-Wunused-function].
> 
> Would be wise to tell that the last users of the function where removed 
> by commit d7c2878cfcfa ("soc: fsl: qe: remove unused qe_ic_set_* 
> functions")
> 
> https://github.com/torvalds/linux/commit/d7c2878cfcfa
> 
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>> ---
>>>   drivers/soc/fsl/qe/qe_ic.c | 5 -----
>>>   1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
>>> index 0390af9..b573712 100644
>>> --- a/drivers/soc/fsl/qe/qe_ic.c
>>> +++ b/drivers/soc/fsl/qe/qe_ic.c
>>> @@ -231,11 +231,6 @@ static inline void qe_ic_write(__be32  __iomem 
>>> *base, unsigned int reg,
>>>       qe_iowrite32be(value, base + (reg >> 2));
>>>   }
>>> -static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
>>> -{
>>> -    return irq_get_chip_data(virq);
>>> -}
>>
>> This seems good to me.
>>
>>   * We know that this function can't be called directly from outside the
>>    file, because it is static.
>>
>>   * The function address isn't used as a function pointer anywhere, so
>>     that means it can't be called from outside the file that way (also
>>     it's inline, which would make using a function pointer unwise!)
>>
>>   * There's no obvious macros in that file that might construct the name
>>     of the function in a way that is hidden from grep.
>>
>> All in all, I am fairly confident that the function is indeed not used.
>>
>> Reviewed-by: Daniel Axtens <dja@axtens.net>
>>
>> Kind regards,
>> Daniel
>>
>>> -
>>>   static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
>>>   {
>>>       return irq_data_get_irq_chip_data(d);
>>> -- 
>>> 1.8.3.1
Hi,
I will follow the advice and send V2 later.
