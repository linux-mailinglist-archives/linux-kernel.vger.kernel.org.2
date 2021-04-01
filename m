Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3627351C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbhDASQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236538AbhDAR57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C05A16134F;
        Thu,  1 Apr 2021 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617286708;
        bh=jqdufY/UuwXUmWUGoi4vXUl54h/XWTzkg20ypWSlnEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOe9Wnt/HdL57OPLZn7Vl7d3z+FIOE5QP+7XbvhU2Gll60lxJojxr0lzGJ+TLCK95
         eGcWeuHPUHA6ZEt5/xjsyOuvHPUNlbliSQt07nI7VhdnfQ9DfvYGXzfhbhtmEef7wc
         +nHtgQUV9XaHOvilBx7EJpeQjHkBYj4+w7hCZLz4pVSVPtI8MmN11oaeYN818B3/u1
         Z6BxY2zxU803zL8XqHgK+69rhtg/nA1XgL1quiCtObtTspqyMQ0F+m90zrbv7zEJX/
         zz9H6RgGodQHf3tZmi0NoYFab/zNctEtq9wcmDNLK0lTmInwJJFqBodCHo4XguoTnd
         hjh/6FJgbsowA==
Date:   Thu, 1 Apr 2021 15:18:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 (RESEND) 5/7] regulator: hi6421v600-regulator: move it
 from staging
Message-ID: <20210401141815.GI4758@sirena.org.uk>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
 <815b79a4e93f133478d9a5b2dd429526dcfe1dde.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <815b79a4e93f133478d9a5b2dd429526dcfe1dde.1616695231.git.mchehab+huawei@kernel.org>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 25, 2021 at 07:05:37PM +0100, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. Move it out of staging.

Acked-by: Mark Brown <broonie@kernel.org>

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBl1iYACgkQJNaLcl1U
h9BZgAf+I3kP+Jp+r1dHAW0AXf0Fhk9DNl9QGn4g0+vlgHOjCqgxYuXljGZ+c1+t
UNh10OpAs47RM2JZTM3RVyEfu3sTgeEqhlaZncY1gjSL5jUzM00kAwmWvrrtK4Ex
Lrverxk3+cCfM/0JapuKNtVzDMmyvO0MFO1WbE4TYj4YnLnVC7Nb11x8azaih+LN
0en2a5zoGpqc+4tdXLzKnGNZd5a7iTbdVP7qQ/qogDLmvKOuPwn/DzbMfPsML1y+
HEf9yyZyDmJAVa3WfHuaBVyX7B4VV67W5EwN7lBlwj41G0qjHCSCeiPrX5BG2AMR
CyV+1wkmabJGmmmaxbGiUBKLrsrMaQ==
=TTgB
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--
