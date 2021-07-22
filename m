Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDA3D230B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhGVLO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhGVLOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C9460FF4;
        Thu, 22 Jul 2021 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626954900;
        bh=RPZVwNiL1LbskPWPDNeRTevYMqkLaT9s20LL5W9zubc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4h8DPv0wG+/e6Xljh6Tj+SjMCDix7iCtqIA1n8H63QeS5149I81MhgoiWdNJ4YIX
         ua8kdrsgCttyLLXsr20mfxHNjpZYyEsRlflimlypknJOw0UVprfPXVRQ86/XCvtjLH
         eUXv/J68kHYjbQ7ZV4NKfmDuVzU5hYUsD5x+KQCL+UltEVx0tao8SVdlLAUjyQD0vj
         TnJsNmd33X6aitkeouwwIov/fle4sOrrrs+hSr2mq+oe2QqekNvb0YP+5QtdrAwuoc
         T19LoXlihIfgLiulsU81OLFAAlCA0DrREf8MD6veekMwq9sBgPM3T9hE1TYlABhTtr
         NFMGTm/KL9WEg==
Date:   Thu, 22 Jul 2021 12:54:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] cx20442: tty_ldisc_ops::write_wakeup is optional
Message-ID: <20210722115453.GC5258@sirena.org.uk>
References: <20210722115141.516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20210722115141.516-1-jslaby@suse.cz>
X-Cookie: Who's scruffy-looking?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 01:51:40PM +0200, Jiri Slaby wrote:
> TTY layer does nothing if tty_ldisc_ops::write_wakeup is NULL, so there
> is no need to implement an empty one in cx20442. Drop it.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD5XIwACgkQJNaLcl1U
h9B/iQf+MwQzsWT0jCi6a5UsrvNAyp0wA49hul7QMIqXD7tzpzsyETEG55NiqESV
1Wl5utvCxoMtIhu3ys7sQT5WCSyYYstoq4OnDrvMgTHUTZjAzZSgdlM6ycHMsx9H
EMrs4DczuoA3iZSbOXWBrSNdVfOJK//iDilqWNRlqHQ6vvIeXwrJQ8sa37kyBZpe
nyUkJg6ZGly1h8Okqqwg3EgxV4PozyfEkJfAC5lRTipb/KhZtH6UZ+SP2sm/Zd7X
gfxyyQMY04vnxI6QWafMA4S9dPIvqdXDtTfXG12Z6cMCqR0EfSgF1+bBdqPgb/mO
9zzZVg5qVrlAaAxtxUTAxb89SVuoxg==
=mL+P
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
