Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23063FFC5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbhICIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:54:14 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49477 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348459AbhICIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:54:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A8D5A3200927;
        Fri,  3 Sep 2021 04:53:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 03 Sep 2021 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=u/IKps32O3lSSQc9bt8YjhkoT6+
        nuErFJo1Os1aHNd0=; b=3m1JIbtbfNmOU94zNynH7Ao3U6w39BeK1KV3+JqnzaX
        q/AJtlN4YAxkYxz3mRmX198NByW96sAftq7rd4Bq/CQ/usVmSg8mXLTLdn6Zp6sc
        4d2mQ6PKo2PCMuekdo2pPuwbj18oF1/fDW8kghuzR/sAgdX9z1QHxrvero5ORGX1
        2zPhFmdOI4YnruoZW8FZdPHdvTGkPIo9JSAIZqQXM2wapsoXadsTJMlKti1z+0FP
        CQtAFYTX+YaoHw6gzABH8PShDexuC02Rl7rgNhI7qVdOyotyphLROJb+40Sn+s2y
        D+CmNJi8ReLjR4OeXggyC91Cxo/N6niUOaZVTHkFYXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u/IKps
        32O3lSSQc9bt8YjhkoT6+nuErFJo1Os1aHNd0=; b=NnHagq2ejnMxL/9GLSPzoi
        PYW0+dLNCTwDQN8KpN9rSgcU6ZtxwjdxY9hWfO1xqCGHLlkAqbt/WvkNJsfwbGUG
        FIVItC/AVRkhLgzkJ5t/TIaFhHXcdhpyhPEouY4vyO6f12dXINS+GawZTN7JWtiI
        LGO5dQaX0jMpIa9zeYClGdLVjclfogCNrTsqM0MTLTclUkUldoG+/Jc2rc+yaZ8t
        kcGcly4zGWrBvZ18JYOl/C9qTX1j0E4nHH5vZMc7DN7f5b9CSasqXVTkllZRRRMQ
        YWncTqKYWA8fPC4nOm0t8nZzgrwyd7gTD0FxbYGVrQEYkBspmN8ppmONa1qRBJyA
        ==
X-ME-Sender: <xms:cuIxYaLzpXzuEkoldT2UY_3gm5Wbz9jsDetGQq8yw8VaGP79O3IAyw>
    <xme:cuIxYSJk2oh9a22g4SNaxygxCZg0XO5kLj8_lfA1O9mWRGiiqKeVuOYINUgvSN3UH
    lLbbCFbbirTY6WpcRs>
X-ME-Received: <xmr:cuIxYauGqz281MxcptL_aWBrGfNZ5qGx2aD84aW7kFmkGvy5Ml663xV631V0mk7T5BjM0Lam-9HWgkqaty_MKjxaA3QK5rFWiUa3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cuIxYfZkjRH4bT-C0mY36JJ7GfJIgDetUb65pH0GQFHqDx__4toxaA>
    <xmx:cuIxYRbF9CQR5TCGit6W90VuqbR_OfvzHfHceX-CQuUhx335WVNxTQ>
    <xmx:cuIxYbBKeOp9kZ7jPnJ1xnVdBTxgsY74ghKy5TzPxY82lkGToEAy4A>
    <xmx:c-IxYd46DYYK22amSCzvZpxP1GVax7W0rEo61f3kwHrnoBjTZayJLA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 04:53:06 -0400 (EDT)
Date:   Fri, 3 Sep 2021 10:53:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: Add machine dependency to A83T CCU
Message-ID: <20210903085305.g5q2cijivnvy4jvz@gilmour>
References: <20210902230200.29574-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qgfp4yybpmblzjim"
Content-Disposition: inline
In-Reply-To: <20210902230200.29574-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qgfp4yybpmblzjim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 06:02:00PM -0500, Samuel Holland wrote:
> The CCUs for all other 32-bit SoCs have a dependency on a specific
> MACH_SUNxI symbol. This effectively hides these drivers when building
> an ARCH=3Darm64 kernel. However, the A83T CCU still shows up because it
> is missing this dependency. Let's add it for consistency.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks
Maxime

--qgfp4yybpmblzjim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHicQAKCRDj7w1vZxhR
xQuDAQCDW+JiMYF4GkNuyUdDcWcB959EY6pP5z5q7ImerlUJ7QEAgPRcNgMEYSqN
+yxQewQdA18/eZIu31NVrgXWk4UtOQ4=
=YI+y
-----END PGP SIGNATURE-----

--qgfp4yybpmblzjim--
