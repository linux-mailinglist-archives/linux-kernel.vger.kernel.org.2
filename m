Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80A332A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCIPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhCIPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:36:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE3A65238;
        Tue,  9 Mar 2021 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615304166;
        bh=Pofaxorq7jn6ioWTVLvagneI4H/1LHRmxp4Zb18QVAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2r/7/r1ukV3G49vkayekVLr8eKvRHwVVLMgi2LCWRjExlht8QRFMuP8TwT1LvHzv
         M++Z9Q7QPMPisXlegJpRPpNekSitAwMOPgVDOE/j6slSVR6A4rdnKcqdsy7+96K61/
         jh2qpMP1kJq1UyBqEgLJa0OIuomSNPGk0g8VtgtLsipceGqUOtksXxJ8aNza/NfoAl
         M2Osg5Obvrxyz/TwzMrRzDDvWbPh9t76Pv2Cq9O06c/rOLBOgLbGw6bhEz4Ermfnxn
         JLk99+/1BybsjNfr8v53mijg+vt4qD1uVLTXgCvEy/Q9OuxCEza8Ilc2zSELLCCr0/
         ASGq7tYFPd2FA==
Date:   Tue, 9 Mar 2021 15:34:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: core: Don't set platform name when of_node is set
Message-ID: <20210309153455.GB4878@sirena.org.uk>
References: <20210309082328.38388-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20210309082328.38388-1-daniel.baluta@oss.nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 09, 2021 at 10:23:28AM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> Platform may be specified by either name or OF node but not
> both.
>=20
> For OF node platforms (e.g i.MX) we end up with both platform name
> and of_node set and sound card registration will fail with the error:
>=20
>   asoc-simple-card sof-sound-wm8960: ASoC: Neither/both
>   platform name/of_node are set for sai1-wm8960-hifi

This doesn't actually say what the change does.

> -			dai_link->platforms->name =3D component->name;
> +
> +			if (!dai_link->platforms->of_node)
> +				dai_link->platforms->name =3D component->name;

Why would we prefer the node name over something explicitly configured?

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBHlZ8ACgkQJNaLcl1U
h9CCjwf+KGK9CFvGq0ABRqnlUjLRBWp+vksCfNrIv+WEUvyvWh0ZHjOjOJb5xLP7
uuf4ei9nQDAeyTh7/jDpU2l2/GUUYuJ/6IRRsgZr2OpxEFOGiH5A0U4Yv5fIPB9p
DLmqYFD44/QqRnX5aXSq2eTFYcZPWElrkXgZcxeq65kSRJAtf2okS9x8XnmuBHiY
h0nb6Q3oTf7PnFoHKHxD93BY5dDuoCz3Ge+hs3+L/piVC/9qDzSnzrHbOl14aZKP
/S/r/QY8eQ5A2caYQl3JLFaETl6/baRcgH8CP6LSvnLJJH78tsbaOEQhTeYiBKX8
VNfo+jBBZJBxvqhOiN41oxupo38zhQ==
=H9TN
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
