Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F73E9431
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhHKPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhHKPEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:04:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3436060FDA;
        Wed, 11 Aug 2021 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628694239;
        bh=MEKpd2JWqLokdbSkx61YNu9WAsXeRAvvzmRiMnR33Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8WWgAepXBPBgkk9rn/oSYpYObUthAeDylwJBqIKptcOjxqjN8Ln3GNc/jpYGR0rs
         skB7OXc+ggRXWgUpNjMgrhD2NHQsvYaJvLmSYG+SQVCTh49HJS/Mx7ovF80qUVvHTi
         kHRECWufjTHQ+tVSFlyfGV7kLrLGIgqHv6bQQ7QMuO14lbKaZCWlEYbHg+XM7HVsaD
         5pua2rb2ZJfwY1ZAvsll0Pn3jNxeLpEilrqTcyFYKXWl5xmvdVFDhQA0tkSYbINN8w
         btgAxzAyhu10vWrVcUcGPdZ6oZPdHM5PiQVLRdxV5EWB/kPXzQHMB6ivsqTRyG++dC
         mxocrA/vQ99Kg==
Date:   Wed, 11 Aug 2021 16:03:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
Message-ID: <20210811150340.GG4167@sirena.org.uk>
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
 <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
 <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 11, 2021 at 07:40:59AM -0700, Doug Anderson wrote:
> On Tue, Aug 10, 2021 at 9:24 PM Stephen Boyd <swboyd@chromium.org> wrote:

> > Nit: Add newline here.

> How strongly do you feel about it? I purposely left the newline off to
> try to tie the devm_add_action_or_reset() more closely to the
> devm_regulator_bulk_get(). I wanted to make it more obvious that the
> two of them were "together" and shouldn't be split up. That being
> said, it's no skin off my teeth to add a newline if everyone likes it
> better. ;-)

TBH the newline looks off before I've got as far as reading the code.

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmET5ssACgkQJNaLcl1U
h9BthQf/fUr37JaTB6dDdW5fjOJOkbaLPTH1s18AdnVXPERV5CAFhW7MLpHpQtAJ
5YeFi0j26U5SHmdyk0gWijwgT+NqBzIyPQBC5wo8wr7XniyF+XZTRw68oVB+1UPW
3EO3n6jvlSqM9GKRHh3vvOcOeS7DKcUXWHlU15dfTMCPLpYebjU4/HVSADQMfifr
WBP5iTnEg4G/0lkihF5gZSdkV7o+3D8uXLO7Lo1SMyteEXeQO6eOl9MwRKl6dGPF
+VxNGfSwCWQjRMZIXGwvRdIUQejFJfsUHLb8OzZ85S+qOLiu5yPckjT19hJsF679
+ThWf0Yaw/mMpWppdr7wuQKgq1cCMQ==
=4IAY
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
