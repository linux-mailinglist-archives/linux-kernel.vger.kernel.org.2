Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C63EFD68
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhHRHJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:09:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48592 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhHRHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:09:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BFAAE1C0B7A; Wed, 18 Aug 2021 09:09:02 +0200 (CEST)
Date:   Wed, 18 Aug 2021 09:09:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Remove the unused white LED
 channel
Message-ID: <20210818070902.GH22282@amd>
References: <20210818070209.1540451-1-michal.vokac@ysoft.com>
 <20210818070209.1540451-2-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <20210818070209.1540451-2-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-08-18 09:02:09, Michal Vok=C3=A1=C4=8D wrote:
> Since the reg property was added to each channel node in commit
> b86d3d21cd4c ("ARM: dts: imx6dl-yapp4: Add reg property to the lp5562
> channel node") it is possible to skip unused channels.
>=20
> Remove the actually unused white LED channel.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEcsg4ACgkQMOfwapXb+vItPgCfS45AP+0FhJC8K4AVj9j3Aj8+
T/YAnR7DJpwgkhHZycBroWk//I05RFn3
=+qTp
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
