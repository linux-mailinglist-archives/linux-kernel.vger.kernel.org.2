Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4927E40355C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbhIHHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:30:18 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56799 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347394AbhIHHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:30:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E0365C00E6;
        Wed,  8 Sep 2021 03:29:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 08 Sep 2021 03:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3ahJ6BT1/uQqiZONi/NQFU1KGU9
        hLUGfEPlx4T84hJY=; b=D7IKfViY12XJborprifoFI28D9v4T5BgieT0aGGWBPO
        4DQkjtcW3FpX1vDrfGRIdTs8Bi7T70tfK4NV5qPVs3ZlY4AFCN1/IhwzeDtRRzvB
        52CMbgc3/Q1uesTZG8gj0iMHFMpm2BayWqogaPNkryXKGmC4DKdi5d9gMGizJhAR
        vQ9n3peCAxxWlIv4tW7cWn1Hl/31WmrKDwj2bDZroW92AzY8cvnas3w5bBdXuk8K
        5MYM95KvqxNwlr5gc4kweRy/LKGDqfiJWGd5QtvhniRrGYbkRxHwr/XonA1QrNKH
        QE8Sxjaz2C39w//B0aVBRvOf4NCwiJL2bMK2Jo6Molg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3ahJ6B
        T1/uQqiZONi/NQFU1KGU9hLUGfEPlx4T84hJY=; b=JjHnGUZ4SVY3ME5kS5F1Ih
        xL5vQO8R0eZ/w70PAVtEsfF4m+HaN+pSUfrdevF3OpUyjHUf0pwalhXGE79GdGU9
        xhFUVixub9uENtkqJKErxX8TLbi4EsaJVG7U6c8T7+XLYWDNR26PFpJXP9G9kiTw
        AUhftbTAlm0RLqKohn7oM3fqsAidAkFeNGAZ1tpEOgOCsdV1eoNU59gdaa4m5350
        DEIalDv6dspS6/Ho35sE50ZQ1cvgZ4ePy6WF8+TvuTOsnw9zd+8w/GmtTKoAWbjI
        5FdCyQtE3aa3ZFipcAVuQvaQGmFN3QCopw5FCOGprW6UG/653P+zHyU7o0SwlsSg
        ==
X-ME-Sender: <xms:QGY4YRz0_Ylwd884diqnDItaq1KUtWoNi1iqfY75_X-JJY5W3_mR9Q>
    <xme:QGY4YRQ0OIQ-RIK2XlWgAHVVKygcVwThLvFy0EN-Vg6mL0KzfS0thsYttGZxmZsq9
    kxDtJVn7qNzizKxcvI>
X-ME-Received: <xmr:QGY4YbV8iBzfpn87Up_kRs3aDqx0tqCtjAhhbj15ysgEuhkT8SnXNC5_VaXsjr03ntvQRtba4Lr8VfUz4zt6bsNph0r8JExEeGOr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QGY4YTgj5_dxk59c6CoeMW-NcBr_64-1hGiIL4zCAdKvpBhV9fiSfA>
    <xmx:QGY4YTAT8nr3VbYJxsog8dJZlk4wvaOUCHRfAztsZ_bTVU7d_fA8fw>
    <xmx:QGY4YcLndadtgGtM7vR51Ad9tpKtciMALy6SB2_cMP_I4ut2VR7rvQ>
    <xmx:QmY4YX38U-mzydom85LMUiZpLYFd17QoBTUBhMP3EXbMncwNYU7Q8g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:29:04 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:29:03 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi: sun6i-ar100: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210908072903.5ualhvekp7plsgyi@gilmour>
References: <20210907085312.5070-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmt6r27lbkvxlbiy"
Content-Disposition: inline
In-Reply-To: <20210907085312.5070-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmt6r27lbkvxlbiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:53:11PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--xmt6r27lbkvxlbiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmPwAKCRDj7w1vZxhR
xV5JAQDjwoIS4pHefvBxAb0St5hixNAjsBvfabv3v0X6WJSOeQD+JXy8L0vlTYKa
ArqSNiViPGeMBWS/7nz7vVSy9WxP7wQ=
=fJPc
-----END PGP SIGNATURE-----

--xmt6r27lbkvxlbiy--
