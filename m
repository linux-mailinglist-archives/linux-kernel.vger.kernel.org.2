Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505153DA206
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhG2LXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhG2LW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DDAD60EBC;
        Thu, 29 Jul 2021 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627557776;
        bh=Qu9LdxcIzRtCNCHtmrwl+UUtyVvZNiU6OrlcOAi99KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOMV+V8CSq6KSa7NzbG6acxmkqo33sM7S2icS8AnJS5eOwB40/XlPOJymVNaedPsE
         PuNZ6Zn60akdwlPuawChn1XmNF8RUaaDT4YClt4aYTeOB5IHBjT0X+JzZp0EOWEnD5
         kk4u7+Nm+FXR9D0nnZhzmyRzCClg7VS6188KNNySQ5x509PSmYRnwyvRElF7gfmcbl
         uSmBFTKeQE2Qa79C4/D6DlZOehnrxXscmZ8X22/WKJlhJb7uxi0Z5+kL7lhCEhd7ds
         MaUobkoeIertl0tquPuoVxylBN7EwvEFAjDamN5cXongB7Q2kx8lQlDFN+NAxGmlR6
         nUrtftnv4khFA==
Date:   Thu, 29 Jul 2021 12:22:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>, lgirdwood@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regulator: sy7636a: Remove the poll_enable_time
Message-ID: <20210729112246.GL4670@sirena.org.uk>
References: <20210706114120.197-1-alistair@alistair23.me>
 <CAKmqyKP8HKERLS3ckOA3wwpiv6J4tdFXn8-d6wXxDXDGn5iN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="en6jyp4HM4Tn+Q16"
Content-Disposition: inline
In-Reply-To: <CAKmqyKP8HKERLS3ckOA3wwpiv6J4tdFXn8-d6wXxDXDGn5iN=w@mail.gmail.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--en6jyp4HM4Tn+Q16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2021 at 09:20:14PM +1000, Alistair Francis wrote:
> On Tue, Jul 6, 2021 at 9:41 PM Alistair Francis <alistair@alistair23.me> =
wrote:
> >
> > From testing on hardware the poll_enable_time isn't required and
> > sometimes causes the driver probe to fail so let's remove it.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>=20
> Ping

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--en6jyp4HM4Tn+Q16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmECj4UACgkQJNaLcl1U
h9DMsQf/Utr/CPGrthjOhuGk9FGldoqWYbsRBvmaex4NoLEwlJOXyzVZOAxO9p0O
QFjzjbNiKm4MuQnXSYDdYZ8XyCfZ40fHC5d47zH7kdmnV/V7l4WVrkEbp88cNm3Q
4NfRUOJIeUoiuHBYnf8yk2ELlEqOoEnG0Vcj5mG3eN9ublCkdcLt7rSeASw452ga
pTdj0kX0LhtJ7KX+azOpURebQs+4+L/BXTCqo5jfNsGyCzQCo3CtSHVwdamMm/m3
sDdvYTDmtszAbJJZeFH8t4ZClSUdXeS4gp+QF52lhU4chrGi0i8eazXTt8y4vcp6
pu9jIeL1Y0jISVcBowzVEeWEhJPb+Q==
=nBa+
-----END PGP SIGNATURE-----

--en6jyp4HM4Tn+Q16--
