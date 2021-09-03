Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA708400183
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349248AbhICOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:51:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39497 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233218AbhICOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:51:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id E71F2580ACC;
        Fri,  3 Sep 2021 10:50:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 03 Sep 2021 10:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1+UNQ4mZYAX+yX8v1shjgWGw45M
        YrAYp1gT+fM1QCoA=; b=rbAtD4PN386W+BxKH5SsXETJ8QBRSvDEB/etHH6iVsH
        rho+11BM8EWl2GPPyZK37ZBlo3ggqWddwcIVWNb8dIZ3yvDK8jqjqH4pZRbdZDfH
        P6wWHVADgQfiJtfB7Pmd6DFMTViWHtzox3yGr3i+eKXAoFHDlYp0nRqgBOEOYrn+
        DG7bBFY2Kes7PGLKh/amjbpYSdVJ3/Yr4yGglaTgQwBND1EA+Y8yKbglnelM4BRr
        yRYl6hj51WOhUkT4CMBn2OSoi/yHXdcLNXzLTS8MnSxXY6Mrv4p7ZyuzWJ1wpmYu
        AKo/vSy5CXf5mczam8ZDyXLpn9m34vBp6h1OM4z24Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1+UNQ4
        mZYAX+yX8v1shjgWGw45MYrAYp1gT+fM1QCoA=; b=slWUYSruonY0xKUWmiFC1E
        SD5CqLQsNw2WabtJxTif87cYvsQ/t51pSazn2rgRlj7xOGQOMHVmUZ+NV3FQI5YQ
        HMjTkG9LkuKo2+wZP+BifP5J4T+1KU7sLfLO2xHs+D7CedujIdeb+rHSyqnxiDD5
        obAq9f+Q7UmnT0waXDCNWbgR0KgzgendP17NwrEO66nTMkrJOBbOxrWQq0bC9Tbg
        O75IrnKe0KJCAuHk6HW2JyVKvO/qkpjplTUYoe35ydlSmu3CzXI7iSU8CAZL3YOn
        tB6Tad7auHJEqBd2Bz+CIWhF7EwZAhVsUoTehhbDIZsaxLYrcwCabTlvZRsUjliw
        ==
X-ME-Sender: <xms:KDYyYaVKxtyb8hnZ0_lt7BZbvnYomSOefq7Si3XoMYpyTZbpz8dU4w>
    <xme:KDYyYWkikFWUmpGZLs3cQlPw3mC6fhddeHby1twuVmEgsdkerzS1dq1UNfJi1x6x0
    t51C6uggsj0mwqHwno>
X-ME-Received: <xmr:KDYyYeZUdatPSKibpZM5xCukzFKPoru4w7nu8Iq15t3Sc7VClFMUp9A1dxcbMLNc2X5uofOnIh05aBaGe_B7erk5AhN_yO4BP67C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KDYyYRU2J2jDsxSAoyA_Sf2otmPC8gI7fEB9yNyR96HNkTur2iunDg>
    <xmx:KDYyYUmp6OD92bU5qZ3jdyMquwx9C_2ztnEJKLi67fq30JMQiEQEQA>
    <xmx:KDYyYWdGWqmHhFTgUR_DeV-fzE0BmxGXU-On6_mxlrTO_SLTZLkojQ>
    <xmx:KTYyYRgG-j5j256aYGyC2WX_i5q14c2TtQgToGhC1O2VzwPubLSiBg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 10:50:15 -0400 (EDT)
Date:   Fri, 3 Sep 2021 16:50:13 +0200
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
Message-ID: <20210903145013.hn6dv7lfyvfys374@gilmour>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aqyjfro3lmncra3z"
Content-Disposition: inline
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqyjfro3lmncra3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 01, 2021 at 12:39:44AM -0500, Samuel Holland wrote:
> This patch series adds a CCU driver for the RTC in the H616 and R329.
> The extra patches at the end of this series show how it would be
> explanded to additional hardware variants.
>=20
> The driver is intended to support the existing binding used for the H6,
> but also an updated binding which includes all RTC input clocks. I do
> not know how to best represent that binding -- that is a major reason
> why this series is an RFC.
>=20
> A future patch series could add functionality to the driver to manage
> IOSC calibration at boot and during suspend/resume.
>=20
> It may be possible to support all of these hardware variants in the
> existing RTC clock driver and avoid some duplicate code, but I'm
> concerned about the complexity there, without any of the CCU
> abstraction.
>=20
> This series is currently based on top of the other series I just sent
> (clk: sunxi-ng: Lifetime fixes and module support), but I can rebase it
> elsewhere.

I'm generally ok with this, it makes sense to move it to sunxi-ng,
especially with that other series of yours.

My main concern about this is the split driver approach. We used to have
that before in the RTC too, but it was mostly due to the early clock
requirements. With your previous work, that requirement is not there
anymore and we can just register it as a device just like the other
clock providers.

And since we can register all those clocks at device probe time, we
don't really need to split the driver in two (and especially in two
different places). The only obstacle to this after your previous series
is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
functions public, but that can easily be fixed by moving their
definition to include/linux/clk/sunxi-ng.h

Maxime

--aqyjfro3lmncra3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTI2JQAKCRDj7w1vZxhR
xULeAP9F874xM3NzdYuwFLC9z8BzcFNMMzlOjOqwTFV7P7pHxAD/Vzu6odW0IVrM
Ulo17sA/rKg+2hzkHxw6WkxA9mXhNgs=
=TM12
-----END PGP SIGNATURE-----

--aqyjfro3lmncra3z--
