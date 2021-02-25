Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979F2324D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhBYJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:54:59 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45394 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhBYJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:54:04 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2708A1C0B8B; Thu, 25 Feb 2021 10:53:23 +0100 (CET)
Date:   Thu, 25 Feb 2021 10:53:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        airlied@redhat.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org
Subject: udldrm does not recover from powersave? Re: udldrmfb: causes WARN in
 i915 on X60 (x86-32)
Message-ID: <20210225095322.GA5089@amd>
References: <20210224200912.GA27905@duo.ucw.cz>
 <452585d5-9d18-f5a8-9d6b-6d39aa037480@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <452585d5-9d18-f5a8-9d6b-6d39aa037480@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >This is in -next, but I get same behaviour on 5.11; and no, udl does
>=20
> Thanks for reporting. We are in the process of fixing the issue. The late=
st
> patch is at [1].
>

Thank you, that fixes the DMA issue, and I can use the udl.

=2E..for a while. Then screensaver blanks laptop screen, udl screen
blanks too. Upon hitting a key, internal screen shows up, udl does
not.

I try rerunning xrandr ... --auto, but could not recover it.

Any ideas?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmA3c5IACgkQMOfwapXb+vIK+wCfcBgCyVwqlwT9BhlQBINozkZu
6EMAn2cKNi7+6HsERfcaiq/3RwULgi5f
=/Y0f
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
