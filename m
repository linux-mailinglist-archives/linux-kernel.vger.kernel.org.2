Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC4392EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhE0NF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:05:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhE0NFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IzFJwCBpTBHNAHayZpbaaG+HYYYb9w6NPRI7Eu3O+2Y=; b=QYIoOTUC1Uf9t0jIpRtLHdxQtP
        hf71Z3sVUCWNONwBhD9oT2cretWZl0b0tTem2h43+wRpF6BJgiw3qFjK+PAfF9+XidbBVWSt5Gqf8
        RL3oxbQT/Lxv+QCO5TzSnZKbqUK6DLt5wCC3byG8n8qmJoDWPor1ClGMAW6UyPm0zM+o=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lmFfi-006O36-7e; Thu, 27 May 2021 13:03:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7FF78D0EA1D; Thu, 27 May 2021 14:03:32 +0100 (BST)
Date:   Thu, 27 May 2021 14:03:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rudi Heitbaum <rudi@heitbaum.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, chenjh@rock-chips.com
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
Message-ID: <YK+YpBm9M2GbFGec@sirena.org.uk>
References: <20210526162342.GA20@8bbba9ba63a4>
 <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
 <20210527105943.GA441@7698f5da3a10>
 <CAMdYzYq8c4=D6_LxG2jPfbtPkOp5tN8oRA0zKt_OM6HLbnfFTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVOdrmUDn/PExWf2"
Content-Disposition: inline
In-Reply-To: <CAMdYzYq8c4=D6_LxG2jPfbtPkOp5tN8oRA0zKt_OM6HLbnfFTw@mail.gmail.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVOdrmUDn/PExWf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 27, 2021 at 07:26:01AM -0400, Peter Geis wrote:
> On Thu, May 27, 2021 at 6:59 AM Rudi Heitbaum <rudi@heitbaum.com> wrote:

> > > Since you aren't adding any functional code, is there a particular
> > > reason you can't just add the chip id and simply use the tcs4525
> > > compatible?
> > > This will prevent you from needing to modify the dt-bindings as well.

..

> > I chose to follow the example of silergy,syr827 and silergy,syr828 for
> > tcs4526 (given I made the mistake in assuming that support for tcs4525
> > meant support for tcs4525.) This would maintain consistency of naming of
> > tcs4526 throughout the source. Is that ok?

> It's fine to have both compatibles (and avoids confusion in
> device-trees), just remember to update the dt-bindings as well.
> It's funny to see drivers with both schemes, so we really have to
> decide which path we want to go down.
> Considering the syr827/syr828 as convention, we should probably just
> go down that route for consistency within the driver.

It is generally safer for the DT to be explicit about exactly
what the hardware is and then double check that this matches the
actual hardware, this gives more room for handling things with
quirks if needed in future and makes the life of people writing
DTs for boards easier since they don't need to remap part
numbers from the schematic to the DT.

> > +&gpu {
> > +       mali-supply = <&vdd_gpu>;
> > +       assigned-clocks = <&cru ACLK_GPU>;
> > +       assigned-clock-rates = <200000000>;
> > +       status = "okay";
> > +       /delete-property/ operating-points-v2;

> Removal of the operating points kind of makes the gpu regulator moot,
> don't you think?

It's still better to say what the supply is even if it can't be
changed - that stops you getting warnings about substituting in a
dummy regulator and allows the consumer to read the current state
of the regulator in case that's useful.

--nVOdrmUDn/PExWf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCvmKAACgkQJNaLcl1U
h9AS5gf+MyXoR1SRd4piOK0UplV96s3jVB5W+Nu4kZPj7iNbaUP7Mpj/yHR6Bm53
rjwUbCpnDJpt+Kjf3uJrSTHim8VYXidXiTykeEYyZTX9SFPRELLatDCd+lxyJSBT
aAGGOMyOX0tQR8+0IqHjS3iFX4/C7KoUcDVeMRILQGJj3x+QGZonSFssqrjjOnbv
L1LE/qJ/AhA8MNYdh027mDk2GcT6Pkv7nVTrf0qubDJNffLVA6NwjR3/xe4IKBph
DqWIj4LZeJGGH8XLp5yOab05BOvBQRFE0UX117GRvfvogOuOSmSzS/EeWS5sC9tS
YLW8k4v4p1yHrpDNwQ4YsE4X6XcorQ==
=smBU
-----END PGP SIGNATURE-----

--nVOdrmUDn/PExWf2--
