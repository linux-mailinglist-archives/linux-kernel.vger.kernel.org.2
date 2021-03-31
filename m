Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817534F396
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhC3VcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhC3Vb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:31:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B88C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:31:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o5so17424016qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=moOHpFp6B1slvDCQ1XJe9I8qoROHz5Fk0JNnYcoNKV4=;
        b=dsCS6SvyblcG7oQ7ueXLS7xHUVbAxqeIo+mKnPu17yA69BEhq40Vqye7OZla+7EiwM
         40/SsDnv0dnE91uCuK9quwkHO04o73NQJ4tZCHawa7syJxJrUIdWKfNc513iTL4TAm+k
         UEXJL+LM1gAuYeQ+RFrgZrmXO7khismTXEDpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=moOHpFp6B1slvDCQ1XJe9I8qoROHz5Fk0JNnYcoNKV4=;
        b=k7G1hy+eJxgpSa5s58m6xPgm/VnrzWg/5wtEg2IDNyVT5+zqFFYiBex2zS/3S6GsJu
         D1/teIaWEFk04bBrxZQeV6Wcq1pAt+1lKRd41jSigLMwHryOo3CWH87LnFBmUv0EsCpo
         QSSO5pn4TFU+A3xn5id3zg98j1dDNnAFPAUjbJyM86R9irZedju/bcVUy2bD7kl43Rg9
         2ZuEKqbwdVQ2BZuuhBWsXV4HleGCsFN7AvZtLKwbX0Ubpa1f67DGC3TxfOLBOpu8ZC8u
         KhmqqKxjTntFnNwOve3X8yKpF9eXgAukloHLz2pKB6c1cXf3OGzdVxe23J5G9h9OMauj
         pYZg==
X-Gm-Message-State: AOAM533Hr7dkdMKuAxfC9/5fclNnbP9DXo17W2OBL3Lg3H3r7RGrb2WU
        RY/2F/KhXNP8JEuzBTBJtncfaHsP9Y5Mgw==
X-Google-Smtp-Source: ABdhPJyj2ThalcPd70Br41g7hRXxUBiE08xfqu7+tPIH8nkHi8saCp1VSS40KpYY5/5ht5eVPODCRw==
X-Received: by 2002:a37:842:: with SMTP id 63mr319651qki.112.1617139916369;
        Tue, 30 Mar 2021 14:31:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id m13sm3737qkk.16.2021.03.30.14.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 14:31:54 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i144so18933257ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:31:53 -0700 (PDT)
X-Received: by 2002:a25:3741:: with SMTP id e62mr265234yba.343.1617139913337;
 Tue, 30 Mar 2021 14:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210330025345.3980086-1-dianders@chromium.org>
 <20210329195255.v2.9.Ia7e9bb7cf6c51d960b9455fb0fa447cc68ece99d@changeid> <YGMvO3PNDCiBmqov@intel.com>
In-Reply-To: <YGMvO3PNDCiBmqov@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Mar 2021 14:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgnPMkJ6moLDvg8FPTKWUcTrp1mYED2i-K1vjJFu4cEA@mail.gmail.com>
Message-ID: <CAD=FV=UgnPMkJ6moLDvg8FPTKWUcTrp1mYED2i-K1vjJFu4cEA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] drm/edid: Use the cached EDID in drm_get_edid()
 if eDP
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 30, 2021 at 7:01 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> > @@ -2049,15 +2049,39 @@ struct edid *drm_get_edid(struct drm_connector =
*connector,
> >                         struct i2c_adapter *adapter)
> >  {
> >       struct edid *edid;
> > +     size_t old_edid_size;
> > +     const struct edid *old_edid;
> >
> >       if (connector->force =3D=3D DRM_FORCE_OFF)
> >               return NULL;
> >
> > -     if (connector->force =3D=3D DRM_FORCE_UNSPECIFIED && !drm_probe_d=
dc(adapter))
> > -             return NULL;
> > +     if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP &&
> > +         connector->edid_blob_ptr) {
> > +             /*
> > +              * eDP devices are non-removable, or at least not somethi=
ng
> > +              * that's expected to be hot-pluggable. We can freely use
> > +              * the cached EDID.
> > +              *
> > +              * NOTE: technically we could probably even use the cache=
d
> > +              * EDID even for non-eDP because the cached EDID should b=
e
> > +              * cleared if we ever notice a display is not connected, =
but
> > +              * we'll use an abundance of caution and only do it for e=
DP.
> > +              * It's more important for eDP anyway because the EDID ma=
y not
> > +              * always be readable, like when the panel is powered dow=
n.
> > +              */
> > +             old_edid =3D (const struct edid *)connector->edid_blob_pt=
r->data;
> > +             old_edid_size =3D ksize(old_edid);
> > +             edid =3D kmalloc(old_edid_size, GFP_KERNEL);
> > +             if (edid)
> > +                     memcpy(edid, old_edid, old_edid_size);
> > +     } else {
> > +             if (connector->force =3D=3D DRM_FORCE_UNSPECIFIED && !drm=
_probe_ddc(adapter))
> > +                     return NULL;
> > +
> > +             edid =3D drm_do_get_edid(connector, drm_do_probe_ddc_edid=
, adapter);
> > +             drm_connector_update_edid_property(connector, edid);
> > +     }
>
> This is a pretty low level function. Too low level for this caching
> IMO. So I think better just do it a bit higher up like other drivers.

Fair enough. In the past I'd gotten feedback that I'd been jamming too
much stuff in my own driver instead of putting it in the core, but I'm
happy to leave the EDID caching in the driver if that's what people
prefer. It actually makes a bit of the code in the driver a bit less
awkward...

-Doug
