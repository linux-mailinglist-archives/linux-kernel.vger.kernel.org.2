Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42A444992
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKCUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhKCUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635971577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfQZLDxKX9/JNdtn85c81b4wR0b9S/y3uO901LWse8U=;
        b=AehKEibFwB1Eff56mD9r9mY3KabrQa4aY4ezr/dhdhvVIjpEM6tz6XjitiyMpKkjPHE0AE
        uIonhwECI141h4X8103im4KHNCUoaPLbz7vFohnamPT5b/jMoRTROyS/oJCwtJmKv7fBov
        1dETVRuS1V0bFky7QXmi2Htu5rCYqs8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-D94zVVsMPb-GiUN01kWPPA-1; Wed, 03 Nov 2021 16:32:56 -0400
X-MC-Unique: D94zVVsMPb-GiUN01kWPPA-1
Received: by mail-wm1-f69.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1607879wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfQZLDxKX9/JNdtn85c81b4wR0b9S/y3uO901LWse8U=;
        b=Uhee1+hjeOVPwfnr0l7MCH+jpRZNKFCamgg71BjSpPXXwiTZoTNkjXK8tDEcjQ5OCr
         fJ2HAOoFCqqLjVhy5eFICS44QglQ/g4avp/EyIDK1UEmjLCGQ2eo6Dx+YBhrwUV1hKDo
         v1tzU2GTG1U9wuYLx5la5Iki7J2YnzgC1vKwM7Wvc2xUqR9vVuIoQZbybf6UPRNkfFsx
         zeHdoP80XgHhiV5QDB90W0xT9NJSiDj6MT0Z9bjH4608/Uo+O13a5NyoZ/LyjzvBodgX
         y58hsq1R3D4SdY6HXNWNstb3RRNtbiqVjhi89pqwfaXQQ5KCuJIPDoxGftQbFCz2mSSk
         lpUg==
X-Gm-Message-State: AOAM53260DGTL/VifLPocyzvvkPwPqgLKptDcrigdL3ZFUIOt+EwBEzk
        MZxnP5R6m/Z6hwNB0u+yucgsb2jMaOWi7hEDDCFlcgULocxRXScxt+Wuyw3rM0k+HONaKyWZ4Le
        y33HfRwEz6JM2RpYXkgJyJgIdQaqMnc5GhKYnfjDk
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr42357378wrw.116.1635971574477;
        Wed, 03 Nov 2021 13:32:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaqj5Gs323amjeimgkzdO2tqEMBafiLuOySEH+DhXBTc0oejehhYPZYhUBqzOi2hU5Xn/Csb1p+6irM4y+lT8=
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr42357362wrw.116.1635971574338;
 Wed, 03 Nov 2021 13:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211101082511.254155853@linuxfoundation.org> <20211101082518.624936309@linuxfoundation.org>
 <871r3x2f0y.fsf@turtle.gmx.de> <CACO55tsq6DOZnyCZrg+N3m_hseJfN_6+YhjDyxVBAGq9PFJmGA@mail.gmail.com>
In-Reply-To: <CACO55tsq6DOZnyCZrg+N3m_hseJfN_6+YhjDyxVBAGq9PFJmGA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 3 Nov 2021 21:32:43 +0100
Message-ID: <CACO55tsQVcUHNWAkWcbJ8i-S5pgKhrin-Nb3JYswcBPDd3Wj4w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 5.10 32/77] drm/ttm: fix memleak in ttm_transfered_destroy
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Erhard F." <erhard_f@mailbox.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Huang Rui <ray.huang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 9:29 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Nov 3, 2021 at 8:52 PM Sven Joachim <svenjoac@gmx.de> wrote:
> >
> > On 2021-11-01 10:17 +0100, Greg Kroah-Hartman wrote:
> >
> > > From: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >
> > > commit 0db55f9a1bafbe3dac750ea669de9134922389b5 upstream.
> > >
> > > We need to cleanup the fences for ghost objects as well.
> > >
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > > Tested-by: Erhard F. <erhard_f@mailbox.org>
> > > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D214029
> > > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D214447
> > > CC: <stable@vger.kernel.org>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/20211020173211.22=
47-1-christian.koenig@amd.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/gpu/drm/ttm/ttm_bo_util.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > @@ -322,6 +322,7 @@ static void ttm_transfered_destroy(struc
> > >       struct ttm_transfer_obj *fbo;
> > >
> > >       fbo =3D container_of(bo, struct ttm_transfer_obj, base);
> > > +     dma_resv_fini(&fbo->base.base._resv);
> > >       ttm_bo_put(fbo->bo);
> > >       kfree(fbo);
> > >  }
> >
> > Alas, this innocuous looking commit causes one of my systems to lock up
> > as soon as run startx.  This happens with the nouveau driver, two other
> > systems with radeon and intel graphics are not affected.  Also I only
> > noticed it in 5.10.77.  Kernels 5.15 and 5.14.16 are not affected, and =
I
> > do not use 5.4 anymore.
> >
> > I am not familiar with nouveau's ttm management and what has changed
> > there between 5.10 and 5.14, but maybe one of their developers can shed
> > a light on this.
> >
> > Cheers,
> >        Sven
> >
>
> could be related to 265ec0dd1a0d18f4114f62c0d4a794bb4e729bc1

maybe not.. but I did remember there being a few tmm related patches
which only hurt nouveau :/  I guess one could do a git bisect to
figure out what change "fixes" it. On which GPU do you see this
problem?

