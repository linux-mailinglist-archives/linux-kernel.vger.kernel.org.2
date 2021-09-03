Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9233FFCEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348611AbhICJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:20:14 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34407 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348667AbhICJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:20:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 382A232009A4;
        Fri,  3 Sep 2021 05:19:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 05:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jVxn/4v9E3VEwSOtkkpFTKH8mhl
        2X8WtKi4ZUbok6o4=; b=Lc5ABoi1KOKOzQ86OXZCi4odRLWCR7On5ZHyFA2EGq4
        tiKX3Frze7DWSztmOOzWTVPGgiwwpTsQhAlyDvcOeFmXa98Kowau61ZTFqR3Uhqq
        swnu0RQNzk3R+JXNIJkTXUdXcYqj5U7RdhmvR6zgbUKZ7EySjG1Dw6TigkzXFF2L
        c6ZRzwFjv7cegegNLiyY/5zXSo93BVGVa1Q2+RXrkWedW5qyv2aXRR5YdhpAM97S
        GdK7LONZXuS0o7xCAh9NyteEcg6+7i3ii2zY3U9iCyvfLvLdl4enQoLCRov9dFe3
        xWlS9cPJFzNqvtv8GF8xDBAvKXnYz81+oyMIb46J9yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jVxn/4
        v9E3VEwSOtkkpFTKH8mhl2X8WtKi4ZUbok6o4=; b=RN8q7uo+t3Oojk+GPktStl
        T+QPdm+Ef5i5Npr72t4/3onhc5ePxpfXX4rG18AAVKjfFp9vwSOap8phC213BUiO
        XwUX63KjyMp19pHeH9sL8VzbwKEfERfemswRkp/qvAGBYGD+xbhsUo5rJVYEnyFJ
        5otFmYeVoDI/rv4768gTF8bQttxFyXNSSQ6Kkw2eKyDv/gELhuOlrvW5EbQ0X21g
        7ZqiIKqNVDQeCGgsLnPP0YdfgO6dcn9ZYL3m4vgcA1phBJ4I9IYvcbfaEwAn4lUX
        leJC6P+FOBAOAi6rk/VwA1v5FPvrxP7b0J8QsiCZcky9Fveh8l5JaQf9X8W8GvEA
        ==
X-ME-Sender: <xms:jugxYRMwfN5bStI9Q4nsWPABkuMxzA8gYj2yRFiInVZxedFveQFHEQ>
    <xme:jugxYT-mi2FhAJ_3S9z5ysDl4RB_oDmVjDELYFyhMq7JeQ59s-gxCJPMHoNEx5T__
    YNYDVNDti8cAb806bE>
X-ME-Received: <xmr:jugxYQS7Rtv9B9rG9L0xDDeFwXtEDaR5V8EciSS_30wb90rgKjasejf_x8ctXnE-k1Zluc1zTQqeQFSdOR-ttWdC-_EwsiR1X1G5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jugxYduktg0uIpE36nFYOWWLsck6pcGWZLEKdVOysehG8g7Km9_ZUA>
    <xmx:jugxYZe3CA-WaLjCPBSRLPdGahfJnyMJKnEudhqK92OEz33F1eKbTg>
    <xmx:jugxYZ1xwu2tU5iUuZxlrQxxU98SpH66zzECl0W_XYoFnUbEtMKMyw>
    <xmx:j-gxYTs-t8K-4hassUZ4KW7tEsS5lOC2av4UDHiG4WDPp0tjbRSuNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 05:19:10 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:19:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] clk: sunxi-ng: Convert early providers to platform
 drivers
Message-ID: <20210903091909.dbibqmw5dx3l5xzu@gilmour>
References: <20210901050526.45673-1-samuel@sholland.org>
 <20210901050526.45673-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbabr2aynocczr7s"
Content-Disposition: inline
In-Reply-To: <20210901050526.45673-8-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbabr2aynocczr7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 01, 2021 at 12:05:25AM -0500, Samuel Holland wrote:
> The PRCM CCU drivers depend on clocks provided by other CCU drivers. For
> example, the sun8i-r-ccu driver uses the "pll-periph" clock provided by
> the SoC's main CCU.
>=20
> However, sun8i-r-ccu is an early OF clock provider, and many of the
> main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means that
> the consumer clocks will be orphaned until the supplier driver is bound.
> This can be avoided by converting the remaining CCUs to use platform
> drivers. Then fw_devlink will ensure the drivers are bound in the
> optimal order.
>=20
> The sun5i CCU is the only one which actually needs to be an early clock
> provider, because it provides the clock for the system timer. That one
> is left alone.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

The patch looks great to me, thanks for doing this work

I'm surprised you were able to convert the A10 and F1C100S as well,
since they don't have the arch timer.

It seems we only use the fixed 24MHz clock on the A10 for the timer and
the interrupt controller doesn't have a parent clock, so it works. The
A10 timer can be fed with one PLL though and would require that
dependency, but I guess no one ever cared. It's easy enough to revert if
someone complains anyway.

Maxime

--hbabr2aynocczr7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHojQAKCRDj7w1vZxhR
xY24AP9QkxtXTpu2pkuoyr5bNFaWFTYVALN9LHVRfNLojuWD9wEAgXLRbTNdtw7/
kgv7agI8PXtUG/dYtIOGlZoM4OfgDgc=
=UHC4
-----END PGP SIGNATURE-----

--hbabr2aynocczr7s--
