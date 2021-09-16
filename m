Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808AA40D9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhIPM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239363AbhIPM1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:27:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26EA360F25;
        Thu, 16 Sep 2021 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631795190;
        bh=mfX29/di/xilhJPTUe/47Dt9l+sLXh8n1/Bzm8nigXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dot7UTFG9z5RDoKt9YwghU4gkD4y/1MEbPdmOHoSGOeFeQji17JwBeN4q3v3btsll
         KjYI9NO8L81+jJYoA3/jm81mU0MgfS6GoThC/wrSXbfjXVWKnyEt3ACq6ylbFiw+Oa
         2dd/mbMaYaFyYpP0cwWTNRGJcZnoZY+YOrDEybg5aEKgEflxSVHSycN1NW3s98A17/
         QEb7g5+IoM+MrG/lX8TzMEELRy7gCn6wvNQMN6MComagWtYo/VixmF8TN+o00lA0I5
         dG9SGeD13axlKcBfB7jyvb68L8mgCHFwQLw2oqTuBOB+6rZnOUbJdwNj1qistYfVzG
         0gwbWdMYlARow==
Date:   Thu, 16 Sep 2021 13:25:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <20210916122549.GF5048@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
 <20210915141012.GC12513@sirena.org.uk>
 <42974939.Tn3hggVSkZ@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
In-Reply-To: <42974939.Tn3hggVSkZ@archbook>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 07:06:14PM +0200, Nicolas Frattaroli wrote:
> On Mittwoch, 15. September 2021 16:10:12 CEST Mark Brown wrote:

> > Why is this not part of the normal bus format configuration?  I don't
> > know what this is but it sounds a lot like I2S mode...

> This affects all TDM I2S modes, i.e. TDM Normal, TDM Left Justified and T=
DM=20
> Right Justified.

> Without tdm-fsync-half-frame, we purportedly get the following output in =
TDM=20
> Normal Mode (I2S Format):
> (ch0l =3D channel 0 left, ch0r =3D channel 0 right)

> fsync: 	_____________________________
>                      	            \____________________________
> sdi/sdo: ch0l, ch0r, ..., ch3l, ch3r,  ch0l, ch0r, ...
>=20
> With tdm-fsync-half-frame, we purportedly get the following:
>=20
> fsync: 	_____________________________
>                      	            \____________________________
> sdi/sdo: ch0l,  ch1l,  ch2l,  ch3l,   ch0r,  ch1r,  ch2r,  ch3r

> At least, according to the TRM. I do not have an oscilloscope to verify t=
his=20
> myself, and in the following paragraphs, I will elaborate why this seems=
=20
> confusing to me.

fsync-half-frame is just normal TDM for I2S, the default mode is how DSP
mode normally operates.  I don't know that there's any pressing need to
support mix'n'match here, you could but it should be through the TDM
configuration API.

> So to answer the question, it's not part of the bus format because it app=
lies=20
> to three bus formats, and I'm completely out of my depth here and wouldn'=
t=20
> define three separate bus formats based on my own speculation of how this=
=20
> works.

It is part of the bus format really.  I suspect the hardware is the kind
that only really implements DSP mode and can just fake up a LRCLK for
I2S in order to interoperate.

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFDN8wACgkQJNaLcl1U
h9AhiAf/ZlfcZ9ejEekSn1zn4A88+/ZgbySK7f6ieclZDuSJ0PyYj0x6VN5f+p8U
UrfT02ie6+dpCTcQHVQtFcJx5+BN5N8WoBidKDS0gAN3W8R2i9LvWGw8z9wT6tKS
KCnSoIL4Gr0ZQ/556y5vIocYG7waZMOckP6/ZuIjBewEH+j0iV34b7uT54kDbfXA
JLi2Y6LDveRJbnVsJ4EK4cLgmxHDfjmirUiAjvrWvTcVUXXZDQ1qXalGDFX/ZEFq
RzP18+TUX33qEgF1UApmZEIOqSCHst3po+sy1xkpZlOvTzcQAQLaZXMm9PulSx41
Aq2b/PrIEwOcL8Kc4GfCeW9YoGOm3w==
=u+Qx
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
