Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7443A840F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFOPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFOPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6686A61628;
        Tue, 15 Jun 2021 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623771283;
        bh=d14cFwvkQ17tOfAPl+ebV2HVKfhjCmFSqPChii5qe7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKu14XdOOA47tRQMguyFzEJ3OzKkBC+Ps8qbRQBDaruZIC0Ou72N6yruCm1fpFrou
         J1nK78JAgG/ubli/RssrL3mRRUyTNNtvRvjhDtMu0/ftpfTIs5n7FJ5aUIMDga6TuH
         ntEnrmYrLTAxn/mqcgEscurp5uq+bscNrGodhTjb0TYxsjMUzmmCLJwrygrRi9Sv3t
         THQlw0O89PfAUNGXBG2gHqqEI1CT+dnVXqe0H8uaEOlh54IKT6VGHQ8YcdVDPCakT6
         C+XgzmSXrq5RCqPgevB0RABJFVo1cfJUssMPnG5F14W9tk3y92PqWmG7dO45wxGkVI
         0I+E2A26Jv3PQ==
Date:   Tue, 15 Jun 2021 16:34:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Message-ID: <20210615153424.GJ5149@sirena.org.uk>
References: <20210615103947.3387994-1-axel.lin@ingics.com>
 <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
 <1623770667.4571.4.camel@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <1623770667.4571.4.camel@richtek.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 03:24:27PM +0000, cy_huang(=E9=BB=83=E5=95=9F=E5=8E=
=9F) wrote:

> No, you may misunderstand it.
> If vsel active is high, the normal voltage output register is vselh regis=
ter,
> and the suspend voltage is vsell register. Else, reverse.
>=20
> Axel's change will cause the normal/suspend voltage be configured for the=
 same
> register. It's not for our reference usage.

OK, can you please send a patch fixing this and explaining what the
problem was?

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIyH8ACgkQJNaLcl1U
h9B6ugf+JGEBnLVQDW5JP5tJ7NZ6H8b6MBADE/YCQuMdtWIwnp6tul0W9OO5wTzd
rvUWTg45gq5UJxFTPBVx5TsWDQexKhNq91q24cg6XNLXCHqih8qoywi09BX8q9R4
Lu/MQCp10q9lgjnrprpDoPo/6lZCwKU38Yjf5poWPtYIcIWMkuOb1S/Rv4RAMESV
K4gdxt54rdBp6LbKikWbtB4n7+lpX6yJp8Y3YAYTr+5EChGWP2E1+n551Nv2y1Qe
OZs0j/E2Bb/bSshzYY0Xas1gIUS6Rp39xU1JbTPkFwamgUl4sUgXvk1h/8pJWzLE
R/2GYzjUMxjTxk0CD/QmSeIIME3eOQ==
=o3JP
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
