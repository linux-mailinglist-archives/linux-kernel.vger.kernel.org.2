Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222B40355A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbhIHHaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:30:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55383 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347394AbhIHHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:30:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 13A525C00A9;
        Wed,  8 Sep 2021 03:28:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 08 Sep 2021 03:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UH/Fz+ngRvuAMDOLvef7SxJD8KQ
        e+wo5ukPSXQ4O0+8=; b=PD9RdzzNeHkgqQQTE/Iuearr2/sG2Hn1QBl4lYtW/UG
        ppitm/ht945tYG2EMhqV71i2gGhMxOshfgWiP21mVbb5omWBHdIUgHJSvjur8kwq
        qgqTyez9wvp/0vfv4SRdn22k0RRWKQ9NpIbi5hOuTzs3IhciD9faS2icI2/w1g5c
        h1OglWYv3NPer+bKBNB99KgdcPIrksbgYb6eSo/CArtWHjgEXQtJw1P5RFcR0FOw
        bd0An7XfCCwM26aSlPjGsq35ssu3LONtDA+MQUQ2yABJk8TAmnETaulcnn99a6Fa
        ZUk6JE6yrG3LBVlwxdZgqGR61cC19H/uRjZEsAeKf6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UH/Fz+
        ngRvuAMDOLvef7SxJD8KQe+wo5ukPSXQ4O0+8=; b=oadT05wDcUU6XWi1Pp2v2f
        WTpz7mrEw2hC7yySC0I9ISKsjhg2EkC0+DK0Gxjk57mSQfG0oVP2o0HOkr1vZLS8
        9sejBTW2BVMjfDvmMNUQY9ktvvDQWfz1GuquKT3YWrA9xsmKRqiaMwfY+b3xeBJk
        gqh6Ac6WgIXgQhxdN7pmtKGk2ADCV90e/9D+MAVgLSNXXFl/NXji2eEW6t307CCm
        XkxeLDc6fq1tJszBB66xtVjl2Y+O6sqlC59v7UloxZZJQzCXn1qam0kh0FrPM9M+
        dm7SaC41FmtPCa9bU9NCsbtqWZdT+UCh7PPjqw4pc2jMSK/T5oivq99Ir4Ra7jeA
        ==
X-ME-Sender: <xms:MmY4YUJ_CDY_z6kH89hnS376Haigb5nV4-xpcuVj1UL9kKYd6A06zA>
    <xme:MmY4YUKXwXjORLBnL5JnMj-WCLgNaareSAc_XT8dATkYg--rUApcfDR1E3adAjzcb
    9fZsG0G8MXqNtQ33w4>
X-ME-Received: <xmr:MmY4YUsLi_xaRhHFNHnTtgJGJT7ZcK0anOw53loLlOBRLhzZMFqDcjYN7HaWbGRp3IOK4-M4T4QomStuBKW5hHuRiYMFsvTO7aGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:MmY4YRadYCvBdhxgL3aH377b5GcW9KrjR2QywQgHP5CmBbaI05n5MQ>
    <xmx:MmY4YbZq0GXSamh02nhUavKwHGjwXgj-Sc1NhvMtQpBrt3xYkQ7xvQ>
    <xmx:MmY4YdCPS05JzwM6dnolPfzgT9kXTJr8p1snkHFPA-KlydHeJVhxIQ>
    <xmx:NGY4YZNcD6v0qVHFh88OZcSzsT0oaviyoez6IayfqM3OOWRCcE2oFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:28:50 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:28:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi: sun8i-apb0: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210908072848.tr6vfhiiweaem673@gilmour>
References: <20210907085319.5121-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d66oxfztvfrotapa"
Content-Disposition: inline
In-Reply-To: <20210907085319.5121-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d66oxfztvfrotapa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:53:19PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--d66oxfztvfrotapa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmMAAKCRDj7w1vZxhR
xRKnAQDRyjvUVOeAGal1aJPJBDkvJ8bGtMpBiDYIUSEbbZJAJQD7Bv0ILFEZyWdM
K7MYrdq0aIbshXKW/gX/PA4DN+z5HQc=
=07Vi
-----END PGP SIGNATURE-----

--d66oxfztvfrotapa--
