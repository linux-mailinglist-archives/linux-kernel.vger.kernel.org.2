Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6E3EFF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhHRIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:48:54 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45209 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHRIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:48:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8CD6D580BCE;
        Wed, 18 Aug 2021 04:48:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 04:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=q5aiMNUsvcwejae1CULZltp8bI9
        VvSQAaLTv7MkoeRY=; b=DWjeRcMOEnrkLwg5LkCT2Yr4IPIjMZaJLDyNtGDM9O0
        dLxKkrF2guAvrO7rqqvoRKOBfmbiR6hqphl62Vly1oMOY2Eb0K/4fw/p0PG+qDD2
        T2qFWxHSnj1zN31MswTtwFmysVRvohwoqeKKoPr8Vy8B7jqM7UYh2tnB2JFJo6qv
        nahLj29dYkwp2ntFAZ4aSYXzjw9b2fyOka1lYZEOyQZWB+qb/+eirzR1NYFmafTm
        eYoM9EZZQNEXlryTAHrdhYrGjW6zCNtaEMDqO+pHc2Pg34fsjtGYd+DX7sE/rLkm
        9ofpZ5krE4DhdpEJYl5eYMoZaCxKY109684XfyaYLnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q5aiMN
        Usvcwejae1CULZltp8bI9VvSQAaLTv7MkoeRY=; b=A/Rkmb6RxESPpbMUgKSrY8
        N5suP1Lv/WP4kfo07bJ+MS7pWfS6LRafmgYfAIgFe9bFULZzgneFyZO3kJqfc5tA
        s6zAxbzzyMcP98cYFcVxEq5JDi1wEmeJSEEeK+iKNW7n1BCtLU6kkTa0BHQeH/Im
        7xPH+Ejodo1cJJajulFdFKz5O+wpfowaiAwDmylBtCzfar7OS6kF5dQGJQDq7l2X
        vTPlFm5lSVz0Vp3hVrqNKxTHVLl9/Wq9pEYpLP3iz5UczguwJK4Y6rmoMFEc5Aso
        +BkedQ2Uh2/9ayVxwvSJHQpQ6CkN15fYGFT3Jiim5bG1FJyc8Gd4WAN3LrFihDTg
        ==
X-ME-Sender: <xms:UMkcYQvFFIkVhdvoGz0w1KCP1J4feSA0__tqRmWdkcCUxU1GyoF2Ew>
    <xme:UMkcYdfj-X7LXTgO3hlwIlXuK2vDnNans54xi0vzlBfrlTMeBGN4_8_xMzYRSsrXu
    bRUAIYfPlm8_9cYx0w>
X-ME-Received: <xmr:UMkcYbyErQZZWeJ4SjUvw2BwFr7F_Z8wcxA_px7OBexxqvzBvlWw5NT750aBwf1PHf3_iGfcq21hKtnO4sUPHGUwlq58NRrs79lG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UMkcYTPYVWcYnM3pUisrXQ8nfT3ibStSfHyTckJ_34RQ8JLFA1K-0Q>
    <xmx:UMkcYQ-kEuVxkl712nSXT4Kim1KpLFhsIGKt_T5ToFAX39QLPEsJQQ>
    <xmx:UMkcYbXwDwmt0dz2vh_BINugs6U2rsP_cARXjAnYD1isvhq0viPWsg>
    <xmx:UskcYbWah52WhmimVxaCti65KxJ5MGpyQ_bN2fqahRjtR8OCzFoDug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:48:16 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:48:15 +0200
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
Subject: Re: [PATCH 06/17] dt-bindings: pinctrl: document Allwinner R329 PIO
 and R-PIO
Message-ID: <20210818084815.o4gnstf2jjxhfq7n@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-7-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftnv6qst5sveii6t"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-7-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftnv6qst5sveii6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:01PM +0800, Icenowy Zheng wrote:
> Allwinner R329 have two pin controllers similar to previous Allwinner
> SoCs, PIO and R-PIO.
>=20
> Add compatible strings for them.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--ftnv6qst5sveii6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzJTgAKCRDj7w1vZxhR
xTr5APwOQljWDmxpezgj3Oriblsb46XZrgUtclHXoxLix/b14gEApLK9IrqPtvzc
2EYrLrfQyR/1BeRVtLyd83TOuyOz1wU=
=qb08
-----END PGP SIGNATURE-----

--ftnv6qst5sveii6t--
