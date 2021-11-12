Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8844E480
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhKLKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbhKLKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:23:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B6C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:20:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z34so21129639lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+io7kYbw2ZDoJfwSHBLvGwSu+tVHeSA6Dhn302dCO0=;
        b=D6EwlExy0nQ+GvAvuyv5YvMgxsLd5ya7d5WFs7yoHksO0llgQTTSVUrLFYnoakskyh
         qeP/+pQ/MHD8Z53g2oSWcC7FVxsJAnvIRJNzTUWKgS+VV8NEou4uARi5Mdg53/l3ksOF
         4gmifQWUCt2LOvUnX0TfdLTwp+a4HvBkSbJiRJEbKWEmUkoxjQ96cWh7PUz4dc7bW2nY
         rvEFL3rLUnhR4DXVq716uWo1ru9aP2W0K2kcPDRLHznxLJupVB9tocYTRWTBebFO5+XS
         yPbYEcN1+50MUwiQIQkZeSJoOMHX1uQB0ziu3/HhSspkUFMt7aeY8FxOdZhrIdJJjZEk
         iR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+io7kYbw2ZDoJfwSHBLvGwSu+tVHeSA6Dhn302dCO0=;
        b=3iI2a4MJ8M4jklIjDRfejkxrji/90nP5b4hVyJaBaI7RrHsSwPmV00oIG+JGhdKDgl
         leexFY1jeJDsJvGFjog0oJ5msGs78R8cudaXn3tLwXTwXqn8hW4gX9bWvRXUkXC0N9Lt
         y0lC+Rp6wK0FRdz8X+0Dj0xLsZ24RoNlEZ/y8Qy4dAHdjOSwhiHeNgKc+LJlyvJhdNxZ
         bgd+o6ACFdGSgmi1UJ+pTyPpNEpSrsBoiGKERpAg+BvqYrRaOY0IpLTuFF0Y+I3pZGjK
         3Pvrmw0bxcNx34ZTAu3Rzo6fcVOESQt1MAktXDmAFQSmO/R6FFDW5Ir3BKRjXk6yfn0y
         IBRw==
X-Gm-Message-State: AOAM531eT6ByNHr5CnIr8piFBuDpcPWgGWYtJODL+u/L8P85dwySIzwU
        4r836Uc74oyppGE5uN58++9q4w==
X-Google-Smtp-Source: ABdhPJzxM6u2ytjQgL2yYEpg+7FWHLyHA570eFj8lDmWapgSbNaW8JIIXdQCNPE9o1P7S/7i2XbyoA==
X-Received: by 2002:ac2:5548:: with SMTP id l8mr12699531lfk.509.1636712442053;
        Fri, 12 Nov 2021 02:20:42 -0800 (PST)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id n7sm549952ljp.108.2021.11.12.02.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 02:20:41 -0800 (PST)
Subject: Re: [PATCH v5 06/22] dt-bindings: qcom-bam: Add "powered remotely"
 mode
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-7-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <6fb025fe-9b93-1bde-4b11-5759a6b2c0cf@linaro.org>
Date:   Fri, 12 Nov 2021 12:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211110105922.217895-7-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> In some configurations, the BAM DMA controller is set up by a remote
> processor and the local processor can simply start making use of it
> without setting up the BAM. This is already supported using the
> "qcom,controlled-remotely" property.
> 
> However, for some reason another possible configuration is that the
> remote processor is responsible for powering up the BAM, but we are
> still responsible for initializing it (e.g. resetting it etc). Add
> a "qcom,powered-remotely" property to describe that configuration.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> [moved Stephan's change to the YAML dt-binding format]
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>   Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> index cfff3a2286fb..bf0a59e8a2bf 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> @@ -73,6 +73,12 @@ properties:
>         Indicates that the bam is controlled by remote proccessor i.e.
>         execution environment.
>   
> +  qcom,powered-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the bam is powered up by a remote processor
> +      but must be initialized by the local processor.
> +
>     qcom,num-ees:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       minimum: 0
> 

after rebasing the change on top of master this particular patch won't be
needed anymore. See my review comment to v5 03/22.

--
Best wishes,
Vladimir
