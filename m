Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B947F43A3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhJYUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235595AbhJYT5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5D1860FC2;
        Mon, 25 Oct 2021 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635191278;
        bh=8Z4CPKBu45gXH2iJqcYpEM3NI3FoQisIbY/55IiRGSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxzCv4LVfRSMt/9kXFC49A/9CtsMtGsHECcr/nnnlMVsHf03JffiL97E7Q4r6TF3/
         QY0tJW77c/ZD3VWhUOdGrOFWL8DaZjQwUH2VifydVC7qz9Y6GUo7VXi8bbIcT7h2EN
         eFr0EcusgJKUfZvVAjVlUKcFaZZycy+sxf0m2DKaIkiPrIXcEeB2yi6TDIJYq+xqb3
         s5OvSv0wVpQWm29HY3weX3WC9N4Al4SlXTUQRQ27AWD/cR83bsnZ2M3PhZLvCXSfrJ
         WbQzZmI+7ZDkz7SBY8bqf36cG0MYvQur2WX2Yf2Yu+EFNkDb5M2PGIe8vZwjQzg4Np
         FcdSpJzyLWNgg==
Date:   Mon, 25 Oct 2021 20:47:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc6
Message-ID: <YXcJ6wQxW72aaGYB@sirena.org.uk>
References: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
 <20211019203320.GA748645@roeck-us.net>
 <CAHk-=whPA5ZgXAG08vqtvZw3DK5H7Tkd9r+ZHSxxNaKYWzjw9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u0i57v4gC00HNIDM"
Content-Disposition: inline
In-Reply-To: <CAHk-=whPA5ZgXAG08vqtvZw3DK5H7Tkd9r+ZHSxxNaKYWzjw9g@mail.gmail.com>
X-Cookie: From concentrate.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u0i57v4gC00HNIDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 25, 2021 at 11:07:16AM -0700, Linus Torvalds wrote:

> Mark, please stop doing these mindless AND INCORRECT back-merges of my
> tree. There is absolutely no excuse for garbage like this:

Sorry about that.  JFTR (and bearing in mind your other points) it looks
like I messed up the first time and then didn't notice that the bad
merge was in my rerere cache the second time, if I am doing these I
should remember to specify --no-rerere-autoupdate so that any mistakes
that do happen are less likely to get repeated.

> If you really need to do a back-merge, explain WHY. And it had better
> be some important reason.

> In particular, the reson should not be "fix conflict", because you're
> clearly not particularly good at it.

A good portion (I'm pretty sure the majority) of the backmerges I do are
due to dependencies for new patches, but obviously you can't tell that
without something in the commit log which like you say should be there
and will be in future.

--u0i57v4gC00HNIDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF3CesACgkQJNaLcl1U
h9AjgQgAgDCkiIzVjybKj5MfXjrxlulBV3rxs7tFpVm0cVp4CovTaC/WS7riXEua
Z0u9keEi93+MfDV52j5/Jwt7TL7Cd6ykdnFVRFwY/8NmfFFyCIdqyoyxjO3wWwhh
Q7DUBEwa7bqjOhoRhII6rCHqkw8XqoLk/ANcExUU23wjUk+K69m7D92lYP8F7+cw
C7b0+s/8CNtTnv7UEDrCabD4vCbGJtCY+2KF1+IR7B3HNUywKvdotsPruJ+EGfRm
TFGnIsatvxNZJK3zGMtaKXQzsnukKLPcIKxdqPiTsqY09QHzkgZOgEBVJJWaLDaE
2ZmLaJlzeHV7wyOEGXG1nJgXquRn3w==
=gS0a
-----END PGP SIGNATURE-----

--u0i57v4gC00HNIDM--
