Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C16311000
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhBEQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:52:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:52262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhBEQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D66C0AC97;
        Fri,  5 Feb 2021 18:30:47 +0000 (UTC)
Message-ID: <21b99f074d6e4ce469cb37d3b73c2cce5c728200.camel@suse.de>
Subject: Re: [RFC/PATCH 05/11] soc: bcm: bcm2835-power: Add support for
 BCM2711's ARSAN ASB
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     phil@raspberrypi.com, Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     wahrenst@gmx.net, linux-kernel@vger.kernel.org
Date:   Fri, 05 Feb 2021 19:30:46 +0100
In-Reply-To: <d081a505-487d-eb29-94fd-5e1f638bba29@gmail.com>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
         <20210205135249.2924-6-nsaenzjulienne@suse.de>
         <d081a505-487d-eb29-94fd-5e1f638bba29@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ve1mgrYE5Du9Qi/w9WRE"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ve1mgrYE5Du9Qi/w9WRE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian, Phil,

On Fri, 2021-02-05 at 08:56 -0800, Florian Fainelli wrote:
> On 2/5/21 5:52 AM, Nicolas Saenz Julienne wrote:
> > In BCM2711 the new ARGON ASB took over V3D. The old ASB is still presen=
t
> > with the ISP and H264 bits, and V3D is in the same place in the new ASB
> > as the old one.
> >=20
> > Use the fact that 'pm->arsan_asb' is populated as a hint that we're on
> > BCM2711. On top of that introduce the macro ASB_BASE() which will selec=
t
> > the correct ASB register base, based on whether we're trying to access
> > V3D and which platform we're on.
>=20
> Your subject has a typo, you most likely intended to write "Argon ASB",
> right?

Yes, sorry for that, the typo is also present in code. I mindlessly decided
both words meant the same and went with it...

So, for the record, s/arsan/argon/ should be applied on all patches, bindin=
g is
fine in that regards. On the other hand, the old arsan/rpivid ASB is refere=
nced
as 'asb' in code, and as 'arsan' in the bindings, I'll rename both to 'rpiv=
id'
in v2.

Actually, if all this is too confusing, let me know and I'll send a v2 righ=
t
away.

> I will review the series a little later today.

Thanks!
Nicolas


--=-ve1mgrYE5Du9Qi/w9WRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAdjtYACgkQlfZmHno8
x/5ViwgAhkx8nnXPFByURX//saW7jL1Odv4Zls+xWQf3h5XuvODF53p49Rdxo3dd
BzUPPXaL6oG+hasEJ2mDc+M4qW7COHCsAVJAuMYWL/+aqt14gZQOWw64PdzgostE
72akjvWauXMmxLO2tbQkZh/YaQ0U591CGYGNr5A5bAP7FMTk6ilNOmjo2gKCBUCL
6i8X4gjKc26/K71OIR/p0YgutEV9WweoLppszWUArgx5l5a4srfcOa9XXVBNyWeU
ZIHUM9k8Y6VmhRpsLFt0owvM60omWNjktdNk9atZATqwFx8CIkbN0jMFtNC4XoE4
3wlnvTbv7xsY+3rYcvmSPSaVZumfqw==
=4k52
-----END PGP SIGNATURE-----

--=-ve1mgrYE5Du9Qi/w9WRE--

