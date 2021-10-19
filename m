Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82B043353E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhJSMB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhJSMB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:01:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCFC4610E7;
        Tue, 19 Oct 2021 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634644784;
        bh=ySRYvdK7NTrM3AmKXqKhUuV0WZHW9zMiPWB/cj1v/W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8oNo2ySNIrGLpLu+RI0T0jN9YSNIjyAYk86yxHa9JLnINNu1zWxFQVhGB/E2UIpG
         YP9LASeCm4erapn4ZB7x8abIFlYL/ZNp/m7e/z45OSIbvszzQOO+lNVXt5hcOE/AZ8
         md37xvbQoKG6yly811l5jjl8jCeb+7DmpJu54dUiR17rsCOmkcc/ytcCUXpP376koA
         5l1ZChVy9v27n65n9WAi++ayBGK0yJpjbpO9rCiCdM8k77bwp4dmU6gLDMlMSgbAcJ
         ATcgKXiiOkkLAMJl4NCyfEdzNIQq/+LpBU4L6u41YgaMbikKEU4XKNi55EF50ULGvH
         aan7h2L/008zg==
Date:   Tue, 19 Oct 2021 12:59:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     George Song <George.Song@maximintegrated.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "george.song@analog.com" <george.song@analog.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Steve Lee <SteveS.Lee@maximintegrated.com>
Subject: Re: [EXTERNAL] Re: [v3 2/2] ASoC: max98520: add max98520 audio
 amplifier driver
Message-ID: <YW6zKsiWPE+xGWTy@sirena.org.uk>
References: <20211018083554.5360-1-george.song@maximintegrated.com>
 <20211018083554.5360-2-george.song@maximintegrated.com>
 <YW1quluaCzsUpET0@sirena.org.uk>
 <BYAPR11MB367106FDD5394AA4F88A42D4F4BD9@BYAPR11MB3671.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tHVcRvqxv/TkamTw"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB367106FDD5394AA4F88A42D4F4BD9@BYAPR11MB3671.namprd11.prod.outlook.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tHVcRvqxv/TkamTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 07:57:26AM +0000, George Song wrote:

> > > +	/* L/R mix configuration */
> > > +	regmap_write(max98520->regmap, MAX98520_R2043_PCM_RX_SRC1, 0x2);
> > > +
> > > +	regmap_write(max98520->regmap, MAX98520_R2044_PCM_RX_SRC2, 0x10);
> >=20
> > These should be exposed to the user, not hard coded - different systems
> > may need different configurations.
> It`s already exposed for 2043 register which is regarding mono mixer for =
"DAI Sel Mux"
> It will be exposed for 2044 register which is regarding pcm input channel=
 selection to dapm mixer.

Then leave the values at the defaults and let the user select what's
sensible for their system.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--tHVcRvqxv/TkamTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFusykACgkQJNaLcl1U
h9DFVQf/XvEmsHsRZThYw5Rh2fJiTUcH0nU71YKqB8OtTm+GmyIjxXvVot3FDVRy
kfbXh3uenZDDIPOPPnWKUmNKh5v1W6j0IFVcDAzoVBi2GZsZJz0bLq8/aGIZOb+t
vIVtBG1rGuTQuXSfVuFQ1oRzbJagBrvUBVtHqBnmKyPkZVzL9q7zfa4nD4UpXlt3
nk53cWjWr91NKrc4m9lyTaPdEv2Tw2zw1UektO6KALKjVOFHj8Q48rqc0e/f5MZH
6bWU6ylcFUGG+XTOMCdrQdr9r/fqJLazU29zqGYeBWrVDMkKltc9i/xsteS2rQCI
jDC+lwC+qHRNWnl51YnKm8Hz3lLSSQ==
=f6mJ
-----END PGP SIGNATURE-----

--tHVcRvqxv/TkamTw--
