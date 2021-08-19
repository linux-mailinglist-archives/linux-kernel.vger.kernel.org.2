Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF643F1B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhHSORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhHSORS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D20610FF;
        Thu, 19 Aug 2021 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629382602;
        bh=0uMlC15O+oh23cQEELPSg5hsjxTkiutg1Dl14TuNA2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFfLWw0XVYjN0YeCEeOw9d34neLFdGyTTycyb0AKBzkKwvJw0RaJfoxI34JSe3WL1
         r7GynOaqWvGHOGOvkhdR9yJ3VjEseQ8pGl1iwhmQ2ZVJwwnIkEojsezZkpmygbrq1i
         tU0zLeemaItq2qGwl4K/aWVCqzotZmIj21bza5ql2ZhSMAQw4Lych1rGy7qrZ5k9x+
         i0249dOb5mCdV+lZ9eACZkjoYtTEEFCSo7DrjEYv56L9+y5jHdva/0+A6an8OgIpby
         zGnrg0Hhvmjh5dk9JY0eln2pqlu+HrE9B8y+I1r0cIkLuaOnyfZQisIMx6ph2kOnpN
         Tay5NsPYPQRcA==
Date:   Thu, 19 Aug 2021 15:16:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <20210819141617.GM4177@sirena.org.uk>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
 <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
 <deb50900-fcfd-23d0-ab8a-0e64b2abb063@arm.com>
 <2412250.zZEsDtmPgG@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <2412250.zZEsDtmPgG@archbook>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 03:52:55PM +0200, Nicolas Frattaroli wrote:
> On Donnerstag, 19. August 2021 14:08:36 CEST Robin Murphy wrote:

> > > +  rockchip,no-dmaengine:
> > > +    description:
> > > +      If present, driver will not register a pcm dmaengine, only the dai.
> > > +      If the dai is part of multi-dais, the property should be present.
> > > +    type: boolean

> > That sounds a lot more like a policy decision specific to the Linux
> > driver implementation, than something which really belongs in DT as a
> > description of the platform.

> I agree. Should I be refactoring this into a module parameter or
> something along those lines? I'm unsure of where this goes.

Why is this even required?  What is "multi-dais" and why would
registering the DMA stuff cause a problem?

> The particular configuration may even vary per-board; an I2S/TDM
> controller may be connected to an external codec which does not
> support capture, whereas on another board it may be connected to
> one that does.

If the external device doesn't support both directions then why does the
driver for the I2S controller in the CPU care?  The constraint handling
code in the core will ensure that nothing tries to start something that
isn't supported

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEeZ7EACgkQJNaLcl1U
h9BLTQf+NFP6G5gxloO6mI1KjGRABdmwB01kioQ+Wrt6Vw3VwRA/5Obtl1XcwDU6
sMmqKjIMhNgfSvDKESHfSDL7E32hYMKUMOXCpEYW2pCEjN2hEbdxVwP+hbIdsmel
z+z+ISyW3zl6K1ndvLbeniqwEZOsGNiz1EUvTygFCMvHdd9Yuory3/nufj92owBJ
RgRiuIZJ52nPD1hdPQY1MRpP+Us3DaP8RNHLrF+FlZVtaj/hPftEwt62oTCNI0KO
iQv81p2ueGYvqIVzD50HGC7sSc5pB2iU3VQ72XlWusgkLYdU22rbVvXGZWSRoaq1
w8aXvCnwvc8ml4d7ZG4ROXBHzoY2oQ==
=/YEY
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
