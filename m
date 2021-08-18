Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C33EFF88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhHRItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:49:46 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56807 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229703AbhHRIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:49:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E8D1580BD1;
        Wed, 18 Aug 2021 04:48:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Aug 2021 04:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=W4WryS7HHijg/d6xGj/1w29IrGV
        lpwWub58kCGVVnck=; b=NneQBjfOr2tJDSGNiDQqBJBOi9i/Idqhindv+lHbhtE
        4c57ganI8JBNr/djZ0T2DM97DAr9vJ6LzhaZCiqHPwUIsRIgu7PKJ2oQ7qu3arLQ
        IoRLPHaB1F/9ZpMiBWYS4JtWbNlMPZNVw9msG3jvPTw16QUUNDKPj8zrKPbao/fc
        QSqnz4iEWKG6mHbZIw3stHPLe4CelfA5ZuMh38lqKamSy0FNX+bhl95UYgxSCAq6
        GOzxXG8EtcRfeE/+iBTas+RwXmSAILA1QG6rDMpj/TqJth71+TEVhdY1Jx4FAHGl
        twIektkWH03FAWhPJWRdZ266kSpw35y8EaLlEnwYsLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=W4WryS
        7HHijg/d6xGj/1w29IrGVlpwWub58kCGVVnck=; b=UAbGQ6O3jyafNNeatU1HFu
        RsxvRdb0D2yTLyxp2y20HZQf0rk+/zi405Whe661SVo3YLH2F4Jrwh6LgZG3Zdti
        pR02P59fMgmbIXu8VpgYZTGFzd1R3cH2Fs/gKeLDPe72LUjFhx3gadEBz0Em9cOk
        o+Jj0CzsDSSGeHIANdEybGR3jrqJMCQzOLOlljC6yudaqeo0FqFNP7KHX3i1MWFU
        /hvCOVyIkkvh5IEsmmg6p4edzYycyDQavUsSOwy+FLFbRX/PLuLGVi8TObOuaI8J
        ud4hvOGjux+vHEknyg7BIs53MP/bzH2/uBpESFJYE64crg2y9cyoqlCRyIXq5H3Q
        ==
X-ME-Sender: <xms:d8kcYbCjuz1kIE_vl81vizUDDKp-D6HAXXwyG0xSJ_uBFfWTs_tl3g>
    <xme:d8kcYRjuKqxmAVFFYn51daBqNsWG4bBsM6buuf_uGbIVX86W3jn7jkVXNecs_oizA
    bqDZweWD_YPiLx91TE>
X-ME-Received: <xmr:d8kcYWlIsSVlAEL4aDBXOB0eBXBdCP0NaC_G-u3cVylfWI71BFAw0e_JWy9nctUuP-9bFCU2peFJ0t189CDILx8h3PB9qAFskzOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:d8kcYdyWOWcVb8din-VnRCOl8RQmlCtWBce172KE7WsbVJHzCEDLYA>
    <xmx:d8kcYQSoIsh2Ln921GhBK03zp5zvsT8zACXuD5q8J4OQAGA3--PpDQ>
    <xmx:d8kcYQa-SzZThmV6gBZtSWFP0TcMhpksR_DtWsXTrlUOrdy2dS7anw>
    <xmx:eskcYUZeBfqB0nm96YXwEBR4msCzgPrQ-k0tf_MfbL0ZZNb9BORX5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 04:48:55 -0400 (EDT)
Date:   Wed, 18 Aug 2021 10:48:54 +0200
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
Subject: Re: [PATCH 07/17] pinctrl: sunxi: add support for R329 CPUX pin
 controller
Message-ID: <20210818084854.4zo6u5heeamdg7kw@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-8-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dcvksnzz7qawnlnn"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-8-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dcvksnzz7qawnlnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:02PM +0800, Icenowy Zheng wrote:
> Allwinner R329 SoC has two pin controllers similar to ones on previous
> SoCs, one in CPUX power domain and another in CPUS.
>=20
> This patch adds support for the CPUX domain pin controller.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--dcvksnzz7qawnlnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzJdgAKCRDj7w1vZxhR
xTunAQCWVewXBg8PV0Obg3qYR7GDoK+QedPMi3CbY4w/8FG+9AD/VEHtEsWFakpV
o7XD8iEgs2xj9aBuGSlqjOCDGSu35QQ=
=2vtO
-----END PGP SIGNATURE-----

--dcvksnzz7qawnlnn--
