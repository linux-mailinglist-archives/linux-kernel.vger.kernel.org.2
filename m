Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06CD427FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJJHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 03:49:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58897 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJJHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 03:49:24 -0400
Received: from bagend.localnet (86-126-20-31.ftth.glasoperator.nl [31.20.126.86])
        (Authenticated sender: didi.debian@cknow.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 47F8D60006;
        Sun, 10 Oct 2021 07:47:22 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date:   Sun, 10 Oct 2021 09:47:12 +0200
Message-ID: <4974503.Y8KB3sNASq@bagend>
Organization: Connecting Knowledge
In-Reply-To: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5876364.1uclEOo45F"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5876364.1uclEOo45F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date: Sun, 10 Oct 2021 09:47:12 +0200
Message-ID: <4974503.Y8KB3sNASq@bagend>
Organization: Connecting Knowledge
In-Reply-To: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>

On Tuesday, 22 June 2021 10:27:09 CEST Guido G=FCnther wrote:
> alsa-ucm groups by driver name so fill that in as well. Otherwise the
> presented information is redundant and doesn't reflect the used
> driver. We can't just use 'asoc-simple-card' since the driver name is
> restricted to 15 characters.
>=20
> Before:
>=20
>  # cat /proc/asound/cards
>  0 [Devkit         ]: Librem_5_Devkit - Librem 5 Devkit
>                       Librem 5 Devkit
> After:
>=20
>  0 [Devkit         ]: simple-card - Librem 5 Devkit
>                       Librem 5 Devkit
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
> This came out of a discussion about adding alsa-ucm profiles for the
> Librem 5 Devkit at https://github.com/alsa-project/alsa-ucm-conf/pull/102
>=20
>  sound/soc/generic/simple-card.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/generic/simple-card.c
> b/sound/soc/generic/simple-card.c index 0015f534d42d..a3a7990b5cb6 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -621,6 +621,7 @@ static int asoc_simple_probe(struct platform_device
> *pdev) card->owner		=3D THIS_MODULE;
>  	card->dev		=3D dev;
>  	card->probe		=3D simple_soc_probe;
> +	card->driver_name       =3D "simple-card";
>=20
>  	li =3D devm_kzalloc(dev, sizeof(*li), GFP_KERNEL);
>  	if (!li)

Unfortunately this change broke multichannel audio on my Rock64 device runn=
ing=20
Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a HDMI cable.

Before/without this change, pulseaudio correctly identifies my AVR and give=
s me=20
hdmi-stereo/hdmi-surround/hdmi-surround71 output profiles via the HDMI card=
 and=20
iec958-stereo/iec958-ac3-surround-51 on my SPDIF card.
After/with this change, I only have a stereo-fallback output profile on bot=
h=20
HDMI and SPDIF card.
I reported this to Debian at https://bugs.debian.org/995923
I have verified that reverting this commit on a self-built 5.14.10 brought =
back=20
multichannel audio.

On LibreELEC's current nightly builds (version 11) with kernel 5.14 on=20
a(nother) Rock64 device (also connected via HDMI cable), I hear no sound at=
=20
all. Previous nightly builds (version 11) with I _assume_ kernel < 5.14,=20
worked fine. As I didn't keep previous nightly builds, I can't verify that.
I reported that at https://github.com/LibreELEC/LibreELEC.tv/issues/5734
I have NOT verified whether reverting this commit would also restore audio =
with=20
LibreELEC as I'm not familiar with their build system.

This is the first time I'm reporting an issue to the upstream Linux kernel,=
 so=20
I hope I did it correctly (DL-ed mbox file and did Reply-to-All). If not,=20
apologies and I hope you'll point me to the correct place/way.
(I don't know if others need to be notified too as it is part of 5.14 relea=
ses)

Cheers,
  Diederik
--nextPart5876364.1uclEOo45F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCYWKagAAKCRDXblvOeH7b
btKJAP94HDQVbxFH7oeZReoLAa9c33hWAkhsXvRR0RgKBsCXlAD/eNwTTabMI5Cy
U1Wsg+p38twgt/m85qPOO2Vwgkfwqgk=
=aGUG
-----END PGP SIGNATURE-----

--nextPart5876364.1uclEOo45F--



