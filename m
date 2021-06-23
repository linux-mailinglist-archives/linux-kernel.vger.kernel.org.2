Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68853B1A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFWMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:31:35 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38155 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230430AbhFWMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:31:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44CF35805E0;
        Wed, 23 Jun 2021 08:29:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 23 Jun 2021 08:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=LYmysgAYQbYf4D5WIV3nX+JHKv4
        gcr5JH0CPAhQp3EQ=; b=2eJlQpIHzliDahyhagWavmKnGgwp95ZisZfiYEn9MQr
        kFnx2PwYMwEwfxbsdSuu5H0iwUSDqsdvFTmGqElDbDAKRvHLLvLCIS1C2D4DLieT
        tdt+ULQRftMO8WV54GoiYsTiwbC3K1wUdoLrhvxobU6PNICaLAhzZZh5qwYIYHgW
        Qot3r07h03x4S/7gR4qA7Boi0D2f9UFjmRPBw0qSmGz4XnDhs7jQPkAAdv7QCFLi
        nJ9LVhD5NkgH7pPP4p/GixwP9y3ZHmJ2RmYL33AYyyR72L0/7xJhBtB7rBKnw5uJ
        aGzyS9WSLYNaGC0bdDafCdCCbAUf/zU12Sh0GMJYOCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LYmysg
        AYQbYf4D5WIV3nX+JHKv4gcr5JH0CPAhQp3EQ=; b=lcr+uzMgCh79q2GtuWp50h
        xEyL0RWnfNYX34/c26G/ynQQcmDVGgDu76mPvLqRRyrlHWQm54BVa78BABb3nkjD
        RiE2e7XdKfj1iVGoZVQ27NgzEBxvM/5y4zx4W6Nd0dTIpqxtQgmQdEcaiXvm0Yp5
        MIGwT6Y0dztc9joSc9wgrs7/e2oOtOMeCndXFrRRrlCoirJE24OTBUeJF+EMLOdE
        APyK+Rzg9kPtZD+blzODFda0w24L/NONnXqZOovMh6kY6zlKzZLQlAwKiaN0GlyK
        eVGAOHLp5rFyuNX7+j7zSLsA1ePkLNUQVn59JahN0ZKhhonk+V1xtXGWaY3MxZaw
        ==
X-ME-Sender: <xms:ESnTYK_C-21U2l2QozyILoNSlPVqKfpTp1q6YqEseQtERYTgD7wEjA>
    <xme:ESnTYKs6ZYg2RUE3T4E6_4WYfh7byUamSHlJxrXSRIO9zEAnf3vP53J6ISh3gHTex
    vjveIKAZEot9ElXG9Q>
X-ME-Received: <xmr:ESnTYAD101y1Z0cSzKC5muGw7O86ArnMv0EERbPkuBkRESwg4ufvcqvrEDGFH43cICse_euQkCXeR5wF_iBFxf7l5AzuiVuIDg2F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ESnTYCe9QBXtVFJhfKsnRwaDl-xkxqvQydUEScUwiqPYbRcEi1TlPQ>
    <xmx:ESnTYPNXuaRR8kEvEfb-7qU59Zify5c9K1HKVr_vC8Om2KWmtIZAxg>
    <xmx:ESnTYMlg2fbk5mkdtWnpb4rpr71L0d4YVRQ-KoHTE6BfyypN_1u9OQ>
    <xmx:EynTYCdX2W4keJN3BziO7ALHGBYvumNaAZ_6JzvRr3sRzPLV1XkbCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 08:29:04 -0400 (EDT)
Date:   Wed, 23 Jun 2021 14:29:03 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 10/12] drm/vc4: hdmi: Register HDMI codec
Message-ID: <20210623122903.nvkm7hagt324n4pd@gilmour>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-11-maxime@cerno.tech>
 <c1ee306fbc81da2df7d0041c719fc8cd3302cf0f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ed3s3jfq3fuhw3ac"
Content-Disposition: inline
In-Reply-To: <c1ee306fbc81da2df7d0041c719fc8cd3302cf0f.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ed3s3jfq3fuhw3ac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 11:26:24AM +0200, nicolas saenz julienne wrote:
> On Tue, 2021-05-25 at 15:23 +0200, Maxime Ripard wrote:
> > The hdmi-codec brings a lot of advanced features, including the HDMI
> > channel mapping. Let's use it in our driver instead of our own codec.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
>=20
> Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Applied 6 to 10, I'll resend 11

Thanks!
Maxime

--ed3s3jfq3fuhw3ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYNMpDwAKCRDj7w1vZxhR
xTtEAQCsRUnfy20Se4iYG9OnMpYBOcMIXkIlk4MHoGG22GbIhgD+KEWBCy8hUjqQ
hXB++Vu4wHH9EPXj1HdCg3lwFXxWrQI=
=QYZn
-----END PGP SIGNATURE-----

--ed3s3jfq3fuhw3ac--
