Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA43C36F842
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhD3KEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 06:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhD3KEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 06:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF7E61434;
        Fri, 30 Apr 2021 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619777035;
        bh=EsspZG1wgaNj6zxFbJZ+pC1jl1In7YfEjcxpJcD5C18=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ks9kPDTlsbf2k8QONXVwjyYdmNM/oLdGwKS0at8YnVdOs3m55uX7awgXTVceT5Ba3
         tUDkg+IpykT8Hpm6jSGlGpGq1Ir1Dcb+L4NaoyXOwltM0cuFF93SH4FT36Ov1IHcov
         /Eu02B1s+jE+cYfpttFk1rMrQ2ClrfhrtTTpxhioNcPrZg1FQfNBbn5rr6dLS75QJ3
         Zx1Z/P7ots5vBYinbNGLKckI3hK3lgxPdGVvd1oVn9O6wYiK50cuYEfH7ntbvvVKg9
         /eWN9C0ehC9M8nf+ziwpow4q7r9pLxYPpyYEclrRh1YZTG5s4kmBv1kIn5TZugzX1K
         g2UdsmTs+ozag==
From:   Felipe Balbi <balbi@kernel.org>
To:     Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: imx8mp: detect dwc3 child nodes with name
 "usb*"
In-Reply-To: <20210430091512.1026996-1-hs@denx.de>
References: <20210430091512.1026996-1-hs@denx.de>
Date:   Fri, 30 Apr 2021 13:03:45 +0300
Message-ID: <87o8dwhywu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Heiko Schocher <hs@denx.de> writes:

> commit:
> d1689cd3c0f4: ("arm64: dts: imx8mp: Use the correct name for child node "=
snps, dwc3")
>
> renamed "dwc3@3*" nodes in imx8mp.dtsi to "usb@3*"
>
> glue layer dwc3-imx8mp.c searches for "dwc3" and so drop failure
> on boot:
> imx8mp-dwc3 32f10100.usb: failed to find dwc3 core child
> imx8mp-dwc3: probe of 32f10100.usb failed with error 1
> imx8mp-dwc3 32f10108.usb: failed to find dwc3 core child
> imx8mp-dwc3: probe of 32f10108.usb failed with error 1
>
> now. Fix this (and allow old style too)
>
> Tested on "PHYTEC phyBOARD-Pollux i.MX8MP" board.
>
> fixes: d1689cd3c0f4: ("arm64: dts: imx8mp: Use the correct name for child=
 node "snps, dwc3")
> Signed-off-by: Heiko Schocher <hs@denx.de>

already sent, see https://lore.kernel.org/r/1619765836-20387-1-git-send-ema=
il-jun.li@nxp.com

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCL1gERHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUiqMQgAkPTeaoKTrLM3Twvb0gZVanRZuuC5+uCq
UM9HH/Lj08k9Z9JLyDH3iqiXhFMupGeBlj41yjQrOStg/gFzyzoqlzpxhHgscXix
kO942is5cV7e71rz09f5NYi2QhL5CZ//KgUptJ6VWZUaV8KC/6cAFTcvsdoKMyj1
tV7mEY7dBiEttAT8wmUqOqchOBW7zX8OyQhgM1EbVqdgJM/kGUKd/Q+OTPogpnd+
3kGWQ5U1OgXILnsZH4VV9i8E+EGNwdHF6XE3TjFEkbM4NwLK9Xiv6j16B3IRoJ8h
vw+EfB60BhPwLGbnw9PTjN7IImVmdkYgfg56bnOFdbEVXpTE3TPsPg==
=8edI
-----END PGP SIGNATURE-----
--=-=-=--
