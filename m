Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47D429610
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJKRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhJKRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:51:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A4160EB1;
        Mon, 11 Oct 2021 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633974594;
        bh=0Tfup/0X75Q3iALjTKW9IdjFBObtInoYJEKNCIloWrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mb5V/yUwG1OcDWVLCliR07688EKA2u/BtFtpW5YsbH8UdGMtF8HUBv+pvJCUHs2rv
         JoNTVvCBjEd8i7+GDCPdHAHUqCSazXDvVgR3u7aH8YA6+fk1Jt3Z5V2+txaMCCmSP4
         hwXWZYjmvL9E6lAGyerfpzc0TP1hZkcBVy7Gr09NNT5S0TiZXQdDYIYonSjZXQO0If
         oHk6LNvxqqlyBND1FP8ma20OWh7dsKTXCsvCdJPcnYdGL2DKTBz7HiV0mz/XBS9kb1
         1ZLrnunVuLF5KLvuwsNijMjUXb4QykRkryHWQcMsTX9JZAfH5b5ne3p4+P+7+KKtGb
         oewgg4ZuOBFpA==
Date:   Mon, 11 Oct 2021 18:49:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, David.Rhodes@cirrus.com,
        wtli@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoc: amd: create platform device for VG machine
 driver
Message-ID: <YWR5QH1lYqiT1cX+@sirena.org.uk>
References: <20211011184715.61573-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZJ2pBbMc2TIawQ/G"
Content-Disposition: inline
In-Reply-To: <20211011184715.61573-1-Vijendar.Mukunda@amd.com>
X-Cookie: May contain nuts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJ2pBbMc2TIawQ/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 12:17:01AM +0530, Vijendar Mukunda wrote:

>  		pdevinfo[2].res =3D &adata->res[2];
> =20
> +		pdevinfo[3].name =3D "acp5x_nu8821_cs35l41_mach";
> +		pdevinfo[3].id =3D 0;
> +		pdevinfo[3].parent =3D &pci->dev;

This appears to unconditionally assume that any machine with this
hardware is going to have exactly the same CODEC/amp combination - that
seems like it's going to go badly at some point.  Shouldn't there be
some other check that we're instantiating the right machine driver?

BTW your clock appears to be set quite a way into the future (possibly
about 24 hours?) which is confusing things.

--ZJ2pBbMc2TIawQ/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkeT8ACgkQJNaLcl1U
h9Djhwf/ZavfF+JGMWA/XWM0KiIkQXHWhRAw0Ql/y3suDpNI1W2VtO+lYx5JJTmf
HMLPXKxLQomTujyTppWnz6abtrROefKDPzWNPRTVBA7CsQNpu5+a27qGdSXgJzZ2
Z531dwpZz+w2ITM4nrrlr+0UmGJJVNSfVWO1IVTSPYIIKA1rK6xtl/qWA7C6hU1x
XDXt7Inokj6u7e/mEU1nypwYp7cESxC0aTyHZ/RRVZV0xjAUqshu3l9mU0nEdgd7
NGfXMISM6zLURSZqfimjFpiomqU7SNv8HbQbpnD52r0v+Ls/4q7WAYpop+wMNQLz
eSybP0NJpYLXH1QyhNL0Q3jYCn3qyw==
=+nOi
-----END PGP SIGNATURE-----

--ZJ2pBbMc2TIawQ/G--
