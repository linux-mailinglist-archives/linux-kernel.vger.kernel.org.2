Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E317C3172FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhBJWNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:13:41 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35001 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJWNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:13:37 -0500
Received: by mail-ot1-f53.google.com with SMTP id k10so3383873otl.2;
        Wed, 10 Feb 2021 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTXg6CwDth7i/nqcv+euFr50pt7fVzpIfVZ9mbO1Zq0=;
        b=sLh8jH9W+1uX3fOyt97W8/4Xc1IHy6QjemN9CZeCyw36S4BoOe/8Bp/mUHASLVP0kp
         nWgZi+JXi7GSNEFll+XiwUw9Mc01XLbFnM8C5y91u01+0MgzxQLR09+lCtgMr3UfL1Sw
         JEt6Ppn16Jkh0CPgjuMV6Dxwhg0+jLn5lirCSf6Sp7YPtDlbKQi47DH3Nlob1ObL55OR
         ZWEvrOAqnhTOFiY+Mz1Wuqcu/hSsiuOV6pqek6RTUie0tvKUmTGHyY4JVuTzSr0lXrgY
         0nj0ecD9geRsTqcNs76TQM2ZbfAxRoZeph4oor88IsIiqArEgVDReTWCQkJmleTgUCk9
         /K/w==
X-Gm-Message-State: AOAM533iJ7IFhITxcMi41A5/PGdxuV1FvRPR70XfCmKlTiq+3SsVUQD6
        9F6cWGotVmW3c1K9v8dZAA==
X-Google-Smtp-Source: ABdhPJzi/+7SeOHhZnHUBL4PJ6P0lIk8i2F6Ep3p3sFUaaO0qUGBJ/J5giqeNfq2byHxecLoX+o25A==
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr3792095otp.49.1612995174877;
        Wed, 10 Feb 2021 14:12:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z8sm613408oon.10.2021.02.10.14.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:12:54 -0800 (PST)
Received: (nullmailer pid 2893717 invoked by uid 1000);
        Wed, 10 Feb 2021 22:12:52 -0000
Date:   Wed, 10 Feb 2021 16:12:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
Message-ID: <20210210221252.GA2885308@robh.at.kernel.org>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 06:23:51PM +0800, Shengjiu Wang wrote:
> fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
> for getting the user's configuration from device tree and configure the
> clocks which is used by Cortex-M core. So in this document define the
> needed property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> new file mode 100644
> index 000000000000..2d3ce10d42fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,rpmsg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio RPMSG CPU DAI Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx7ulp-rpmsg
> +      - fsl,imx8mn-rpmsg
> +      - fsl,imx8mm-rpmsg
> +      - fsl,imx8mp-rpmsg

rpmsg is a protocol. What's the h/w block?

> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock for register access
> +      - description: Master clock
> +      - description: DMA clock for DMA register access
> +      - description: Parent clock for multiple of 8kHz sample rates
> +      - description: Parent clock for multiple of 11kHz sample rates
> +    minItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: mclk
> +      - const: dma
> +      - const: pll8k
> +      - const: pll11k
> +    minItems: 5
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  fsl,audioindex:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: instance index for rpmsg image
> +
> +  fsl,version:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: rpmsg image version index

What are these 2 used for?

> +
> +  fsl,buffer-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: pre allocate dma buffer size
> +
> +  fsl,enable-lpa:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: enable low power audio path.
> +
> +  fsl,codec-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sometimes the codec is registered by
> +                 driver not the device tree, this items
> +                 can be used to distinguish codecs

0-2^32 are valid values?

> +
> +required:
> +  - compatible
> +  - fsl,audioindex
> +  - fsl,version
> +  - fsl,buffer-size
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rpmsg_audio: rpmsg_audio {
> +        compatible = "fsl,imx8mn-rpmsg";
> +        fsl,audioindex = <0> ;
> +        fsl,version = <2>;
> +        fsl,buffer-size = <0x6000000>;
> +        fsl,enable-lpa;
> +        status = "okay";

Don't show status in examples.

> +    };
> -- 
> 2.27.0
> 
