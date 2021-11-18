Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC90455CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhKRNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhKRNwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:52:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E032261A55;
        Thu, 18 Nov 2021 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637243394;
        bh=EHKSkKOrT01rZkYPW4UuImNyGa7Bn6ryCr5Bieip2ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BND+dl5nE0O9ftOYY91HxJfmFIo5zY5u6blBHoeIBAfPkhmBYBf2YrJZEPHrO/1W4
         mbsK8jeuqc/Gd7qDyvul5KyVKdtyMnrqbXbjPIutxFg7URfsT0HWdGnOgpXzm6Abai
         J349q2ySUxxhC7TqS3qrnYQv7StSQNNpEoAzLoANJWLOKh1Bz1mway82MSlHRAS4mH
         7Vc7jsbB8fs9rjS5QbhOBHi/q9jEq/n8DtP5vvQBlMjzAPVoWMOOc6Nnu2JN1uZGy3
         weJ468p45cEGPax8dYY0nbi68tgMdFyAZqDEL7lK06yTbSnPXNvbJC5oUW4psoqgvi
         RxLknQozTP2Rg==
Date:   Thu, 18 Nov 2021 13:49:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sameer Pujar <spujar@nvidia.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/16] ASoC: tegra: Fix kcontrol put callback in MVC
Message-ID: <YZZZ/Qk2/XX20qSS@sirena.org.uk>
References: <1637219231-406-1-git-send-email-spujar@nvidia.com>
 <1637219231-406-13-git-send-email-spujar@nvidia.com>
 <s5hzgq1io88.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3p2xpiMr+J6zdqeh"
Content-Disposition: inline
In-Reply-To: <s5hzgq1io88.wl-tiwai@suse.de>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3p2xpiMr+J6zdqeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 02:32:07PM +0100, Takashi Iwai wrote:
> Sameer Pujar wrote:

> > +	old_mask =3D (value >> TEGRA210_MVC_MUTE_SHIFT) & TEGRA210_MUTE_MASK_=
EN;
> > +	new_mask =3D ucontrol->value.integer.value[0];
> > +
> > +	if (new_mask =3D=3D old_mask) {
> > +		err =3D 0;
> > +		goto end;
> > +	}
> > =20
> >  	err =3D regmap_update_bits(mvc->regmap, mc->reg,
> >  				 TEGRA210_MVC_MUTE_MASK,
> > -				 mute_mask << TEGRA210_MVC_MUTE_SHIFT);
> > +				 new_mask << TEGRA210_MVC_MUTE_SHIFT);

> I guess this test-and-update procedure can be simplified with
> regmap_update_bits_check().

Yes, this is exactly the application that _update_bits_check() was
written for.

--3p2xpiMr+J6zdqeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWWf0ACgkQJNaLcl1U
h9D8jAf7BVgrmUDkAqGQIkedLOdK24v1N/Gp53lTao7cwUgUy+beBW3YsQU0w7Bg
r1BcXrjWpusKLTBgo6Y/8mr2bzktqToKmlne3trxVUS/EWSGWWq4JINEw8SajpqT
GcSmqwJ6BpF3giLyFPUTE7jJBGsv19qEohP3OUrW7Kph1GP+pm+LV/epWBmHamwN
XVTyPHxk0bmxtsOXOTHi3+14iD0CwpyO8AWsxFxx70ZKjtL89v5IthEZzy98ZQV7
4uZyh/GXN97rNizvH5k1DCjwnfyAUxvkP8L2ksIQ00RRfqDv2TmBujw1AetHsJ+g
j3GyV0p/jUwFxXiSZ8t2+Vho2oUucg==
=u/ik
-----END PGP SIGNATURE-----

--3p2xpiMr+J6zdqeh--
