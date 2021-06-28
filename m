Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EE3B6A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhF1VaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbhF1V03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:26:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8638C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 14:23:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v13so9686396ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=beDcbwnP5As/mpTZp4157m7lhvaIkwus448ktxDYZvw=;
        b=hWBO2BGhHo4wGkJVLXWZrYlXf4KDPCrSBwu9CLS9i1uqZziusrG8bjJ9mhC2Gvqo5U
         /9D563iCVi95+zuDP6wh8g98G0A1nr54k9YZIqal45xzZx/Sfu6Cq+WGvFHtcpRh9CmK
         p1i4f38U+srKWyf3c+pGv9BuT7Vfe4zLq5qtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=beDcbwnP5As/mpTZp4157m7lhvaIkwus448ktxDYZvw=;
        b=Ks6THP9PtJehBazRHJZ+IK9VIyarflhR2khHhzaI+9x9/iVd64e3dGaRZziHbI+bkD
         RwqC1w/eJ/8162Ghz/jyW08+AVTFZJbYx9Ifv4Fa294zJCUHZhrc5HTIo7ctENVyJlH1
         hdOsxUMl3S/nQwMn9JBZXECgLizHfMcsACVuUOGNH7eQO4W3ybkdvke3kaGFA1r3S3my
         xJUCiK69GXWZ4bAs9iHDOErx1Dm3vZimTEKAon1j4d8/Dpgw5u/6nM9qx4iyDco7gcYG
         doXZXA/Amel3gzeYNPWUoLsuRaxPFwxq0mVnCH61FcaFQB4CKzRxcJdVgK9i4Xn/MfRc
         fmVg==
X-Gm-Message-State: AOAM530035CSNTbJ8weMN5EHL1PixV2g7+BE4y0Rd/MBEcBtF+9wyV5K
        OaXSTT6D7P+bvxPosnN4PIKeAg==
X-Google-Smtp-Source: ABdhPJzWVQZwXtcZku9Aom+JoyFe8QXif5vNo/7e47b/swit2rYKntKf8tytD9UEe1i5oQdJKiBXnQ==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr39170373pjb.133.1624915438390;
        Mon, 28 Jun 2021 14:23:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:df70:d2d8:b384:35cf])
        by smtp.gmail.com with UTF8SMTPSA id j2sm15093743pfi.111.2021.06.28.14.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 14:23:57 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:23:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Subject: Re: [PATCH v8 6/6] usb: dwc3: qcom: Keep power domain on to support
 wakeup
Message-ID: <YNo97HQXmYjUNz/C@google.com>
References: <1624882097-23265-1-git-send-email-sanm@codeaurora.org>
 <1624882097-23265-7-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1624882097-23265-7-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:38:17PM +0530, Sandeep Maheswaram wrote:
> If wakeup capable devices are connected to the controller (directly
> or through hubs) at suspend time keep the power domain on in order
> to support wakeup from these devices.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
> Checking phy_power_off flag instead of usb_wakeup_enabled_descendants 
> to keep gdsc active.
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 82125bc..ba31aa3 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_domain.h>
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> @@ -355,9 +356,15 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
>  	u32 val;
>  	int i, ret;
>  
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> +	struct generic_pm_domain *genpd = pd_to_genpd(qcom->dev->pm_domain);
> +
>  	if (qcom->is_suspended)
>  		return 0;
>  
> +	if (!dwc->phy_power_off && dwc->xhci)
> +		genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> +
>  	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>  	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>  		dev_err(qcom->dev, "HS-PHY not in L2\n");
> @@ -382,9 +389,15 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
>  	int ret;
>  	int i;
>  
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> +	struct generic_pm_domain *genpd = pd_to_genpd(qcom->dev->pm_domain);
> +
>  	if (!qcom->is_suspended)
>  		return 0;
>  
> +	if (dwc->xhci)
> +		genpd->flags &= ~GENPD_FLAG_ACTIVE_WAKEUP;
> +
>  	if (device_may_wakeup(qcom->dev))
>  		dwc3_qcom_disable_interrupts(qcom);
>  

This is essentially the same as v7, which Felipe NAKed
(https://patchwork.kernel.org/project/linux-arm-msm/patch/1619586716-8687-6-git-send-email-sanm@codeaurora.org/)

I think Felipe wants to see the handling of the power domain in the
xhci-plat driver. One problem here is that the power domain is owned
by the glue driver. For dwc3 the glue device is the parent of the xHCI
device, this is also the case for some other drivers like histb or
cdns3, but I'm not sure if it is universally true. If it isn't
xhci-plat could only make use of dev->parent->pm_domain for certain
compatible strings.

One could argue that it isn't very clean either if xhci-plat manipulates
a resource of it's parent. At the same time the glue driver isn't
supposed to check for the wakeup capable devices, so I guess some kind
of trade-off needs to be made.
