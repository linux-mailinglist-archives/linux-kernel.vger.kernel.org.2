Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDE32A3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382553AbhCBJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:48 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52643 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837986AbhCBJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:17:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F1525C00D0;
        Tue,  2 Mar 2021 04:16:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Mar 2021 04:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=8Qsy7Meg0hACls6ymvjBD7Va/wH
        qIHlIHDh6TppONGg=; b=IOl6bdVEvD++MdsXyrjzlex4cxcOmVlNXMpIvh3NtXK
        RWnpPF07gZ8hz8vrYHqaEmnHIOJnHOtQyw5NPJAXls6UDWRvYfRtSsCHlntQR5ZZ
        BdvNlQA9QoI8tbuLdJZnYmbypi2lP1ivUAm7uJ+jG4/S2uUW3Ojx4tssdvBN4ypb
        l+HhrnHiSsAQWAbzHiKRMWcrI6oYJZzam0zSOBMZ9psaPF1TcvERQyz+S1fKEI0H
        CZFDHV3GbUTB3E2crMKyGpmnYWiqq11gHzfDAqRk33+NOhNnOl74T8oR27Ca6V7p
        HtjnTCgzJfbg1APK8dA0iPCPi1eOV0BJ8m7u6QZxO6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8Qsy7M
        eg0hACls6ymvjBD7Va/wHqIHlIHDh6TppONGg=; b=WdOIrS/5rSbDnJ0OzW6r3T
        CtLhaSWPzIxM7ocU6TayZ2r9t54/GKeTP+HVgnulGdtwLnwvLPrD2LMmLk19VVMm
        NuvybqxMlSRxSejljTMgeo29yXvR3iUHdqHRbl/FpWC+3wifv94nJHcC3Vxl4Z2b
        kR0z3Wyu6bbktQS6aow+wVxqEQ8VbhB7/1Vd/oODJJRfoiQHBmZISXeIZNGr+w0z
        1UUM9jR9WPpXT3JnY142VH8UiogLMJqRV9Ny/mRHbta88mDfxk0aCLed5a/5tvxT
        cmwCXuhvyMBKZMMZTpYd8nDSZjWT+oiAmfj46TMzzBCGQCWLbFMDQf33eldOqj0Q
        ==
X-ME-Sender: <xms:VwI-YD-KpGKhSKs5eTUm3QV1HwdZxNiER_FOGADDmFlzeV6kkuMCAA>
    <xme:VwI-YPuSTTAqlTwGAbUrXyyvbtd6QmmXw_xyIH9401arB7RxPmp-0B_B2WezDuAf3
    Cmpvk7uj5N7D8lP6gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddttddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfeggfehkeevjedttdfhhffggeeltdfgueejtddvgedtudekuedukeduhfdu
    uedtnecuffhomhgrihhnpeduvddrihhtnecukfhppeeltddrkeelrdeikedrjeeinecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgv
    segtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VwI-YBBv2WPPWTHHK9pn9bqRM6yRe6RKWM7ylCOWb7orVEVXsDSoIg>
    <xmx:VwI-YPcVAGUzMH55JWEl6KbygiQtYddwsbrBjBCRr8Jr-KHqOYHe8A>
    <xmx:VwI-YIMIvcJFm9M4AeiprdgA_ck1DydOTPgrbbCfczAPQCtaUfPfvg>
    <xmx:VwI-YNqdkUtK6ZwDH15XhsAEZu2HiPYYqICe4xyRNQ9056qml2YD0w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14B9B24005E;
        Tue,  2 Mar 2021 04:16:06 -0500 (EST)
Date:   Tue, 2 Mar 2021 10:16:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Switch to macros for RSB
 clock/reset indices
Message-ID: <20210302091605.6shce4tb4kxab3bk@gilmour>
References: <20210301162309.1225-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q7xlweowtzwnpyjf"
Content-Disposition: inline
In-Reply-To: <20210301162309.1225-1-wens@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q7xlweowtzwnpyjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 02, 2021 at 12:23:09AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The macros for the clock and reset indices for the RSB hardware block
> were replaced with raw numbers when the RSB controller node was added.
> This was done to avoid cross-tree dependencies.
>=20
> Now that both the clk and DT changes have been merged, we can switch
> back to using the macros.
>=20
> Fixes: aaad900757a6 ("arm64: dts: allwinner: h6: Add RSB controller node")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>=20
> Small patch split out from the H6 RSB clock support patch.
> This should be merged for v5.12.

It's not really a fix but something we can live with, so I've merged it
to sunxi/dt-for-5.13

Thanks!
Maxime

--q7xlweowtzwnpyjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYD4CVQAKCRDj7w1vZxhR
xTydAP4tmEtCuD9ut84AJ9ej7MqOIgWiJSffOME+dts7ojyfOQEAzQ1xZt7spSYY
z8e8QndzQ1HcGGFIvPKfCOyRBCEgQA0=
=Kf9+
-----END PGP SIGNATURE-----

--q7xlweowtzwnpyjf--
