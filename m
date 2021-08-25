Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0243F7791
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhHYOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:42:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8774 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhHYOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:42:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvpYl0PgdzYrGg;
        Wed, 25 Aug 2021 22:40:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:41:16 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:41:16 +0800
Subject: Re: [PATCH 3/3] amba: Properly handle device probe without IRQ domain
To:     Rob Herring <robh+dt@kernel.org>
CC:     Saravana Kannan <saravanak@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ruizhe Lin <linruizhe@huawei.com>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <20210816074619.177383-4-wangkefeng.wang@huawei.com>
 <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
 <CAGETcx8SY14rcd7g=Gdwmw7sUMb=jdEV+ffuNpg6btDoL1jmWw@mail.gmail.com>
 <ee649111-dc07-d6db-8872-dcb692802236@huawei.com>
 <CAL_Jsq+0rq6u5d7itETOnQWx_V+J3aP1m1Zgehi5QKVoKvdbvQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d7a1d3a8-bda4-7a29-b66d-22ed4926f9c8@huawei.com>
Date:   Wed, 25 Aug 2021 22:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+0rq6u5d7itETOnQWx_V+J3aP1m1Zgehi5QKVoKvdbvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 20:33, Rob Herring wrote:
> On Tue, Aug 24, 2021 at 11:05 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

...

>>> Similar to other resources the AMBA bus "gets" for the device, I think
>>> this should be moved into amba_probe() and not here. There's no reason
>>> to delay the addition of the device (and loading its module) because
>>> the IRQ isn't ready yet.
>> The following code in the amba_device_try_add() will be called, it uses irq[0]
>> and irq[1], so I put of_amba_device_decode_irq() into amba_device_try_add().
>>
>> 470         if (dev->irq[0])
>> 471                 ret = device_create_file(&dev->dev, &dev_attr_irq0);
>> 472         if (ret == 0 && dev->irq[1])
>> 473                 ret = device_create_file(&dev->dev, &dev_attr_irq1);
>> 474         if (ret == 0)
>> 475                 return ret;
> I wonder if we could just remove these. Why does userspace need them
> in the first place? It's only an ABI if someone notices. Looking at
> the history, AMBA bus was added in 2003 with just 'irq' and then
> changed (ABI break) in 2004 to 'irq0' and 'irq1'.
>
> Rob

Ok, I will kill all irq parts,

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 962041148482..c08e8b30e02c 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,8 +20,6 @@
  #include <linux/platform_device.h>
  #include <linux/reset.h>

-#include <asm/irq.h>
-
  #define to_amba_driver(d)      container_of(d, struct amba_driver, drv)

  /* called on periphid match and class 0x9 coresight device. */
@@ -135,8 +133,6 @@ static ssize_t name##_show(struct device 
*_dev,                             \
  static DEVICE_ATTR_RO(name)

  amba_attr_func(id, "%08x\n", dev->periphid);
-amba_attr_func(irq0, "%u\n", dev->irq[0]);
-amba_attr_func(irq1, "%u\n", dev->irq[1]);
  amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
          (unsigned long long)dev->res.start, (unsigned long 
long)dev->res.end,
          dev->res.flags);
@@ -467,10 +463,6 @@ static int amba_device_try_add(struct amba_device 
*dev, struct resource *parent)
         if (ret)
                 goto err_release;

-       if (dev->irq[0])
-               ret = device_create_file(&dev->dev, &dev_attr_irq0);
-       if (ret == 0 && dev->irq[1])
-               ret = device_create_file(&dev->dev, &dev_attr_irq1);

and do some cleanup about error handling in the next version.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/log/arch/arm/common/amba.c
> .
>
