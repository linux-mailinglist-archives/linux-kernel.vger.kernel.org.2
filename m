Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75DD37ED72
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbhELUXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:23:02 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43527 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385238AbhELUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:07:43 -0400
Received: by mail-oi1-f172.google.com with SMTP id j75so23359077oih.10;
        Wed, 12 May 2021 13:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZOu937T06FGYysrX40DfRIEifPnkgP2wpT5ChbrOLM=;
        b=suEPlijjcetQcOtRaxbflsp2GvTpnlO3aAqF1bCBieMKaoQOZe74Gze7NeSAX2qOBL
         59Uo0KBTCc39RdlplAq7xbFle4CxFQeJtm3ylVvueR+5sibq2pmF4Lvh2FqvtXOUEbMg
         wvMWGPpWBeCUm4SZ4w73Eearmg7kmtQRo87nQunoYriWX3BezOs0zDuYsVc6jOwQenZB
         baWcK5h6gkTH+ZVACFstPQqd26sxpt3WM9Lb/YUGho+EshpIiJpBp2Ass5DvMZPrFNJu
         c2ASsQ5sxM3sgXY/4vXNcn7BwG5qd1kmbahHmK1xWs9tyS6WV+eEJwNebwV+Y2P9mQtt
         HhlA==
X-Gm-Message-State: AOAM532R+bGA0peOr2hkxlhvPdJ96guHfq0qBl2bqhN1sXMaP/FXY5tB
        +e22rbMGTEUN5uZQ1tUyCeVIzvL3ZA==
X-Google-Smtp-Source: ABdhPJyFestwfEyHgdtvQESLKDKYdJEwVqw5rAmNlfsvq9xl609Ay/5t03I4TO2cGO9CWGnLqGNXZg==
X-Received: by 2002:a05:6808:561:: with SMTP id j1mr189039oig.24.1620849994987;
        Wed, 12 May 2021 13:06:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d19sm172127oti.57.2021.05.12.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:34 -0700 (PDT)
Received: (nullmailer pid 2429755 invoked by uid 1000);
        Tue, 11 May 2021 19:00:57 -0000
Date:   Tue, 11 May 2021 14:00:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc
 for akcodec machine driver
Message-ID: <20210511190057.GA2416585@robh.at.kernel.org>
References: <1620630441-14358-1-git-send-email-shengjiu.wang@nxp.com>
 <1620630441-14358-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620630441-14358-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:07:21PM +0800, Shengjiu Wang wrote:
> Imx-akcodec is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - update doc accoring to Rob's comment, use the common porperties.
> 
>  .../bindings/sound/imx-audio-akcodec.yaml     | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> new file mode 100644
> index 000000000000..0812c4779b59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-audio-akcodec
> +      - fsl,imx-audio-akcodec

We gone from individual codecs to a family of codecs. Is there something 
specific for the machine driver about this set of codecs? Why can't it 
be *any* codec?

> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source. Valid names could be power supplies,
> +      MicBias of codec and the jacks on the board.
> +
> +patternProperties:
> +  ".*-dai-link$":
> +    description:
> +      Each subnode represents a dai link. Subnodes of each dai links would be
> +      cpu/codec dais.
> +
> +    type: object
> +
> +    properties:
> +      link-name:
> +        description: Indicates dai-link name and PCM stream name.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
> +
> +      format:
> +        description: audio format.
> +        items:
> +          enum:
> +            - i2s
> +            - dsp_b
> +
> +      cpu:
> +        description: Holds subnode which indicates cpu dai.
> +        type: object
> +        properties:
> +          sound-dai: true
> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        properties:
> +          sound-dai: true
> +
> +    required:
> +      - link-name
> +      - cpu
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - model
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound-ak4458 {
> +        compatible = "fsl,imx-audio-akcodec";
> +        model = "ak4458-audio";
> +        pri-dai-link {
> +            link-name = "akcodec";
> +            format = "i2s";
> +            cpu {
> +                 sound-dai = <&sai1>;
> +            };
> +            codec {
> +                 sound-dai = <&ak4458_1>, <&ak4458_2>;
> +            };
> +        };
> +        fe-dai-link {
> +            link-name = "HiFi-ASRC-FE";
> +            format = "i2s";
> +            cpu {
> +                sound-dai = <&easrc>;
> +            };
> +        };
> +        be-dai-link {
> +            link-name = "HiFi-ASRC-BE";
> +            format = "dsp_b";
> +            cpu {
> +                sound-dai = <&sai1>;
> +            };
> +            codec {
> +                sound-dai = <&ak4458_1>, <&ak4458_2>;
> +            };
> +        };
> +    };
> -- 
> 2.27.0
> 
