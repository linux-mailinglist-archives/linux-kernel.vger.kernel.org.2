Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2245E31725E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBJV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:29:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34980 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:29:22 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 787631C0B8A; Wed, 10 Feb 2021 22:28:36 +0100 (CET)
Date:   Wed, 10 Feb 2021 22:28:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>, Greg KH <greg@kroah.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [RFC/context] add serdev interfaces to n_gsm
Message-ID: <20210210212836.GA18497@duo.ucw.cz>
References: <20210107224530.GA23250@duo.ucw.cz>
 <YBQvvUitX4MtRrh+@hovoldconsulting.com>
 <20210131170639.GA21067@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20210131170639.GA21067@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +config GNSS_MOTMDM
> > > +	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
> > > +	depends on SERIAL_DEV_N_GSM
> >=20
> > You need to post this driver together with the serdev-ngsm driver. This
> > one cannot currently even be built without it, but we also need to see
> > the greater picture here.
>=20
> Well, here it is, for greater picture. But it is not ready. Current
> problem I have is gsm_serdev_register_tty_port(). The way I do
> platform device registration causes oops on module unload. Help with
> that would be welcome

I would not mind comments on parent patch and some help here.

Basically I tried to work around limitation in=20

int serdev_device_add(struct serdev_device *serdev)
{
=2E..
       /* Only a single slave device is currently supported. */
       if (ctrl->serdev) {
=2E..
                   return -EBUSY;

Best regards,
								Pavel=20

--=20
http://www.livejournal.com/~pavelmachek

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYCRQBAAKCRAw5/Bqldv6
8g42AKCF3xaDusP/0QCXk30hrIxR+URjegCggiIRB9jUxIO3Cm4MVnT+SD+FDUs=
=OUYv
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
