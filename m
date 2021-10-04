Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0184F4209F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhJDLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233005AbhJDLTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:19:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1879A60FD8;
        Mon,  4 Oct 2021 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633346282;
        bh=0wgu5iuPepCxFxpreyphFnKy/ixxODTBfmJn7/Iu3yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwCo+BFKqVLQ1SvbSEXurrDxAkESGjOPahwmc/v7dYUl0nSGUvMWYYAUlrHK6wA72
         Tl7bt+KLft1VY8XcW1uQjMzTu7Bxy59KjyIzKpvZYczVvEF/33IVmVS0K0d5ynNmEm
         hznHSZlQgPPfQ6JeEaOqcq6G4F3dLSk2yzo0FQDZhX/moMnybr32CuCZraBLrdCRkD
         y/e7EyNF1zIsI6wgWRosuIFHfsqMoaTezQj+yW5ZtKZ7QXVOkayKfxx7wdX5x7vKB/
         Km4QA+LvwmGmPj7/JZZau4x0NY/m9gsfr8qoRM1+pkwNxJilYnb8DW7rlc3YJD/uuu
         ELy4g7gdn652g==
Date:   Mon, 4 Oct 2021 12:18:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Geraldo Nascimento <geraldogabriel@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control
 questions and issues
Message-ID: <YVri6Plus1oaX248@sirena.org.uk>
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <YVk77/SIxr8Vt8TQ@geday>
 <494D4A30-F230-4B64-AFA9-319FFC4C69DA@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5TFB1rwqMxtqYHgE"
Content-Disposition: inline
In-Reply-To: <494D4A30-F230-4B64-AFA9-319FFC4C69DA@gmail.com>
X-Cookie: If it heals good, say it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5TFB1rwqMxtqYHgE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 03, 2021 at 11:00:15AM +0400, Christian Hewitt wrote:
> > On 3 Oct 2021, at 9:13 am, Geraldo Nascimento <geraldogabriel@gmail.com=
> wrote:

> > It doesn't sound like a machine gun noise to me :)

> > More like brown noise, but anyway what I'd like to note to
> > everyone involved is that this one is a major dealbreaker.

> I=E2=80=99m the origin of most reports that Google will eventually discov=
er. I
> was told elsewhere that this is known as MGN so I=E2=80=99ve described it=
 as
> such, but that could be wrong. For clarity this is the noise
> (triggered, and with AVR volume deliberately right down) followed by
> some navigation in the Kodi GUI to change output:

> https://chewitt.libreelec.tv/testing/wp2_audio_noise.mov

Right, I would just call that static.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--5TFB1rwqMxtqYHgE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFa4ucACgkQJNaLcl1U
h9AGmwf/fxBw23uJPAC92OR7QsFhST90SG2lccRXbEC0+OXrQX3FyehcnLk6aURp
2BV7EWeP8mpFG9VmfR0uQIKAClPMChSO+23XieDPF5Nmk4HQc7foEnu3OJIkDhvK
cmjlDh29FKmSfIR+Ky8BN5EUhVd+Wj1FzYjbyGgMhfm2d6kZq8OzpJHVG9Ddet8t
E/xCVh8IsaEp5aGSPdty096Q0xC1v5ApLnStlCjzFCcqGVRYVCwUrZm4MARyTWIC
b00uBIwlKMSkV9Qh/K3a0umgcl/zGNjIO8n2edAOXtrw5EJIdmCboupoKpNLjLDC
CxWhMmWFJlsXDz0qSGAiSJaI30OMMg==
=gPaQ
-----END PGP SIGNATURE-----

--5TFB1rwqMxtqYHgE--
