Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB15420B32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhJDMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233268AbhJDMwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 406E46103B;
        Mon,  4 Oct 2021 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633351854;
        bh=DEPXcUSwkuLvKTygrBe4+mBiRWgvdY/Y44xGRtMf2bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/lAB4Nxk794gnkR+a90qgK3LEiKjd12Aka1uL4kohj9qPLfYiRlpqOUWC66yUIXN
         +bywrc7QRJB9zbaCA7CDVrT0k4ub6MkrIBHh33vrTrelp5BgsZhWui4ctH47Fxh6oL
         e/SbulhfwqhZhbkPimdNnC9TFgDIctMXOeV0P4MwMAnMsXh/6Fclp8EJEbDE3J3ddo
         4B+CjbdbHybFlYMpkQVRoQtcvHdhtlvuAOPQwmESQVdyptJUAwA0WmId0YrZCU/P/F
         Xg3xNI3uQJ+fbj1brN/VDai97pYqukkm7sjeuBOEWhIJFblRZjU9O83tCAx0k3DI7k
         +5ZvpJurMMvVA==
Date:   Mon, 4 Oct 2021 13:50:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chien-Yu Lin <Chien-Yu.Lin@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yichin.huang@mediatek.com,
        hungjung.hsu@mediatek.com, allen-hw.hsu@mediatek.com
Subject: Re: [PATCH] ASoc: fix ASoC driver to support ops to register
 get_time_info
Message-ID: <YVr4rAbfS220ucDr@sirena.org.uk>
References: <20210820130210.3321-1-chien-yu.lin@mediatek.com>
 <a6336289dcf0009f2fc900c74f480b3c5fc0e8be.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HwyruTVZFZxRCbxq"
Content-Disposition: inline
In-Reply-To: <a6336289dcf0009f2fc900c74f480b3c5fc0e8be.camel@mediatek.com>
X-Cookie: If it heals good, say it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HwyruTVZFZxRCbxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2021 at 07:38:22PM +0800, Chien-Yu Lin wrote:
> Dear Sir,
>=20
> Sorry for bothering you.
>=20
> Does it have any status updated, please?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--HwyruTVZFZxRCbxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFa+KsACgkQJNaLcl1U
h9B44gf/fUMPWu+biAIQkH3GN1XQANoRFWcvCfbt7GluF29wUwCmTWWNbE+pOnbC
OIAiltjgUkizwDO5UqxK+geASqmI24BRHOFxgb+0MLsEkcrV+oQXfq1ysba61lvR
ATwkOnFC9x/QQA1h9bAf7On6ma6w4nRKdXiJm8HwzlS2oNuiG3Q8yt2FM6MbrnYb
HSc/8lWwFnyB68zIZgpOV9boN8mxC1q/QW4QaYa5eVfsreRm+qGVLsL+ZQYcxv4Y
NznJUih2U3JDc+4vXZSm9uta360+wMLE6q9wsuBin6SOUdQlE0+k9RKTG0UTVB2+
dzSebepqIS215S5s9gGIE0/xHYCRZw==
=r+iv
-----END PGP SIGNATURE-----

--HwyruTVZFZxRCbxq--
