Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068DD316AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhBJQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBJQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D5C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:13:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so2305888wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9EqkICeAqFea9hutcJE8LTJk6fkCLGfHmOvQQmMvAJM=;
        b=Hh49I+GceO/gmkekotuymhn3rjlU3YIypVisjoLOygTP1mgYBpzmbiY1B+Z5kDHv1H
         X+1p+H/pZbOPlldO65mL33J/nmB6ms47MC+u60d9S34oT4MiRfwDpZZWh/qETmt/Om/y
         olUsvQGKt/zp/HREvWDezf3EVhY9WQSBDq//vrYo+RtlXuw1teA/flfEzF4rT2UCYUo6
         WEyPCuv9rP7JAXB7hd4Zk5CXQfiPo2bj7YDV4C/V4SfKbO6gG7O8nWSxiVamK32i6r03
         Vi1DcAM4Whf1JnAWKjVWawTmQnF73oyA7TPneeQ1mIDpdIwY/evQfcTuEdgRAkLg3tZr
         f/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9EqkICeAqFea9hutcJE8LTJk6fkCLGfHmOvQQmMvAJM=;
        b=o1YCLjAALQJHvB+wZfiSkZBI/Br+dfLybuqSmUFU59umh7gKhEYxNcPs1kR4osC0lx
         yzfYdoE9wj0pn/oFyvpPQJpDFgMPkhn2XR+5SDZQXQIM8H8bBoWsayAKI8iBKr5uIj6C
         9kk1ddL6ZkkvvQVqvKKUHP/II4za9F1zbDilkOegoUU2V6H0pkedHMA8P8+BnI5RDJVI
         tuhb0DEEFbWFzUcNW8DE2SXM/MUf5wa5hdzNN2ljp9LP9r/LScfB1cY+EqVBdgNqXr+P
         KjTNX9PMfHR/primnmPxaIXSskp+a69mWCIgGOccAVgFFrElmjPdt/INZVRQrVvIY0H4
         ALYg==
X-Gm-Message-State: AOAM5304rOmPdq1AxEXV0Fead5xAMqdsRV4ej8BYlb2wmqYU67GnaNEi
        F0jg/Cx85+zjIb6YbnMGlSVHzQ==
X-Google-Smtp-Source: ABdhPJxwjN9tnOjYE29ii/KagRZk+egL7JyD+GF9hT3oJWkCY7DOqROK+nqMjm3eItHTGs95G9LYOA==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr3432179wmi.111.1612973581930;
        Wed, 10 Feb 2021 08:13:01 -0800 (PST)
Received: from x1 ([91.110.221.237])
        by smtp.gmail.com with ESMTPSA id x9sm3275333wmb.14.2021.02.10.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:13:00 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:12:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        kernel-janitors@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: use getter/setter functions
Message-ID: <20210210161258.GA124276@x1>
References: <20210209211325.1261842-1-Julia.Lawall@inria.fr>
 <20210210082341.GH220368@dell>
 <YCPbxSHWMipTz+mB@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCPbxSHWMipTz+mB@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Daniel Vetter wrote:

> On Wed, Feb 10, 2021 at 08:23:41AM +0000, Lee Jones wrote:
> > On Tue, 09 Feb 2021, Julia Lawall wrote:
> > 
> > > Use getter and setter functions, for platform_device structures and a
> > > spi_device structure.
> > > 
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > > 
> > > ---
> > >  drivers/video/backlight/qcom-wled.c                                  |    2 +-
> > 
> > This patch is fine.
> > 
> > Could you please split it out and submit it separately though please.
> 
> Or just apply the entire patch through backlight tree, there's nothing
> going on in fbdev anyway I think.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I can do that.  Is that an fbdev Ack?

> > >  drivers/video/fbdev/amifb.c                                          |    4 ++--
> > >  drivers/video/fbdev/da8xx-fb.c                                       |    4 ++--
> > >  drivers/video/fbdev/imxfb.c                                          |    2 +-
> > >  drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c |    6 +++---
> > >  drivers/video/fbdev/omap2/omapfb/dss/dpi.c                           |    4 ++--
> > >  drivers/video/fbdev/omap2/omapfb/dss/dsi.c                           |    4 ++--
> > >  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c                         |    2 +-
> > >  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c                         |    2 +-
> > >  drivers/video/fbdev/xilinxfb.c                                       |    2 +-
> > >  10 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > ...]
> > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > index 3bc7800eb0a9..091f07e7c145 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -1692,7 +1692,7 @@ static int wled_probe(struct platform_device *pdev)
> > >  
> > >  static int wled_remove(struct platform_device *pdev)
> > >  {
> > > -	struct wled *wled = dev_get_drvdata(&pdev->dev);
> > > +	struct wled *wled = platform_get_drvdata(pdev);
> > >  
> > >  	mutex_destroy(&wled->lock);
> > >  	cancel_delayed_work_sync(&wled->ovp_work);
> > 
> > For my own reference (apply this as-is to your sign-off block):
> > 
> >   Acked-for-Backlight-by: Lee Jones <lee.jones@linaro.org>
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
