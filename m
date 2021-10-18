Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC243119D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJRHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhJRHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:55:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3ACC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:53:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g36so48916866lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=bxVfna16cxYfDlVbnANGIk1HnqAlhaGCp7nH9Gcyq9c=;
        b=QyLwGECEiYP1tJgmurcHjGRXiqLiWofwug6J9SuebZVlwQz8UkoJoD6p9UARsKPksg
         PvCS4852EoKb7J2dgpT1n21mSVuS9nw/yGKFRgoaIFVKr8l9lMbnCGY+GkstLoQedYuF
         djCXmmzV2NmTnK8+h2RETDke0UdWle0a6I8a0U8dhETpFX1ncNPQhGYkmEx7wjZiiLtA
         GUGK2Mk184V+bkVl75e2X2ALndjYH9/jaEfhcPe272pQpNHA1yghoJYEd5GMHfkHLPb/
         fggGNtKoY+mKYJ3yLezM23G8438PvhM62289/RhY0iG1ro3arfvQneGQmGrNtFkIYROx
         VDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=bxVfna16cxYfDlVbnANGIk1HnqAlhaGCp7nH9Gcyq9c=;
        b=7wH7FKdiy6XaCX0PsYt2Q+wYQd6g4XKKwpHDF0+IIcV7dIlWBlfqtgdGs0HdIrq33z
         wZorwCjF5GpO4FQRUy9aE6id5GFzebxXoKoPS6xmV9VgbN1YtlZDEtYvXTCZ6+/VjSEB
         uozmApD9nQoO+VVr3rbi8uEIeV0th4Etoeh/t9wFfSTUvdN96eiQVV5EgceyUBxCDY+c
         vGRxxILgBmQWSdy/ir6v4FMixKC8Fx5sK9CqHPJ7kgb/sbBojwIzT83AGRZMeE2CNz84
         3a5zh3MA+SXs84OyQ7rts9WbpWWDiqbTGiMsgO+lff9vufAv2Y6OLLPM8i1osf3kxFEM
         05uw==
X-Gm-Message-State: AOAM532ig/vdL5SRuzCSwwXOsvY6tjlKhhsMliKt4hguMHvJ9cGPOLwZ
        ljfd2tgOgsteFNkRkwE/0sA=
X-Google-Smtp-Source: ABdhPJwNxZP5kz/BgybStPT9EfAJaqXhusTVgcjXO5hDjCD2qbaxLsRU94qz33GF68bDyLtUOTV41g==
X-Received: by 2002:a05:6512:31b:: with SMTP id t27mr28619056lfp.688.1634543622240;
        Mon, 18 Oct 2021 00:53:42 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id h23sm1541000ljl.35.2021.10.18.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 00:53:41 -0700 (PDT)
Date:   Mon, 18 Oct 2021 10:53:33 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH 0/6] Refactor the vkms to accept new formats
Message-ID: <20211018105333.5f1bf9fe@eldfell>
In-Reply-To: <20211005201637.58563-1-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R_1IcPyF+kFhqCYh6Korsfw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R_1IcPyF+kFhqCYh6Korsfw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Oct 2021 17:16:31 -0300
Igor Matheus Andrade Torrente <igormtorrente@gmail.com> wrote:

> XRGB to ARGB behavior
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> During the development, I decided to always fill the alpha channel of
> the output pixel whenever the conversion from a format without an alpha
> channel to ARGB16161616 is necessary. Therefore, I ignore the value
> received from the XRGB and overwrite the value with 0xFFFF.
>=20
> My question is, is this behavior acceptable?

Hi,

that is the expected behaviour. X channel values must never affect
anything on screen, hence they must never affect other channels'
values. You are free to completely ignore X channel values, and if your
output buffer has X channel, then you are free to write (or not write,
unless for security reasons) whatever into it.


Thanks,
pq

>=20
> [1] https://lists.freedesktop.org/archives/igt-dev/2021-October/036125.ht=
ml
>=20
> Igor Matheus Andrade Torrente (6):
>   drm: vkms: Replace the deprecated drm_mode_config_init
>   drm: vkms: Alloc the compose frame using vzalloc
>   drm: vkms: Replace hardcoded value of `vkms_composer.map` to
>     DRM_FORMAT_MAX_PLANES
>   drm: vkms: Add fb information to `vkms_writeback_job`
>   drm: vkms: Prepare `vkms_wb_encoder_atomic_check` to accept multiple
>     formats
>   drm: vkms: Refactor the plane composer to accept new formats
>=20
>  drivers/gpu/drm/vkms/vkms_composer.c  | 275 ++++++++++++++------------
>  drivers/gpu/drm/vkms/vkms_drv.c       |   5 +-
>  drivers/gpu/drm/vkms/vkms_drv.h       |  12 +-
>  drivers/gpu/drm/vkms/vkms_formats.h   | 125 ++++++++++++
>  drivers/gpu/drm/vkms/vkms_writeback.c |  27 ++-
>  5 files changed, 304 insertions(+), 140 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_formats.h
>=20


--Sig_/R_1IcPyF+kFhqCYh6Korsfw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmFtJ/0ACgkQI1/ltBGq
qqf0HRAArta1tWtQSDyslMERLLK3UK0+yHfQBtIIII8mW2/1JMShM7dwdnB/CJGb
7J+135bmSCr0WV1pm2LTSOjfSN5Z+9OZvdUgqY2/l7aWGRcK9jMfm6sndwI+PW1y
WOXhpmkT0dKAjPMAKRKpnUSi9+msjEMqBc/vB4rWYciYNc3vhS1Mj5HWJTUT8FUg
cCWSNUfzjCZ8zBWEvEQODJDUXK/XhND9OhFN83PYcDKcalSt1sA6waVDbi0IlH/S
l7Qm2MwdGrF3KsHqwqciMHyo8i2B5+Ty1u4TBC7pB9NXv4U7jx6osfHhMThsnHRH
ZMf17yMftnZMYgH3WSLGPoRswWwl/J6X72CbHhAz3TKrjDPkbNFxH1pLfSUeosLz
3gRNgJ3noTSTV/0Zbd9AXX61R4MoyWoiW6+k0Sh4GQxu9drNkUrcXnvj3tsst5c6
MFEiQoOeVoaSSrc1w3oJ1TS8HFpS831NLuSg2zG3H1OBSkEWLLU3Sc1fi3APYfzd
xWHZFUUN9waAZhqqD3T50FTkgGyvCT+Y2Nim/PDdMZAL8IZq8ZTFB1vSrK+/sN91
/YlJOvXvWVZW1BWvf/8jZTcLjxOGP+PVxj+wZypA1EhFNIE0MhMbsOsfjrOOYdE4
y2T6KudEskkKtG9e9VzrGAI1c0MajORuqAtuaUOQJyAtDh5gUKo=
=Xvh9
-----END PGP SIGNATURE-----

--Sig_/R_1IcPyF+kFhqCYh6Korsfw--
