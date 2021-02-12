Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78CF31A426
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhBLSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBLSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:01:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:01:13 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k10so9204515otl.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgDULeiKflVFwoR6BsGB3cUqPpNxfkBwuzxZxXpXoLY=;
        b=DCzDEBVjLIaaQd57q6fVH1cUKOsUzde77Y6qiR5L/k48zTlVtQYI7DtAlnEuHF9q0X
         57rDgE3EcctbG+Jjyd+60Xa5CgCSRK1FuwvPs9VyBfXVKDLM67rJPYdyWPy19b9xMWBO
         QSR459ll+V93R4uNHr4h0eO5o3QUfjngs5f5dPrkNeivbE3YQCBNlmQAy1dDZosVX3EL
         6D1Xz5zusS+1ld+MGkk3JmZ2ySbbSANFUOOXxCVgZq+JEZ3YP9okvyOPuFhS+4Oe7XD6
         56tb6NsTZPbt4iLyids3gREv+ebIoulLV0KlupwbKepL8afknT8QgtgpkI/JAdCsWg9C
         fOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgDULeiKflVFwoR6BsGB3cUqPpNxfkBwuzxZxXpXoLY=;
        b=OfPgbCgjh5ziXPnWPT+5Gg2yxTfPUe5Xl8SkiqtdwTjJwOtdPrIMQhafr72ePuP4C4
         4iFpXPCcpnFJYv+6v1pm04N7RPCsvn/z/w0ZnEmQ5qoLSYTxR4g4kNr2qBN1c1Xxpr5I
         8FZ/UudXZ5gOZre2lytplX05+qktwLQzE767eZgwrZGe25mcEdr9PASSdZlqz1s1UJTk
         Wwa/wjhGA1Sr21CaJoqGT/qJmCWLvzcMHnU55tDRWFz6AkUB7C2QCRDk0+UHHmgmPjOf
         lq13U1HXIMHDARRWHy6lfIIpi9J5W1O/kkA2MZ1TVdIDru8fG3kOS2gxcMaiTL6OMa2H
         0t+g==
X-Gm-Message-State: AOAM531GoRHMGCF/Vmox7e/vJglcPioL6RvTALJ7gWY+mV0BBVApnYbn
        iG72q8VtOU2ZJZSukYZRph+kpA==
X-Google-Smtp-Source: ABdhPJyniCmu8jCeQK56LqSsb0pYBEXvHH0wktvHQXkTlk5uyu8JEP55tx/ozoDyxTZNRcxrBKdOug==
X-Received: by 2002:a9d:8f2:: with SMTP id 105mr2836518otf.64.1613152872844;
        Fri, 12 Feb 2021 10:01:12 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e14sm1684583oou.19.2021.02.12.10.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:01:12 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:01:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 09/10] usb: dwc3: qcom: Detect DWC3 DT-nodes with
 "usb"-prefixed names
Message-ID: <YCbCZuaO9ryAzxzy@builder.lan>
References: <20210210172850.20849-1-Sergey.Semin@baikalelectronics.ru>
 <20210210172850.20849-10-Sergey.Semin@baikalelectronics.ru>
 <CAL_JsqJBknqhCSUOdpZVbtmp6TYetBQPLoQUCT6DTFajpChaSA@mail.gmail.com>
 <20210210184051.ncvvs5xgyo7o3uzq@mobilestation>
 <YCQse9EtEHtLVe9A@builder.lan>
 <20210210193325.inp7rgpsfr624zhd@mobilestation>
 <20210212173315.jgr6kata2yxrbkuu@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212173315.jgr6kata2yxrbkuu@mobilestation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12 Feb 11:33 CST 2021, Serge Semin wrote:

> On Wed, Feb 10, 2021 at 10:33:26PM +0300, Serge Semin wrote:
> > On Wed, Feb 10, 2021 at 12:56:59PM -0600, Bjorn Andersson wrote:
> > > On Wed 10 Feb 12:40 CST 2021, Serge Semin wrote:
> > > 
> > > > On Wed, Feb 10, 2021 at 12:17:27PM -0600, Rob Herring wrote:
> > > > > On Wed, Feb 10, 2021 at 11:29 AM Serge Semin
> > > > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > > > >
> > > > > > In accordance with the USB HCD/DRD schema all the USB controllers are
> > > > > > supposed to have DT-nodes named with prefix "^usb(@.*)?".  Since the
> > > > > > existing DT-nodes will be renamed in a subsequent patch let's first make
> > > > > > sure the DWC3 Qualcomm driver supports them and second falls back to the
> > > > > > deprecated naming so not to fail on the legacy DTS-files passed to the
> > > > > > newer kernels.
> > > > > >
> > > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > ---
> > > > > >  drivers/usb/dwc3/dwc3-qcom.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > > > > index c703d552bbcf..49ad8d507d37 100644
> > > > > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > > > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > > > > @@ -630,7 +630,8 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
> > > > > >         struct device           *dev = &pdev->dev;
> > > > > >         int                     ret;
> > > > > >
> > > > > > -       dwc3_np = of_get_child_by_name(np, "dwc3");
> > > > > > +       dwc3_np = of_get_child_by_name(np, "usb") ?:
> > > > > > +                 of_get_child_by_name(np, "dwc3");
> > > > > 
> > > > 
> > > > > Is there some reason using compatible instead wouldn't work here?
> > > > 
> > > > I don't know for sure. The fix has been requested in the framework of
> > > > this discussion:
> > > > https://lore.kernel.org/linux-usb/20201020115959.2658-30-Sergey.Semin@baikalelectronics.ru/#t
> > > > by the driver maintainer Bjorn. To get a firm answer it's better to
> > > > have him asked.
> > > 
> > > My feedback was simply that it has to catch both cases, I didn't
> > > consider the fact that we have a compatible to match against.
> > > 
> > > > As I see it having of_get_compatible_child() utilized
> > > > here would also work. At least for the available in kernel dt-files.
> > > > See the affected dts-es in:
> > > > https://lore.kernel.org/linux-usb/20210210172850.20849-11-Sergey.Semin@baikalelectronics.ru/
> > > > 
> > > > A problem may happen if some older versions of DTS-es had another
> > > > compatible string in the dwc3 sub-node...
> > > > 
> > > 
> > > Afaict all Qualcomm dts files has "snps,dwc3", so you can match against
> > > that instead.
> > 
> > Ok then. I'll replace of_get_child_by_name() here with
> > of_get_compatible_child() matching just against "snps,dwc3" in v7. Can you
> > confirm that noone ever had a Qcom-based hardware described with dts having
> > the "synopsys,dwc3" compatible used as the DWC USB3 sub-node here? That
> > string has been marked as deprecated recently because the vendor-prefix
> > was changed sometime ago, but the original driver still accept it.
> > 
> > Alternatively to be on a safe side we could match against both
> > compatibles here as Rob suggests. What do you think?
> 
> Bjorn, any comment on the question above? So I could respin the series
> with this patch updated.
> 
> Also note, since the patch's gonna be changed I'll have to remove your
> Reviewed-by tag unless u explicitly say I shouldn't.
> 

Sounds good, I'd be happy to review the new patch.

PS. As this only affect the Qualcomm part of the series I would suggest
that you send these patches off separate and don't send all 10 patches
together.

Thanks,
Bjorn
