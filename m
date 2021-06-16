Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7F3A9838
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhFPK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:58:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D3C061574;
        Wed, 16 Jun 2021 03:56:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1515461pjb.4;
        Wed, 16 Jun 2021 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuLGw9v7JLauPhtnxWS8KYadx9N1A/H3l9fDM2qNdFs=;
        b=Zhj8UEuYrb4byhhy4fvAXLyIcmOOFNXknm7PP8rsag6hkDRyQUHz2glSE9P47Ax/o8
         2x6T4LwzcY9FMCJt9+/ZIMwszYNdgg53J30WeeWvWMf3yA7rrzPaoSXcZ0pEDUNMPQIH
         uPYFMbPHjYNjzKlHTDGbC6HGv96cokWjzplROekLytbWjppWC9KJnRFEZI8Y2a49AQoX
         vJWVAQj9bplLUyd8X1E9rAzy9zil8Ke0Lb7Y5Y8UtCkQ1uJD0VvN6hlbWroddcoM3PVn
         UBYR1nXZQAagH8XFLPrxMHoctTJ8Y76+0UIT68BeR0Nk36MVaOzawLd+4yL73vyIez4Q
         1rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuLGw9v7JLauPhtnxWS8KYadx9N1A/H3l9fDM2qNdFs=;
        b=b22f1/PsF9PeYAhZJouO2MQJ6JVnzc2KJf18d8CVegd3Hx7CXI1jj0u9elhDCTT8Lq
         Uiy/JGIKAEZxrgdvbzEXGrw/9aKh9EoXBJsRK17BxnxXhe03NxUbKnc7GXLDAtT7VzZb
         bmOXPHCaxkxyVCALLANRAfR8oXssXd9e7MEj8dovloydTol3aWKdBYbfdEr51B3rTjGM
         S3LDCRV6YVNgxxyhirmVqwsSU1hZ/hafUvyULFxR4Lj10XV4WzsE7jAPLU8Ug+uyhYzt
         Fv14XQdFcXNHmS4vZFdPMC0FSN7BgD2EXNDJIoKPkCt8edkuIjPKdgO7gDn7cx8wIk4v
         AXYg==
X-Gm-Message-State: AOAM5331ZvcrGFLTaQylPz0dlXLChVgPQ9VQYAajs2MB6KLAW9QZgxBv
        2ex/9OVa1cQUNSFP4TAir0fuwRaWb1agCgg3lQ==
X-Google-Smtp-Source: ABdhPJxTheKUcJqyRfJvtawPTMCjeDGxyzMx7Xo/qrwPj+nkXyk+JqpYYCZmLzAA+Kf7pa2yv3lgVepdJoP3repgnkw=
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr4447446pjq.156.1623840996957;
 Wed, 16 Jun 2021 03:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130737.2098-1-fengzheng923@gmail.com> <20210616084920.y6yjic4sau6ungv5@gilmour>
In-Reply-To: <20210616084920.y6yjic4sau6ungv5@gilmour>
From:   =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date:   Wed, 16 Jun 2021 18:56:25 +0800
Message-ID: <CAE=m619_52DDC_up=QqRXkF88uJR6CcAJqentnBzb=pxL7LhxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for
 DMIC controller
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B46=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Jun 15, 2021 at 09:07:37PM +0800, Ban Tao wrote:
> > The Allwinner SoCs feature an I2S controller across multiple SoC
> > generations.
>
> Which SoC generations?
>
> > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> > ---
> >  .../sound/allwinner,sun50i-h6-dmic.yaml       | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,s=
un50i-h6-dmic.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h=
6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-d=
mic.yaml
> > new file mode 100644
> > index 000000000000..81d40c374e44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.=
yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner H6 DMIC Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Ban Tao <fengzheng923@gmail.com>
> > +
> > +properties:
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    const: allwinner,sun50i-h6-dmic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: dmic
>
> The convention we use is bus and mod
>
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    const: rx
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - "#sound-dai-cells"
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - dmas
> > +  - dma-names
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spdif: spdif@5095000 {
>
> The label and node name seems wrong?
>
Yes, in fact, I don=E2=80=99t know much about yaml format files.
The allwinner,sun50i-h6-dmic.yaml file is based on
allwinner,sun4i-a10-spdif.yaml.
So, How do i convert txt file to yaml file, for example:
---------------------------------------------
Required properties:

  - compatible         : should be one of the following:
    - "allwinner,sun50i-h6-dmic": for the Allwinner H6 SoC

  - reg                        : physical base address of the
controller and length of memory mapped region.

  - dmas               : Generic dma devicetree binding as described in
                         Documentation/devicetree/bindings/dma/dma.txt.

  - dma-names          : DMA have to be defined, "rx".

  - clocks             : Contains an entry for each entry in clock-names.

  - clock-names                : Includes the following entries:
       "apb"             clock for the dmic bus.
       "dmic"           clock for dmic controller.

  - resets             : reset specifier for the ahb reset

Example:

dmic: dmic@5095000 {
        #sound-dai-cells =3D <0>;
        compatible =3D "allwinner,sun50i-h6-dmic";
        reg =3D <0x05095000 0x400>;
        clocks =3D <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
        clock-names =3D "apb", "dmic";
        dmas =3D <&dma 7>;
        dma-names =3D "rx";
        resets =3D <&ccu RST_BUS_DMIC>;
};
---------------------------------------------

Thanks.


> > +        #sound-dai-cells =3D <0>;
> > +        compatible =3D "allwinner,sun50i-h6-dmic";
> > +        reg =3D <0x05095000 0x400>;
> > +        clocks =3D <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
>
> You'll need includes for it to compile
>
> Maxime
