Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29139D777
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:34:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3080 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFGIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:34:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fz62Q6jcgzWstj;
        Mon,  7 Jun 2021 16:28:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 16:33:04 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 7 Jun 2021
 16:33:03 +0800
Subject: Re: [PATCH 1/1] lib: devres: Add error information printing for
 __devm_ioremap_resource()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20210428063203.691-1-thunder.leizhen@huawei.com>
 <CAMuHMdWX7rC2zswHoo6aFf3CYp3NKAfJ7E0x4W2wbVkybGa84g@mail.gmail.com>
 <d8d98365-98f6-d0a4-233e-279172004f51@huawei.com>
 <CAMuHMdWeJkDvhf-J-S4dLqKmSvqnkf+AcWdjyPNu-G8zu2jOkA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2c0a1977-2f87-7fd5-13db-e9524f0fed80@huawei.com>
Date:   Mon, 7 Jun 2021 16:33:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWeJkDvhf-J-S4dLqKmSvqnkf+AcWdjyPNu-G8zu2jOkA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/7 16:15, Geert Uytterhoeven wrote:
> Hi Leizhen,
> 
> On Mon, Jun 7, 2021 at 9:11 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>> On 2021/5/17 15:04, Geert Uytterhoeven wrote:
>>> On Wed, Apr 28, 2021 at 8:33 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>> Ensure that all error handling branches print error information. In this
>>>> way, when this function fails, the upper-layer functions can directly
>>>> return an error code without missing debugging information. Otherwise,
>>>> the error message will be printed redundantly or missing.
>>>>
>>>> Fixes: 35bd8c07db2c ("devres: keep both device name and resource name in pretty name")
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> Thanks for your patch, which is now commit 5c3e241f5246445d ("lib:
>>> devres: Add error information printing for __devm_ioremap_resource()")
>>> in driver-core-next.
>>>
>>>> --- a/lib/devres.c
>>>> +++ b/lib/devres.c
>>>> @@ -157,8 +157,10 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
>>>>                                              dev_name(dev), res->name);
>>>>         else
>>>>                 pretty_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
>>>> -       if (!pretty_name)
>>>> +       if (!pretty_name) {
>>>> +               dev_err(dev, "can't generate pretty name for resource %pR\n", res);
>>>
>>> If the above fails, it is due to a memory allocation failure, and the
>>> memory allocation core will have already printed an error message.
>>> So there is no need to print a second message.
>>> Hence IMHO this commit should be reverted.
>>
>> If the memory allocation fails, only the 'size' is printed, but the start address of
>> the 'res' is not printed. So the printing here is not repeated. The start address is
>> the more critical help information.
> 
> Does that actually matter?
> What can the user or developer do to fix this problem, with the
> additional knowledge of the resource's start address?

Oh, you're right.

> 
>>>>                 return IOMEM_ERR_PTR(-ENOMEM);
>>>> +       }
>>>>
>>>>         if (!devm_request_mem_region(dev, res->start, size, pretty_name)) {
>>>>                 dev_err(dev, "can't request region for resource %pR\n", res);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

