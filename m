Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AE3F4364
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhHWCUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:20:16 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15201 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhHWCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:20:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GtGBq1dnXz1CZbh;
        Mon, 23 Aug 2021 10:18:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 10:19:24 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 10:19:24 +0800
Subject: Re: [PATCH 0/3] amba: Properly handle device probe without IRQ domain
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <YRw32YE4cnNnWSvl@robh.at.kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b5ccbf00-b686-d35b-c81a-0ec69f4677a0@huawei.com>
Date:   Mon, 23 Aug 2021 10:19:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YRw32YE4cnNnWSvl@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/18 6:27, Rob Herring wrote:
> On Mon, Aug 16, 2021 at 03:46:16PM +0800, Kefeng Wang wrote:
>> Patch 1 and 2 make some cleanup, and patch 3 use of_irq_get() instead of
>> irq_of_parse_and_map() to get irq number, return -EPROBE_DEFER if the irq
>> domain is not yet created, amba_device_add() will properly to handle the
>> no IRQ domain issue via deferred probe.
>>
>> Kefeng Wang (3):
>>    amba: Drop unused functions about APB/AHB devices add
>>    Revert "ARM: amba: make use of -1 IRQs warn"
>>    amba: Properly handle device probe without IRQ domain
>>
>>   drivers/amba/bus.c       | 100 ++++++++++-----------------------------
>>   drivers/of/platform.c    |   6 +--
>>   include/linux/amba/bus.h |  18 -------
>>   3 files changed, 27 insertions(+), 97 deletions(-)
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Hi Russell, should I send the patches to the ARM patch system?

> .
>
