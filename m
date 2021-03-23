Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163B5345B08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCWJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCWJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:38:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:38:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so22678582eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0jEA2q4Aaw2ZtcKO1cqlqt1glbyKrTnhi87C48RZtAM=;
        b=yAvKFG7A0oMQmtxQy5Sp8oXbqx947Q69OvWO2V0qsimcWUAfew4wyVUjqSRQeu/yeo
         49ZN2P7ECpDDmwbX4PdqmndoYnlRgcnUgZpKYtlNBkgDAl3EIsoBVMBv8+jargId8Arb
         9Vw/fYAPIjv2RNBoeeEDTaGlj1syolEiQieg08gkP8Z+m8m+jOj5AYcsRrhyowZ8yFjU
         6tOnH3yCEBeomTxFTf5Ntd3G8ZJV9ijUf2Zo+h5/1VQsjBAHnFoR9XuupRXTAtvqNuhD
         fxpm2FU2uH43VbAK9jW6DaLEtV4agyabD+vtDEQ2BZE55ZdbkNk75GkegetDuDaovftd
         3aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0jEA2q4Aaw2ZtcKO1cqlqt1glbyKrTnhi87C48RZtAM=;
        b=mJF9Tjy51J7Wo7G1wVI/stxORurU46Kt/JjMrXBHU+EKerIrjBX4hnQ9GIyfzMyNWb
         MhRomEuZl319onkEtOzvCih3Tej40RA1XvG6dDovizDjQJ0G/75YNTxCjT0Pj+mLb6lr
         OwOXMjSSU/AEnJ8bJ0lfzJTZ4gGWWOzXrxkbB7NHJodSC4UQFH1CThNzQC6e17xBYxKJ
         9MU352tlpeOSc+DieddBKmaq2P3CNUBmsUrOBmFa9hb3kxtjz1uFDGhL8Al3v88mZxe6
         9haIpsfL+YzbdpqQJFnrGx5smUvrwT8gqLSqrGSxlvgfaUsZ2HtohNar/Kcx/6NsHf2J
         /eAQ==
X-Gm-Message-State: AOAM531Avgbe+pTHjLbGgqp73RVtbndjDA5l+qdUPD2ON+uemiy+5sPE
        LKVicAqsSgnw13BwG89C8jHZNQ==
X-Google-Smtp-Source: ABdhPJwW4mqlJyLJmx5PFFyr4uXYYH6MQQhFbOmFuns9sUC3DPQG6k2/fTJcihGXeieRDqshA10EjA==
X-Received: by 2002:a05:6402:34d:: with SMTP id r13mr3725729edw.64.1616492289370;
        Tue, 23 Mar 2021 02:38:09 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g12sm6470839eje.120.2021.03.23.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:38:08 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:38:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sre@kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
Message-ID: <20210323093806.GR2916463@dell>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
 <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
 <CAE+NS34qR9f2LOpvxTBDF4OR=Xq-SFP+uHdWe3dZ5x8xggS8kA@mail.gmail.com>
 <20210115073241.GC3975472@dell>
 <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS37hVMVJA04ZmdcfKvw05ga1-vT=fGRAf=bh17XOJHEh4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2021年1月15日 週五 下午3:32寫道：
> >
> > On Fri, 15 Jan 2021, Gene Chen wrote:
> >
> > > Matthias Brugger <matthias.bgg@gmail.com> 於 2021年1月12日 週二 下午8:32寫道：
> > > >
> > > >
> > > >
> > > > On 12/11/2020 11:39, Gene Chen wrote:
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> > > > > to simplify the similar resources object.
> > > > >
> > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > > index 692e47b..5119e51 100644
> > > > > --- a/drivers/mfd/mt6360-core.c
> > > > > +++ b/drivers/mfd/mt6360-core.c
> > > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
> > > > >  };
> > > > >
> > > > > -static const struct resource mt6360_pmic_resources[] = {
> > > > > +static const struct resource mt6360_regulator_resources[] = {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > > > -};
> > > > > -
> > > > > -static const struct resource mt6360_ldo_resources[] = {
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
> > > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > > >
> > > > As discussed with the MFD maintainer [1], the regulator (and probably all cells)
> > > > shouldn't have a DT binding.
> > > >
> > > > So please send a new version which fixes that.
> > > >
> > > > Regards,
> > > > Matthias
> > > >
> > > > [1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/
> >
> > I don't think Mark is correct here.
> >
> > We usually do implement compatible strings for sub-devices and they do
> > tend to have their own device nodes.
> >
> > It's a very long time ago since I coded this up myself, but from
> > memory, you can't have 2 devices share a compatible string.
> >
> 
> Either Mark or Lee suggestion is work.
> Is there a conclusion that we can apply it?
> If MFD is already supported of_compatible, we prefer use of_compatible mapping.

I would resubmit the set.  We can start afresh from there.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
