Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51672439AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhJYP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:56:59 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43153 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233339AbhJYP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:56:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id F133D5806DB;
        Mon, 25 Oct 2021 11:54:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Oct 2021 11:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=x9hX7RM8sQwYrR0HEhgf0Gl/oxT
        qM4CCrz4sBwH4ayI=; b=VUU06bdAamyAAcLyXQJ9NO0kd2qz+5w1GImA6tjsA8y
        hjxUpJDWL3vRgsFt2Q/bm3Br7WL4ehlPhORajkqkjyGCzviyUn1IcCpparOJHt9X
        pEPEhrcA+tYjeKqrCQqVG019jidjHckLeT1mFxF1D4UjCSEaWpLpR/PYGZPo3+Qe
        QREZnSUDhA6AgtxP4/cJR9o/+5hSXsGoGFt7FPt1areNO0y8G1e85nJVImzUS4Dl
        /SeOyRDBSqW46+rDMRk9K0AuuMFq6KOWRE4srr786p7PPtNldIZTV6Js8+uXTWCf
        5lsuCMhi0XDj/SDFPso22WCkhoXm6ZiTFS0QmyCZyrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x9hX7R
        M8sQwYrR0HEhgf0Gl/oxTqM4CCrz4sBwH4ayI=; b=NdzkdO8kg/DmBnLvYZLUU/
        uGX3maxPueEQUxKyQ3GLrL5+EQ9e/pbvsOheK0gKppJ7uj32KklNHGoDVWGW22iv
        j0/KU4NB0Bgd9rheUHAKzYr3uJDdBXg6qOzPuFX14sUZqRZp90HGU1m2JDJY1ntp
        5McTyS/HYDOCmKJohN+QBz7qtEpO0uB8kiL6DEshGq3ANrDQuVxP83hihdbqEUtX
        AOGtOMNXAwKmyJiPYXFimrNJFTM1dD5Zg7mxrGxPjuvUP/eMCLFBFR4R/lZqIofJ
        prK6a3qZZwJDzW59lXzfDI63efvMlHsgFnBn7x8VCMCSWYMe0eJ58qkMSYSywwrg
        ==
X-ME-Sender: <xms:N9N2YX-4AA7IhWpNSrsQWqxEuj53A4IeR-VypczGM9hbW76ejTbJXQ>
    <xme:N9N2YTvEGhuPeOqei6tWqO36SbdCRRMVtiMoHyfiU3TYWLS5K5tRH7KDElp9I8H6_
    zJXZkZDhBiPgwbHRMY>
X-ME-Received: <xmr:N9N2YVDndp7EkZsp9tE4-f7vexAA1aqa4_uCqwWxXLB4Fqd2kGKKc-_Ba5JjY-GNPBfySHluKisHpR5GhbLW1OwKh0dfgEOGhKvdbh5t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:N9N2YTfJFS9YrKJHfUcQKmrfhTPDLKxE5oeEXD-LH87ALaEvhQE4_w>
    <xmx:N9N2YcPaBQwt25zWrj6q8zyJE8blYmC1xlPQIlaND9Lzi90_Bj_xGA>
    <xmx:N9N2YVnzs6fB0HInHXVH9Gt4mESja-nf_tWy5DVHKBQEsXrum0AhAg>
    <xmx:N9N2YbqlGwrCI6kU6coaFSNZ6iv6K1N3bq1v8mPjni5MaJO_R0ucIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 11:54:31 -0400 (EDT)
Date:   Mon, 25 Oct 2021 17:54:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <20211025155429.yac6ig6pmdcg424i@gilmour>
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210903145013.hn6dv7lfyvfys374@gilmour>
 <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
 <20210909084538.jeqltc7b3rtqvu4h@gilmour>
 <c910527d-e2d7-31ca-efd9-1915db62d85d@sholland.org>
 <20210928090625.rq3atiaejaq5kcbx@gilmour>
 <bc338f11-9867-2394-ceaa-99314ff67660@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b2ksp7hns5x2e4cw"
Content-Disposition: inline
In-Reply-To: <bc338f11-9867-2394-ceaa-99314ff67660@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2ksp7hns5x2e4cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 10:54:26PM -0500, Samuel Holland wrote:
> Hi Maxime,
>=20
> Thanks for your reply.
>=20
> On 9/28/21 4:06 AM, Maxime Ripard wrote:
> > On Tue, Sep 28, 2021 at 02:46:39AM -0500, Samuel Holland wrote:
> >> On 9/9/21 3:45 AM, Maxime Ripard wrote:
> >>> On Fri, Sep 03, 2021 at 10:21:13AM -0500, Samuel Holland wrote:
> >>>> On 9/3/21 9:50 AM, Maxime Ripard wrote:
> >>>>> And since we can register all those clocks at device probe time, we
> >>>>> don't really need to split the driver in two (and especially in two
> >>>>> different places). The only obstacle to this after your previous se=
ries
> >>>>> is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
> >>>>> functions public, but that can easily be fixed by moving their
> >>>>> definition to include/linux/clk/sunxi-ng.h
> >>>>
> >>>> Where are you thinking the clock definitions would go? We don't expo=
rt
> >>>> any of those structures (ccu_mux, ccu_common) or macros
> >>>> (SUNXI_CCU_GATE_DATA) in a public header either.
> >>>
> >>> Ah, right...
> >>>
> >>>> Would you want to export those? That seems like a lot of churn. Or w=
ould
> >>>> we put the CCU descriptions in drivers/clk/sunxi-ng and export a
> >>>> function that the RTC driver can call? (Or some other idea?)
> >>>
> >>> I guess we could export it. There's some fairly big headers in
> >>> include/linux/clk already (tegra and ti), it's not uAPI and we do have
> >>> reasons to do so, so I guess it's fine.
> >>>
> >>> I'd like to avoid having two drivers for the same device if possible,
> >>> especially in two separate places. This creates some confusion since =
the
> >>> general expectation is that there's only one driver per device. There=
's
> >>> also the fact that this could lead to subtle bugs since the probe ord=
er
> >>> is the link order (or module loading).
> >>
> >> I don't think there can be two "struct device"s for a single OF node.
> >=20
> > That's not what I meant, there's indeed a single of_node for a single
> > struct device. If we dig a bit into the core framework, the most likely
> > scenario is that we would register both the RTC and clock driver at
> > module_init, and with the device already created with its of_node set
> > during the initial DT parsing.
> >=20
> > We register our platform driver using module_platform_driver, which
> > expands to calling driver_register() at module_init(), setting the
> > driver bus to the platform_bus in the process (in
> > __platform_driver_register()).
> >=20
> > After some sanity check, driver_register() calls bus_add_driver(), which
> > will call driver_attach() if drivers_autoprobe is set (which is the
> > default, set into bus_register()).
> >=20
> > driver_attach() will, for each device on the platform bus, call
> > __driver_attach(). If there's a match between that device and our driver
> > (which is evaluated by platform_match() in our case), we'll call our
> > driver probe with that device through driver_probe_device(),
> > __driver_probe_device() and finally really_probe().
> >=20
> > However, at no point in time there's any check about whether that device
> > has already been bound to a driver, nor does it create a new device for
> > each driver.
>=20
> I would expect this to hit the:
>=20
> 	if (dev->driver)
> 		return -EBUSY;
>=20
> in __driver_probe_device(), or fail the "if (!dev->driver)" check in
> __driver_attach() for the async case, once the first driver is bound.

Hmmm, it might. I know we "leveraged" this some time ago for another
platform, but it might not be working anymore indeed.

> > So this means that, if you have two drivers that match the
> > same device (like our clock and RTC drivers), you'll have both probe
> > being called with the same device, and the probe order will be defined
> > by the link order. Worse, they would share the same driver_data, with
> > each driver not being aware of the other. This is incredibly fragile,
> > and hard to notice since it goes against the usual expectations.
> >=20
> >> So if the CCU part is in drivers/clk/sunxi-ng, the CCU "probe"
> >> function would have to be called from the RTC driver.
> >=20
> > No, it would be called by the core directly if there's a compatible to
> > match.
> >=20
> >> Since there has to be cooperation anyway, I don't think there would be
> >> any ordering problems.
> >=20
> > My initial point was that, with a direct function call, it's both
> > deterministic and obvious.
>=20
> I believe I did what you are suggesting for v2. From patch 7:
>=20
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -683,6 +684,10 @@ static int sun6i_rtc_probe(struct platform_device
> *pdev)
>  		chip->base =3D devm_platform_ioremap_resource(pdev, 0);
>  		if (IS_ERR(chip->base))
>  			return PTR_ERR(chip->base);
> +
> +		ret =3D sun6i_rtc_ccu_probe(&pdev->dev, chip->base);
> +		if (ret)
> +			return ret;
>  	}

Ah, sorry, I entirely missed it. Yes, that totally fine by me then. I'd
prefer to have the spinlock passed as an argument as well, but it can be
done in a follow-up patch.

>  	platform_set_drvdata(pdev, chip);
>=20
> >>> And synchronizing access to registers between those two drivers will =
be
> >>> hard, while we could just share the same spin lock between the RTC and
> >>> clock drivers if they are instanciated in the same place.
> >>
> >> While the RTC driver currently shares a spinlock between the clock part
> >> and the RTC part, there isn't actually any overlap in register usage
> >> between the two. So there doesn't need to be any synchronization.
> >=20
> > I know, but this was more of a social problem than a technical one. Each
> > contributor and reviewer in the future will have to know or remember
> > that it's there, and make sure that it's still the case after any change
> > they make or review.
> >=20
> > This is again a fairly fragile assumption.
>=20
> Yeah, I agree that having a lock that is only sometimes safe to use with
> certain registers is quite fragile.
>=20
> Would splitting the spinlock in rtc-sun6i.c into "losc_lock" (for the
> clock provider) and "alarm_lock" (for the RTC driver) make this
> distinction clear enough?
>=20
> Eventually, I want to split up the struct between the clock provider and
> RTC driver so it's clear which members belong to whom, and there's no
> ugly global pointer use. Maybe I should do this first?

Yeah, it sounds like a good plan

Thanks!
Maxime

--b2ksp7hns5x2e4cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYXbTNQAKCRDj7w1vZxhR
xZzvAP97myNfXuUhtnBUUGAL7em5FVCfP8xefmvk5wAGOQNkwwD+IOaCylf8Rk2y
idlAsL/6oi+inNEUnUDORvob8eEJ2gk=
=1LDy
-----END PGP SIGNATURE-----

--b2ksp7hns5x2e4cw--
