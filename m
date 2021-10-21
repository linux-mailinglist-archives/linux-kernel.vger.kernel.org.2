Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39E436451
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJUOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJUOfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CD1F6121F;
        Thu, 21 Oct 2021 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634826768;
        bh=KSsOWgxe5H/+hjbO2waxynELXJyRbEoOI39Z2RPQyzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm0po0uPXbYsnb8qU4eh4BcGCRnAFzMPHgjZdauqa5WxQ43/ODHIgGk67Sf3JbycU
         UimU+eEZ/bLajbg6ttD0yXgX8Fd3/v2D8vXGGsBxwIusVqYRIbUI7sJlmo8gWZTMtw
         uizrTbNOYfn99x2Dehr94npOU9QMFnoskjSK6s9bL+plpGj5hASJzDvGbpk2a/yO56
         EVHPRQDDhpZrEIq97nk48nihYdu/ZBJiFGKBjZ5GAobiCYsK4JJiW2DC57+hzkEHvo
         YkkH50f0ItZ5f1pjUrCXZNcSDb8MwEVJb9Sp78+DNzsnVeThKqdEXVpWgB6yACG6o8
         Yhb0yrCiOfvwQ==
Date:   Thu, 21 Oct 2021 15:32:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <YXF6DgZAFeeN0jOn@sirena.org.uk>
References: <20211021132721.13669-1-andrealmeid@collabora.com>
 <YXFxFc1C7QnCQZx9@sirena.org.uk>
 <3e0750da-bbd1-b8c6-1270-ef8fcd17e02a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g1rVn5bmmxYOr3na"
Content-Disposition: inline
In-Reply-To: <3e0750da-bbd1-b8c6-1270-ef8fcd17e02a@collabora.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g1rVn5bmmxYOr3na
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 10:56:21AM -0300, Andr=E9 Almeida wrote:
> =C0s 10:54 de 21/10/21, Mark Brown escreveu:

> > It wasn't just a warning, as I told Lucas it was a build error given
> > that allmodconfig now has -Werror.

> Ok, I didn't know that -Werror was around. Should I resend the patch
> with [Andr=E9: fix build error]?

No, it doesn't make any practical difference.

--g1rVn5bmmxYOr3na
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFxeg0ACgkQJNaLcl1U
h9ATnwf/du2v97mvfr2+EmfT89zIa09ZIjxoRDKU8HfhVTcNkuJu/qN3Cr77tnKR
eYccjTkhDh/qITsX85cHB9rwntxl4wNbU3HsO/11J3f06YlqRq31lP8C+yKfmFvN
6SgzjIDFX5E+9NOWb7aTGYp9dVoQB8rrkspYW+Ub4HUeno8t5pSFppLWsXPxQLKg
3vyatwXnme0cGT6wdtLv4sKZEggrIZi4L9qKZAg3fKDX51UqQlARWYCMpz+yeSoI
0k3oKNbRiNOFWmYUJhs3irlOjU/axPwqh242zULgHnbbyLf/Ft17+HAIzLOpHHHU
q9L4WzaTN+O7Qwwq18K+HN1uwCbEFQ==
=ZN4O
-----END PGP SIGNATURE-----

--g1rVn5bmmxYOr3na--
