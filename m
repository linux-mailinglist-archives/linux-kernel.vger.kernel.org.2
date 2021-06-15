Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D43A7E38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFOMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhFOMcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A92A061420;
        Tue, 15 Jun 2021 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623760229;
        bh=Lb24lKt6MXXaaV3uULc+nVP704h2xY9cjKIbyq5ydTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtyeMzNjz9CHBPSCN2x9G3vn4txUnkQNsgXngp3iCbAOwwUcflMpOYcoRSsKpPkLL
         yX7/nwlWOT1M1FhN4SqHvYug2wAiciiNLjRU4Ts1NbrpSmiGfpCU9mcihq6p2SNkW6
         5OVbvRhNoGJSRDvCxEeTzeRd/UfkTnQyaZx1ibrXXCdfrwMrgFW2r4f1vVKBe5NuzB
         d+Y4uXzvZQfnL1QTOQsBy3/w4uJWKV/urP2IXs+E8A1kphGhhWu9f06Quv9TBEd4Td
         rtvd1YzZCygTFZiHbxbrzZ48i6ojA2In932FqDbH0dqzbLgzzLvN/FT87F441v36GD
         CMeb4CQTGIhjQ==
Date:   Tue, 15 Jun 2021 13:30:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Claudius Heine <ch@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic32x4: prepare driver for different
 device variants
Message-ID: <20210615123008.GF5149@sirena.org.uk>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-2-ch@denx.de>
 <20210615115438.GD5149@sirena.org.uk>
 <32b82dae-45ea-c6d4-77b7-c8a234cbf803@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <32b82dae-45ea-c6d4-77b7-c8a234cbf803@denx.de>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 02:06:30PM +0200, Claudius Heine wrote:
> On 2021-06-15 13:54, Mark Brown wrote:
> > On Tue, Jun 15, 2021 at 11:49:30AM +0200, Claudius Heine wrote:

> > > With this change it will be possible to add different code paths for
> > > similar devices.

> > > -	{ "tlv320aic32x4", 0 },
> > > -	{ "tlv320aic32x6", 1 },
> > > +	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
> > > +	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
> > >   	{ /* sentinel */ }

> > It appears that the device already supports multiple variants?

> Those values aren't used anywhere as far as I can see.

The point here is that you need a better changelog, the driver clearly
already supports multiple devices so we need a few more words to explain
what this is doing.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDInVAACgkQJNaLcl1U
h9Dp4gf/ZQ2xpw5GNRXy86pCeJSO0K6PI3Zc3o8poYFgEjZfhzK7YQU789f9J8rf
F/jcfgL0+w9jWwjTFv3kyyPJUUdxPB29u6n5pwleWkGEHQWxwn44slqR+9FQS8B9
8VT+Pu89UkfTgGQWAnOnaUom4VabbzDZivhyvk7EWL57gL/nqUF1q69AwR4AMaNj
Ppb6Y/f0s252hjPX26WjP9Ni5F2lleiumxgFvW3WRmpY3U/nJ4gvB3Nbzq3vcgsz
ICQ3wmyoK3OsouT+lAGa5hjsa12kTmQNf1vBkN58hz8eZj8i17O5brxZmv6JBPDB
TNk/VD/CS0KENTEccw40Vqe/8UCwxQ==
=JB4d
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
