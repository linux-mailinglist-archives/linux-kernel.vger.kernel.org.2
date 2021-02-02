Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8379830BF32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhBBNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:18:31 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51424 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhBBNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:17:54 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CBF041C0B7A; Tue,  2 Feb 2021 14:13:26 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:13:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add initial support for BQ Aquaris X5
Message-ID: <20210202131326.GA23980@duo.ucw.cz>
References: <20210124135409.5473-1-jonathan.albrieux@gmail.com>
 <20210124210119.GA27676@amd>
 <YA3rTAx2vfOXPCMq@gerhold.net>
 <20210127222407.GD24799@amd>
 <YBKDa1irydOUaXag@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <YBKDa1irydOUaXag@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > How close are you to having useful phone calls?
> > >=20
> > > You can do phone calls (with audio) and you can use mobile data, if y=
ou
> > > have the patches for that. :) I'm trying to find time to finish up the
> > > drivers needed for that, but I've been a bit short on time lately.
> >=20
> > > Most of the functionality is packaged in postmarketOS [1] and you can
> > > find a list of the devices in the postmarketOS wiki [2]. Especially
> > > the ones in the "community" category are quite similar in terms of
> > > working functionality.
> >=20
> > I know about postmarketOS (I even contributed a bit some time ago),
> > and watch it from time to time. Currently I'm using old Nokia 6151 for
> > phone calls, but would not mind switching. Work is ongoing in Droid 4
> > land -- phone calls are also "almost there". But the almost seems to
> > be a lot of work :-(.
> >=20
>=20
> It's fairly simple on Qualcomm SoCs once audio DSP and modem are working
> (which is not that simple). I basically just tell the audio DSP to
> stream voice call audio to the audio ports and then it does that without
> involving the kernel.
>=20
> It seems to work quite well, so far no one complained about quality or
> something like that. Not sure if anyone is actively using it already
> though :)

Ok, thanks for info :-).=20

> The work left is mainly making the driver more generic so it can work on
> other Qualcomm SoCs as well (right now I have some things hardcoded).
> Also, I still haven't fully figured out what is the best way to
> integrate it into ASoC/UCM/..., so that it can be easily activated when
> starting a voice call.

On droid 4, we use mixer settings to configure audio system for a
call. Maemo Leste has some kind of component to automatically adjust
mixers when call is started. We use ofonod.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBlP9gAKCRAw5/Bqldv6
8tzWAKCdkEFZl9hRFG46yPE3C/spvowpWQCaA6Ukg3wKxEbu1zi+xVIs9ckw2Ks=
=mY9d
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
