Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90340323A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhBXKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:11:47 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42785 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234826AbhBXKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:11:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 20291580667;
        Wed, 24 Feb 2021 05:10:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 24 Feb 2021 05:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=kfzvIjz40bAcKM0RWeUMXud03b2
        +MIfE0nrkqnTKGcA=; b=opk4I4Dx/6W+HWKqylTyGHvLGV33WVn/Q3KnHMexGg0
        n7DPGt/huewokKLo020DXLHHolgEE08+fv1ZlmS0ErafrN2vFWZr0nGWtAG60gX5
        pg59gbMOWwul3eDvdAeALUUd7AreLbfnzeBpirgFkqa6w/dq/vJjrOkBbdg2Qtd3
        q1cu7gWTTwzxBVVQHVQn6fD+f0Itaq9/JoJME69ENGXjHNuyKkUkTOosGz1RUbG5
        x2Zbkb/keCXjkVFdY+3beNKjGjxJzF2HoO5JOMEO9v1yTAyRYL7W3FebFQxNr3gK
        kwMYTaZJaa7j1JoRFmYNDKgdMhvJNPMiITm91FYf4gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kfzvIj
        z40bAcKM0RWeUMXud03b2+MIfE0nrkqnTKGcA=; b=iJRk8puxfdjOpRWsFeyOJI
        au5YXH53LN2CKWPN6gQ/7C0UFg0k7XrQTmWr0+OT4PB2mVuYMYNnGKRCoWjeb0m1
        FxDLr5HTJCFOzxJMy78KbfAozat5xi1+86Mf1wpUPrVXoASUKrqb9Q3uTyxavZG2
        L2ImtoncV+p9Wnf3D9YP0VnsmxjqniRel5amt/KckAwNT0zP59liLRbIxJ2U+R6V
        AN8U/Ul6BSGO4PualecmZKz+/66Wa3xTQULpUDJ+BvNiOm+PX26B/JmTE9+IQ8pw
        VCD+q9QXyPy4oPdy31h3bVYXlzkdSjfupmTCAtIwZqR1dY875bx8zN/3/O9OKJeQ
        ==
X-ME-Sender: <xms:DCY2YB1UQ6zrODtk6yaLpThlv3PaMhbnvzWFyRZliHVLMIkwzfafvQ>
    <xme:DCY2YIH67s7WuxfmbOw32QP01d3Ylq4HNV7PQVOWYa6liBDi0GsPxzN802a45VDeQ
    GpEJUx6iz-g7udSpVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DCY2YB7nHJUdBiJIhhgKNVe39rwsNjua9mNKGm5mji26Lo5xTmROwA>
    <xmx:DCY2YO3Hfs2fzEw1qY3Ek7z-gY-48UQEQ9P3TpiNLTw9I6u5AmWRRg>
    <xmx:DCY2YEHSWXcpQ3V2XxtVhvyxMje42zvl5T_KUbeKpZdAc3qgTlDadw>
    <xmx:DyY2YLeL0Mn3zIM1v7Xv4PNtLWlJPMMeUGOJ0-4ArEeugngR5d42ZA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1FE91080064;
        Wed, 24 Feb 2021 05:10:19 -0500 (EST)
Date:   Wed, 24 Feb 2021 11:10:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Corentin Labbe <clabbe@baylibre.com>,
        Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/2] ARM: dts: sun4i: Add support for Topwise A721
 tablet
Message-ID: <20210224101018.ateuj367oqvphyzd@gilmour>
References: <20210222100826.12478-1-dev@pascalroeleven.nl>
 <20210222100826.12478-3-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctatgkubvtbbo6kr"
Content-Disposition: inline
In-Reply-To: <20210222100826.12478-3-dev@pascalroeleven.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctatgkubvtbbo6kr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We're almost there, except for ...

On Mon, Feb 22, 2021 at 11:08:26AM +0100, Pascal Roeleven wrote:
> +&lradc {
> +	vref-supply = <&reg_ldo2>;
> +	status = "okay";
> +
> +	button-761 {
> +		label = "Volume Down";
> +		linux,code = <KEY_VOLUMEDOWN>;
> +		channel = <0>;
> +		voltage = <761904>;
> +	};
> +
> +	button-571 {
> +		label = "Volume Up";
> +		linux,code = <KEY_VOLUMEUP>;
> +		channel = <0>;
> +		voltage = <571428>;
> +	};
> +};

Those nodes should be ordered alphabetically

Maxime

--ctatgkubvtbbo6kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYDYmCgAKCRDj7w1vZxhR
xXiEAP9TJK18t/Ug+nJChn8xkzq27KvAp4Gagg85nHJfZJRgjwEAwiJM0U80LsFT
1tQoFr85mEnIgd13nceFSuzlLON74QE=
=1gnL
-----END PGP SIGNATURE-----

--ctatgkubvtbbo6kr--
