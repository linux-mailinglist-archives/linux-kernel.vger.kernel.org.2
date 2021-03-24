Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251E347616
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhCXK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:27:12 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47881 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235797AbhCXK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:26:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 45BD0BA1;
        Wed, 24 Mar 2021 06:26:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Mar 2021 06:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=rTXYX3ec27IEHVMCtp17ydcc9fd
        6hBq2ucam/Vvra0w=; b=EEzdkxBNvbdpSL0MkdxqekvGdalqZ9UADREmP/BbCVd
        hBjP4CM5RjyWtB8dpxy1JhjQxstGikBF4ztOz4uhwybxllV2PB24cuGB00ci5sPw
        anFrD8F4Gp4O6tTHpt38y/MYyPT2aaypo9Z8lKXDPNj6itozz1bOtSGpQu55ODav
        7EMoygH0Y1PFzeOYFV2/JzDKFmkLHIhgsafjBTNQ+vEuctkkt+RHc7PbHchm4tTT
        hJwbWUsfnqXFR5T5WsMFTfKQrPKwTs2q3mIOOeOnMXK4IdvhOfGcLmbsSXc2E01O
        /CpYvQi7p68gHVd7cWjjx2qXNsFKQ8VmTlZCHZYYKUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rTXYX3
        ec27IEHVMCtp17ydcc9fd6hBq2ucam/Vvra0w=; b=KN3K6jeXsb5vWMBU4uu7O8
        qqApKnfCE4quWqJaYmKqXGXiaDY6OA0ZjiJGxKUMj3jwLNlVcvBNCVjWmFdXlelP
        0ImmYij80a4qX5LFrUZ4AFdNTjiX6VCKLUzl8srh9RQqlCDWaRJw491pIhCzf3BX
        qbbFpHGB0XbGOwMCc7bvkg1A1GSOS+6R0dw6Mm+1wTNPCsGoajRjsZTkbz0ltVlh
        9aDgbacrMeYBZdB6zuMLnu4pUdHxWlDeb1JQJFMXUIHr0kgTTvhSJqAK0ZKIhJKr
        HW82lIbHBqFHMv8SaFMy7+z5IPs650FTEWge+KgVI+8rMrciOmycSVDnyCFfRAxA
        ==
X-ME-Sender: <xms:yxNbYCLySsrgsm4s8WsVG768kV_nRz2oJfGMoXLMHHKGUYB5Up3Cwg>
    <xme:yxNbYKLAwXIRyD-sX8meDNs0pc7nviJeOpfZ-_5-BSA09bELNqcvUpMLJsSXCF9wi
    kLudOPwneOM0Q1bRiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdeludehfeeiteetteehfeetgeejhedujeevffegvddujeekjeekudeivdfg
    keevnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:yxNbYCvpSPiWv-QfhrphcqK7rXomvkyi91e7Pov0p4SpKkIiCXelgA>
    <xmx:yxNbYHZVD7tK5g3S0cBvEtepjY6I2LZRIPyPARKQ9k-EZ9uPLUU1MQ>
    <xmx:yxNbYJYrW8Xflok2lDI1DRQZhzFD2D4x8e_y_nVSiu9yczycGzenHg>
    <xmx:zBNbYF63hKLO3ST146vqLm0QCjfuN442b31F6qSdfOF9tuTGqE1DJw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03450240356;
        Wed, 24 Mar 2021 06:26:18 -0400 (EDT)
Date:   Wed, 24 Mar 2021 11:26:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1] MAINTAINERS: Update Maintainers of DRM Bridge Drivers
Message-ID: <20210324102616.tnlsybli2ejgz7l4@gilmour>
References: <20210324102019.1251744-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4h55i7gpqlhgx2bg"
Content-Disposition: inline
In-Reply-To: <20210324102019.1251744-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4h55i7gpqlhgx2bg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 11:20:19AM +0100, Robert Foss wrote:
> Add myself as co-maintainer of DRM Bridge Drivers. Repository
> commit access has already been granted.
>=20
> https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/338
>=20
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej =C5=A0krabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--4h55i7gpqlhgx2bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFsTyAAKCRDj7w1vZxhR
xWDBAP4tPNlvd+EKfbUGyMtfYnswWd7TVJO+HLJgYLkcg76pxgD+Ly3VYaJqb5oH
RPwm8B/bB7PFGKmyNDyEWnOrCsvG2go=
=F4dy
-----END PGP SIGNATURE-----

--4h55i7gpqlhgx2bg--
