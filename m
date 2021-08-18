Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654653EFD42
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhHRHAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:00:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47120 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhHRHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:00:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0950C1C0B77; Wed, 18 Aug 2021 09:00:02 +0200 (CEST)
Date:   Wed, 18 Aug 2021 09:00:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: trigger: remove reference to obsolete
 CONFIG_IDE_GD_ATA
Message-ID: <20210818070001.GD22282@amd>
References: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
 <20210804123426.16947-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20210804123426.16947-2-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-08-04 14:34:25, Lukas Bulwahn wrote:
> Commit b7fb14d3ac63 ("ide: remove the legacy ide driver") removes the
> definition of the config IDE_GD_ATA.
>=20
> So, remove the obsolete reference in ./drivers/leds/trigger/Kconfig.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, applied.
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEcr/EACgkQMOfwapXb+vLMBQCfdCzU/lz/6A94DTCvwmlxTCuq
DBMAnjyLKaVaJOMw0tLpHn5I835/BdZH
=NVt6
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
