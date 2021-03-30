Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9634EA73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhC3Obr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:31:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15047 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhC3Obh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:31:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8sJS5cl0zPmpK;
        Tue, 30 Mar 2021 22:28:56 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.252) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:31:25 +0800
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
 <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
 <20210330134323.GA3700@duo.ucw.cz>
CC:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
From:   "fanghao (A)" <fanghao11@huawei.com>
Message-ID: <dabcbb05-2d5a-f32e-a725-3dbc51c2f0d5@huawei.com>
Date:   Tue, 30 Mar 2021 22:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210330134323.GA3700@duo.ucw.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/30 21:43, Pavel Machek wrote:
> Hi!
>
>> On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
>>>
>>> s/Hisilicon/HiSilicon/g.
>>> It should use capital S, according to
>>> https://www.hisilicon.com/en/terms-of-use.
>>>
>>> Signed-off-by: Hao Fang <fanghao11@huawei.com>
>
>>>  /*
>>>   * Copyright (c) 2013 Linaro Ltd.
>>> - * Copyright (c) 2013 Hisilicon Limited.
>>> + * Copyright (c) 2013 HiSilicon Limited.
>>
>> This change looks really silly to me, but I am not a lawyer - so I
>> can't tell if this makes sense or not.
>>
>> In any case, "Hisilicon" is being used all over the kernel - do you
>> intend to patch all places with similar changes like this one? Perhaps
>> just send a big tree-wide-patch instead and see what people think?
>
> Plus, I'd expect authors to submit changes to copyright notices.
>

Just add Reviewed-by or Acked-by! Thanks.

> Best regards,
> 								Pavel
>

