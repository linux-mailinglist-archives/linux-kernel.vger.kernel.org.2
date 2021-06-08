Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D739F89E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhFHOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhFHOOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:14:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D90CA61078;
        Tue,  8 Jun 2021 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623161544;
        bh=ari7yVWVgKH9ppjVmH7YO+gyqRCAtynmCk18nf2544A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pEFiR8edqqA7xThEI5CNAjrJ5P469BNXiyufR3THfQqasXdvjY4vs06PJ0P52KaF3
         5Q+xRvfsowpM+KvxjIMQ8yXz8A3e0RFASiB4pcX11o7sGGH1Ab7KqetKrw0mSTEGHr
         nevJ9T7ihV7jTT41CtT1eMw6uoUvwj892m+S+/mOiS0HLpTCijSX6Bkhr9yT4RXYgo
         OMurmZn3Lpmt3Tae13Uw9SjNX2im7xmIu4ToE8HTU0a8kh3i0hPAG2zyOs/ef7m0CV
         dreLNfUweCtzQIt1fpbkA4ano0iSuFlVOIU3HMGB7ofGiNLRX6exiMzWxm1+25wjZM
         MLOJzzT7UrjuA==
Date:   Tue, 8 Jun 2021 15:12:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v8 3/9] ASoC: codecs: wcd938x: add basic driver
Message-ID: <20210608141209.GF4200@sirena.org.uk>
References: <20210601113158.16085-1-srinivas.kandagatla@linaro.org>
 <20210601113158.16085-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20210601113158.16085-4-srinivas.kandagatla@linaro.org>
X-Cookie: Auction:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 12:31:52PM +0100, Srinivas Kandagatla wrote:
> This patch adds basic SoundWire codec driver to support for
> WCD938X TX and RX devices.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/Kconfig   |    4 +
>  sound/soc/codecs/Makefile  |    2 +

It would have been nicer to add the Kconfig and Makefile changes last
for the benefit of bisection.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC/ergACgkQJNaLcl1U
h9ATOQf9GVwxHqO9SFJme6lrZ7lLpmKoTnKPSTfSPpV61X1zS7itVhMaz41WbHg7
374N5eNwQh59eRjRG0zyKo1wBGh+Cgxi1gjqediOC3leMYX6WYAW1fc3+zNGjfVj
AtUPzlCIlY+P1meOf2ZTzF6UzkQZs8O/sB+SOGZr+Kh90CAwUy7u6E2AjqcMtCD8
2MOryEoXpOeo61pKEJSbKQ23aPeHU3gs0KyaVsHrQVDz8WWKmSmswtj94uojjnEw
7CsFI9rfK8g9b7SbFR5BsVS9GYf5zdlwU66dsxMGwTzuvxIaIuU13MNdkdPuZHCx
JTgKqP/iNrrgCCx8nbobinhLkU3b8Q==
=1xrn
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
