Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFA3682BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhDVOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236019AbhDVOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A225E6141C;
        Thu, 22 Apr 2021 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619103096;
        bh=L8GJCRdZEgvWuOnY6MuNLjvwrNnvqmgpp3zdB/y2tAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM2DBFYeIS1vpXcFSbqqPh63KmZSmf+SYdcqN8Jhtda9CK8+YBHG++z8LDRlvUoYl
         tKUSJRlcJuURFrcV0BM/va3by71GnVHGNS7bzIU2gD5ak0+DW/M1JzdXXPqKH8pcFd
         GKuIqTyqfz6t1o8PG+7luW2tPOebn/RxyZjM07jNM/KF0bKRCsFtqbdYUUkKtrQh97
         5f02jluzV0RcGKxK2ak9Ldz0jv71M7tbpTkZKIvFcoXyMWGP1Xw/mg/I2Z/1V4tUon
         1U5q0OlXwbGZwCUep28eug8FIiq1u59QQrstZQq1Ff+7I9LY3XUpYL5b1jrBlUT11v
         uEWyOlvvgyNOA==
Date:   Thu, 22 Apr 2021 15:51:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        ksummit@lists.linux.dev, workflows@vger.kernel.org
Subject: Re: RFC: building a regression tracking bot for Linux kernel
 development
Message-ID: <20210422145107.GH4572@sirena.org.uk>
References: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 09:16:40AM +0200, Thorsten Leemhuis wrote:

> That's it already. The regression was tracked with:

>  * minimal overhead for the reporter
>  * no additional overhead for the developers =E2=80=93 only something the=
y ought
> to do already became more important

For things that are caught by the various automated systems the
deduplication might get annoying - even for the systems with a human in
the loop it's very common for things that the automated systems pick up
to end up getting reported several times over due to things like race
conditions in the reporting process.  We'll have to see how that goes,
it might be possible to automate some of it.

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCBjVoACgkQJNaLcl1U
h9Cbjgf8D14vx+s9t/dKVSSiCbipbS1Ip/ihBgFmYGmfZlURlPlQcoRh/fkYASjZ
CrDngHSKgnmnkmRTn2SLPaEP88ZUoKP9xXpI9mE/TzpzJ/vkI1nfSIu5eZn73U7o
Z2XrcQq/5esSRZqQ0MhbKGnCW5YjkQvdqFpVJ8ENF4pK85KIE6l83uaZsbhrkXAy
GTPyov/bBXISY0K2OXu2RyTvtCY9RtpdAgySbO++VnonAcs4fC/dSgB2juC/g+Lc
70/oVxhXoTpRd8bX0oKEH1u00NcVC9uqaUuHf7wkIFBw9/AeNvJgEz3Fz1L2o6aY
BKEOjtrgZAvcSV3grGwYxpt7Cql5Aw==
=KJRI
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
