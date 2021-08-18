Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4763EFF78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhHRIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:47:53 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45253 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHRIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:47:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5DCE1580BCE;
        Wed, 18 Aug 2021 04:47:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Aug 2021 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Wv1WmLMep7dFaT8jfGEaMi7tqlP
        V+6Sld2o5UJJO29s=; b=YfQEpXEVxESCzSIj6K0QKj0RD4pot640SQiSflKmevd
        jdYx2gWJbzNjVl2RAmeIVIscA3EUkCM1efA7B9DAK562np/XgCG0LqKKfg8UwUMm
        6BfSixL5McURh/ek7NDvT+aha2i3VaBFuaWCHWPQi3KOf+PS5A5bnJcViBdTpURx
        fdlvzq8EuFSaKAN7y1kiEtVCh+wI4hvSR9UzR2kHzj3pE1Ls2fNj2K1fVvv3m8FY
        glpF1X5OEhvy5dJ+NY1Do9+3npqDzb2igbJmyi5EkEAjtzj7bJzjllwcaXffL+N0
        N6Esmm/LII0xlPbvju6U6HCcUwGDIOcjKZjKIikGlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Wv1WmL
        Mep7dFaT8jfGEaMi7tqlPV+6Sld2o5UJJO29s=; b=NP14a4OiosHFqzQbEOcX6L
        mfp9zEjfUPiA6K5WZBU/PUFh3H0hr9DXtLZSSLE1FMi7Pe56DBC0LTQeqSSr6gUa
        4rELkoku/+OmQNd6+M5+5f+oht/8v+7hJev3bGsQ4UQsxU8fB353Zs2kB9r+K32J
        KITRgh50kcgwkgWX7zP0yOieBtHCauuVk2LHp/p8MHKuKc1nd3kM/kZPkWXsOSNC
        EJaxHj8yAwLIvj8GzPOK7kVDTG9u0TtBngwsGI+OFri1vPEDYWBoUKPf+7ZEERG3
        KT3UmP9DOOmbDQL5Dc3LONbWoOgQsOvqLEojBiT/m5np26kwosBLpBfo3YUSB1dw
        ==
X-ME-Sender: <xms:E8kcYcpOmx-QPn4ca8wKoBhFIZIoFObuITuwF7_kMrFQmACOveaiNg>
    <xme:E8kcYSokGBSKAy16Mm3GkgTbhAYXnxbVu3JoVFdG-SSzWCxaW5Ebums7v0Ur0WUl9
    CIitDcx-doRMbvSDDk>
X-ME-Received: <xmr:E8kcYRN63fiaQMaMdbYHLreV2Z6kBisoHfJ1D4D_90q5EG894KS4RMpzW-myCKYwG2PHa_UTRrDN4rAVysreQnAHsUPHXYictOO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:E8kcYT54YTpAF7LXDLpHckcvMp3KEFqkh2DmfLrzkQjfauZ74qknIg>
    <xmx:E8kcYb6q80YXRnjZDaya95vLaPwMVRJSCXdgZkZfF6GGeB7AayDPiQ>
    <xmx:E8kcYTgDNc2MQpE1GxDFi7OjBYRKoSNFbHBsP6B4CWdjIwRusAT73g>
    <xmx:FckcYfhTcjjpQXUcCl9ob0paGIshs5Rzuyrfx-DO89-A980zBx4uFw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:47:14 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:47:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] dt-bindings: mmc: sunxi-mmc: add R329 MMC
 compatible string
Message-ID: <20210818084713.klz3ijd4tskhorzm@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-13-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ehiead6yfp2hmcse"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-13-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ehiead6yfp2hmcse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:07PM +0800, Icenowy Zheng wrote:
> R329 SoC has two MMC controllers similar to ones in the previous
> Allwinner SoCs. However, as R329 has no eMMC controller, the two MMC
> controllers look like a mixture of previous SoCs' ordinary MMC
> controller and eMMC controller.
>=20
> Add a compatible string for R329 MMC controllers.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--ehiead6yfp2hmcse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzJEQAKCRDj7w1vZxhR
xZYnAP9B+XLHb8xJusE9+/MDItMQgZp3Fd4DgCaMnhkMmgOSmgEA41fsWU7UE5iR
ICQf8x3MNt3DL8U/VoQAweINu9DDVwo=
=Txi1
-----END PGP SIGNATURE-----

--ehiead6yfp2hmcse--
