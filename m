Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B373FFCC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbhICJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:11:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39541 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242775AbhICJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:11:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5CD493200905;
        Fri,  3 Sep 2021 05:10:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Sep 2021 05:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ox+I/Ry1v/j82vqbJpoMct9xYn8
        vhfN0iM0y0R/9Wa4=; b=VPZfi/EnygXML/q/kpH7FBvJeu9/C5QPnKNHhEnomws
        sjlGDFlegXG2TQBPfh3/NkFuZEejkaktEnLBvFyIR87u9TZfRwSaeRegOlpFceNl
        32s6LfM0wCntk6l65wCuFaPC2pFDSyHwkDQfcSGxDxu926aIlEzW84UIh/SlTgFr
        O1L1zBdEIYAdgdXSUH1jBtsVLUfIEvYUYWhouQ1l7FGPvGmc/1BMSVTtBP886Srq
        oiGyPVcHldqDk00Jrer29EEnMjO+BoRm4wI4VQyE+NqCTf+a33T9mlbTt1TlS1Sq
        DD8/+Rt0ANQh7dwqIOUm371VtIbTeuC/GimUqh7zvHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ox+I/R
        y1v/j82vqbJpoMct9xYn8vhfN0iM0y0R/9Wa4=; b=bvloNvgKdH/DDTrAB9De1r
        wsZqy8CrKk8GNm/uTeL+27iyu48KHio0B6hJPz//np8BlZOElL1WhnLCpDk/ElWX
        toWwilmaA4ZWeWZp1vv/lQFL9cQ2nI92zToc47r45I//VN3zMsppUY9cEdFIw7tE
        snAJbIXsUKVJnva98ZQgE7qu0HzQC4CY6Zs6yGmXM9iEmNKd8S9ueVXZao5enLSq
        wVtHmk3lxmI7n5t1ppKrUYE7LOh3U/PG9tZm+/deVZIHUCNPlezp/opg0gCgg4iz
        w6ge/rJeWgazBjVkGpFBv7d4NhGOUHJANYyXPgDqnom/ehb7BHqSwJeaJFFF1iOA
        ==
X-ME-Sender: <xms:kuYxYUl_KGhbwWP-J-5LnK9wzo4Su2ZG5hknQWEGoOmQh-eASeYB6A>
    <xme:kuYxYT3k26iSM-BsPd7YFnKKLeWdwnipOIOxYg--H_qLAYOJNub3-sefFpoqQNxFa
    98V0ohjbpOOI7ONriM>
X-ME-Received: <xmr:kuYxYSpUS7qGPQrm5MmYCIKpzffgVz7p8T4OhYfy3MO9kQzIXTz5Dj-dvz4Bn_CNLoGkZ3jNLf9j0VW_Bo3JvGhDPsp2fsn0e-hH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kuYxYQn-S0dh-ztN8x2oKEFnP-1n1lKz2uTzbut5CN1lSmL2aCSV3Q>
    <xmx:kuYxYS0EJ9wWpOcRmqlWDB2RxYQUyWpNd21leJfnztL8SDfFi0gdvg>
    <xmx:kuYxYXvRvyoRaN-EaFPSNyZx9Z5T42DYLnxHbJbTPNuhWDV1SUpusA>
    <xmx:lOYxYbn3qtWt4Vq2Kyg0fgHeFk1imqyrjrbzRKGepwc7kc0HI9G4VA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 05:10:42 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:10:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Rename files to match Kconfig and
 drivers
Message-ID: <20210903091040.2bngsvhem2ftzhaz@gilmour>
References: <20210901050526.45673-1-samuel@sholland.org>
 <20210901050526.45673-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejwkc5wmabu555zl"
Content-Disposition: inline
In-Reply-To: <20210901050526.45673-5-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ejwkc5wmabu555zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 01, 2021 at 12:05:22AM -0500, Samuel Holland wrote:
> When the drivers are built as modules, the file name will become the
> module name. Rename the files so everything matches: the Kconfig symbol,
> the platform driver name (as seen in sysfs), and the module name.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

I'm not a big fan of big renames like this, it makes merging and
backporting patches harder in the long term.

I assume you did this to make the module autoloading work? If so, using
MODULE_ALIAS would be less intrusive

Maxime

--ejwkc5wmabu555zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHmkAAKCRDj7w1vZxhR
xf4xAP90rWbPp24J+BEJxdB2On7UfpvhIiYfWFYBbYKAlJfsRQD7B8nA9clu2f1u
JaR0qk9WskxjgGvi6R8jMVEelzBTsAg=
=sai4
-----END PGP SIGNATURE-----

--ejwkc5wmabu555zl--
