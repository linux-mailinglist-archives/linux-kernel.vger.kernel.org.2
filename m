Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161B83AD1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhFRSCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFRSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:02:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA14C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:59:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10522324otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVHGU8UL0ivllVq4QmKUCdHkLLM91aC0SyFwcBY4ZK0=;
        b=upUbYE/rnkUa5QA0/Am+XWZ4mL791j4KAwuCyxzHwEnBvVAWemJZ2TUClk9mmdVCb/
         NCQ7nuMl4Ao5fhXsIU9In+O8UMdFdKkjI1RRdDkRCR4jrTGEi1jsJzbHMlSYqKmV3EaP
         0N/dC5CJ4Xz37eyemWoNOoHnlMh5Ji2gD27PdBzLwZbrtaY5KaogT2rvSEeJqNgaSnOh
         JwJ73MxG3ECdsoph11tFc0Yb5EfCH13XeXyYkSePzQDWHoGM0i8cfuXxv7Ri58TeoaoQ
         vvmENNpPuypx7jW1tmsXbUA+3xtVwDx/vWWABxWi5x3v11lmT1HIlAJ6tZX7G/P4Tuzb
         jCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVHGU8UL0ivllVq4QmKUCdHkLLM91aC0SyFwcBY4ZK0=;
        b=jibaBIZHTrfMlswkL5IGZfzBEI2rdOCCZAjTdKp7V45SIIbDLjwckp/daaX3rfRTIJ
         J/N9AQQ3ePeO4zkTM9pMPIdjrl8BA2Ck7+4tQX2IE6iUHBUXrNDQBs4Nev55MIVshn60
         OhvFRGYZ8U67WZCQ9sEfpjP1A/Eb09l2zDWgtqm1xUDHGrduoMEaG9ZgKQvvkrk3cxly
         YfTzvce9nFhsD8uXznsql5uRNmJCYM3SvOmHmOCzBXfKzREWF0CM99PwWHgiYtDvut9D
         5macXjxTHI6WEo4G9cPVxLy2N3mAOcqmwqy3McTkaxRsV/qk18lrvkwmj38TlWJnQ8Ym
         wUMg==
X-Gm-Message-State: AOAM530cR7mcQ5mBwDXTsRVQNcpr8wvHfRM7ocMinhzF9vUYRqJxzWCW
        M91kddvU+2gzP+Q6drkXnyrBTQ==
X-Google-Smtp-Source: ABdhPJyE/LoGz7LC2g8/j9RwBFj2bD0PC32nsa5vED9hZpvK22vsfpP+2VFSGWJqOtijPvdR2hpRpQ==
X-Received: by 2002:a05:6830:1598:: with SMTP id i24mr10536481otr.52.1624039195815;
        Fri, 18 Jun 2021 10:59:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h17sm1572922oop.21.2021.06.18.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:59:55 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:59:53 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: Arrange
 compatibles alphabetically
Message-ID: <YMzfGctdFGytohFQ@builder.lan>
References: <20210617053432.350486-1-bhupesh.sharma@linaro.org>
 <20210617053432.350486-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617053432.350486-2-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Jun 00:34 CDT 2021, Bhupesh Sharma wrote:

> Arrange the compatibles inside qcom-pmic gpio device tree
> bindings alphabetically.
> 
> While at it, also make some minor cosmetic changes to allow
> future compatible addition to the bindings simpler.
> 

I think we're rather close to getting the YAML binding sorted out, but
this patch does look good and doesn't hurt.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,pmic-gpio.txt       | 58 +++++++++----------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index f6a9760558a6..10f049e21264 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -7,10 +7,20 @@ PMIC's from Qualcomm.
>  	Usage: required
>  	Value type: <string>
>  	Definition: must be one of:
> +		    "qcom,pm660-gpio"
> +		    "qcom,pm660l-gpio"
> +		    "qcom,pm6150-gpio"
> +		    "qcom,pm6150l-gpio"
>  		    "qcom,pm8005-gpio"
> +		    "qcom,pm8008-gpio"
>  		    "qcom,pm8018-gpio"
>  		    "qcom,pm8038-gpio"
>  		    "qcom,pm8058-gpio"
> +		    "qcom,pm8150-gpio"
> +		    "qcom,pm8150b-gpio"
> +		    "qcom,pm8350-gpio"
> +		    "qcom,pm8350b-gpio"
> +		    "qcom,pm8350c-gpio"
>  		    "qcom,pm8916-gpio"
>  		    "qcom,pm8917-gpio"
>  		    "qcom,pm8921-gpio"
> @@ -22,20 +32,10 @@ PMIC's from Qualcomm.
>  		    "qcom,pmi8950-gpio"
>  		    "qcom,pmi8994-gpio"
>  		    "qcom,pmi8998-gpio"
> -		    "qcom,pms405-gpio"
> -		    "qcom,pm660-gpio"
> -		    "qcom,pm660l-gpio"
> -		    "qcom,pm8150-gpio"
> -		    "qcom,pm8150b-gpio"
> -		    "qcom,pm8350-gpio"
> -		    "qcom,pm8350b-gpio"
> -		    "qcom,pm8350c-gpio"
>  		    "qcom,pmk8350-gpio"
>  		    "qcom,pmr735a-gpio"
>  		    "qcom,pmr735b-gpio"
> -		    "qcom,pm6150-gpio"
> -		    "qcom,pm6150l-gpio"
> -		    "qcom,pm8008-gpio"
> +		    "qcom,pms405-gpio"
>  		    "qcom,pmx55-gpio"
>  
>  		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
> @@ -97,34 +97,34 @@ to specify in a pin configuration subnode:
>  	Value type: <string-array>
>  	Definition: List of gpio pins affected by the properties specified in
>  		    this subnode.  Valid pins are:
> -		    gpio1-gpio4 for pm8005
> -		    gpio1-gpio6 for pm8018
> +		    gpio1-gpio10 for pm6150
> +		    gpio1-gpio12 for pm6150l
> +		    gpio1-gpio4  for pm8005
> +		    gpio1-gpio2  for pm8008
> +		    gpio1-gpio6  for pm8018
>  		    gpio1-gpio12 for pm8038
>  		    gpio1-gpio40 for pm8058
> -		    gpio1-gpio4 for pm8916
> +		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
> +					     and gpio8)
> +		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
> +		    gpio1-gpio12 for pm8150l (hole on gpio7)
> +		    gpio1-gpio10 for pm8350
> +		    gpio1-gpio8  for pm8350b
> +		    gpio1-gpio9  for pm8350c
> +		    gpio1-gpio4  for pm8916
>  		    gpio1-gpio38 for pm8917
>  		    gpio1-gpio44 for pm8921
>  		    gpio1-gpio36 for pm8941
> -		    gpio1-gpio8 for pm8950 (hole on gpio3)
> +		    gpio1-gpio8  for pm8950 (hole on gpio3)
>  		    gpio1-gpio22 for pm8994
>  		    gpio1-gpio26 for pm8998
>  		    gpio1-gpio22 for pma8084
> -		    gpio1-gpio2 for pmi8950
> +		    gpio1-gpio2  for pmi8950
>  		    gpio1-gpio10 for pmi8994
> +		    gpio1-gpio4  for pmk8350
> +		    gpio1-gpio4  for pmr735a
> +		    gpio1-gpio4  for pmr735b
>  		    gpio1-gpio12 for pms405 (holes on gpio1, gpio9 and gpio10)
> -		    gpio1-gpio10 for pm8150 (holes on gpio2, gpio5, gpio7
> -					     and gpio8)
> -		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
> -		    gpio1-gpio12 for pm8150l (hole on gpio7)
> -		    gpio1-gpio10 for pm8350
> -		    gpio1-gpio8 for pm8350b
> -		    gpio1-gpio9 for pm8350c
> -		    gpio1-gpio4 for pmk8350
> -		    gpio1-gpio4 for pmr735a
> -		    gpio1-gpio4 for pmr735b
> -		    gpio1-gpio10 for pm6150
> -		    gpio1-gpio12 for pm6150l
> -		    gpio1-gpio2 for pm8008
>  		    gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10
>  					    and gpio11)
>  
> -- 
> 2.31.1
> 
