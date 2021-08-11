Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6F3E9744
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhHKSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:05:11 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:55283 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHKSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:05:07 -0400
Received: by mail-pj1-f44.google.com with SMTP id a8so4760072pjk.4;
        Wed, 11 Aug 2021 11:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKtlG454in3Dc/QU9s2cgp31LIi/iAWHdH0tzX1ufew=;
        b=a/0TGRSdaBuPi+aVQk6Z+gaDAANPpxqpQj3JOZVsgNzKpzkEY7aJbrO+rNA1N4J/cm
         gKAz2PCNX61LnaCWDj++f0uiUSDiRYTirIT/D8k7G93Gbw6cXue+Tsng0KrDE8JpMUSV
         rwfQLCGC8XpfPSFQz7Z0qwuLsNgAqpZJ6tARl1bMfX9y2Frq4hrI1+sHlRkpFIE6J3w3
         aBKX7wcro2YzjujFQslwPAWD3cTLaHm3s5O/ywsY/YTyJQ53c355WRMbdBUL0Cn7uE0F
         TxI4qmJ8hfBab5osS2sxGzwQNPDWQqjlO86V5cnj01kxJ1IYp/Dm12D6/ea6klG6/iZI
         6S1g==
X-Gm-Message-State: AOAM531ee+nIC8iT+JQ/WMVc696e42s3WA9ISEw9HwMScDp8JIZ2lTz4
        dw5Pm9yNjEVuMRHSn2QIHg==
X-Google-Smtp-Source: ABdhPJzUpqUdnU6CQA6cwHSbG7+5+AB9EFa+JIFSqM1aIg7k4CDMZq59oDbbzajYfkw+SKdD9F2AmA==
X-Received: by 2002:a05:6a00:1c65:b029:3cd:e06d:c0b5 with SMTP id s37-20020a056a001c65b02903cde06dc0b5mr75591pfw.38.1628705083171;
        Wed, 11 Aug 2021 11:04:43 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id v7sm90625pjk.37.2021.08.11.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:04:42 -0700 (PDT)
Received: (nullmailer pid 3882 invoked by uid 1000);
        Wed, 11 Aug 2021 18:04:38 -0000
Date:   Wed, 11 Aug 2021 12:04:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] dt-bindings: timer: fsl,imxgpt: add optional osc_per
 clock
Message-ID: <YRQRNrLXIYERa6FT@robh.at.kernel.org>
References: <20210803072958.4815-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803072958.4815-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:29:58AM +0200, Oleksij Rempel wrote:
> Add optional osc_per and fix dts validation warnings on imx6 SoCs.
> 
> Fixes: df8cad689eae ("dt-bindings: timer: Convert i.MX GPT to json-schema")

I don't think you can say the above commit was broken.

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index a4f51f46b7a1..e496dd9f4988 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -43,11 +43,15 @@ properties:
>      items:
>        - description: SoC GPT ipg clock
>        - description: SoC GPT per clock
> +      - description: optional SoC GPT oscillator
> +    minItems: 2

The 3rd clock is valid on every version of the h/w?

>  
>    clock-names:
>      items:
>        - const: ipg
>        - const: per
> +      - const: osc_per
> +    minItems: 2
>  
>  required:
>    - compatible
> @@ -70,3 +74,16 @@ examples:
>                   <&clks IMX27_CLK_PER1_GATE>;
>          clock-names = "ipg", "per";
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +
> +    timer@2098000 {
> +        compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
> +        reg = <0x02098000 0x4000>;
> +        interrupts = <26>;
> +        clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
> +                 <&clks IMX6QDL_CLK_GPT_IPG_PER>,
> +                 <&clks IMX6QDL_CLK_GPT_3M>;
> +        clock-names = "ipg", "per", "osc_per";
> +    };
> -- 
> 2.30.2
> 
> 
