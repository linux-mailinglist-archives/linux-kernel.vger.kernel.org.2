Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2231F8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBSMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:03:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:32939 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhBSMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:02:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6CE863E5;
        Fri, 19 Feb 2021 07:01:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 07:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=zO2+KACVCBF9wPIu/yH5KH2QXWS
        QL5/8EumXFIR8eo8=; b=LN63jKfwAVfkQhPkAmtvaCtkvElndUggyWlDn85P1+l
        Am7hTq5ErVfhIxbh/6rjeipmAWJCimTpOoveZcjlLeSieUkPJ7hzYd72C8/kP6mo
        5KCKycRxRHWUQ2UOdApkEfRJM65DJGyN7QAMBx/Sg4u02KsculdyaVuQw4zqVTZO
        O/rytldqLwsHyRtRggoJ/yhpnuTsEMl1W5LRiSzKZBtHZk+URIjGFQJAHeLlQQY7
        2KLpDhalEgBe2Hh4A2ObusuP+GMWOtV2J+iBKIdsK2i8bFDU025HvDEXy/yUj+e3
        gDortjNdut6uNB5dYz6eU1wIA17vjrS8OzPpBZuyC+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zO2+KA
        CVCBF9wPIu/yH5KH2QXWSQL5/8EumXFIR8eo8=; b=FTYfYQ8/8+88oq9ECKRWCq
        RFVnwCt99ZtOfsZMpiE/xg8DdBypsGfCaTIZTEBSNsTOtWOcWKS8oKumtBsl4IWw
        wugBSSycxlqwuzJSQhG7ZM8q70d6SAI9ly8wypF1bGnumWLKXEY6sYrkbhQEy9I3
        0r1+74PCeuCwCOEOIOyjtdlT+q0MLNxZ1p7ypcLN8cU0xDATHcK9QWo0qDNwggQk
        ie2JnXMdhNOqeupPLIC69CglsG5EiYgmARWzP51pAwxNqZsfE6r3QlI94xRqDNLX
        BWVDjjjlWq5Vsgct919vI6lKes8XPUbhgCoiXhbFeMAnszIgoDaydiTN4X0azjCQ
        ==
X-ME-Sender: <xms:lKgvYEdvgIXhs2p0j4b0XnoEABZfeFW51cyZdj_PRgQQssUX9GsUXw>
    <xme:lKgvYPKEGWeIrV4OPfwEXIR-XBWSq3A1PY12D23TctqXAvliooi5V1CPeQIITz63e
    5wRf6p4PYXatB7exWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lKgvYBFPoJTadOhRLZOploO2qxizfkxuk5ulJ4oJWgI56tpeJTamvA>
    <xmx:lKgvYKAxaOi581VsH_ynDaUj7XdaOC2qk-oiP9QoTK_AsxJbuqnieA>
    <xmx:lKgvYM87Nlle8X6aN8fMqeQ8X-Hg9WRe5zRSbTvOA6cxiZmONV4oyw>
    <xmx:l6gvYPkcOyBDFmWcA1QplWZ8ePSM7t6K4Ep5gF88iXIymQVkjIIpGg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE1501080057;
        Fri, 19 Feb 2021 07:01:24 -0500 (EST)
Date:   Fri, 19 Feb 2021 13:01:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 1/1] clk: sunxi-ng: v3s: use sigma-delta modulation
 for audio-pll
Message-ID: <20210219120123.4q5m27byxylpsrtb@gilmour>
References: <20210218112001.479018-1-t.schramm@manjaro.org>
 <20210218112001.479018-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyfqdg5wwwj4kjco"
Content-Disposition: inline
In-Reply-To: <20210218112001.479018-2-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyfqdg5wwwj4kjco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2021 at 12:20:01PM +0100, Tobias Schramm wrote:
> Previously it was not possible to achieve clock rates of 24.576MHz and
> 22.5792MHz, which are commonly required core clocks for the i2s
> peripheral of v3s based SoCs.
>=20
> Add support for those clock rates through the audio pll's sigma-delta
> modulator.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied, thanks
Maxime

--oyfqdg5wwwj4kjco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYC+okwAKCRDj7w1vZxhR
xWUPAP9UlOHIEd8Mmjjo0yVzV4BlzO+qFihrLW4LloAikQ6UYAD/fvjjkFGKwNzi
dliEhvNt3GxZ/wy5dEbCJrAgdYNiVQM=
=RVBT
-----END PGP SIGNATURE-----

--oyfqdg5wwwj4kjco--
