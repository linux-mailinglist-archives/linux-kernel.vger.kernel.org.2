Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13F400461
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350148AbhICRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239546AbhICRzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C17D56069E;
        Fri,  3 Sep 2021 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630691688;
        bh=Vx+Km4LriFtzpvdspYwFenbfHbXLmzP8mIVZy0YnnQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bii7O3kijZSAGxN1lYCGSfhk6quh3TeQbN9PVnbKJKccxT3ltGq+R/QS/7+Din7ac
         b5qWy5bBC/DcEguANdqp3gz5INYxCFt5SygbgKf87jYQEDejk6hFXGLvs9Wr7xUaDH
         3XUiuObeUZbf+ICzsMxk9mBs7ZAD3aotyPLDGJ260qW6/S98oQltAN+UBnYPoKCbpc
         RH2uaauGijsBxR9ee1LZOJ5WZgyVmgk7AjFL+WifHMV7IYOMmmVznbvkhWdZdu703g
         7r8G0EQ6kil9v4RBLxxtl1uqKfzInXlVJdEnDIsdMfEB3JumFHYdn03fJ+ua30QwtU
         hIS9KDhoRJtOg==
Date:   Fri, 3 Sep 2021 18:54:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
Message-ID: <20210903175414.GO4932@sirena.org.uk>
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk>
 <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
 <20210902170613.GG11164@sirena.org.uk>
 <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
 <20210903111023.GE4932@sirena.org.uk>
 <CA+ASDXM7GrbahVyneW=TwHi9Uu7sF+7GcC=U0866_m=GXnFmtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <CA+ASDXM7GrbahVyneW=TwHi9Uu7sF+7GcC=U0866_m=GXnFmtQ@mail.gmail.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 10:09:04AM -0700, Brian Norris wrote:
> On Fri, Sep 3, 2021 at 4:11 AM Mark Brown <broonie@kernel.org> wrote:

> > In terms of not understanding the issue here is that the patch didn't
> > pass the smell test, it was your explanation that helped here not the
> > pointing at a driver change that lacks obvious relevance.  I really
> > don't know what the reader is supposed to infer about the change from
> > the commit,

> OK, I might see where you're coming from. Personally, I'd still like
> to reference the commit in some way, because I've never used bypass
> mode that I'm aware of, but the mentioned commit added a new case that
> I do care about. I like documenting motivation, where reasonable --
> but apparently I need to do a better job of that part.

A reference is fine - it's just that people actively use Fixes to mean
"the specific commit introduced a bug and anything with the referenced
commit might want this fix" which is different to "The change in this
commit caused me to notice this other thing" which is more what you've
got here.  For this case some words in the commit log saying something
like "The foo change in commit X ($subject) exposed $existing_problem"
is probably what you're looking for.

> > I don't think anyone came up with anything more tasteful to do with that
> > hardware, like I say the hardware is itself very hacky.

> OK. I guess I was specifically asking about this patch (and the new
> usage of ->supply in commit 21e39809fd7c, to some extent). If the
> usage of ->supply is the best we can/should do, then we can leave
> 21e39809fd7c alone. If you don't care to "fix" this log message, then
> I can forget about $subject patch too.

> Or, do you only want me to improve the commit message (drop the Fixes,
> mention bypass mode, etc.) and resubmit?

I've queued it for v5.16, I'm likely to move it to v5.15 - it's just
warnings on a very small subset of systems but OTOH it's pretty safe.

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyYUUACgkQJNaLcl1U
h9BTHwf+LLWMXNA89IkpK5az18Wb6CwPR5hrA52zSLzZ8tHESrJpB8Oh0EYZdYKv
Y81SXeDSL9sdRARkD3DbGfg5ixVaVrxR/uyFs9UtSOhmE7FSqvhzo61fuqEyKXtc
/n/EmI5O6lnl5o8NCdxMTKWB1DGw01G0kSvGwTn0C4WYPt64HpGy1Yk/6E9KHz7A
IEasMs/yGo4bRqLmcrLmdw/lo1T/5um3Qp9w+t9qyATRWopMt0PIfA2BGSFUSG9F
W+tRUtSg2RqdsChgVDrGYSjrwN0HfLx2p+kpJux9fVZBI5mWCac9+czz7V+sp0IX
RRx4nB2lbyp6saFqqIebtkZbfkOqyw==
=kZ7P
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
