Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F001A317328
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhBJWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:18:10 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36421 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBJWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:17:47 -0500
Received: by mail-oi1-f175.google.com with SMTP id k204so3909838oih.3;
        Wed, 10 Feb 2021 14:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/+AS1PnO/pIi25zgPnySrTJigYkK7rUzHnIa2wA10c=;
        b=CmvT4wHzGKQRzTA5B7tw6mefyFDXTWu8dzQkPwK3hyBCtlU9ZvtSftD7BloAwx1kcS
         LLQ5luPthoD3xbWfMsMaJLWieRMjmUijhEJKElz/Ryak1Af9UxPQ2Jk3ZlirQhqVXcNB
         RNW8W7IRtybFugg/m7rW3LI78EtpFvwLYu0oDD5pn+WO+hSRlqsShGyWQ6ObqGFZIBNg
         jH9xdZtGQK7J5QT4aFROclRg/C7/lBKUL5nsIHC2qeuC7sI8uMzNScrWdRzY+TepX5XZ
         cm3f+2vmT1bsf/epmIlt1k8vV3gMEfBM9iDnvuHDk2a2yWOkgnhB9bB+pV9YyQHGgv/0
         hi9A==
X-Gm-Message-State: AOAM531VI6Lfy9DDg59sQjDLWSQMCJUuP4NNEQteOPwWDLqolajGi6bF
        7VcLO3Zo2efEFgG4uq4NLw==
X-Google-Smtp-Source: ABdhPJwBaK5/uRRp67UJ2r6hTbPKpERNoPUPShLujM3MmLo48Htw1DUx13FzI0PYRRUmqbkp9mKjSg==
X-Received: by 2002:aca:ab89:: with SMTP id u131mr818003oie.170.1612995426687;
        Wed, 10 Feb 2021 14:17:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a20sm155592oid.47.2021.02.10.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:17:05 -0800 (PST)
Received: (nullmailer pid 2901206 invoked by uid 1000);
        Wed, 10 Feb 2021 22:17:04 -0000
Date:   Wed, 10 Feb 2021 16:17:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
Message-ID: <20210210221704.GA2894134@robh.at.kernel.org>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> core. The Cortex-M core will control the audio interface, DMA and audio
> codec, setup the pipeline, the audio driver on Cortex-A core side is just
> to communitcate with M core, it is a virtual sound card and don't touch
> the hardware.

I don't understand why there are 2 nodes for this other than you happen 
to want to split this into 2 Linux drivers. It's 1 h/w thing. 

> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/imx-audio-rpmsg.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> new file mode 100644
> index 000000000000..b941aeb80678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/imx-audio-rpmsg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX audio complex with rpmsg
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-audio-rpmsg
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-cpu:
> +    description: The phandle of an CPU DAI controller
> +
> +  rpmsg-out:
> +    description: |
> +      This is a boolean property. If present, the transmitting function
> +      will be enabled,
> +
> +  rpmsg-in:
> +    description: |
> +      This is a boolean property. If present, the receiving function
> +      will be enabled.
> +
> +required:
> +  - compatible
> +  - model
> +  - audio-cpu
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound-rpmsg {
> +        compatible = "fsl,imx-audio-rpmsg";
> +        model = "ak4497-audio";
> +        audio-cpu = <&rpmsg_audio>;
> +        rpmsg-out;
> +    };
> -- 
> 2.27.0
> 
