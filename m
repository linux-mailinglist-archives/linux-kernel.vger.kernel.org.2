Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123DD3E3DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhHIChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:37:18 -0400
Received: from mx.ucr.edu ([138.23.62.67]:30677 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232616AbhHIChQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628476617; x=1660012617;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=S5CPTabNoTndrACQMK6Rmlxzof5oq7hgo1skvEPN0Y8=;
  b=pkX+g00D+xyKcHECM113YL92k9A4mfSQF/vDN6ADq7j7vMp7g17NeIfl
   3/2Fi4JgmeiIcrTJiT8QpmDZkeE4ohTnu++3Q46SXAUq6YlbfRkqbQk2g
   uyWeaVAu/KHZEihcoOI6butUxv53bJHODSNBqg21JVeiAXYulwBy6P543
   luHwC22Fj46cFcloN0KqoVoRgmF03j7K2fEElVTWzrOAWynIbIMYdY4rd
   v+BCNE9F/qy4NhAQlbii21cFWZMDKlon9uq73mtloRU+5tMtHLp0xYdBj
   5bWQDLgfnCl6LmPc/Jfv9weuEZReJOsRrL+PLCzt/ExzvfvT9aIKSec7p
   g==;
IronPort-SDR: 320KQQVrh91PhjLY7g9dCFIiGI+W+IqRRKpYuN1OT9csQ8kI+uSez6eQNTMiTcCoKxDXpDAOzK
 Blrxp/H/Qs1efa/t6xl8o9SGOLYffXCfbVUdkPyaLmngyhfRZZhm1bjUMY10+HcH82vz6wqjjh
 0+TFQBFah+znLEH4MEBLT33IVMryHe+q4O4GeConRpbOma5BI01a2nbQviIzhCXgTMPo0VctzC
 rrta4eX0eshcJ+Z8ggpOWAj4cBcKie4Btt7nx/S5BIrLJXIw5ADvE/LAFp2nzXnBDjfWMjg921
 lljHkLXUpj+TVCzs5vZLVffl
X-IPAS-Result: =?us-ascii?q?A2EeAgArlBBhhkfYVdFaHgEBCxIMQIFOC4N4bIRIkW0Di?=
 =?us-ascii?q?lmRCYF8AgkBAQEPQQQBAYRYAoMFAiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBAQUEAQECEAEBAQGBIAtZC2OBT4F5BgQ9gjUpAYNtAQEBAxIRBFIQC?=
 =?us-ascii?q?wsDCgICJgICIQESAQUBHAYTIoJPglYDLwWcWoEEPYsyfzKBAYdZDU4BCQ2BY?=
 =?us-ascii?q?xJ+KocLhmQngimBS4EFgTM3PoIghTuCZASCLGMHARUnFigTHDIHBmktPREqE?=
 =?us-ascii?q?X8BAQGTWwGLUJw8WwEGAoMOHJJKhRkJfIVjK4Nli2CGQ5BnLZAslSiVQhAjg?=
 =?us-ascii?q?T2CFTMaJX8GZ4FLTQECAQIBDAIBAgECAQIBAggBAQKOKA0JFY44JC84AgYLA?=
 =?us-ascii?q?QEDCYpQAQE?=
IronPort-PHdr: A9a23:vygK8BSraYHxs/AOY6ykcSTSItpsorWfAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBcOEtbkZ0qL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNfwlEnjiwbLJ9I
 Bi2sAnaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiNODIOzb
 YsBAeQCM+hFsYfyu0ADrQeiCQS2GO/j1iNEi33w0KYn0+ohCwbG3Ak4Et0MsXTVrdX1NLoVU
 euoz6bIzS/Mb/JL0jr66InJcxAhruuNXb5sbcbcx1IiFx7ZgVWKs4DqIS6a1vkUvmWd8uFvW
 v6hhXQ9pAFtvjig2N0sio/Ri48azl3J8SV0zogrKdC3TEN1bt2pHZReuiyaOYZ7XsIvTn1pt
 Ss0ybAKpIO2cDUJxZk5yRPSZP+KfpWG7B/+SOucJypzinF9eL+nmRq+7Uytxvf/W8S0ylpGs
 DdJn9jWun0PyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4UhwrsslpoLtkTDAzP2lF32j
 KCIckUk/fCl6+H9bbXnop+QLpd0igPjPqg3lMyyA/k0PhIBX2ic/uS827nj8lPjTLpWif02l
 7HVsJHcJcsFuq60GxFZ3pon5hqlDDqr0M4UkWcaIF9EYh6KjZXlN0nLIP/iDPe/h1qskC1sx
 /DDJrDgApTMLnjZn7fgYbpx90BRxREuzd9D/ZJYEK8OL+/uWkPprtzXEgc5MxCow+bgENh90
 oIeWWSSAq6WKa/SskGH5vgpI+aSYI8Yoyj9K/c76P70l3M5mkESfbOv3ZQJbHC0BPNmI1+WY
 SmkvtBUM2AMtxY+Reqio1SHXCRUYT7mXaM3vGoTC4+8C4rHAIe3j+rS8j28G8hnZ3JGF1fEI
 3fhds3QSuUMYSPKepRJjzceE7WtVtlyhlmVqAbmxu8/faLv8SoCuMemjYAtj9A=
IronPort-HdrOrdr: A9a23:kuDo1quu/7YYG/17skaM344a7skDTdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIHZIObuEYzmIWsS852mOF+hobr+VvOZrF69vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="231012977"
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2021 19:36:55 -0700
Received: by mail-pj1-f71.google.com with SMTP id mi10-20020a17090b4b4ab0290178b6d7574aso534283pjb.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXT+reKNAAdaXSEr1r6kToV8qtLfQIdGnpz4v9GHBhI=;
        b=DGJQj2tk9PPDrJLKLhRQMk1wMcg3Aq9Y//dOwiO0zJTWiWPSqBjSoU997eyYgwnl1C
         PIEB2QKAwjdGTVeDWeJARete5foFwudwiHmgjGIjtSTjwg1n2ITnSXPnfWFVvyhcJf2F
         rdViZvi+yzi4T/hBp8KLc2SM9jsYzijzL/mrrWBj0ytYfWvRfcUC/rQmhewTPTPNzlmJ
         lTZgcgX8M2Oz70NuAjkeGAYfOqJ1/IHI5Mwmxdtk1i7SCOceR69uhX9DNMEjrsbiF09c
         c5TgeKPTTHhLBMkPTHokOzuVSqavVskXY1KkT/8rPmriF1HfWDrPVMHcitStxURu/94p
         DmUg==
X-Gm-Message-State: AOAM5314a3tL8o3cTqoWfX5H9z7wklLXxdkHkeL/hQUTg9vpqw66iDu5
        4T/E4a5zJ5dL/HBMhzjjvDwAfjDlWSWsm233cLXrHLyOqM5OrJ5k4ecryUVunIb5zMZVjKPj2KQ
        4ClhUjxdjbXvAmqwFhBdMN5PpSHS2UbE4XX/FW2UU2g==
X-Received: by 2002:a17:90a:448f:: with SMTP id t15mr22860884pjg.21.1628476615285;
        Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmi7KyD7gC/LNsTSN7LbNllZcAdD362fcg3154hLUGjINb7m4IUt/iss0EBAvzX9fyKwU+IE1XNo2+BlsUz3s=
X-Received: by 2002:a17:90a:448f:: with SMTP id t15mr22860872pjg.21.1628476615053;
 Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210719195313.40341-1-yzhai003@ucr.edu> <20210724164840.7381053b@jic23-huawei>
 <20210808183243.70619aa8@jic23-huawei>
In-Reply-To: <20210808183243.70619aa8@jic23-huawei>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 8 Aug 2021 19:36:44 -0700
Message-ID: <CABvMjLRHs61AAYqTeRWV0DHciLBoqHwJ5Djg7ZseYkjE=JhbQg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Fix the uninitialized use if
 regmap_read() fails
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan:
Thanks for your effort, and yes please take a look just in case.
FYI, I made the modifications align with Alexandru's help, this is the
original reply:

On Mon, Jul 19, 2021 at 12:47 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Jul 19, 2021 at 2:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > Hi All:
> > Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> > could be uninitialized if the regmap_read() fails and returns an error
> > code.  However, they are directly used in the later context to decide
> > the control flow, which is potentially unsafe. However,
> > stm32_dfsdm_irq() returns the type irqreturn_t and I could not return
>
> Just curious: are you seeing any issues with these variables being
> uninitialized?
>
> > the error code directly. Could you please advise me here?
>
> The correct way to do it, would be:
>
> ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> if (ret)
>     return IRQ_HANDLED;
>
> IRQ handlers should return one of
> enum irqreturn {
>     IRQ_NONE        = (0 << 0),
>     IRQ_HANDLED     = (1 << 0),
>     IRQ_WAKE_THREAD     = (1 << 1),
> };
>
> If you want to fully optimize/correct this, then it may be something like:
>
>         ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
>         if (ret)
>                 return IRQ_HANDLED;
>
>         if (status & DFSDM_ISR_REOCF_MASK) {
>                 /* Read the data register clean the IRQ status */
>                 regmap_read(regmap, DFSDM_RDATAR(adc->fl_id), adc->buffer);
>
> // in this point, we could check for regmap_read(), but it won't make
> sense; we should call the complete() handler, either way
>
>                 complete(&adc->completion);
>         }
>
>         if (status & DFSDM_ISR_ROVRF_MASK) {
>                 ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
>                 if (ret)
>                         return IRQ_HANDLED;
>                 if (int_en & DFSDM_CR2_ROVRIE_MASK)
>                         dev_warn(&indio_dev->dev, "Overrun detected\n");
>                 regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
>                                    DFSDM_ICR_CLRROVRF_MASK,
>                                    DFSDM_ICR_CLRROVRF_MASK);
>
> // in this point, we could also check the ret code; but we still need
> to call IRQ_HANDLED anyway;
>         }
>
>
> Quite often, when regmap_read() returns errors, then something is
> seriously wrong in the system.
> Something else would usually fail or crash worse than this interrupt handler.
> That being said, properly handling regmap_read() here is a good idea.
>
> >
> > The related code:
> >
> > static irqreturn_t stm32_dfsdm_irq(int irq, void *arg) {
> >     unsigned int status, int_en;
> >
> >     regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> >     regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> >
> >     if (status & DFSDM_ISR_REOCF_MASK) {}
> >     if (status & DFSDM_ISR_ROVRF_MASK) {}
> > }
> >
> >
> > --
> > Kind Regards,
> >
> > Yizhuo Zhai
> >
> > Computer Science, Graduate Student
> > University of California, Riverside


On Sun, Aug 8, 2021 at 10:29 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 24 Jul 2021 16:48:40 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 19 Jul 2021 19:53:11 +0000
> > Yizhuo <yzhai003@ucr.edu> wrote:
> >
> > > Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> > > could be uninitialized if the regmap_read() fails and returns an error
> > > code.  However, they are directly used in the later context to decide
> > > the control flow, which is potentially unsafe.
> > >
> > > Fixes: e2e6771c64625 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> > >
> > > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> >
> > Hi Yizhou
> >
> > I want to get some review of this from people familiar with the
> > hardware as there is a small possibility your reordering might have
> > introduced a problem.
>
> To stm32 people, can someone take a look at this?
>
> Thanks,
>
> Jonathan
>
> >
> > > ---
> > >  drivers/iio/adc/stm32-dfsdm-adc.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > index 1cfefb3b5e56..d8b78aead942 100644
> > > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > @@ -1292,9 +1292,11 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> > >     struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> > >     struct regmap *regmap = adc->dfsdm->regmap;
> > >     unsigned int status, int_en;
> > > +   int ret;
> > >
> > > -   regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > > -   regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> >
> > Moving this later is only valid if there aren't any side effects.
> > The current ordering is strange enough it makes me wonder if there might be!
> >
> > Jonathan
> >
> > > +   ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > > +   if (ret)
> > > +           return IRQ_HANDLED;
> > >
> > >     if (status & DFSDM_ISR_REOCF_MASK) {
> > >             /* Read the data register clean the IRQ status */
> > > @@ -1303,6 +1305,9 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> > >     }
> > >
> > >     if (status & DFSDM_ISR_ROVRF_MASK) {
> > > +           ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> > > +           if (ret)
> > > +                   return IRQ_HANDLED;
> > >             if (int_en & DFSDM_CR2_ROVRIE_MASK)
> > >                     dev_warn(&indio_dev->dev, "Overrun detected\n");
> > >             regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
> >
>


--
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
