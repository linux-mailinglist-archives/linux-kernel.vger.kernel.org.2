Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE293F75A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhHYNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhHYNMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C894361101;
        Wed, 25 Aug 2021 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629897127;
        bh=vb6zlF1GgtQtao0qLGE24EzkOC2L1Rd7nI7ZvWXvlPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usJ8mFB/sj/sibWICxDGAIVmLfO19jadVac7bNbETo07f52t+Q1070PNnX7dCGzG6
         jc+T78jDPsXX/sG2mI5BAvK04emqpf3BZQSKHsvRx142bRPv396pi6ze+3HQ2y6rKf
         I5ulspPpLlI0Bzd3dcbEkxWSv9O3CZC7c2kzlkJzczfkUtsUQf2Naw42BgLc7lKZzN
         TFK69UZorXG8DokFa1beGf8clJ3G0TcmOJ/OJWuZ2WutM1I3PKorKredSV8XjaffcN
         JLsVxbn/hv9u75Pw1tlCst30dxg5FYytQT2+JhaozjTqrzmw2/wJzAIRQtIg6FultK
         A4Bq8aiJef9WA==
Date:   Wed, 25 Aug 2021 14:11:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825131139.GG5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 03:26:37PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 25, 2021 at 2:30 PM Mark Brown <broonie@kernel.org> wrote:

> > No, what was proposed for regulator was to duplicate all the the DT
> > binding code in the regulator framework so it parses fwnodes then have
> > an API for encoding fwnodes from C data structures at runtime.  The bit
> > where the data gets joined up with the devices isn't the problem, it's
> > the duplication and fragility introduced by encoding everything into
> > an intermediate representation that has no purpose and passing that
> > around which is the problem.

> The whole exercise with swnode is to minimize the driver intrusion and
> evolving a unified way for (some) of the device properties. V4L2 won't

The practical implementation for regulators was to duplicate a
substantial amount of code in the core in order to give us a less type
safe and more indirect way of passing data from onen C file in the
kernel to another.  This proposal is a lot better in that it uses the
existing init_data and avoids the huge amounts of duplication, it's just
not clear from the changelog why it's doing this in a regulator specific
manner.

*Please* stop trying to force swnodes in everywhere, take on board the
feedback about why the swnode implementation is completely inappropriate
for regulators.  I don't understand why you continue to push this so
hard.  swnodes and fwnodes are a solution to a specific problem, they're
not the answer to every problem out there and having to rehash this
continually is getting in the way of actually discussing practical
workarounds for these poorly implemented ACPI platforms.

> like what you are suggesting exactly because they don't like the idea
> of spreading the board code over the drivers. In some cases it might
> even be not so straightforward and easy.

> Laurent, do I understand correctly the v4l2 expectations?

There will be some cases where swnodes make sense, for example where the
data is going to be read through the fwnode API since the binding is
firmware neutral which I think is the v4l case.  On the other hand
having a direct C representation is a very common way of implementing
DMI quirk tables, and we have things like the regulator API where
there's off the shelf platform data support and we actively don't want
to support fwnode.

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmQYsACgkQJNaLcl1U
h9ANAwf/S6zYJSnp+10kaaC/6OAkXKT6uQv/eFL/gT8c/DjiGe755qgji1k8fsm4
X4tGbb8AE3mRGaTOdjQXjEsLNfTbrU/sWDOyZnFUv6U0uLEje+2hBdxqZ77XI9Uj
OK91Bq4IK9NFRO8yf18m6kP3prF3Fcl3VY4CIHxYMiCLf425F71PkJ23Nry+YQ7/
ERC/tv0yw+1TrTEu9m5nFoQS6PBe6t3iMMeiOcgh/WOVB2VsW6yc0XKgKt9IKfPf
HqtRuNTb9lJ94cU1vh1ZF209+cl9zpBSDQ/p0F64BVIbeBMRMSizgWwYNBJeekqq
n/bwINS/S8djAWxsi97Aeurv5Kcaiw==
=LW9S
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
