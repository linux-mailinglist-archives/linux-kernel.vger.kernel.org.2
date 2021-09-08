Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A740356D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbhIHHbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:31:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35249 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350259AbhIHHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 131865C00DD;
        Wed,  8 Sep 2021 03:30:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Sep 2021 03:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jwdgZhf5It+S+2opARN1plsCRwq
        5Run15TxdyfWbJ1g=; b=bByvrZbx8ZfxJRV+eUHRfkc5pNr/isPK0C/G8BOabuH
        9ff9VStumrA8InKQX7X5JgzXpzgCG5tLSm+eyDSj+fTRSM8j7YtSNQCeiar7ZzKI
        FRORsQx5tgXZ/K6LSiYv8smlh8mjxmG03c7y5KySKX5PdzTWQLfylaLCIRHCelNm
        0cpV2aXcpaL5JgjAYx3rUgpFNaSu8f76sy/P20TqdE332IZZa4JzH/xSAzzcVd03
        l3/CRLPbnOoaS7gnSHIV6MMiLSn5EhAii+fJZzDSJpnvi27jaHq2WTdLB6RYBdVX
        zENtHYBI2RypTDp1OCa0F4OoV8Xstvi8TAxN1cNbqDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jwdgZh
        f5It+S+2opARN1plsCRwq5Run15TxdyfWbJ1g=; b=HqQgBMIKesPkWjPpNnZWCz
        pwZh9+Y2HwHUnq5hSKNeAv2PWo4CRxJdqJsLIgGWF695HgKKD7Pmb/3dYs4HkotR
        SenzxP+nEMSz8uuNSf0gUZcEUfc3CjhQZGBK0zcNqqgA5t85R1OegM7icBVBHWMS
        WGXi55T0tB232mqEkKixoDVNdcikCfXXSM8G4oeXA3BvPleS13N8haZMYM5wljwQ
        wumn1+khfmiDXhNx7ALYiWcNCGqKA96DiTcns/3puWa2wUArLYZs5feLiBxzmbY4
        +1gCw/pjfhxAIDxCuyZLT1vKmCapdJ30+QKPtdqqa5ZzMYXCLmNvvk6yNgf92qVA
        ==
X-ME-Sender: <xms:hmY4YUt2XtjqvgGSy0HqqiP2iyvoM12ZXzDmZo490-5kVzRxGENDvw>
    <xme:hmY4YRfcmV3V7YBiodzjb-jZFFIR6Bk5yI-7AaATHYRuUFiYjrv2SIQY9efGeJH3z
    WT9mvp9l_PaJ06sTsI>
X-ME-Received: <xmr:hmY4Yfy30-RJIlygp2buA5rsmHMjSgLkPYk-MaY7bDtLGQ4xZDNsyT0BCUeL8hc4G3ABD1GTmyBfGRWJ5DAQ06ZA-AuU2tjQh2NF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hmY4YXMqpQ7xWFhzVF5K2MY-FHdvF1pl0Bq49ETsAh6q2C7wZKxj_w>
    <xmx:hmY4YU8pvrjoutBPUhXcpKUK2Eg6sWTjVCgje3qUe0SY2DvPcrnX_Q>
    <xmx:hmY4YfUsz5nkKqy7lLfQxgxuvb-caUN814YFz5UiC8V35o1doXvuMg>
    <xmx:h2Y4YROankTAaUaNhZKrtGXRYizE3TKPEflnu1NwQXs8K_L3o9p4QQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:14 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun8i-de2: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908073013.nruqviaxw53v2xzw@gilmour>
References: <20210907085221.4713-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zpbhe4qyitkuwgh"
Content-Disposition: inline
In-Reply-To: <20210907085221.4713-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zpbhe4qyitkuwgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:20PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--4zpbhe4qyitkuwgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmhQAKCRDj7w1vZxhR
xYjKAQD1g9JmdROiGicG/hxYoZFZMIQsK0GpZtMiwqqjT22I4gEAmX3mmrb1LuR4
VdSMTaLVapXSFYy9dUkuFzJOAQdL7Ak=
=KIau
-----END PGP SIGNATURE-----

--4zpbhe4qyitkuwgh--
