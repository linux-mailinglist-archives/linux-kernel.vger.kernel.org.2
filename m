Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572333A9A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFPMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:38:10 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33343 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhFPMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:38:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 938D8580564;
        Wed, 16 Jun 2021 08:36:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 16 Jun 2021 08:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1sZx0enZ5rPT3TQVb1y0Ba59AJG
        Prg0OKYOsTh77X58=; b=tntzNxLB46PwqxA9WAo2p+Kn9/LfuWqGfASWR3L7YkL
        M7iz2E76/IN7BMTeZMrh2VyCek5EENTJafi2gqUezm1HzjbkytlL+AJ/tnEcjVM4
        eXG8W44yXDdPl4rNc/aEDItlA7WNjVfScGEizDcdlMTdO0x+XL9TK3H+pq2V7jwa
        RMnUyzrg0FfML/+eI52F4IS2x1m88XHpziO8guH1xeliHAQl3he6VWhSf9F7Ag0s
        zTT03OHPE/xxV5VhleEKLIZnyaDOSkSWrtojAbanB4uueSQb8KQ649MOeSJwu9Vx
        xCR1QFwoksk30jP71UXW6XFHwWurMRP7fBIB4fIc8aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1sZx0e
        nZ5rPT3TQVb1y0Ba59AJGPrg0OKYOsTh77X58=; b=Ar+Lqs8mYjHAI0PQADqT6I
        8DQCuwYHjlX/p3bKccys8lBdePbEc2+vp7A3CzkUDY4IDzwlCTBRoYodwCUqu2sf
        LXGgpFGjwPHxHUZyvS6u9Z0oEdqUphhNKjs5pE32xM0QKp3HXQH5laZDa9g8lbBZ
        Khb9qa5PQJUsgGW1jKwDkcBrf53mRJmSvdbcO20ELgPbnnU0orFjByS8FO7zgWbK
        c8/9bejB75J+wNalU3uVc1SzzA9Lql4pJdr+p9QZCz5+Jakku2Na2XSFLlQZiO8m
        m9YhdskJZ388c1Q6LSzRArN3USRtmG536ifugdoS35Zd50Q6HqrUdVlQIUfwABlg
        ==
X-ME-Sender: <xms:MfDJYJkJnEgwXxd4kHDEpZVSOSx2GUR272-mCsDop8_uLLGuWgq8OA>
    <xme:MfDJYE2oEerMEQkuQK-34WVL9LaDZOdIRUs6rAR-h0s0PBM9PRDMH1w4Jxg3ZiKO4
    ScbSiapdlj0wL4H6yE>
X-ME-Received: <xmr:MfDJYPouFmvfQXcPo7uJxwb_LlGbdW2F-HG-nqkR0rzAQMF29TteVQXV1pLS5ZzaYIUO2z-bSGYxX-dhkDzMFAQ6IrzOYi6CPVSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MfDJYJkIAuar1buK7zdZk5OyrAkfeFwNypbEX7UudJ7sjFuCH5TVWA>
    <xmx:MfDJYH3j5pmCQPHAoi-r0spmsKupu9au_X_CEdqus-T6v1tcb2wKmA>
    <xmx:MfDJYIvG05XIWf9ce0KmIbPwHS5qvirjr_l2feWngbUi_W9KaGcs8A>
    <xmx:M_DJYFOUdsw6GSlhueTmhmFDrdRMxkWVRsG-24_Fgat9s4vVQGoZUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 08:36:01 -0400 (EDT)
Date:   Wed, 16 Jun 2021 14:35:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, Emma Anholt <emma@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH 3/3] drm/vc4: hdmi: Make sure the controller is powered
 in detect
Message-ID: <20210616123559.azuo4zudyexxmvsh@gilmour>
References: <20210525091059.234116-1-maxime@cerno.tech>
 <20210525091059.234116-4-maxime@cerno.tech>
 <CAPY8ntDfoKLwWG6pkPNvq78C3e5WzXNCVtCykJrrHhZ0UcrjTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vglgsjthekhzshnl"
Content-Disposition: inline
In-Reply-To: <CAPY8ntDfoKLwWG6pkPNvq78C3e5WzXNCVtCykJrrHhZ0UcrjTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vglgsjthekhzshnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 11:51:26AM +0100, Dave Stevenson wrote:
> On Tue, 25 May 2021 at 10:11, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > If the HPD GPIO is not available and drm_probe_ddc fails, we end up
> > reading the HDMI_HOTPLUG register, but the controller might be powered
> > off resulting in a CPU hang. Make sure we have the power domain and the
> > HSM clock powered during the detect cycle to prevent the hang from
> > happening.
> >
> > Fixes: 4f6e3d66ac52 ("drm/vc4: Add runtime PM support to the HDMI encod=
er driver")
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Applied patches 2 and 3, I'll resend a new version of patch 1 after some
comments by Daniel on IRC.

Thanks!
Maxime

--vglgsjthekhzshnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMnwLwAKCRDj7w1vZxhR
xUIoAP9gpqjRqeNY34XJL8wXsE/w4cW6+rVfVIIFqYrRkG6auQEAvnvTLmxyhQBN
p4+TOmatXf17NWJPuaennvoDX2CEVgs=
=egla
-----END PGP SIGNATURE-----

--vglgsjthekhzshnl--
