Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6953AB9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhFQQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhFQQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E294E613BA;
        Thu, 17 Jun 2021 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623947380;
        bh=h8mWdalnwqOGxgPzDDjfRank/448I/bBBc4d6qKMLj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvZ0+KKAuAFqDjU/hLzVEd/T///kIjlioxINYjvjY7itetWi7+YvxllivGbc8WZCA
         ORi9Vj+QxOVl5mxSGnXm3rnUbFdSJRtgVd3zyegtwCxVEeq3uHQVMZsoUFYEtUdzMm
         AMHHcEKm/UdgfO/1cSxmAhUe/3ZPmUuhZjB0XkoSlesVpDNSsQclTVcEzCqUejVc3Z
         hT0kUcrnqEfr44kKGRNLVCfuRtMItcmE6KXjzrWYYWb6lIIu5vLgXEUaKKtZC9nCfN
         7g3gTL9VyYi/X6olvFozUsgvwlVkp06+lQKmQ1G2Vh5KzlXVbUztan/2qWZ/nSsFJ9
         85uOir0giuq2Q==
Date:   Thu, 17 Jun 2021 17:29:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, cy_huang <cy_huang@richtek.com>,
        gene.chen.richtek@gmail.com
Subject: Re: [PATCH 1/2] regulator: mt6360: Add optional
 mediatek.power-off-sequence in bindings document
Message-ID: <20210617162919.GH5067@sirena.org.uk>
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
 <20210611201643.GA1583875@robh.at.kernel.org>
 <CADiBU39Prz99ZLtkYdcM9XDQsd0nKKeiEGjW3wq=u75JGjwX=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <CADiBU39Prz99ZLtkYdcM9XDQsd0nKKeiEGjW3wq=u75JGjwX=g@mail.gmail.com>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 11:04:01PM +0800, ChiYuan Huang wrote:
> Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=884:16=E5=AF=AB=E9=81=93=EF=BC=9A

> > > Originally, we think it must write in platform dependent code like as=
 bootloader.
> > > But after the evaluation, it must write only when system normal HALT =
or POWER_OFF.
> > > For the other cases, just follow HW immediate off by default.

> > Wouldn't this be handled by PSCI implementation?

> No, the current application default on powers buck1/buck2/ldo7/ldo6
> are for Dram power.
> It's not the soc core power. It seems not appropriate  to implement
> like as PSCI.
> MT6360 play the role for the subpmic in the SOC application reference des=
ign.

If this is part of the overall system power off that seems like it fits
well enough into what PSCI is doing - it's got operations like
SYSTEM_OFF which talk about the system as a whole.

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLeF8ACgkQJNaLcl1U
h9DoNAf/ay42021AEwWsgvVf64PZ7bfN1VQtq5/Gvxa3qKXwvF2ElhI0rEWVv+TD
ykW5worWSNVBlrmXT5e5pG0vDPAqQ4XSgOsubJCj7BWz/o8vebLSclpZz0PDQCav
Dbt3qvsDnTcOMOMucTRf2X4u9SHAVgE06JDUiZTcEqprRk4Vd4ye6i6REqw2t2wX
ydNjf2EsU1b9nzoVuyzhnLA9p1p5wiiYEzhCoFw+4x2BYypYNT4bk6xRQ/IitcIl
ZrtklyKL+G3Ty7Ul9AREvr++U177bA902zg+5kCh2NvrmcPDwQahA3zx06NePexK
B6Ch9wofiE4v/hRfzXuS7w4Q85k2Vg==
=/WVl
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
