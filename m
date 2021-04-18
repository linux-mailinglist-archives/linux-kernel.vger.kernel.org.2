Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0219363C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhDSHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbhDSHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:01:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE7C06174A;
        Mon, 19 Apr 2021 00:01:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n8so54381873lfh.1;
        Mon, 19 Apr 2021 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g010ghKmkv4wStLkoVhE7WzhJ7tae+htRaSW+tKxRTs=;
        b=OGgagQ06dAAGwCy0nnZUYTsZ45Fhg+RFrLdvw3hlxKXEs0j9x6z4BuqlzmMWnQOfYE
         2OkBSg5tT8HAEHpzeQc8HJi6qhbC2V6m1MfZTaH2aGD8HRi81UbcuB3pTzBaRi2/JZtt
         zHaZcYwr1bhRVVQkZOnGFDoh71rnp8gLPjGzbIUJwh4UZs0EKyUnM0A9tDrQA0nVNEi8
         GCp5k7GGnSSf536bQkAf/gXiM3dgfZd9p1Dcwil+iNfEDa61IH8IzWAWMZkzTlNHSKa2
         1ibViwWjX70KrRx+1P/dkCoOWOypqhGYt19NBefzXag7JuRjfRBde/uBORjctPHbiWwy
         paOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g010ghKmkv4wStLkoVhE7WzhJ7tae+htRaSW+tKxRTs=;
        b=E2rBxC8jC2KyXdWPw3VOip0NI67FE+JMeINFarNfYuh7SuRkLec7z2zIF0FnG0FpTi
         NPWM81yLOwY9yB1yrC4+3lDSBVze2St1aVJezalrzVwzVr1R3IQeeojuHa9cxY6G3k7E
         mwvF3FMXvk2HLGHFMm/FEOTeblJVgptSvsFOAkQR0+5xHtJm5Z6awX5f7J9TZRYY3gsN
         IhW3pDPUklDWMXrMpnXuXjTA66ZVz5VjPbgiOvN9wCCXzdj1v1WdsUVjjo6RO4nlWtok
         nY/6gaFwD3b5+ftTfWQ5AKpMqh7oM6Khz+bPMGFGKAOM/AHU2lOKtg7ZXPTBgt321efD
         0bKQ==
X-Gm-Message-State: AOAM533JEe1M6hjiBljqtEife5mGPtDWTMpwnv1POVs2AN5mNfmqls1b
        /xSqA0COlZedPpX/wMm2/GbWR/s1ISMiDtQe/DQ=
X-Google-Smtp-Source: ABdhPJz4syNfzvTiyqqGFPOOwbikvUTpgDwZK8/A86+O3J7DF1dln1xqNb7oNX+tyXvlZVlO9h3uvQnw3PMTwrvZgOE=
X-Received: by 2002:a05:6512:3dac:: with SMTP id k44mr3328306lfv.188.1618815674748;
 Mon, 19 Apr 2021 00:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210222132822.7830-1-kevin3.tang@gmail.com> <20210222132822.7830-5-kevin3.tang@gmail.com>
 <20210324111019.og6d3w47swjim2mq@gilmour> <CAFPSGXYZPoM45vF_HcjMBcO_Ek-UJZw7F+Q0Of-gWZxvVaPQjg@mail.gmail.com>
 <20210415090312.md6exuuv2y4mblxn@gilmour>
In-Reply-To: <20210415090312.md6exuuv2y4mblxn@gilmour>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Mon, 19 Apr 2021 07:01:00 +0800
Message-ID: <CAFPSGXYdA=09xWZJi2oCQsbr3eH1GBgzjD8DRm5=beiKAtx37Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi,

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B44=E6=9C=8815=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Thu, Apr 15, 2021 at 08:18:52AM +0800, Kevin Tang wrote:
> > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B43=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:10=E5=86=99=E9=81=93=EF=BC=9A
> > > > +static struct sprd_dpu *sprd_crtc_init(struct drm_device *drm,
> > > > +                      struct drm_plane *primary)
> > > > +{
> > > > +     struct device_node *port;
> > > > +     struct sprd_dpu *dpu;
> > > > +
> > > > +     /*
> > > > +      * set crtc port so that drm_of_find_possible_crtcs call work=
s
> > > > +      */
> > > > +     port =3D of_parse_phandle(drm->dev->of_node, "ports", 0);
> > > > +     if (!port) {
> > > > +             drm_err(drm, "find 'ports' phandle of %s failed\n",
> > > > +                       drm->dev->of_node->full_name);
> > > > +             return ERR_PTR(-EINVAL);
> > > > +     }
> > > > +     of_node_put(port);
> > >
> > > The YAML binding should already make sure that your binding is sane, =
and
> > > if you still get a DT that doesn't follow it, you have a whole lot of
> > > other issues than whether ports is there :)
> > >
> > > > +     dpu =3D drmm_crtc_alloc_with_planes(drm, struct sprd_dpu, bas=
e,
> > > > +                                     primary, NULL,
> > > > +                                     &sprd_crtc_funcs, NULL);
> > > > +     if (IS_ERR(dpu)) {
> > > > +             drm_err(drm, "failed to init crtc.\n");
> > > > +             return dpu;
> > > > +     }
> > > > +
> > > > +     dpu->base.port =3D port;
> > >
> > > But you're still referencing it here, while you called of_node_put on=
 it
> > > already? You should only call it once you're done with it.
> >
> >  of_node_put should be called after done with it, this maybe indeed be =
a bug.
> > i will fix it.
> > >
> > >
> > > I'm not really sure why you would need drm_of_find_possible_crtcs to
> > > work then if you don't follow the OF-Graph bindings.
> >
> > it scan all endports of encoder, if a matching crtc is found by
> > OF-Graph bindings
> > and then genarate the crtc mask, here is description:
> > 41  /**
> > 42   * drm_of_find_possible_crtcs - find the possible CRTCs for an enco=
der port
> > 43   * @dev: DRM device
> > 44   * @port: encoder port to scan for endpoints
> > 45   *
> > 46   * Scan all endpoints attached to a port, locate their attached CRT=
Cs,
> > 47   * and generate the DRM mask of CRTCs which may be attached to this
> > 48   * encoder.
> > 49   *
> > if we don't follow the OF-Graph bindings, crtc can't attched to encoder=
.
>
> Yeah, what I'm actually confused about is why you would need the
> of_parse_phandle call. You usually call drm_of_find_possible_crtcs with
> the encoder device node, so from your MIPI-DSI driver in your case, and
> with it's device->of_node pointer and it should work perfectly fine?
I still confused about use drm_of_find_possible_crtcs to bind crtc and
encoder, the port of drm_crtc, default is null?

709  /**
710   * struct drm_crtc - central CRTC control structure
711   * @dev: parent DRM device
712   * @port: OF node used by drm_of_find_possible_crtcs()
---------------------------------------------------------------------------=
--------------------------
25  static uint32_t drm_crtc_port_mask(struct drm_device *dev,
26     struct device_node *port)
27  {
28   unsigned int index =3D 0;
29   struct drm_crtc *tmp;
30
31   drm_for_each_crtc(tmp, dev) {
32   if (tmp->port =3D=3D port)
33   return 1 << index;
34
35   index++;
36   }
37
38   return 0;
39  }

I did not see any place to initialize the port of drm_crtc in the drm
framework, if not setup it.
it looks like the port of drm_crtc is undefined.

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/rockchip/roc=
kchip_drm_vop.c#L1851
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/tilcdc/tilcd=
c_crtc.c#L1051

The difference from others is that we use of_parse_phandle,
as you said, follow the OF-Graph bindings , should be also use
of_get_child_by_name replace it?
like this:
---------------------------------------------------------------------------=
--------
    struct device_node *port;
    port =3D of_get_child_by_name(dpu->dev->of_node, "port");
    if (!port) {
        DRM_ERROR("find 'ports' phandle of %s failed\n",
              dpu->dev->of_node->full_name);
        return -EINVAL;
    }
    crtc->port =3D port;
    of_node_put(port);
---------------------------------------------------------------------------=
---------

If we have multiple display controllers, use of_parse_phandle by
different index also seem is ok.
display-subsystem {
                compatible =3D "sprd,display-subsystem";
                ports =3D <&dpu0_port, &dpu1_port, &dpu2_port......>;
 };

dpu0_port =3D of_parse_phandle(drm->dev->of_node, "ports", 0);
dpu1_port =3D of_parse_phandle(drm->dev->of_node, "ports", 1);
dpu2_port =3D of_parse_phandle(drm->dev->of_node, "ports", 2);


>
> Maxime
