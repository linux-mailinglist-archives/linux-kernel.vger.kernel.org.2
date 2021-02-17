Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4031D7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBQLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:06:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55113 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231230AbhBQLEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:04:35 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6929F5C00D3;
        Wed, 17 Feb 2021 06:03:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 17 Feb 2021 06:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=RhWcT+wzUyCCkN6d1Yoz8PTsSVB
        hl4FHpU5J3vQcZDE=; b=H3dVaDibAMsKoUksJrYqWmyoE/KNQb0f/+IBdGlE/hZ
        n4W/BRi+spDr4LaggTNgzjTS6TxTdJcyM3PpcKyDD0nonZRbI8pyPNd+IMBOnXcl
        7oD4fB0bDhUkhR2M5qSeksR3ldlhufv79X57Xee5vO2jOyP8jF8pRAaxg9na/3Oi
        HvQM1yElBZWr6g613otX+rwlmSgGa6Nk0POUUOtKm5EQ0uC2MNzj3aN0M8XN8biM
        4G17NsBDk3mmOkLDfu7LNSvW8Mue6JZGh/XKQWBW2tAmXWSThAxWRce7lhsfrzmZ
        bqKjwWtQrwe1n/TT++coxv6LRjh6PZ06H4+SKhsvxqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RhWcT+
        wzUyCCkN6d1Yoz8PTsSVBhl4FHpU5J3vQcZDE=; b=cMrw4u+dIQ4Q8FsWi3IkRg
        K8Z+HQUvS0Y6vb30HIUV2FcVKgx26+Rx6Yu8pwaeITsHvH3cSg8dQhNWgj6wUJo3
        BcE7XfcpJ49jdYGoCMToJFGROFJowd475o597clroj0H6azkRV9QrbdO104xtXre
        zZWgS1ackAA2FuVpgATVQxS/Tst1z+a28GBIbWJULe10WkIPsFdW+wg4BU9aOVJC
        UjlV1sAPEGlXQ3rldWzgkIHt25Ea8t0pg1rCebI7h/s2MubcW2xnsdJ/3DelCXXn
        huBznNPBmqXP0RzVYv91qtyfovnzmPZfe8/LjGdN3/oxyr2jxb0erCKLvSSCG5Cw
        ==
X-ME-Sender: <xms:8_csYDjKWj8yvtqDXQ0_3j3h7xQ7egLpJaiZhKN0ycKAES3d3Ztx8A>
    <xme:8_csYP_qa-8NZNBnC1W2YJYYbO5VaI_Nu6whxL3oWZjexfWPC5dw-JEvZk2JDmybb
    lIGGbyJyfrKyk69bYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjedugddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8_csYP8dTUyJxSjW3uxv3vKY9In1dFN0vyL_ry0Sfer3-ZArs5QF1A>
    <xmx:8_csYIDMh1AT2d7witfNg_L6eE_VDidYd1tB355iTPmGGD1Qv2HjUg>
    <xmx:8_csYPwbjOBUe8L6JwovIPhC2HhWntcVSE65dLY-SOlCRMGCQ_gB4g>
    <xmx:9fcsYAPfbz1StMBWRvwmFuGfuHw2qnJsPJV2aq3X5FrzYadySEHe7w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AACE624005E;
        Wed, 17 Feb 2021 06:03:15 -0500 (EST)
Date:   Wed, 17 Feb 2021 12:03:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Marjan Pascolo <marjan.pascolo@trexom.it>
Cc:     wens@csie.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl/sunxi: adding input-debounce-ns property
Message-ID: <20210217110313.ly5ly5u5vyh2s7dh@gilmour>
References: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
 <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
 <20210114114219.faulkwww3dhdqwmc@gilmour>
 <c3bc06e3-4193-dc0b-b2b3-d54636481e28@trexom.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4d4ux434tr5bcsek"
Content-Disposition: inline
In-Reply-To: <c3bc06e3-4193-dc0b-b2b3-d54636481e28@trexom.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4d4ux434tr5bcsek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 10, 2021 at 05:22:37PM +0100, Marjan Pascolo wrote:
> On Allwinner SoC interrupt debounce can be controlled by two oscillator
> (32KHz and 24MHz) and a prescale divider.
> Oscillator and prescale divider are set through
> device tree property "input-debounce" which have 1uS accuracy.
> For acheive nS precision a new device tree poperty is made
> named "input-debounce-ns".
> "input-debounce-ns" is checked only if "input-debounce"
> property is not defined.
>=20
> Suggested-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Marjan Pascolo <marjan.pascolo@trexom.it>
> ---
> ---
> =A0.../pinctrl/allwinner,sun4i-a10-pinctrl.yaml=A0 |=A0 9 +++++++
> =A0drivers/pinctrl/sunxi/pinctrl-sunxi.c=A0=A0=A0=A0=A0=A0=A0=A0 | 25 +++=
+++++++++++++---
> =A02 files changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.y=
aml
> b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.y=
aml
> index 5240487dfe50..346776de3a44 100644
> ---
> a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.y=
aml
> +++
> b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.y=
aml
> @@ -93,6 +93,15 @@ properties:
> =A0=A0=A0=A0 minItems: 1
> =A0=A0=A0=A0 maxItems: 5
>=20
> +=A0 input-debounce-ns:
> +=A0=A0=A0 description:
> +=A0=A0=A0=A0=A0 Debouncing periods in nanoseconds, one period per interr=
upt
> +=A0=A0=A0=A0=A0 bank found in the controller.
> +=A0=A0=A0=A0=A0 Only checked if input-debounce is not present
> +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32-array
> +=A0=A0=A0 minItems: 1
> +=A0=A0=A0 maxItems: 5
> +

This should be a separate patch, with the DT maintainers in Cc.=20

You should enforce that the properties are mutually exclusive through
the schema too

> =A0patternProperties:
> =A0=A0 # It's pretty scary, but the basic idea is that:
> =A0=A0 #=A0=A0 - One node name can start with either s- or r- for PRCM no=
des,
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index dc8d39ae045b..869b6d5743ba 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -1335,14 +1335,31 @@ static int sunxi_pinctrl_setup_debounce(struct
> sunxi_pinctrl *pctl,
> =A0=A0=A0=A0 struct clk *hosc, *losc;
> =A0=A0=A0=A0 u8 div, src;
> =A0=A0=A0=A0 int i, ret;
> +=A0=A0=A0 /* Keeping for loop below clean */
> +=A0=A0=A0 const char* debounce_prop_name;
> +=A0=A0=A0 unsigned long debounce_dividend;
>=20
> =A0=A0=A0=A0 /* Deal with old DTs that didn't have the oscillators */
> =A0=A0=A0=A0 if (of_clk_get_parent_count(node) !=3D 3)
> =A0=A0=A0=A0 =A0=A0=A0 return 0;
>=20
> +=A0=A0=A0 /*
> +=A0=A0=A0 =A0* Distinguish between simple input-debounce
> +=A0=A0=A0 =A0* and new input-debounce-ns
> +=A0=A0=A0 =A0*/
> +

I'm not sure that comment should stay, the code is obvious enough

> =A0=A0=A0=A0 /* If we don't have any setup, bail out */
> -=A0=A0=A0 if (!of_find_property(node, "input-debounce", NULL))
> -=A0=A0=A0 =A0=A0=A0 return 0;
> +=A0=A0=A0 if (!of_find_property(node, "input-debounce", NULL)) {
> +=A0=A0=A0 =A0=A0=A0 if(!of_find_property(node, "input-debounce-ns", NULL=
)) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return 0;
> +=A0=A0=A0 =A0=A0=A0 } else {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 debounce_prop_name=3D"input-debounce-ns";
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 debounce_dividend=3DNSEC_PER_SEC;
> +=A0=A0=A0 =A0=A0=A0 }
> +=A0=A0=A0 } else {
> +=A0=A0=A0 =A0=A0=A0 debounce_prop_name=3D"input-debounce";
> +=A0=A0=A0 =A0=A0=A0 debounce_dividend=3DUSEC_PER_SEC;
> +=A0=A0=A0 }

This doesn't follow the kernel coding style, make sure to run
scripts/checkpatch.pl on your patches before sending them.

Maxime

--4d4ux434tr5bcsek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCz38QAKCRDj7w1vZxhR
xdYxAQDuQw3AAskrMfcPPpaS8bwmoVbfXI1KgKDZ6IRikJ/MtwD+JBs5jXA0i0aL
4KwQ8cc5G7YLwGjAjFAVn15ACOnxtgc=
=9525
-----END PGP SIGNATURE-----

--4d4ux434tr5bcsek--
