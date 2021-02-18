Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8031E763
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBRIYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhBRHWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:22:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD4C061756;
        Wed, 17 Feb 2021 23:21:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e15so733040qte.9;
        Wed, 17 Feb 2021 23:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4CuVJp6htN2y1/Vp8LtCaaMfaPH0Jo1ezQEtxgh7bk=;
        b=mdpH+6FobMXsdaZB85IHeW3r64Vs5Sg4rYLQ5bmOIOqagsYGgBIxrwD41jtF37xVZF
         BtJs+dLUNcu6JAbX1j9/qbszuIFb+yz8ZASbPKX3n89Fxf/rGShVkZWuBJBoV1a/qRKZ
         7N4Xfd/uaDo/51xC71PTE3rkOhCDmEcPCr+f5zHLqrMgICVf1fRFTzEY8XYaIJDNx6NL
         myjNbOtCm0jUeSJAyy4Uh47OoUEYGT/gUVX+24Iir1s6t1nRjUD2OLQGNHhqvzVxMrlh
         E3kqYoqHSH3tjsuk480W9oiBvOxuQ2wPk8Eil28J4j32OUTZSmZVQDhU7M5GAU9KJ2LP
         IG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4CuVJp6htN2y1/Vp8LtCaaMfaPH0Jo1ezQEtxgh7bk=;
        b=uOPscJnFcIZbIL7VhopymcSvHJ4Pp0YVSHKh1mk+yuMcKymWmF6WFQWdrVS1clGeCD
         E9TZp4ceWH1OrGOvGWcE4qPt9ryf6jPIU2ICQTjfDtoxZA3Xq65wbNPhDxVs00JQzvmy
         1zEEkLdOOEQLljdg92F9Newautx/aj99hTfAGcYTZx1cDKcMAijtjaskB4TT6DfvEtib
         RYhw3e2KNFS6yG/YwNTxJs6KO/s6IQjOja0IIL6LKOcIColxsXIJmRIRju5p7PPd+/d2
         19AkHuQqyFJvk6TcPaiCh+ennFFeoObP/7TnFGqOVnQ2sgD0SfZL9NjG1tOZDeNMS7X4
         c0iQ==
X-Gm-Message-State: AOAM531wTHObiZM4ReNDUnapqF7CyEj6hIyJs6+PD5CmyFMGLbWp5rBh
        ju/apcyxyHPdQlNefS93oJ8btUzL2jFcFAkS0HY=
X-Google-Smtp-Source: ABdhPJxYDxHIpH8R50b3lmetoPOD5LNUh7FIOIlLGHYseOIxe+kTql8AAKWjI5pZkC7bn2hCVj6VeG0ssJUHibmXYYY=
X-Received: by 2002:ac8:7b43:: with SMTP id m3mr2919646qtu.121.1613632881637;
 Wed, 17 Feb 2021 23:21:21 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com> <20210210221252.GA2885308@robh.at.kernel.org>
In-Reply-To: <20210210221252.GA2885308@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 18 Feb 2021 15:21:10 +0800
Message-ID: <CAA+D8APfd8trC8cFsT8k8G54nhrYDrwXxECx9RpDAgw3rco9DQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 6:13 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 07, 2021 at 06:23:51PM +0800, Shengjiu Wang wrote:
> > fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
> > for getting the user's configuration from device tree and configure the
> > clocks which is used by Cortex-M core. So in this document define the
> > needed property.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> > new file mode 100644
> > index 000000000000..2d3ce10d42fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,rpmsg.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP Audio RPMSG CPU DAI Controller
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx7ulp-rpmsg
> > +      - fsl,imx8mn-rpmsg
> > +      - fsl,imx8mm-rpmsg
> > +      - fsl,imx8mp-rpmsg
>
> rpmsg is a protocol. What's the h/w block?

On Linux side this driver is a virtual driver, it is running
on Arm Cortex-A core. The h/w block is controlled by
another core (cortex-M core). so this driver actually
doesn't touch any hardware, it just does configuration
for rpmsg channel.

>
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral clock for register access
> > +      - description: Master clock
> > +      - description: DMA clock for DMA register access
> > +      - description: Parent clock for multiple of 8kHz sample rates
> > +      - description: Parent clock for multiple of 11kHz sample rates
> > +    minItems: 5
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: mclk
> > +      - const: dma
> > +      - const: pll8k
> > +      - const: pll11k
> > +    minItems: 5
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  fsl,audioindex:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: instance index for rpmsg image
> > +
> > +  fsl,version:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: rpmsg image version index
>
> What are these 2 used for?

fsl,audioindex: As we may support multiple instance, for example
two sound card with one rpmsg channel, this is the instance index.

fsl,version: There are maybe different image running on M core, this
is the image version, different image has different function.


>
> > +
> > +  fsl,buffer-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: pre allocate dma buffer size
> > +
> > +  fsl,enable-lpa:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: enable low power audio path.
> > +
> > +  fsl,codec-type:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Sometimes the codec is registered by
> > +                 driver not the device tree, this items
> > +                 can be used to distinguish codecs
>
> 0-2^32 are valid values?

I should add range for it.

>
> > +
> > +required:
> > +  - compatible
> > +  - fsl,audioindex
> > +  - fsl,version
> > +  - fsl,buffer-size
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    rpmsg_audio: rpmsg_audio {
> > +        compatible = "fsl,imx8mn-rpmsg";
> > +        fsl,audioindex = <0> ;
> > +        fsl,version = <2>;
> > +        fsl,buffer-size = <0x6000000>;
> > +        fsl,enable-lpa;
> > +        status = "okay";
>
> Don't show status in examples.

ok, will remove it.

>
> > +    };
> > --
> > 2.27.0
> >
