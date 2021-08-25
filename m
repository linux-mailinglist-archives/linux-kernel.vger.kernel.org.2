Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163773F751B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhHYMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240864AbhHYMej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:34:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96DC261184;
        Wed, 25 Aug 2021 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629894833;
        bh=qrESRDAEVzdBOBV/LmDq/fGG6ZFyDzbuKD741OD8lw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ptaaKz6BM9sC8AF20cxv7ay0tp6xTyNsiqtL2al4Vfzn5R+ZpYOzYOA1xvXnZIzYv
         PK+FJmuXp6S3mHqbiW2UKQq6mAI2X8nyGt/HfhWPtyoTfmjANXs7zRq2qa4ZK9R00a
         2GeLpDdA1fYdEBma/psBZD4Vpv/wfkgjqrgTLUCITNmWf9Oxby2bMf5JhgfhTFCFUf
         YiiPXUeOLv2Sv2hvGK2Pz4oSisNhom7rLCUthmjn6Fd56XJpAfaMUfktEi+uer9p5n
         lViqpSR/iT8mLu6A5dsUDndWcW36EM/rO8SqPM5nBHRvYaZPpsOKtrUy10JY7idyE6
         /3fn8EfzOk/3g==
Received: by mail-ed1-f46.google.com with SMTP id q3so36753667edt.5;
        Wed, 25 Aug 2021 05:33:53 -0700 (PDT)
X-Gm-Message-State: AOAM530zSDlSjn0+Gtpqi8tvzNtBCXLK104Yj6Atbz9mByARJFqx9oLZ
        /YJ7J7NLVzk//Y3EOaBsUL7fb90M0bgMcLpEmg==
X-Google-Smtp-Source: ABdhPJxKPMFYHuam6oE3ysnmdaKPmXcVvdn2Bl4IdLfOhvyu9U/HF8ucAh/dyuGU/eEYLlFwdzzAFp8v/IGuoot3VpU=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr49263006edt.194.1629894832158;
 Wed, 25 Aug 2021 05:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <20210816074619.177383-4-wangkefeng.wang@huawei.com> <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
 <CAGETcx8SY14rcd7g=Gdwmw7sUMb=jdEV+ffuNpg6btDoL1jmWw@mail.gmail.com> <ee649111-dc07-d6db-8872-dcb692802236@huawei.com>
In-Reply-To: <ee649111-dc07-d6db-8872-dcb692802236@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Aug 2021 07:33:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0rq6u5d7itETOnQWx_V+J3aP1m1Zgehi5QKVoKvdbvQ@mail.gmail.com>
Message-ID: <CAL_Jsq+0rq6u5d7itETOnQWx_V+J3aP1m1Zgehi5QKVoKvdbvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] amba: Properly handle device probe without IRQ domain
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Saravana Kannan <saravanak@google.com>,
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

On Tue, Aug 24, 2021 at 11:05 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/8/25 4:08, Saravana Kannan wrote:
> > On Tue, Aug 24, 2021 at 1:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> >> +Saravana
> >>
> >> Saravana mentioned to me there may be some issues with this one...
> >>
> >>
> >> On Mon, Aug 16, 2021 at 2:43 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>> of_amba_device_create() uses irq_of_parse_and_map() to translate
> >>> a DT interrupt specification into a Linux virtual interrupt number.
> >>>
> >>> But it doesn't properly handle the case where the interrupt controller
> >>> is not yet available, eg, when pl011 interrupt is connected to MBIGEN
> >>> interrupt controller, because the mbigen initialization is too late,
> >>> which will lead to no IRQ due to no IRQ domain found, log is shown below,
> >>>    "irq: no irq domain found for uart0 !"
> >>>
> >>> use of_irq_get() to return -EPROBE_DEFER as above, and in the function
> >>> amba_device_try_add()/amba_device_add(), it will properly handle in such
> >>> case, also return 0 in other fail cases to be consistent as before.
> >>>
> >>> Cc: Russell King <linux@armlinux.org.uk>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Reported-by: Ruizhe Lin <linruizhe@huawei.com>
> >>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>> ---
> >>>   drivers/amba/bus.c    | 27 +++++++++++++++++++++++++++
> >>>   drivers/of/platform.c |  6 +-----
> >>>   2 files changed, 28 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >>> index 36f2f42c8014..720aa6cdd402 100644
> >>> --- a/drivers/amba/bus.c
> >>> +++ b/drivers/amba/bus.c
> >>> @@ -19,6 +19,7 @@
> >>>   #include <linux/clk/clk-conf.h>
> >>>   #include <linux/platform_device.h>
> >>>   #include <linux/reset.h>
> >>> +#include <linux/of_irq.h>
> >>>
> >>>   #include <asm/irq.h>
> >>>
> >>> @@ -371,12 +372,38 @@ static void amba_device_release(struct device *dev)
> >>>          kfree(d);
> >>>   }
> >>>
> >>> +static int of_amba_device_decode_irq(struct amba_device *dev)
> >>> +{
> >>> +       struct device_node *node = dev->dev.of_node;
> >>> +       int i, irq = 0;
> >>> +
> >>> +       if (IS_ENABLED(CONFIG_OF_IRQ) && node) {
> >>> +               /* Decode the IRQs and address ranges */
> >>> +               for (i = 0; i < AMBA_NR_IRQS; i++) {
> >>> +                       irq = of_irq_get(node, i);
> >>> +                       if (irq < 0) {
> >>> +                               if (irq == -EPROBE_DEFER)
> >>> +                                       return irq;
> >>> +                               irq = 0;
> >>> +                       }
> >>> +
> >>> +                       dev->irq[i] = irq;
> >>> +               }
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>>   static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> >>>   {
> >>>          u32 size;
> >>>          void __iomem *tmp;
> >>>          int i, ret;
> >>>
> >>> +       ret = of_amba_device_decode_irq(dev);
> >>> +       if (ret)
> >>> +               goto err_out;
> >>> +
> > Similar to other resources the AMBA bus "gets" for the device, I think
> > this should be moved into amba_probe() and not here. There's no reason
> > to delay the addition of the device (and loading its module) because
> > the IRQ isn't ready yet.
>
> The following code in the amba_device_try_add() will be called, it uses irq[0]
> and irq[1], so I put of_amba_device_decode_irq() into amba_device_try_add().
>
> 470         if (dev->irq[0])
> 471                 ret = device_create_file(&dev->dev, &dev_attr_irq0);
> 472         if (ret == 0 && dev->irq[1])
> 473                 ret = device_create_file(&dev->dev, &dev_attr_irq1);
> 474         if (ret == 0)
> 475                 return ret;

I wonder if we could just remove these. Why does userspace need them
in the first place? It's only an ABI if someone notices. Looking at
the history, AMBA bus was added in 2003 with just 'irq' and then
changed (ABI break) in 2004 to 'irq0' and 'irq1'.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/log/arch/arm/common/amba.c
