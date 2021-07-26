Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480883D5C29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhGZOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:12:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36713 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234691AbhGZOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:12:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8D84658037C;
        Mon, 26 Jul 2021 10:52:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jul 2021 10:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=YH7NgoqGItUWkC7R6deH5Zcu+he
        6CbEh3YXSIrNnpb4=; b=H8MMkapgWYqx7TUdwyCHNxnxVB+sJa/W8mEH2H2VJFa
        H4FufngYs+O322+lobj0qzRCbnVufStEGheOzrJUuYeTvDQvDGdBephi+K3kkRra
        xmH8g8TNxKLtjlaFxqRv/e/0Do0as/vLMvGZ+/D/AoPUd+fEmn8uqq6p1/9oJM/G
        ioOUqLLDQn4PgFyLncmMnOvzsrzztRXQUh+M3zDbAuIz09zLRwelS9ssOuf1zT7E
        z7RNL822mfraCW4ddYHhkay82Ypn59ejOSgYa421TkIjft2ywFmRVyhpYSU5XWfM
        xay7jDCmYGgg92ZSh/hca0n44pODk2UbwL6E3/+UzkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YH7Ngo
        qGItUWkC7R6deH5Zcu+he6CbEh3YXSIrNnpb4=; b=dO61XLazOwLFEsSUkUI1K0
        4HSOVQW2gjnzaK2aL9mZV5YI78w6wextAPR7jMvvVAw47a1pR59XbE1Tuzc13Mlf
        mQ9lObSayuJ1xAwRED8CXgb/yWyGVZ6bTNBcbX/xbuXyt7Kv39ayCAH36+oSEB3y
        DSgSYT1+xR++aOOWY9GCCFRBMF/g1xCDPEIMgXvwI5f13IV2GNvLdLVBnjjgaCi7
        rWW/MXVk3bYfkprQF6rwiLoIzuUwqGwrgvWEnNG6BfNWnJ/mauUxV07wTO2vuBu1
        4CHrcenzZQ7vn119A1J9+pOQEPynTNgjHzt1sbjSu3zQa4gNmP2Wq74kYsvCdioA
        ==
X-ME-Sender: <xms:L8z-YGfQVPO3WQdueYzUy0e750a7NFVgtABpF5ORgZ-yqBg1H_24fA>
    <xme:L8z-YANiQ4dbfQaGZG6ktY-P6boaBsp3Pe5pgq5CeoLaLH6zolhEUKRdHm3kOxGsC
    g0BkvfWvUtINv-jYYc>
X-ME-Received: <xmr:L8z-YHjF4w3_lwPc6mVXvMj8nhoBgxyYcyUc1clAzlMcuF0LSofXtkcFBDaeHvgz3RQ7vmcZzc5TM2kHWrkDckWFrbYKRiQoLZbp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:L8z-YD9Q6Oz1ZGYO53MOcPnyGJuceH0XLysh0Y4HnTHd_pQcbubldw>
    <xmx:L8z-YCuJWm8gew6O5VMdb0zv7ybOhpZCIzOH7sneKg6OnfYo8nJTtw>
    <xmx:L8z-YKGlU_8FelJnDLWw9AG1jbN1qiAxVJ1Jj7Gk-5se5xTfN4cyRA>
    <xmx:MMz-YML-PRHXMxU7D3h_XcEQ8iNen4uoSqWy0ZDU8TbVhKsotFt3jQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 10:52:31 -0400 (EDT)
Date:   Mon, 26 Jul 2021 16:52:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v8 00/11] arm64: sunxi: Initial Allwinner H616 SoC support
Message-ID: <20210726145230.uevhinsrvo7gtuty@gilmour>
References: <20210723153838.6785-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="up2ns35lavo3yw5c"
Content-Disposition: inline
In-Reply-To: <20210723153838.6785-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--up2ns35lavo3yw5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 23, 2021 at 04:38:27PM +0100, Andre Przywara wrote:
> Hi,
>=20
> another try on the basic Allwinner H616 support, now on top of 5.14-rc1.
>=20
> This time I dropped the USB support from the basic series, to split off
> the discussion, and simplify the core SoC support. I will post the USB
> series soon, to be applied on top.
> I kept the RTC support in, even though this is still under discussion,
> because this is important to keep future DT files compatible with this
> kernel.

Honestly, I don't want to support something we don't guarantee if it's
at the expense of making something we do guarantee more complicated.

Delaying the clock tree description to sometime in the future will only
further complicate the probe part of the driver, and there's far too
many special cases already.

Maxime

--up2ns35lavo3yw5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYP7MLgAKCRDj7w1vZxhR
xQviAP43ZH6hYvpPTFTh0Ky76XcmPg9oNB230+/EeQWij2EJmAD+Ms7eRM11Jm2A
xrMLoAPlLR++oEqHzkAKBoz/daz2NgY=
=OQKY
-----END PGP SIGNATURE-----

--up2ns35lavo3yw5c--
