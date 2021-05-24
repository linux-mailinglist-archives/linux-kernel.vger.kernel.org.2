Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD64338E826
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhEXN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:58:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37623 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhEXN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:58:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 429535C012E;
        Mon, 24 May 2021 09:56:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 24 May 2021 09:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=chBJ4ZOrDFbzWHlYJ/8zo5hqg1Y
        QbOQCWZSq+WmwgeI=; b=RMPCDPSXgL3lQnsxdLLnp5/0KVKQeJauD2AV4MOJcIC
        27hMW5QfqZB+KiDNFwT8F1DnU525JV4TL4uwJutYVxNn17paU1j7+pUBOKL2hZof
        kKuYwppQeEjcrPaxqR9LaftNVmBBHBIb6qkrLPPLUiluGDxvXqMH/7kONlfSTosc
        P4EC1iFWO6aiLyuTRmOTl+NDWDSdu7yR88Tgb8phAMR53XQfvRHvLJvZR1gpbjoI
        ddrL7eJiy962+mnLY58Yf1FdgQY/uy0FCLs2+LA/Cb5nj9mRezypIjGTdLx673tP
        y01pLfsWLoH+1CWxmg8HmJ+lgzZqRIK6qGsd7Zqt15A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=chBJ4Z
        OrDFbzWHlYJ/8zo5hqg1YQbOQCWZSq+WmwgeI=; b=WIrzBHmV0icVOgzNY3JdGb
        MUawHxg7z1B88pRRg+jYZnbG2fg/N6WaGeyVu/DFhCl4o4eBlFh1wviMRYF0gPXU
        VJSwxRdyXZICIR7eaYOggJgUw+T6XGAPF6chfFQKyMoA/oqf6COXbfIB1WH1G4/8
        k5Yn7v18B8ATJ6OPLkc5vxQtmw3wvalfGCnGum5yx7rttVBIQ6EhP3EQYKsx7C7I
        /Pxga275ubHqxUI2ezvZLa8/59pJv+Xtj6YcItTvicIfebUbRE4Ry08TuJ8xykY9
        u+sgkfYd3hSB9ZucmFpPpo9nBjj/+zfsvTu1/RIGnUOpA2IHBO8xwWqP9crCdzpg
        ==
X-ME-Sender: <xms:mLCrYNyRVgLhVoy0JMEMS5ASD6ga3zU8FRCenLUfLoJ-kb9UTnDzmw>
    <xme:mLCrYNTerUy0YFhn6qyEpGZpUSkhT_zMwk3VpP6sIQOnEFytriBKkJ6qFgmBfBHjK
    tQXIcAB2c3sB0DvFWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdfggfelgeehieeuieegfefgueduudefheffhfejleekheefjeevveegueel
    ueefnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:mLCrYHWwChcn5OwO3D5asSrPOCovrgDM8He8gE24pkRK4vNGKhTyLg>
    <xmx:mLCrYPir1dBnrvYH7K5b-pD-Q7I-o0wQ0KxQK3ARuh5P1ybFHdEu6A>
    <xmx:mLCrYPDMXri7PYidw84cp2hIZtaSov0FpnwUCbK4P4BhixYv9UHv6A>
    <xmx:mbCrYK7bdmxbLglhbQuL611g1cmd5lR0QTBWaHE3zjocdgF-wV4npw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 09:56:39 -0400 (EDT)
Date:   Mon, 24 May 2021 15:56:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
Message-ID: <20210524135638.uqx2pk4rj5pozs7c@gilmour>
References: <20210419025246.21722-1-samuel@sholland.org>
 <CAGb2v642Z3iH7fUWa31Rb5j+nWdZ=sXn2BYw3_dyE9P6iuL0Cg@mail.gmail.com>
 <20210419095443.1548432e@slackpad.fritz.box>
 <20210430091035.i4zoyzb4c2l22msb@gilmour>
 <20210430115545.6a45d1dc@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mb2hlya2v2axj4c2"
Content-Disposition: inline
In-Reply-To: <20210430115545.6a45d1dc@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mb2hlya2v2axj4c2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 11:55:45AM +0100, Andre Przywara wrote:
> On Fri, 30 Apr 2021 11:10:35 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> Hi Maxime,
>=20
> > On Mon, Apr 19, 2021 at 09:54:43AM +0100, Andre Przywara wrote:
> > > On Mon, 19 Apr 2021 11:17:19 +0800
> > > Chen-Yu Tsai <wens@csie.org> wrote:
> > >=20
> > > Hi,
> > >  =20
> > > > On Mon, Apr 19, 2021 at 10:52 AM Samuel Holland <samuel@sholland.or=
g> wrote: =20
> > > > >
> > > > > Dealing with the inconsistent numbering has been a major pain, and
> > > > > there is a solution with (as far as I can tell) no tangible downs=
ides.
> > > > > So let's use it. =20
> > >=20
> > > Thanks Samuel for sending this!
> > >  =20
> > > > > Yes, I know the kernel supports UUIDs for root=3D. But UUIDs do n=
ot help
> > > > > when referencing the whole, unpartitioned device, like is needed =
for
> > > > > updating the bootloader and firmware. So for the use case of "wri=
te a
> > > > > bootloader to the SD card, regardless of where the board is curre=
ntly
> > > > > booted from", I know of two options:
> > > > >   - Dig around in sysfs to find the mmc number from the MMIO addr=
ess,
> > > > >     which means I have to know the MMIO addresses for every SoC, =
or
> > > > >   - Apply patches like these.
> > > > >
> > > > > Samuel Holland (2):
> > > > >   ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
> > > > >   arm64: dts: allwinner: Enforce consistent MMC numbering
> > > > >
> > > > >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++   =20
> > > >=20
> > > > At least with Rockchip this is now done at the board level. IIRC it=
 was
> > > > a request from other people to not do it at the SoC level. I don't =
recall
> > > > exactly who though. =20
> > >=20
> > > FWIW, I am very much in favour of these patches, at a SoC level:
> > > The *SoC* BootROM imposes an order, by probing the first (by MMIO
> > > address order) MMC controller first for boot devices. IIRC that's a
> > > different story for Rockchip?
> > > And if people really don't care about the order, then having a certain
> > > order doesn't hurt, so we could as well use the "natural" order, as it
> > > was before. =20
> >=20
> > This doesn't have anything to do with the BootRom though but what we
> > provide to the userspace?
>=20
> My argument was that there is a "natural" order, not only by the
> location in the MMIO space, but on a more logical level: the "first" SD
> controller is first checked by the BootROM, so the SoC puts a "number
> 0" tag on this particular one. This is just because I heard the
> (reasonable) argument that location in MMIO space should not be
> significant, and deriving an order from that is arbitrary.

Unfortunately, the bootrom order is just as arbitrary. It's even worse
since it's inconsistent across SoCs. The A31 has that boot order:
https://linux-sunxi.org/BROM#A31

Do you really expect that we have a different ordering based on the
state of these pins for a given boot?

I know you don't :) And it's my point, really. There's no logical order
that is common to all the SoCs and all the buses. So there's no point in
even trying, the userspace and installers should just acknowledge that.

> > The userspace has no guarantee about the
> > kernel enumeration order for any bus (but UART for some reason), I'm not
> > really sure why MMC would be an exception.
>=20
> Userspace is one thing, but arguably there are ways to find the
> partition you are looking for, because you have all the kernel *and*
> userlevel tools at hand. The question is whether this needs to be overly
> complicated and harder for the user.
> But the other, more pressing problem is the kernel-only code in
> init/do_mounts.c, which has very limited means to find a
> certain partition (see below).

To some extent it's still a userspace issue: I never heard that
discussion for a server or desktop, even though they very much have the
same problem. It's not for those systems because they rely on UUIDs
and/or an initramfs to address it.

If you want to build a system that is generic enough that PARTLABEL or
PARTUUID doesn't work, it should be the preferred solution as well.

> > Especially since the kernel will not try to catch up, this will be
> > bound to be broken on a regular basis.
>=20
> What do you mean with "will not try to catch up"? Do you mean there
> might be other kernel changes that spoil the numbering again, in the
> future?

I mean, the kernel doesn't even try. It never really did either.

We have systems where even an aliases based solution wouldn't work
today, like the kettlepop (a CHIP with an eMMC) that has an eMMC but no
SD card by default, but an extension card exists that has this
capability.

The natural order without the extension would be mmc0 for the eMMC, but
obviously that would be mmc1 if the mmc0 controller is enabled, right?

> > And that aside, assuming that a device only has an eMMC this would
> > create the mmc2 device, which is completely weird and inconsistent
> > with how any other bus behaves.
>=20
> You have a point there, but I don't see how this would be a problem. I
> think one advantage is *consistent* numbering across reboots, so it
> will always be mmc2, even if you add a WiFi chip later (some boards
> have that as an option). Also those SD-card less system could surely
> override the labels in their board .dts files?

This is inconsistent with how any bus and devices behave in Linux. You
plug a USB key, the first one is going to be called sda. The first
graphics card is going to be card0, etc.

I don't see why we should make an exception for MMC buses on "embedded"
devices specifically. Or if we do, I want the embedded exception for a
few other things ;)

> > > Also UUIDs only help if you boot with an initramfs to resolve them,
> > > which proves to be extra pain if you don't compile kernels on the
> > > device, or not inside a distribution environment. =20
> >=20
> > I'm not sure what you mean? The kernel is perfectly able to resolve
> > them. You can also use PARTLABEL if you want something more user
> > friendly.
>=20
> init/do_mounts.c supports PARTUUID only, but most people/distributions
> use UUID, which is filesystem metadata, so not easily accessible for
> the kernel early and on a partition level only. And IIRC PARTLABEL is
> only available on GPT partitioned disks.
> Also PARTUUID is set at partition time, so a user formatting her own SD
> card (or just changing the partition table) will have a unique PARTUUID,
> and it cannot be used from within a filesystem image or
> prefabricated boot script to reference its own partition
> (in /etc/fstab).
> And in general UUIDs are not very human friendly, so their main domain
> is to be handled by code. I definitely don't memorise a single one of
> them, but I do remember root=3D/dev/mmcblk0p2.
>=20
> I find it *very* annoying to load my development kernel over TFTP, then
> booting them with the rootfs from SD card or eMMC, and seeing it fail
> about 50% of the time, because the numbering is off.

Yeah, I know, it's annoying to me too.

Maxime

--mb2hlya2v2axj4c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuwlgAKCRDj7w1vZxhR
xY1LAQDEzFxWOhQ+jLuvDrxwGvwpolEwK2uE4+u1Q91h327lMgEA4qUdCTDXGUAL
Y1NlXY9eR+qRWvLWqDyYg5zDcKnM6gA=
=fm02
-----END PGP SIGNATURE-----

--mb2hlya2v2axj4c2--
