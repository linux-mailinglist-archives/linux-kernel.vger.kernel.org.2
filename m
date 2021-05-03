Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BDB371E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhECRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:08:36 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37421 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhECRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:01:28 -0400
Received: by mail-ot1-f47.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso5700093otm.4;
        Mon, 03 May 2021 10:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpWS97nnXbRs49r1fForFBwiCI3FlCAOFGO2IucCbgI=;
        b=jKXIcz2msfofi3MX/6abqXQg7sXsaHLO/ycEbBYga/2/Odtv1sltaZlGi8kO5tdCto
         LtAUkU7cJkjm/PHxpInb60pU8NVT5GnpAnhutVjR/FLgw/khNtPFyJZg+IiLEy27HuI7
         kdM5breokilINsN0PzKOthGlxF9vgDTGsR2Ie67JPMJvimxdE9Fsl/ng4N9zfpVV6vnV
         YSdJpBFoWVKneu32IahclfUnM61YAPYkJ4aVdJ/miq//gPfY5nuF0Lwy3kq1FwN18nbU
         xIMA0vZmB2vkZ41wt07Z325ReCz/AiYU4Fxe9JEqQ4XyW8Yq1v6wTUZ8ZtO3pm15K1up
         mgyA==
X-Gm-Message-State: AOAM533lsExUoUJtSPlHxtpnQEiazPNJkaeyy36OqOjYco6SOFeYQNNT
        pX69mHD4zKMBSeu/9mA+uw==
X-Google-Smtp-Source: ABdhPJz3axdorHwGCwuPSEqF9Bw80gZAqMDgQOmNpRuGn93hjcvSZSCtx5vibHriB9CdGrpMOJJZig==
X-Received: by 2002:a9d:7085:: with SMTP id l5mr15416541otj.345.1620061233291;
        Mon, 03 May 2021 10:00:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t25sm71651oic.23.2021.05.03.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:00:32 -0700 (PDT)
Received: (nullmailer pid 2008247 invoked by uid 1000);
        Mon, 03 May 2021 17:00:30 -0000
Date:   Mon, 3 May 2021 12:00:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc for
 akcodec machine driver
Message-ID: <20210503170030.GA1987906@robh.at.kernel.org>
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
 <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:51:47PM +0800, Shengjiu Wang wrote:
> Imx-akcodec is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/imx-audio-akcodec.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> new file mode 100644
> index 000000000000..7419bf7224e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec

Looks like the existing fsl-asoc-card.txt? You should convert to schema 
and use that. Otherwise, my comments are based on this all being 'new'.

> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-audio-ak4458
> +      - fsl,imx8mq-audio-ak4497
> +      - fsl,imx8mq-audio-ak5558
> +      - fsl,imx-audio-ak4497
> +      - fsl,imx-audio-ak4458
> +      - fsl,imx-audio-ak5558
> +      - fsl,imx-audio-ak5552

I continue to not understand why audio bindings need the codec(s) in the 
compatible strings. Can't you look up the codec thru the audio-codec 
property?

> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-cpu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of a CPU DAI controller
> +
> +  audio-codec:
> +    description: The phandle of Codec DAI controllers, there are two
> +                 controllers maximum.

We have the common 'sound-dai' property. See the simple-card.yaml 
binding. 

> +
> +  audio-asrc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of ASRC. It can be absent if there's no
> +                 need to add ASRC support via DPCM.

Needs a vendor prefix.

> +
> +  fsl,tdm:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, the TDM mode is enabled.

But this one seems like something that could or should be common.

> +
> +required:
> +  - compatible
> +  - model
> +  - audio-cpu
> +  - audio-codec
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound-ak4458 {
> +        compatible = "fsl,imx-audio-ak4458";
> +        model = "ak4458-audio";
> +        audio-cpu = <&sai1>;
> +        audio-codec = <&ak4458_1>, <&ak4458_2>;
> +    };
> -- 
> 2.17.1
> 
