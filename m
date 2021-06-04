Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20439BADE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFDO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFDO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:27:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 111E6613FF;
        Fri,  4 Jun 2021 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622816766;
        bh=6qcDrWQa4+6z+ZkRiDCUGgmZILuI30SH1Dvb5rIUE4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K41Bhwd0MOusWyBzUd4UFF+NmX33eK33EeXt4X5BT4/V60KJ4oGtNjF/k0FXmXwmN
         zV2O40ms+G8QPax7JsusAeriGbq+ltfYVMbo4TVsWx8HvlMB9LiSTiBoDSfUFyR65v
         8O7z1jatuH37f5DFL4OE+gs4C3369x+rFtXkQz3tiz2srNQ3P9USfQb57V/SxiKUGY
         tgCOmv7zcPr4pFmOmc7Nu6Osoi1ql1aXpgeYOGedX+Y6+drTwo/HN4s4kBpKfU4tg2
         DnNZxQVodxCEq+94EVn2qysKSgs/bHsg9yDZPYcOqipto+95GnjLbAXIO4rU6foeLT
         8wwya6uRfNBzA==
Date:   Fri, 4 Jun 2021 15:25:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com
Subject: Re: [PATCH] ASoC: rk817: Remove unneeded semicolon
Message-ID: <20210604142554.GA582@sirena.org.uk>
References: <1622802209-45031-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1622802209-45031-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Cookie: Truth is free, but information costs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 06:23:29PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
>=20
> ./sound/soc/codecs/rk817_codec.c:49:2-3: Unneeded semicolon.

This doesn't apply against current code, please check and resend.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6N/IACgkQJNaLcl1U
h9Aw2Af/ZhDgCHIjE+l4J8Du0e1i6r7rFyERFiVVkaAsCDw21i/pdRYBS1c00kgn
DPRCorTuIUidRsYWnC6VkB6yLFC0O0kZrSuKro+jGMXeCR5OBDn8gzOyPdgmaxGa
YZ2ILiWlcWZR0cSIsFwVJ2UZcrDN7lIffjyV7o8JCoq3LKF/JHC9oYvDzqmZzWUX
bj3KxrwErBys9al5zzALFtfUNCat2bjsCxB111qTg6fiFZq4k1Crzeb56GhCnQRn
IQ+8yXOsmx9vp238kLIoB4n6ZneK7AY16AxlpcKFgbf0WzlzOOIiO1gdLVgHyr5m
4jkQfukW/B56BN0OoGWcPPvkumrKiA==
=gP8F
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
