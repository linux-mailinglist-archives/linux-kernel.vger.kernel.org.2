Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33C635ACEF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhDJL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:28:54 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42924 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:28:53 -0400
Received: by mail-wr1-f41.google.com with SMTP id p6so1361895wrn.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPyvO5p6R4xdh4iYQtis3fsH4ovA9npNrFpGcTCeObA=;
        b=QVq/yqPGKDf7m3pojLmpEIXx+/JE8TcdlJh/3g4dj8SRPo8wpDZTCPTuZ7zWKELcht
         E2NOZGLb1CoY6O02kGLNgR44rf3QuvxOONHfWUr0Ls+Wucsu8hkHLa58pvzjvh4XZuwV
         eIM2q5vJKscWvKsF2fpysP25Cl/jU5EvjlPhF0aV1TLYrH8/D9ZQAHoCKUklwFcI3upo
         LCF+Hn2Id8R3bJLwOAi5uRv91NNx1j0cbEDCxQKc0fY4bvVVl87HebCExtk+xDDULS6+
         /PPVcNa5L+OAk1rT9nhiWIXiz+3R2Gtmz3Tyu7EzrnLsgEBXPCsp32SMLNuUs3F5yX8y
         7muQ==
X-Gm-Message-State: AOAM5307x6TXqmy1HjNThMYV8JmFq+g71lLT7UKwR+ZblNAktF6UoM7W
        65X+JjNjw3kmpZGRPS1/Ox6FiCEPX3zT
X-Google-Smtp-Source: ABdhPJynBMcvUr2DdfhGGZ4c7MRuxMUjp1OO98n0DRpeXskW9TltMiVUSsk4ac/i7njP6gJ2ngyfBA==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr22001123wrn.144.1618054118246;
        Sat, 10 Apr 2021 04:28:38 -0700 (PDT)
Received: from tesla ([2a02:c7d:8e07:7c00:3e97:eff:feb3:72f1])
        by smtp.gmail.com with ESMTPSA id f8sm8558775wro.29.2021.04.10.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:28:37 -0700 (PDT)
Date:   Sat, 10 Apr 2021 12:28:36 +0100
From:   Javi Merino <javi.merino@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, thara.gopinath@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com
Subject: Re: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
Message-ID: <YHGL5MDcOnXPRL+0@tesla>
References: <20210217115908.22547-1-lukasz.luba@arm.com>
 <20210218041812.o2yksgbfdvbgtwc4@vireshk-i7>
 <e3208461-f4ec-8c88-8af4-67c777f9382a@arm.com>
 <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bszoGADahcLG+mih"
Content-Disposition: inline
In-Reply-To: <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bszoGADahcLG+mih
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 02, 2021 at 12:53:08PM +0200, Daniel Lezcano wrote:
> On 02/04/2021 12:25, Lukasz Luba wrote:
> > Hi Viresh, Daniel
> >=20
> > On 2/18/21 4:18 AM, Viresh Kumar wrote:
> >> On 17-02-21, 11:59, Lukasz Luba wrote:
> >>> Update maintainers responsible for CPU cooling on Arm side.
> >>>
> >>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>> ---
> >>> Hi Daniel,
> >>>
> >>> Please ignore the previous email and that this change with 'R'.
> >>> Javi will ack it later.
> >>>
> >>> Regards,
> >>> Lukasz
> >>>
> >>> =C2=A0 MAINTAINERS | 2 +-
> >>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index f32ebcff37d2..fe34f56acb0f 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
> >>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Amit Daniel Kachhap <amit.kachhap@gmail.c=
om>
> >>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Viresh Kumar <viresh.kumar@linaro.org>
> >>> -M:=C2=A0=C2=A0=C2=A0 Javi Merino <javi.merino@kernel.org>
> >>> +R:=C2=A0=C2=A0=C2=A0 Lukasz Luba <lukasz.luba@arm.com>
> >>> =C2=A0 L:=C2=A0=C2=A0=C2=A0 linux-pm@vger.kernel.org
> >>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Supported
> >>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 Documentation/driver-api/thermal/cpu-cool=
ing-api.rst
> >>
> >> Good that we have one more reviewer for this :)
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >=20
> > I believe it has lost somewhere in people mailboxes.
> >=20
> > Thank you Viresh for the ACK.
> >=20
> > Could you Daniel (or you Viresh) take this patch, please?
>=20
> I was expecting Javi to ack it.

I did, but it looks like my replies never made it to the mailing
list.  Anyway, here it is:

Acked-by: Javi Merino <javi.merino@kernel.org>

--bszoGADahcLG+mih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE9DQZSW3HuWfDbCD6B7SEUnaNOCQFAmBxi90ACgkQB7SEUnaN
OCQseg//dE9dpv0kXK9nTTM7BeAwDYK8zeYiNe0zoTS37vD2hLq2bf/yEF5O/UF8
y5hG1HF1o7vD/7qWOMmaFIsfLzmt2tUPNeIIFHP275voD1pFy55ORuQounRq6d+h
9cRAEAVQEpNQhdIFE7A07EZNu3fluxN9yS5ORQ0mRfcHlwW2JrjHU4OT8SRMhU/5
NhTSv6iZDrfzjxBJeI2sFmFyX9sE+gbmA4aw01EDrqgiZWR5wjqYZPfM1pS4CJEV
vt/UmHbnqBTS3MDNdIqtcUzbBGCOjIz8JFeg7I3lnSiM8zm83TkyWIcw+b591U4C
PP6uN9ukppFFUYXGXs2vnhlDVURRN2N41NBZEoIVmiBdDwXAnMLpF/0uvBKNZ6cD
qlPRQuZc4Ro4gl7B/EV2F3etgn3TakloHjZrNEdEx36V5e6BHznyRvERC4ECT3C2
sV6em3KMbBlokN2w4mYI9q+lntFkUvbhyx0TOJkF212z6gvNvTkHEYGPGaLFSBwc
+Jm1t9HwRrq9yELDF0YKucmIkr34JZctRSrC2SZeHB5S8wEu9bdooE1tbTjcCn/r
4mpfXInc7sm4t4m8pai0QNq9+dMQnOGT/x5vYJapv77awYlHWMxdnU6fOzEipjnT
F4A66+rnQeN2SvbbODNY1LrQ/lrAeCAFkQrvONHF9ovOtAdU+Vg=
=jdq0
-----END PGP SIGNATURE-----

--bszoGADahcLG+mih--
