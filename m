Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF140357B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbhIHHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:31:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52193 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350661AbhIHHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 280F85C0167;
        Wed,  8 Sep 2021 03:30:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 08 Sep 2021 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2v7mUfLtjnrnwxqUwfU7fsoEhJz
        IGABS6QNS/r9Udho=; b=ifyDEUkv5qUVgjeMdIXjuKqKWnm53Oile1i79bSZfEQ
        NDxqgijEerfNHtlJHAuhvGvcqgjNTlmzLwUlEd3A3kg6Hp5b9P9eHjZq4GszCLGw
        PAfV4ayD67qymYuFbfPi/lDkbkckVncA12eW7G4H8gKIpu0Dqv/fjsSNL+OlxxIj
        m/wiOdTX5GzaRxKk979IBoyHkm1H7LQGPlm4WhDTccCJpvo+nS0m0RU14p5elpdJ
        pq8SCgqUdEzJ/QxdV8Of8/rHZMgO5kirIo/ZHXR4/pTiRgfIGeFWwZaHkn0oF2FE
        X94sFOLIlU7bdYzPx2PCkEWoA54r9uL7A0IPdB9JNUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2v7mUf
        LtjnrnwxqUwfU7fsoEhJzIGABS6QNS/r9Udho=; b=hBIQq7zWPWVZi2oriKH0wp
        cHn3B0u1iXQ+okmSNOlTNazJhJFmDWDzGercJUTUmY/jLhKizGjmOxRzk+D1JCvp
        9FpijpPe5qF0i7jZWmtVWW4qnI4IaoSUwH0WI7witX2Dh3caSi+wbrZmV5JF+r+c
        GtjyhbN6BZTYtdkgEZfdkmxuFrSb1sfSJGUAiZXzytHzxpnKmGQgL8GVYJH/qNgS
        /d2Z7n/vOJwJEoO7Ja+0Rkz8PRaB1vijZUYbbBVWfrEZHpnKNttcnSz5ULUQwdH6
        BMB2PCNcC6FNYNAMZBOScB/ZaZxDxhAAmMvr36NqQ/Mc91M6F908LWBhYHUVM2Nw
        ==
X-ME-Sender: <xms:nGY4YcQq1rrlH88kJewIllxqfbQKCaA8sr2Lbc0f_Fdppi2mbPRkvg>
    <xme:nGY4YZxpQqQXVyNzDSTX7-Dzz_heCQTunZZWrTW2UhArNj_Ta5R-T8DQYhNEBvyfB
    5z0xqxUrLeBw1k1LCc>
X-ME-Received: <xmr:nGY4YZ13WTbzwJhdbRG29-lP-eQ6ow2N5VyoGp6h7HNixhgSiQsMTkj4UBGYbMA3TOp9X1ZebXevHYS_D238ODOJaH6J-bNNgZ9n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nGY4YQBoLjVbCcdIy97YxastIDIHAG47l_22_GmYbBuwMf5aN0VOAQ>
    <xmx:nGY4YVgMdnKmoC8R_W7Pa63J0rt6nzHxt3DoxmGHiRrc1xP-7Tc-wQ>
    <xmx:nGY4YcrtYP1mqSguA_cmHxeKID5AfJpbhFLUsIpW3jUe5wj3WS7FZg>
    <xmx:nGY4YdiSyYboxkJzttoJrC1k2DF-P5-mT9VjpM6V2oLJ8-1omQHUyw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:35 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun50i-h6: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908073034.k6alewngdw2rzmmv@gilmour>
References: <20210907085206.4611-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xe3e5pjhnlhjlmpa"
Content-Disposition: inline
In-Reply-To: <20210907085206.4611-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xe3e5pjhnlhjlmpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:05PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--xe3e5pjhnlhjlmpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmmgAKCRDj7w1vZxhR
xfufAP4geomUT/CABAy4IjXHboLJnyZ1AyZnrEyR6zywFYUbEQEAluMg1Kmmlm0Z
p3SEer9qlAqG9oDxLgMtg1vbNXq7rwM=
=Hkmh
-----END PGP SIGNATURE-----

--xe3e5pjhnlhjlmpa--
