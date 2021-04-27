Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7636C17E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhD0JNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:13:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42508 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:13:18 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE3671C0B79; Tue, 27 Apr 2021 11:11:33 +0200 (CEST)
Date:   Tue, 27 Apr 2021 11:11:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rename LED label for NanoPi R4S
Message-ID: <20210427091132.GA9373@amd>
References: <20210426114652.29542-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20210426114652.29542-1-cnsztl@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-04-26 19:46:52, Tianling Shen wrote:
> However "sys" is not a valid function, and it is always on.
> Let's keep existing functions.
>=20
> Fixes: db792e9adbf85f ("rockchip: rk3399: Add support for FriendlyARM Nan=
oPi R4S")
>=20

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCH1UQACgkQMOfwapXb+vIytgCgsvCEfJXxZS5O2ixhW9KWCWq2
w3wAn0V4RXIAUDnRv0twwb9Uy9EseOV2
=DyY8
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
