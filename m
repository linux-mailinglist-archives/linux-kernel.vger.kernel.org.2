Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC538E5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhEXL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:59:20 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44701 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232110AbhEXL7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:59:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 72FDE5C0054;
        Mon, 24 May 2021 07:57:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 May 2021 07:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=B529eywUmsR9JY3AcBFsjJlGcRP
        HY45DQE7bzyzTCZE=; b=Gvo1WFDSk4JVECXX4xz0uR4964zfHSzzK+CPdWJ/9rp
        KNJgy8jEttsQConKjtmfTjNYN97e2IZ6sWkVMuuJuxeoJvMxLmne7pAlYaW+61XD
        TdsOq4DcQBVN/iFqNS2vQZ/xhlIXJAOr+l+EeJEeJyja82xFtKL2EcAThz//4vcY
        D1CTahLU/Ix7CX58gudibB/otx4naGtErahE8sQOzvtoIfKSu1YuOGrzsggHmLh1
        OQCU4dZFYsEMLSnQvdBAXZY8Vd+F/mgSMmrKLzPoWpOEZZ4FKv0vRAiR44T0ublH
        nTxFDLMJw2GN/KsHkMNeg4qG+zHyy19Sz8dvYfrBKcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=B529ey
        wUmsR9JY3AcBFsjJlGcRPHY45DQE7bzyzTCZE=; b=r9YY7HYEPhLJGKReZe8hqK
        6jaGqem1mqRyycpkyf8tv5RcDvbePNPXqebSuhb5G4sv7xdkW16rltqGuFOuSSOX
        ljCYwnIGQns3LbAlUHXpu9FwCyvHbOpKnaNJLC3t7GPGfwqKSX2E0ycR+gMRYY5M
        JFT7IEYFOr4VroQ8y4itji22occbG6dT3GTlsHHX23PfiCJYeLUTJwpKTEDmSQCk
        dM0zpMe+/uV18VK7J+ttCnFda4fV6W0kCIs7VJvlLWwlra7LvZBPas8ix70cX1ZY
        GibV5IixRj99tctnpOOTjQDpRVu2/1QnNcC31stEEbsLYl6hCm7YrezynwgxjZyg
        ==
X-ME-Sender: <xms:vJSrYCFltTNSWLEvXZpuoWBQtcyumqjnUZ61_RNjr1ia5kalxCEUQg>
    <xme:vJSrYDXReR2553hORjr7sj2zXlIVOTxv4gSzYWaJS7HkAkzYkG8_JVy0IEZAdKxmR
    2N95483tIocx7ASmA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vJSrYMIJEMlx79njkJiInd1DWyP9iHRjIR7KLxSHy_D9wz5P4uLrXw>
    <xmx:vJSrYMHfU4RGHfiu8TubRjC8oQr_E7BIIHBDIBi4SEiyQhwCZ7Gyeg>
    <xmx:vJSrYIVv7ZLHrOaCKIjeIsAC_fM2Uv4f0HyAxtW-cfqoaUg9JtpCQQ>
    <xmx:vpSrYKJUOmr7bQKgO52pbx5mHWAQNDVxJjmXD06g8LbNAI8GcaPO2A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 07:57:48 -0400 (EDT)
Date:   Mon, 24 May 2021 13:57:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: v3s: fix incorrect postdivider on
 pll-audio
Message-ID: <20210524115747.2vv3kigu7wcrgpmj@gilmour>
References: <20210513131315.2059451-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3klzeylg2lfcluf4"
Content-Disposition: inline
In-Reply-To: <20210513131315.2059451-1-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3klzeylg2lfcluf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2021 at 03:13:15PM +0200, Tobias Schramm wrote:
> Commit 46060be6d840 ("clk: sunxi-ng: v3s: use sigma-delta modulation for =
audio-pll")
> changed the audio pll on the Allwinner V3s and V3 SoCs to use
> sigma-delta modulation. In the process the declaration of fixed postdivid=
er
> providing "pll-audio" was adjusted to provide the desired clock rates from
> the now sigma-delta modulated pll.
> However, while the divider used for calculations by the clock framework
> was adjusted the actual divider programmed into the hardware in
> sun8i_v3_v3s_ccu_init was left at "divide by four". This broke the
> "pll-audio" clock, now only providing quater the expected clock rate.
> It would in general be desirable to program the postdivider for
> "pll-audio" to four, such that a broader range of frequencies were
> available on the pll outputs. But the clock for the integrated codec
> "ac-dig" does not feature a mux that allows to select from all pll outputs
> as it is just a simple clock gate connected to "pll-audio". Thus we need
> to set the postdivider to one to be able to provide the 22.5792MHz and
> 24.576MHz rates required by the internal sun4i codec.
>=20
> This patches fixes the incorrect clock rate by forcing the postdivider to
> one in sun8i_v3_v3s_ccu_init.
>=20
> Fixes: 46060be6d840 ("clk: sunxi-ng: v3s: use sigma-delta modulation for =
audio-pll")
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied, thanks
Maxime

--3klzeylg2lfcluf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKuUuwAKCRDj7w1vZxhR
xfLuAQDbALcSH3I9sN3aT7SM2BKzG79hN9v5u7zkilw8NofhGAEA1n9Sx3Vp0Z4M
/DY6a26+9XAGkK7BByoqG2qVMCw7RQQ=
=CHIg
-----END PGP SIGNATURE-----

--3klzeylg2lfcluf4--
