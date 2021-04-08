Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388B357F28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhDHJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:30:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15969 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:30:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGGCT3Dv4zyNgX;
        Thu,  8 Apr 2021 17:28:21 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 17:30:25 +0800
Subject: Re: [PATCH 1/2] powerpc: remove set but not used variable
 'force_printk_to_btext'
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210408011801.557004-1-yukuai3@huawei.com>
 <20210408011801.557004-2-yukuai3@huawei.com>
 <b7636590-42ef-e588-59e1-b0591243d619@csgroup.eu>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9e3e5a40-ff90-9872-30a5-3a65232d5f0e@huawei.com>
Date:   Thu, 8 Apr 2021 17:30:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b7636590-42ef-e588-59e1-b0591243d619@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 13:01, Christophe Leroy wrote:
> 
> 
> Le 08/04/2021 à 03:18, Yu Kuai a écrit :
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> arch/powerpc/kernel/btext.c:49:12: error: 'force_printk_to_btext'
>> defined but not used.
> 
> You don't get this error as it is now.
> You will get this error only if you make it 'static', which is what you 
> did in your first patch based on the 'sparse' report.
> 
> When removing a non static variable, you should explain that you can 
> remove it after you have verifier that it is nowhere used, neither in 
> that file nor in any other one.

Hi,

I do use 'git grep force_printk_to_btext' to confirm that
'force_printk_to_btext' is not used anywhere. Maybe it's better to
metion it in commit message?

Thanks
Yu Kuai
> 
>>
>> It is never used, and so can be removed.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   arch/powerpc/kernel/btext.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
>> index 803c2a45b22a..359d0f4ca532 100644
>> --- a/arch/powerpc/kernel/btext.c
>> +++ b/arch/powerpc/kernel/btext.c
>> @@ -46,7 +46,6 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
>>   static unsigned char vga_font[cmapsz];
>>   int boot_text_mapped __force_data = 0;
>> -int force_printk_to_btext = 0;
>>   extern void rmci_on(void);
>>   extern void rmci_off(void);
>>
> .
> 
