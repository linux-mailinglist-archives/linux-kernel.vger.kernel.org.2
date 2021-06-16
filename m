Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C3F3A9A13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhFPMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:22:30 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56811 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhFPMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:22:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 449BD580561;
        Wed, 16 Jun 2021 08:20:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 16 Jun 2021 08:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kDf3rNI2uOH/mcfgKx6Ye6XWRv3
        V79fjGB5uhMQ4otA=; b=z2HdRZoa9JfWsbC3/UGzCONbdmyOQluULUbxr5za+LK
        poGy4GWzpeXRdvHiG2ozkcmblHdE4f7aDRQEwV22sob+3Ib/CwFxsOPtt0It3fhk
        JRLgiy81rGEr29WUK6sWSGkMdSZ/O7Y8k3yH6mPc+mzsG1wHnjtxf55/ETiM+m5U
        RA5Wb/mS6svr8WqjXQ57+o5nEjOCkZ/1cinQ8in5Ic5eQH/qrwSGtnFmlhXpVXMC
        U9mxbB8Bl+FlDYOPZ5oZuSYstypPUpVPxD0mtAwwk0a72hD6FR/fv7ODz0sk8HZa
        qiU7vqajfsaAvASh1cfPIadM99Bh2tsbMQMlcq3pKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kDf3rN
        I2uOH/mcfgKx6Ye6XWRv3V79fjGB5uhMQ4otA=; b=bwkpCiX3G0+194zKJaLcoO
        0k2zbPC/ySz5INgX1tKjrE3cD5iUwEohG7Uj6rd4cLunJPbDDCABYZBjeCrWA87Y
        UB7NoLz9HdaY8dXdbndcay/GOx/b9A9GrdtZZpdkAN2snrBEBOs1ULPsPYG4icp+
        G3i+QwLhQKKivlu7bbo/+5sjae5N/F8DNfzMzKuZ4p6nBbkgy3PsWwBzjVgVS63s
        vY2egCWCYXUXwRV3kDnbfn5gUL7KtJ8iKaP+mdfg/SGDVDg2FNeE0w7ik4IfZPmI
        EXaEZeFQDyR5xuUohjvPMXUpajcIbpphTI+UoTpuZDNlyISYn6ruRD02lyLQeHOg
        ==
X-ME-Sender: <xms:hezJYKE5Vd2AbVJZ4LbjT6zmwiPs21p7AeC30Snsb58H0pKFKCIjXw>
    <xme:hezJYLVLctXUTFnUHk0obPH-GfMfpNa0BsEX-hcprKLS2aHH1emDXEdEN-oZKTobl
    l1YLUBqVivU2-PAEhY>
X-ME-Received: <xmr:hezJYEIy60kb22oNfvhIPkjfwGSv0fSXm62vPaSHIQiYDgwmsRzkyweS-AOPXWb27iAsjTCqcTKaJpWgdvPtbv4Ih85uRGCIgK19>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hezJYEEeB56-TfFLDIc-XaFUv6Zh5GS_MEj7WpEgMKUlnGnWxefunA>
    <xmx:hezJYAUMZiyoDYubalv1z5F7xIwU8OvukmdTnxew3H6ztMIg8kJuoQ>
    <xmx:hezJYHM4woEo4pMrbsfVDwtenH-pTOe_OPMXYXh7uEJ1o7iuwZxB2Q>
    <xmx:h-zJYJOpq_QcEAVpFoypBlseK9BBc4V15B4HNE8vOtYWHVtXljxJyg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 08:20:21 -0400 (EDT)
Date:   Wed, 16 Jun 2021 14:20:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/vc4: hdmi: Rely on interrupts to handle hotplug
Message-ID: <20210616122019.f4u2zndgbpb32j3f@gilmour>
References: <20210524132018.264396-1-maxime@cerno.tech>
 <CAPY8ntAqh2wEhN2wO_RQ2jJ7X3ovwB_5UwbrbPypDOhd1KVN6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otvofflh35ejfizp"
Content-Disposition: inline
In-Reply-To: <CAPY8ntAqh2wEhN2wO_RQ2jJ7X3ovwB_5UwbrbPypDOhd1KVN6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--otvofflh35ejfizp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 11:09:29AM +0100, Dave Stevenson wrote:
> On Mon, 24 May 2021 at 14:20, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > DRM currently polls for the HDMI connector status every 10s, which can
> > be an issue when we connect/disconnect a display quickly or the device
> > on the other end only issues a hotplug pulse (for example on EDID
> > change).
> >
> > Switch the driver to rely on the internal controller logic for the
> > BCM2711/RPi4.
>=20
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Applied (with a compilation fix), thanks
Maxime

--otvofflh35ejfizp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMnsgwAKCRDj7w1vZxhR
xVmIAQCXmcjaJFVs11F+WGsGcVaGWocvj7QWlEeBGoMkSmHSZwD7BIQLyxZla74G
iAWXVW1wzFikP4mMetsKBkzZdkR48g8=
=2bbS
-----END PGP SIGNATURE-----

--otvofflh35ejfizp--
