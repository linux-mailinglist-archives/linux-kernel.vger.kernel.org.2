Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3F3FBE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhH3VaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhH3V3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:29:13 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:28:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y128so21745723oie.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWW/ngYDKJNHbc/3izYjMV42ez7lWh8GMqEHdYHK41k=;
        b=LTOS3AIjU/fMG9OubGJWGN0w2i1ObmwkMRbtiQJEr3rSpJd7VZNj7uRuUApL5gdIsc
         8QWS0ln8rHeWy0NvK8sADUzKDnRc84KChrv7FeTTVrSuYmDI42pFvlxRJIIIgGOJ6lhC
         i+dLZ6E66zm6jPUHmvcUt+d0cfHKPk+j8sFNzXpMW4EHJgEkzctsSV1LxZqrOKm/Id6q
         aRFf3Ith4g7rk+9lAMpCnzSforXls0NtPqR27yOsSdOmtCrGx2v+3UVJ6ZdyUbUjwzVv
         NEp6kYby9nRNB+XdDOLJ82Y/bmccYtUz9zxAroKAxdPmIi+AwkJ0VY7bBLjFWfmjJeHd
         q3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWW/ngYDKJNHbc/3izYjMV42ez7lWh8GMqEHdYHK41k=;
        b=k407ksPqRpw6q5g9CxjkMnc3bCqIyDUI3dhP+lVdO+RtA78cazDy6YO9RZzQM6xhd8
         ae1ML7bUSJ+Uy2wXGUtmOTOigyh69EW9rAHP5kFJ5fjIcr0qiJ2ao5Pu4ME0hAWUe1Vm
         0c745BZnNtG6/0Rnhh2nOtVvBERct3Jw18lw8towXhbJU2QpB9/pXEjq5D9R1VLf30Kx
         H8U3fuTK2Dvcx/RqKpzuu5Rmt8h2p5u7GYOvIkJO5MwGpvoX59qv1eVQ33gz9J1ZALSM
         tJNpbRbd+ZX5jSlI3vMWdT6WNUVQrRf5KDW9A1RnV+aRnY8rMl0dlSU+2V85N5KE06nQ
         axxA==
X-Gm-Message-State: AOAM533/FkMI4KW5fvxjkH8S1CSMCWu7H9OpiUFqjXtm6ESbWMKqZuqZ
        iWvwJCQs5ckHtBOnKGB7d4VWvzQhxXiJBg==
X-Google-Smtp-Source: ABdhPJxQaKR9VZXyTuQ+qlMYZCjuEXrqGCsPi9dzwkfWL0LU4LCvPlDmTwxK60pEtp5Smjo4uWirvQ==
X-Received: by 2002:a05:6808:7:: with SMTP id u7mr897581oic.63.1630358898186;
        Mon, 30 Aug 2021 14:28:18 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a15sm3467710otq.13.2021.08.30.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:28:17 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:28:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: qcom-msm8974: Add xo_board reference clock to
 DSI0 PHY
Message-ID: <YS1NbxhPrAPIQwk3@yoga>
References: <20210830175739.143401-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830175739.143401-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Aug 12:57 CDT 2021, Marijn Suijten wrote:

> According to YAML validation, and for a future patchset putting this
> xo_board reference clock to use as VCO reference parent, add the missing
> clock to dsi_phy0.
> 

And just to confirm on MSM8974 "ref" is supposed to be 19.2Mhz?

Regards,
Bjorn

> Fixes: 5a9fc531f6ec ("ARM: dts: msm8974: add display support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index db4c06bf7888..96722172b064 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1580,8 +1580,8 @@ dsi_phy0: dsi-phy@fd922a00 {
>  				#phy-cells = <0>;
>  				qcom,dsi-phy-index = <0>;
>  
> -				clocks = <&mmcc MDSS_AHB_CLK>;
> -				clock-names = "iface";
> +				clocks = <&mmcc MDSS_AHB_CLK>, <&xo_board>;
> +				clock-names = "iface", "ref";
>  			};
>  		};
>  
> -- 
> 2.33.0
> 
