Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341B331285
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:48:38 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40179 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhCHPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:48:12 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB1B75C0065;
        Mon,  8 Mar 2021 10:48:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Mar 2021 10:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=RnEavwGRxlLSFmOVcdiWgzlkElE
        f0ZIkYfj/r5zG3Wo=; b=XdreZdBc//ytwXMmasq02zF0VA4DGLNLJb9hV0HRyXd
        gG77hNpUCuBAkbaxuXNmG+/L6Qeh6eM/AjrUa07DhJ3ELpTMtTzNVNr8+LrUW7+E
        Q3IQdFvDs+eCo9TMzTHaW1SZcfeO4HPDO5uB/omdKJC8Y9A/FxacmSTT+D47FdOa
        TT3oxsJUwzPnmWEoTLrJ8q1G8/us3jp4RNhFG8r5gElfZkzveVY6dhhz3jlsLpMf
        ensOhBaueDaWzV4VZhYOcNiqiqG+uf1DhcYhyP2j2W3HfQW897bjB5eeErrpcaQA
        JHktSOUjle8WIHikb0HXYW7aCbffAdMAA53BhSB9RKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RnEavw
        GRxlLSFmOVcdiWgzlkElEf0ZIkYfj/r5zG3Wo=; b=gRYJAiztJyXDzLiWkKvVjc
        0zkkeYDEyvZUZgvl4SeeZbblynI829UL2DnKAPJ2Z7uzfcXXSahlKXuB+xJzYR1n
        vV3VBsC675yXt6hR7uK3iwNi756bNl4dRIQe2pmWj9p5oKJZMzR4B6ShSU6TKqT+
        VyIAQia1RNILgnsAewRG+zprTGNjDlhnxjW0FP98vpkKSP7M9dedstvMw1/X4fJM
        fCkQhfyb5KrNS97bLdofPkaRbkbikoWSmJWa2xgVJZLpLWZXnKaAUkwGrfzIfjXg
        e8BqCfOz3QfNkP4JP2ZAHAcW3rgBP5LD+MR+mfKq2qCoT4Us4CrAmu/wJmcDPfVA
        ==
X-ME-Sender: <xms:OEdGYI4xOgWHKxF8oYJIWM_5kPKMUDd-ReuABU6S25G-HWXC_lozTw>
    <xme:OEdGYKVj1ma6a787As77OmrSV8oyxCTDD6C7vSFLuMCSIuQjjbsZpLtdceaW7R5kg
    ANwJQGc072e7DIY18g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:OUdGYIKn8SFj0xhyGox_ApzXUAtzuSqHkfzpT8NwAfbMQvIBVQI0Xg>
    <xmx:OUdGYEsFBzAaXp2wpuO6H5LhGdwY3M0YVjZ4DAcTCEgWPWR-zedTMw>
    <xmx:OUdGYNLbiCCIrQriLzJV4byrEaeLVUDLjIzubQNhB9xeNAerb_zj_g>
    <xmx:O0dGYIhyqHhqOhj3RZwG4HS5hXiBCcxo_q5bQuMtafdbxTbLViSReA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C051F1080067;
        Mon,  8 Mar 2021 10:48:08 -0500 (EST)
Date:   Mon, 8 Mar 2021 16:48:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/1] clk: sunxi: Demote non-conformant kernel-doc headers
Message-ID: <20210308154807.j6llubzzbcxd6b55@gilmour>
References: <20210303142430.3168703-1-lee.jones@linaro.org>
 <161481702291.1478170.841537456605456317@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdun35vxb6d37qvr"
Content-Disposition: inline
In-Reply-To: <161481702291.1478170.841537456605456317@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdun35vxb6d37qvr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 04:17:02PM -0800, Stephen Boyd wrote:
> Quoting Lee Jones (2021-03-03 06:24:30)
> > Headers must describe their parameters.
> >=20
> > Fixes the following W=3D1 kernel build warning(s):
> >=20
> >  drivers/clk/sunxi/clk-sun9i-core.c:27: warning: Function parameter or =
member 'req' not described in 'sun9i_a80_get_pll4_factors'
> >  drivers/clk/sunxi/clk-sun9i-core.c:100: warning: Function parameter or=
 member 'req' not described in 'sun9i_a80_get_gt_factors'
> >  drivers/clk/sunxi/clk-sun9i-core.c:155: warning: Function parameter or=
 member 'req' not described in 'sun9i_a80_get_ahb_factors'
> >  drivers/clk/sunxi/clk-sun9i-core.c:235: warning: Function parameter or=
 member 'req' not described in 'sun9i_a80_get_apb1_factors'
> >  drivers/clk/sunxi/clk-usb.c:22: warning: cannot understand function pr=
ototype: 'struct usb_reset_data '
> >  drivers/clk/sunxi/clk-sun6i-ar100.c:26: warning: Function parameter or=
 member 'req' not described in 'sun6i_get_ar100_factors'
> >=20
> > Cc: "Emilio L=F3pez" <emilio@elopez.com.ar>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Applied

Maxime

--cdun35vxb6d37qvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEZHNwAKCRDj7w1vZxhR
xU79AQCzPtUTayiFwjMgMYuzW273X0qfnDb37uGFa9+2V+439gEAiFJYrZRzfL6R
1WCIHHBYcwz2hpCP6tXrurZuB9tEIwk=
=ZcjV
-----END PGP SIGNATURE-----

--cdun35vxb6d37qvr--
