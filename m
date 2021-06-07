Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04B439D7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFGIqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:46:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33983 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFGIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:45:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A43045C009A;
        Mon,  7 Jun 2021 04:44:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Jun 2021 04:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=18ijyZ5L48A1ngB5xr0ZXKoYagA
        14lFazbGBR6OHmF8=; b=hStDS95y7m4ZLSLFO+jDeRFo0NwA1RSIPWcQnsIoUUF
        25QAci2Ks/KH85z9IgkpqI9zDAlAcwNK+Rj0cX9CRDWY8mHdkNsRnsPcipaOmECZ
        rvVqZ3PcPoVV/OAewBzUV2OZw72ujsiEtLAjaLCvApr7OXnovewM0kMxKAtawbOb
        2/r2Q4jVg0d7Tc7t0DeTQ1piorar1xFmRfW3ELeDznS8/6rOVKh846IHN1XFY27h
        WdE9FB1+29xCbz3QphlTv9sZc001LsadLFiEzYc0d3OxMakTBiUv/PR/gVhEXw8c
        fo6kVjBcgTJz/KuZrBShX/IIayA+R9rcRZ5igj1h27w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=18ijyZ
        5L48A1ngB5xr0ZXKoYagA14lFazbGBR6OHmF8=; b=qaT4dt/PHRxDhYMhGxPQA8
        UOhOhysWvllSwh/pHKOzwJGawQKDJy3/IT3JkEPY0JZubQA9hyVhIfBuisP6zk1q
        /XUAonzrhGimdCessiKhBPWn56HcIMvPyRlI47aBMntJChk4obP43qJGRHDXk9FA
        eHuWhh/2AtJy8fRq3ECfN0A5O7BxBKIRrt7cwZp76k1+agKNBJkt9msTSQI+Y6NT
        2UN7ZClADzWAVVHuG1oR3+873TRcET97YkObhq+MO2FHGYtqiKLby19cJWQw+8zn
        VJ4Fv5yKhmiOaRDNi6M3C+DbzcqG6gsk0uZ9fycF6tw6jowP4dk/q/xCT/SI86Bg
        ==
X-ME-Sender: <xms:UNy9YLblECMBSoccBECuTkeR1fcm4Ko6-Xc1CrjHAUFERGWq_XHLJg>
    <xme:UNy9YKZuUfx6AV5CD6ot7l3lmGxtMA_DYi86B0PF26JdfZZkBhNUD3Wi0l0ayBExc
    42ndWJsZGGfYpD294o>
X-ME-Received: <xmr:UNy9YN-YfYTEU922Uq9ldlyAqE0mweLxbnQINTxy66O0w2uf2wJHzQw5QqGhXYQN1b0HSf3kDb0hEde_imKWH7PZlKDAuad-3Kd7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UNy9YBrdSdX6IthLuL2RZCv7hqQAg8t5BG920iQOgfHZe1whdda9NA>
    <xmx:UNy9YGpEVMl1oIAV91UCDyChhIVJw0TavIon3hwfYitjmL7Kt7g3qQ>
    <xmx:UNy9YHT59uzCPz-6Gxko2skSxlOlDtdxv5KZADvVaspiPPL6crpsvA>
    <xmx:Uty9YCd30LuZ0VBZdrJZI5SOGC1RjxYGpIGCtSlAHHRVNe8YrJpibA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 04:44:00 -0400 (EDT)
Date:   Mon, 7 Jun 2021 10:43:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        daniel.stone@collabora.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH] drm/sun4i: de3: Be explicit about supported modifiers
Message-ID: <20210607084359.hkm6ng2m4hcoheyz@gilmour>
References: <20210605073534.3786194-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ycnegl2wrikhuac2"
Content-Disposition: inline
In-Reply-To: <20210605073534.3786194-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycnegl2wrikhuac2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 05, 2021 at 09:35:34AM +0200, Jernej Skrabec wrote:
> From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
>=20
> Currently only linear formats are supported in sun4i-drm driver, but
> SoCs like H6 supports AFBC variant of some of them in multiple cores
> (GPU, VPU, DE3). Panfrost already implements AFBC compression and is
> sometimes confused what should be default choice (linear, AFBC) if DRM
> driver is not explicit about modifier support (MiniMyth2 distro with
> MythTV app).
>=20
> After some discussion with Daniel Stone on #panfrost IRC, it was decided
> to make modifiers in sun4i-drm explicit, to avoid any kind of guessing,
> not just in panfrost, but everywhere. In fact, long term idea is to make
> modifier parameter in drm_universal_plane_init() mandatory (non NULL).
>=20
> Signed-off-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks
Maxime

--ycnegl2wrikhuac2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYL3cTwAKCRDj7w1vZxhR
xfhZAQCQDar9Xj7NCzBF7OjpfeiurqurWlpsfb50m6v9VGrvjwD/VRJb8dF/j8J7
MiecNQL73w9r1P2JPWUAzjILeoNlsA8=
=ZjS0
-----END PGP SIGNATURE-----

--ycnegl2wrikhuac2--
