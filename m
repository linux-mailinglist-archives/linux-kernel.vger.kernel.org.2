Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471613F81C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhHZErG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHZErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:47:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:46:17 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p83so1380046yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgdL5as35+i2mHlUCdQc4m6L0YmfdSZa77eRS39qBnA=;
        b=WrQhDyryIaGyHF+wUrhDTQGAekquZHmBoUQGHFuwMpk4D62D+QwNVo0yeK1CmQfw+T
         TFVY6mEdnd09CI1xNYFtKe4Nc2qOhywN1cf0C+UvT66lew1NtVERVR4j/xDAtkOTiRWW
         0wVARsJZjBwPQQIyl/VvMS2LqAkzn/9JUhO+PmFpXNTSx5g/cnGNC7oIrT53cWnbim+b
         Wav1jCUrhaaRtKAkt9FdbR7HY/YIu3uhR45Mrd/6b1yeBiJeNiKCHEgymyn29zuZXg/x
         JtxrY2v02fJAxkJVVpnbd1I9wovoDx5cPYEnydpIth9SgPH4f2rFutVD4IoA2Hf0LAsl
         7PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgdL5as35+i2mHlUCdQc4m6L0YmfdSZa77eRS39qBnA=;
        b=hTFTBsoxpz8w1nSjmvLuRiIxoEzD2F/7T1c8nnD5JtkIpP3jdUlwSrm3lM+hYM/m9K
         ui6NYqdmM1FDzPAuEh2uDPfoSPQ9WyNam+kWQVORTzl/JOY0FkCaHdxabna/nn0cpD9d
         U5xZxIkGyZhjHnH1rK5RZEpNPyAIH6Ixev2mI4MFFs3Cro4E076j9iEILgSwMZlwAjP8
         ZYtirSiJLvpJCxeTJiEhq5CF9nT/zPk0wMQlOwatDm1fYTvNUM++RPJ4j+gxFrhet+oV
         vCY5pEm8BX4VK0oubkL6FsPvVQW/piUBnd/Nm8vgqFLIGTBIgZ2Vq06kvbotYIAD1eou
         /Okg==
X-Gm-Message-State: AOAM533ne+HcieXkFVfHj79Os9X8pE9JrONQW3UUQ0KswUFgEcTfMzxg
        5A6h3/jDaEhGl8YelHiVdyCnPXxkR3aCQt/O+Qo9xQ==
X-Google-Smtp-Source: ABdhPJzsaBSC4K7dz+AKCr2HuRqOibJQ2FbCOIa7HlSYjw1OSkdTpyGN+6glSGWQLia7J3JzHEja4XJNj+dLfR1S84s=
X-Received: by 2002:a25:804:: with SMTP id 4mr2697573ybi.346.1629953176343;
 Wed, 25 Aug 2021 21:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <20210816074619.177383-4-wangkefeng.wang@huawei.com> <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
 <CAGETcx8SY14rcd7g=Gdwmw7sUMb=jdEV+ffuNpg6btDoL1jmWw@mail.gmail.com>
 <ee649111-dc07-d6db-8872-dcb692802236@huawei.com> <CAGETcx9drOdE_vfn-nhDZM9MbgxGxYJN6ydiAVxo_Ltqve9eTg@mail.gmail.com>
 <b5eb935f-26e1-6475-63af-e7f6101eb017@huawei.com>
In-Reply-To: <b5eb935f-26e1-6475-63af-e7f6101eb017@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 Aug 2021 21:45:40 -0700
Message-ID: <CAGETcx9yaWZOzt=gcyNAshoHdPoYizhmrKS-kU9c2QM2+HqeEw@mail.gmail.com>
Subject: Re: [PATCH 3/3] amba: Properly handle device probe without IRQ domain
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ruizhe Lin <linruizhe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 7:45 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/8/25 16:04, Saravana Kannan wrote:
> > On Tue, Aug 24, 2021 at 9:05 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>
> >> On 2021/8/25 4:08, Saravana Kannan wrote:
> >>> On Tue, Aug 24, 2021 at 1:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> >>>> +Saravana
> >>>>
> >>>> Saravana mentioned to me there may be some issues with this one...
> >>>>
> >>>>
> >>>> On Mon, Aug 16, 2021 at 2:43 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>>>> of_amba_device_create() uses irq_of_parse_and_map() to translate
> >>>>> a DT interrupt specification into a Linux virtual interrupt number.
> >>>>>
> >>>>> But it doesn't properly handle the case where the interrupt controller
> >>>>> is not yet available, eg, when pl011 interrupt is connected to MBIGEN
> >>>>> interrupt controller, because the mbigen initialization is too late,
> >>>>> which will lead to no IRQ due to no IRQ domain found, log is shown below,
> >>>>>     "irq: no irq domain found for uart0 !"
> >>>>>
> >>>>> use of_irq_get() to return -EPROBE_DEFER as above, and in the function
> >>>>> amba_device_try_add()/amba_device_add(), it will properly handle in such
> >>>>> case, also return 0 in other fail cases to be consistent as before.
> >>>>>
> >>>>> Cc: Russell King <linux@armlinux.org.uk>
> >>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>>>> Reported-by: Ruizhe Lin <linruizhe@huawei.com>
> >>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>>> ---
> >>>>>    drivers/amba/bus.c    | 27 +++++++++++++++++++++++++++
> >>>>>    drivers/of/platform.c |  6 +-----
> >>>>>    2 files changed, 28 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >>>>> index 36f2f42c8014..720aa6cdd402 100644
> >>>>> --- a/drivers/amba/bus.c
> >>>>> +++ b/drivers/amba/bus.c
> >>>>> @@ -19,6 +19,7 @@
> >>>>>    #include <linux/clk/clk-conf.h>
> >>>>>    #include <linux/platform_device.h>
> >>>>>    #include <linux/reset.h>
> >>>>> +#include <linux/of_irq.h>
> >>>>>
> >>>>>    #include <asm/irq.h>
> >>>>>
> >>>>> @@ -371,12 +372,38 @@ static void amba_device_release(struct device *dev)
> >>>>>           kfree(d);
> >>>>>    }
> >>>>>
> >>>>> +static int of_amba_device_decode_irq(struct amba_device *dev)
> >>>>> +{
> >>>>> +       struct device_node *node = dev->dev.of_node;
> >>>>> +       int i, irq = 0;
> >>>>> +
> >>>>> +       if (IS_ENABLED(CONFIG_OF_IRQ) && node) {
> >>>>> +               /* Decode the IRQs and address ranges */
> >>>>> +               for (i = 0; i < AMBA_NR_IRQS; i++) {
> >>>>> +                       irq = of_irq_get(node, i);
> >>>>> +                       if (irq < 0) {
> >>>>> +                               if (irq == -EPROBE_DEFER)
> >>>>> +                                       return irq;
> >>>>> +                               irq = 0;
> >>>>> +                       }
> >>>>> +
> >>>>> +                       dev->irq[i] = irq;
> >>>>> +               }
> >>>>> +       }
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +
> >>>>>    static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> >>>>>    {
> >>>>>           u32 size;
> >>>>>           void __iomem *tmp;
> >>>>>           int i, ret;
> >>>>>
> >>>>> +       ret = of_amba_device_decode_irq(dev);
> >>>>> +       if (ret)
> >>>>> +               goto err_out;
> >>>>> +
> >>> Similar to other resources the AMBA bus "gets" for the device, I think
> >>> this should be moved into amba_probe() and not here. There's no reason
> >>> to delay the addition of the device (and loading its module) because
> >>> the IRQ isn't ready yet.
> >> The following code in the amba_device_try_add() will be called, it uses irq[0]
> >> and irq[1], so I put of_amba_device_decode_irq() into amba_device_try_add().
> >>
> >> 470         if (dev->irq[0])
> >> 471                 ret = device_create_file(&dev->dev, &dev_attr_irq0);
> >> 472         if (ret == 0 && dev->irq[1])
> >> 473                 ret = device_create_file(&dev->dev, &dev_attr_irq1);
> >> 474         if (ret == 0)
> >> 475                 return ret;
> >>
> >> of_amba_device_decode_irq() in amba_device_try_add() won't lead to issue,
> >> only delay the device add, right?
> > But delaying the device add is the issue. For example, adding a device
> > could trigger the loading of the corresponding module using uevents.
> > But now this change would delay that step. That can have other
> > unintended consequences -- slowing down boot, what if the driver was
> > working fine without the IRQ, etc.
> >
> >> If make it into amba_probe(), the above code should be moved too, could we
> >> make a new patch to move both of them, or don't move them?
> > I'd say move them both. If Russell hasn't already picked this up, then
> > I'd say redo your Patch 3/3.
> I will resend with put it into amba_probe.
> >
> > Btw, I've been working on [1] cleaning up the one-off deferred probe
> > solution that we have for amba devices. That causes a bunch of other
> > headaches. Your patch 3/3 takes us further in the wrong direction by
> > adding more reasons for delaying the addition of the device.
>
> Got it,  and I could resend all combine your patch(due to context conflict
>
> when changing same function) if you no object.

If you want to resolve the conflict with my patch and resend it while
keeping me as the author, I would definitely appreciate it.

-Saravana
>
>
> >
> > -Saravana
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx8b228nDUho3cX9AAQ-pXOfZTMv8cj2vhdx9yc_pk8q+A@mail.gmail.com/
> > .
> >
