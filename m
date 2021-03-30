Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5924034EB83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhC3PF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhC3PFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9076E619C8;
        Tue, 30 Mar 2021 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617116733;
        bh=Ad141g+06Mj6kxA0pZroy2+ah/G8as714CayImOKtTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cs7vS3PK1/F3nSAzLn1MyTZrf6CiZ/ol6wLci6u05BjhP5fULglV2DEHFr5mtcQ7N
         9p5JpNmRdK+RmeQhdee4oa6MZW42laUwlviiywVlzvqIxYtXl5+NkS/0ddMLSwsvHu
         09Km333AQDu8pdrNl0ozwcW0YI5yBvblkC3MlJlt+3zDGRBm0aZFu1kvCOx6Q7xu6T
         bLqyVbsXupxbZW7K9flIi7SlcPPJX6pr5dMhQ7+oB1c7SaFsMsMpVI9acjeCbfRZAW
         3/ST9M76hf37Gp4luwzFb+pOppgbtC5bsHGoP2btgl1UOTlxjokRDE841IN6/MNev6
         rOnsRo00jf+iQ==
Date:   Tue, 30 Mar 2021 16:05:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ak5558: Add support for ak5552
Message-ID: <20210330150521.GD4976@sirena.org.uk>
References: <1617085972-6094-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <1617085972-6094-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 30, 2021 at 02:32:51PM +0800, Shengjiu Wang wrote:

> +static const struct snd_kcontrol_new ak5552_snd_controls[] = {
> +	SOC_ENUM("AK5552 Monaural Mode", ak5552_mono_enum[0]),
> +	SOC_ENUM("AK5552 Digital Filter", ak5558_adcset_enum[0]),
> +};

It's a bit weird to have AK5552 in the control name - any reason for
that?

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjPjAACgkQJNaLcl1U
h9DkEQf+Ol3YVjyLArT+FOt6sN18M3scwhn2xFn1/JazXAfsJTtIAzGG1YTItNdZ
bivEU66vjQ90ao+FNXapny//1uwlfOPFYVieXVmOlx05Vgl8TsApelVN8lOopNH7
48vLv4gGmIQILT3vTVbBbSetXJU8zIAQuSVCuZqt53I3KSaDd8KQyCuJmLKSfVfn
3dNIQoJBHGioNlPqaUgm8f73NC/LRJJ7AtCGD7ylRQ86RYmEwIaTKOCkBRKbns+r
UoYJ/GJ6vjLcFdjrvuHfc8Him6JpZlr5R6mHNanljL2+0moqW7b9NBeYPGGEK0FR
VrtzZNwhGtfXJPCazDJOKUIVD8qYpQ==
=VImg
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
