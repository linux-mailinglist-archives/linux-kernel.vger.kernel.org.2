Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA23B9D83
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGBIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhGBIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:30:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 845D3613F1;
        Fri,  2 Jul 2021 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625214474;
        bh=aXPyxGZlTIBZvE1WJ/B5WJEX0VZKFvbH4NwBdjJckck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASz/KTzQqGgZc1bdKnhYJVXO8ahlTpVBeS6GikRtBJCkMwbuxBJnJE3hIHUwTB+GU
         MmzCm8UhJ3ZmnIMV0rkKLsLlUZbN0UC6A2Lz9XQrLwuUcy2HVvusFgjQfJ4oZFZad1
         HAhDJNP62mvdcgsl+1ub7yGApCj/fK/0OZwKlXAg9kDHG532ch7jNGrZ5yUGlWno7o
         R9hBWVG3LgGfiM7HX0ge1rhwZSyL9+nH1Keup9I+/Hjz+ApJrWeOdC4Q+oWYPt0owx
         sabICxkAfMfMVgprWZolcsoUpCsqgxPi3yNS2jMAceXeiKtbyPQO27gANerCEKIl8B
         gp0aEfXzhzu3A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lzEWd-0002Vm-Ni; Fri, 02 Jul 2021 10:27:51 +0200
Date:   Fri, 2 Jul 2021 10:27:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stefan =?utf-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniele Palmas <dnlplm@gmail.com>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra
 Wireless 5G modules
Message-ID: <YN7OBzmcsidWIG0F@hovoldconsulting.com>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de>
 <20210611135842.14415-1-stefan.bruens@rwth-aachen.de>
 <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
 <3614092.7mX7SIBJgt@pebbles>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+fSrOke19xwIognt"
Content-Disposition: inline
In-Reply-To: <3614092.7mX7SIBJgt@pebbles>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+fSrOke19xwIognt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 06:41:26PM +0200, Stefan Br=C3=BCns wrote:
> On Donnerstag, 24. Juni 2021 09:28:59 CEST Johan Hovold wrote:
> > [ +CC: Daniele and Bj=C3=B8rn ]
> >=20
> > On Fri, Jun 11, 2021 at 03:58:41PM +0200, Stefan Br=C3=BCns wrote:
> > > The devices exposes two different interface compositions:
> > > - QDL mode, single interface
> > > - MBIM mode, MBIM class compliant plus AT/DM(/ADB)
> > >=20
> > > Current firmware versions (up to 01.07.19) do not expose an NMEA port.
> >=20
> > We already have at least one SDX55 based modem (FN980) supported by the
> > option driver. Any particular reason why you chose to add it to qcserial
> > instead of option?
> >=20
> Support for qualcomm based modems are spread over option and qcserial. Al=
l=20
> other Sierra devices are supported by qcserial.

Ok, but we may still end up adding this one to option if matching on the
interface protocol works.

> > Note that the FN980 also needs the ZLP flag set in QDL (flashing) mode,
> > I'd assume this one needs it too.
>=20
> It depends if you implement the Firehose protocol in accordance to the=20
> specification or not. 80-NG319-1 (Firehose specification) explicitly stat=
es to=20
> pad any XML command packet which is an exact multiple of 512 bytes with a=
n=20
> extra newline or other whitespace character.

Thanks for the details. If you're referring to the device-side
implementation it seems a bit fragile to not just set the ZLP flag since
apparently there are some non-standard implementations out there. But
sure, we can do that later if needed.

Johan

--+fSrOke19xwIognt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYN7OAwAKCRALxc3C7H1l
CPH7AP949REvyDQL0GzQ/Iu/PBYxRIjegY+tX1YWWlsgut4yOgD9FJiHMoJ6P+lm
l1CqjIUHAzuTd3+YHA7gtM+Mbiog2Ak=
=6cXq
-----END PGP SIGNATURE-----

--+fSrOke19xwIognt--
