Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5903FFEC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhICLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhICLL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A255610C8;
        Fri,  3 Sep 2021 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667456;
        bh=1TnfIKjcstczVfsnCOmNwv9Y3GV4l8l0zsaoNNBHwg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKJVZtZSBqjhYZDY0D37GL2LugGkEVbwVzVITkwWWQbd8dTyRUYlw92E/doxq/D4K
         BkehEyYtrV7aE/6khLZ75bWIrUnmbNhvFRHbeP0oNOEo9uev3+Q/ORxUGerJifXJwW
         STm//poUPSPE0PDRKwF3as0DUK2z7K8wBzVSnBE7m4HARlp2AF7uNliMFkJJvlam54
         X2+liJp0ek/53ecpadr+QlJ+XXylMPvlo3ywr6YGztvN4OXvNEiWAZrZEBRasQGiVR
         8usSXarjdQ2tOFMveGavD5UXBLokjVLXUBsYd4xqELOSif4hpUVobHcRPjMhq3nnFe
         4VzQA2MubVuvg==
Date:   Fri, 3 Sep 2021 12:10:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
Message-ID: <20210903111023.GE4932@sirena.org.uk>
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk>
 <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
 <20210902170613.GG11164@sirena.org.uk>
 <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 03:41:02PM -0700, Brian Norris wrote:
> On Thu, Sep 2, 2021 at 10:06 AM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Sep 01, 2021 at 01:06:28PM -0700, Brian Norris wrote:

> > > Take a look at the commit this "Fixes":
> >
> > > 21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disa=
ble ops")

> > That driver change is at most tangentially related to the code that's
> > being updated,

> It introduced another case where we hit a spurious error log. And
> below, you admit that you didn't understand what this is fixing
> without that pointer. I guess we disagree.

The point is the "another" bit - by just picking a random commit you
will cause people to think that an issue was introduced by that commit
which in turn means that people will for example use the presence of
that commit as a guide to backporting.  They may not backport things far
enough since the random commit isn't there, or backport things too far
if the actual issue was introduced later which can be even worse as it
can introduce breakage where it wasn't before.

In terms of not understanding the issue here is that the patch didn't
pass the smell test, it was your explanation that helped here not the
pointing at a driver change that lacks obvious relevance.  I really
don't know what the reader is supposed to infer about the change from
the commit,=20

> > That's definitely an abuse of the API, the hardware design is pretty
> > much a gross hack anywhere as far as I remember.  As Chen-Yu says I'd
> > only expect this to be possible in the case where the supply is in
> > bypass mode and hasn't got its own parent.  In any case I can see why
> > it's happening now...

> Well the hardware exists, the driver exists, and it all worked OK
> until somewhat recently (and now it works again, thanks to Chen-Yu).
> What should we do here, then? Just leave the "abuse" in place?

I don't think anyone came up with anything more tasteful to do with that
hardware, like I say the hardware is itself very hacky.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyAp4ACgkQJNaLcl1U
h9A59gf/cFZ2R9/zqZ+xFevI1+qoJQ/UGK7nXxvEWbxzXlzijddBq2w+FB4NE5S3
VmDC9uRq870lshSJVCiSj2EDoUSCNkg7zh+fYr++86d1oreDtOO5FMHaStpa2NXN
SW2fKUj/wXWoIZO9YjRZSSUOZm5VqL1hjMWctovB28SAOOjClfQxjHY1My+YMXuY
VdyzWWfI8O2bZOZVzvcGd/nuTyh4xJw8IAY8NKLLZh9VVtYusblY1Cu/zacDdTTu
0830DhIdv7P/jdmogAHQkuJPkOFuwCrQQAXC07Rj9/4BkeiKYROMmJOPQ5rLaBse
ME4RDbdZq2GYyRsi+485YiPJgfD1SA==
=Qf/D
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
