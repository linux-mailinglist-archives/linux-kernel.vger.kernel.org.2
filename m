Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBC37715E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhEHLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 07:15:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A83EC061574;
        Sat,  8 May 2021 04:14:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n22so8525050qtk.9;
        Sat, 08 May 2021 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXbSQAyhG6W2ZQ5ums5vjGpNRe3vyzAhG3D2OB6FJtA=;
        b=MEaQk6XPhXourlRG1ktFxx9flPigPi5AhTwrHElyyTSb6GnddHT2NBqQzAk7pfHBGh
         bxeC3+pH57tIvA67Zb42zGAcZKXFca8aAOfP6/GgJwC3zsVMuMFVYGKdHUVUh9x9fxRz
         AuqV344d7kd4prNGA6D5wBzbTIUZfWhDs1A7RiMm+8zxj1b5bv6/VA94Lmp2cEaF8qvP
         brtOwOdEzI1+3uPAV2G4hmFqWHImm3SpA7dyouODAAP8Mjio6LclJl4ZGBtVrPq4Fi8p
         0+/pQsi16Tp9y3Q1qRTOfWp4qnx2ADsyVbfSyZmqK613n4bOlpNGMAeYOsMaUVGML0CG
         kQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXbSQAyhG6W2ZQ5ums5vjGpNRe3vyzAhG3D2OB6FJtA=;
        b=JJHtas3aGMk4TFx1FUTXiJBRW2v4iih10ddOdcUwDMwRRimPBN1ZV4Hk0jObKtdmsq
         fDBtT7WS8CMJeze04+yrbR11Y4mX9s6yl+o1F6mHSHN9BN/oYXYKIA/6Hb9vqheXwEH9
         h5XqvMVLvSiEXpUpYIBV2zh2f/TIMqUk5n1FcCsHhSQ2sO0ojdL3ATCTt06ELYc7oBBN
         Es5nZGaPPwb1FpU4oNA4OYjCFJeddK4uLy71ehYL5wCnrVLjQd8BybsycCU5tU9YMvbT
         lrdez/DvaiXMY+tH/Pkhl+koH3aspz4H+sqN1xv4lNH2fhprfKviJPe9H47JGLKMisJ+
         bg2w==
X-Gm-Message-State: AOAM531fRBa963ZuppC8VORmcWAkm95Dl/OefizmvO+pjFAcE1dnJTxL
        h50/bCKQrGIZqeigW3y4dXJSvonrZae9uAx3SrY=
X-Google-Smtp-Source: ABdhPJyRCbYhCpRfDI8+hasLkF4yP7yMUxLuTdvAzoQoMJyQJahYYgoI6qqRk4w4Lw9Mgcet1WmcDyaHhNNKa/rS4Jc=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr13187735qtr.292.1620472484696;
 Sat, 08 May 2021 04:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
 <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com> <20210503170030.GA1987906@robh.at.kernel.org>
In-Reply-To: <20210503170030.GA1987906@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 8 May 2021 19:14:33 +0800
Message-ID: <CAA+D8ANFmegm2CgOs8u5+FCrR0gGyA_tQHcPCrh3Sikcm_g47Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc for
 akcodec machine driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, May 4, 2021 at 1:01 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 23, 2021 at 01:51:47PM +0800, Shengjiu Wang wrote:
> > Imx-akcodec is a new added machine driver for supporting
> > ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/imx-audio-akcodec.yaml     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> > new file mode 100644
> > index 000000000000..7419bf7224e9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec
>
> Looks like the existing fsl-asoc-card.txt? You should convert to schema
> and use that. Otherwise, my comments are based on this all being 'new'.

Ok, let's treat it as 'new'

>
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8mq-audio-ak4458
> > +      - fsl,imx8mq-audio-ak4497
> > +      - fsl,imx8mq-audio-ak5558
> > +      - fsl,imx-audio-ak4497
> > +      - fsl,imx-audio-ak4458
> > +      - fsl,imx-audio-ak5558
> > +      - fsl,imx-audio-ak5552
>
> I continue to not understand why audio bindings need the codec(s) in the
> compatible strings. Can't you look up the codec thru the audio-codec
> property?

I will try to remove the codecs type from the compatible string and check
the codec type in driver.

>
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  audio-cpu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of a CPU DAI controller
> > +
> > +  audio-codec:
> > +    description: The phandle of Codec DAI controllers, there are two
> > +                 controllers maximum.
>
> We have the common 'sound-dai' property. See the simple-card.yaml
> binding.

ok, will use sound-dai.

>
> > +
> > +  audio-asrc:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of ASRC. It can be absent if there's no
> > +                 need to add ASRC support via DPCM.
>
> Needs a vendor prefix.

ok,  can be removed in the next version.

>
> > +
> > +  fsl,tdm:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      This is a boolean property. If present, the TDM mode is enabled.
>
> But this one seems like something that could or should be common.

Ok, I will use the common one in the next version.

>
> > +
> > +required:
> > +  - compatible
> > +  - model
> > +  - audio-cpu
> > +  - audio-codec
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound-ak4458 {
> > +        compatible = "fsl,imx-audio-ak4458";
> > +        model = "ak4458-audio";
> > +        audio-cpu = <&sai1>;
> > +        audio-codec = <&ak4458_1>, <&ak4458_2>;
> > +    };
> > --
> > 2.17.1
> >
