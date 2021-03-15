Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB133B0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCOLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:08:09 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38267 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhCOLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:07:47 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A834F580A1A;
        Mon, 15 Mar 2021 07:07:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Mar 2021 07:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ThO60sGRyq30t0HLAOO1zf9vnva
        YPWODtuOEx85W2No=; b=RRRuwzirG/7JjCsbczGkuq9bXkc+BAYvGcUzg+QTRaH
        2kPr4lZIm+IWhQ/taPvpLg/POxx5OBZp67ca9caPfR8ALyaU5Jq4cVpwAbltptwX
        RgHZh6RWjkFC1d4mvKaqR/9yzfQnVjKntQZyICqoWGBhEzeVNA7+I8xsqWsHM0gW
        vcqH/rQYKT/gzdb/p2MjPPEVytjmfwweVA1kOxPLU53wRDblBTwIE+uVQn9VH3Zi
        jdbx995QARiVwTqqUeBbXSiaQzgM7ov88T9+gKbQlmkksa6sxng9qDbZGpRy9Sim
        ZehUn1+5lCcVln26JO4+I4upHTXYU1gm1mwNkBf92QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ThO60s
        GRyq30t0HLAOO1zf9vnvaYPWODtuOEx85W2No=; b=Yeyx6xQKIudZz5mC11ll38
        CbQYPsCrBEeprui7Xg+9WyHrXrGCIzcJJSLIC3P0j4rfhl6LQ3POx4TtMDDwglZG
        pdLfQKiIrZGAPpsZHvh6xTl3eG9JotGE7dJXY7xILkhFXP5cEPMD3e0w8o+yYCfy
        5O/6FwtodRodf8iXkN5TwExjAJJydTHfhc86MTXzANKQgJsa2PvSo4Z2PicKDEFi
        sZ7m3nBE0A4XOJpsD0VH6VSVvbJgkVjiIc8ewgxRGAvC5ozvCdwk0wjqB1uhszuR
        j4qx6FBdLUNkqAGWpVtX/SCSnW6USxk+LQJ6Xxbv8MVIGiNalhIKPRmSz+Mw894g
        ==
X-ME-Sender: <xms:AUBPYJ7bG829zKIuWg-QA6ItsyPM3wbTBYlXdsZgcR-9grhVslqoxw>
    <xme:AUBPYG6Syh3K_uBXu2gMMqLIDs2PLU_u2qbgb8ozHHVruVFVitcmoJOBj-pOr0GVA
    -W9niBqgv2G6OcoUcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AUBPYAeFlwdBkwMtwFY8LXcXwXmVmpJ18zWNgU78LOSf_BdJp3Em6g>
    <xmx:AUBPYCJaX1ahU_-obaU0okNHPnlDg5EwJeNR958P59RY0LJZzgtVWw>
    <xmx:AUBPYNKwL0HWATfOSQUl4fAL_NaThiyp5YY6lZKrGAGwjrcC2S_x8Q>
    <xmx:AkBPYE-9XTvEtetF8f2fcBDugkinKf4CclPSiPJF1qAuGTu9t-WQ9Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDEFB1080067;
        Mon, 15 Mar 2021 07:07:44 -0400 (EDT)
Date:   Mon, 15 Mar 2021 12:07:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: timer: Add compatibles for sun50i timers
Message-ID: <20210315110742.6ul47e72v6yl6ydj@gilmour>
References: <20210315043250.45095-1-samuel@sholland.org>
 <20210315043250.45095-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pucgglng2x7rt7wq"
Content-Disposition: inline
In-Reply-To: <20210315043250.45095-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pucgglng2x7rt7wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 11:32:47PM -0500, Samuel Holland wrote:
> The sun50i SoCs contain timer blocks which are useful as broadcast
> clockevent sources. They each have 2 interrupts, matching the A23
> variant, so add the new compatible strings with the A23 compatible
> as a fallback.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--pucgglng2x7rt7wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE8//QAKCRDj7w1vZxhR
xW86AQCrK2MQndw/TUK6GbSqIPgqLwJsRk92qUz7tdL55sgumgD/ZLd8CWAgOgko
ld6FZaCSIUwMuq5fh7Z1STGksQNP2wM=
=OfmS
-----END PGP SIGNATURE-----

--pucgglng2x7rt7wq--
