Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5EB347489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhCXJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:26:31 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48477 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234683AbhCXJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:26:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 81748DC3;
        Wed, 24 Mar 2021 05:26:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 24 Mar 2021 05:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=P4q7qF5dCCPbIS/3VRCKQLTIbIJ
        3buWE4sA1uoPISZI=; b=ZaZKjNqJRoy+SSrfgVfURaf91p9lW4Dv6BfUJLa3x8F
        c7gFAxoh0znAjVts1nzewGu8nR9QmUJmV6H0rtIMpwaaQy2qUiDtnQSZGk/XYNHJ
        umXuvgaAwT5WSX/KbAEg5wvBLbwcvMNbREGVwpz6x8QUf1HiSl40GSK4eOVY4Vaq
        aQFIFnuc1rnE/fmjE1DNDsk0IQ6411JzqZLar2L1TanIbfe9Mrved1r+0r48w9O3
        iAvNoGIZ28+HzmYQWW0LCz5ZSaPlRC2r6x00StyuLimhGMclaHvHOzE8CVvTQ2Ly
        Tg/5mUP0lcbLuMYwwPuOvbriBC5ALmxUSw76+SqYV6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=P4q7qF
        5dCCPbIS/3VRCKQLTIbIJ3buWE4sA1uoPISZI=; b=paNN3VArDqwxJoN+hXtfli
        aIL1BMI4kJWxx5v4GHqyLgWhsh3EqWYP42LDBu15iARTf6KjqUTUsPN/q4/hAKrV
        FhtMoi3RXkRc02QIWjyNhZ5FKMFc4WaNnGf75Y9NHZjGWLq44As7VDJwwKgCopq6
        UKEglovVZNQRBLgreeUhoai/2y49y1fpyIrsKzkAIgH/fYfzkbtjPtlI6YTUbXsS
        ICYqXEyvJNfqOs9nfnd2/STdcbUPdGpVE1GihYHPYdqRQKmogjpDVI/uzW2QcJgo
        TQDb8HjYPDOSzYfY3HCjgFflqpaZ7hbr+08qPoAhv/Ynn8mR626/849XXFYdb2fQ
        ==
X-ME-Sender: <xms:rAVbYB73NAR4UlOJHAHhqjqhfJBfNr9MQjaYpXFWbe0dM9h4NmO4Cg>
    <xme:rAVbYO5HMHyBtcziALlcGCvj8ubzGpaa-3am9m2rB2KpkM_FbfjVoN2T0j3X04fp7
    QHS2CF8x8e0Q76ffew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rAVbYIfM9uvvdJF3XoSPOPpyUOBr_ZGle9KWmkxd-TnnR26fE7KhPQ>
    <xmx:rAVbYKLLLRfQfDzwsjiQEolbSAqxl5pDPhZJh4NoopNx7lrTR2nWYQ>
    <xmx:rAVbYFIED3W4UfHop2GNDccHksuhY0lpoRQvuj8z0ibtA_8SEx2xIw>
    <xmx:rQVbYCFF9c3dgVD_bLTwUwHPyvu0bQJUGP2no1H0xhdzPLu9I3rk-A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA97F1080057;
        Wed, 24 Mar 2021 05:26:03 -0400 (EDT)
Date:   Wed, 24 Mar 2021 10:25:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] ARM: dts: sun8i: h3: beelink-x2: Add power button
Message-ID: <20210324092556.v6l24ngivbfbyps4@gilmour>
References: <20210323204341.28825-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n37s7tbra4tzbnob"
Content-Disposition: inline
In-Reply-To: <20210323204341.28825-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n37s7tbra4tzbnob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Mar 23, 2021 at 09:43:41PM +0100, Jernej Skrabec wrote:
> Beelink X2 has power button. Add node for it.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks

Maxime

--n37s7tbra4tzbnob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFsFpAAKCRDj7w1vZxhR
xZAPAP9Y5tuntDyZ0QMr1HSksHFRXlL5FXAYQUJUelJBnk/NGwD/Zj3OUBcqb+jr
JH/EEzZI9+7NxjRmjqjxPxNh0Mw49wA=
=rZw1
-----END PGP SIGNATURE-----

--n37s7tbra4tzbnob--
