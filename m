Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9A232A3C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379069AbhCBJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42653 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837922AbhCBJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:12:14 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id F23BC5C00B0;
        Tue,  2 Mar 2021 04:11:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Mar 2021 04:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fxp8Q1ZobdKfv1l/FezgBYXf6NS
        F8GlosMSO26Vrskg=; b=lEIfGLugw+wra+8DkOmDr1cjDDkZj8/+0Xy2DhvFDWY
        9bbuaSAiU1h4uRInotU9TUd+d3mJiEyY4WbT3elvP/hZjp/FcWkJ0f2iJjl9bwRg
        8udsWnov36rM0WfqBg26wttID+r6YmYPQBn8Jujpl5a5Aw7+8p04qZRLAEvSI14Z
        Os2FPJWtu4IJfUGEdattORmSe2B04CLOGc4n8SxFD9OJw9yMcBWa49vGmaCz3jK3
        BrL3bd+Js32A9l1rJ2W5CXXNuKhGsJb1wycmxiUnCZ3lko83ddkdFHRfS+ijgKL6
        sFqlVBPJCXQ2lMDFY7slOiC8o4/ALiCxxACDhHR4F+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fxp8Q1
        ZobdKfv1l/FezgBYXf6NSF8GlosMSO26Vrskg=; b=qqyD3OiRd/dQPXvIDP36ti
        G5bV+wtEn9KVfXS+0lsM4MrtdKNYr5QXNS8S+vxfACYF6WH33KPuO7Gs6bC/dPFD
        bl0zNf/uJtVqeN/3UOZmQ0Dp/e6is+3rhemBz8S6UkMIfBTEQaEA+DTZH2WfuAeb
        +XgaTzx0d4ZQUT4kdmhBQjPpOWWbAAIhV1UEBoNNM+aIP3ICG7aRQqgAcnvAao2M
        OaX5sB6pKiH0xhsUZJuBIpTNDHOUWGu56C/VChoDT+tlaHxwq1iYQYEoXiDeWAUm
        ON/iC3VUU03m3+AQZhjv84vg6HdA3MzwvB2BzlLzgTimd/lfaVmaLXhNnc3lBlMA
        ==
X-ME-Sender: <xms:OgE-YJUkZf-Po6tAw_ZEc6Quv4D0vk9wrQsCUID6dBKJi0W9T1Qr-g>
    <xme:OgE-YLncbAh5l7oalT9TgYPxCyUul3wtVUGcmwFLQu_qkW6KXGjGoyvUNLL12knc3
    Ps6mkrWsMZe9tujrhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddttdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeguden
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OgE-YOyxqbWFesDNHTRdQSH5iOxSYC7IKdoTMW-2WlTvxaZ2SEo5Hw>
    <xmx:OgE-YOi-zx1zHO1twSSFTApPpA1j7nrVIq9HmrtMXK56rwtpL2ez8g>
    <xmx:OgE-YLWlg0YXaiQc7iY320HIjbwMzc2M2g2-Dg6V-2ykpFQXIaSf8w>
    <xmx:OwE-YGCCu7zkbOgGTQEtQPKmeLWSZMsj0U83cZuF4vhhKQnynvvaFg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D68A108005C;
        Tue,  2 Mar 2021 04:11:22 -0500 (EST)
Date:   Tue, 2 Mar 2021 10:11:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: sun8i: V3s/V3/S3: add dma controller node
Message-ID: <20210302091119.ckclp2ywjzaz4ivp@gilmour>
References: <20210226103028.729172-1-t.schramm@manjaro.org>
 <20210226103028.729172-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cmdqmnqtlsaxm5zb"
Content-Disposition: inline
In-Reply-To: <20210226103028.729172-2-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmdqmnqtlsaxm5zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 11:30:26AM +0100, Tobias Schramm wrote:
> The V3s, V3 and S3 SoCs have a dma controller. Add it to the dts.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied, thanks
Maxime

--cmdqmnqtlsaxm5zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYD4BNwAKCRDj7w1vZxhR
xRmEAQDLWf+LCieT+Xnugb19mCcR0hCl8gSeHeSCZJUg+rpADQEAzOrI2+L7svjN
MM4w6cNlbJYvSTb8/R43q1yfaarSsQ8=
=WjNb
-----END PGP SIGNATURE-----

--cmdqmnqtlsaxm5zb--
