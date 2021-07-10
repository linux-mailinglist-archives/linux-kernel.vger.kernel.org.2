Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D973C3225
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 05:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhGJDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhGJDQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 23:16:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28405C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 20:13:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so11550893otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D2/Au7VaseimhuhhJwLg2yXBVIiRM0wy8fddWmx2Lg4=;
        b=MGHpYGTvVEgEFsRtHucZchqHBpfrG9awMe48Awe/WAAcmDrW/gQGlO5z5U9gHTyuES
         +BpX3XwuVxIR9odq5jAeC8XF2sT4HJLmypaOqaLzCeVSfBSLZNziuxXAJrMDLHMfuwYk
         irAB/s5GOZXgLyYrRGZFkE/ZVKkfe6uPH8LICxavVbZEzq0t4cONlgbuC/9Fdx2/KbaH
         B0ZXsCaTdwd+7oNMyeFYXZAOGjgGLZ8VKxrApHpiCV1KCg8xbHPxzF73IScZsNWPWIxj
         rJ57RjPzJ2Juw5wd2Ueey65PJIrpmFFavvxU4RKqLS0NC0KfD2bbaTp13tP4zMDP7dNr
         aLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2/Au7VaseimhuhhJwLg2yXBVIiRM0wy8fddWmx2Lg4=;
        b=FfgVn90g5vI9uVazhHFRLxA1gK9VPbdQszcPDmpOe6GwPJy5A2yydbtrE/nTCp14+n
         yHHKCz7XaE54pfpDX+R2c5jJR9uDaoy00Bd3zhiVcQVbjOrCo8q1EAxW8dB8+ftF9hbA
         Y5Topd6AIvovs6/rRkzAmd5F9Ln8E5/gXT+mOz625C8j8ilTXDrh01H6XKHmjbLlLWv1
         giOuy9LSRIcwz2d7acEQ+sXte2L18Z3WAwJOW3koeCJPIEkwb0DbUyDxJ383j5CHPsDS
         5kDvVLEV4Hv1sBxKLxeG0Oy3gUTZu6W62yR/TDxLmzavxGaaZ4DnwhEQ1J87HPN7sdfZ
         bcYA==
X-Gm-Message-State: AOAM5326oWnXt3Nmf51TsXnxi110/YfZsZw70P8Mckww+Tv5acy2do8r
        93LIz+vBjGcmI4VxVYo3e8buug==
X-Google-Smtp-Source: ABdhPJy15VgTgdSDdAw23jwT5C34wukcHFZcKs5Shy0thIg10hPpd1ref+uvlNItcjtIKV0tm6UO/w==
X-Received: by 2002:a9d:77c6:: with SMTP id w6mr8117447otl.123.1625886802556;
        Fri, 09 Jul 2021 20:13:22 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v2sm1604837ots.8.2021.07.09.20.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 20:13:22 -0700 (PDT)
Date:   Fri, 9 Jul 2021 22:13:20 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document SDX65 platform and
 boards
Message-ID: <YOkQUED397xH+RlB@yoga>
References: <20210709200506.20046-1-quic_vamslank@quicinc.com>
 <20210709200506.20046-2-quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709200506.20046-2-quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 15:05 CDT 2021, quic_vamslank@quicinc.com wrote:

> From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>
> 
> Document the SDX65 platform binding and also the boards using it.
> 
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 174134f920e1..bdf1da8fc557 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -41,6 +41,7 @@ description: |
>          sdm660
>          sdm845
>          sdx55
> +        sdx65
>          sm8250
>          sm8350
>  
> @@ -174,6 +175,11 @@ properties:
>                - qcom,sdx55-mtp
>            - const: qcom,sdx55
>  
> +      - items:
> +          - enum:
> +              - qcom,sdx65-mtp
> +          - const: qcom,sdx65
> +
>        - items:
>            - enum:
>                - qcom,ipq6018-cp01-c1
> -- 
> 2.32.0
> 
