Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10454403577
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350285AbhIHHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:31:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48461 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350504AbhIHHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 23E335C0167;
        Wed,  8 Sep 2021 03:30:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Sep 2021 03:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=yGCXYbluQX/ON2P4qhCwIlRzQxV
        TSV/kB/bvO/GkOhg=; b=DnN6W5YfyId1zyJRpjFG+qd90Y/FLEyrBYhS39fa47J
        ACIvW8HuiOhbn7XTq/KD/Ah9FK2GqAvyOAtgnubOXCL5BtHsj8COonTs60CKo2ru
        KeucrNoFCfKVsK3Ly89tblXvX1ie/5DQ0qqWffEfnLvll04qiYWWxABv153gITPc
        y2Z2NfJhqEDuGflc28a+h00kZXAjzpxoFTrUCS+2M95nNyIAQqce94F9UmzkLl+u
        FpjRDLbRJ8X8GCyWaN4MaN3MgwZ3qNw79BbKd+IHx2YdBIWxKBIIUmFCwrtKQhIK
        xBjTfg1476kgQBr1c3T8o/TngctRYCWn/pNGvtsYEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yGCXYb
        luQX/ON2P4qhCwIlRzQxVTSV/kB/bvO/GkOhg=; b=T0L4OEJIuv0hwFq4wsD0Pn
        pbglvEOYfLTzhgBOXXWvapdXomYc9fFwD00aFX6aOmdaB2Yx1CvQk48joFRTJ/2w
        hr5rmIfT96Bl3c/c+P94AfPiX0Xuu27UjfWFcSZWNqJdzgRY4S7y7BPv2eap3bxz
        WlJ2uN85kE3fEt5jKIjMx7jwNLsF+sAZpMLt/LMoiDZp7HVbp8DkUcRAB9ieUX5P
        Q5Js18JuUbPt6I2Z+VB+l4PXs1YH8lx4SUplCSwxxT6y41zdAW1O0MMBMfSYO4f2
        G9/vJgDmCXJXE0dO9XHfda+NMAGbkjHDH3fKoPCbABnaSaTqXJV7UAL6hvD6JGRw
        ==
X-ME-Sender: <xms:kmY4YZy2ALfOPzMfs0OjRZOb15wgTZI9D-LcYKZvPqLBiIQnbmV2rA>
    <xme:kmY4YZQEJHeq81BgJJ3H-rzJwu2vP3p4Byf-RKwBYYy6uXnNRVFZ5G4eRtgvw1Byc
    L-A0jeM_WUVq4b2j4o>
X-ME-Received: <xmr:kmY4YTVDQ55D_4mHS5OdcEyCWzzRaCQF1QOD8PZgzFkmWlchoeiq54fVeWEq0u3EeMaAcj_nalt4rEEWkWyeJsV6Jr_bpN1vxKjO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:kmY4YbinxAAXDjh-dp8NgddaUufxzmCRk2GzFem4TLmQL36w4BNsSw>
    <xmx:kmY4YbB9Tmxmdzl79j0rRFxIqukO0NMZxQZXWTuFmt0d6Aln3wHscA>
    <xmx:kmY4YUJAfqGoelmFE5GtXKxQ6NbXVJMhwy2p3SIdTwXEJhjAgCbaPg>
    <xmx:lGY4YdDbpw0VlQ_X4X8w6x3ZRIJOx8SzgamLvDx3Gr90H3kh3i4PKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:26 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun8i-a83t: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908073025.eug3vu77rgm3l6fl@gilmour>
References: <20210907085213.4662-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iec32v7lqakop55a"
Content-Disposition: inline
In-Reply-To: <20210907085213.4662-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iec32v7lqakop55a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:12PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--iec32v7lqakop55a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmkQAKCRDj7w1vZxhR
xaK6AP4oxCW46ajZao1g7PXC2f9tUD9Y5GLLa068wAOvGhK62gEA5ozGL9W3IFy8
Oum2Rm1Ihx6z6wnbfRBUwqkmU0xSiQk=
=NNtO
-----END PGP SIGNATURE-----

--iec32v7lqakop55a--
