Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626A3169AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhBJPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:03:05 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44797 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231927AbhBJPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:02:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D09D55C017C;
        Wed, 10 Feb 2021 10:01:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 Feb 2021 10:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6GZtdqXMNFkD2BcFburlBicKk1i
        oVhLRSpK6+dRFql0=; b=ln8XgmqJuPfayAsfHYyeRmHfpOkr9QxtZhq8yQz/R2e
        g5b0PACGUZeZ9pPOHSsvdH5NHoSq6Qz08UZAgSQjjSL+tiOXrEEkPrSvH5hMrgS4
        6XkQdaDclkzIaMBNJYv40CV1GLvep/+IYz3ebKH00mmdl0E8OmMjg8FWBevKIut0
        aoEHNP4lk80Od7EzdAgy1lGL5oeSnxr/x1Vm2myXZ90+PnWyGZiuddSMzi1We7ii
        YJJfX/K4c+/7kBm/RKpl4sBIluoCw7u9n2fU3TfMGmUdYnH3VDlAxHjDHkS5jqLh
        tpJaPVltzy4l5O9Um5DvS6YlRPKU9cD+xRMR2Os2xCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6GZtdq
        XMNFkD2BcFburlBicKk1ioVhLRSpK6+dRFql0=; b=lZPD1HgEGxoHNYwPDLlZRy
        Yq6hptQY+IgaQgkKgQYp6BQh6KWInW54H23x+78hAlhMRrvJJSeLSRlHvufnxNI+
        kglJnoGqcVvs23U7GrXrLF+u0rEuLZo+6I3CIvlSOoZ8ed6S7ZdQnaEJojSsBdbG
        ivcrw4crvwgTjIbex1d/V7p1cLM9KwXHmerFQ5VDzNz/7PpLRnj9fGBp4SAIWUkI
        GWM6TXYjO1hZGsNGuLb/clbDBVEdhqWda7gH5YSPS8pol4rtnaSNicPJI3VPLAfX
        BVGt4XMFmq1TnksCsto6Yf++cOqrFOEqTm7BSKFIaxQ6IGnrhHS+OpblM+uvGKvQ
        ==
X-ME-Sender: <xms:QPUjYPN-SVKk_xBSnmqZgMJjeqyRKaWeYWgl5LKCkRxDMd6bkbukGQ>
    <xme:QPUjYJ97UxuiO_WC6Q4LWofHAM8DOO-x0gWPBEiZTo9xqCEJSMQHbalDwMEjCEvJd
    HjXlqMxJrXqQacxblE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QPUjYOTUkHOTe6AmVa0j98ZfcE9keIcv5-6MGsGYTDpsmZ6IQgq1eg>
    <xmx:QPUjYDvpApN8bKCKdlMtHMfEcsY8gNYcxFAj7cdvkqmOg_0rkr962Q>
    <xmx:QPUjYHcUcJ4DGJ4DwKFmI-hF3jA4VH24PXE9hV-_jUmnVsm4xCkIBg>
    <xmx:QfUjYIEFjmdLZC3jGWHdJNP01drrBjnuazM08-xA2-J__LkiSTi9cQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3080C240064;
        Wed, 10 Feb 2021 10:01:20 -0500 (EST)
Date:   Wed, 10 Feb 2021 16:01:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     "B.R. Oake" <broake@mailfence.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <20210210150118.ly252i37eykayrcb@gilmour>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mc7bt46on7uorfl2"
Content-Disposition: inline
In-Reply-To: <1243888060.510560.1612783497400@ichabod.co-bxl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mc7bt46on7uorfl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 08, 2021 at 12:24:57PM +0100, B.R. Oake wrote:
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
> delay config"), Ethernet no longer works on the Orange Pi Plus,
> because that commit sets the RX/TX delay according to the phy-mode
> property in the device tree, which is "rgmii", the wrong setting
> for this board.
>=20
> Following the example of others who fixed the same problem for
> many other boards, this patch changes the phy-mode to "rgmii-id"
> which gets Ethernet working again on this board.
>=20
> Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
> Fixes: 1dcd0095019a ("ARM: sun8i: orangepi-plus: Enable dwmac-sun8i")
> Signed-off-by: B.R. Oake <broake@mailfence.com>

Unfortunately we can't take this patch as is, this needs to be your real na=
me, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#deve=
loper-s-certificate-of-origin-1-1

Maxime

--mc7bt46on7uorfl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCP1PgAKCRDj7w1vZxhR
xZSsAQDi5eI7KYLfoFTOdahd3unW/v8Wk6HmPxOdTiBAJJt6lAD/bUsW9cfrdL3U
LkJen15K9KdgC4tKI83IJmzoNgnRfA0=
=a46C
-----END PGP SIGNATURE-----

--mc7bt46on7uorfl2--
