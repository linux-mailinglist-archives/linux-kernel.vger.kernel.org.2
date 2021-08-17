Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6EB3EEB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhHQKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:36:49 -0400
Received: from mail.ispras.ru ([83.149.199.84]:32874 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235845AbhHQKgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:36:41 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7AB0E40A2BD5;
        Tue, 17 Aug 2021 10:36:03 +0000 (UTC)
Subject: Re: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
References: <20210812113800.12466-1-novikov@ispras.ru>
 <CAHp75VcgqZEHBTXpNApGfRkhgjpCvbgj+yxUZbbO+=0DOvZLQg@mail.gmail.com>
 <20210816100114.384f01b9@xps13>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <246f2094-e294-73f8-8a5f-3467e987f788@ispras.ru>
Date:   Tue, 17 Aug 2021 13:36:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816100114.384f01b9@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 16.08.2021 11:01, Miquel Raynal wrote:
> Hi Andy,
>
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Thu, 12 Aug 2021
> 15:13:10 +0300:
>
>> On Thursday, August 12, 2021, Evgeny Novikov <novikov@ispras.ru> wrote:
>>
>>> It seems that mxic_nfc_probe() missed invocation of
>>> mxic_nfc_clk_enable(). The patch fixed that. In addition, error handling
>>> was refined appropriately.
>>
>> NAK. Until you provide a deeper analysis, like how this works before your
>> change.
>>
>>
>> Please, don’t blindly generate patches, this can even your bot do, just
>> think about each change and preferable test on the real hardware.
>>
>> The above is to all your lovely contributions.
>>
>>
>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>
>>> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
>>> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>>> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>>> ---
>>>   drivers/mtd/nand/raw/mxic_nand.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_
>>> nand.c
>>> index da1070993994..37e75bf60ee5 100644
>>> --- a/drivers/mtd/nand/raw/mxic_nand.c
>>> +++ b/drivers/mtd/nand/raw/mxic_nand.c
>>> @@ -509,9 +509,15 @@ static int mxic_nfc_probe(struct platform_device
>>> *pdev)
>>>          if (IS_ERR(nfc->send_dly_clk))
>>>                  return PTR_ERR(nfc->send_dly_clk);
>>>
>>> +       err = mxic_nfc_clk_enable(nfc);
>>> +       if (err)
>>> +               return err;
> As Andy said, this is not needed.
>
>>> +
>>>          nfc->regs = devm_platform_ioremap_resource(pdev, 0);
>>> -       if (IS_ERR(nfc->regs))
>>> -               return PTR_ERR(nfc->regs);
>>> +       if (IS_ERR(nfc->regs)) {
>>> +               err = PTR_ERR(nfc->regs);
>>> +               goto fail;
>>> +       }
>>>
>>>          nand_chip = &nfc->chip;
>>>          mtd = nand_to_mtd(nand_chip);
>>> @@ -527,8 +533,10 @@ static int mxic_nfc_probe(struct platform_device
>>> *pdev)
>>>          nand_chip->controller = &nfc->controller;
>>>
>>>          irq = platform_get_irq(pdev, 0);
>>> -       if (irq < 0)
>>> -               return irq;
>>> +       if (irq < 0) {
>>> +               err = irq;
>>> +               goto fail;
> However some reworking is needed in the error path.
>
> That goto statement should be renamed and devm_request_irq() should not
> jump to it.
>

We still need some help and clarification from those who are very 
familiar with this sort of drivers or/and can test this particular 
driver. mxic_nfc_clk_enable() is the complementary function for 
mxic_nfc_clk_disable(). No other functions invoke 
clk_prepare_enable()/clk_disable_unprepare() in the driver. Unlikely 
somebody in its environment does that since driver specific clocks are 
dealt with. At the moment the driver invokes mxic_nfc_clk_disable() on 
error handling paths in probe, in remove and in mxic_nfc_set_freq(). 
mxic_nfc_clk_enable() is called just by mxic_nfc_set_freq() that 
moreover does this after calling mxic_nfc_clk_disable() first. So, we 
did not find any place in the driver that invokes mxic_nfc_clk_enable() 
prior to mxic_nfc_clk_disable(). Basing on this we added 
mxic_nfc_clk_enable() just after getting clocks. As I explained in the 
previous large e-mail, we may be wrong in our understanding of the 
driver environment or/and at specification of requirements being 
checked. It would be great if you will point out on our mistakes.

Best regards,
Evgeny Novikov
>>> +       }
>>>
>>>          mxic_nfc_hw_init(nfc);
>>>
>>> --
>>> 2.26.2
>>>
>>>   
> Thanks,
> Miquèl
