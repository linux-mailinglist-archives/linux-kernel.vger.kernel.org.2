Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B773C30D652
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhBCJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:29:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44739 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233215AbhBCJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:28:37 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B8DC99EB;
        Wed,  3 Feb 2021 04:27:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Feb 2021 04:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=VAoa5grz9ER7JEyWFa0fcNdHf38
        qXZqtMA88GRCrXjQ=; b=rKRxtop/20i6t3PEJ74Cld1+XQ63ReDEhxZKubD/7g5
        QibY83C4b+Ql2oIhCS7ushMTgRp7tgV0MX1FLISsNDaD2UyI49+gFj0LOH04Kr3A
        ejdqVu2RF0S4nYENEfhBqEr2xVKwl7RMsqUeTFXykWMaSW1pLh0k+ZmznRsE6UBx
        srfp0ExRk0G2Qjru2vNpMBYNpwe0jnfyvPmcwriywEYPeiJKzbb7wVakL9NtQeSD
        qmhBU5mU0HdanwGbqm5EqcXMofl42C/vV9F41t1Ax7D9IwwtaaElKEgzo6SWAocJ
        XtAT2sacyYPtVVtvQjRsIX0yGL/H9cS1cP0fPt6r2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VAoa5g
        rz9ER7JEyWFa0fcNdHf38qXZqtMA88GRCrXjQ=; b=S3tXiMIzexyRJJwRq/kxcZ
        U5vQvhBtVN7si49GrTA/kGkzOEAsF3XcD/slEG567C6CWsR2a9SEwPS7WRX83O1A
        nRxWIJ+foX4/bgZwpljCbH6FGIba6ECsGaNs2PivzonfC5AAPi+EzYvDccQGxnEO
        CzpCwjQQciJ7xwD+TruNz0Vs/3Q8rynn8WwZORMnFS4bKl8MBep8KWN5NCGmtoBL
        Kn3Ovj5RMkzj8N87HdA5OwRwwzz7phvYfJY9h8qi2VLtAWmVZp3Q/OsBLjk7a3oW
        q50wY3qWleMbwl0skmrFAEJ2v6qQDQWYhhBdPScSuudrqu28S1jbc5zlfTYkj1/g
        ==
X-ME-Sender: <xms:kmwaYGLv3oiq1aAts75fZoUUQhuT4Bbb2ZnyH9gs9m5x2GFm8tLWEQ>
    <xme:kmwaYOIUTIQEln01zGG6g-A_OPggpHWEgdyXLKEkPzH3TSuMQY9g85I1ZpMWID96L
    9JXHa6WqsHVENxG3LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedvgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:kmwaYGtI4OIWrB8xJVU1N2VIOLK5r1Ixc5KaxTVyEdUO-ljbiydh9w>
    <xmx:kmwaYLZjFuzSIkBaEx0SyCied-z56YyLxVH2jzX99XgvhObVVHkfOA>
    <xmx:kmwaYNa8KZ_mGkilX2Y0zmCHZHG5_y9cl4sCR5WuAam3uTOZWaRI_g>
    <xmx:lGwaYJ6bTFjcKRF6k7HAK2Tn2_RpL8HjYafYc9WDI0UKuFI5QBs0Ug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 524781080066;
        Wed,  3 Feb 2021 04:27:46 -0500 (EST)
Date:   Wed, 3 Feb 2021 10:27:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/21] clk: sunxi: clk-sun6i-ar100: Demote non-conformant
 kernel-doc header
Message-ID: <20210203092744.yfedaauyynzn537h@gilmour>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-13-lee.jones@linaro.org>
 <20210126155430.llxijnwf5i4z3end@gilmour>
 <20210126165459.GG4903@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jajmciffwlsodka3"
Content-Disposition: inline
In-Reply-To: <20210126165459.GG4903@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jajmciffwlsodka3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 04:54:59PM +0000, Lee Jones wrote:
> On Tue, 26 Jan 2021, Maxime Ripard wrote:
>=20
> > On Tue, Jan 26, 2021 at 12:45:31PM +0000, Lee Jones wrote:
> > > Fixes the following W=3D1 kernel build warning(s):
> > >=20
> > >  drivers/clk/sunxi/clk-sun6i-ar100.c:26: warning: Function parameter =
or member 'req' not described in 'sun6i_get_ar100_factors'
> > >=20
> > > Cc: "Emilio L=F3pez" <emilio@elopez.com.ar>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > Cc: linux-clk@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/clk/sunxi/clk-sun6i-ar100.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/=
clk-sun6i-ar100.c
> > > index e1b7d0929cf7f..54babc2b4b9ee 100644
> > > --- a/drivers/clk/sunxi/clk-sun6i-ar100.c
> > > +++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
> > > @@ -16,7 +16,7 @@
> > > =20
> > >  #include "clk-factors.h"
> > > =20
> > > -/**
> > > +/*
> > >   * sun6i_get_ar100_factors - Calculates factors p, m for AR100
> > >   *
> > >   * AR100 rate is calculated as follows
> >=20
> > This is the sixth patch doing the exact same thing over the files in
> > that folder you sent. Please fix all the occurences at once
>=20
> No.  That would make the whole clean-up process 10x harder than it
> already is
>=20
> Before starting this endeavour there were 18,000+ warnings spread over
> 100's of files and 10's of subsystems that needed addressing (only a
> couple thousand left now thankfully).  Some issues vastly different,
> some duplicated (much too much copy/pasting going which made things
> very frustrating at times).
>=20
> Anyway, in order to work though them all gracefully and in a sensible
> time-frame I had to come up with a workable plan.  Each subsystem is
> compiled separately and a script attempts to take out duplicate
> warnings and takes me through the build-log one file at a time.  Once
> all of the warnings are fixed in a source-file, it moves on to the
> next file.  The method is clean and allows me to handle this
> gargantuan task in bite-sized chunks.

I mean, you have literally used the same commit log and the same changes
over six different files in the same directory. Sure changes across
different parts of the kernel can be painful, but it's really not what
we're discussing here.

> Going though and pairing up similar changes is unsustainable for a
> task like this.  It would add a lot of additional overhead and would
> slow down the rate of acceptance since source files tend to have
> different reviewers/maintainers - some working faster to review
> patches than others, leading to excessive lag times waiting for that
> one reviewer who takes weeks to review.

Are you arguing that sending the same patch 6 times is easier and faster
to review for the maintainer than the same changes in a single patch?

> Having each file addressed in a separate patch also helps
> revertability and bisectability. Not such a big problem with the
> documentation patches, but still.

There's nothing to revert or bisect, those changes aren't functional
changes.

> Admittedly doing it this way *can* look a bit odd in *some* patch-sets
> when they hit the MLs - particularly clock it seems, where there
> hasn't even been a vague attempt to document any of the parameters in
> the kernel-doc headers - however the alternative would mean nothing
> would get done!

Yeah, and even though properly documenting the functions would have been
the right way to fix those warnings, I didn't ask you to do that since I
was expecting it to be daunting. Surely we can meet half-way

Maxime

--jajmciffwlsodka3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBpskAAKCRDj7w1vZxhR
xdZ6AP4rRA0/S6jS9NyjKe9T4p7VaHMetN9ppZuB/NUOoJlyFwD8D1n3Dc1DUcA0
VLJXXOfCEuGjWm9gmaygNm2hBNzP3AU=
=XQlf
-----END PGP SIGNATURE-----

--jajmciffwlsodka3--
