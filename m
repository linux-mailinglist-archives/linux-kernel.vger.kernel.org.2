Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AB37BD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhELNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhELNAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A2E61104;
        Wed, 12 May 2021 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620824377;
        bh=uZ9DAXNv7xdc8TXvcZIXWp/gH6+n3qozo6ptEgDm5Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTxFQmX3fUKUsA2Upp8LyIAkQbWsZXSSuavxJ9wBI3jWKDhI+I63AOlk7EcEN0CUA
         qEw1AFm8QjuxkMvIi7Ptm1mFBblBIdzhqC9WUBf2VTODelx+9u0oR28UB8VTlHt5uT
         urtr0OCpjYObFbhOZVvlbXempzM6pzfhjEItOsfukukdVgq3OHCdNKmVmueGqKJ3Zv
         oZ7yw6jrMifMozcf6fOSqwUNfAx8ecNue4c9k2Zyzbvl1ceMGpQtmHCnDuWSwj988o
         sXD+OiH6rSoeacBOCKCJd+kZTW+0+1PoaQLLEeYGLCK68JxkrA2tPGQGk5ORQ80hoo
         sn7LiV05hoqcQ==
Date:   Wed, 12 May 2021 13:58:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Implement msleep()
Message-ID: <20210512125857.GB6343@sirena.org.uk>
References: <20210512114728.19015-1-broonie@kernel.org>
 <20210512115949.GA20883@1wt.eu>
 <20210512121858.GA6343@sirena.org.uk>
 <20210512125000.GB20883@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <20210512125000.GB20883@1wt.eu>
X-Cookie: When your memory goes, forget it!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2021 at 02:50:00PM +0200, Willy Tarreau wrote:

> Sorry if I wasn't clear then, but I proposed this example which should
> return the number of ms left:

Oh, I think what happened is that I took your "copying what we're doing
in sleep()" a bit too literally and didn't properly read the code you
added :/

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCb0RAACgkQJNaLcl1U
h9BJWAf/cH0LNYJU2Cf6TSM/AY64Q8OfVXqJoZRh905WCsbIortJBBknPSMQT0Th
xX8WnlKxd+cHoMUIC0eiXe8iYj1qiV7GS0r/7PEOI5tRl3IpmL6t4LINZVsQUctf
9n+u3Kbk1zfb77TzfWkJqlKpsLpNmhYk788DKHp/hUMHmwQPuyU5yq9QZfb0FHou
76fOcJmFyYRuLmzP7s4M8ZQDeBTGni6oGad5UpcavOVgduIVLh+PLaYZLslce6vB
MDIuoYeyEdyvpqCnFo/aYKc2yUgN7gNtIB/1sRGktFovD7OYnDtP9VzE7vs1Cv2v
Gup54pNO2Up6728tYDlq7YltftYFMg==
=BoLJ
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
