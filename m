Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E494425489
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhJGNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241536AbhJGNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E466460F6F;
        Thu,  7 Oct 2021 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633614346;
        bh=CzLXUpNEPe+Fc8D4lYwwX2ixsJtBDWtyruzWFlfomeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cp/yQ+YYegFh4JOVWZf2urVOANhRMdw83gJczirTSVqDvtLVaLXlg0ddDdNjuCR3V
         Hvc0MheowvxrzO36pEkvUNMBuupIyKILRvKHvCHm/f7jfFwltuLyNakC8gschlV58F
         RCh4SU28B2udGU5Wu/j0/+ayhvdDNKf1eG8t2LrDCzZUxl82xAQuta2A/HCYRmD227
         66xOEzpmSQoZycpSc00TpIaL0ATmTkXBh2xrJ7PxoEXzLiEDjjG26x+e1uohwtzto4
         Bv3Obpy2isyDcHITI8gfS1BKVMYLatzy1+u5dzQq4O2buus1y1zQh9c1DnUy74jMKh
         pSyKCw/EjIp4Q==
Date:   Thu, 7 Oct 2021 14:45:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, allen lin <allen_lin@richtek.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Message-ID: <YV76ByQWKvKNOvF0@sirena.org.uk>
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <YVw7vbpu4TS+7Su8@sirena.org.uk>
 <CADiBU39dvKS_a5FDgw9yMVFe8Uycn6bfjGwBWq+7MN_DdxkL1g@mail.gmail.com>
 <YVxFMaPhZdAFniMa@sirena.org.uk>
 <CADiBU3_TuHKiVG-r1TG-8WK_tW2GXi4VuqkidPwTyebOgE60OA@mail.gmail.com>
 <CADiBU3-4F-FdJxaa4Qp4xmUD3vsA=6u5_ojwDSr8zrDuW8JbXg@mail.gmail.com>
 <CADiBU38zCZk_P-q8BtbPfdeSacUF7LOvQYUFgvidbWZwcLY=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KwxzcL8DXmUlXdOr"
Content-Disposition: inline
In-Reply-To: <CADiBU38zCZk_P-q8BtbPfdeSacUF7LOvQYUFgvidbWZwcLY=wA@mail.gmail.com>
X-Cookie: Colors may fade.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KwxzcL8DXmUlXdOr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2021 at 10:44:49AM +0800, ChiYuan Huang wrote:
> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:47=E5=AF=AB=E9=81=93=EF=BC=9A
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:39=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=
=9A

> > > > > > I would expect this to be done through the regulator bindings, =
they
> > > > > > would allow the driver to query the supply voltage.

> > > > Please don't take things off-list unless there is a really strong r=
eason
> > > > to do so.  Sending things to the list ensures that everyone gets a
> > > > chance to read and comment on things.

> > After contacting our HW RD, to support DVDD 1.8V not just SW config,
> > also HW connections.
> > To get only DVDD supply voltage is not enough to meet the HW design.
> > The property seems indeed and need to be used by user's HW connection.

> > Can this property to be kept?

> After thinking, This property name may be improper.
> I think this change depends on HW external circuit for lowv application.
> Currently, I'm modifying the V3 change, this property name also affect
> the property parsing code change.
> May I directly change the name to 'richtek,dvdd-lowv-application' and
> submit the patch v3?

I still don't understand why you wouldn't describe this through the
regulator bindings, those exist to describe the physical supplies ont he
board and their constraints.

--KwxzcL8DXmUlXdOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFe+gcACgkQJNaLcl1U
h9CxxQf/XLbUqCBWX7z5jeyDmyDvwzHIRGbjEWm8prqmKXOYerIrsa1wQAASMVIq
CUtmTRz779PvbCbSxbrV/3PWBvAU8f+ViQdCdma3TEn5TuCjhNczdySN+g1psMto
34MvNT+bJSyiaL6dXErgyXSEbbNAbbcKTVGe0he258QVMYefv3KfWoN98AG67cKM
pzKdjihlrgvzG8lXnxwOEcaKTJSsbsrSe9F+sUbUe9A9TWPP7KAouF6LGczYmdHE
0HyOYoqjFNg6fhVqJSHSRUv5qsBFUZdblgOv4W83CTzKARal9+K2aLuchHn50yla
03nh+5FcXTlNEvuuegJZGkhjwMQs/w==
=wb/1
-----END PGP SIGNATURE-----

--KwxzcL8DXmUlXdOr--
