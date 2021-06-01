Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8322E3973A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFAM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhFAM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:58:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D856135D;
        Tue,  1 Jun 2021 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622552178;
        bh=2Cl6MC1zMLi1wVlxtabUNKw40xMLYyr3h9FF5PfzyX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnvVCbpOOeN9rkItCc/yoTJVnjIYphOmRUyy31lUnBN16ztG508cC6bnbwExyyPfz
         4frf2pAynhv11HOAms0oRJEahYMeG0tJWXOcmnXyaYSyI5zbD90fISxnTj4ZD6Zrsu
         4KHdr3lui/UR2XVz30gQggHNZhJS55ocfbFdK16AfxECbi+7onftdTHdC+8eHRpC82
         GWlAQENZUjuDWUGrWnwevhodDw/4bAXrNsXQkb3paumbXLiPRNnt3HSl2qklurQNhy
         3q5C+9yipXhvNBsOICFkwI5+XJgxlaAX54znzWYBKxd9gnLFPnGUHNcCqiwrtgL6xa
         WhMI/9Tmb8M+Q==
Date:   Tue, 1 Jun 2021 13:56:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, ezequiel@collabora.com,
        chenjh@rock-chips.com, pgwipeout@gmail.com
Subject: Re: [PATCH v2] regulator: fan53555: add tcs4526
Message-ID: <20210601125608.GC4089@sirena.org.uk>
References: <20210526162342.GA20@8bbba9ba63a4>
 <20210528101946.GA418765@96e513df87d1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20210528101946.GA418765@96e513df87d1>
X-Cookie: Sic Transit Gloria Thursdi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 10:19:50AM +0000, Rudi Heitbaum wrote:

> ---
>  drivers/regulator/fan53555.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20

This is adding a new DT binding, it needs to update the binding document
too.

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC2LmcACgkQJNaLcl1U
h9BzHAf9G464dHNtQknzDW/5kAgdMbejI7xxx5QTf4tseVQ6XY22i3ThsC5iivxi
5OiLoEmJJ62CFt4fcej2+g9xrtqlrML+fU+D1YwIV4JnBKcNwf1PUKsufpxZdlOl
jVRFThjrGk8ZXaYnuVu+U+9FbnoYGzidvMT8xdWqcDCUhGT0mUpMcQP3jAsRWXIh
XqsJpBQrLyCoZE188rbXZN5PEyRHKymDKzSCgJalshiSxReexKZpeJNgZ8IEFcaE
LZOQNJv01ie/uh7h1Y+5C0bDNlHM6HE89egEY+ATVbx5uHpH2r3GN8wMtBHJk5Hx
s9+s5oOePen3qqty+jum80ZePycKGg==
=8JU/
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
