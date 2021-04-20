Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C00365CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhDTQOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhDTQOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:14:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02DE6613C4;
        Tue, 20 Apr 2021 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618935224;
        bh=cD3y7b3kSrwWftJRkxx0RYSxy1zhp+eP+mHHMyD5znU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p72y/+C8zRB7jibKzZbKoTo/4uyciL4SpZsoR7nj2YJec0zW/MCB5DPdwwosi/2pM
         U2GgmVaYXdVJoucJvIUgePup+nRr8NSaVmI4VG6xl3Hi4GEcaKuKdbnb/3MlwGhZRn
         6YRNqNYBKbW7XhTMAz++sKLDXKnCXn8YuoifOVUJodf2hEm0ZXACnhRjPBvARLkmBo
         UVPlbEHHUb1bmAGvpqkfXtNmmKTnilvKc4djCmzP/gPch3f5XUHXy11DVceQhGqCh3
         0UxfV6M9+HBiNWxwXcVLwhdOhPltUygJRaw7SKNahQArEKMYUWMPhhqZL/BuI7+OI+
         xDN6Rzd+SqB7g==
Date:   Tue, 20 Apr 2021 17:13:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210420161317.GE6073@sirena.org.uk>
References: <YGNmaNzWOYrJROvX@hatter.bewilderbeest.net>
 <20210330180200.GK4976@sirena.org.uk>
 <20210330193810.GA235990@roeck-us.net>
 <YH4ukR5egB2eG0Vo@hatter.bewilderbeest.net>
 <20210420033648.GA227111@roeck-us.net>
 <YH5rky8nA4nKAVdg@hatter.bewilderbeest.net>
 <9639fa33-01ca-9802-e745-5e3edb81e305@roeck-us.net>
 <YH59WOg0iKbz1d0l@hatter.bewilderbeest.net>
 <fe111c8a-9588-dbfb-624a-29bb3a5efe13@roeck-us.net>
 <YH7w6HUtBSCZRWq4@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <YH7w6HUtBSCZRWq4@hatter.bewilderbeest.net>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 10:19:04AM -0500, Zev Weiss wrote:

> Mark, do you have any further input on what a viable approach might look
> like?

I already suggested writing a driver or drivers that represent the
hardware you have, that advice remains.  It's hard to follow what you
were trying to say with your long mail earlier today but it seems like
you basically don't want to use any abstraction or framework, but that's
not really suitable for upstream integration - other hardware that looks
similar to the end user should look similar in the kernel too.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB+/Z0ACgkQJNaLcl1U
h9A2Hwf/SWR76PMEbzeYJSpzqHxdwIVdQoQPT//JnsDvGXFKZpXK29a+gvAY9EW2
vR/O/no5OLWRaQ6DRjrNbg4y3kcNsGSIMBrl1g0+jO+Iznes8ZRqBkFYcsh2uHnA
b6ZHnLqIhfIoSxC2WfYKo1ZlHoJzZJwgD9tTIs0B6/jWJ0VmtWH1Vfkg7Efcwfq7
YQv84OLLrLaXPBCrF9U2Gekw+Ju9JHnH8fPIlyeHQHN1JW4M/nOYc7ri5R/islne
SLA9DkV7l/cr6YUDU6eKCB8F5I2XEpJOOLgGcnMYo0rpTZoypOUygw6ZxEXk34qy
2AmIyG9TTs70sV/hLjrJEXBh+PNynA==
=T6vq
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
