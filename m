Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E48375CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhEFVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:41:12 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46970 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:41:09 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1C99B1C0B77; Thu,  6 May 2021 23:40:10 +0200 (CEST)
Date:   Thu, 6 May 2021 23:40:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        tech-board@lists.linux-foundation.org
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
Message-ID: <20210506214009.GA6494@amd>
References: <202105051005.49BFABCE@keescook>
 <20210506082616.GA20224@duo.ucw.cz>
 <202105061042.E99B414F0A@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <202105061042.E99B414F0A@keescook>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > # Commits from @umn.edu addresses have been found to be submitted in "b=
ad
> > # faith" to try to test the kernel community's ability to review "known
> > # malicious" changes.
>=20
> I would agree that the phrasing here is sub-optimal in that it could
> more clearly separate a few related things (e.g. "malicious change" vs
> "valid fix"). If I were writing this, I would have said something along
> the lines of:
>=20
>   Commits from UMN authors have been found to be submitted with intention=
al
>   flaws to try to test the kernel community's ability to review "known
>   malicious" changes. ...
>   During review of all submissions, some patches were found to be
>   unintentionally flawed. ...
>   Out of an abundance of caution all submissions from this group must be
>   reverted from the tree and will need to be re-review again. ...

Thank you.

> > UMN apologized. Our reaction to their apology was:
> >=20
> > https://lore.kernel.org/lkml/YIV+pLR0nt94q0xQ@kroah.com/#t
> >=20
> > Do we owe them apology, too?
>=20
> I will defer to Greg on what he thinks his duties are there, but in
> trying to figure out who "we" is, I'll just point out that I attempted
> to clarify the incorrect assumptions about the intent of historical UMN
> patches, and spoke for the entire TAB (Greg included) here:
> https://lore.kernel.org/lkml/202104221451.292A6ED4@keescook/
> The report repeated this in several places, and we explained our need
> for due diligence.

Well, in https://lore.kernel.org/lkml/YIV+pLR0nt94q0xQ@kroah.com/#t
Greg says:

"Until those actions are taken, we do not have anything further to
discuss about this issue."

I'm not sure on behalf of whom he is speaking in the email (and I
believe he is unneccessarily harsh with them).

I could reply to that saying "hey, Greg is probably speaking only for
himself there, he certainly can't speak for whole linux community",
but I believe it would be better if TAB did that.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCUYjkACgkQMOfwapXb+vIgqACgul6m/ov6Iq3ywwLaZ5vbaC+O
7Y8An1htBprvIw05430rK0TG4qDiNmG6
=Mtog
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
