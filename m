Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD73FEFA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbhIBOpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345374AbhIBOpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CB33610CC;
        Thu,  2 Sep 2021 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630593866;
        bh=QSkZv2N1yXVzhucXRsxaUE7H3wr+r7TSYHXNxXgC910=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDOYYkTybQvl1z6Luah3ixvfoCcvxrLI1lfGneZBWECIuC7las8tHY4sx9jFAowup
         mtthFD4gHpW2p17sYrm7Mgh85X7CvTV5On0a1IRI0cvEcJzmLbz7pvkvXoeAWswxyN
         gLaJLeqUgQ7jJqx3ynHZEPF46lNi27sb31qr1nVxWHR2xRApLthfDAGhYYTlgVaHNB
         maEoFyoOpTZfV7rpXhEPr77U+Q2vRZfu5GsC10TzD8Tvh6rKqlxzJ9Uacomw+ZmuWN
         UfQpwJeKIZb4wX6C9HQN7WrqESL+pG6RY7QBb2q4bMSbonZF6O6JJnqgzOosm9DMwq
         7PhKumonfatXQ==
Date:   Thu, 2 Sep 2021 15:43:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: max98927: Handle reset gpio when
 probing i2c
Message-ID: <20210902144354.GD11164@sirena.org.uk>
References: <20210829170019.384632-1-atafalla@dnyon.com>
 <20210829170019.384632-2-atafalla@dnyon.com>
 <CAHp75VdY9uoTWeJEroi3iChnToUSxe+Henmg7Yux+UWkK59jQg@mail.gmail.com>
 <YSwGlXEFRuUvNGZ7@dnyon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <YSwGlXEFRuUvNGZ7@dnyon.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 30, 2021 at 12:13:41AM +0200, Alejandro Tafalla wrote:
> On Sun, Aug 29, 2021 at 11:22:35PM +0300, Andy Shevchenko wrote:

> > > +       struct gpio_desc *reset_gpio;

> > Why? Are you using it outside of ->probe()?

> No, I'll delete it and use a local variable.

It can be good to reassert reset when unloading the driver in order to
ensure that the device isn't active.  It doesn't really matter though.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEw4yoACgkQJNaLcl1U
h9DWrAgAg56iA1Au+XNyIyNCXB0VXn2oIgAwnxeXEjv3PKrw4YE0fW7dcbvywDnr
8Fs2PMIw09wFpzzoSzAQCNGN8Ts3OeiL8QFHnsOQeeyIzSkuOviiBrOWDtuCfx/j
0XXcxoH4ODxf0faKlbCGHQ6LdBgvsSeQiU3ExLjqJHYusxXbXUdRJ8XxIyhDC5tI
+7KZOK7azIuJxSJrfYJ9aIlHvMmkCS9o/OpynCwkrwZwAh47+XyNSR6mn3pgiEoS
Q8+WJChvT1kQ/XdYHo4GigjZIVXF0hUeA0GJJUoIdbJKl7O+8YLlOH0MDh8i0isX
iTLYJ+8bqv+F8ONYPxTXcdlw4pcYdQ==
=IJLZ
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
