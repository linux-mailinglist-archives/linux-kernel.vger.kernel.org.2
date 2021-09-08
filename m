Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4735403565
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbhIHHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:31:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58203 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349904AbhIHHaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:30:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 885D55C0167;
        Wed,  8 Sep 2021 03:29:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 03:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=j8T8zyxGJ67HYo8jgH8U4+I+GHR
        kCE9Z97zCoaAvk44=; b=sLaV3/undnCOnTd64AGWSbF0jqRSRVPGyBt3Ay+qH7K
        FxLGjzu4CtaUQsu317w8EHrXXzITzPHJGTH8exUv/I4dEDs7GPS8pTmRR891tTcg
        OyfviDyNvFrI65ftuFmW9gt+1dzvKbJgJCbWWGShx0zU565/FedSi47oMk03qT2R
        UaU+ZS/7MjAuZYdPw+cbv6tkpz3hDu6mMY9l5kq3atC1kKtUCIqKV9FqLXvRFfiy
        fUE/x0kerS4brJwEq14wdOEN20euDNh0jMJKO7h1f0J557y2HF0OLx5gn5lNZsha
        aZ9KYiv9X1Bio6TPUj9o4/bzcncMEzXNs1llEPL52lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=j8T8zy
        xGJ67HYo8jgH8U4+I+GHRkCE9Z97zCoaAvk44=; b=srBNI9FjUS4OUpgZR7aSzQ
        ndh/mwyEtBRrHiH3oUZD4dBenMi1er2/MHrngWYrDEUXek0kzRtqxX/b0y5pOktT
        YiP+MMHZaB2u4BI+rPkLGwRtP9NTT5KDz4vJK6eyYBjLvk8LT8BT4IKN69uR6g6D
        J36/W/UFXKIp37jg0K1P65mMc4tkg4ENC3tBPwZHkePJU1Wmr3yYowWbqT1ez2gA
        /jSTeJHPPhA3Hb/jHU1Kbp/pUfZtCKtlbjpRkxDOJ7xkK7h7QMj7IUiR6Ewatfya
        5Tj2Q3fHUe7qREnWZziYALFNtvIanE//N4mvfKRx5CGK1BeBd92vMTmiVPA5YkPw
        ==
X-ME-Sender: <xms:aGY4YXFdfeRKsA32kfFodVtKpxto1Hbb9_uokmtoyJZD12XKbryFmw>
    <xme:aGY4YUVrdlWtERifpQ3V-Id_VM7rYAEEWGQmf2C2rrriPXaRe9T-F9DuoAl5wNUoR
    vbDQobnlWQwdsfdyCA>
X-ME-Received: <xmr:aGY4YZICyHiK3wLPJrOIEx3l_AjdwUaYW5xvilkp_zZ-ELhw43DHnCywx5bri4jEGDjn59Yu__Rjna0smWMVTMSfV3pkxSE10D6S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aGY4YVGw817OUbU3gC2tWwDitu0sGjJwxLAnO4HBlHsvZzD72XQBJA>
    <xmx:aGY4YdWcGmO_2v-CHu5_Ijt0RS9Jt56tXcHEmJmIooQn7oZIKICFuw>
    <xmx:aGY4YQPBfuaVX-wHjKL_PcKnHDnbf4FLWaRzOnZXP31kByxJJGM3yg>
    <xmx:aGY4YcFQlQ09DwSewt1bRFLX0HH0yeJwkyGZpHgUyBqBH4TkjiAm6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:29:44 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:29:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun9i-a80-de: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908072943.wbgvia4a4u5fq5kz@gilmour>
References: <20210907085243.4866-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pi62vkko2paw5evj"
Content-Disposition: inline
In-Reply-To: <20210907085243.4866-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pi62vkko2paw5evj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:42PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--pi62vkko2paw5evj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmZwAKCRDj7w1vZxhR
xS4DAP9US70dJSzK5vX7pGLkOYSB5V6+340Or5foPEKHqHnWIAD9GlD06/FR4Grq
u3spB4CwXhe3+OZXKloOb5hP+cBlDgs=
=17kb
-----END PGP SIGNATURE-----

--pi62vkko2paw5evj--
