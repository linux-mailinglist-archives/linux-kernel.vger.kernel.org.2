Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9820539BAE0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFDO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CBD1613FF;
        Fri,  4 Jun 2021 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622816824;
        bh=jyhVkbKJAz0dmq112rRFC095rYggluvWOSdsX33VwH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdRa3D4oZLi1oEvo/9MiY1MeqHrxwedWKUJXg8jlVZMBtC38arPLQYZ89HzUb6K3f
         Fuw2ZUQwFAr/HIkypXAqpkbsYit3zWS+BAfx4LspLCeCZMZjJlc5+MzKIh8sNknT19
         crTdnv8PtpNFuPYCCP9hUrSn2dGVke4+9Q2U+Rhtzf+slCDrYpxcCzUHBOtErmWUxW
         WYhGdnrv34Ct7jYn8f7/OGs1SQryrFMtYTvKDVOlMrvh9vz28E70gf/eV8ypsAdkqc
         Xazzu2WFiM67ktsiPnPkDvhPWorkULPj1IAgtbDwZR3XoR4g+WgGO+527Ey3J3bYW9
         MKgmXHxWvkvgQ==
Date:   Fri, 4 Jun 2021 15:26:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Remove unneeded semicolon in rk817_codec.c
Message-ID: <20210604142652.GA915@sirena.org.uk>
References: <20210604030045.7360-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20210604030045.7360-1-wanjiabing@vivo.com>
X-Cookie: A modem is a baudy house.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2021 at 11:00:23AM +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./sound/soc/codecs/rk817_codec.c:49:2-3: Unneeded semicolon

This doesn't apply against current code, please check and resend.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6OCwACgkQJNaLcl1U
h9BqXwf9EWS3l1/OCYkMhCMSB42ss/Z1//ss+FoD7LRk1cWvjfFDmUMeBV3W6eEs
ajDvZ5T4wCwqaqePWqilqBMvfp7oNYSbGl592lyIyq6OR83bvcSCvBnpqUr27S2m
WIQeg5mFXlbbUam71Fu3X1qECec3kUSA8vOhqYBsSsnA7Rgek2kEQq6N2q9yADob
DLBxqNodF6Guws51tg2NE/ZGgaHwaKdqcOhR7wX0rwfkTQQoE6AfEyM7+JMIZiUi
5xT+eSalT3l8qs5JNyyjaVgOhh6MfiHc1wnVCZcBUpEVxFlVMEJ2LUkdLBLjJ5nd
G2CU/4LI27mzAg/RwKgBa6PM5LSXrw==
=28E5
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
