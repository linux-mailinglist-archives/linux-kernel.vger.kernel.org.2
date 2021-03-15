Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475C33C196
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCOQW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhCOQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:22:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264C4C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:22:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w34so19686947pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4OgT1op5pKi9FPa9H6iNM9XBtjK1+8GfQ3rJ+7I0hzg=;
        b=HPFxk1Zjce149T/5GYwsq4vVi8kl7RSBQGKUGvT9NymyCL5rp01UP+ZpzYZMmRE16S
         YRbQ0a+dbcjFaOLrI3Z/iCOPI9UJw/1Mmq8BqVjt5LeT2rzixpuYHVcKZdBNTxfg1vDe
         5Ot1ZXVlFg+HFGZLFoW8wepjsxCuuqh5IB2LmywdIODSk8EoXFu1Ctb3aWZ0OKcI2OIJ
         Ih5jrY6ATdw1GDi/K8ZFtT1+wC49lt/JSzL+PJXdCwPowLZaErwogcAetcnMy7o495Cz
         TZ9WOyfUXU/haFnwb4NLfk0y+lIASQnzn7eVpMgv2tu51NxucboE/FP0t2PLcZJs6576
         XeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4OgT1op5pKi9FPa9H6iNM9XBtjK1+8GfQ3rJ+7I0hzg=;
        b=B1iibcn0embQW6JsE/0JGf4SQE4KW+PHg00kd7bkdWQFPn4OQfddtlcVNvInIFMuO2
         1q6RghXglOETBm4AqcjLtyw8YwIoBDcUkrTMZBnQgH3wKQDslOr1mO5of9vz1Owkxxzf
         yEQRdOJx6Q+1bzPZDkpsQMCza4FP7f6hffp5h2xrxsH8CN7aFKv9z8wLOV5glyAqPdlO
         DGDdxWeK7ukjdGXUz2PsmKJ2Hnhp423rEXEffFBaZVCxPjVplddVAKmktrEjzoXWv3+g
         kpFFI9ShcCxE1e6exApS9/Pbd7gF7ncI9j23JFy1L6ZZ0AY1/pSkbkIh591tzqWz71LQ
         0iXg==
X-Gm-Message-State: AOAM533ILpwjlLIc+nsteVhnGxBFRH5vh0TAFrYcOFJgsijlcQrvO8bh
        IMD1hHRX7gLDFbKnxnQtjv7qig==
X-Google-Smtp-Source: ABdhPJwTkkx4r53sv5pqh1F/+EV63pgm09PHYplM3kJLusGQI94sZ6ELMpBINgkwEsze/alAmXWY8Q==
X-Received: by 2002:a63:c84a:: with SMTP id l10mr294989pgi.159.1615825346568;
        Mon, 15 Mar 2021 09:22:26 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d19sm81935pjs.55.2021.03.15.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:22:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:22:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Provide errors for
 firmware-name parsing
Message-ID: <20210315162224.GB1339147@xps15>
References: <20210312002605.3273255-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312002605.3273255-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:26:05PM -0800, Bjorn Andersson wrote:
> Failing to read the "firmware-name" DT property without informing the
> developer is annoying, add some helpful debug prints.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 66106ba25ba3..15abfbba78d2 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1661,8 +1661,10 @@ static int q6v5_probe(struct platform_device *pdev)
>  	mba_image = desc->hexagon_mba_image;
>  	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
>  					    0, &mba_image);
> -	if (ret < 0 && ret != -EINVAL)
> +	if (ret < 0 && ret != -EINVAL) {
> +		dev_err(&pdev->dev, "unable to read mba firmware-name\n");
>  		return ret;
> +	}
>  
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
>  			    mba_image, sizeof(*qproc));
> @@ -1680,8 +1682,10 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc->hexagon_mdt_image = "modem.mdt";
>  	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
>  					    1, &qproc->hexagon_mdt_image);
> -	if (ret < 0 && ret != -EINVAL)
> +	if (ret < 0 && ret != -EINVAL) {
> +		dev_err(&pdev->dev, "unable to read mpss firmware-name\n");
>  		goto free_rproc;
> +	}

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	platform_set_drvdata(pdev, qproc);
>  
> -- 
> 2.29.2
> 
