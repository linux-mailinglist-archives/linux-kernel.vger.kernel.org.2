Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4923A30BFEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBBNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:46:01 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51773 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhBBNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:43:39 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 010201BF20A;
        Tue,  2 Feb 2021 13:42:52 +0000 (UTC)
Date:   Tue, 2 Feb 2021 14:42:52 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: BOG: commit 89c7cb1608ac3 ("of/device: Update dma_range_map only
 when dev has valid dma-ranges") seems to break Pinephone display or LCDC
Message-ID: <YBlW3ES1E5SwUOpJ@aptenodytes>
References: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
 <YBkh6IZfmzaLWYPp@aptenodytes>
 <E45AE13E-6A74-43E6-A7AE-B0D425B10344@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NCITzV7iYwPHdQvU"
Content-Disposition: inline
In-Reply-To: <E45AE13E-6A74-43E6-A7AE-B0D425B10344@goldelico.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NCITzV7iYwPHdQvU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nikolaus,

On Tue 02 Feb 21, 11:50, H. Nikolaus Schaller wrote:
> Hi Paul,
>=20
> > Am 02.02.2021 um 10:56 schrieb Paul Kocialkowski <paul.kocialkowski@boo=
tlin.com>:
> >=20
> > Hi Nikolaus,
> >=20
> > On Tue 02 Feb 21, 10:18, H. Nikolaus Schaller wrote:
> >> Hi,
> >> since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.
> >>=20
> >> I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
> >> the commit mentioned in the subject is the reason.
> >>=20
> >> Reverting it makes the display work again and re-reverting fail again.
> >>=20
> >> IMHO it seems as if the display DMA of the pinephone (allwinner suni-a=
54)
> >> got influenced and stopped to scan the framebuffer.
> >>=20
> >> The only dma-ranges I could find are defined here:
> >>=20
> >> 	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>=20
> >> 	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
> >>=20
> >> but I can't tell if they are "valid" or not.
> >>=20
> >> Any insights are welcome. And please direct to the right people/mailin=
g lists
> >> if they are missing.
> >=20
> > This may not be strictly the same thing, but is this patch in your tree:
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210115175=
831.1184260-2-paul.kocialkowski@bootlin.com/
> >=20
> > If not, it's worth a try to add it.
>=20
> No, it hasn't arrived in v5.11-rc6 (or linux-next) yet.
>=20
> But it fixes the issue.

Great! The patch should already be on its way to the next RC.

And nice to see you're active on Pinephone as well! You might remember me f=
rom
the Replicant project, as I've worked a bit on the GTA04 :)

> great and many thanks,
> Nikolaus

Cheers,

Paul

> > If it is, it's worth doing a revert.
> >=20
> > My understanding is like DE2 does not need a particular DMA range and h=
as DRAM
> > starting at 0x40000000 (just like the CPU) but it will map DRAM in a lo=
op
> > before and after this address.
> >=20
> > I suspect the issue shows because the pinephone has 2 GiB RAM while for=
 other
> > boards with < 2 GiB RAM, removing 0x40000000 to the DMA addresses still=
 points
> > to the same location. So IMO the MBUS dma-ranges shouldn't apply to DE2.
> > I think this is already the case in dt, but the mbus driver may add it =
if you
> > don't have that patch.
> >=20
> > I think I have a few A64 boards around, but probably not with 2 GiB RAM.
> > If adding the patch doesn't help, I'll try to make a few test.
> >=20
> > Cheers!
> >=20
> > Paul
> >=20
> > --=20
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--NCITzV7iYwPHdQvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAZVtwACgkQ3cLmz3+f
v9HKOQf/Ut0tW+f5rk40F9VHRyUZBcEyE272o7KMfQOGt3qWf74rCuce+H6opbdq
M8Ouu6o5asniVNsn51P5Bzn+LGo/r3BcXMqjz3zyFrT8QriEVO5GkF/xqAQjfuNE
Q0eEg/kt1O3Wubzt59xaQ9eCKlgUJalvhKel0Wfhhx4iuU5w5wazfIyv7W5hzauB
gevB0AGzX9ohO67J52VxErmrLRf5+MM+cg57l3uuW2bS6SIn4M6eylz2dii7C3LE
l6pu0jdJss/IrwifOrAW4cOvVmYb0MyFdfm3HSLOAiU+zqLPzw+H55KfiWpvucDq
rTfx30b031A39GwZdB+AKog7R1g5ng==
=zic6
-----END PGP SIGNATURE-----

--NCITzV7iYwPHdQvU--
