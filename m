Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C204237A2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEKI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:56:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2116AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:55:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c17so15592800pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yv7JOioo8NokeIgCiQAVCLNKcBXIN5FjohvMBc6oEZo=;
        b=IjrSZ/MBJIXPLWhgb2vBNqGnRgcz/pl4GrnOAav+jod2qEyNbldyR3140Wf4Oq0pVs
         8k0o2PbFxucJDwaJ8Reownq2b+eoDI+9mtg4UWraYTkh16GeKBGwtoZmlKuQg9xOjbBF
         rOAyryrYehEgLy1JH1qUYRK6naD3lnYNL182g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yv7JOioo8NokeIgCiQAVCLNKcBXIN5FjohvMBc6oEZo=;
        b=H5z3ZJMjIM1CZKj9x0ljjJUHCFO3rOIH3SZJSQNeIMKbarwfiO2pV9O4Zc8j/0KMTp
         /3fg07thR+zCNdUGtkUA94iO18T32203BTUCRHNFEDieNEvOT/MUl0PGLxodzZY3wn1Z
         2rBUfkC20zIXN9I34Zn21b2kLj7+WkpELPAThTvz+IvFUwsdR5pEHs4+A0oJM3uRlV1X
         7tUdqi4gysQiNMHs8ZRYWvJ8StQgXgbz5gOJDwx5Dnnl1w/tK/S7TXQQmDvSc/qBcsmQ
         0GPo2/4+RlT4Grs11JJoBdrz6w95T5ATrHK1Qfk7t/JpV7TAPz61WxBqpr+NvXz/5tOs
         bs2w==
X-Gm-Message-State: AOAM531U2BLOT7U0Baw/k3dGknZpKqXVFbPugZLwN7RieS3YCZq9ECJj
        +xbhs5FFOA5+h2N1nyukg+6jEYtHsbWgrPrLUbf2/g==
X-Google-Smtp-Source: ABdhPJzfJaXV9C774l39y1nfIuJgZ6++yAnwWMMzvr3IEV+eavjS34LSzHuQnPfx+kG/AEjJG2DKLq+0zZ73fma9T1I=
X-Received: by 2002:a62:6544:0:b029:261:14cc:b11d with SMTP id
 z65-20020a6265440000b029026114ccb11dmr29306277pfb.12.1620723336588; Tue, 11
 May 2021 01:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210415032958.740233-1-ikjn@chromium.org> <20210415032958.740233-2-ikjn@chromium.org>
 <CAFqH_53GXdCfPCke_UN3fqrDxHZ_scd21ZekVzrYoVWbmLUmrw@mail.gmail.com> <CAL_JsqJ0mqqK69m_iFKTqGzu_TYvR7WdsuKw-ead74Sc=6msDw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ0mqqK69m_iFKTqGzu_TYvR7WdsuKw-ead74Sc=6msDw@mail.gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 11 May 2021 16:55:25 +0800
Message-ID: <CAATdQgAUGUntdZCwyP_7gdqD+sXYPubitwEHOfdvmZ=F3wmzHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mfd: google,cros-ec: add DT bindings for a
 baseboard's switch device
To:     Rob Herring <robh+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 9:30 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Apr 16, 2021 at 12:37 AM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi Ikjoon,
> >
> > Thank you for your patch.
> >
> > Missatge de Ikjoon Jang <ikjn@chromium.org> del dia dj., 15 d=E2=80=99a=
br.
> > 2021 a les 5:32:
> > >
> > > This is for ChromeOS tablets which have a 'cros_cbas' switch device
> > > in the "Whiskers" base board. This device can be instantiated only by
> > > device tree on ARM platforms. ChromeOS EC doesn't provide a way to
> > > probe the device.
> > >
> > > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > >
> > > ---
> > >
> > > Changes in v5:
> > >  - Add missing blank lines and change the description property's posi=
tion.
> > >  - Add a note to description: "this device cannot be detected at runt=
ime."
> > >
> > > Changes in v4:
> > > Define cros-cbase bindings inside google,cros-ec.yaml instead of
> > > a separated binding document.
> > >
> > >  .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yam=
l b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > index 76bf16ee27ec..8dcce176b72e 100644
> > > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > @@ -114,6 +114,22 @@ properties:
> > >        - "#address-cells"
> > >        - "#size-cells"
> > >
> > > +  cbas:
> > > +    type: object
> > > +
> > > +    description:
> > > +      This device is used to signal when a detachable base is attach=
ed
> > > +      to a Chrome OS tablet. This device cannot be detected at runti=
me.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: google,cros-cbas
> > > +
> > > +    required:
> > > +      - compatible
> > > +
> > > +    additionalProperties: false
> > > +
> > >  patternProperties:
> > >    "^i2c-tunnel[0-9]*$":
> > >      type: object
> > > @@ -180,6 +196,10 @@ examples:
> > >              interrupts =3D <99 0>;
> > >              interrupt-parent =3D <&gpio7>;
> > >              spi-max-frequency =3D <5000000>;
> > > +
> > > +            base_detection: cbas {
> >
> > nit: Rob, shouldn't this be just cbas?
>
> Yes.

Sorry, I'm a bit confused here.
'base_detection: cbas' in example should be just 'cbas'?
Maybe that's because cbas doesn't need to have a phandle or just by
its definition in schema?

Please let me upload v6 if this needs to be fixed.

Thanks for reviewing!



>
> >
> > > +                compatible =3D "google,cros-cbas";
> > > +            };
> > >          };
> > >      };
> > >
> > > --
> > > 2.31.1.295.g9ea45b61b8-goog
> > >
> >
> > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
