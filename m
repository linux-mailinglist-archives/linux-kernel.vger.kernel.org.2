Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703E23B199F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFWMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:15:33 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47055 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhFWMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:15:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 53CB05805EC;
        Wed, 23 Jun 2021 08:13:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Jun 2021 08:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bvlEN71gEJw8dTddmdc2q2Vwa/f
        oT2HV1h2HUMGGpWk=; b=QYV3LZdLpqmkM4L4+cnqSa9HU9oU+rMprHSsb/GpRe9
        GWY52E7PipkKUevdhlO+ajgvcc3aj0gLNpPLP+UjaGmBv4A28YWKy+1jWG2pOHe6
        SDBQOVDw+l6ZA82FeCqFPJ3u/4XxxsbwHBCRTYM5hrF46sz1F7uLhshZmbiK8bnQ
        hpaPiZYKnIpvd1Le0A15a6GRd6HPPloI9UEMkzWK7QFnkH2pGGPFAq7rKgIEUGFZ
        XEEAHECCcQBU8WymCYPRZ+BK2E1gd7VA535ODx4izTEbsVhvWgfok93dbS1vDSzj
        1bBbZK2GmiOZga74UEFtgvcO7FxmdlYCDRuGc1baUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bvlEN7
        1gEJw8dTddmdc2q2Vwa/foT2HV1h2HUMGGpWk=; b=jHJeARFsGYkV+1k41dYd+p
        6uJzJBWNE4MSFYijIqiOo00ZPHFYzJWOc61a9Yc4kQWeLAQxlJW5WHk5RT64ajet
        QFXddb2XshDyU18V6QWl8R7TwpY0j3u2UbjpRov+SlxxUyww62RXsUGAbDjB34p7
        5GZDUWEf6zEQ1b5NVm7phrJIODeKzT88VXxqNlzwaxORcJHAPmIjVRxPNxODRr9W
        30DFG2I1Kg8xrNtGmttYIhhof/5kYRVGItSRl0nr0rrMEUTxGVTVYjLPZRCBgV8Y
        i8SjgqtqGDImToat70xcPZvsUvJUU3F+70xnrTo7j/s56EbdwRpiqXAWwtPOmOiQ
        ==
X-ME-Sender: <xms:WCXTYGUK8xceoJrOxy2UUQELe-vEVQAbyxc_dv_f83XITRI6TkIZdA>
    <xme:WCXTYClH5AAS0C0ZHLHb9WwanAZZEb7wOBxhQxoQ7OvWpuZYYGKVLpjXZU_ONHNMV
    QgogFtMI7Q-qa7wdAM>
X-ME-Received: <xmr:WCXTYKZ6TZjLlypY3q-xGLUlerQc5WZaOoMc3V2CwquMjq2Qydr-eV3bdJdI_cNwY7TMj_RN64Qxbqoj5KhKCOhBT2gMjs1Rk8qG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WCXTYNXIGb-bFSIrhvw-sjJ6GagaRged1569H6I9Tl7EgBswtCtLvg>
    <xmx:WCXTYAmlCZ8X-KS48Y-6CAg-g7OH88Db6db7OqPDE7PPfO0zGA2sGg>
    <xmx:WCXTYCf3k9TpbenJgrE388JwyVpL123O1fj4qUTuYue-rLrINppWwA>
    <xmx:WiXTYNjItrZulxglOXXEKAnrELpJgs_SyR0F0mLHVMAJoRNq-y5bpQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jun 2021 08:13:12 -0400 (EDT)
Date:   Wed, 23 Jun 2021 14:13:11 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] HDMI codec improvements, v2
Message-ID: <20210623121311.qlbnije5gn7o7so7@gilmour>
References: <20210610122550.jnriewchqspdcrwk@gilmour>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttfcqn3oaqjqblfs"
Content-Disposition: inline
In-Reply-To: <20210610122550.jnriewchqspdcrwk@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttfcqn3oaqjqblfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 02:25:50PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here's a PR for the changes to hdmi-codec that need to be shared between
> drm-misc-next and ASoC.
>=20
> This is the second iteration, fixing a bisection issue with compilation
>=20
> Thanks!
> Maxime

Merged into drm-misc-next

Maxime

--ttfcqn3oaqjqblfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYNMlVwAKCRDj7w1vZxhR
xX3xAQDxAGQmBeNhyLP7BR6FrulVySLHaiWkeiGlePaRir2uugD+NyFXqQyaAFJX
OHqA+RuGw5JNpbnPtgsQYEU3Aj+Efwk=
=homM
-----END PGP SIGNATURE-----

--ttfcqn3oaqjqblfs--
