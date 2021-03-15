Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9433B009
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhCOKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:32:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2696 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCOKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:32:34 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DzXgP2WSSz68058;
        Mon, 15 Mar 2021 18:28:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 15 Mar 2021 11:32:32 +0100
Received: from [10.210.166.140] (10.210.166.140) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 15 Mar 2021 10:32:31 +0000
Subject: Re: [PATCH] lib/logic_pio: Fix overlap check for pio registery
To:     Jiahui Cen <cenjiahui@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <xieyingtai@huawei.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20201218062335.5320-1-cenjiahui@huawei.com>
 <2cde14cd-91da-aae4-70aa-656d629259e6@huawei.com>
 <006ad6ce-d6b2-59cb-8209-aca3f6e53fec@huawei.com>
 <5df9663b-7c6a-6652-2561-9d3889ff94bc@huawei.com>
 <e3fdeba7-9058-8618-9ca8-486f58d4f383@huawei.com>
 <643b5c84-3e94-4029-721b-34b79c1b3589@huawei.com>
 <eaedbff6-fd4f-e01e-b14c-482e8dd6d382@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4022fa47-fcff-84dc-ae15-63975fbb2a8e@huawei.com>
Date:   Mon, 15 Mar 2021 10:30:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eaedbff6-fd4f-e01e-b14c-482e8dd6d382@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.166.140]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 01:27, Jiahui Cen wrote:

+

Hi Arnd, xu wei,

Any chance we could pick up this patch via arm-soc tree?

The series which I originally included in, below, is stalled a bit.

Thanks,
John

https://lore.kernel.org/lkml/1610729929-188490-1-git-send-email-john.garry@huawei.com/

> Hi John,
> 
> On 2021/1/15 18:10, John Garry wrote:
>> On 21/12/2020 13:04, Jiahui Cen wrote:
>>>> On 21/12/2020 03:24, Jiahui Cen wrote:
>>>>> Hi John,
>>>>>
>>>>> On 2020/12/18 18:40, John Garry wrote:
>>>>>> On 18/12/2020 06:23, Jiahui Cen wrote:
>>>>>>> Since the [start, end) is a half-open interval, a range with the end equal
>>>>>>> to the start of another range should not be considered as overlapped.
>>>>>>>
>>>>>>> Signed-off-by: Jiahui Cen<cenjiahui@huawei.com>
>>>>>>> ---
>>>>>>>      lib/logic_pio.c | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
>>>>>>> index f32fe481b492..445d611f1dc1 100644
>>>>>>> --- a/lib/logic_pio.c
>>>>>>> +++ b/lib/logic_pio.c
>>>>>>> @@ -57,7 +57,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>>>>>>>                  new_range->flags == LOGIC_PIO_CPU_MMIO) {
>>>>>>>                  /* for MMIO ranges we need to check for overlap */
>>>>>>>                  if (start >= range->hw_start + range->size ||
>>>>>>> -                end < range->hw_start) {
>>>>>>> +                end <= range->hw_start) {
>>>>>> It looks like your change is correct, but should not really have an impact in practice since:
>>>>>> a: BIOSes generally list ascending IO port CPU addresses
>>>>>> b. there is space between IO port CPU address regions
>>>>>>
>>>>>> Have you seen a problem here?
>>>>>>
>>>>> No serious problem. I found it just when I was working on adding support of
>>>>> pci expander bridge for Arm in QEMU. I found the IO window of some extended
>>>>> root bus could not be registered when I inserted the extended buses' _CRS
>>>>> info into DSDT table in the x86 way, which does not sort the buses.
>>>>>
>>>>> Though root buses should be sorted in QEMU, would it be better to accept
>>>>> those non-ascending IO windows?
>>>>>
>>>> ok, so it seems that you have seen a real problem, and this issue is not just detected by code analysis.
>>>>
>>>>> BTW, for b, it seems to be no space between IO windows of different root buses
>>>>> generated by EDK2. Or maybe I missed something obvious.
>>>> I don't know about that. Anyway, your change looks ok.
>>>>
>>>> Reviewed-by: John Garry<john.garry@huawei.com>
>>>>
>>>> BTW, for your virt env, will there be requirement to unregister PCI MMIO ranges? Currently we don't see that in non-virt world.
>>>>
>>> Thanks for your review.
>>>
>>> And currently there is no such a requirement in my virt env.
>>>
>>
>> I am not sure what happened to this patch, but I plan on sending some patches in this area soon - do you want me to include this one?
>>
> 
> Sorry for replying late. It's appreciated if you can include this patch.
> 
> Thanks!
> Jiahui
> 
>> Thanks,
>> John
>>
>> .
> .
> 

