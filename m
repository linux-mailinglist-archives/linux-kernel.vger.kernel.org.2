Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC43186B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhBKJP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhBKJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:06:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9401161493;
        Thu, 11 Feb 2021 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613034267;
        bh=s6acHd5aTlo6n49Lkwr18bw9K57h309+9vm78Ih2dCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSKUkhCP0g6VmedvF0aQPzYO/lYhn/RcbMV0JRzgpFyE/rDvhQrg7OmQqIzg9QY/o
         Br5NJKne3Pwkg3tM5tqcBFuA8wC+q3PJhuw4o2LCYFB5WeFLw7Oe66FREsGB7f0S9G
         3/y5QjdVlw00Ad21aCTdCJO3HWBFrO/TGLDzq6HtAe+spCQp6ToWzcMC/eqU+7iZnV
         WATuk84moqqfkcSNSAw+eRdg5AILaUN8b2t1XX6yYuXlhwW7N4UGO3kwP3ZTXWSYXt
         ruq2eJVnbfs+EUT63+OD7fm30X4eSV4dZgWRvKOe4UXMj9KPX7YzhOAjBXfKmKrvos
         yLs5VeWaf5d9g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lA7ty-0004kk-Dl; Thu, 11 Feb 2021 10:04:42 +0100
Date:   Thu, 11 Feb 2021 10:04:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [RFC/context] add serdev interfaces to n_gsm
Message-ID: <YCTzKm+70jwqkdLK@hovoldconsulting.com>
References: <20210107224530.GA23250@duo.ucw.cz>
 <YBQvvUitX4MtRrh+@hovoldconsulting.com>
 <20210131170639.GA21067@duo.ucw.cz>
 <20210210212836.GA18497@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rAT/ssUU3GkMr7C/"
Content-Disposition: inline
In-Reply-To: <20210210212836.GA18497@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rAT/ssUU3GkMr7C/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2021 at 10:28:36PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > > +config GNSS_MOTMDM
> > > > +	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
> > > > +	depends on SERIAL_DEV_N_GSM
> > >=20
> > > You need to post this driver together with the serdev-ngsm driver. Th=
is
> > > one cannot currently even be built without it, but we also need to see
> > > the greater picture here.
> >=20
> > Well, here it is, for greater picture. But it is not ready. Current
> > problem I have is gsm_serdev_register_tty_port(). The way I do
> > platform device registration causes oops on module unload. Help with
> > that would be welcome
>=20
> I would not mind comments on parent patch and some help here.
>=20
> Basically I tried to work around limitation in=20
>=20
> int serdev_device_add(struct serdev_device *serdev)
> {
> ...
>        /* Only a single slave device is currently supported. */
>        if (ctrl->serdev) {
> ...

I haven't really had time to look at the code yet, but trying to work
around the single-client (slave) assumption seems wrong. You still have
only one client per port even if the mux driver provides multiple
(virtual) ports.

But judging from a quick look it appears that you are indeed registering
one tty device per mux channel in gsm_serdev_register_tty_port() (as you
should) so perhaps that's not the issue here.

Do you have a stack trace from the oops? Are the client drivers holding
the ports open while you unload the parent driver? That sounds like
something which could go boom unless you pin the parent for example
(serdev doesn't support hangups).

Also, did you forget to post the gsm_tty_driver implementation? I don't
see a definition of that symbol in the patch.

Johan

--rAT/ssUU3GkMr7C/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYCTzJAAKCRALxc3C7H1l
CI+3AP9VA3K/m2t9z13w7b+tVZbUIrSxHOX/0DomC+lfFgg1pQD/ZE+MdHa704R5
sm2pYuZFeNCfY6aLbitWO0uLlnOZPQo=
=LyzA
-----END PGP SIGNATURE-----

--rAT/ssUU3GkMr7C/--
