Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735443F792C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhHYPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:38:27 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52353 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233573AbhHYPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:38:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id CD8E9581083;
        Wed, 25 Aug 2021 11:37:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 25 Aug 2021 11:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/0eVR1LO8zbGReZXGH8OHCw0mxS
        kJRrqtSARXT+ndjE=; b=jOJoLOZJ7qqIkWp6K7FpTOChGd2qZmIRXLmSWjlJqRO
        dQblvhua/6eE+Jt9fE8sbongC2crCLUSrfuLXEB24ESruSTwCM6CkhnUwcqxFNbY
        uLP9YHVAyfzCcWG+EIQhcp4XXa+lSkJJKk4rjvtDFC9tW1sGxP547FTA3wqVH3oZ
        1G2tZSQ9oJPKob+ToTi4396mjeDSANBauZTG3jeP5W/cn+S9jH8E1UOCFz8dxq7w
        TJNjnyrayo3vrTs2Bvik7r/XDcTHOEQSCPb0GLhJlqE/X2fiuBeTRIO/dnbGMW1P
        jLvoagU4A2J7qAWmzRahj4zGv1aCzrMIijvELcGYBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/0eVR1
        LO8zbGReZXGH8OHCw0mxSkJRrqtSARXT+ndjE=; b=ChzAkc6XRxFFWDxmLe9OTf
        nhPLQSPOH9FW3yTzhJFXc3LYrqPB6yuDnV+al0sLOpcSX92N9q2oGnlw1AqpeKHn
        arPkznBwpy9V2HgIYM1ZZFRFcpukVoEXEv4bHZbFglsX4UquxVwhEfuZWBPjIvF/
        90eCztKUJjttdPPh7slJPAr3JT+L3543JmGeCrezchXTnQsg4B07Nd/45Sw+SHo4
        QCIfzLIWlRg99+seytJOe1aEpBtF+krEw0WAK8OdqVsAOG/sfLTu+7odouUQeoVl
        pUOHlb2+WsK15GyK0BwWS9ad6dmV+IE8arI3ZmpVyXbX8jwOPjG3ncQEfIBxjv8g
        ==
X-ME-Sender: <xms:wGMmYaOx6PU9g5zpPTMk0xavlo2KZrCYc7MjBG-E5dxsZenG3J4LMg>
    <xme:wGMmYY8w5ieXwOZSGWLwYLWqgEQykpIc1HJWdb5BlG_7wtsRlz2zYQHeJUpMs6zpT
    dzIoeNoIqfgOx-TX0Y>
X-ME-Received: <xmr:wGMmYRR_14ki0BgOD3QDXfE-sTab2EUT9bmzCk_R66UtJpPeiPeVCnH2fmsj4zyXpVd6CAhtkBiFzl_Q9IqDBnsOV4fp8AOip9wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wGMmYat_QBC7cfDUTgFkenPs_zYq0rJu85JLMSP_htH1Xjgah0MHSg>
    <xmx:wGMmYSfCERYHwBrYVDj_5JPoCbF_WOJgINH0pXCIfNofHeBo6WKN8w>
    <xmx:wGMmYe1Q2ahKsgSOwaiB-6YhJC6UqRTz1SGN3NJ3SgfJEWOcFVL69w>
    <xmx:w2MmYe14yVuP9zsqrKPxmCVDC-XVE0jny2BzZCLuShtq3cHkrCbaiA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 11:37:36 -0400 (EDT)
Date:   Wed, 25 Aug 2021 17:37:34 +0200
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
Message-ID: <20210825153734.3cwlufietc63ma3m@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <5432230.1UTMcGJKg4@jernej-laptop>
 <20210825145027.ixc7wnh3x5w6wzny@gilmour>
 <3221818.pD4rYpbbZ1@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujvj4sh6srxe5rru"
Content-Disposition: inline
In-Reply-To: <3221818.pD4rYpbbZ1@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ujvj4sh6srxe5rru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 05:03:30PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 25. avgust 2021 ob 16:50:27 CEST je Maxime Ripard napisal(a):
> > Hi,
> >=20
> > On Fri, Aug 20, 2021 at 06:34:38AM +0200, Jernej =C5=A0krabec wrote:
> > > > > +static void __init sun50i_r329_r_ccu_setup(struct device_node *n=
ode)
> > > > > +{
> > > > > +	void __iomem *reg;
> > > > > +	u32 val;
> > > > > +	int i;
> > > > > +
> > > > > +	reg =3D of_io_request_and_map(node, 0, of_node_full_name(node));
> > > > > +	if (IS_ERR(reg)) {
> > > > > +		pr_err("%pOF: Could not map clock registers\n", node);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/* Enable the lock bits and the output enable bits on all PLLs =
*/
> > > > > +	for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > > > > +		val =3D readl(reg + pll_regs[i]);
> > > > > +		val |=3D BIT(29) | BIT(27);
> > > > > +		writel(val, reg + pll_regs[i]);
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Force the I/O dividers of PLL-AUDIO1 to reset default value
> > > > > +	 *
> > > > > +	 * See the comment before pll-audio1 definition for the reason.
> > > > > +	 */
> > > > > +
> > > > > +	val =3D readl(reg + SUN50I_R329_PLL_AUDIO1_REG);
> > > > > +	val &=3D ~BIT(1);
> > > > > +	val |=3D BIT(0);
> > > > > +	writel(val, reg + SUN50I_R329_PLL_AUDIO1_REG);
> > > > > +
> > > > > +	i =3D sunxi_ccu_probe(node, reg, &sun50i_r329_r_ccu_desc);
> > > > > +	if (i)
> > > > > +		pr_err("%pOF: probing clocks fails: %d\n", node, i);
> > > > > +}
> > > > > +
> > > > > +CLK_OF_DECLARE(sun50i_r329_r_ccu, "allwinner,sun50i-r329-r-ccu",
> > > > > +	       sun50i_r329_r_ccu_setup);
> > > >=20
> > > > Please make this a platform driver. There is no particular reason w=
hy it
> > > > needs to be an early OF clock provider.
> > >=20
> > > Why? It's good to have it as early clock provider. It has no dependen=
cies
> > > and other drivers that depends on it, like IR, can be deferred, if th=
is
> > > is loaded later.
> >=20
> > No, Samuel is right, we should make them regular drivers as much as we
> > can.
> >=20
> > The reason we had CLK_OF_DECLARE in the first place is that timers
> > usually have a parent clock, and you need the timers before the device
> > model is set up.
> >=20
> > Fortunately for us, since the A20, the architected timers don't require
> > a parent clock from us, and we can thus boot up fine.
>=20
> There are other timers. A lot of SoCs, newer than A20 (like H6), have Hig=
h=20
> Speed Timer, which requires parent clock to be enabled. We just choose no=
t to=20
> add node for it to DT, even if it's there and driver already exists.

Yeah, I know. The thing is, we just need one timer in order to boot to
the point where the DM is there. We can totally have a timer driver
probing just like any other driver, through the DM, later on.

Maxime

--ujvj4sh6srxe5rru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYSZjvgAKCRDj7w1vZxhR
xX+TAP0WGHG2s4yHamp+fjkYZIyN3blRmTbmA8bbbYAZDDpWPAD8D3b0gM0/5VYF
c22yVcU2bytiqTiat5LMPSwOhQzTCQo=
=zJhK
-----END PGP SIGNATURE-----

--ujvj4sh6srxe5rru--
