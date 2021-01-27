Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EE306116
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhA0Qd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234398AbhA0Qdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:33:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26AC464D9E;
        Wed, 27 Jan 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611765181;
        bh=mFZZesIR82eBkPap+U0XlrfJGsyXXYDqk4YtgITqi+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AigFQ8zz2eDWbwzbwHUKC+fLCtUjjymsi6Iptve0WCYlaMZ1R32qPkEv20xILlleQ
         8+DfYyhwbS44Z7fYk0KpCOhsV0idQrYUNnyLcOl9AI8PkR70s3ONCJKRWwTkvrceNO
         AoeG+zSDPRIhN+9JRu8xsrEeDeGjuvjmlg+GhJJeAFHP0fNUKDtlmtW9efUDEDGKNx
         db7h9XWvnqT+9CQ8IyDdCXOdW9DcHgrf7spJJbir+U7idUV9R5o8PFcyIrsuFSiJWG
         m5wBzWc0IaOqw3jGFQ+JTNdd3VkjcGH9hwrLbZmjHL6IbUL2uhjGJbu+svk2JAq49T
         T6B5hwjFdc0nQ==
Date:   Wed, 27 Jan 2021 16:32:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Message-ID: <20210127163218.GD4387@sirena.org.uk>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
 <20210127122733.GC4387@sirena.org.uk>
 <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
 <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
X-Cookie: La-dee-dee, la-dee-dah.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2021 at 03:34:46PM +0100, AngeloGioacchino Del Regno wrote:
> Il 27/01/21 13:56, Matti Vaittinen ha scritto:

> > I can only speak for BD9576MUF - which has two limits for monitored
> > entity (temperature/voltage). One limit being 'warning' limit (or
> > 'detection' as data-sheet says), the other being 'protection' limit.

> I would tend to agree with you here, Matti. Also from what I understand,
> the wanted outcome is software handling a possibly temporary issue with
> you charging caps, external IC initialization using (expectedly) much
> more power than needed before stabilizing, and eventually handling other
> "real" issues for which there is a solution that may not even include
> disabling the regulator itself, but some other handling on the connected
> device driver.

Note that the events the API currently has are expected to be for the
actual error conditions, not for the warning ones - indicating that the
voltage is out of regulation for example.  If you're supporting warning
notifications as well you'll want to add more events (or possibly
another flag to munge in with the existing events to indicate that it's
a warning rather than an error).

> Though, Mark: for example, on qcom labibb, there's "PBS" that is killing
> the regulators on short-circuit condition and as you see, handling that
> is a little trickier compared to the over-current one, where there is no
> such auto-magic-thing...
> .... I wouldn't know if it'd be a good idea to have a system like qcom's
> PBS everywhere.
> For the sake of protecting HW "paranoidly" though.. maybe :))

Well, if these things are kicking in the hardware is in serious trouble
anyway so it's unclear what the system would be likely to do in
software, and also unclear how safe it is to rely on software to be able
to take that action given that it let things get into such a bad state
in the first place.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmARlZEACgkQJNaLcl1U
h9A1Xwf+LaSr3Y/BuhHm69m0DLYodtxCQCuK/dOAGDBq4lF4Qh4HMeW3UMvEfq+A
l8NDzOjKC2MjzmArzQQki2Dg7ompH/d6p3XN2ZeurVeEPHby9Ta8VxgdDzc91m5n
TpFF6NMaunWd7gK9yQoVlVb/kHbWP0HqdSfoiYdLZTqRfodG47x//UBhZxKUFWt+
hVd4KACstGjng0oLx7N9PclJx3zUdrxpKEvIwliI4XY5mSf8lAZ1Qm2Dj/qN2M53
9jLnH5OzwrqT/6Bwnl2pycQYI5hREqOv421pE9axSF40kWNrpwExDwknHrcD3n2w
Pq+RgenaEiCUXNL9Ex0pbepaUuu7ig==
=vP3z
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
