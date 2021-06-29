Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE83B79AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhF2VIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhF2VIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:08:04 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1D4C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:05:36 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a133so325395oib.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+qm+5rKSIxSb2pA2xlIn0/txUGCpUQJ4ebyGwBBltc=;
        b=go2pqgdjoBHcGVFwtYdsPAVRkF29K2h0MJWiVHvpabrFlE3jVS20PCrvUEGUoThwyy
         VXYYx8cZvsS7IpMm/Ho1MmEuGXIYOXRxK2oFbEIHkgHzjOHXT/BYTKRhJs//9gjwK14U
         rMsicuDZ8rwEnLh+bPLpJBogqm1ESw1vVVAYRk0Dka/3iutN1hJ/9H67asO61ln7IqXu
         Ll08pzP2x44ijAKWszqC9HjBEFT5AFgfNRrsUYx5QZ7yLlcDQgmiqjIHMJ8uRAnu4WLL
         paRXe1Eotvz7BTSKeutk2fi+EB5O+CyaFZV9EsfIr5u2QWdepIAztsKIik47FqW8PP1N
         S7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+qm+5rKSIxSb2pA2xlIn0/txUGCpUQJ4ebyGwBBltc=;
        b=KTxPJyV3NRT+yFvwfHZqKDV7KeZPcaCkkVmpsBFgRFyrgLbIcX7sQOyAyZL4B8S3xR
         Xisb6fZ2UmNaOO/RHlg6N35CfkXFgiXwue9eZ9qWnBVYCghIYo3V14qjQ2acyCsEAwEj
         MEoHnCcQh8BNkJmY+w2fxjDu+4d01LAHEynqsZKwBScWFhNHVqKUg3s40+wwIXG24OLS
         ZdUG61hTw7v9q+HwFA/nUSHV98IHl201ukh3UfwXqJzDIrHR5t1gHsrcJG7/aYcRAk3U
         t9gC+Od7pcghJhpX+W4GpGWRtHLqITMTDsNHh0D2ZeUnWwRM6jW5tP92rU1FalrgES2b
         kDlA==
X-Gm-Message-State: AOAM530yfyigLaT3Gy5poy19IfnQ8H+9zw+gQlgAh132HbaMQZzCsKdU
        WLKBms2XTcvzwx6QMdgLYQWnrg==
X-Google-Smtp-Source: ABdhPJwU0+6rFdHYA2wBJuyHlCFAl+6T7M+7GmvpDmTLHExf/AmbdNW7nfg6Xg2F7jN+Q5Sb1y8fHQ==
X-Received: by 2002:aca:d60a:: with SMTP id n10mr11617275oig.20.1625000735886;
        Tue, 29 Jun 2021 14:05:35 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s12sm4036129otd.73.2021.06.29.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:05:35 -0700 (PDT)
Date:   Tue, 29 Jun 2021 16:05:33 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: Ensure regulator init state matches
 GDSC state
Message-ID: <YNuLHWkUwyml26Uk@yoga>
References: <20210625225414.1318338-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625225414.1318338-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25 Jun 17:54 CDT 2021, Bjorn Andersson wrote:

> As GDSCs are registered and found to be already enabled
> gdsc_toggle_logic() will be invoked for votable GDSCs and ensure that
> the vote is matching the hardware state. Part of this the related
> regulator will be enabled.
> 
> But for non-votable GDSCs the regulator and GDSC status will be out of
> sync and as the GDSC is later disabled regulator_disable() will face an
> unbalanced enable-count, or something might turn off the supply under
> the feet of the GDSC.
> 
> So ensure that the regulator is enabled even for non-votable GDSCs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37416e554961 ("clk: qcom: gdsc: Handle GDSC regulator supplies")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 51ed640e527b..f7e7759cdb90 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -359,10 +359,17 @@ static int gdsc_init(struct gdsc *sc)
>  
>  	/*
>  	 * Votable GDSCs can be ON due to Vote from other masters.
> -	 * If a Votable GDSC is ON, make sure we have a Vote.
> +	 * If a Votable GDSC is ON, make sure we have a Vote. If
> +	 * non-votable, ensure that the supply is kept enabled (as
> +	 * is done by gdsc_enable).
>  	 */
> -	if ((sc->flags & VOTABLE) && on)
> +	if ((sc->flags & VOTABLE) && on) {
>  		gdsc_enable(&sc->pd);
> +	} else if (on) {

I somehow lost the check for sc->rsupply != NULL while trying to make
this readable. In other words, this is broken.

Regards,
Bjorn

> +		ret = regulator_enable(sc->rsupply);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	/*
>  	 * Make sure the retain bit is set if the GDSC is already on, otherwise
> -- 
> 2.29.2
> 
