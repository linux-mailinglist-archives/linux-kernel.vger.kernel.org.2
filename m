Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C340C55B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhIOMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhIOMgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF18361164;
        Wed, 15 Sep 2021 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631709334;
        bh=ZgeBgOtQK86NR5xKcsbgrpV+8iWT1YLVsfrnmkwzh3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORAorsyHidnP3aiVlBM2tIFpWVCd5bQ61Wbzppp2LfeX+3IpFK0cshQvR3AChjA4w
         OkjT6GVJjskD2IZGnUq55ZntqOTW+tUepldSM322ZIMrAtHM8xLAFHv75632a9Xoqw
         tQi5tP2xu1QFI3OGSWZFpp6IN/Bc6KTQoq36gzGKJFSTyLgUZ1wZtN2JTGWhD7ixK6
         47oWUT7nBIz581zW+UbbZ+NMHUaXxHN6f9Xsd3zNjoq+ZqOPlV/K0Q/ub/m9Nzvkc6
         dfDVekjhzmgp0gSFJOJygzYVDG/OuFy/d9x1lSBx8wbItUTvj7vMUh8Vuvnx2YJd12
         zxJWIhaw/O5/A==
Date:   Wed, 15 Sep 2021 13:34:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <20210915123453.GD5389@sirena.org.uk>
References: <20210915120951.29907-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <20210915120951.29907-1-tanureal@opensource.cirrus.com>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 01:09:50PM +0100, Lucas Tanure wrote:
> Set regmap raw read/write from spi max_transfer_size
> so regmap_raw_read/write can split the access into chunks
>=20
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>=20
> Changes v2:
> New series
>=20
> Changes v3:
> None

How does this relate to the previous free standing copy of this patch
you sent only two days ago on Monday?  You've dropped Charles'
Reviewed-by so I guess there must be some change but this changelog
claims there's nothing (and appears to claim that v2 was the first
version...).

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB6GwACgkQJNaLcl1U
h9DqMQf+IIZI4maSmCuTEs8nP0v8mH3dhwpcQ2snw6Km14ifkdfIF/uyHqemS837
KS9/JVmtqJYSCuAjBuz1cIxtXVaVUFFCiQgtm/CqOymC5g5ADuCcAQHDVO/6Eqj/
NDiO45P0nUcy8DOzW4gHNRp/Yal3xjgUOgov7dxfqy4va5uFrHsulT7OTTWQUQ5C
p3/n+iRco8PNREpc7TTmHKdZbGPmAx0BWWviQCLMsPm3QWpoe5SfpY2Lm2FvgQQ4
oOpUiuoq8pgdapt7DwmQEm5m/OfWJQcCbtmpe/qVi/uXJMtNAmIsImAomXwsjHAm
Jf/Yln3qNQA+KIvKJvgCsoiVpjEcwg==
=jX5P
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
