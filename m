Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A23D99A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhG1Xkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhG1Xka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:40:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 107756103E;
        Wed, 28 Jul 2021 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627515628;
        bh=bwsV5GSE+mQt/iUhC9W7pV9yYShQiS/j/L6KdceZwu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6oIQ8WpxCueu2SMIn2rgWrEd/4rFibd0B+5X6MsBjsgMwOpnDhNmW7LmMCvMDY5b
         0zOAvnp8YM1W4i8apColW24hh2IQgSQLNGOI9nNeUpiS8e5hYpLGvBS/hJT2PVPNhD
         eBN18Q5tVNmIEqOsVzvhhdp4NyEAnQZ0gSzAN8+hLGOIjfj0XbCyE4yFNX4rw/pQsJ
         dba8FhuX/7jDH0I3xJpOvOGFhTbzT6TiOWil3MPr/OvMkyFIrtZhpA2/OJSvRhf+Ui
         lLkaJom261WC4XuKaKfRTqvKxkEGR3/TCqWr7D/LVOof8x1nl5IyfXfDUEifYxM7AY
         QWIwJYpx0m3Kw==
Date:   Thu, 29 Jul 2021 00:40:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pierre-louis.bossart@linux.intel.com, rander.wang@linux.intel.com,
        shumingf@realtek.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
Message-ID: <20210728234018.GH4670@sirena.org.uk>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
 <20210705165041.GC4574@sirena.org.uk>
 <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
 <20210728160948.GE4670@sirena.org.uk>
 <a59d60bf-6bbc-c65f-bd77-2b1bc98b0d22@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhOf6eAHdfH9MSjZ"
Content-Disposition: inline
In-Reply-To: <a59d60bf-6bbc-c65f-bd77-2b1bc98b0d22@opensource.cirrus.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vhOf6eAHdfH9MSjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 28, 2021 at 07:29:30PM +0100, Richard Fitzgerald wrote:
> On 28/07/2021 17:09, Mark Brown wrote:

> > The thing here is that nobody would have thought that that any caller
> > would have been open coding this stuff like the component things were,

> On the contrary, since that was the only way to use these functions with
> a prefixed component it's entirely possible that there is code already
> adding the prefix. Why would you expect nobody has ever written code
> that works?

Prefixes just aren't that widely used, explict DAPM calls to set pin
states are more commonly used but tend not to be used in the simpler
systems that would normally use prefixes (though Soundwire appears to
have changed that quite a bit).  There's a decent chance that the Intel
system that ran into this is only the second or third one that ever saw
the two features used in combination.  This sort of missed case is a
thing we still run into from time to time with prefixes.

> > like this so people wouldn't think of auditing the callers to find uses

> I don't think that it's either safe or desirable to skip checking how
> callers use functionality that you want to change. My understanding of
> Linux development protocol was that if you make a change that affects
> other code, you are responsible for updating that other code to match.
> Regardless of whether you agree with how that other code was
> implemented. It creates a lot of overhead for everyone if it's ok to
> make changes without trying to fix up other code that is affected by
> that change.

Sure, and that's exactly how I spotted that there was a problem with the
patch you posted - your patch was clearly going to break the systems
which rely on the change to _find_widgets() including all CODEC drivers
that use the DAPM level API.  People should and generally do make a
reasonable effort to check things out but it's always going to be that
rather than a guarantee, you can't 100% rely on people spotting things
especially when callers go off piste and do weird things.  Some of the
assessment of reasonableness on the part of everyone concerned is going
to involve looking at things like how secure the abstraction layers
involved are and how one would expect things to work, also influenced by
things like the volume of users and how easy that makes it to find
unusual users.  That's most likely what happened here.

These things are going to happen from time to time, when they do the
thing to do is to raise the issue (as you did initially) and then engage
in any discussion about what's going on and how best to fix the problem
(which was a bit of an issue here).  If you have proposed a patch but
there are other things that need to be considered there is likely to be
some expectation that you might follow up with a new version unless
people have explicitly said otherwise (submitters often have a strong
preference for this).

--vhOf6eAHdfH9MSjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEB6uEACgkQJNaLcl1U
h9A4ugf/WCVbCqC2pBFoXlYK54esbrhx6P7+SKulcpHO817HMDNyImk4lGMflqZW
mGCrLw1xkR6jm7IUBGHt/9OD3R7w9gPgswaWreeweoUabS/Wxezy95a2SoRKlVNb
v7y5fGLxh5pnlWDB3rlAwGnGxs/rcvixBtpax3Cy38Kic5xamnaP8inj8NhPHNPv
avoU7ICL8pcjWCqJLIBKpVH7da1qXFx/zFum+9tQbcmpdmbDIWNbxHp58IjKlErc
NCpiVNrp3ohYTIBI1HPJNS9k4KPV/03U74t2nFq1UsE6CTVtrtJYO/+eFHlHutQA
Z5hE5IL3InOfsJ02RpvBfhL5xbWgXw==
=fNs7
-----END PGP SIGNATURE-----

--vhOf6eAHdfH9MSjZ--
