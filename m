Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C738FDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhEYJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:35:06 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52607 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232553AbhEYJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:35:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id B65C213C9;
        Tue, 25 May 2021 05:33:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 May 2021 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jROtr0lHgeFAU/OduOZJ0abHrau
        DG88KGsvMrltysdI=; b=TLPZBtCagzgKGJPCmH4mUGQRE54Ss6YUFxm47RiK/7w
        D3DdIzzPJlix+xCCczeO3AbQm78U/XAROdw3rosxCxoLOtAIbqY1PEw7IaKDdiD1
        ge1iDpNAEHdinDomQpkVzLC2ePI//nrpzhDFq7hSfzLgdBAgIVwx+BUxaXTiZ++m
        s0IzBnjnWwHtmkBw4sJt24n0BOT2lMZAN36/zlDHxDMIsepuZlWinJey2mUegmJV
        wLfQQYil5kKWFTf5lKLU/4jw2RkVUCSE0Rn9d+l7bPvn/FZLcmvkQRmEvr8ez1du
        S5/eTUCYo3rffAqJj9DVVeln+3dRB8eyrWWCkxEbiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jROtr0
        lHgeFAU/OduOZJ0abHrauDG88KGsvMrltysdI=; b=EPrdFpjy5DbjELj8+jWq4I
        H7kslYwLoyWuKudCa/+iYse2L8azuHIi/CJUfv6Sx5878orW6UPRxO6xC5hn+NIS
        KS5R4q3/AwEaH/ZAcMwLgmXoprrIWdAsz9qCBEwD3ECZqrJ1D2Lzla0759/nuIPF
        HrLMD8nG2hCqpj9695bUlF5qKB3xOuBmyz+Siwe3HAJAOAvBBoMB9psU6gpLZeED
        sKcoAxgdRHv3BVo92RS2ObkeCqODErHNKzlwjSdvK/PV8fGElw1ae/2Uos4EA+Hi
        u5+FfK+0Rh5YKWDWaWjSNUd62Y8+UZm72URoYE26ATxf3OdEpl3DbZZfd9qJueXg
        ==
X-ME-Sender: <xms:bMSsYNWWx4K7zZOUZnyIzS5z0uNCe4gX4e_Y6j_9hFPZJvmjQkAbyA>
    <xme:bMSsYNmy0AodNTZsM50cPsJ2ysIo86rC9SIJxu2uF2JD5RwSq5deQ5OIcxYdPzDYo
    -mGBeDBZtfJkMEJNq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bMSsYJZ09yBox5hokHxS0K0cxQZCLOKJUfo_j29kM51BdRWzrYge0g>
    <xmx:bMSsYAXURi_GssbkSTkTX_pne958RhRhOquoeW-KLY65ONYDMDA2FQ>
    <xmx:bMSsYHmIhMqVwQGl6FBrDJttHkSzgOJh3W-Fwi6yziF8813X8OHKeA>
    <xmx:bsSsYJuJydhsJUXfxb7fKgfdgGY2uVOCcOoB9hcOxw_4IlJoiVLtJrPm08g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 05:33:31 -0400 (EDT)
Date:   Tue, 25 May 2021 11:33:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>, nsaenz@kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 01/11] snd: iec958: split status creation and fill
Message-ID: <20210525093329.trltam5mqtvbqkr5@gilmour>
References: <20210507140334.204865-1-maxime@cerno.tech>
 <20210507140334.204865-2-maxime@cerno.tech>
 <s5hbl8ze082.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxe2w3b6f53vgutz"
Content-Disposition: inline
In-Reply-To: <s5hbl8ze082.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxe2w3b6f53vgutz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 25, 2021 at 09:33:49AM +0200, Takashi Iwai wrote:
> On Fri, 07 May 2021 16:03:24 +0200,
> Maxime Ripard wrote:
> >=20
> > In some situations, like a codec probe, we need to provide an IEC status
> > default but don't have access to the sampling rate and width yet since
> > no stream has been configured yet.
> >=20
> > Each and every driver has its own default, whereas the core iec958 code
> > also has some buried in the snd_pcm_create_iec958_consumer functions.
> >=20
> > Let's split these functions in two to provide a default that doesn't
> > rely on the sampling rate and width, and another function to fill them
> > when available.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> The changes look almost good, but please use EXPORT_SYMBOL_GPL() for
> newly introduced symbols.

Ack, I'll change it.

> Also, it'd be worth to mention that some bits update are done only for
> the default values; if a rate value has been already set, it won't be
> overridden by this *_fill_*() call, that's the intentional behavior,
> right?

Sorry, I forgot to put a commit log on the patch 2 that implements this.

My intent was to provide a default in the probe, but if it was ever
overridden, we would return it in the control afterwards and pass it
along to the hw_params (and later prepare) hooks

I'll add a commit message

> Last but not least, the subject prefix should be "ALSA:" in general :)

Ok, I'll change it then

Thanks!
Maxime

--qxe2w3b6f53vgutz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKzEaQAKCRDj7w1vZxhR
xX/iAQDyKGU5zZGT0hhjwnnBey03GOnI+zvb2A8SFJmO7NaZvQD9Fo3ynLNkuX+w
ANzO43UIWP4npIS3a391pApWC4R1tAg=
=d5nb
-----END PGP SIGNATURE-----

--qxe2w3b6f53vgutz--
