Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6F34ECB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhC3PgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhC3Pfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7738619A7;
        Tue, 30 Mar 2021 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118545;
        bh=nMNslYbP7bsoxUxRERQoAOXe4dowyalkqJZsnQN81Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+KJceb+4H44bWJcmqmsx8kpjhc0T+EFlJeJuTwyk2s+ML8d8mWeJt+GpP1agJZL+
         54k8PHVJlw6HVPBNX61mb+yHGQlQVWwGcdmrWa5iT09GRbvJOc4TRGHRgj1q4kEkQc
         GvZP7xqE3SULPPZNK+DTG6mb4tjre8Y7H/T9C/4QKoYygZZfnS2aMeBfJYa6pk2g0s
         xHyfPzWyRgFFRQ1ILIVTVxVy8PXDlBTMECNrKLqtz7s/zSSLxvnJ7pkaDmqmblrGaT
         9y2g3BfhOM/vBG3ano+5tVksJ6JOh1uHxJR9G5SpmbA9Mc5bGRBM2PgFQwH6qKDWLr
         1bcYGwdtds7zg==
Date:   Tue, 30 Mar 2021 16:35:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, kent_chen@realtek.com, jack.yu@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
Message-ID: <20210330153534.GF4976@sirena.org.uk>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
 <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
 <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 09:12:11PM +0530, Mukunda,Vijendar wrote:
> On 3/30/21 7:52 PM, Pierre-Louis Bossart wrote:

> > > =A0 static const struct acpi_device_id acp3x_audio_acpi_match[] =3D {
> > > =A0=A0=A0=A0=A0 { "AMDI5682", (unsigned long)&acp3x_5682},
> > > =A0=A0=A0=A0=A0 { "AMDI1015", (unsigned long)&acp3x_1015},
> > > +=A0=A0=A0 { "AMDP1015", (unsigned long)&acp3x_1015p},

> > This isn't a valid ACPI ID. AMDP does not exist in

=2E..

> > There was a similar issue with Intel platforms using this part, we had
> > to use a different HID.

> Is it okay if i use "AMDI1016" for ALC1015P?

That's valid, though obviously you might regret that later on if someone
releases a CODEC with a 1016 name (equally well ACPI being what it is
there's no good options for naming).

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjRUUACgkQJNaLcl1U
h9BCzQf/StVuObimo3H3q9bs6c5tTcFh1Iy8jt/jk6W6jV3j7f5XUhNvmMHqCFWy
e7siS5UjGpCDRbZDIC+QnNZvt3t5krLRijboULo8jAreEkMisQLv6X3nNKoXMSmY
wnSrnJpzwIFKcqUrCeLejk8KAgtvHwxKFQc5u7MEXrDQCCzgIU809WbtgmpPd+VV
mwpyT59KIHjzrSJPZ+29Oco3XFm7YM22pLs0RBNki3OnG4jWy9wJu6Ppk/47RQIo
iilrSirO96NhP2w6T/dDxf1x0fo9aa7Exbd7kYvV05PZBPXJq2cVUR+LIqc26o/y
+wCtkJBgWlnyqlLNavuKel4pWEgeZw==
=LM1I
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
