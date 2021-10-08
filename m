Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7F426B36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhJHMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241844AbhJHMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E190C60FC2;
        Fri,  8 Oct 2021 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633697487;
        bh=yN6jNyqY0tdmECHxR1wtroW8A8lILV+Zejp7DTxpLgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/1sMv63+8hQRt+O4kGRixzo+6wh7EcvWsWC/P+Su88x09542URplEQbblqIKy14H
         ohLwCXe19nsPPwS08M9VoPUYcOhxvyiBAt/mbgq7HnWVGrYB/v/HB33Punj8Re+n4z
         40Nukq94SbgsBfxJeUb2MJF34Dm6pVrm4+qM3Gp//b+68yS7qBoIDDXvk33wSh8Jht
         KS+mE6GpTp8VWblR4fM3OVa0VyOEe50JzGey99xCzcLxCabgvo2SCNHFoR1rDTa0Wi
         Yr2kT46+UtEHbu84uiAwghJ2v6B3O6DV/kXmmIFccUauFbo+vgGhLkhCsoOYyVn3H1
         WCj4T62ZErGcA==
Date:   Fri, 8 Oct 2021 13:51:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: Re: [PATCH v3 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
Message-ID: <YWA+ykStTEyzRbEy@sirena.org.uk>
References: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
 <1633668612-25524-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msEr/jdBSU575gqS"
Content-Disposition: inline
In-Reply-To: <1633668612-25524-3-git-send-email-u0084500@gmail.com>
X-Cookie: When your memory goes, forget it!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--msEr/jdBSU575gqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 08, 2021 at 12:50:12PM +0800, cy_huang wrote:

> +static const struct snd_kcontrol_new rt9120_snd_controls[] = {
> +	SOC_SINGLE_TLV("MS Volume", RT9120_REG_MSVOL, 0, 2047, 1, digital_gain),
> +	SOC_SINGLE("SPK Gain", RT9120_REG_SPKGAIN, 0, 7, 0),

Volume controls should end in Volume even if they don't have TLV
information so applications know how to render them.  I'll fix
this up as I apply.

--msEr/jdBSU575gqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFgPskACgkQJNaLcl1U
h9DbbAf/ViOSI75UvPC1A+pp7ykPb2CF0lo+AsflYDs6bPHdCBnzsKecBpQB3A8K
gLHD6jFdEEKhAwhvLpzQqLU5ytwDkPrY81ebrgwOrIzCHR0jk9dq1ZYEyim8k0UZ
TBmFmIgQ+PEQ/JjkQKCPu20jzZBVFI5sEZ/Q6Ar1mWVO/GnVuxWF3Kw9fCxbxh2Y
Dan9EeLRo0PHBT6DXjh3fV1kexTV30npTLgff3XGcAoXKjgLHLfZTEgPQuxqfDLX
NlRK0djS7ZwXEEGFwcWE+w7UBfZC/I/wxeeGS1VsCVTwMHTPIVYe+Ip4Dj+8hbBL
xfDreeXlMm4P8GvDPbY4dFVNylrM5w==
=+qxg
-----END PGP SIGNATURE-----

--msEr/jdBSU575gqS--
