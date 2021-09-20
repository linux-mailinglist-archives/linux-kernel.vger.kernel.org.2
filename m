Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D374118CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhITQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhITQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:02:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:01:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x124so1771637oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1fYDaDdupQKRTQy3G0eIhoK53MQKmBSMDwabNWa7/AU=;
        b=p+7utRst/qqmYc/Px7XXYaJgdlSDfqy4DcYoqfugUv72qnBhSeS6x8yigOpO5/Irs1
         DXbeT+XLOKrxi9YAYfoERpvwvPu6wqDAMsB9Pr3oCiPpS0N3dUNAboL2krs2g2kiDce8
         6jocJnGRBQsm5q/mFMPA8l2L3tl/HvgjIaE9sg7SZbmuJz7S3Sww2wq8+nOCz5rSB+C6
         SDZ36P0yqZ3Tap0VKX87E+Iy24pKtDer99RSVPfvyIP3o4iRhH4lyPRk1XvXR0y3ji3j
         VibBIYsMaTsj2Chkl3iYPM2JAE7OLhkYywMWflBeRa3uPoS02LeQkjbvf3pOrCQkD2vB
         KuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1fYDaDdupQKRTQy3G0eIhoK53MQKmBSMDwabNWa7/AU=;
        b=CgrC76OxvkKVkDh3jRCajZLNInJQPjuGv+cbE4YieEQn1SsACaH8eF7HzPRST/+eqL
         c/HmWmhUYCBm4F+jLwEFDyDcCcgDY+5pTOvk5DnjNj/ajJ2cDPGyKRGVE+XGaZfUnSLt
         ogg7OqNx9rmd0c3RVrMR9VlpPspdzBcq/jbnVlOqDPzkrcFOu3zGxZGaVXm45lMExDjG
         yTLXOog5YW5jcS7CM/SK21H9o/qk2FvlEEPufRm323cvnbaZvW6QAbstiDMmhlvKMxKO
         eU5pP4Y3EO8AMx6wUq/eDt5rWZ9kvC+83OpV17Sy2TOlO6HI/W+JBmRXe7Kv8TOTZfxW
         IBqg==
X-Gm-Message-State: AOAM532ZwwEastefZVmOCxapCiuE9kl0TCULHCbJtTyPcGH/zwQRT1tJ
        IrcjoJ3FT5egzIwv/HGQPf47aW3dD4unRYFPrZk=
X-Google-Smtp-Source: ABdhPJwOHHWgd9SO7q7Cydk6uePKV4tjaBzzczM3AW42smRP6Ur2Lr8KyLJmghYXdOlIIRSW5g1naekO1sTu9UWOqw8=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr13285127oie.120.1632153661084;
 Mon, 20 Sep 2021 09:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210918094157.4770-1-yangzhiwei@uniontech.com> <484936f6-86e8-2078-3739-674a04283666@gmail.com>
In-Reply-To: <484936f6-86e8-2078-3739-674a04283666@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Sep 2021 12:00:50 -0400
Message-ID: <CADnq5_PwkRb=2z2ak5f8gnAwzQLdE_6ACjtNvpe+6hECxxsCpA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix uninitialized bool variable
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Zhiwei Yang <yangzhiwei@uniontech.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 3:44 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 18.09.21 um 11:41 schrieb Zhiwei Yang:
> > The bool variable detected_hpd_without_ddc in struct radeon_connector
> > is uninitialized when first used, that may cause unnecessary ddc ops.
> > Make it as false when a new connector is alloced.
> >
> > Signed-off-by: Zhiwei Yang <yangzhiwei@uniontech.com>
> > ---
> >   drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/d=
rm/radeon/radeon_connectors.c
> > index fe12d9d91d7a..c1987a66373f 100644
> > --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> > +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> > @@ -1866,6 +1866,7 @@ radeon_add_atom_connector(struct drm_device *dev,
> >       bool shared_ddc =3D false;
> >       bool is_dp_bridge =3D false;
> >       bool has_aux =3D false;
> > +     bool detected_hpd_without_ddc =3D false;
>
> In general good catch, but I don't see the need for a local variable here=
.
>
> Just initialize the member directly or even better change the allocation
> of the connector into a kzalloc().

This is already the case:
        radeon_connector =3D kzalloc(sizeof(struct radeon_connector), GFP_K=
ERNEL);
So I don't think this patch is necessary.

Alex

>
> Christian.
>
> >
> >       if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
> >               return;
> > @@ -1923,6 +1924,7 @@ radeon_add_atom_connector(struct drm_device *dev,
> >       radeon_connector->shared_ddc =3D shared_ddc;
> >       radeon_connector->connector_object_id =3D connector_object_id;
> >       radeon_connector->hpd =3D *hpd;
> > +     radeon_connector->detected_hpd_without_ddc =3D detected_hpd_witho=
ut_ddc;
> >
> >       radeon_connector->router =3D *router;
> >       if (router->ddc_valid || router->cd_valid) {
> > @@ -2384,6 +2386,7 @@ radeon_add_legacy_connector(struct drm_device *de=
v,
> >       struct radeon_connector *radeon_connector;
> >       struct i2c_adapter *ddc =3D NULL;
> >       uint32_t subpixel_order =3D SubPixelNone;
> > +     bool detected_hpd_without_ddc =3D false;
> >
> >       if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
> >               return;
> > @@ -2414,6 +2417,7 @@ radeon_add_legacy_connector(struct drm_device *de=
v,
> >       radeon_connector->devices =3D supported_device;
> >       radeon_connector->connector_object_id =3D connector_object_id;
> >       radeon_connector->hpd =3D *hpd;
> > +     radeon_connector->detected_hpd_without_ddc =3D detected_hpd_witho=
ut_ddc;
> >
> >       switch (connector_type) {
> >       case DRM_MODE_CONNECTOR_VGA:
>
