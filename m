Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1B30739B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhA1KWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:22:22 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:32853 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbhA1KWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:22:01 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1BB0558062E;
        Thu, 28 Jan 2021 05:21:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Jan 2021 05:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=o1F01j7WydKewpoMAwmV7IhtgkX
        HLvbfzpJz5nwwo1g=; b=ehpkDrc4nuGXLRLG+D7bdmY+GvK4lSeyvP/kI69Tctu
        iU3UgQNrLjIRp0n6USDLaqUr6QJ0vZXuDTWrr+K7tcCOYMMwasga4vdXTrBFG7Ok
        DtU6t1MVceqtRqinx1X5W/fJ3f3aVguA9IpLSGBOEi3J2EcBNa6pAuzIbdAa6IVb
        vfMfhCEGlge0qwjnEzDjjYcAl+7TyU1NVOYNZRl48vktarkLuaY9R6Lz6nGF2cCx
        +HU4S1AFvB6h+1DRamFrqJzbez08nCfjDGg3tI+HbKI5JTJPmg440emYALVViwOo
        HtLO0yXcrUynyhq/GX319wsz3SGtmvs8xabuEyBH9LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o1F01j
        7WydKewpoMAwmV7IhtgkXHLvbfzpJz5nwwo1g=; b=ixjPOtYWl2rIM7tYso/Izc
        f25RPBT8eHiKyS6aCDuqTmqoemGZ5K901CnyWYCTqUKlKl6HFcoz7AsJkXaseEoW
        +yXjG2htet9H4J2JHBc/Ok29j6ot931P5LYpXatKACQfAQsQeWzhi8kOBRsQy26B
        FK5FnirMFey1Ws5gIcgXJRVPAwdCqPWYXT0ALh0PGeATCuOnWXn82KauKtx8owht
        I2VLd7WV8S7ZZVBKhtr3xi1SPiwLsJGV0pNttu98UABlghy3viU7aE9JFm7M05ud
        uF4rzBFdxXk2zhY91gbWAwoj7PBzHvDbPqoFaNb/736ECZbx+DmPF01BhBFSiKWw
        ==
X-ME-Sender: <xms:GZASYK-uPPnTMNcZG657e3sXcmmpmWgOvxkHMNN_ZxFv-RzXNFOAqg>
    <xme:GZASYIioO0iw7qlAfBF6zxwFJc50BzqwbTC2jFUhUD8XmFfTxEzOTyNy_dalEXdlY
    ucxsqYMfbi54aaA4Ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GpASYKcnclUfG3-tthu6vSO6nNA80lw5TgQxExX8K5Ne2K26yW8rPQ>
    <xmx:GpASYPo5xZ-HYhM8KKWaQJzUeiV3kHV_uZZdTViSAfupGGM7qcaBxQ>
    <xmx:GpASYPBec_9R12B_yNcpK6g1AJWReS8k1mah3uRp4jfN6DSPQfRkOw>
    <xmx:GpASYO_FjOXizhl5M6MofYbfkY_mIwtaTZPpf-wWaNYhhSyums3j7Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C513024005B;
        Thu, 28 Jan 2021 05:21:13 -0500 (EST)
Date:   Thu, 28 Jan 2021 11:21:12 +0100
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
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 15/20] dt-bindings: net: sun8i-emac: Add H616
 compatible string
Message-ID: <20210128102112.vm56eh3s3rh7lkgv@gilmour>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-16-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cux2x6cmcw4jyobt"
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-16-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cux2x6cmcw4jyobt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 05:24:55PM +0000, Andre Przywara wrote:
> Add the obvious compatible name to the existing EMAC binding, and pair
> it with the existing A64 fallback compatible string, as the devices are
> compatible.
>=20
> On the way use enums to group the compatible devices together.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--cux2x6cmcw4jyobt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBKQGAAKCRDj7w1vZxhR
xZ92AP0ROVkOZpa9Z71Kb4jYY0e9OS84wrIIbSGmVuEi0cFALAEAwCLkw8DhekGs
kZ+xN9CL8RIYRqxBjkjfZTS4ohFOewM=
=ZjAD
-----END PGP SIGNATURE-----

--cux2x6cmcw4jyobt--
