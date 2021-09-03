Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D63FFCC1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbhICJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:10:31 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36997 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242812AbhICJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:10:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E5C08320084E;
        Fri,  3 Sep 2021 05:09:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 05:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xO2AiuSIewvWYYBYy9ppnzbKpNq
        Gz03TblUf1EuZ4Ug=; b=XT1lY8wkYnzR38phv7i1SyOAFv9ohtxxPlXCihKOkHs
        fvMTBlx0eHQXdjCnRLfcwMEbroeOkSRo5UlkGG8xrjFrL9ux0//3c12PwWCTMaZy
        qkOPTsoqgKqaKGRGvkR4K/V9GRHQ5M0nSQ8IfqgxG2tTO3oig7vKzbr7cNfN2Ec3
        FYdjHDxxeBuMO9i2dsrVvefBQ9cD02eCb+AqPvtgvlEVEAm9x/v25frTdEJWpozN
        6QWefZCpZBgkhS3hWKCyLH+80+AO98wAp8G8fRO5cc6vVa648T9UmcEFzXtX09Ek
        oEveTqx/9QBgJmku+g7Foq6pSr3J2M836EYLIr3UPOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xO2Aiu
        SIewvWYYBYy9ppnzbKpNqGz03TblUf1EuZ4Ug=; b=fX0vxdJDTwZAQISatfNDYI
        MH/S7hX/lBNdMKGbrn03QLvqkeVq+HxeBhRN0wWf8D9N66UmDkG7xYGfQHvVgoRu
        Zy9pjXxfsyNOFJvl6EtnCl2r9A0ZcXFyQbStGGZYw/pzCdfZ0bLcJH9bjQlj2m82
        Jb6l1Dq7BiBzTpACvgHea3f32ay/aDD4VQLfZ2oixA7YzbMswhdu4z9R1Z3gtHA1
        tkEIV6Zj3fFaj7QNMmewMEkx52zJ/7vE/QSd0rXAP5ULZOcIvTViUu9de8RVo274
        nbdFAlT6sR+6spdXoVkgEILW+RnezkD/APSaR33J95sWszMEPdvWBirt+Yak388Q
        ==
X-ME-Sender: <xms:QOYxYRDjKDnJMAOMDPrTyL5Yg4ull8u0jcNdXybtm7_s-ixIiGOohg>
    <xme:QOYxYfgpH42R2n9AwpBrQKyZYOLSvNsAAXVKe11uJroN2HnRgkTcFd2YLQoC_g_0a
    OzUJnJtESOg5Mp6K7k>
X-ME-Received: <xmr:QOYxYckG-s2cbJdErNS5HUQGIuCaU5PF1Wcb7b7BZvBeZ2AXFJnauCB6TAimPxQcroLpAykJD9Xc4osWPzELx-5jZ6IjDAF6brNK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QOYxYbzlvCnbTjPj4VDSCYXWuDQj6HIjp8-BcYzXg8qtcZ3BmB6dBw>
    <xmx:QOYxYWR9aIl764ZaGCemeG03wiUBp3QJpk2qQAPyAWqknIA6Dv08-w>
    <xmx:QOYxYebXOzO6o-UuDuD2Q9MboxJCWIpWJj9qu_rBUWVQXL1NWYGcSA>
    <xmx:QeYxYTQiBwr2w5BSCNtbmLAW5IxX8bnMQ9zRNs4yBS_NdXSR1rlQRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 05:09:20 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:09:18 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] clk: sunxi-ng: Use a separate lock for each CCU
 instance
Message-ID: <20210903090918.krvukxbwaicxyuxh@gilmour>
References: <20210901050526.45673-1-samuel@sholland.org>
 <20210901050526.45673-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d76srkb255wqnmwl"
Content-Disposition: inline
In-Reply-To: <20210901050526.45673-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d76srkb255wqnmwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2021 at 12:05:21AM -0500, Samuel Holland wrote:
> Some platforms have more than one CCU driver loaded: the main CCU, the
> PRCM, the display engine, and possibly others. All of these hardware
> blocks have separate MMIO spaces, so there is no need to synchronize
> between them.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied the first three patches

Maxime

--d76srkb255wqnmwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTHmPgAKCRDj7w1vZxhR
xYNdAQCr9ixZ9YQw11Q1b8e9NxFK8M85Xyqlvyc9vXD5hXsTCgD9FffYNIOOpw7I
tfMxsl4tlGQ+4ZQaNe7rQ+qs4DrfjQw=
=8EAf
-----END PGP SIGNATURE-----

--d76srkb255wqnmwl--
