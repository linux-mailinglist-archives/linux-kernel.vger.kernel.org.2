Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E508444AEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhKIN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhKIN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:29:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCDF361159;
        Tue,  9 Nov 2021 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636464383;
        bh=J2HKc1MxYjxe9gpE69xTbA5+nRuj4eiTFvnENQOr37k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/gz9DKhinbAoV/QCOVsqbhS3HF4+Pt5r4HFYK237NhSc01SfbPG6nkny+MI+ARf8
         8P7upGQlo8lYGWFhik7IN/Jum/EauOkZZVVkOnIQud6jIQ/yr53iJ5rgezpToOCRAE
         DF7PQXrTs+SHEqu5PeBjuls6FEjnEMDr1Q1b753FI0+DvIVxKTQp3MpQtLcf+S44ei
         axkOjztraSoaXVPGqChqbzNPIIQUnwcGsbZDC4vpxi0VHjQlaHooMe+/xJKLsGnr+d
         5S6HgE7TwHTejEfB7aPKkpW6CfNvNU5x11c8NUSR789I5VOZEQ3A7bRkp1FAMqmdQQ
         n5unOukEaiM4g==
Date:   Tue, 9 Nov 2021 13:26:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, oder_chiou@realtek.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        allen_lin@richtek.com
Subject: Re: [PATCH 1/2] ASoC: rt9120: Update internal setting and fix auto
 sync problem
Message-ID: <YYp2+gqjn6+M/hZ7@sirena.org.uk>
References: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
 <1636439024-15877-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HVGDxR7W1SSa3wC/"
Content-Disposition: inline
In-Reply-To: <1636439024-15877-2-git-send-email-u0084500@gmail.com>
X-Cookie: Elevators smell different to midgets.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HVGDxR7W1SSa3wC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2021 at 02:23:43PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> - Update internal setting to fix issue.
> - Disable auto sync if fs is divided by 48.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do.  When splitting patches up git gui can be helpful, you can stage
and unstage individual lines by right clicking on them.

--HVGDxR7W1SSa3wC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGKdvoACgkQJNaLcl1U
h9CDUwf/empk/L0AB6TG5uu8RYPa6l2xwNsGoK24S7mFsEIsG7ykomIbzY5cn5de
O6C0OBLyNOZwl6WprWKMRGFtj+yzsAFijk47pq3FYOwEU/EHRt/WtBrcLSlYZQen
g913L88YViV5l7kCF5LgXQuetDkPMU+uXIFY74zLAPEpE9rCGfzmYkbEAp26bgtm
b8AMzlh4BBH7YquiB1yyyN23Zf8V7VdUZxzaCJZmLbYXS+iiwFzbTb69FdZvRIwD
6FVq8+ox0ftvpU4q94bPq/dZCWMIDdfXa1jLRl6axzfGWErvYA+p1+aVyJoy/x2T
SFvXJh3bMIDIH8XJ7dfn2enhoT62AA==
=sDK0
-----END PGP SIGNATURE-----

--HVGDxR7W1SSa3wC/--
