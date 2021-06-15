Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93123A7E20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFOMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhFOMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E544D6143E;
        Tue, 15 Jun 2021 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623759792;
        bh=XoQTzRQwmuh1QMzbvDAjue3zCh0UzzKehg+0IFfhvGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGLRYensvx/zi4r6Mx2V2HC6zErvM45s9pbLPp77nMCCF2+qERLvi+GQ4AAe4DiC6
         sr1v+AUxBvRpppYNu4sgDmUejW95H3wDHVQDQ/JnOh9R4p7FMGrxT0Oy26RVuDrgQ6
         25oewW1KeEG0g4MVv1ukCbq8JMmvnhP8dTp7eS2QB0w3ZEYhZEf0gLqtxhs/HIswRb
         wzTeweIfMy494Fupq3x3B8La21M6OgoZeDdhPSBvIAFy8e4WkrQc//GKJ2rOegriCx
         nTcEl4m021zdct1jkxVqLiAChTrb5+xTZKrz1A7muf3mwF+I0gOkdML52f9vrzula+
         FooX6VE8DUOzA==
Date:   Tue, 15 Jun 2021 13:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Claudius Heine <ch@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tlv320aic32x4: add support for TAS2505
Message-ID: <20210615122241.GE5149@sirena.org.uk>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-3-ch@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20210615094933.3076392-3-ch@denx.de>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 11:49:31AM +0200, Claudius Heine wrote:

> +static int aic32x4_tas2505_spkdrv_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	u8 val;
> +
> +	val = (ucontrol->value.integer.value[0] & 0x7f);
> +	val = mc->invert ? mc->max - val : val;
> +	val = (val < 0) ? 0 : val;
> +	snd_soc_component_write(component, TAS2505_SPKVOL1, val);
> +
> +	return 0;
> +}

Controls should return a boolean indicating if they changed their value
when written.  Other than the hard coded register what's device specific
here?  It looks like a normal control with a maximum value, it is
unclear why this is being open coded.

> +	SOC_DOUBLE_R_S_TLV("HP Driver Gain Playback Volume", AIC32X4_HPLGAIN,
> +			AIC32X4_HPLGAIN, 0, -0x6, 0x1d, 5, 0,
> +			tlv_driver_gain),

Drop the Gain.  See control-names.rst.

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIm5AACgkQJNaLcl1U
h9BiHAf/fliuYAge5Ukx/NgOlna7YT+TGmHxRUEyKrNyrw2Y7IQKgptR3dElp3Ep
IZ1bbWar9WT8777vi7UXKL2muaNwSjPvf1kmVTkVAvJAHwtOOPFCfiRplZiTBUg0
sm2KLjkLuyF6sUO2x88AEUHrqDlgINzoIo59/hhAxU/RJpKOI9S3ghmV8NRFJvW6
B9eM0EMx8W4E5Rqi3P5LC+ki/T7+0qg8Y50EydvKbtCCV//HLlMgxABh8D2wzd0P
2rV+5l+du08/mm3rhBiuh003+NSz4nI481WvrLu2MdUmBPb71aoJYQLiGwXzomah
DaPpUm0KFW8qDnG9jyGJ1Bl+6W22Cw==
=rv4N
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
