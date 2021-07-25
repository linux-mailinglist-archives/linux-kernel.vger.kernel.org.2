Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88B3D4F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGYRhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhGYRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:37:13 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9317C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:17:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso7630022otb.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sswnSXSh197nslKDxXOTclBgYIN74ZxttZPIZEPCju4=;
        b=ht29vs68FcSwPAZQyqQVAnK4RvwQwB8upF5Qyf8QVeleL84dga0CF5zXIDgzt6mZx+
         s+iIf7G0Rzphde/JrZ6v5sT3oG31RvXqrOK/2am0KbQWxXm5r3PJK0ezUFXChv4zy7oW
         yIQRkQ0zzOP2Xnnw8MqBfUC7ccgwef7Uhy6zieuTEu/z+8DbHLgv5g7gUHGTaz8WKOsi
         aZyf11ZJrXnlhakR11BKTwMEDZmI1vjVsP/+HCo2Z91ZhpQ1EESXBwVfaUM34MpQYfFW
         wxUs8MyZ49PdDgvwxGNFeeEDlzwwscZL6KOb6m/KWjfHbby9+QKMLM2lx87510I6o1TH
         2yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sswnSXSh197nslKDxXOTclBgYIN74ZxttZPIZEPCju4=;
        b=KKRbhCclIfhnhoFSSPvw2kXa+KeKAdmGmP2Y0Owp4xdSuC0s+FbsVNVqqH5jalHBMa
         o0SCfw6Gdnap5d25lKuhatUOcVxnOt7df9dDQ0T/0i8JMg0JuH4vwdn7eNfiWL0h5y9y
         qOt0aiKiVIUP+Ga6sC/8BM8dKfrKU8CheSnMGb8sMi7COyJ1iDpCbZ8ocsZCfAaNdTsO
         BEMEEOXrRrJz+fQspmpRTyrf+pXGIH9pPeHCUeFkjSoHWtVm2COxfIZULmpXe5/WsmBQ
         y/LXDoEAFRurGEJiHu+LZqPZUb38Pj2Ry7dYRL46yrWlw7ORksZ/SLrH0hkVaCAvuLz0
         zJKw==
X-Gm-Message-State: AOAM532qUOxLgcmJILFQLLq1t0Y8Lwyo6z3V6Omfqw+Ldwd/xXD/0nBT
        8LJ+XHCaC1IqJiuUb9r5GM47xg==
X-Google-Smtp-Source: ABdhPJzqXUAQfTJzM5uGDuuYAIFHVt1QfUg6wB4yj7Nkjgw7rlxyy9f48ybB1v7Q90LiaZdJk8U7Lg==
X-Received: by 2002:a05:6830:4108:: with SMTP id w8mr9811615ott.216.1627237063253;
        Sun, 25 Jul 2021 11:17:43 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y61sm6824329ota.31.2021.07.25.11.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 11:17:42 -0700 (PDT)
Date:   Sun, 25 Jul 2021 13:17:40 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>, kgunda@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V7 1/3] dt-bindings: mfd: pm8008: Add gpio-ranges and
 spmi-gpio compatible
Message-ID: <YP2qxMTaTb+i1+W1@yoga>
References: <1627029074-23449-1-git-send-email-skakit@codeaurora.org>
 <1627029074-23449-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627029074-23449-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Jul 03:31 CDT 2021, satya priya wrote:

> Add gpio-ranges and "qcom,spmi-gpio" compatible to match with the
> parent qcom,pmic-gpio.yaml binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But it doesn't capture the full binding of qcom,pm8008-gpio - which is
properly described by the end of this series. As such I expect that any
non-trivial usage of the pm8008-gpio in a dts will fail dts validation.

I still think this patch can be merged, but I don't think we're done
expressing the PMIC bindings.

Regards,
Bjorn

> ---
> Changes in V7:
>  - This is newly added in V7 to resolve below error.
>  dtschema/dtc warnings/errors:
>  /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/qcom,pm8008.example.dt.yaml: gpio@c000: compatible: ['qcom,pm8008-gpio'] is too short
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>  /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/qcom,pm8008.example.dt.yaml: gpio@c000: 'gpio-ranges' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index 7799368..ec3138c 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -53,7 +53,9 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: qcom,pm8008-gpio
> +        items:
> +          - const: qcom,pm8008-gpio
> +          - const: qcom,spmi-gpio
>  
>        reg:
>          description: Peripheral address of one of the two GPIO peripherals.
> @@ -61,6 +63,9 @@ patternProperties:
>  
>        gpio-controller: true
>  
> +      gpio-ranges:
> +        maxItems: 1
> +
>        interrupt-controller: true
>  
>        "#interrupt-cells":
> @@ -75,6 +80,7 @@ patternProperties:
>        - gpio-controller
>        - interrupt-controller
>        - "#gpio-cells"
> +      - gpio-ranges
>        - "#interrupt-cells"
>  
>      additionalProperties: false
> @@ -107,10 +113,11 @@ examples:
>          interrupt-parent = <&tlmm>;
>          interrupts = <32 IRQ_TYPE_EDGE_RISING>;
>  
> -        gpio@c000 {
> -          compatible = "qcom,pm8008-gpio";
> +        pm8008_gpios: gpio@c000 {
> +          compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
>            reg = <0xc000>;
>            gpio-controller;
> +          gpio-ranges = <&pm8008_gpios 0 0 2>;
>            #gpio-cells = <2>;
>            interrupt-controller;
>            #interrupt-cells = <2>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
