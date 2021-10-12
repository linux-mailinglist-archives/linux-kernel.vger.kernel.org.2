Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD542A273
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhJLKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJLKmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF1A561076;
        Tue, 12 Oct 2021 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634035235;
        bh=8Mo99hNpbVCPntx6qXcJMQQ8Zr6U+b7gnjdoRm7v9wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuY/0Ev7PWWGp+fKGsfoZGUoYxRammnb3CLy1qKbZ5vWTCmfWRDkQl6yG4b0f6BPc
         M62CbOC8WSvWc2uF+xtTPJ4nyGjziTFUrBHorz+z/exgwe0L0KVM/a4bD/6pe6Mow+
         KzeapNdc4esEnUTr4rb8pe8ybB78ZHGdHTOB2IxETMO9g59Q147K44yyZ2OlE8af+z
         GCOG/C9iMHskpxKn3Wjs3OiCeplGvPfmJMWQL+P5iJFshfPjf1NynFaQwJAHxSzGx1
         vPXNLQN0UQPIS24+9CG6fFz7gQN6nGMtBMi0vnkWgKg/UYFgH/mKnoTYAUAgwcbaxv
         Fxj0/o9aWrzpw==
Date:   Tue, 12 Oct 2021 11:40:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
Message-ID: <YWVmIKM99Zp/eVLZ@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-7-nikita.shubin@maquefel.me>
 <20210726165124.GJ4670@sirena.org.uk>
 <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
 <7cd9ccc118c1955b5f3b48f6f8a7157a72d5213e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Xxb2RUjTwxQcxkX"
Content-Disposition: inline
In-Reply-To: <7cd9ccc118c1955b5f3b48f6f8a7157a72d5213e.camel@gmail.com>
X-Cookie: You buttered your bread, now lie in it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Xxb2RUjTwxQcxkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 09:25:15AM +0200, Alexander Sverdlin wrote:
> On Mon, 2021-09-13 at 23:43 +0200, Alexander Sverdlin wrote:

> > would you take the patch to a tree of yours, please?

> I still cannot find this patch in any of your trees, but I've found this =
one:

You ignored my question about dependencies:

    https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/

so I've no idea if it's safe to apply or if other people might need this
one patch from the middle of the series.

>       video: ep93xx: Prepare clock before using it
>       dmaengine: ep93xx: Prepare clock before using it
>       ASoC: cirrus: i2s: Prepare clock before using it
>       pwm: ep93xx: Prepare clock before using it
>    =20
>     Nikita Shubin (1):
>       ep93xx: clock: convert in-place to COMMON_CLK
>=20
>=20
> ... which claims to merge both "ASoC: cirrus: i2s: Prepare clock before u=
sing it"
> and "ep93xx: clock: convert in-place to COMMON_CLK", but they are actuall=
y not
> merged.

No, it doesn't - that's the cover letter from your series.

> Could you please consider ASoC patch, while I will resubmit the final clo=
ck conversion?

So please answer my question then: what's the story with dependencies?

--+Xxb2RUjTwxQcxkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlZh8ACgkQJNaLcl1U
h9DJkQf/YWStIGUowcgzXW+8LvZgoJQGF/Pz4DneFx9CyXhIuKBospPojXunjUn5
/p7TXRzlC3nr7JKqqu/Yz3uQ0d5JiJ87XsRJe53YUGQbQ5AjnQ2cN6Z3s8MJEhbe
F/cyYUXDCWnt4dTsTDmWEjrO5I37Lu62DWdEtuENbkh9tILWF8nPtBpxcuU7Bois
n5u+A35nICssRSLyI3RYVQJyovkzjHUl06oT8L4wKiAgyJS7VoiJUv1dYP1QbsrG
v1mDYcqerGWuRykGCL6nXzSeso0LFYy5wqEufHzlxP4WwwK0fcq3ISt0mlK7hVCo
Mu7TVhcs9l8yG3imacbH5sL84IDU9Q==
=XWRi
-----END PGP SIGNATURE-----

--+Xxb2RUjTwxQcxkX--
