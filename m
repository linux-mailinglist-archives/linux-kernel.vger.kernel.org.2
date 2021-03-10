Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09496333345
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhCJCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:49:01 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:45992 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCJCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:48:38 -0500
Received: by mail-il1-f173.google.com with SMTP id s1so14130522ilh.12;
        Tue, 09 Mar 2021 18:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tEOOZPHDEcY0BRs13eDY3wS0u+L4s5FzuNZ5kGdjLNs=;
        b=eV2gPCQedLWrmNOQrzbtioYRmvDkw6ex/rTGk406xvRhyFhNbgs6EtoQkArujWt8h1
         /6BAHAcKmdo10ax9+ow4COsHaFMXquCsWtv64eHeRv9B5JzuY7slA4X9Pt8l1jMLfklr
         r8UsDkhyqdbEvbzpXST1prBr48PwZDR3vhRb5aK/9UPeW2UXSV2F/ZxbikyuOXJFzoTH
         1lCVg8tBGKiSY46vDHaeKglidGzo7c8Ym5YGMDJUDINxKs9/6+0kzZ1jUzDIlSKGCSI8
         zH2PatyaTSM5HASMBITf1VLJeY67ia4znP9G3wqFJS8ceu/yh1uYu462dI6oYzLEUPg5
         RY2g==
X-Gm-Message-State: AOAM532M4yzsMLJwcDAq6ZfK1fW5AjZhY4p8sK0weA0pZBe3gqEHbjjZ
        EsHr3kOiX9jJuzYgnojZ7w==
X-Google-Smtp-Source: ABdhPJxlxbdsnOqUBKBvn9roAYNjrX2t5RPeImFkLklYb3N4N/Nb+GkhzCBE7xUxdgoLpquCONAlmw==
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr998162ils.39.1615344518240;
        Tue, 09 Mar 2021 18:48:38 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x6sm8397734ioh.19.2021.03.09.18.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:48:37 -0800 (PST)
Received: (nullmailer pid 1645357 invoked by uid 1000);
        Wed, 10 Mar 2021 02:48:34 -0000
Date:   Tue, 9 Mar 2021 19:48:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
Message-ID: <20210310024834.GA1623179@robh.at.kernel.org>
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
 <1615209750-2357-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615209750-2357-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:22:27PM +0800, Shengjiu Wang wrote:
> fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used

Bindings describe h/w blocks, not drivers.

> for getting the user's configuration from device tree and configure the
> clocks which is used by Cortex-M core. So in this document define the
> needed property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> new file mode 100644
> index 000000000000..5731c1fbc0a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> @@ -0,0 +1,118 @@
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
> +description: |
> +  fsl_rpmsg cpu dai driver is virtual driver for rpmsg audio, which doesn't
> +  touch hardware. It is mainly used for getting the user's configuration
> +  from device tree and configure the clocks which is used by Cortex-M core.
> +  So in this document define the needed property.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx7ulp-rpmsg
> +      - fsl,imx8mn-rpmsg
> +      - fsl,imx8mm-rpmsg
> +      - fsl,imx8mp-rpmsg
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock for register access
> +      - description: Master clock
> +      - description: DMA clock for DMA register access
> +      - description: Parent clock for multiple of 8kHz sample rates
> +      - description: Parent clock for multiple of 11kHz sample rates
> +    minItems: 5

If this doesn't touch hardware, what are these clocks for?

You don't need 'minItems' unless it's less than the number of 'items'.

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
> +    enum: [0, 1]
> +    default: 0
> +    description: Instance index for sound card in
> +                 M core side, which share one rpmsg
> +                 channel.

We don't do indexes in DT. What's this numbering tied to?

> +
> +  fsl,version:

version of what?

This seems odd at best.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]

You're going to update this with every new firmware version?

> +    default: 2
> +    description: The version of M core image, which is
> +                 to make driver compatible with different image.
> +
> +  fsl,buffer-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: pre allocate dma buffer size

How can you have DMA, this doesn't touch h/w?

> +
> +  fsl,enable-lpa:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: enable low power audio path.
> +
> +  fsl,rpmsg-out:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, the transmitting function
> +      will be enabled.
> +
> +  fsl,rpmsg-in:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, the receiving function
> +      will be enabled.
> +
> +  fsl,codec-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 0
> +    description: Sometimes the codec is registered by
> +                 driver not by the device tree, this items
> +                 can be used to distinguish codecs.

How does one decide what value to use?

> +
> +  audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the audio codec

The codec is controlled from the Linux side?

> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the reserved memory nodes
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

How does this work? Don't you need somewhere to put the 'rpmsg' data?

> +    };
> -- 
> 2.27.0
> 
