Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA64426B58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhJHM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:57:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38493 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbhJHM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:57:52 -0400
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 11D2D20000F;
        Fri,  8 Oct 2021 12:55:54 +0000 (UTC)
Date:   Fri, 8 Oct 2021 14:55:54 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YWA/2o/Df34VDcpp@aptenodytes>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
 <YVapVLnGfSBZCDTY@matsya>
 <YV463gUvYauhDP/l@pendragon.ideasonboard.com>
 <20211007121436.jkck2cue5zd3rys4@ti.com>
 <YWAdKTvYzF58oyU/@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L5dYWIzivIAnCCEH"
Content-Disposition: inline
In-Reply-To: <YWAdKTvYzF58oyU/@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L5dYWIzivIAnCCEH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 08 Oct 21, 13:27, Laurent Pinchart wrote:
> Hi Pratyush,
>=20
> On Thu, Oct 07, 2021 at 05:44:38PM +0530, Pratyush Yadav wrote:
> > On 07/10/21 03:10AM, Laurent Pinchart wrote:
> > > On Fri, Oct 01, 2021 at 11:53:16AM +0530, Vinod Koul wrote:
> > > > On 17-09-21, 22:58, Pratyush Yadav wrote:
> > > > > On 16/09/21 12:22PM, Paul Kocialkowski wrote:
> > > > > > On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> > > > > > > The Cadence DPHY can be used to receive image data over the C=
SI-2
> > > > > > > protocol. Add support for Rx mode. The programming sequence d=
iffers from
> > > > > > > the Tx mode so it is added as a separate set of hooks to isol=
ate the two
> > > > > > > paths. The mode in which the DPHY has to be used is selected =
based on
> > > > > > > the compatible.
> > > > > >=20
> > > > > > I just realized that I didn't follow-up on a previous revision =
on the debate
> > > > > > about using the phy sub-mode to distinguish between rx/tx.
> > > > > >=20
> > > > > > I see that you've been using a dedicated compatible, but I'm no=
t sure this is a
> > > > > > good fit either. My understanding is that the compatible should=
 describe a group
> > > > > > of register-compatible revisions of a hardware component, not h=
ow the hardware
> > > > > > is used specifically. I guess the distinction between rx/tx fal=
ls under
> > > > > > the latter rather than the former.
> > > > >=20
> > > > > I am not sure if that is the case. For example, we use "ti,am654-=
ospi"=20
> > > > > for Cadence Quadspi controller. The default compatible, "cdns,qsp=
i-nor",=20
> > > > > only supports Quad SPI (4 lines). The "ti,am654-ospi" compatible =
also=20
> > > > > supports Octal SPI (8 lines).
> > > >=20
> > > > Those are hardware defaults right?
> > > >=20
> > > > > In addition, I feel like the Rx DPHY is almost a different type o=
f=20
> > > > > device from a Tx DPHY. The programming sequence is completely dif=
ferent,=20
> > > >=20
> > > > Is that due to direction or something else..?
> > > >=20
> > > > > the clocks required are different, etc. So I think using a differ=
ent=20
> > > > > compatible for Rx mode makes sense.
> > > >=20
> > > > Is the underlaying IP not capable of both TX and RX and in the spec=
ific
> > > > situations you are using it as TX and RX.
> > > >=20
> > > > I am okay that default being TX but you can use Paul's approach of
> > > > direction with this to make it better proposal
> > >=20
> > >=20
> > > Given that the RX and TX implementations are very different (it's not=
 a
> > > matter of selecting a mode at runtime), I'm actually tempted to
> > > recommend having two drivers, one for the RX PHY and one for the TX P=
HY.
> > > This can only be done with two different compatible strings, which I
> > > think would be a better approach.
> >=20
> > FWIW, I think having different drivers would certainly make things=20
> > easier to maintain.
>=20
> I'm sorry for not having recommended this in the first place.
>=20
> Any objection from anyone against going in this direction ?

So apparently there is not a single register that is shared between rx and =
tx
and clocks are not the same either so it feels to me like a separate driver
would be legit. This looks like two distinct IPs sharing the same base addr=
ess.

Cheers,

Paul

> > > It's unfortunate that the original compatible string didn't contain
> > > "tx". We could rename it and keep the old one in the driver for backw=
ard
> > > compatibility, making things cleaner going forward.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--L5dYWIzivIAnCCEH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmFgP9oACgkQ3cLmz3+f
v9Hxvwf/e/A29WlDAhrBrskZq6ow7NWWzWAoCdjdGQl/QDZmIe7f2+93Q97rjSLn
eiXMvHxgnuvkm4KWlGM7MBEczcwbSfnZKyu48UWYsdGwfkNAvLJEka522u7nhsxY
j68hda1nI6BpV7tmX4zsQH/kySF/z1Z787q/CoYl7Yq/dYxtNW8L0EDval4kbYQI
vHu4CXsmFw0ToPPJd0d4wBrD8WEU8wQX6CkNhDIw92RCzMMJu7jy9FRD5/ekF93P
Bty3NYcL3a9jcNoX82BeFcBbRE+xyJxeCHR8KpBAmgTaVefI3E6aoPQL1L55bN1v
SuwC4/l8Bq3f03IyIv222HfPQ6rURw==
=ceu9
-----END PGP SIGNATURE-----

--L5dYWIzivIAnCCEH--
