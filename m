Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73FE3C5E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhGLOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhGLOSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:18:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 656CD610CD;
        Mon, 12 Jul 2021 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626099364;
        bh=Q83T11Ynq/A0+rWPbLKwWxH7IXVFfOn66OkJOcS+cpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSGOEf3AMw99wiSsfNy7T4+/CTzVt0QXUw16ZXcsW+KfVKNBnj062U5meENkDpTnl
         06yHwgRBRvVv0P/7kHmpaPnSeCc/X7FK0uOxWf9GSb4yKZ5piSHfiDXlKsGdctV5Su
         ssI+Z7dXdFATkxVMrpuiHjuG23XPGqf9Juo8PtOxSRpjoVPW2gfibq7LcrT0InJ1qM
         irD0vbiawRvoiIMeerfbZFezwORGYm7nYLlF+9wZ3k436eAJRoVvI9zEP1TR5tBdyX
         AbQFoGtfdVUEZnmxqciZjc/1hAJOwmZoVrg14Ldk3IrIxKmDXXcGjDQMrPlMcZkGUv
         fkNJyBIZtlXcw==
Date:   Mon, 12 Jul 2021 15:15:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210712141528.GE4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <c95da883-581b-d1f4-4c8a-2162b8b58b64@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <c95da883-581b-d1f4-4c8a-2162b8b58b64@gmail.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2021 at 11:48:33PM +0100, Daniel Scally wrote:

> I went with this approach because the ACPI isn't entirely lacking, it
> enumerates the TPS68470 as an i2c device for its driver to bind to
> without a problem which results in the regulator driver registering the
> regulator devices (7 of them for this chip), so I was thinking along the
> lines of repairing the problems with ACPI to give those rdevs the right
> init_data rather than sidestepping it altogether. I could register the
> platform devices for the regulator driver to bind to in a board file
> instead if that's the preferred option...usually this would involve
> using i2c_board_info I think but as ACPI will enumerate the i2c device
> for the chip independently we'd need to handle that somehow to stop them
> racing each other I guess.

Like I said elsewhere it seems a lot easier to just have the I2C driver
set platform data based on parsing DMI information like we do elsewhere.
I really don't see any benefit to introducing an additional layer of
abstraction and binding here, it just seems to be making things more
fragile.

I'm not sure what you mean by "register the platform devices for the
regualtor to bind to" - if the PMIC is an I2C device it's going to need
to be an I2C device, and if the device is enumerated by firmware we'd
need to suppress that firmware enumeration to replace it.

>=20
>=20
> I'll take a look and see if I can make it work that way.
>=20
>=20
> >> I'm posting this to see if people agree it's a good approach for tackl=
ing the=20
> >> problem; I may be overthinking this and there's a much easier way that=
 I should
> > I don't think I understand what the problem you are trying to solve is
> > so it's hard to say if this is a good approach to solving it.
>=20
>=20
> Hope this is a bit clearer now?
>=20

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsTn8ACgkQJNaLcl1U
h9C2Xwf/TjjFjhoVccF73CbP5AOvWWFfO9lZzboxZM78SK61Ioe0befCPxvwjuGC
Uw81/NEb9dzaEM28RotI/UZYiMGrnLJNYcEa/8ytOQs2g1Y9AQaqp3xHerTyND/D
F1VvGSMzew+oRbT5VoRNBSycQKPef65wi/viqVHe1dqyb/gUeS/R2Y2OP8aYAm0K
WkrLuLIn1r03Iw/dk7idNq0KbsslVAembIvy4gVTeKLvnFBFys02fNgMX876PYZp
gSeQ1n6y8wu8lNBsT4OfBXqXOBvWJFTEafLaaNtHE3uyYk2nXJDJ8paopTbdfE+u
uYZifsfgzz6GB5yyXub3zSACBVDplg==
=UYK+
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
