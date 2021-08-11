Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4253E8E41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhHKKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhHKKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:15:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A7C061765;
        Wed, 11 Aug 2021 03:14:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15so1551356wmj.1;
        Wed, 11 Aug 2021 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIoTEsdxgD+rQHM+TTvpsF8TMu7RDq5yzsyDpH04EdQ=;
        b=Hus6VAqtAaET1LurL6mMZkdsWOS/A0JniOgBsFqHzyKoTRPbz0DXhdUGPyscKR8EYw
         /cQvqDsmTv2Y527RDnEZuYpVDbIKbliufTmO/CRXIVYUDTf9xI5wBsqorIwB2g9ugPlv
         SdFXOh7ullggxoAZhP3TOUxfIT7ocsm5vgAHR9hIDNNGDEFDN1ztByDsdRp4KeWhZefA
         8bsaQXXqB1TnHrys05CDyJLNP5+aN8GRmRQF7gdSq4HLYVXF4PhQz8x9r+6ziup+ykU6
         d2HKFJ4myjbaa40GTNZ2PNTvBNVbqTyenBoh5EqzG7J6eE2VCY9V24RNQN39/8cKKpT/
         XYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIoTEsdxgD+rQHM+TTvpsF8TMu7RDq5yzsyDpH04EdQ=;
        b=APNgNPYkP1lTb4aBQzD3DLHE/r7jIu4gcozi+WsZiqDSzDRgd3B6ugnCw4d3X4L3fw
         gFz5PNfpe7/kwpADH/e1hCWhVy8f22ppYzYNW+IeoUgbfxf04DQqViMWvCS6GexC7239
         pIgaVy1D4UMXDsnBqAEcQkDDDkTHqVU8pNmV78vEIHymA83sxq/W3ridxAeh2af/3WJ0
         RmrxYTo0JBBd8P2+4ygxOaR5hb1JsplahFf3hoi98eKF4jy77lkgXhNJTCgf51AzuHbj
         pv30uMHMy3G0EM1lBw5l1XYP1DNdFZIfu7UsAlNze78QWFqWVarIibwNAApjlr/WZ3wv
         TEXw==
X-Gm-Message-State: AOAM530klAML4odzrZJBP1/V6q/U3zLAWFrzUJ/HSfUh4MJmx/rH5FCZ
        EfHujC2lOKU7NzT58Rm2t+8=
X-Google-Smtp-Source: ABdhPJyeZbyPbhlMNdXLlQiI7O7Kxacx895cF0VStOiPQg/X1NnAm+3Nb6MxPi8Zc+ALtu5hZVPSfQ==
X-Received: by 2002:a05:600c:3555:: with SMTP id i21mr20531484wmq.156.1628676887539;
        Wed, 11 Aug 2021 03:14:47 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id z17sm26872858wrt.47.2021.08.11.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:14:46 -0700 (PDT)
Date:   Wed, 11 Aug 2021 12:17:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Tegra Kconfig improvements for 5.15
Message-ID: <YROjp3WQfWo4Jvm7@orome.fritz.box>
References: <20210714025127.2411-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WS9QCbIpLi0WkVgN"
Content-Disposition: inline
In-Reply-To: <20210714025127.2411-1-digetx@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WS9QCbIpLi0WkVgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 05:51:20AM +0300, Dmitry Osipenko wrote:
> This series enables new Kconfig options, it also fixes CONFIG_FB and
> CROS_EC options.
>=20
> Changelog:
>=20
> v2: - Added two more patches from Maxim Schwalm that are fixing CROS_EC
>       options and refreshing tegra_defconfig.
>=20
>     - Added fixes tag to the CONFIG_FB patch, thanks to Maxim for finding
>       the offending commit.
>=20
> Dmitry Osipenko (5):
>   ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
>   ARM: tegra_defconfig: Enable CONFIG_FB
>   ARM: tegra_defconfig: Enable Acer A500 drivers
>   ARM: multi_v7_defconfig: Enable Acer A500 drivers
>   ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
>=20
> Maxim Schwalm (2):
>   ARM: tegra_defconfig: Enable CONFIG_CROS_EC
>   ARM: tegra_defconfig: Rebuild defconfig
>=20
>  arch/arm/configs/multi_v7_defconfig |  4 ++++
>  arch/arm/configs/tegra_defconfig    | 25 ++++++++-----------------
>  2 files changed, 12 insertions(+), 17 deletions(-)

Applied, thanks.

Thierry

--WS9QCbIpLi0WkVgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmETo6cACgkQ3SOs138+
s6Fv9A//eYUenPejiWCCQy6sNLaZkec3RcZ3Ic26R0lvy/WdfvuJFIxNrAMlfZBg
XT7iDUurOZUV3odwv6Qyn1DYKrr+ji8Gpc9UDN0gW8WP9LmSvhlBdFZ3EN+KPD5P
XPO9CQTOvyX4Sdg3cog/3baVv6DBXcnEcbLeLaV/YbrDh9pPj8atuvcOcGOLdldu
2xinbCMfhDU0redKrVe1HDyXzbEf9Iatnj0Vi8WRW5TDY0VnH4ygJzFb+kjY2YfF
seX9LpvIl40lTVAfQsXhi1EXWu5G9yX9neda0h/7yzQ06CbZzGCD610OnlwDJ7JW
FQiDBe+abf1s+wdsAxcru6tBjq2qd254iKwWmrxqC8VjsSvrMU1N+1VDgC7hPw6A
7uTDD/xgD/dpne95QB54XNqI0zpfGbEqiIrPhmDoctCnBTq21CNkSneXW2tceVE8
0o9gd7bO3NpIT2XLStNqhASo2MbEL/rWVqqFvGqsOwUjJ4NpnxYDuIXWp5lSZxSZ
HmJl5MNESk0vcsMwvGC4VlhBhAYXAR4TruL+Gmm5rXbMpHxDqx0paHvnBXsfqBaz
Ju2XtYooKkq4wxJ/k5DFGhZDUM8484NQEj175ULDBk7rC4wZjaBgzhp2sw2FBWmz
qktDqFzZfaerS31JzQTZflXEdb21NV3HxPb8l8ePQTRTtnyerLE=
=b/wg
-----END PGP SIGNATURE-----

--WS9QCbIpLi0WkVgN--
