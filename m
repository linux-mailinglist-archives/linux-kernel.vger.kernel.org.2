Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D7A3434EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhCUU46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:56:58 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53396 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCUU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:56:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AD1ED1C0B78; Sun, 21 Mar 2021 21:56:19 +0100 (CET)
Date:   Sun, 21 Mar 2021 21:56:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Getting Rust to work
Message-ID: <20210321205619.GB28813@duo.ucw.cz>
References: <20210321193705.GA13699@duo.ucw.cz>
 <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > First try was on x86-32. It took me a whlie to figure out the problem,
> > hence the diff below.
>=20
> Thanks a lot for trying it out and for the feedback! :-)

Thanks for your work :-).

> The supported architectures are in
> Documentation/rust/arch-support.rst, so we should link to that.
>=20
> x86 32-bit and other architectures should eventually work -- we need
> to put some time into them and setting up a few things. For the moment
> we focused on x86_64 and arm64.

Actually x86-32 would be useful for me. That's my test machine.

> > Then I got failure because libclang (?) was not installed. I installed
> > it. But I guess that should be mentioned in docs as dependency.
>=20
> Yeah, this is mentioned on the bindgen section in quick-start.rst, I
> will try to improve make it more clear, perhaps I'll a section for
> libclang itself.

Aha, sorry, it is possible I was not careful enough reading the docs.

> > With CONFIG_RUST unset, kernel builds for me. With CONFIG_RUST=3Dy +
> > RUST_EXAMPLE=3Dy... I get errors:
>=20
> Typically it is due to a kernel option that enables some GCC flag that
> libclang does not know about -- I have a hack in place to make it
> work, but requires manual maintenance. Can you please attach your
> kernel config?

Done, in a private message.

> Meanwhile, please try building with Clang or LLVM instead, the GCC
> builds are very, very experimental. I'll make it even more explicit in
> the quick-start.

I tried, but newest in my distribution is clang-7, and kernel needs
clang-10.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFey8wAKCRAw5/Bqldv6
8u0KAJ9DZ2RYwRhGehvc63R337HtCyN8IACfQKjb/AnYOBcg9gCu+u5gsSpxfEo=
=OpBy
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
