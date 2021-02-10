Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0163160EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhBJIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhBJIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:24:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44131C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:23:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r21so1424986wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MJzRoK5AHHgr8V25vpyceNTWmZxiFyKsyjhqQm8Vxxc=;
        b=d/b3ponHrtEaGh9+nR4CHVGjqOHtnpraE5raOOOMutWd3Y/vW/uw1i/PmwjfcCAOlI
         hSBPogoT7cAULj0g3PmoKbO+SoDAWMPSOECHnT1Hf4DW/HG3NgCZs5Oz4yycpbsGpbXz
         6aDc3GNQtnk1ZzXHSwQCVv4LOVj0FL2tcZrnkEKPH22CeUw6azGEwO6gqPhOeo/UTzC8
         CAGMYMu0CibvYCRJgy2fuPg3TqVZbhGt5gHufNtUof0Gw0FDR3KgWX5KWtTvRU2bJCB3
         6J8LXoac3H1R5/6ZWZ8wIHim0sOUZG312tHezmcG2vA/YZDFQNq2NLrC7BlZj/TPwF8d
         LG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MJzRoK5AHHgr8V25vpyceNTWmZxiFyKsyjhqQm8Vxxc=;
        b=BssVlLqQbaEHRUnxNEa4+v8buAwhgVLqtLMkw6JL7/aPpCRDThpBjE4//czqLgREyZ
         XJQaAnCaaIcibcJmeOXkX9m5wgZ/Syx7JXCw+9iMjvh7ZYe3CEoZE+bQfgE23gj2A/3q
         Sm/QRFrFiSfsA/0LumIDG5NrjnH7o/xkTrDIDqC3W5KQrIW5u9euSzI+QIlPnE8X5PQd
         R4/rvjwPI3UTR0uTw1xXe1dviT62sq+GRM+ngYVqzD9HV0jlwIuGZlVXdgkhj9eX73Sf
         10hlfr5pQ/UWm5/NJj4AymhRlv2TC21rkK1aDvx9B9yim4vN2MSXZ6xGplY2Ms1+0rKG
         VX/g==
X-Gm-Message-State: AOAM532hiYP2FrgOUQt7fVWrKjw/pw+wdDxn8ZLOB+mHyGsTBrGbjyWQ
        1VR+UWuPI+kj0vl6NtR2izUPBw==
X-Google-Smtp-Source: ABdhPJzpmLKGtf/B7RhbJlQwrCAP0Mb8Tyioqci54O7y0v57o4U82PROFirmSWr5+lJk79X2A0kouQ==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr2236419wry.184.1612945423966;
        Wed, 10 Feb 2021 00:23:43 -0800 (PST)
Received: from dell ([91.110.221.237])
        by smtp.gmail.com with ESMTPSA id h9sm1850897wrc.94.2021.02.10.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:23:43 -0800 (PST)
Date:   Wed, 10 Feb 2021 08:23:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Fabio Estevam <festevam@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] video: use getter/setter functions
Message-ID: <20210210082341.GH220368@dell>
References: <20210209211325.1261842-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209211325.1261842-1-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021, Julia Lawall wrote:

> Use getter and setter functions, for platform_device structures and a
> spi_device structure.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/video/backlight/qcom-wled.c                                  |    2 +-

This patch is fine.

Could you please split it out and submit it separately though please.

>  drivers/video/fbdev/amifb.c                                          |    4 ++--
>  drivers/video/fbdev/da8xx-fb.c                                       |    4 ++--
>  drivers/video/fbdev/imxfb.c                                          |    2 +-
>  drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c |    6 +++---
>  drivers/video/fbdev/omap2/omapfb/dss/dpi.c                           |    4 ++--
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c                           |    4 ++--
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c                         |    2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c                         |    2 +-
>  drivers/video/fbdev/xilinxfb.c                                       |    2 +-
>  10 files changed, 16 insertions(+), 16 deletions(-)

...]

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3bc7800eb0a9..091f07e7c145 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1692,7 +1692,7 @@ static int wled_probe(struct platform_device *pdev)
>  
>  static int wled_remove(struct platform_device *pdev)
>  {
> -	struct wled *wled = dev_get_drvdata(&pdev->dev);
> +	struct wled *wled = platform_get_drvdata(pdev);
>  
>  	mutex_destroy(&wled->lock);
>  	cancel_delayed_work_sync(&wled->ovp_work);

For my own reference (apply this as-is to your sign-off block):

  Acked-for-Backlight-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
