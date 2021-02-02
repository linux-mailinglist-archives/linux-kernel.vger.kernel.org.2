Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CB30BC6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBBKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:53:55 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:16871 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBBKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612263061;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
        From:Subject:Sender;
        bh=PeVAVapo36NVgNgQvCQ5f98Kwxxzz3njm4fOPjoLqmE=;
        b=oKLvU7zwZSdbyQUiwxFp6lmK7NLKyoXencqyjn1aAOKJ2G4W+Bucc6maOZRFI3NG+5
        XlB53vdqMo1HI6kJ6xn0hawqIaL8FEGuOsXJSoCXgFlLedPURgAaIRaZdHt7TPyF1ofD
        Iqj73iyYIAK9pbI3gQd8ehdbpkUvbuwr7hcM3WgIEkF4hY6WgyQbT1H8Gavg0UsY7LFM
        izGFNa2H8RkUG6VMrS0Gx9LtLrdaGrte6LiAYxU0CzKtXgnwlriGy3d91aWjfLDdIcTe
        sesW0ub4yP21vSSYXvUK7VwEAEOXqeItfIGR8fSb7kECmZWyEocWKmcQaOTYxXTL4la5
        4D0Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PqwDOsGq4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id R01a2bx12AonLh7
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 11:50:49 +0100 (CET)
Subject: Re: BOG: commit 89c7cb1608ac3 ("of/device: Update dma_range_map only when dev has valid dma-ranges") seems to break Pinephone display or LCDC
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <YBkh6IZfmzaLWYPp@aptenodytes>
Date:   Tue, 2 Feb 2021 11:50:48 +0100
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E45AE13E-6A74-43E6-A7AE-B0D425B10344@goldelico.com>
References: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com> <YBkh6IZfmzaLWYPp@aptenodytes>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 02.02.2021 um 10:56 schrieb Paul Kocialkowski =
<paul.kocialkowski@bootlin.com>:
>=20
> Hi Nikolaus,
>=20
> On Tue 02 Feb 21, 10:18, H. Nikolaus Schaller wrote:
>> Hi,
>> since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.
>>=20
>> I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
>> the commit mentioned in the subject is the reason.
>>=20
>> Reverting it makes the display work again and re-reverting fail =
again.
>>=20
>> IMHO it seems as if the display DMA of the pinephone (allwinner =
suni-a54)
>> got influenced and stopped to scan the framebuffer.
>>=20
>> The only dma-ranges I could find are defined here:
>>=20
>> 	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>=20
>> 	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
>>=20
>> but I can't tell if they are "valid" or not.
>>=20
>> Any insights are welcome. And please direct to the right =
people/mailing lists
>> if they are missing.
>=20
> This may not be strictly the same thing, but is this patch in your =
tree:
> =
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210115175831=
.1184260-2-paul.kocialkowski@bootlin.com/
>=20
> If not, it's worth a try to add it.

No, it hasn't arrived in v5.11-rc6 (or linux-next) yet.

But it fixes the issue.

great and many thanks,
Nikolaus

> If it is, it's worth doing a revert.
>=20
> My understanding is like DE2 does not need a particular DMA range and =
has DRAM
> starting at 0x40000000 (just like the CPU) but it will map DRAM in a =
loop
> before and after this address.
>=20
> I suspect the issue shows because the pinephone has 2 GiB RAM while =
for other
> boards with < 2 GiB RAM, removing 0x40000000 to the DMA addresses =
still points
> to the same location. So IMO the MBUS dma-ranges shouldn't apply to =
DE2.
> I think this is already the case in dt, but the mbus driver may add it =
if you
> don't have that patch.
>=20
> I think I have a few A64 boards around, but probably not with 2 GiB =
RAM.
> If adding the patch doesn't help, I'll try to make a few test.
>=20
> Cheers!
>=20
> Paul
>=20
> --=20
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

