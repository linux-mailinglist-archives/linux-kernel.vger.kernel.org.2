Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2971377F63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhEJJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:31:42 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34851 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhEJJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:31:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 965255805E9;
        Mon, 10 May 2021 05:30:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 10 May 2021 05:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o+RlLCP+uehcYeWcqJXYSH2E672
        srG6HjVhpuNJ5Otw=; b=LRzN7R2mzE2k+V6J5lq2UK+fX2nKfXfQYuOHuKoyzRu
        j+lbi1CqL+NP52cHv+CUoC6WJXpUlgycBjwv4T1j9a/DEjiG7Zyhv/1xpTUitXZL
        7Fd/mDNx/OUdkho08SBnpHWnVIiHROf+vqN/fyEFiSEDxbh1551GhyRMuFrp5cMd
        R69z7nR31SgF8D/SYPRt47jYKanW+Oo6pnXuIYvoWFyzmei4QJf02LXSZDvyhN8x
        tFXcVYkbq/9yygODAYeQE2tG1RbZFfzu+w4RTsg6w/rAX1FD0QAdBoT+3q34uO3X
        8ZEI4WPUzpLkycyYgQSbm1zm45+vtE0MK2Xu6lI/uyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=o+RlLC
        P+uehcYeWcqJXYSH2E672srG6HjVhpuNJ5Otw=; b=VX3bQ+xcj3x7+sHu1YxUks
        X8wNw+Fd01R1yQydbq78L0Cby+TIrelv5tOaVpJB/GWvl8D+sH8CgIaGNO69c5IY
        hEiQyv7Y2Jgds5qY1uFrSkOnaYEbYBOomlV5EOFkf4/PnX9Rs462yg/zF5Eu9QbD
        h35gXkLL9xRD38Zar2zQmtsODpC5f73Otu29yGjoiZfNH7VAztnGyVNb0Xl2Qsfd
        mBZFcJ8Cpo/Uq/1IUet2WiVQkTW8LqJQY+moL/C+vVhWEQf5kgbquj+p8tQ2+wl6
        Xb3HAqB+d4YF37Bop+OEKqzE+NZnmG6gffrLPiQ6QQEf2UWv1Z+z3gZkoqJ+yX0g
        ==
X-ME-Sender: <xms:Of2YYIpYtkrA164iwUrw7wmpDV4h9axrUp3B3CJweKypS-TZA0NZbQ>
    <xme:Of2YYOrKXTbfHrPgXqLYRwJGj6xl7MIhjhonGFzBdcfa6_pxjeDoxX_BgrbeBrv58
    VZBGEOrsS_alylWUFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Of2YYNP5VV3a0_SvB0NmN01X54WjaQrB9NnSc1yQ8lerLAQ02VA-RA>
    <xmx:Of2YYP5cdonqadux1oSBLKDrcufNnALJwsSgUalM6zcH4dGR8Q7IXw>
    <xmx:Of2YYH6QXRm5sYUZeJeRhxcWbGatnMHT3BFkpsgl982tUJuGTZbjjg>
    <xmx:PP2YYHpBFc5v6b-bl_ORTr9Vz8bRf0QCFHdpWHXnPOnKVzQnXk9B9Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 05:30:33 -0400 (EDT)
Date:   Mon, 10 May 2021 11:30:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v3 1/5] drm/connector: Create a helper to attach the
 hdr_output_metadata property
Message-ID: <20210510093030.nqbfw7iayhmtnljg@gilmour>
References: <20210430094451.2145002-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="faciecejyji5pg3t"
Content-Disposition: inline
In-Reply-To: <20210430094451.2145002-1-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--faciecejyji5pg3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 30, 2021 at 11:44:47AM +0200, Maxime Ripard wrote:
> All the drivers that implement HDR output call pretty much the same
> function to initialise the hdr_output_metadata property, and while the
> creation of that property is in a helper, every driver uses the same
> code to attach it.
>=20
> Provide a helper for it as well
>=20
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

I pushed all 5 patches on friday

Maxime

--faciecejyji5pg3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJj9NgAKCRDj7w1vZxhR
xTd/AP48Cj/pWzxu4xJM1P/Gl4C1i/fr6aJANTq2rOju3Y84FQD/Re0cYaNtLidN
8GBg64zcLh2z0n9CYT4Vc6km4PVungw=
=/OMZ
-----END PGP SIGNATURE-----

--faciecejyji5pg3t--
