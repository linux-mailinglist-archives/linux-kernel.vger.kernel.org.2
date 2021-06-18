Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3663AD0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhFRRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhFRRMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:12:50 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:10:39 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t40so11262211oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k3dCTAx8gsxYWttzI5w/2kvcBcr5PpHulEpa3/adkDQ=;
        b=hnQvz5GcAocFRPbIJujGLDG4eBFw0HqJKa5nLawSj00bb7ilY+CXgSEpOVsDaedRSP
         nvqR+bpdtepuJfc2w8FgKsknrZSuXM+qS60qhfJ8zPrNj/R6r9vV+OMzMONiBmKoCffY
         Jfmxz/foT3Mz3YVSRyWptX1dxDavjGBpZxQnzIYO113u71JFlidz2qeIBF9Bhvv99PSL
         lGXab/Wrk6sqw6ClhXyHnzhq4EJo6Dh+hLdSuor8FSTq49vpWerXomxVpX6iWVS8J4Bq
         bQs+ejtuVOb9iMoGvlNSNuzrhuva7/cqiwDewUXOO50nviHqTfx+P7hd98w+IhXnlDkc
         78Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3dCTAx8gsxYWttzI5w/2kvcBcr5PpHulEpa3/adkDQ=;
        b=Fy7VmPa7Aq0YrJ5MH2lKJzt54j+XMsVGCqSLerBV+IdXcoin2oCf26AWqQFHNUG75M
         gVhX4oF58Cok99aBq/LSRjTZByTvdu1Wcs/jYQDkB8st44ayn/vDuUzMEaPNVZbn1njl
         LQwS/WYDJUExsnUsx/SpdcaCBvGjaiJP/eRx1pMiMV85lTOucrcyP4q6rjsDMx6+azC+
         dActJKWlyapTTIy/pRz8Bg535r4JXAhI3idSdWFcWlX3spzInnLC6rkUJEpEbr2So7SZ
         XPma5GDyUM3UDHzOb9pYZTtttRkij4hgLa/urYqnaP/mV8dQNWRnqooU/LvWWdWetGo+
         /l1g==
X-Gm-Message-State: AOAM533+G59zbniU7tqJkrGfugMv41SkUk3p4kdl3cboIix9GIgURCNQ
        HV+mY0ssau50Axa4k/ED+76e+g==
X-Google-Smtp-Source: ABdhPJz2JqjVInbgOzS0fbJn/rC7XmTTYrZWwJ7ACJfaK4TzHnn0J4ERNDokznMNi1r4F8DruMQclw==
X-Received: by 2002:aca:53ca:: with SMTP id h193mr15030468oib.69.1624036239039;
        Fri, 18 Jun 2021 10:10:39 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x29sm2066218ott.68.2021.06.18.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:10:38 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:10:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: qcom: geni: move struct geni_wrapper to
 header
Message-ID: <YMzTjMNNCR9bsvfu@yoga>
References: <20210618141839.3777270-1-vkoul@kernel.org>
 <20210618141839.3777270-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618141839.3777270-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Jun 09:18 CDT 2021, Vinod Koul wrote:

> SPI & I2C geni driver needs to access struct geni_wrapper, so move it to
> header. The drivers needs this header to find the geni device and use it
> in dma mapping.
> 

How does this differ from engine->dev->parent?

> Using this method works for both DT and ACPI systems
> 

I was under the impression that the wrapper and engines are describe
completely independently in ACPI, so we don't have a link between them.

If that's not the case, then I guess that answers the above question
about ->parent.

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 14 --------------
>  include/linux/qcom-geni-se.h    | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index fe666ea0c487..08d645b90ed3 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -78,20 +78,6 @@
>   */
>  
>  #define MAX_CLK_PERF_LEVEL 32
> -#define NUM_AHB_CLKS 2
> -
> -/**
> - * struct geni_wrapper - Data structure to represent the QUP Wrapper Core
> - * @dev:		Device pointer of the QUP wrapper core
> - * @base:		Base address of this instance of QUP wrapper core
> - * @ahb_clks:		Handle to the primary & secondary AHB clocks
> - * @to_core:		Core ICC path
> - */
> -struct geni_wrapper {
> -	struct device *dev;
> -	void __iomem *base;
> -	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> -};
>  
>  static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  						"qup-memory"};
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 5114e2144b17..5fda675c5cfe 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -38,6 +38,20 @@ struct geni_icc_path {
>  	unsigned int avg_bw;
>  };
>  
> +#define NUM_AHB_CLKS 2
> +
> +/**
> + * @struct geni_wrapper - Data structure to represent the QUP Wrapper Core
> + * @dev:		Device pointer of the QUP wrapper core
> + * @base:		Base address of this instance of QUP wrapper core
> + * @ahb_clks:		Handle to the primary & secondary AHB clocks
> + */
> +struct geni_wrapper {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +};
> +
>  /**
>   * struct geni_se - GENI Serial Engine
>   * @base:		Base Address of the Serial Engine's register block
> -- 
> 2.31.1
> 
