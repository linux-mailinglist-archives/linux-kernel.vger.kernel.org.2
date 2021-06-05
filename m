Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5A39C6C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFEI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhFEI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:28:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291ACC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 01:27:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so11460090otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKyUqf7NI2Yuw0Cm11CrEyV9uYKyJhwCEAKigEKJNJ8=;
        b=ZS6EUPMoBJoX6MkxGQ9BXtnrqLzaWaesaMMxH99UlWaxLN0dTg8LcmeGrxD5kWX0OT
         RL+cn0uTJqQmllPGzucLq8e/7lvwU4XSeiaX4MMIZSFLeODXFvXfENBjbp70qDH7lTiF
         65bdM67WQJwnlcr//9cu38chzebttAT4TXJA3BA0A8+IJjo2v2xqG6KBwB769tFB8UK7
         sp7L7k3FWnKHFS4Gguj+Vb57YMMQr4R6ptKeW0MKZqDgQz1F+w13d37fdO7wQQMsg89k
         e0hXbn5vaHyz1AHDz0vVS+SdXyir9I/k+ueh88t33DXZub8SPyqQWaMuBRc4zmEbkH2n
         4uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKyUqf7NI2Yuw0Cm11CrEyV9uYKyJhwCEAKigEKJNJ8=;
        b=k4Gdvrz4PV0Xnq++UJOMLdBs00AR5h23E1L17ldV4UoZF+qbA+EGO8jw6LHPjQMxHA
         k32Nvq9dUS8vhTlL0tpwRS8ZH4V9LLkjFaI6KSTTKlJdM4S3UtJdSkUUJPBdpL6WOTRB
         tmSdn/xbhzuNSoY4XLReuZRMZ1K2lj1mn97W6Qlifh++JvToeJNbyv+2y7Afou4h9XDj
         c4g9NOOeC/bu6FTIeSWVTnYRA9SGRdDfY+DgX+Unozf5r4t/0VUEbgTvs2DwXOYvpZKv
         utK+MJQ9K5dEAOsu96w3V+qVCvEuEjrnP5kmB61MC66ipm6mijXcxAoeoM84I7W+29Qb
         ej8g==
X-Gm-Message-State: AOAM530ZVuX8y7yHbYqr7F0+EFWIaqeimB0jfgKTGjqVpmuwwq8EOjM7
        +SXueN/pk5nfJZzMLk+QuIRpbnSUcT/PQY8zfWBFCw==
X-Google-Smtp-Source: ABdhPJxnmzc/8hxfB8fveUdflIof7ixtQvUsNexucCkGmlOQVpwJQn70pCPp044bin6dr/pH+6DjV0HdWVtuhUOPgQg=
X-Received: by 2002:a9d:7982:: with SMTP id h2mr742263otm.51.1622881619504;
 Sat, 05 Jun 2021 01:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-17-bhupesh.sharma@linaro.org> <ca0e576d-0231-d1a8-06c5-e85f0706c993@linaro.org>
In-Reply-To: <ca0e576d-0231-d1a8-06c5-e85f0706c993@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 5 Jun 2021 13:56:48 +0530
Message-ID: <CAH=2NtwuPP+qAidYKJ6i_iQg1VMtPS6xeGvnSKcNE0pf0HqcNQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] crypto: qce: Defer probing if BAM dma channel is
 not yet initialized
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

Thanks for the review and sorry for the late reply.

On Fri, 21 May 2021 at 07:27, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
>
>
> On 5/19/21 10:36 AM, Bhupesh Sharma wrote:
> > Since the Qualcomm qce crypto driver needs the BAM dma driver to be
> > setup first (to allow crypto operations), it makes sense to defer
> > the qce crypto driver probing in case the BAM dma driver is not yet
> > probed.
> >
> > Move the code leg requesting dma channels earlier in the
> > probe() flow. This fixes the qce probe failure issues when both qce
> > and BMA dma are compiled as static part of the kernel.
>
> So, I do not understand what issue you faced with the current code
> ordering. When bam dma is not initialized, qce_dma_request will fail and
> rest the error path kicks in.
> To me the correct ordering for enabling a driver is to turn on clocks
> and interconnect before requesting for dma. Unless, there is a specific
> issue, I will ask for that order to be maintained.

Sure. The problem I faced was the following. Let's consider the
scenario where while the qce crypto driver and the interconnect are
compiled as static parts of the kernel, the bam DMA driver is compiled
as a module, then the -EPROBE_DEFER return leg from the qce crypto
driver is very late in the probe() flow, as we first turn on the
clocks and then the interconnect.

Now the suggested linux deferred probe implementation is to return as
early from the caling driver in case the called driver (subdev) is not
yet ready. SInce the qce crypto driver requires the bam DMA to be set
up first, it makes sense to move 'qce_dma_request' early in the boot
flow. If it's not yet probed(), it probably doesn't make sense to set
up the clks and interconnects yet in the qce driver. We can do it
later when the bam DMA is setup.

I have tested the following combinations with the change I made in
this patchset:

1. qce - static, bam - module, interconnect - module ->
qce_dma_request returned -EPROBE_DEFER
2. qce - static, bam - module, interconnect - static ->
qce_dma_request returned -EPROBE_DEFER
3. qce - static, bam - static, interconnect - module ->
qce_dma_request returned -EPROBE_DEFER
4. qce - static, bam - static, interconnect - static -> no -EPROBE_DEFER

Thanks,
Bhupesh

> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/crypto/qce/core.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index 8b3e2b4580c2..207221d5b996 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -218,6 +218,14 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       if (ret < 0)
> >               goto err_out;
> >
> > +     /* qce driver requires BAM dma driver to be setup first.
> > +      * In case the dma channel are not set yet, this check
> > +      * helps use to return -EPROBE_DEFER earlier.
> > +      */
> > +     ret = qce_dma_request(qce->dev, &qce->dma);
> > +     if (ret)
> > +             return ret;
> > +
> >       qce->mem_path = devm_of_icc_get(qce->dev, "memory");
> >       if (IS_ERR(qce->mem_path))
> >               return dev_err_probe(dev, PTR_ERR(qce->mem_path),
> > @@ -269,10 +277,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >                       goto err_clks_iface;
> >       }
> >
> > -     ret = qce_dma_request(qce->dev, &qce->dma);
> > -     if (ret)
> > -             goto err_clks;
> > -
> >       ret = qce_check_version(qce);
> >       if (ret)
> >               goto err_clks;
> > @@ -287,12 +291,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >
> >       ret = qce_register_algs(qce);
> >       if (ret)
> > -             goto err_dma;
> > +             goto err_clks;
> >
> >       return 0;
> >
> > -err_dma:
> > -     qce_dma_release(&qce->dma);
> >   err_clks:
> >       clk_disable_unprepare(qce->bus);
> >   err_clks_iface:
> >
>
>
