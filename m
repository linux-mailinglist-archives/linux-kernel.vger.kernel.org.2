Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74239DD8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:24:55 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:46241 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:24:53 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 81482580579;
        Mon,  7 Jun 2021 09:23:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 07 Jun 2021 09:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eIGEOso5WV+AOgirZtfFc6JFRhs
        xePWMObTrGPYzxdE=; b=hI86DV35aCBf34dHf9ILs9hXUs/wgUb0aZnNxSVWnPF
        Sk7M/gj6gaF3I9oVhXOU9cVftfwtViGnN6RZID2gjPJicHP8oXKDteZCcNrwL16f
        DOj3krZtgCFrRzUF5AxZ6PlDMEsNyhJLU8fPdOdbeaXeAmx/CmYXhsNpcAu8RqN3
        J1JO0l75btousxw2qdROB45k5mzLn4ltAA50YjElVSeo2144Mna5On9enYlcaAiA
        D1CUHbkvL5jOyqg0nyo7UfJIy7r4FZmyT/bzGHlC6vCjqKGptqO/Sf/qY2IXeFst
        frQKGtqzqQYqHd685HMUdkkiBIEAv0wB+ZVKk85I1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eIGEOs
        o5WV+AOgirZtfFc6JFRhsxePWMObTrGPYzxdE=; b=QsetC05r8jv/tx2c6VYG1o
        ySKTHkDnhdO97GXt/MrI8F+Bd/AJPyeiQPC6EoCXRcUrM3zgGiByemEtwsgJmRBk
        vdxn7jY6RPoS27CULafVmDCJY987tkFQkY6P7rsvFw/vk8exjkNEcGyBiKEwII9Y
        eFFhbWP1rkhtsICJGOfxK0Im7V08sPPdIGTcjHmvQXB0e7ERmQXt7DluY0w5e/8+
        A/goRUvkYJLKYP1vU6rU546N5BTN6JjDTGc2IwIykVpVbj0Oas21YwT5bN/+gcxY
        myAlzSNkgw2VWpAkXtPLGFYaFmheydfM2YvEknQtwNcZ/E+l9u1SFi3sskRQ0oBQ
        ==
X-ME-Sender: <xms:sh2-YKb3d4Xd5RLDWWUCTqXFsmredhExw1N0IdEU6Mi3wCvWZ8ZPkQ>
    <xme:sh2-YNaxkSVQgkvsZr_u218E8-Wd4rHUTG2DqDX37IdLDEdpoXAlc6-WkgGJrXXiS
    33O-_KHhS42IbPRyqw>
X-ME-Received: <xmr:sh2-YE9Ud2Ei4GQy5ldpkLjRkKWgcnokR-PAPRDLNnjpZQXo5OXBCCyD9eBzpyYdYWE1Dg2z3UQFORTqS9qhuXG0i4_KtvgBH3SY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sh2-YMpLRTV_9DQG505QhkLWlE7WFpIZ3Cq9a0kCHa7aVe4pojPy7g>
    <xmx:sh2-YFqFFDdAp6-890Gg7wl4ChKLDB_EP2EFWJ3gawE_BxIMEZqyzw>
    <xmx:sh2-YKQ_al-qaoCiDwvhKLYeI-y3a7_kpOEy9aOpIpPl8cJ_5qdItg>
    <xmx:tR2-YG6s32D0mQGsspz303hd6NGkhWAC0EJOfxbFHKIcsEEVIx6nsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 09:22:58 -0400 (EDT)
Date:   Mon, 7 Jun 2021 15:22:55 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 12/17] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Message-ID: <20210607132255.7fa75a7k7ud2g7ux@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-13-andre.przywara@arm.com>
 <20210524115946.jwsasjbr3biyixhz@gilmour>
 <20210525122901.778bfccd@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2gxgfnqjc5ew5rx"
Content-Disposition: inline
In-Reply-To: <20210525122901.778bfccd@slackpad.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2gxgfnqjc5ew5rx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 25, 2021 at 12:29:01PM +0100, Andre Przywara wrote:
> On Mon, 24 May 2021 13:59:46 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> Hi Maxime,
>=20
> > On Wed, May 19, 2021 at 11:41:47AM +0100, Andre Przywara wrote:
> > > At least the Allwinner H616 SoC requires a weird quirk to make most
> > > USB PHYs work: Only port2 works out of the box, but all other ports
> > > need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
> > > RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
> > > the PMU PHY control register needs to be cleared. For this register to
> > > be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....
> > >=20
> > > Instead of disguising this as some generic feature, do exactly that
> > > in our PHY init:
> > > If the quirk bit is set, and we initialise a PHY other than PHY2, ung=
ate
> > > this one special clock, and clear the SIDDQ bit. We can pull in the
> > > other required clocks via the DT.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
> >=20
> > What is this SIDDQ bit doing exactly?
>=20
> I probably know as much as you do, but as Jernej pointed out, in some
> Rockchip code it's indeed documented as some analogue PHY supply switch:
> ($ git grep -i siddq drivers/phy/rockchip)
>=20
> In fact we had this pin/bit for ages, it was just hidden as BIT(1) in
> our infamous PMU_UNK1 register. Patch 10/17 drags that into the light.

Ok

> > I guess we could also expose this using a power-domain if it's relevant?
>=20
> Mmmh, interesting idea. So are you thinking about registering a genpd
> provider in sun4i_usb_phy_probe(), then having a power-domains property
> in the ehci/ohci nodes, pointing to the PHY node? And if yes, should
> the provider be a subnode of the USB PHY node, with a separate
> compatible? That sounds a bit more involved, but would have the
> advantage of allowing us to specify the resets and clocks from PHY2
> there, and would look a bit cleaner than hacking them into the
> other EHCI/OHCI nodes.

I'm not sure we need a separate device node, we could just register the
phy driver as a genpd provider, and then with an arg (so with
of_genpd_add_provider_onecell?) the index of the USB controller we want
to power up.

> I would not touch the existing SoCs (even though it seems to apply to
> them as well, just not in the exact same way), but I can give it a
> try for the H616. It seems like the other SIDDQ bits (in the other
> PHYs) are still needed for operation, but the PD provide could actually
> take care of this as well.
>=20
> Does that make sense or is this a bit over the top for just clearing an
> extra bit?

Using what I described above should be fairly simple, so if we can fit
in an available and relevant abstraction, yeah, I guess :)

Maxime

--y2gxgfnqjc5ew5rx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYL4drwAKCRDj7w1vZxhR
xd7TAQDncN/zcz+Z9eSgAJaMRWNdzFFjpQWl9G5zj8Ywa1FdIAEAqsVgmYFPss9l
yFRreCSeCDL8U8Q4q9q5CcNgKG6geQ0=
=WN4y
-----END PGP SIGNATURE-----

--y2gxgfnqjc5ew5rx--
