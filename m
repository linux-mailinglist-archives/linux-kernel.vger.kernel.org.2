Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAD3FFC44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbhICItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:49:55 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56657 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234817AbhICItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:49:52 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 109CB320084E;
        Fri,  3 Sep 2021 04:48:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Sep 2021 04:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hQ1nmr8FqIrbd7jINZ288GcuT/J
        36KiVUNQgsJszPMw=; b=PHjrllx4NVqgM8Jlnh9b8LbrI0yOGsmdFY0e5PFVTT3
        xUsPT1ETrtPdT/QDWMp6ZbK73MmjO47tLT5xtGMT7jGqGoskKxgtH466HHIacouO
        9jT6o3LLkPN9B2Yj661uqlTldpwJBUNqxdFGRo7/wZwVw330zcT65bNGKkfPgiDy
        ZK/dYL5vbc09dW4nvw6/ZMGsmo8toerRGlmwBuTnAACXywn2DH8Ew7NdQDHs6x5F
        uHp3Ym9pC/2XPTYU3eRDNcIZEhgJ+u3VIMoZZ2vLCjyyUXJ+2oYQBgjEYKH1XY8e
        fDJIpSFbsBjQizTXxWachS27+jdp5TmI11hEHtwkYew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hQ1nmr
        8FqIrbd7jINZ288GcuT/J36KiVUNQgsJszPMw=; b=iRffeU5WL7OKLXbVkxkq9F
        i9NH4i8SlvY7ZMQW/T3X6u+b5G6ewerWIdW+5/D2MDJSPvQGbvIbj7z4VoamWltr
        Y/Je+0DGvCJSHsoTBXusokpS9rht9USjmdPTrod6t5Xr9Fw9JD/C3vRoqV0uw2Gi
        gVgUoHtT6QhyZAP+nAsqybmzKHY7MsJJc8UIgl3kY2Dqc5lV5zIuDSSX3ylit4Gv
        cH3kL6SaAemZiXvYlHvvoN3xGNTMdQU6RdPXKSfFx5fBSsK1ASxz00t3m1g84d+x
        +y+MokPoooBO+mqf6G2HCDWTU/gLFUrcraIL8W53kzMasUx3+x8iAY0t62+LUTQg
        ==
X-ME-Sender: <xms:b-ExYbnOD5s0DvCXfIGa3YrbEqtOmv_paincGAhXmhAA4F7WCES9cA>
    <xme:b-ExYe1W94F4Eq9mMLgR6cVQJinS4OxF6VPztlacPSMZriObGD1fvH03WsAXeBXeq
    u_uptTaH6RCTjjYqEw>
X-ME-Received: <xmr:b-ExYRpJRS7EqtiCYSnl64N_Kds4KagIwJChAfwKS1SwC5F8xEfaolhl7Q40RhviFmb33KPv4lXmlozjiSmIqW0Xs3Fg9BiWlYg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:b-ExYTnoCChahLwAj2Lgdv9J3ocYOSTJYYCpf9a487cwGLk1G6ipcg>
    <xmx:b-ExYZ3aPcvwkoZ_lcNLrxrwqyooUE2E5l4z_O510hfrDdWln69nOw>
    <xmx:b-ExYSu_YUsx04U4wuGZtercfDzNSGFUf1Nzu4AgMJTdqXt5ztK3lg>
    <xmx:cOExYWl2SCSMyPs5l0CR5IQAXvpHd00HgSLGWZreHgU3pLGUoSrS4A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 04:48:46 -0400 (EDT)
Date:   Fri, 3 Sep 2021 10:48:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: mux: Remove unused 'reg' field
Message-ID: <20210903084844.fizlsjnfne3kcwz2@gilmour>
References: <20210902230336.29745-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7hw5q2u25hewzka"
Content-Disposition: inline
In-Reply-To: <20210902230336.29745-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7hw5q2u25hewzka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 06:03:36PM -0500, Samuel Holland wrote:
> The driver uses 'reg' from 'struct ccu_common' everywhere, so this
> duplicate field is unused and unnecessary. Remove it.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks
Maxime

--d7hw5q2u25hewzka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHhbAAKCRDj7w1vZxhR
xU8xAP0UchnkM21a+7FRcDf8V3tLLjiXwA9OuhHwustIVgcqcwEAoHWky7HFXUTg
HXNooCq6avRrPF51PXqr90oqtOOTkgA=
=h0s4
-----END PGP SIGNATURE-----

--d7hw5q2u25hewzka--
