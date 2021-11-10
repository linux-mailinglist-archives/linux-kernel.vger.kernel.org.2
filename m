Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327C044BD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKJJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJJHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:07:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671AC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:04:47 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so4342986lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=HQWUub7VLNdwBSHnx+JE2hlji0Dkf+2DqDY0ZqCPbLc=;
        b=lQiUzHeGkagsLJbfrGTBkjqm8aetPqgR3GbDFWg1BAHcoQew+DGIVL2ov8Ne0HES2k
         Yo7E9nK25aJnSqNzgjagzgzWyCogccHltSgbCCRvLnxjqe6/OSzl/P9XOJCuifM8iLyT
         X+8laDbXuRlrwYR9SdwF+XS/SY0IAUrM8YsFTFkZVSpPpv1QmNh2xlsOsDo2Haal9ij0
         KINdfHpNCq8RgX7IgIey7eCNNw4DubkMpAuJ2zU4FgoGs4savYFltZ69s6CIlW+5oc+5
         w9YzD6zqHkP3zq389BuI0Bzzlm6P+MBQAm1QTqxzZm6syLBjf3IZo6kD3db7sUar3WRP
         UTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=HQWUub7VLNdwBSHnx+JE2hlji0Dkf+2DqDY0ZqCPbLc=;
        b=NVrJ9C8pUzhIjgqyWDLbdRJqd5Y0WeAuLzNHZbEI8LHzJtRAVQR21Hs9IqmMA3HSVn
         2OSmFXTdhu3m4BbUaL8Z6cwYck2yFjfGGSu8vDZV6D7aXfQBHxOYFpqEGWEtziBSb2Zi
         DAcxxuVrsqpwX28sQUDpaJGT3QGhSATBe/8UkUSmKQ0Hmh+G46buw5nSvpVwJTS5ur3L
         6aXox8f2j9fuhm+q6YZ2NCW4XbyQL5G6inZfrGf/O+/nFG+anj5FPhIWdbvYyohAr1Km
         2OzdzEeCB2Q7OlQNngaKXRpmgt8yU5Q6A1for+HtuN3USm16wZHnPykWrQAfXgoj8aJ+
         s4Aw==
X-Gm-Message-State: AOAM530GP/icryEbH2vGztQ6xNsufynHbI65yEepdLF5xjBwQx1FyyC8
        S13mQU3HbFkOAR7AQ0ohv04=
X-Google-Smtp-Source: ABdhPJztyr/6yDe3gRE12AMmYSUao1rUN8CaKuWnrLvV0yuzBjFNj4OCIsCu/TrZseTLavBK+DWESg==
X-Received: by 2002:ac2:4c55:: with SMTP id o21mr13107354lfk.408.1636535085468;
        Wed, 10 Nov 2021 01:04:45 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id c2sm484485ljf.50.2021.11.10.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 01:04:45 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:04:42 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
Message-ID: <20211110110442.1743b0d2@eldfell>
In-Reply-To: <CAEg-Je-mmwZOGR-J-dTcOs-8x2BfgCtv5GwFy_d9rBkxOZ1YBg@mail.gmail.com>
References: <20211103104812.1022936-1-javierm@redhat.com>
        <20211103104812.1022936-3-javierm@redhat.com>
        <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
        <1dbc7d15-a314-677b-1870-276b0cca1705@suse.de>
        <CAEg-Je-mmwZOGR-J-dTcOs-8x2BfgCtv5GwFy_d9rBkxOZ1YBg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GBZoySIpsQ2kQYmHUWrMzmj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GBZoySIpsQ2kQYmHUWrMzmj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Nov 2021 08:34:20 -0400
Neal Gompa <ngompa13@gmail.com> wrote:

> On Wed, Nov 3, 2021 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wr=
ote:
> >
> > Hi
> >
> > Am 03.11.21 um 12:05 schrieb Neal Gompa: =20
> > > On Wed, Nov 3, 2021 at 6:48 AM Javier Martinez Canillas
> > > <javierm@redhat.com> wrote: =20
> > >>
> > >> The "nomodeset" kernel cmdline parameter is handled by the vgacon dr=
iver
> > >> but the exported vgacon_text_force() symbol is only used by DRM driv=
ers.
> > >>
> > >> It makes much more sense for the parameter logic to be in the subsys=
tem
> > >> of the drivers that are making use of it. Let's move that to DRM.
> > >>
> > >> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > >> --- =20
> > >
> > > Please no, I'd much rather have a better, more meaningful option
> > > instead of "nomodeset". If anything, I would like this option to
> > > eventually do nothing and replace it with a better named option that's
> > > namespaced by drm on the command-line. That was part of the feedback I
> > > gave in the original patch set, and I still stand by that. =20
> >
> > This was nack'ed for now during irc chats with others. There was no
> > clear semantics for the new parameter and nomodeset is good enough for
> > now. I agree that nomodeset is badly named, though.
> > =20
>=20
> Where are these chats happening? I'm mostly talking to Javier in the
> #devel:fedoraproject.org Matrix room, so I don't know about anything
> else...

OFTC IRC channel #dri-devel


Thanks,
pq

--Sig_/GBZoySIpsQ2kQYmHUWrMzmj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmGLiyoACgkQI1/ltBGq
qqcaUw/+Jk5Wb0tkqXt5grtkWI9ckpKkt2KRzVhuRjoUEAo47Tpntm5dlETkT8Ah
EJEaKvYvI9gw91BVSy3teCLbUu2TAdfnK/maO4Kg3n8JhAW9OxPJrMbZoUaR3kNa
O5qxgE1DuM8qjNcLwvYU4p8/F1hMFNG6KHM2g2Jx9CX1W2fmpbSxEpTTnugGQxRW
mQVx4/YgC2WcWOwtjLO+NP915PTuJjMhdpBGLsUYCy8bEQHZEMeatsA/5qqQMIK0
2kpDN1YV9k7ALtzHtTdArKgz3AqmDlFOzglt+XFgpr7YcBe02ulKDkruf0kQe4X2
MGXsLHetaEDZ6nErLKsw87wQSf+qi6esQnI7aH+TZu7RQr48qUSeraXj2r3/6s46
gFwUUd1IqoMxY3h+0O4Y61R/z3Wp0o4ZtoAVCO7gzgeQuxWai6M0+MZpnKCG4GjP
oJYRp38ckrXN1xC02Xb3n8awNTQSUb1+PARthBG4hMedKAeHy/0BllAeO01QUx3u
g+jaYKXDk1npj65lyB42KTgdOzrIJ6cEbWDftNg91kn/nSu5GjqIaegPbB2d59of
c7meiRpM/SgRcbkwkkAbM+ohn35FtP6usQ8LFXgcRK13T1p1W9E3RreddxYUQaBN
j2d92zAbUaWXLkc/fK+BHTMDMFcoQkbiWyTDLx/VotKsvkq3Rsw=
=RkEM
-----END PGP SIGNATURE-----

--Sig_/GBZoySIpsQ2kQYmHUWrMzmj--
