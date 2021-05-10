Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B46379488
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhEJQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:48:13 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33432 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhEJQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:46:44 -0400
Received: by mail-oi1-f171.google.com with SMTP id b25so11120848oic.0;
        Mon, 10 May 2021 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9higqPKGrnY1IY6VuqVyaPGF4tW6YAqMC+KWAKz/f2M=;
        b=rq32SXBXW8fjKHsOr65AFdnn9c3HYKtDb7OrgNkQCsIFZi5OGzyFeGKhwKHZzL3rGq
         wjlOe0fAubW33SKQ9LGwR5gMZ8Vqc+JQ3tkbhEO85XLmJ0YjKRfXCree9q6rp0Jz7pCU
         8HPk+qMQXu52aFE9KuGCk7ZlLmDjUntRxj2uM7v/Y6llzigkqDO4r0FOIDql8d7Ruyd3
         uRG0UEcgg3RmnIS5k5LZBFK0Jibjl/janAAULx9Eq/BD0N7IfV/s5XO1Ba2M4Msq20gZ
         JE6RvF/QjAGzVDgfTxJ4Vq4JZALawin40VxKZwsh8a4WCn46ALmo1SIl3uwrsEvN1qe+
         tYdQ==
X-Gm-Message-State: AOAM530hG4RH+BxCCU5KJckC6xwbB+jORX6KrS2TTETA8xuRJXkUZ/wT
        ETVKS4DIgdgyZKYLRBkxrA==
X-Google-Smtp-Source: ABdhPJzrDpekbN2l5TxSPDuiWfP8/sG/3dI4sWv+MXhY2apRC5QC50Nmv8BeU/9jsn21sgB3Fmknfw==
X-Received: by 2002:a05:6808:13ca:: with SMTP id d10mr10913461oiw.24.1620665139210;
        Mon, 10 May 2021 09:45:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q130sm2629826oif.40.2021.05.10.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:45:35 -0700 (PDT)
Received: (nullmailer pid 260896 invoked by uid 1000);
        Mon, 10 May 2021 16:45:32 -0000
Date:   Mon, 10 May 2021 11:45:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset
 Button detection
Message-ID: <20210510164532.GA241925@robh.at.kernel.org>
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
 <20210510101201.7281-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510101201.7281-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:11:58AM +0100, Srinivas Kandagatla wrote:
> Add bindings required for Multi Button Headset detection.
> WCD934x support Headsets with upto 8 buttons including, impedance measurement
> on both L/R Headset speakers and cross connection detection.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)

A search tells me this is not v1... 

> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> index e8f716b5f875..b25c6ca4e97c 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> @@ -77,6 +77,64 @@ properties:
>      minimum: 1800000
>      maximum: 2850000
>  
> +  qcom,hphl-jack-type-normally-closed:
> +    description: Indicates that HPHL jack switch type is normally closed
> +    type: boolean
> +
> +  qcom,ground-jack-type-normally-closed:
> +    description: Indicates that Headset Ground switch type is normally closed
> +    type: boolean

I asked before if 'normally closed' was the more common case and you 
said yes. So I'd expect 'open' here, but now you've changed the 
polarity of the property. And now not present is not described at all. 

> +
> +  qcom,mbhc-headset-vthreshold-microvolt:
> +    description: Voltage threshold value for headset detection
> +    minimum: 0
> +    maximum: 2850000
> +
> +  qcom,mbhc-headphone-vthreshold-microvolt:
> +    description: Voltage threshold value for headphone detection
> +    minimum: 0
> +    maximum: 2850000
> +
> +  qcom,mbhc-button0-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button0
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button1-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button1
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button2-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button2
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button3-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button3
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button4-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button4
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button5-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button5
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button6-vthreshold-microvolt:
> +    description: Voltage threshold value for headset button6
> +    minimum: 0
> +    maximum: 500000
> +
> +  qcom,mbhc-button7-vthreshold-microvolt:
> +    description: Voltage threshold value headset button7
> +    minimum: 0
> +    maximum: 500000

These can all be a single pattern property: 
'^qcom,mbhc-button[0-7]-vthreshold-microvolt$'

Are there inter-dependencies between these properties? Are 0-7 
meaningful or just an index? For the latter case, why not just make this 
an array?

> +
>    clock-output-names:
>      const: mclk
>  
> @@ -159,6 +217,13 @@ examples:
>          qcom,micbias2-microvolt = <1800000>;
>          qcom,micbias3-microvolt = <1800000>;
>          qcom,micbias4-microvolt = <1800000>;
> +        qcom,hphl-jack-type-normally-closed;
> +        qcom,ground-jack-type-normally-closed;
> +        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
> +        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
> +        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
> +        qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>          clock-names = "extclk";
>          clocks = <&rpmhcc 2>;
>  
> -- 
> 2.21.0
> 
