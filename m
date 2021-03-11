Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D5337CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCKSmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:42:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhCKSlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:41:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D13FB64DEE;
        Thu, 11 Mar 2021 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615488106;
        bh=ipfQqSOZywUDqfSlURS+9CmL2qyZ4SrWmfyx37h5n+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATIvzOe2Frjw6cnZY8luSBegqGnlar+EGU8P5zbLb6U4KtUKyqz2BhXqV6C+5nMji
         qwB1CD5VEca3+4pQIhAQa1goZwy27aD/7ACkkfkv+7VcyiwfD25BxCN7wqY92zUMfH
         e+KyQyS1R292ut8rBdVlK/UTvsFszNXxnhnt84w9dv7FVCpHBAeqP5ly76biFEoDJ8
         w+Dw/TtvfACTbiLJbA7hT5m09QhqbeZq4NrylBsbFxjpvym1keBsXw/xotpn0xDPVW
         r5dEGTzcu98gt3TcK+dsrwrSM5RiyvBx9QU2ZeU7u3J6KY7y2Sz1GzD69G2QIpIfrB
         s7XyvQeWBL0lg==
Date:   Thu, 11 Mar 2021 18:40:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210311184033.GJ4962@sirena.org.uk>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <20210310094821.GB701493@dell>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2021 at 09:48:21AM +0000, Lee Jones wrote:

> Could you take a look at this for me please:

> > +static int regmap_ignore_write(void *context,
> > +			       unsigned int reg, unsigned int val)
> > +
> > +{
> > +	struct regmap *regmap = context;
> > +
> > +	regmap_write(regmap, reg, val);
> > +
> > +	return 0;
> > +}

If there were more users it'd be better to have this in the core so that
problems we can detect like cache stuff if that's used but if it's just
one broken device it's probably not worth it, this seems like something
you'd have to try to end up with and which is going to cause timeout
problems with a lot of I2C controllers which would tank performance
enough that people would notice.

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKZCAACgkQJNaLcl1U
h9B5YQf+OWhi3p3jDEJY5RxtGOjQsm5A1eUmm/TYd2uZBEZ+tCJ9CwoDlZQ5WIAr
QfWAhLK9var/WpC2bOgwGcB3yW4uCxNBjDrGI6mLJObrv0m2Z5cHA7uPQE98Ut79
PKHS8+ZEXWEkgH8fPYz+lY5Ln+mddsPeB6l/yj3jkvJsoRypyWJT/S6xppsjHVhV
15rlztZszFQl0z3A1QAKvkIeGTg7upbZUXBnltvf63RP+aF2v8M64zuv102YpWqL
LQXGfvm7orKwS+oKIw8inbo/XjIyUVX3/VEYj2lpXGhMTRawogRcEpp3X0jUEx6W
kvjH5HpWQ6V0ys/7gqnBhQyYMHBIZA==
=fB7p
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
