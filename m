Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6053930BB98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBBJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:58:02 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35527 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhBBJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:57:46 -0500
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BA0BA24000C;
        Tue,  2 Feb 2021 09:56:56 +0000 (UTC)
Date:   Tue, 2 Feb 2021 10:56:56 +0100
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
Message-ID: <YBkh6IZfmzaLWYPp@aptenodytes>
References: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FywNW6//oMEHP8B6"
Content-Disposition: inline
In-Reply-To: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FywNW6//oMEHP8B6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nikolaus,

On Tue 02 Feb 21, 10:18, H. Nikolaus Schaller wrote:
> Hi,
> since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.
>=20
> I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
> the commit mentioned in the subject is the reason.
>=20
> Reverting it makes the display work again and re-reverting fail again.
>=20
> IMHO it seems as if the display DMA of the pinephone (allwinner suni-a54)
> got influenced and stopped to scan the framebuffer.
>=20
> The only dma-ranges I could find are defined here:
>=20
> 	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>=20
> 	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
>=20
> but I can't tell if they are "valid" or not.
>=20
> Any insights are welcome. And please direct to the right people/mailing l=
ists
> if they are missing.

This may not be strictly the same thing, but is this patch in your tree:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210115175831.=
1184260-2-paul.kocialkowski@bootlin.com/

If not, it's worth a try to add it. If it is, it's worth doing a revert.

My understanding is like DE2 does not need a particular DMA range and has D=
RAM
starting at 0x40000000 (just like the CPU) but it will map DRAM in a loop
before and after this address.

I suspect the issue shows because the pinephone has 2 GiB RAM while for oth=
er
boards with < 2 GiB RAM, removing 0x40000000 to the DMA addresses still poi=
nts
to the same location. So IMO the MBUS dma-ranges shouldn't apply to DE2.
I think this is already the case in dt, but the mbus driver may add it if y=
ou
don't have that patch.

I think I have a few A64 boards around, but probably not with 2 GiB RAM.
If adding the patch doesn't help, I'll try to make a few test.

Cheers!

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--FywNW6//oMEHP8B6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAZIegACgkQ3cLmz3+f
v9GMSwf+M9LokGcpYmUUjM+QKbQiZN+fF/QxqEV2cZdtgl0cuDkv/sLpvDmmj5O4
LT75CStM2LUBo2KYk97saEHX+5KxDeOCDpcyKb+PiTIuCZ0K2XaxMoGSs24XBJHC
+oPPXUWgZ5JowcwObvEyp9dnAjYeqSLmK8vtZs/n80hGWhvrvzf++Jdo0Qy+TAwK
ltD54b3Y2Yl3P5jUB4SxmrK0/FPXOeId5yN8x316/rXEcCqntpMbTMjU1nqkAr4r
ydOcWbqqdedPGVufLwvQaECPmBZrmI9Yxzsffbw3ijOrLAv5NHsSADG+D632WcgW
tbDQj8VryIs602K1KVnMNWL+9oPxng==
=x65B
-----END PGP SIGNATURE-----

--FywNW6//oMEHP8B6--
