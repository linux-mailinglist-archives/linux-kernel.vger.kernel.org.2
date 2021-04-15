Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B776360FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhDOQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:18:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F02446115B;
        Thu, 15 Apr 2021 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618503486;
        bh=TmC1IQHS1RYCuzCjSF/kPNZCXV/1xAOTKEBh9ar9brU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ub8vMSiRxKNFK170DWbsNpCrmVTcRmruBiWXRaDFcYo9hF7DksN8llVMygQ7d0J4+
         yy91n8KTH6bYkMWu9rZ967MRdMG88tSl5bGLZmFV/hvLowL4TpnAqbqjYroeMUH33q
         oUOHXK+urSUqXPy8ZzQKgDMtTIpLxY/MgJdJi+t3tJSH1DIDUituhwzm01h7qN1n0q
         BX385pRag81rJqjzZ0C9oEqwY8U8Svxo7zN66gJiQUeHhJ1hG8mkKinGLny9jx8LHu
         tlDi5SpfHPfQdEoIFfxUT8iWPKTgUGJaj0uBg6vjksAr+O2Gnq6hvgwEQIsN3mvKCh
         wSIzdFcMYxkKA==
Date:   Thu, 15 Apr 2021 17:17:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        mirq-linux@rere.qmqm.pl, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Message-ID: <20210415161743.GH5514@sirena.org.uk>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
 <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 02:58:10PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:

> How about using a different API for ASoC only, since that's the place of=
=20
> DPCM. Only drivers that do not involve DSPs would have to to be changed=
=20
> to call the new snd_pcm_hw_rule_add() variant.
> Another solution would be to have a different snd_soc_pcm_runtime for BE=
=20
> interfaces (with a new hw_constraints member of course). What do you thin=
k?

I'm really not convinced we want to continue to pile stuff on top of
DPCM, it is just fundamentally not up to modelling what modern systems
are able to do - it's already making things more fragile than they
should be and more special cases seems like it's going to end up making
that worse.  That said I've not seen the code but...

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4ZyYACgkQJNaLcl1U
h9AydQf/elP8e5y2Rm/NSzV4RiR3KwwNw77ME5V2y+EN09TS7n5uXp7wYsiMCawT
55a3w2sy7ptihU413CYFHA1PepvHIAboGCpAqD/bpTTERQ2Cjh3VrpTNZVbOielO
zZUEO4eUZjU183jsHP+Dn2CpTpt4Hy6ud9icwHqg8qVjHx2TL9yaTzCtD9yi6yND
jsw5DzA43SNy5EnDGcW4O6eU8Uu33v1bNsxPJteqnuVtJ23eDrZ24lAjNF5fytuz
EUw6G/EgcW66sNtLwfc00urm11UPOyRa1zssiQuFxNbrkuZEbJ6wbKqNC7xN0/Mu
lbg0FchJftDPVI1snlP8fvxXuqbGYg==
=cMvM
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
