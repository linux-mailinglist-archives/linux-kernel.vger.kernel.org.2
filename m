Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF83EFF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhHRIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:53:36 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40537 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhHRIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:53:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 78424580B7E;
        Wed, 18 Aug 2021 04:53:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 04:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hUJVt56LeH6CO/Ss0tzAR6FmDaW
        a16mjlZgsEEsdqPE=; b=pYT9qKre/I8UORqTDPdRqiZAvR0s0+Zf/e4KXNXARXC
        Dltx7WKmLFvzXVJyyBcwamLjxN8KPv9E8Mf5hEPcYTmALdmjffHTknk7pdi8oEhI
        ro01jWOnAwrbFX56ca682OM/n6/BOxNTYd+pmyBEZ9vfj+d/Uu0uje3G8sEhSWX2
        +EgpFkHyFuzDAv7HO1JezhsShBkdw8z+gYhymH8SoSCpze/hm7Lg+L9QHOrXClAr
        ofAiXjs+4c9XgddaugKmldpMcsZYN7RjDhggxsOHq2PhqkS0ZQTVRBSgQz3JARiL
        Vh8GcexmAuu3bV9ZdwBh0me53dXH82f4UVAUkNCe1RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hUJVt5
        6LeH6CO/Ss0tzAR6FmDaWa16mjlZgsEEsdqPE=; b=LmfS3yO2lH2slpO0GTxI+g
        4zbx366vsWUtjixVyYHf6sly6syh3oIVawncgew3fOMJQW+D13CmO+tWkmMEMCbE
        QPN3W9PyHucSV7M/ep7KAnKGWxAaFtlajaMmSRAuZH4y2XZXVAwbywRxpEU979d1
        gG8hwyuEIyh9WlPIZANfQBC1DLQYByxkscHnZTXMSAMiF4oleUkOkLIHG/HDhNRT
        BxkPN/7ebOtAq9nLgLt+kIxPkXSM1OyQiLYirzudMJVZpXdyqbFhjWkwvGvGMgil
        b6Q5crwDFuslCoZUZTPrlPlAkkbX2vb1/FI0K8cm7EBtR/ylJV5WIxmEhSemZhiA
        ==
X-ME-Sender: <xms:asocYdQqtqgtk8UoEZRs-1VZtnwkIbujyOvucpMoqW3f9wBhuxaPpg>
    <xme:asocYWzQcBsT2wWE9H2bu4HYAQV_TNJa6tC29BtLjnfQ8P1RXVr2lfecvMg3rPZ5v
    1iU-_P2Um0hVrm_QXI>
X-ME-Received: <xmr:asocYS0eOs2A317OTKjmTiv3UVcikHi3R6F1DAMtr7npsF4OtELoPJf36jb8Wad5o1iNcgvUW37kyRkFb1_y6mD1h7hdQrE4QNe5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:asocYVCzOrXCRlDmBHAOE9REI2pcCIg0M5Jo7Un3_bbufkW7aERkrg>
    <xmx:asocYWj9G9HUdMRO7Uq-X-jw1Pf6Qa-is2BYX6DmszuIo_LQZeNlvA>
    <xmx:asocYZrxXHtO2Y97AfvnyY8GN81TRs7nqPbuTOzQm6Y2KSeXCJHBSg>
    <xmx:bMocYdqe2oTBkWjibi3sw_6qWLwM11CzMgv37jTLSXc9XJqXno0ivQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:52:58 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:52:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] pinctrl: sunxi: add support for R329 R-PIO pin
 controller
Message-ID: <20210818085256.p5m5zwri6jfkgihy@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-9-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y3qmd24y6c6k2nk5"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-9-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3qmd24y6c6k2nk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:03PM +0800, Icenowy Zheng wrote:
> Allwinner R320 SoC has a pin controller in the CPUS power domain.
>=20
> Add support for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--y3qmd24y6c6k2nk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzKaAAKCRDj7w1vZxhR
xeb7AQCdPHQNxn+5UZz7+HuzV1Nz6N9y2L/WWbaPRQKiJ3QoBgEAo/E4qRSjVikO
4Wi5L4ItXDMDwWnCI0H4yfl/iXK9XwI=
=5Twl
-----END PGP SIGNATURE-----

--y3qmd24y6c6k2nk5--
