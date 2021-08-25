Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337B23F77BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhHYOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:51:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47657 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhHYOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:51:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA6975810A7;
        Wed, 25 Aug 2021 10:50:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Aug 2021 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=j25qG8ukGnHu+GbG45H46dChMEe
        xlabwoRMynBr2xQU=; b=wVFPjE3MTevKsL7NaaHJE9zSwMBfgYJGOnMnoreO3AX
        vk1O/cfAFCBEQJW2L9B8JoYEWYLQJdAI5KIn4Wg4+x4Y6VlmlZ1BG6ImYNx542zv
        G9T3VKCY9v0TxTqVkaKuI9D6W5CzAES/W6iKJXWy+ui7nmoZ609OH5ERQx1YR8ur
        IPK0UfMgEY7knOBO2qJFN+mEVcht6sgiSWRUXEqMbskGagO0qAWnIzACvD3rdzwg
        hplhXB+FqckBRoNI7rpurBpEmzK2IrbzRdxy6UVNdeO+AQJSrqU03pZ2i1Ng969p
        sXX5jhsWfUrDhqt+EuPTH+Dab1Oom9Axy7O7U1ap0pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=j25qG8
        ukGnHu+GbG45H46dChMEexlabwoRMynBr2xQU=; b=R7bAv9tR+HlbzPrN/rR+Nk
        o3C5o2WqYYqhlDyY0BUR3xrz6jhciIJtYchoOWaGZISQJV9tT4QuDUg1q5M9tMVK
        kE9+M2AkV0jm96CSBGUbRXkT2bzpY5A4IXwZBymVzbzFYdihxl3D1mXgRgQbU6P9
        C5j+yrHrEmdyME9iGbZWXAVvNpFdmanHTeyJyQwFirpHBic8r1/9wNlRpl0xdCxR
        MUYEndKm8tEeJJpwiTJ90h3zj+wm6Hc1wdKKjM9vnG9MMHVI1+OPS4vHuLS4t4MP
        BejePOQa9MjVVxP9ClMomsjXLLKU49bts241TRraMaauZvT/6Qu8nOB4j36+bgfg
        ==
X-ME-Sender: <xms:tVgmYdVgF9flf2GSdFBmL7HcJupf808NuWROnLgOJ1wC7TcMUbkiSw>
    <xme:tVgmYdm0Rdipl-dI3gZWe3-KmIp00lMpX4lb1vfiKkgjldDhYfH39AEiNs6CwWC7H
    Dlyt89bpJ93xIpK-n4>
X-ME-Received: <xmr:tVgmYZZOlZNlU_aP1H4ifQDVubyL06XATXfR5GbO0CMUin_TZoHFzI70QKCCogLzTgD0TLQhXewSQbXB2KysJLceCtiXKCyvSybr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tVgmYQWmWMZ8XdEcYmO4Mb1LLHGBOQtGGUpVrfmZuJEkUK-X2ZYS5A>
    <xmx:tVgmYXnyxrdWekkYo6Y50byHM6awvwK4hsM1JVpD6BV9Z0rQpqm0nw>
    <xmx:tVgmYdePAPRyJRQLp4E4wnhL3Yts9Ci-RhXNvTnK8dCrovnH9_esPQ>
    <xmx:t1gmYVdGRgEdEgnktFIjj6c_5IXTieARkO9Y1WDKEmbzFNbYS9djug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 10:50:29 -0400 (EDT)
Date:   Wed, 25 Aug 2021 16:50:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] clk: sunxi=ng: add support for R329 R-CCU
Message-ID: <20210825145027.ixc7wnh3x5w6wzny@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-11-icenowy@sipeed.com>
 <99a74950-fdc0-ecfe-e5f0-ba4a7d8751f0@sholland.org>
 <5432230.1UTMcGJKg4@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l3qwbvgcz3gjr7tn"
Content-Disposition: inline
In-Reply-To: <5432230.1UTMcGJKg4@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l3qwbvgcz3gjr7tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 20, 2021 at 06:34:38AM +0200, Jernej =C5=A0krabec wrote:
> > > +static void __init sun50i_r329_r_ccu_setup(struct device_node *node)
> > > +{
> > > +	void __iomem *reg;
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	reg =3D of_io_request_and_map(node, 0, of_node_full_name(node));
> > > +	if (IS_ERR(reg)) {
> > > +		pr_err("%pOF: Could not map clock registers\n", node);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Enable the lock bits and the output enable bits on all PLLs */
> > > +	for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > > +		val =3D readl(reg + pll_regs[i]);
> > > +		val |=3D BIT(29) | BIT(27);
> > > +		writel(val, reg + pll_regs[i]);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Force the I/O dividers of PLL-AUDIO1 to reset default value
> > > +	 *
> > > +	 * See the comment before pll-audio1 definition for the reason.
> > > +	 */
> > > +
> > > +	val =3D readl(reg + SUN50I_R329_PLL_AUDIO1_REG);
> > > +	val &=3D ~BIT(1);
> > > +	val |=3D BIT(0);
> > > +	writel(val, reg + SUN50I_R329_PLL_AUDIO1_REG);
> > > +
> > > +	i =3D sunxi_ccu_probe(node, reg, &sun50i_r329_r_ccu_desc);
> > > +	if (i)
> > > +		pr_err("%pOF: probing clocks fails: %d\n", node, i);
> > > +}
> > > +
> > > +CLK_OF_DECLARE(sun50i_r329_r_ccu, "allwinner,sun50i-r329-r-ccu",
> > > +	       sun50i_r329_r_ccu_setup);
> >=20
> > Please make this a platform driver. There is no particular reason why it
> > needs to be an early OF clock provider.
>=20
> Why? It's good to have it as early clock provider. It has no dependencies=
 and=20
> other drivers that depends on it, like IR, can be deferred, if this is lo=
aded=20
> later.

No, Samuel is right, we should make them regular drivers as much as we
can.

The reason we had CLK_OF_DECLARE in the first place is that timers
usually have a parent clock, and you need the timers before the device
model is set up.

Fortunately for us, since the A20, the architected timers don't require
a parent clock from us, and we can thus boot up fine.

Since the dependencies are minimal, it should probe fairly early and
with the on-demand probing from the device links you might not even tell
the difference for most consumers.

Maxime

--l3qwbvgcz3gjr7tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYSZYswAKCRDj7w1vZxhR
xSPEAP9Zhi9W1anVqHAPOuCAL6FS67fx29ak4D6qwqqA9LiJzgEApDVyVFqkg5H3
IG8aBvBUnCeV6HIK+MZOyJENIasJwQM=
=NwLi
-----END PGP SIGNATURE-----

--l3qwbvgcz3gjr7tn--
