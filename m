Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9833750FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhEFIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:39:23 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60594 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhEFIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:39:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A31731C0B87; Thu,  6 May 2021 10:38:16 +0200 (CEST)
Date:   Thu, 6 May 2021 10:38:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: An initiative to collect unusual kernel messages and
 automatically create bugzilla.kernel.org bugs based on them
Message-ID: <20210506083815.GA17544@amd>
References: <aaece64f-8c6d-29c8-2aa1-34e6dd9378ac@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <aaece64f-8c6d-29c8-2aa1-34e6dd9378ac@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-05-05 23:31:59, Artem S. Tashkinov wrote:
> Hello!
>=20
> Here's a proposal I've made in Redhat's bugzilla (it's been my distro
> for more than two decades, so I think it's pertinent), PR1957520:
=2E..


> I have a very unpopular idea to propose. Let's implement a strict opt-in
> program and add it as an option in the Anaconda/Fedora/RHEL installer to
> _anonymously_ collect unusual kernel messages and based on them
> automatically create bugzilla.kernel.org bugs.

Automatically spam bugzilla.kernel.org. Bad idea, please don't.

If you want to investigate anonymous bug reports, and submit bug fixes
based on them, well... go ahead :-).

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCTqvcACgkQMOfwapXb+vLaSQCgjRUEupt7pDeZP9PB08iUxaNc
r1UAoLkuK5tGiW1kz5IPe7kQ6isyQNDk
=Qd1v
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
