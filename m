Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976645B89F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhKXKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:50:40 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50844 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhKXKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:50:39 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 280071C0BA7; Wed, 24 Nov 2021 11:47:25 +0100 (CET)
Date:   Wed, 24 Nov 2021 11:47:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with custom hardware on x86
Message-ID: <20211124104723.GA8909@duo.ucw.cz>
References: <4ad5a438-ddc4-ca0a-a792-09d17edeb66b@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <4ad5a438-ddc4-ca0a-a792-09d17edeb66b@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm about to start a project involving custom hardware using an x86 CPU.=
=20
> Complicating things somewhat we will have a CPU board supplied by a 3rd=
=20
> party vendor using a COM Express type 7 connector which will plug in to=
=20
> the board we're designing (actually 2 different boards each with some=20
> modular aspects) .
>=20
> Coming from an embedded (mostly ARM) background I'm used to describing=20
> the hardware via a devicetree and dealing with plug-in modules by=20
> loading devicetree overlays. How do people achieve this kind of thing on=
=20
> x86?
>=20
> I gather ACPI is involved somewhere but the knowledge that the BIOS has=
=20
> will go as far as the COM Express header and somehow we'll have to tell=
=20
> the kernel about the various non-probeable (mostly i2c) devices on our=20
> board which is kind of where I'm stuck. Any pointers would be greatly=20
> appreciated.

In x86 land, we usually use PCI/PCIE and have a add-on board expose
unique IDs with driver knowing what the IDs are. ACPI should not be
involved for add-on boards.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYZ4YOwAKCRAw5/Bqldv6
8gxCAJ94m2cCpKrGAdH4sxgKbLZk9Ht+BgCfd163sgp1Ke5Gu8IT//TlGMNZFaQ=
=1WmC
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
