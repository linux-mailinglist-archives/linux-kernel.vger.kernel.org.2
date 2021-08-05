Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0953E1AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhHER7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240942AbhHER7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2BAB6115C;
        Thu,  5 Aug 2021 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628186339;
        bh=oYAoJqCnPnFKfCHh4qqDJHiix9bODipkA6rz0rXh0iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MB+Bchw/Qvv2BX2utMg55UEvMbkkHQTLAoe6ogaVVMwSuIDcvuF9/7AhxdB9tGX8S
         opH/GoRwCO6JWiOCgaTqNJxBs0MB45B/3Cotdzn0SbPwzOXvKNCWvAlHwr15pE2ejD
         fh1Noi/sw9CvZINduOD1NA0mpuX3/ghzBIUJ5DfOCA0ZQq2hp1e3NolKAZeE9PuUai
         9X0L1kv5PWT/zVqgjSZrW9VYGJ+pFUCnqOGbwfff41QJzgxsgpUSDEz0DVqionSKjc
         xeX/j2GCCaiDQ+i6lc0jBdmdtTgbSdEUrS5jiOMjYpbzQM7Z/EH9Z5DjbhZYktDfwL
         +ylN1dj08cCYQ==
Date:   Thu, 5 Aug 2021 18:58:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC power domain vs generic supply regulator
Message-ID: <20210805175843.GS26252@sirena.org.uk>
References: <CAOf5uwnZvJWhwf=h8nx=MmZz4BOyaq_BTr8vyDcGHqnBO7jK1Q@mail.gmail.com>
 <20210805172300.GR26252@sirena.org.uk>
 <CAOf5uw=BZ98KGskd-C4NyHQozi7kpca4ZCQE9c8wxkg-W0Aewg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+d/sD+4Memv8CeGA"
Content-Disposition: inline
In-Reply-To: <CAOf5uw=BZ98KGskd-C4NyHQozi7kpca4ZCQE9c8wxkg-W0Aewg@mail.gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+d/sD+4Memv8CeGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 07:39:42PM +0200, Michael Nazzareno Trimarchi wrote:

> So in short you said that if I have a device that has no definition of
> supply in his
> documentation, this device needs to support the supply in his binding
> and make to sense
> to create something like:

> generic-supply = <&regulator_device>;

No, the bindings should use the specific names that the supplies have,
generally whatever the names they are given in the datasheet for the
device.  If the device has no actual supplies then it almost certainly
shouldn't be working with the regulator API.

> and let dd to pick them up

No, the driver for the device should handle things.  The code is pretty
trivial, though if someone wants to write helpers then sure.

--+d/sD+4Memv8CeGA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEMJtIACgkQJNaLcl1U
h9A1vgf7BVLH3zy+Eb8CF74sgPgebJZGY6qKlAAu+3lR+b6O3TSeJ2vYk4kqfNcx
+I9ad2/bMOkTa8rlYXx522Wc5esSnnz/M5fTq1OHUoTcBzpKCJ40OiSEWYdlWHgB
Dpl06Lfzz0aIKDyOz7QPgGLyL8JdcMs7hk3IxPCBZz9LIJY+/YVd0kH+Was1DiPU
hpHY5NkImYrhPQHFv3PwZcFjvzNtDyxVj/XK1PuLCNO6UdR0V/8PwZXAV1JbETLp
TLcHh6mtEBE042WrOWXkeqUejfxEzDu7t0Y8YMJmjMegqyX1D2P8y7m7ztuezlHJ
jfVVYiF+roy60hjqI1yslHiHdHgj4w==
=2X7H
-----END PGP SIGNATURE-----

--+d/sD+4Memv8CeGA--
