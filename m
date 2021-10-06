Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3C424606
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhJFS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhJFS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:27:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531FC061746;
        Wed,  6 Oct 2021 11:25:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y26so14327738lfa.11;
        Wed, 06 Oct 2021 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nilvj0BCNWHsyq1W7awlCSFRX2jOx57s9HjwLir53WA=;
        b=aT8IlMoIH8cgyNkOORPkoY7N2odN1B9ip5felUqWhaWSrDewU2VSCzPp5/yxcFtdyi
         VRjd6IKbxjRx7NaNEYZW3OyTfTk2OZdXpO1oTQkJEqKpueu6pvInIFS5SbB3ZHPKuGP6
         PhCNKDO0XQDrbszz7iI/OYDfKXllQevjoIVk+W1F5Z+H/WTk3rwk3KzPmENNXZX4wMTi
         vHMnYcNKEVT7HOG1ueFU2ogb788ZcjjlDfvkdciJtISxTyFHg/D4Xc6YoH4CB+WZ/Bwo
         sP2RXfDebRjRRAqMWstuXcS31bx+BUnkyz6rnAK3LeXwxe44YajGQNNpcJCbLx+eeV77
         Xf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nilvj0BCNWHsyq1W7awlCSFRX2jOx57s9HjwLir53WA=;
        b=UXrsWJr8iCTcRaqdCb6szVHOGcLDW0j0rvA1b4FQPOo2Fk7dTLksqw+gf6vGomNDfs
         itXMlVuyYEz3lc/bp84CBGPxCvKUnYd7X9o8z5ktgEIyV9Gtl2QmxC2A8X8VEpQRiVk5
         ncLUemJj+uXjzEqi5GsD1EXLSiUvwlXZ6LPat/mI81nWHkLqD1SqAdYBofU1tSPiDf2o
         m52dYw2VIiLjp1R6qzZ+zXac/sgYHUVP2qucSSc6zILkxXuRE7e9uheE5uFltUs6iFhf
         7uau7j7OyRs+ogzervejBOH35grbHfJv+JLcHdW+ZHgU+98+FuD+woSHBE1ILVUEKA33
         y+Uw==
X-Gm-Message-State: AOAM533iLa0B+oL5mRxRIr77ja71B+7084drncIoUgld4+43OIh2nHlC
        X9ysacHEss1Hr6yFNowwrj6m4pSaExay8/V1VaQ=
X-Google-Smtp-Source: ABdhPJxp9XhtFnKoflB76MTWzHr6/mQhe0VNIY3phx28RDnkMpdeIipOPEKfQgAmIMfAAVSM9xYcOp2aHV+dug8jOAI=
X-Received: by 2002:a05:6512:13a0:: with SMTP id p32mr11523368lfa.492.1633544713324;
 Wed, 06 Oct 2021 11:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210813145302.3933-1-kevin3.tang@gmail.com> <20210813145302.3933-7-kevin3.tang@gmail.com>
 <20210917154047.leojvqjqjj2sg34l@gilmour> <CAFPSGXZbqh0f6kEoQaq_Nt677ksVS6QPdAa5==KVVAszSAuasw@mail.gmail.com>
 <YVCgznmOA97v30wG@ravnborg.org>
In-Reply-To: <YVCgznmOA97v30wG@ravnborg.org>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Thu, 7 Oct 2021 02:25:02 +0800
Message-ID: <CAFPSGXbap3QsaofzRnJ79eOro3Z5DNN0Kj_v3ZaTn8pdSf=m8g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, pony1.wu@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,
Thanks for your response.

Sam Ravnborg <sam@ravnborg.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kevin,
>
> > > > +     reg->_0b.bits.out_sel =3D pll->out_sel;
> > > > +     reg->_0b.bits.kint_l =3D pll->kint & 0xf;
> > > > +     reg->_0e.bits.pll_pu_byp =3D 0;
> > > > +     reg->_0e.bits.pll_pu =3D 0;
> > > > +     reg->_0e.bits.stopstate_sel =3D 1;
> > > > +     reg->_0f.bits.det_delay =3D pll->det_delay;
> > > > +
> > > > +     val =3D (u8 *)&reg;
> > > > +
> > > > +     for (i =3D 0; i < sizeof(reg_addr); ++i) {
> > > > +             regmap_write(regmap, reg_addr[i], val[i]);
> > > > +             DRM_DEBUG("%02x: %02x\n", reg_addr[i], val[i]);
> > > > +     }
> > > > +}
> > >
> > > It would be great to also convert this part to a pattern without
> > > structures.
> > I will try it, but our pll registers, all not have official name from
> > aisc design owner.
> > If need to convert it, our pll regiters macro define, it can only be
> > named as reg_01, reg_02...
> IT is better to use the stupid names provided by you asic design owner,
> than just numbers. Add a comment explaining this is due to the asic
> design owner the names are stupid and not your fault.
The chip manual released to us by the asic designer is like this for
many years ago.
As for the specific reason, unable to find out now, i will try use
"stupid names" rather than numbers.
>
> > > > +
> > > > +     if (dsi->panel) {
> > > > +             drm_panel_prepare(dsi->panel);
> > > > +             drm_panel_enable(dsi->panel);
> > > > +     }
> > >
> > > Please use the new devm_drm_of_get_bridge helper here, and use the
> > > bridge API instead.
> > We use drm_panel_init and drm_panel_add API to add panel, so here is a
> > panel device, not a bridge.
>
> The new way to do this is to always wrap the panel in a bridge. We will
> start to slowly migrate away from direct use of the panel API, and let
> display drivers always wrap the panles in a bridge.
> So please do as Maxime suggests.
I only found a demo about the use of devm_drm_of_get_bridge in the vc4
dsi driver, i
will try to follow it.
>
>         Sam
