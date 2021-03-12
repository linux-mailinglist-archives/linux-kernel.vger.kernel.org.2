Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3288338FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhCLOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhCLOYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3042964FAD;
        Fri, 12 Mar 2021 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615559053;
        bh=4fcxO7Smoa0cv+E1nslqtIlJSCuMHvSdEw8b0mNB4U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tO/PBxqflYey1RZMejEfbXJSNJjstUTyAxuftBDTRRX3JQXMVyk2pIehKsK0zfqKY
         OaeLkntuazPfukF2+hQbv2uA6vPj5imVNwLt6XsQIsTkOP1nGN6cTqAmyIivvBjzHo
         JCm0IJIJAdVTV1FypyOyTGOZKI+yOr0mvw2VWO/IO8GzV/WIud7Lcr4/6iWmpIz5vY
         Zak5js87cfi/bL3jZRII1dDN7FPBqardF1tuwn1c/ONj7mpZkwam4M7FVvLN+YigdP
         HdJ276wpNszh0vxzKhA1yey7kPI8yzjB6CKdV/O5wftcq/pOpPAKIGoMsPFZt/q87R
         u34VCvu33P3hQ==
Date:   Fri, 12 Mar 2021 14:23:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: core: Don't set platform name when of_node is set
Message-ID: <20210312142300.GG5348@sirena.org.uk>
References: <20210309082328.38388-1-daniel.baluta@oss.nxp.com>
 <20210309153455.GB4878@sirena.org.uk>
 <CAEnQRZB_VgsEPYgxtWQWUgs2+noRt1AMMHf2crJ_9Hg7s7NJ0Q@mail.gmail.com>
 <20210312104931.GA5348@sirena.org.uk>
 <CAEnQRZDe_Q-N7L_7z7aVz1o3guKd6R+WFrOfT9KPbggJP8SPZw@mail.gmail.com>
 <20210312115748.GC5348@sirena.org.uk>
 <CAEnQRZAAU34YS778WJVD6uubSwQxjA-5LTG9g0CvSdSZOuO+tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <CAEnQRZAAU34YS778WJVD6uubSwQxjA-5LTG9g0CvSdSZOuO+tQ@mail.gmail.com>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 02:37:30PM +0200, Daniel Baluta wrote:
> On Fri, Mar 12, 2021 at 1:59 PM Mark Brown <broonie@kernel.org> wrote:

> > No, just the opposite!  If there's an explict name configured why do you
> > want to ignore it?

> Because the initial assignment:

> dai_link->platforms->name =3D component->name;

> doesn't take into consideration that dai_link->platform->of_node is
> also explicitly configured.

But why should we take that into consideration here?

> dai->link->platforms->of_node
> configured and we hit this error:
>=20
> soc_dai_link_sanity_check:
> /*
>  * Platform may be specified by either name or OF node, but it
>  * can be left unspecified, then no components will be inserted
>  * in the rtdcom list
>  */
> if (!!platform->name =3D=3D !!platform->of_node) {
>     dev_err(card->dev,
>     "ASoC: Neither/both platform name/of_node are set for %s\n", link->na=
me);
>     return -EINVAL;
> }

OK, but then does this check actually make sense?  The code has been
that way since the initial DT introduction since we disallow matching by
both name and OF node in order to avoid confusion when building the card
so I think it does but it's only with this mail that I get the
information to figure out that this is something we actually check for
then go find the reason why we check.

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLeUMACgkQJNaLcl1U
h9CxEwf9GYlTDgLnBKPQQLdh53qJmZp0mq31jrvlr0BU1jZT1bUP/jkJAufFi4fz
2YIwTI8K79Pj/AoMoQXJ1L2XOedZ7/AspZFanBhgUovzs+f36XfW00fum5QmG+A0
W7wLEhoJuoUxGOOJ0Z4EYRT07LFfvN23lYoNxKBb0gqO4FxnJEAe1E5+O9n39zTO
yCdwDl0H5JhLp8U8SuutChBnt87l474a04Tx5GdCRZ3yAvwuvvNLZ74/68We+82F
NlPAf+g2d4ojF1UqCYtgR59jPLpTmJmDtMfcgBqtskFMeCtqrM7B3Jqz8O1b8Ix9
/Pvscq3dBWICZSt7Qj9Ilh1IScjMdg==
=CF3l
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
