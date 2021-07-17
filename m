Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1D3CC0AA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 03:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhGQB67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 21:58:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15031 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhGQB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 21:58:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GRWMX1H3SzZm1l;
        Sat, 17 Jul 2021 09:52:40 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 17 Jul 2021 09:55:59 +0800
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
To:     Rob Landley <rob@landley.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <David.Woodhouse@intel.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linfeilong@huawei.com>
References: <20210708131359.21591-1-linmiaohe@huawei.com>
 <20210716010224.44582046@xps13>
 <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
 <20210716114808.246e92ba@xps13>
 <f7f55c5e-f6b2-542c-66d2-20f4d88bf669@landley.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <91b48a5d-3a33-2a8f-8b8d-9ebeb31a8ec6@huawei.com>
Date:   Sat, 17 Jul 2021 09:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f7f55c5e-f6b2-542c-66d2-20f4d88bf669@landley.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/16 21:34, Rob Landley wrote:
> On 7/16/21 4:48 AM, Miquel Raynal wrote:
>> Hi Miaohe,
>>
>> Miaohe Lin <linmiaohe@huawei.com> wrote on Fri, 16 Jul 2021 09:42:19
>> +0800:
>>
>>> On 2021/7/16 7:02, Miquel Raynal wrote:
>>>> Hi Miaohe,
>>>>
>>>> Miaohe Lin <linmiaohe@huawei.com> wrote on Thu, 8 Jul 2021 21:13:59
>>>> +0800:
>>>>   
>>>>> From: Feilong Lin <linfeilong@huawei.com>
>>>>>
>>>>> The size in struct mtd_info_user is 32-bit, which will cause errors
>>>>> when obtaining the size of large-capacity MTD devices, such as TLC
>>>>> NAND FLASH-2048Gb.  
>>>>
>>>> Besides the fact that such devices are far from being supported by the
>>>> Linux kernel, this change would basically break userspace, it cannot
>>>> enter as-is...
>>>>   
>>>
>>> I see. Many thanks for your reply! We're working with these large-capacity
>>> MTD devices now, any suggestion to work around this?
>>
>> The only way is to create a second UAPI.
> 
> Twelve years ago a patch was submitted to add a 64 bit MTD api:
> 
>   https://lwn.net/Articles/326418/
> 
> But for some reason they only merged 64 bit erase:
> 
>   https://github.com/torvalds/linux/commit/0dc54e9f33e2
> 
> But NOT the rest of the 64 bit mtd API in the same patch. I've never understood why.
> 
> Rob
> .
> 

Many thanks for both of you! This really helps! :)
