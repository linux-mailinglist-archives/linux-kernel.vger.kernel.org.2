Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA31C40D81A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhIPLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:04:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55745 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237459AbhIPLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:04:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 256805C0234;
        Thu, 16 Sep 2021 07:03:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Sep 2021 07:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uPb9yOuBxieDtxwFX1tkC2xNg2n
        jrloQioaAV8Ncf2Q=; b=4TJ56iNw+IW/RYm+oP5gGyR7YAJxoYSE8w1OyOHPoQM
        f7UIW2PnQQgcdbwu7f3XNiYT1bKmGK2fcMGMH0/eLpStBkV2gZ5Zx0nTkH+vkr02
        5ZNBe1MuuW3nP9bPcSO27aCWHsZl5zcOfq8c/Iv/zF8qy6VH8hHNbQ1k3GMbQwPw
        adz0AgphUZht7Ql1wLrcIueVexVQskd8HK2kU206dzOkc3/RurlSD8JZmJk3l0TV
        Ak71DccBgjnbuqLai0PYTpGjvgYFS/7PSNDW4zfmIMRQKkVg7WAZAohDJzUjVoqd
        utdvejTocyEuVsPuBlz7MlufIYhfMuVNGpf3KrHLsrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uPb9yO
        uBxieDtxwFX1tkC2xNg2njrloQioaAV8Ncf2Q=; b=cDjUyjpdsRwwZ/y9Tx6uOp
        p8UcPkqyV7ADQsjWCuE1svMQ/zeY55mPOyv9ZmrcNcm4GA0Df9E/WdV9gjoWN1h6
        HRHoPtVyFr7Y/obiWXaTE7I+Xxkklm4FBSgfmQBp33ZQ7rli50Z5ryEkhmk9Eu+6
        4zvdxuJRziV80HEZb5PHg7wj5M/7aW+/yq28w+GDmcSJD0mFoQXNkrOMgKQ3aHtt
        Fy8cta+qSjTc1kOY+G1xmPBX9YXYXQuVzbjrGwvzcCFJ+VTz83DAOUsthw6Hit7T
        fnNx0LEwcT888In56JTnnr4/3hLNGGwtSuLn/B+CxjLBZnL6nnZ8jZjiej1fz/sw
        ==
X-ME-Sender: <xms:ayRDYa1srlIR1ROV1_spfcxfP2ApQIj4P4YCKnM1k1_sRF8bdwYk8A>
    <xme:ayRDYdHPWWfDAbf4C0EG_323BGhFazY4Oo9j7J1JqNdoXxWI7d1lsC0qRvoNDOCt3
    RECXUEmF3VbjP4fUSE>
X-ME-Received: <xmr:ayRDYS6a_3uNs93s0ABObOnlzvUowlH8GFqq5WSFfwGnFId9eq9MXJdq3YGLfb6BtgS_74I2Xu5NJiLj4jfXgucp4ba63MCDtiDX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ayRDYb1lpbuNZ706wKM7Vv_HAEtClkqUmzd-1bTRyoCAD5qiyBHp_Q>
    <xmx:ayRDYdHjU2uZVyF4E-5QG-YOWIxtFegPMzEX2_HwyQbJDOhpH5Tomw>
    <xmx:ayRDYU9i-NQUBtWtSjqnmnxU_PUZKTqJmvnTPpkw32Vniv9sKmMx5w>
    <xmx:bSRDYS5X9CTEylFp4PhC-oBbP61Hfh_Zl8Za2rKJzHM5gPC7VH8SZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 07:03:07 -0400 (EDT)
Date:   Thu, 16 Sep 2021 13:03:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     roucaries.bastien@gmail.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Chen-Yu Tsai <wens@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        Bastien =?utf-8?Q?Roucari=C3=A8s?= <rouca@debian.org>
Subject: Re: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix
 ethernet phy-mode
Message-ID: <20210916110305.ehmaspxht4nnhksg@gilmour>
References: <20210916081721.237137-1-rouca@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tm6zdv7bbtikgw5o"
Content-Disposition: inline
In-Reply-To: <20210916081721.237137-1-rouca@debian.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tm6zdv7bbtikgw5o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 16, 2021 at 08:17:21AM +0000, roucaries.bastien@gmail.com wrote:
> From: Bastien Roucari=E8s <rouca@debian.org>
>=20
> Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> config") sets the RX/TX delay according to the phy-mode property in the
> device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is =
the
> wrong setting.
>=20
> Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> the Ethernet working again on this board.
>=20
> Signed-off-by: Bastien Roucari=E8s <rouca@debian.org>

It's the third time you've sent it since yesterday, what are the
differences and which one am I supposed to apply?

Maxime

--tm6zdv7bbtikgw5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUMkaQAKCRDj7w1vZxhR
xVLdAQDcZH3Hq07ZYLZqSjCMR9ApO8Oe4siueWivrUaAQqXqXwD/SEBY9vWMjNkS
Qd4WH0dLMENPwzBUoOjMHobwpA4nuA4=
=1SqP
-----END PGP SIGNATURE-----

--tm6zdv7bbtikgw5o--
