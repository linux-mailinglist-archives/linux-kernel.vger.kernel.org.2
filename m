Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6830737A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhA1KP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:15:58 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33003 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhA1KP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:15:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id C3A80580788;
        Thu, 28 Jan 2021 05:15:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Jan 2021 05:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=VTAFBqtOhCy0yoYTvGJOxx1nJ1N
        oRdob2zC/BpgUKks=; b=g4AIlX3F6DiznNiGaTka0EUZDD8hi8igdLJJDrfriG4
        d1+Ftxe+KHjXVJGlj1upwk8cdXmhngFNvb/o40JVkuQ20RkasOt94cGT28mcHfsT
        kUfP5LtsIAZjQw9q9DKalE1vjPddANgqbf8gk7snbhKgaDdNT7dmrSDOuY/H3zAK
        kVDYWHyPdmMmxR6XALbOsPSav98uIzmSHRWIXzMQAhiVJSMcJy/tEws7+gnV2ODD
        Jf0kTVfX4/BcjdfqGaDHRm3fhzl6TFReLE6MwfTAoPEkCtm206pmkU1YicqEsLtL
        jPDoEUlwrQ/WnIfXCAU0sRdWkItAYPEOXEQEHPXsY1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VTAFBq
        tOhCy0yoYTvGJOxx1nJ1NoRdob2zC/BpgUKks=; b=Xwtt2EBT4Hti9Gg38Hlg2x
        m/rwpEUDn52RsE9YjmL73YodArqMkfR8VT4wRBH3xjEaIY6Rt66eXf1orMedt7ud
        RG7f+49hx8JKuVi9wn1WK41OmYY8H6B0/lcot40BBFUdokwdANk9JY8J0H/Rd1i4
        E/l4XP5WUuo/va3Oic9OEg6Egn/jPa7P0nAlJxq04wIC4j5R09CWRzKUYMIAkTrF
        6h/fpzWvJyh+BB7JcWwx2dRONQzMcHkPsNSLLW2hlivMuXvQ06VPfaBDbRN39vHC
        a4hgir6CyKUBh/ke6Q+SzbEnU6bzhlI8NB5wC5ZnQ4EZt7ROuj7HXyFibiAH4Hgw
        ==
X-ME-Sender: <xms:q44SYHZ_PUiIdFLNsxZCCka5DhT7n6fas8_z_UALO59mcMIBBJFFsw>
    <xme:q44SYGZlcR9Hvskrjin2Ww5Q_5Wvd3FobZw5HJjzmu9dcT7I5ohV1FgqwSVDaUa1W
    PvF1saAGJDzhrsq4oE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rI4SYJ8oyinGri0CexKbWmrbvAnXmw9hKW6NJ8hxtosj0pc9Fd250A>
    <xmx:rI4SYNqRCQXJ-ZjhV1QB4B7CVDtgwgL5Imv-YFyGeCZQNLvs2o-W5g>
    <xmx:rI4SYCq6WHsRZwRhD3pLG1ZILWPVVSzEzSz5XUAs_mwc-APJJL8Wxw>
    <xmx:rY4SYPQj7YY03Ybqa08irg_W08-mRv3qZZ62L3Bmp5yZObeO4FeZ2g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B502A1080059;
        Thu, 28 Jan 2021 05:15:07 -0500 (EST)
Date:   Thu, 28 Jan 2021 11:15:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/20] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
Message-ID: <20210128101505.67pszbw4wuejzx2n@gilmour>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqj34mvsav6svqec"
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-5-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqj34mvsav6svqec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 05:24:44PM +0000, Andre Przywara wrote:
> The AXP305 PMIC used in AXP805 seems to be fully compatible to the
> AXP805 PMIC, so add the proper chain of compatible strings.
>=20
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--fqj34mvsav6svqec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBKOqQAKCRDj7w1vZxhR
xWBiAP9QPwJpPoRsCkZZdEFpsl4TmNgW4FP0suiOarrVsgL3PQEAlEfUSjVJvec/
ToigsVeSNnhJnU/Th9JHWi7qW83GAwE=
=Zt1l
-----END PGP SIGNATURE-----

--fqj34mvsav6svqec--
