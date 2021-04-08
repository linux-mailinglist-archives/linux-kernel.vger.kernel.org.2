Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5348D357F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhDHJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:34:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15970 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhDHJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:34:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGGHm43xxzyNkS;
        Thu,  8 Apr 2021 17:32:04 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 17:34:09 +0800
Subject: Re: [PATCH 2/2] powerpc: make 'boot_text_mapped' static
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210408011801.557004-1-yukuai3@huawei.com>
 <20210408011801.557004-3-yukuai3@huawei.com>
 <5b91cd3f-d171-f510-7dae-8cbabb13b23c@csgroup.eu>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5ea1644d-8b75-eafb-9ad5-d729f430d884@huawei.com>
Date:   Thu, 8 Apr 2021 17:34:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5b91cd3f-d171-f510-7dae-8cbabb13b23c@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 13:04, Christophe Leroy wrote:
> 
> 
> Le 08/04/2021 à 03:18, Yu Kuai a écrit :
>> The sparse tool complains as follow:
>>
>> arch/powerpc/kernel/btext.c:48:5: warning:
>>   symbol 'boot_text_mapped' was not declared. Should it be static?
>>
>> This symbol is not used outside of btext.c, so this commit make
>> it static.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   arch/powerpc/kernel/btext.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
>> index 359d0f4ca532..8df9230be6fa 100644
>> --- a/arch/powerpc/kernel/btext.c
>> +++ b/arch/powerpc/kernel/btext.c
>> @@ -45,7 +45,7 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
>>   static unsigned char vga_font[cmapsz];
>> -int boot_text_mapped __force_data = 0;
>> +static int boot_text_mapped __force_data;
> 
> Are you sure the initialisation to 0 can be removed ? Usually 
> initialisation to 0 is not needed because not initialised variables go 
> in the BSS section which is zeroed at startup. But here the variable is 
> flagged with __force_data so it is not going in the BSS section.

Hi,

I removed the initialisation to 0 because checkpatch complained about
it, I do not familiar with '__force_data', thanks for pointing it out.

Thanks,
Yu Kuai
> 
> 
>>   extern void rmci_on(void);
>>   extern void rmci_off(void);
>>
> .
> 
