Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452533AB0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhFQKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFQKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:07:02 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C860C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:04:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id b1so2673133vsh.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yc3v3gAfLxnXDzM8KeyqkmyumlBhFvvZJHDrxz2cMIU=;
        b=sI3eyR4FhUDZbzi6XsgSlIBX6O2vmLnEK0oMfoI5SmlPbHNO3BoVwb5qyzvxgc+vuC
         R7A1svAj17X/tiWOml6tNAQV84dFmYoffEbhD6MnqZ4aVe62FVO4EJ5JPZgvTCs7KIIH
         85Ehn7kD/Fp2EkJr8XwNVq23CxYCenQORBAcGvkxncV/nsZFeHTfEPDQ2/k19MPJfUU1
         j2q6v5bcOb79E7u4QdV5cVVm6cFK5q8aQqFlOupvLSzeKUeFAQFHQeAmoZMS7Ag2iuG7
         vDdudKcblojjxBs6c62twU8w/fVSumeLeBNbF9Fb/Zux+HkWPcrZWqL6yxQoFAjaxRcJ
         atZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yc3v3gAfLxnXDzM8KeyqkmyumlBhFvvZJHDrxz2cMIU=;
        b=KZM/HEJJr04lerStQG3ROUMx04cf00WdhxDhEEg75RWLiQxKiB4SNjf0nl8CJJJ80Q
         ET/P8Ia2VMNvfOyZz41zvoJqkK05sTZa3DwbHuOgnbzj5jVIrAKgidsohcswQJOLX+nr
         svXi67gsuFUiaZ0Mtj6hiP9tBrcBowsBTpcGaqNSW0EQXwfLoDCOXHgL8eFFG1ra+KSJ
         VY/OkItVfywyLV/KNV+Dyrnd3Ae36wF/pN/9v4y/50UTxm7JXOfhb4AY8fMrS0RMFX3q
         +N0OiQq77AF6sHb77JQFq3PR+Nl4jKOXcLEdT5/x2243CxNnSUV59J++yP36odQKaTE9
         P5Sw==
X-Gm-Message-State: AOAM532VhfFoVGoD9BVW6O6hqcLQ6n9G0YC5XvrFKWQ13wutAJPsnGtO
        5mn6fqNG1jDkWzydZZoq4bLBHNPI1VPHFUyHfZ8UrKEMKyDbbg==
X-Google-Smtp-Source: ABdhPJw29hnXb1KQzO/v8lJ0U0DUEo8Sjzq3oZXt2JE/qO1kK7A4zJfyHhgbucCOZ9JfQCjRKnVQTqu7QMYJQLRCEUQ=
X-Received: by 2002:a05:6102:386:: with SMTP id m6mr3631602vsq.48.1623924293206;
 Thu, 17 Jun 2021 03:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210603182242.25733-1-rashmi.a@intel.com> <20210603182242.25733-2-rashmi.a@intel.com>
 <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
In-Reply-To: <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 12:04:17 +0200
Message-ID: <CAPDyKFpTf8DvauD17JR+jMH1TypgPiNs86k3YtaD4g10fRp65Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvigJxQQVRDSOKAnSAxLzJdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBVc2UgY2xvYw==?=
        =?UTF-8?B?ay1mcmVxdWVuY3kgcHJvcGVydHkgdG8gdXBkYXRlIGNsa194aW4=?=
To:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     rashmi.a@intel.com, linux-drivers-review-request@eclists.intel.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org, Mark Gross <mgross@linux.intel.com>,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 08:13, Michal Simek <michal.simek@xilinx.com> wrote:
>
>
>
> On 6/3/21 8:22 PM, rashmi.a@intel.com wrote:
> > From: Rashmi A <rashmi.a@intel.com>
> >
> > If clock-frequency property is set and it is not the same as the current
> > clock rate of clk_xin(base clock frequency), set clk_xin to use the
> > provided clock rate.
> >
> > Signed-off-by: Rashmi A <rashmi.a@intel.com>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/mmc/host/sdhci-of-arasan.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> > index 839965f7c717..0e7c07ed9690 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -1542,6 +1542,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     sdhci_get_of_property(pdev);
> > +
> >       sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
> >       if (IS_ERR(sdhci_arasan->clk_ahb)) {
> >               ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
> > @@ -1561,14 +1563,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >               goto err_pltfm_free;
> >       }
> >
> > +     /* If clock-frequency property is set, use the provided value */
> > +     if (pltfm_host->clock &&
> > +         pltfm_host->clock != clk_get_rate(clk_xin)) {
> > +             ret = clk_set_rate(clk_xin, pltfm_host->clock);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "Failed to set SD clock rate\n");
> > +                     goto clk_dis_ahb;
> > +             }
> > +     }
> > +
> >       ret = clk_prepare_enable(clk_xin);
> >       if (ret) {
> >               dev_err(dev, "Unable to enable SD clock.\n");
> >               goto clk_dis_ahb;
> >       }
> >
> > -     sdhci_get_of_property(pdev);
> > -
> >       if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
> >               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
> >
> >
>
> Manish/Sai: Please retest this on Xilinx SOC.
>
> Thanks,
> Michal

I am about to queue this patch, but it would be nice to get your
confirmation and tested-by tags before doing so. Would that be
possible within the next couple of days?

Kind regards
Uffe
