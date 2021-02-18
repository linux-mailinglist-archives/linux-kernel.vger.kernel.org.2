Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8443A31EB28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBROyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:54:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56608 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhBRMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:53:02 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 21EFF1C0B81; Thu, 18 Feb 2021 13:51:32 +0100 (CET)
Date:   Thu, 18 Feb 2021 13:51:31 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218125131.GA10316@duo.ucw.cz>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <YC4atKmK7ZqlOGER@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Why would you backport new features to an old kernel?  That's not what
> they are there for.

For CIP project, this is one of advantages for "supported" boards, as
we'll backport patches improving their support as long as those
patches are mainline.

> > If the CIP project has committed to 10 years you would think they would=
 be in contact
> > with you to add their support to the 5.10 LTS effort.
>=20
> They are doing testing right now, see the announcements where they test
> each stable -rc release.  But they have not talked to me about 5.10
> yet, Their model is that they will, somehow in a way that is yet to be
> determined, take over maintaining these releases _after_ I drop them.
> But they are only going to do so for a very specific hardware platform
> or two, so anyone using anything other than their specific boards, is
> going to be out of luck.

I'd say this is a bit inaccurate :-). We care about different boards
at armv7, armv8 and x86-64 architectures, which actually means we care
about quite big part of the kernel already. Rough estimate is that 50%
of patches in stable touch our configurations, I could collect better
statistics.

As you said, I'm not sure everything is fully determined at this
point, but... we'll certainly try to support community effort for 4.4,
4.19 and 5.10 maintainance for as long as possible.

It is well possible that we'll continue to maintain even
configurations we can't test (we don't have s390 to test on) on
best-effort basis (to help community and because applying a patch may
be easier than determining if someone in CIP community depends on it).

> Which makes sense, scoping support like this to those that actually care
> about a specific hardware platform is much easier than the work that I
> and Sasha do in support it for all platforms.  So if you are interested
> in 10 years, please work with CIP to get your platform into that list.

And yes, this is very good suggestion.

Best regards,
								Pavel
PS: Again, I'm speaking for myself.
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYC5i0wAKCRAw5/Bqldv6
8k6PAJoCZU40runcm0gDpKEmZr2ggueNPwCggAsKICCZm6i6K7SB7lNIy/Np6Ys=
=4XSo
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
