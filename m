Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52538E6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhEXMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:36:40 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53447 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232486AbhEXMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:36:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CAE3917C9;
        Mon, 24 May 2021 08:35:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 May 2021 08:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=RgURLS9p1wMowaWNBQnCBciQXSD
        k9br9wW1FSu9L5OQ=; b=hQ6NN3WbEWtRvV4Dy/6bowGcLT6VAFZjQqUHxZf0OgC
        9lyAnrKxnmwkI3v+4MASqyy9RmJdTGPhREBvmKFZN4nbv5hx3o1o3kYZoZih0/pc
        Til6TmZTmEQafCRJub64i2zAvmIZqnz/VWGjKYhP7rVKQ9SIfMhST8nSfKzekh1u
        a1ijcI82ax3gsl7ncNgfVvG7UVsP8xAoB9pz0Mos/iHpvRZfOCE0D/pc+KnVbSdw
        f+mySgQF2QB3ak6U+1KwQbNsPuHBpCTqBmL0/fusYn36X/+aQjDxD2PW09SpvCcI
        EeMzoSj2TE2/KaYoQv6VUIkXKKLQBNiLDSZTplI+r6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RgURLS
        9p1wMowaWNBQnCBciQXSDk9br9wW1FSu9L5OQ=; b=VMHjCXu3QAaO4NGLHlg+HK
        fX6ear112+NMHy6FUT8hFs9r5x+cwRS2V/lV9xfjofYprYL7Mxb/O4IPpTXFg4Kb
        6s/+N1uFGwBAHZwjz05STyBLhMAG5cJGlBcRuaSZaf4fc56UbjwxuBwR03JCTH4s
        EvofP+tbdHKlODJ+PVNBVrp4rmH++Oauov3Brg5wshxON5J0gCm21zw31MZOGZc0
        gR+qg2wt3mO+okdlVc4SRcSy3WeY8MlGg2UmvcaweLJrL3mta3MSCcweCjdVGscH
        746fe2vanbknnsdsj5s0KrEt9hANpG+fkipWOVHKsmUier3wapggpqI4B6IwpHkg
        ==
X-ME-Sender: <xms:e52rYNRg9mV0kdlAS6wyqtQ0UTEn52_ePEvbCg32M_A9CJ1CKMcqAw>
    <xme:e52rYGzOSyh48b0fcDIBmwhNzHYX25yYzYX0VHd1DVoc1El2KBIfqkH_boPmErqxz
    OC_5tPCbmG5iiyLdXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdevffekheevfefgheelvefgieetfeeihfdvteegfefhuefghedtgfeuveef
    tdefnecuffhomhgrihhnpeguvggsihgrnhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:e52rYC1ErC6J997C3utIV9orIYguR-WXyx-8qiFD8CcFDO87z0BwMA>
    <xmx:e52rYFDh-MhbQ2JH1o3ZSi1NbyOYrO_-dbqS2saZWw3W3_V7RioFLw>
    <xmx:e52rYGiTaX5oJApnWVp8gcYkwe0thyiwa-UibnVbd1QuTPjItCFkgg>
    <xmx:fp2rYKjLNc5tDqEvMCsoToNaDDa-INBMe8kE-H6QOK7UmDDQlqvynA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 08:35:07 -0400 (EDT)
Date:   Mon, 24 May 2021 14:35:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Vagrant Cascadian <vagrant@reproducible-builds.org>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
Message-ID: <20210524123506.cuwwtqgtejquuq5e@gilmour>
References: <20210524122111.416885-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mjd66dqrdahwedu3"
Content-Disposition: inline
In-Reply-To: <20210524122111.416885-1-carnil@debian.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mjd66dqrdahwedu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 02:21:11PM +0200, Salvatore Bonaccorso wrote:
> Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> config") sets the RX/TX delay according to the phy-mode property in the
> device tree. For the Orange Pi Plus board this is "rgmii", which is the
> wrong setting.
>=20
> Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> the Ethernet working again on this board.
>=20
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Reported-by: "B.R. Oake" <broake@mailfence.com>
> Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> Link: https://bugs.debian.org/988574
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Applied, thanks!
Maxime

--mjd66dqrdahwedu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKudegAKCRDj7w1vZxhR
xcr8AP4nGuUcFxQBI006qDoW+1VvmZevGyEN0wwfRSX+8K+q7wD9F36//h7Pj2FR
oHnZzDUG3LJ2LBf8wCDnyFl2RjjJDAk=
=0nBI
-----END PGP SIGNATURE-----

--mjd66dqrdahwedu3--
