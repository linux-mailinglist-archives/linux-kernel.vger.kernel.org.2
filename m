Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB73357D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhDHHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:20:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15966 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhDHHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:20:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGCKK3QS6zyNNs;
        Thu,  8 Apr 2021 15:18:13 +0800 (CST)
Received: from [10.67.108.130] (10.67.108.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 15:20:16 +0800
Subject: Re: [PATCH-next] powerpc/interrupt: Remove duplicate header file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>, <heying24@huawei.com>
References: <20210408035644.2417002-1-johnny.chenyi@huawei.com>
 <c42ebf38-c7ea-68bc-01ca-8352581bc33d@csgroup.eu>
From:   "Chenyi (Johnny)" <johnny.chenyi@huawei.com>
Message-ID: <96c6a5b6-ec8f-c9cc-159b-38ca21eea98a@huawei.com>
Date:   Thu, 8 Apr 2021 15:20:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c42ebf38-c7ea-68bc-01ca-8352581bc33d@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/4/8 12:57, Christophe Leroy 写道:
> 
> 
> Le 08/04/2021 à 05:56, johnny.chenyi@huawei.com a écrit :
>> From: Chen Yi <johnny.chenyi@huawei.com>
>>
>> Delete one of the header files <asm/interrupt.h> that are included
>> twice.
> 
> Guys, we have been flooded with such tiny patches over the last weeks, 
> some changes being sent several times by different people.
> 
> That one is included in 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210323062916.295346-1-wanjiabing@vivo.com/ 
> 
> 
> And was already submitted a few hours earlier by someone else: 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1616464656-59372-1-git-send-email-zhouchuangao@vivo.com/ 
> 
> 
> Could you work all together and cook an overall patch including all 
> duplicate removal from arch/powerpc/ files ?
> 
> Best way would be I think to file an issue at 
> https://github.com/linuxppc/issues/issues , then you do a complete 
> analysis and list in the issue all places to be modified, then once the 
> analysis is complete you send a full single patch.
> 
> Thanks
> Christophe
>
Dear Christophe,
	Thanks for your reply, I have checked that thers is no header files 
which has been included twice by mistake in arch/powerpc/.I would file 
an issue next time.

Best regards,
Chen Yi


>>
>> Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
>> ---
>>   arch/powerpc/kernel/interrupt.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/interrupt.c 
>> b/arch/powerpc/kernel/interrupt.c
>> index c4dd4b8f9cfa..f64ace0208b7 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -7,7 +7,6 @@
>>   #include <asm/asm-prototypes.h>
>>   #include <asm/kup.h>
>>   #include <asm/cputime.h>
>> -#include <asm/interrupt.h>
>>   #include <asm/hw_irq.h>
>>   #include <asm/interrupt.h>
>>   #include <asm/kprobes.h>
>>
> .
