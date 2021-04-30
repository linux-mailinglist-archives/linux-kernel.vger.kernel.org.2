Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A905F36F798
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhD3JL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:11:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58945 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhD3JL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:11:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 875515C0032;
        Fri, 30 Apr 2021 05:10:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 30 Apr 2021 05:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DgPXkCNwhuM1PvuNpQB5vO85GXk
        9IVTLv4pIOEkACM8=; b=v3lFalLS2TrtaF/aAKRNtCRKo3X9KKsTJPpbZDbALtO
        TBZfUyMeRdDSnVkzhYJ0hTaRqiK1la++4dg3x/o/lFAZJjWKEjouSxHiXjpp/7V3
        GcZtuH7Jz0vb+aK9kQO1NpHjdSqA5NXZLm98uz0dE+LLfiWsso+BoBulMdGJ/BCg
        NLCkTemN9sdyyOjFIoYRBoi6CmjhlsZtIEreEnIiXVY1XbP512vkemu76JtmQG+T
        soYufUFwf6paOCwAS1zu4aYfjUlf9YzruiIRIHy/If8w/vi2uH6E7PsDslYx2T5v
        3dtGpNGWPDK9N/b2IdfhOtXKPuoPtRKbRukx/PplrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DgPXkC
        NwhuM1PvuNpQB5vO85GXk9IVTLv4pIOEkACM8=; b=sFY/ECTsNNXUjSfwBt6lFu
        BJfDhttISlFO4bU/nzfmphsiTRMvkRfPRdPP3Sdy7C557AhTifO5usvA7iVzrPLM
        PPbR9noGUEONxwEuDcYz4ok5Nv30zc5qOZ1xsdmqn5H5dzBHHZSSMupZrqZ/EI+h
        WOwfJ/agiVqE4OYuviOXyC5Sc9/x8NvvZvG4uPV2ompJWuIW8s767yW0+NRj+lrD
        wm2W/SQ9YVQAoF7jfGN9bf+ORVQ+hE3IZRw79eCSw9Jebt31hDV5XQ2bTYaEiB8b
        GMyxricEnXr5+kmywZ7x/VpkKnJLij8chr3yWx10Ol+dvSTGsHCpUO1Ai8AvC74Q
        ==
X-ME-Sender: <xms:jcmLYIv46PFH2I-yNC0GBVVTHo1wtbmhmYsub_r28nDlmmxaw0tsAw>
    <xme:jcmLYFfRmEELpEAy70HCBIzKVxE80lyJz2ULLpqLaoXCz8BOPoxox3Ox7ouChhBym
    R-ddg5bofsDlBhBMog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jcmLYDykuZ_CP5JV8lF6npKjNeBo-VDdNnCaVq7GS4m2DlyhlQkQbQ>
    <xmx:jcmLYLNBzH8upGuc3c63EbYnRSgWC2Mo3kPlHuKBOb_f6LF8dW91Ew>
    <xmx:jcmLYI-PRvTdFHdebQ7onUcahcQaSSxSIq1af5ejZkNGAoWQECaG0A>
    <xmx:jsmLYHl0OezGXOTggnNmAyoPAE5wTh9EwOZg8wVI6WS3gXwxvSkBsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 30 Apr 2021 05:10:37 -0400 (EDT)
Date:   Fri, 30 Apr 2021 11:10:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
Message-ID: <20210430091035.i4zoyzb4c2l22msb@gilmour>
References: <20210419025246.21722-1-samuel@sholland.org>
 <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
 <20210419095443.1548432e@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5enpgdo5lledv3vf"
Content-Disposition: inline
In-Reply-To: <20210419095443.1548432e@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5enpgdo5lledv3vf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 09:54:43AM +0100, Andre Przywara wrote:
> On Mon, 19 Apr 2021 11:17:19 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>=20
> Hi,
>=20
> > On Mon, Apr 19, 2021 at 10:52 AM Samuel Holland <samuel@sholland.org> w=
rote:
> > >
> > > Dealing with the inconsistent numbering has been a major pain, and
> > > there is a solution with (as far as I can tell) no tangible downsides.
> > > So let's use it.
>=20
> Thanks Samuel for sending this!
>=20
> > > Yes, I know the kernel supports UUIDs for root=3D. But UUIDs do not h=
elp
> > > when referencing the whole, unpartitioned device, like is needed for
> > > updating the bootloader and firmware. So for the use case of "write a
> > > bootloader to the SD card, regardless of where the board is currently
> > > booted from", I know of two options:
> > >   - Dig around in sysfs to find the mmc number from the MMIO address,
> > >     which means I have to know the MMIO addresses for every SoC, or
> > >   - Apply patches like these.
> > >
> > > Samuel Holland (2):
> > >   ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
> > >   arm64: dts: allwinner: Enforce consistent MMC numbering
> > >
> > >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++ =20
> >=20
> > At least with Rockchip this is now done at the board level. IIRC it was
> > a request from other people to not do it at the SoC level. I don't reca=
ll
> > exactly who though.
>=20
> FWIW, I am very much in favour of these patches, at a SoC level:
> The *SoC* BootROM imposes an order, by probing the first (by MMIO
> address order) MMC controller first for boot devices. IIRC that's a
> different story for Rockchip?
> And if people really don't care about the order, then having a certain
> order doesn't hurt, so we could as well use the "natural" order, as it
> was before.

This doesn't have anything to do with the BootRom though but what we
provide to the userspace? The userspace has no guarantee about the
kernel enumeration order for any bus (but UART for some reason), I'm not
really sure why MMC would be an exception. Especially since the kernel
will not try to catch up, this will be bound to be broken on a regular
basis.

And that aside, assuming that a device only has an eMMC this would
create the mmc2 device, which is completely weird and inconsistent with
how any other bus behaves.

> Also UUIDs only help if you boot with an initramfs to resolve them,
> which proves to be extra pain if you don't compile kernels on the
> device, or not inside a distribution environment.

I'm not sure what you mean? The kernel is perfectly able to resolve
them. You can also use PARTLABEL if you want something more user
friendly.

Maxime

--5enpgdo5lledv3vf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYIvJiwAKCRDj7w1vZxhR
xezdAQDIY6qe0cw/YeAwFhjlA5dAKEDjlxwmNTpj6ztkqfs/4wD/ckzHAVsRq/tR
KkQbbJcdqKeAzIEY1dSy+rvOusXqqAA=
=DXm6
-----END PGP SIGNATURE-----

--5enpgdo5lledv3vf--
