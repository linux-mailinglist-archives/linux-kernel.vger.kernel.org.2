Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0C3750AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhEFI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:27:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59384 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhEFI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:27:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E34671C0B87; Thu,  6 May 2021 10:26:16 +0200 (CEST)
Date:   Thu, 6 May 2021 10:26:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        tech-board@lists.linux-foundation.org
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
Message-ID: <20210506082616.GA20224@duo.ucw.cz>
References: <202105051005.49BFABCE@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <202105051005.49BFABCE@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Report on University of Minnesota Breach-of-Trust Incident
>=20
> 	or
>=20
> "An emergency re-review of kernel commits authored by members of the
>  University of Minnesota, due to the Hypocrite Commits research paper."
>=20
> May 5, 2021

Thanks for doing this. I believe short summary is that there was some
deception from UMN researches in 2020:

> 2020 August:
>   - "Hypocrite Commits" patches from UMN researchers sent to kernel devel=
opers
>     under false identities:
>     - Aug 4 13:36-0500
> 	https://lore.kernel.org/lkml/20200804183650.4024-1-jameslouisebond@gmail=
=2Ecom
>     - Aug 9 17:14-0500
> 	https://lore.kernel.org/lkml/20200809221453.10235-1-jameslouisebond@gmai=
l.com
>     - Aug 20 22:12-0500
> 	https://lore.kernel.org/lkml/20200821031209.21279-1-acostag.ubuntu@gmail=
=2Ecom
>     - Aug 20 22:44-0500
> 	https://lore.kernel.org/lkml/20200821034458.22472-1-acostag.ubuntu@gmail=
=2Ecom
>     - Aug 21 02:05-0500
> 	https://lore.kernel.org/lkml/20200821070537.30317-1-jameslouisebond@gmai=
l.com

But there was no deception from UMN in 2021. Yet, we were
spreading... let's say inaccurate information as late as this:

> 2021 April 29:
>   - Greg posts an update on the re-review along with some more reverts.
> 	https://lore.kernel.org/lkml/20210429130811.3353369-1-gregkh@linuxfounda=
tion.org

# Commits from @umn.edu addresses have been found to be submitted in "bad
# faith" to try to test the kernel community's ability to review "known
# malicious" changes.

UMN apologized. Our reaction to their apology was:

https://lore.kernel.org/lkml/YIV+pLR0nt94q0xQ@kroah.com/#t

Do we owe them apology, too?

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYJOoKAAKCRAw5/Bqldv6
8nBJAKCXH41qp7GFDRZZKr5FKX6sgAgnWgCfQVKch1WxtLNI56BmgVMbctBSb20=
=zYAO
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
