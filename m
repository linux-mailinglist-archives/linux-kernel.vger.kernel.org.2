Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2762E307384
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhA1KRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:17:03 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33805 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232031AbhA1KQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:16:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id A30CE58078B;
        Thu, 28 Jan 2021 05:15:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 28 Jan 2021 05:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sBHceBX3nouDZkvavqurqgQf2F/
        vRYTPOBuP3L3yZFE=; b=GqIYTyhsobAcx5Yipt8FdKD8Qv5QEl6HyioVIh0HddM
        LF8Yp7/RUr5p/jvFANAxobMoLA6Ka+YuqvKn6V8oMJeO/7DKiSeEUikOmOC6hyH2
        Hi9O+BVasiZj0uxCdLWJWa7iDGCcVznm42fmswG7oK4WHjJ5avsdu/K79zFrzrg3
        h7hPa6+stwC4wcNvntmuowDDgwjuCXdb3ikDABoRRYYBLiiOu+U+ySy4LFMrB3Pc
        7V37cpAImtT17mfVX2hJDU9GibhhUAnlSFiui4Zf3H+2ZNOz6Vroccl2vvuAdttg
        AT/Fp8r71xwkbb0kkU+RJftldrQjtuK+xo0RDzRn82Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sBHceB
        X3nouDZkvavqurqgQf2F/vRYTPOBuP3L3yZFE=; b=aFoV/URNlkUQKRY4W2xAki
        LIqmWZ6Bcme1kUtMxe5SRq9wgZN8IyVX6AEYBfVW76w/NkS4bn9hkugCEFKcAoN5
        1omUDSSsurKB7rBxY6+Pnut4LJYhdEbHzuCXXUJ0kg7lZMnJse5rgqRbdhFFa+o1
        o8sBaaouN/YUS5RvMgpfXnItowt9M2k7e68H/AngS5Za/ECkPeRBxRaNTKJ7gggx
        JFaqWXHEc54qQHJGSH/9FcBtNECqLdU8QYofKCqG8YTFgMm6xUYpyL3RZrHOEDXi
        8H6QB3Ejfi2juc81BfzkhyvzfPjsTwjJ+Hw1f4DkwKI4knWC4Ce64IiThq/RMurQ
        ==
X-ME-Sender: <xms:0o4SYGlwrGoUMK8fdn8kan39Z6RqAkPegg2Ljr666_Lb3t5aHM0W_g>
    <xme:0o4SYNyzq29q5dCRukUk9C5JQT0zdUfTSrRR67yL909bvHnHOifq6bLIY08UQuX31
    GdIgG6UsL00imzCmpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0o4SYBgyqAf70frOBOpUXmd2XEOWzQvnJePA8Bh31fVhyVtvWQnhYQ>
    <xmx:0o4SYCXRaR-7NgzJpG6Og2aot_EhJsfEqEjD5Qvh0q6n1Wcy_b3i7w>
    <xmx:0o4SYD1UEGUavME5UEERoZN7OlOOQJZt9iDjuA7yhCptPR2dK3KxdQ>
    <xmx:1I4SYL9JBxR24Ju1k76BDEhzS4FcD0edyhV58AN0tQ-QRSs3wSepcA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34BAB24005D;
        Thu, 28 Jan 2021 05:15:46 -0500 (EST)
Date:   Thu, 28 Jan 2021 11:15:44 +0100
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
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 06/20] mfd: axp20x: Allow AXP chips without interrupt
 lines
Message-ID: <20210128101544.yyvrguk2jlgr4uwo@gilmour>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6eblr7x2iq5pdape"
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-7-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6eblr7x2iq5pdape
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 05:24:46PM +0000, Andre Przywara wrote:
> Currently the AXP chip requires to have its IRQ line connected to some
> interrupt controller, and will fail probing when this is not the case.
>=20
> On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
> least one board does not connect the AXP's IRQ pin to anything else,
> so the interrupt functionality of the AXP chip is simply not available.
>=20
> Check whether the interrupt line number returned by the platform code is
> valid, before trying to register the irqchip. If not, we skip this
> registration, to avoid the driver to bail out completely.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--6eblr7x2iq5pdape
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBKO0AAKCRDj7w1vZxhR
xfuSAQDsBnkmPRLbuwfbB2tNnWlYrtOy/dSadYy1k/1FEC1DnwEA4ZmBkAyH5K/z
igfyPWSk2ldQN7UJGNIPKL6JiBIjnAk=
=+6sm
-----END PGP SIGNATURE-----

--6eblr7x2iq5pdape--
