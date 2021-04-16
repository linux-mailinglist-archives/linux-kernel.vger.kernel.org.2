Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C353625AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhDPQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235719AbhDPQcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3618861002;
        Fri, 16 Apr 2021 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618590715;
        bh=jur2fTEdYRNCY9C314G21CAjYJzcRNFZKz3QbNsHrdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ2M3ReXMpR06PJpEQU1pIiWAML+ojYlvdMpWtZb/6H63Zqh6KzyNlLHZUP6KJEQs
         /T6ufATom9vfHolMAM3+jK9RkdImi4MjQ7wDCPzHVovNwskoE4oL1CgJgaIyTzPwp4
         3jAalUaJZjxcURIwwMWZQEJeC0813m7D5sWfkAnkSskX0ykTqhDcph1f55A71TMj7v
         C84uSqwkbBW6Te65lXxLibl9uUgzPexzTluts03UW0Q08QihHgGKZpqcGJ/4r2Ks0P
         vsEJxsnC8csgLKEcpvTRULqwbFtH035ZT2E5PQyaZdn+4wZP7cvn0J+dGNo7KRv8dx
         +IOSaVG6A0RxQ==
Date:   Fri, 16 Apr 2021 17:31:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        mirq-linux@rere.qmqm.pl, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Message-ID: <20210416163131.GI5560@sirena.org.uk>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
 <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
 <20210415161743.GH5514@sirena.org.uk>
 <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
 <20210415172554.GI5514@sirena.org.uk>
 <ad5d556b-601f-c6f6-347e-86a235237c02@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline
In-Reply-To: <ad5d556b-601f-c6f6-347e-86a235237c02@microchip.com>
X-Cookie: Snow Day -- stay home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 16, 2021 at 04:03:05PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:

> Thank you for the links! So basically the machine driver disappears and=
=20
> all the components will be visible in user-space.

Not entirely - you still need something to say how they're wired
together but it'll be a *lot* simpler for anything that currently used
DPCM.

> If there is a list with the 'steps' or tasks to achieve this? I can try=
=20
> to pitch in.

Not really written down that I can think of.  I think the next steps
that I can think of right now are unfortunately bigger and harder ones,
mainly working out a way to represent digital configuration as a graph
that can be attached to/run in parallel with DAPM other people might
have some better ideas though.  Sorry, I appreciate that this isn't
super helpful :/

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB5u+MACgkQJNaLcl1U
h9C7gwf+LLB68ItVQbC2IRYlF2Sl8tu40UQ5YKNuZNaWzg6h195x+OiLY3Wb5Ok3
h90k1H+NLLAj2VLjychn83Z6gS617Zmm9Ti41SjGp7glW2aCdzzPXkRlTUvuxYf5
alsSTimD5tFa5PqiM1YWu3l9BKVOrM9cG7qdNKHjaJDuEdiDUF1F80Xskey8/yga
7vO/kGT+0qmtS/oECPf2JSsYlPcWjKMS3Zph74/j70WlHWuSSf6iazxZUZW8eHid
6E3dM6KGD51C2ZqYgv9HzyDmd7lcAkpEZWAOSvVA+w91B+NSDCGiL8Ps5NBEwRdw
j+dYkIs39Iq8VrPxC7QP/a7IVea29A==
=3vRx
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--
