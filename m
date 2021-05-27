Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E7392F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhE0NHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:07:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhE0NHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UXGNIaSzoW/C0FndVcq3C1mNY97nbWGbAJ+OPbR6xYY=; b=GTWa8l9C5zkrPNxJlOYo7Hcxy+
        sxlKtTMD2sjrnxzrzqm69B0IMVgd/fflUJPk9clctfyXy4ceG/M16kogIT6FfB8kwFoXsg7B9uYj2
        CY+DdYz7iwBSilGJFFAT61J6JNVR9qZGkijAPgAoVxWFgTQcKroVaDxPR+0YSkloPXzQ=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lmFhy-006O7I-Kt; Thu, 27 May 2021 13:05:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 1D2C1D0EA33; Thu, 27 May 2021 14:05:53 +0100 (BST)
Date:   Thu, 27 May 2021 14:05:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Rudi Heitbaum <rudi@heitbaum.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        chenjh@rock-chips.com
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
Message-ID: <YK+ZMdD+7uqQwCow@sirena.org.uk>
References: <20210526162342.GA20@8bbba9ba63a4>
 <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
 <20210527105943.GA441@7698f5da3a10>
 <462b8d80447efb6c00e93704914169bceb5adc4d.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NyUceJCoDarUvku8"
Content-Disposition: inline
In-Reply-To: <462b8d80447efb6c00e93704914169bceb5adc4d.camel@collabora.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NyUceJCoDarUvku8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 08:51:27AM -0300, Ezequiel Garcia wrote:
> On Thu, 2021-05-27 at 10:59 +0000, Rudi Heitbaum wrote:

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reg =3D <0x1c>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0vin-supply =3D <&vcc5v0_s=
ys>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0regulator-compatible =3D =
"fan53555-reg";

> I can be wrong, but I think regulator-compatible is deprecated.

Yes.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0regulator-ramp-delay =3D =
<1000>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fcs,suspend-voltage-selec=
tor =3D <1>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0regulator-always-on;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0regulator-boot-on;

> Just out of curiosity, is regulator-boot-on really needed for the GPU?

It should only be used if it's not possible to read the state of
the regulator enable from the hardware.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--NyUceJCoDarUvku8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCvmTAACgkQJNaLcl1U
h9CX9ggAgzyzUvDEBdNIyiQB7N7iaoLnBcDf4WWsOC8pOpOinrfXGplncFDVXzcz
jirCOSxb0jLmCwKEMbFrSaOYw2SZuDbVtDDnYwsFBXBmL4wedkU8n0c5eJ5DK88L
bJ5gToio6MmqIL1Yb9QPI7XsQeEvF/LxN/QzwXr3KqTZeB6hATgg4EqrRNyLjbvS
Ra7dmlehkgQ6Ym6aL5cTaxFPkffpASi1MnvaUhyEEsbiXTbC+dWmLGovVMRrf6GY
g4/vglOQe0uuMBGRpoy1s2SRLOSeKcCwZOKoLITxpTsT6YhZw1BDw48o2Vaxzcdb
up/35XqdtRuBzEDTd/sC9Fv2raCEzQ==
=vK9F
-----END PGP SIGNATURE-----

--NyUceJCoDarUvku8--
