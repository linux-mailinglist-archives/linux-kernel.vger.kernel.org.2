Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B13B058B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFVNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhFVNMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40B1660FE9;
        Tue, 22 Jun 2021 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624367420;
        bh=rlrdiEcg+ZdW8e/s7MAfxIo34DErh21S+v44x3rwdyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LantDriewHoCNU2TGw/y4EPc+TqjEPG668DKavCzECbRsS5XdW0noh2Q5y2qEu6V4
         mJY2okdU3SCme7DOvhLkkgbM5515u4h0HrOhQaT2/5NWse5DkJt+m/WabgbJDf1TdC
         9uTHcmrGJEqZ+BOSRLtztLkbQ7H18X4x8nJX6EPOEvYYyMCtQbroeMfct8YUh7AfMd
         xxsobEl9aW+C88bu1TRC3WbDyhe98/RfFCSGoB06EJYTVAB2gMSEUiiUtBJ0UUpKdz
         i+cRoN08Xzlk9HzOlzpJ3UZtyKJ15h5JuxeBxFzvPtCSv8EdRTI8CuKVYheyCDauGr
         UgWy9lHkZ7a+Q==
Date:   Tue, 22 Jun 2021 14:09:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH v3 1/2] regulator: da9063: Use __stringify_1
Message-ID: <20210622130956.GD4574@sirena.org.uk>
References: <ad5355c28c25fc273a450a11bc82f201fffad8cf.1624147922.git.plr.vincent@gmail.com>
 <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624365748.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624365748.git.plr.vincent@gmail.com>
X-Cookie: fortune: not found
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 22, 2021 at 12:45:19PM +0000, Vincent Pelletier wrote:
> Indirect stringification is not intended here, and generated names may
> unintentionally conflict with macros.

Please don't submit new patches in reply to old serieses, it makes it
easy for things to get missed and creates confusion about what the
current versions of things are.  It's better to post new things as
independent serieses.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDR4SMACgkQJNaLcl1U
h9AgVAf8DR/pQXe/Hv6uKYIOVUZA7/dpK4s1UYRQa1cJHVaKGQA3BUytVL0ei8+y
0vpGI9wiwahQu40SPQsqxpiG4y09xDlrn+i1OgNFpZQw9k7vqscvag3eUnBYQtA+
Rt0rgYkuL2yi410LUvbq0cBGCNjSHMWoGdyHjyBiVoeE7JDeS3Y/9fApHCzBeiUs
fP9n7qNWYNb1/V4/DFgO5OsItDJd/zJokKYB9fDOJNvOZmoAHgN/rf4QIRm3N3Sv
bF3DHWBG0eoz6gTsrIQRcsTbn3hA5og2JD2so//JwIQtjf40PhSWo3tvCvEfkSVG
NaPw62rPEtmvhWjX8PZS9Bn+3CHaHg==
=Rvgv
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
