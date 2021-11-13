Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4D44F4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhKMTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhKMTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:16:15 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9AC061767
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 11:13:22 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so25136072oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VX9u57ND9eVK+gTaCNiN80rSb5UrqPdKqsespFT8p5E=;
        b=cL66v3koUCiHVwtGlyUC95j/M4cAp5NUs3TJK3Fl9emWWbiHwS01dRp+MApY+ReS6F
         eVNgDxjf8LODFMBYP6ig4D4w49D3tQIM1KwqpUkHXuE8IYzYSKgoSz9GytD8d5wW6MXc
         AsjHIca9Wv6ahS+froBZVUMHz2JSyvSgxvLEekKH7iYKxCklwTT7wgaQbk6fb0lhyOlC
         uBnNwK8xcRSOotXddZjgyLo+7lL71tXzR/J9EI0PFZ6XriqgY7zWBnKplg8BqFoNs0yF
         ZC0WjEK4eDOKUHNe6+vCp1GuHb7ZkJtajlNs32IpQifqaFqQes3NDXhdZRd3PPjHftvg
         fhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VX9u57ND9eVK+gTaCNiN80rSb5UrqPdKqsespFT8p5E=;
        b=vkJVwC3mYIoZ3uYlCFDp7yBwAm49QvLA7VdCYH/Xal0zL2aY7O4V/1/QE9/TRjlUKt
         cpzWr3ysSr2OCHYyy9YSkAhSLO9F5TWP09GVq2FzSW3NDn54pQ012G3r+TnD2pLkDtQv
         zETEQ9K39bYqP6CWilo8GCBRMmh83AWSRwP3y8qUgP7fMek/sBJUaQrATFa2oi8adB1g
         T/Y5Xj3XFlYrZJa5Yjn8F44f1Tz5PGUYRCCkaB1qxASUwJZOta5OoR1qFCZryFfcrN7S
         HJEvZpcDVyf1Tmxp3/vp/p93IRWHL/+NhVTucWnPsbVwVv5QWoLwe3toQ1mH8o805pVw
         CAMQ==
X-Gm-Message-State: AOAM531jo1fj1aAfItNpd+6VjJM+lJWgeoaye+8y8vW19o0rHS5mrcsp
        43Bhrj1fbw2BwsWkFFqkqLV2wg==
X-Google-Smtp-Source: ABdhPJxEb43QBIsiGI+QjTsHJYPHDG8L4nisFz66waqXIwZHTBKNufbppOOM4duDBS8P33eOlaosrw==
X-Received: by 2002:aca:be54:: with SMTP id o81mr34259607oif.64.1636830801950;
        Sat, 13 Nov 2021 11:13:21 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d25sm2023262oti.9.2021.11.13.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 11:13:21 -0800 (PST)
Date:   Sat, 13 Nov 2021 13:13:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v5 03/22] dt-bindings: qcom-bam: Convert binding to YAML
Message-ID: <YZAOTCQ0yIJUJTYO@builder.lan>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110105922.217895-4-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Nov 04:59 CST 2021, Bhupesh Sharma wrote:

> Convert Qualcomm BAM DMA devicetree binding to YAML.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
>  .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> deleted file mode 100644
> index cf5b9e44432c..000000000000
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -QCOM BAM DMA controller
> -
> -Required properties:
> -- compatible: must be one of the following:
> - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> - * "qcom,bam-v1.7.0" for MSM8916
> -- reg: Address range for DMA registers
> -- interrupts: Should contain the one interrupt shared by all channels
> -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> -  represents the channel number
> -- clocks: required clock
> -- clock-names: must contain "bam_clk" entry
> -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> -  the secure world.
> -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> -  remote proccessor i.e. execution environment.
> -- num-channels : optional, indicates supported number of DMA channels in a
> -  remotely controlled bam.
> -- qcom,num-ees : optional, indicates supported number of Execution Environments
> -  in a remotely controlled bam.
> -
> -Example:
> -
> -	uart-bam: dma@f9984000 = {
> -		compatible = "qcom,bam-v1.4.0";
> -		reg = <0xf9984000 0x15000>;
> -		interrupts = <0 94 0>;
> -		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> -		clock-names = "bam_clk";
> -		#dma-cells = <1>;
> -		qcom,ee = <0>;
> -	};
> -
> -DMA clients must use the format described in the dma.txt file, using a two cell
> -specifier for each channel.
> -
> -Example:
> -	serial@f991e000 {
> -		compatible = "qcom,msm-uart";
> -		reg = <0xf991e000 0x1000>
> -			<0xf9944000 0x19000>;
> -		interrupts = <0 108 0>;
> -		clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> -			<&gcc GCC_BLSP1_AHB_CLK>;
> -		clock-names = "core", "iface";
> -
> -		dmas = <&uart-bam 0>, <&uart-bam 1>;
> -		dma-names = "rx", "tx";
> -	};
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> new file mode 100644
> index 000000000000..3ca222bd10bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM BAM DMA controller binding
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description: |
> +  This document defines the binding for the BAM DMA controller
> +  found on Qualcomm parts.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,bam-v1.3.0 # for APQ8064, IPQ8064 and MSM8960
> +      - qcom,bam-v1.4.0 # for MSM8974, APQ8074 and APQ8084
> +      - qcom,bam-v1.7.0 # for MSM8916
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: bam_clk
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 31

The old binding uses the wording "the one interrupt" and at least the
Linux implementation indicates that there's only a single interrupt.

So I think this should just be maxItems: 1

> +
> +  num-channels:
> +    maximum: 31
> +    description:
> +      Indicates supported number of DMA channels in a remotely controlled bam.
> +
> +  "#dma-cells":
> +    const: 1
> +    description: The single cell represents the channel index.
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description:
> +      Indicates the active Execution Environment identifier (0-7)
> +      used in the secure world.
> +
> +  qcom,controlled-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the bam is controlled by remote proccessor i.e.
> +      execution environment.
> +
> +  qcom,num-ees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +    default: 2
> +    description:
> +      Indicates supported number of Execution Environments in a
> +      remotely controlled bam.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - qcom,ee
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +    dma-controller@f9984000 {
> +        compatible = "qcom,bam-v1.4.0";
> +        reg = <0xf9984000 0x15000>;
> +        interrupts = <0 94 0>;

While the txt->yaml conversion should retain the original content, I
think it's okay to fix this line up while you're at it; and make it:

	interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;

Regards,
Bjorn

> +        clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> +        clock-names = "bam_clk";
> +        #dma-cells = <1>;
> +        qcom,ee = <0>;
> +    };
> -- 
> 2.31.1
> 
