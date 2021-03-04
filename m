Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639BD32D370
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCDMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:44:05 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52504 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhCDMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:43:58 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2BFAA1C0B87; Thu,  4 Mar 2021 13:43:15 +0100 (CET)
Date:   Thu, 4 Mar 2021 13:43:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A note on the 5.12-rc1 tag
Message-ID: <20210304124314.GA9979@duo.ucw.cz>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hey peeps - some of you may have already noticed that in my public git
> tree, the "v5.12-rc1" tag has magically been renamed to
> "v5.12-rc1-dontuse". It's still the same object, it still says
> "v5.12-rc1" internally, and it is still is signed by me, but the
> user-visible name of the tag has changed.
>=20
> The reason is fairly straightforward: this merge window, we had a very
> innocuous code cleanup and simplification that raised no red flags at
> all, but had a subtle and very nasty bug in it: swap files stopped
> working right.  And they stopped working in a particularly bad way:
> the offset of the start of the swap file was lost.
>=20
> Swapping still happened, but it happened to the wrong part of the
> filesystem, with the obvious catastrophic end results.

Fun :-(.

> One additional reason for this note is that I want to not just warn
> people to not run this if you have a swapfile - even if you are
> personally not impacted (like I am, and probably most people are -
> swap partitions all around) - I want to make sure that nobody starts
> new topic branches using that 5.12-rc1 tag. I know a few developers
> tend to go "Ok, rc1 is out, I got all my development work into this
> merge window, I will now fast-forward to rc1 and use that as a base
> for the next release". Don't do it this time. It may work perfectly
> well for you because you have the common partition setup, but it can
> end up being a horrible base for anybody else that might end up
> bisecting into that area.

Would it make sense to do a -rc2, now, so new topic branches can be
started on that one?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYEDV4gAKCRAw5/Bqldv6
8nTqAKCDoqcnnX2pETJIK3lSxsFt1rzDRACcCT8RzKKz/hPm21N+/SdbLff1HyY=
=yeY7
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
