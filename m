Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72128399EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCK3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:29:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBDCB613AD;
        Thu,  3 Jun 2021 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622716073;
        bh=8ijE2vQGky9Bg1rmyAkb6n1CFUZk/Byqn3JghZuit+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFJJu2OcCXINVqtjoqWZiApwd8dizPz/4If8w9D2xRSLwZbVqW6g9G5yDc8kf7kq4
         GePrlLdOIN/kVlLzRAFhp4SqrsVA++b65Rc8SJDOSJOLE3YJ5PdKDljaiNQQmMuaOU
         dQfaC5Eyyz1jpaPLBlK//pSQXlYFu1t6C212Zlnofn6KXBFsUM2q6lHMvz+WJNCY/d
         /ugWKXqGMZokcv5eFmwlqO+Ed1xG7aOM8eYjC+4jCE9TSM5wzF8LDSeEDAMMjc8hun
         lc14BOn9JQBUkpRLMFtiiDjvEPuXdD9EWYC9x5MldGho6veBLuNR4ogr+aZEBvBVku
         nKDVrvPPYES/w==
Date:   Thu, 3 Jun 2021 11:27:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: core: always use enable_delay when
 enabling regulators
Message-ID: <20210603102741.GA4257@sirena.org.uk>
References: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
 <20210519221224.2868496-2-dmitry.baryshkov@linaro.org>
 <20210520115724.GA3962@sirena.org.uk>
 <CAA8EJprEQcP3hzqSsq8jzoCzf0gvbWdnQtCEGBO5S3WJNUkYEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <CAA8EJprEQcP3hzqSsq8jzoCzf0gvbWdnQtCEGBO5S3WJNUkYEQ@mail.gmail.com>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 02, 2021 at 04:14:35PM +0300, Dmitry Baryshkov wrote:
> On Thu, 20 May 2021 at 14:58, Mark Brown <broonie@kernel.org> wrote:

> > On Thu, May 20, 2021 at 01:12:24AM +0300, Dmitry Baryshkov wrote:
> > > Some regulators (e.g. fixed) do not have .enable callback per se, but
> > > use supply regulator and enable_delay. Do not return early from
> > > _regulator_do_enable in such cases, so that enable_delay is properly
> > > handled.

> > This doesn't seem like the right fix - if we didn't actually do anything
> > then we don't need to add a delay.  We should only be doing this if some
> > parent regulator changed state.

> I have implemented this, but then it becomes too fragile. If the
> parent gets enabled for whatever reason just few us ago, the whole
> delay would be skipped.

This seems like a solvable problem, we can track what parents are doing
or teach parents about their children for example.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC4rp0ACgkQJNaLcl1U
h9BTVAf+IXCl0yTkAJOX5dvkUZOBE+o/4uSJ2Fwf37YJ0yczkt3qrbezII3csUvf
2LoaBiEDR+p/bEfwzSxOnvIH9ntXIbQ/DcygemDCREIIcIJNJkr5YLV9rLB1amr8
pi5rWTthxqMVb5UmpWKcFV68JyxrDCOeedX0B2OV4syIE5pOwm2qya9feI5Y/QqH
0BrDp9SvYRoZR+FUjxZiyECbVj/5+KgeUx7ITH52tHa2DTNsezRhcf1CD/LL2TAF
XX5xhrkHUTOYX1aA3GokBMi9dQGWXMn34Aol5V8s8iTtFbNrsip01/GXDSJXQ6px
3Y0SwJIGkRKP6CAtuIL8pxbHTzptPA==
=EbqP
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
