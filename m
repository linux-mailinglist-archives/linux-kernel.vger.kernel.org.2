Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFF333F56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhCJNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhCJNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:33:25 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E152C061760;
        Wed, 10 Mar 2021 05:33:23 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f124so16727385qkj.5;
        Wed, 10 Mar 2021 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xATgDCcvjbRfKhf77xL4HQKVKsZXwxoQX6S2FdKT3Oo=;
        b=bl9foFVuWm1U0ekqf1RlZ6JOgyHSxk20HsshPAc/WzmNMQkpqow9aJHwikbBuhzGt5
         jT1S7UCkiQhavHDTqfeS/7Pfr5/IePsLcFDW+xtC3oZT8urNRddeoTEDdbA1IepPMPk+
         opy2by+nNj9L9mcjh3ek7aNkXjf9fKBBKm2Jqgd5tMFigjlDZjBf2JhaP0RIxWNQxb2T
         /+3P/012KMPMRD/pd+hAGnOJoVnTUWu55a3JQpQ9tb6n/wtLR9H0ZJW4J2/1/FeMOnPA
         ckGsAVCt8a/1taU7nsP+U4gCNpvnevNcHi/hhmmnz1IViwSN4ngtMzFuAOU/mXVgcYBY
         nErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xATgDCcvjbRfKhf77xL4HQKVKsZXwxoQX6S2FdKT3Oo=;
        b=ZNjDI9cRf+sLSltR3BDW02f7FXgiWXtMRWkaeb/iDEeBs7AdZlmaRmUlEpmMnjaA3/
         sW8xBJw8i4/KHMnlC5+Jd5MDJjgehmHG5FAdeGdra8RTlMEz01zTHbqwbYnI3kTwZHXM
         kifVoocHori5qzZgF42UBf3rjhyI2hptmEpG26VdkFJLN9MhBL9YExC9+7jFC1Fgcn/q
         9ciMZlG70CpIV2vAsmUkIgN661endpnSXJYh4J5u2WXnAViE3X9zn9lFOrAB9b87DnaA
         Xj881ReCcwihRX/4FT4xcd5cMkmbY7D0Ftwxr66/OB/Pftqk6l6FXS6CNoVcCdcEtCoJ
         2c7w==
X-Gm-Message-State: AOAM530UEX3kv7pdwyDm4SL1sycoEV3eCStRINADWWo+goaWjdmFouz9
        EpwgpCxKQrrQADTXw6x0ZbqjwwR4MoFCI+hGkZc=
X-Google-Smtp-Source: ABdhPJwsnjO9VMCLT+e6qoznWlE6iGQjtNS8w36gj0aKWvcdVWBIbKTu/A3JNEQWuep1O/iNA0xg755nBa0vz1K9AyA=
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr2468495qka.103.1615383202487;
 Wed, 10 Mar 2021 05:33:22 -0800 (PST)
MIME-Version: 1.0
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
 <1615209750-2357-4-git-send-email-shengjiu.wang@nxp.com> <20210310024834.GA1623179@robh.at.kernel.org>
In-Reply-To: <20210310024834.GA1623179@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 10 Mar 2021 21:33:11 +0800
Message-ID: <CAA+D8AM5nH+gwfas_=9gkzaegq4=4q2AfVybBnxM4xU3gOiF4w@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Wed, Mar 10, 2021 at 10:49 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 08, 2021 at 09:22:27PM +0800, Shengjiu Wang wrote:
> > fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
>
> Bindings describe h/w blocks, not drivers.

I will modify the descriptions. but here it is a virtual device.  the
mapping in real h/w is cortex M core, Cortex M core controls the SAI,
DMA interface. What we see from Linux side is a audio service
through rpmsg channel.

>
> > for getting the user's configuration from device tree and configure the
> > clocks which is used by Cortex-M core. So in this document define the
> > needed property.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> > new file mode 100644
> > index 000000000000..5731c1fbc0a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> > @@ -0,0 +1,118 @@
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
> > +description: |
> > +  fsl_rpmsg cpu dai driver is virtual driver for rpmsg audio, which doesn't
> > +  touch hardware. It is mainly used for getting the user's configuration
> > +  from device tree and configure the clocks which is used by Cortex-M core.
> > +  So in this document define the needed property.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx7ulp-rpmsg
> > +      - fsl,imx8mn-rpmsg
> > +      - fsl,imx8mm-rpmsg
> > +      - fsl,imx8mp-rpmsg
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral clock for register access
> > +      - description: Master clock
> > +      - description: DMA clock for DMA register access
> > +      - description: Parent clock for multiple of 8kHz sample rates
> > +      - description: Parent clock for multiple of 11kHz sample rates
> > +    minItems: 5
>
> If this doesn't touch hardware, what are these clocks for?

When the cortex-M core support audio service, these clock
needed prepared & enabled by ALSA driver.

>
> You don't need 'minItems' unless it's less than the number of 'items'.

Ok, I will remove this minItems.

>
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
> > +    enum: [0, 1]
> > +    default: 0
> > +    description: Instance index for sound card in
> > +                 M core side, which share one rpmsg
> > +                 channel.
>
> We don't do indexes in DT. What's this numbering tied to?

I will remove it. it is not necessary

>
> > +
> > +  fsl,version:
>
> version of what?
>
> This seems odd at best.
>

I will remove it.  it is not necessary

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2]
>
> You're going to update this with every new firmware version?
>
> > +    default: 2
> > +    description: The version of M core image, which is
> > +                 to make driver compatible with different image.
> > +
> > +  fsl,buffer-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: pre allocate dma buffer size
>
> How can you have DMA, this doesn't touch h/w?

The DMA is handled by M core image for sound playback
and capture. we need to allocated buffer in Linux side.
here just make the buffer size to be configurable.
>
> > +
> > +  fsl,enable-lpa:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: enable low power audio path.
> > +
> > +  fsl,rpmsg-out:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      This is a boolean property. If present, the transmitting function
> > +      will be enabled.
> > +
> > +  fsl,rpmsg-in:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      This is a boolean property. If present, the receiving function
> > +      will be enabled.
> > +
> > +  fsl,codec-type:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 0
> > +    description: Sometimes the codec is registered by
> > +                 driver not by the device tree, this items
> > +                 can be used to distinguish codecs.
>
> How does one decide what value to use?

I will add more description:
0: dummy codec
1: WM8960 codec
2: AK4497 codec

>
> > +
> > +  audio-codec:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of the audio codec
>
> The codec is controlled from the Linux side?

yes.

>
> > +
> > +  memory-region:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the reserved memory nodes
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
>
> How does this work? Don't you need somewhere to put the 'rpmsg' data?

The rpmsg data is not handled in this "rpmsg_audio" device, it is just to
prepare the resource for rpmsg audio function, the clock, the memory
the power...

The rpmsg data is handled in imx-pcm-rpmsg.c and imx-audio-rpmsg.c
These devices is registered by imx remoteproc driver.


I will update this document in v5

Best regards
Wang Shengjiu
