Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A464F34E64F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhC3LXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3LXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9247461987;
        Tue, 30 Mar 2021 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617103386;
        bh=P9SExgjbYY0iz0ly5S6s+o+0gtVraFaw+byED+bjTq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTRSOu3E1AA9QKGSiNcA/soQKSYqQrUNY3aHrzHim1hTUaL8wE4tpz6NfVU9XN7Ag
         fO44Catmfp/wYb553FXcayPQmyom1e/+tvCZebn8wszTsFej0Z+ai4dk1/h8BfhTW9
         X7efrmD5tZZO6iKEmkGxoKN6W4INm6H7vIvi8twA5UxyXp9jYfkPEl03tJCITRH2/C
         e0K72lDLC/RXq1i3P0QTZdOi7mvKNtG1WL/oGlcUrLMetsZheUf6JjQaB/hw+c5nRp
         pge2OaT6b/gqSXrN9l/Lu/9mWeefBLl+vDwWAXD9xhn8tPZqZpoxA/YzZBsnc1ZImD
         5VlWSVRbbtcDg==
Date:   Tue, 30 Mar 2021 12:22:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210330112254.GB4976@sirena.org.uk>
References: <YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net>
 <5105ada1-643a-8e58-a52d-d3c8dbef86b9@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <5105ada1-643a-8e58-a52d-d3c8dbef86b9@roeck-us.net>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 03:34:16AM -0700, Guenter Roeck wrote:

> (and I don't know if the userspace consumer code is appropriate - you
> might want to check with the regulator maintainer on that).

It's not, you should never see this in a production system.

> > first attempt at this ran into problems with all the
> > reg-userspace-consumer instances getting attached to the first
> > regulator device, I think due to all of the regulators ending up under
> > the same name in the global namespace of regulator_map_list.=A0 I worked
> > around that by adding an ID counter to produce a unique name for each,
> > though that changes device names in userspace-visible ways that I'm
> > not sure would be considered OK for backwards compatibility.=A0 (I'm not
> > familiar enough with the regulator code to know if there's a better
> > way of fixing that problem.)=A0 The #if-ing to keep it behind a Kconfig

> Maybe ask that question on the regulator mailing list.

I can't really tell what the issue is here without more context, the
global name list should not be relevant for much in a system that's well
configured so it sounds like it's user error.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjCg0ACgkQJNaLcl1U
h9CrkAf/TSRg35eq8WabWWLzcTIUo/QdwVEdbLrcBq8sB22zW+lZicAOvpWCY+pa
cit9c0IqFkH7TFZ7vTPgta4lKflluYv8TLmWlN5/9QZJHo8gWC1x4os/MnUwONzy
vo9ZuPe7q12A+15s/yC6RZ5K2aV57fLUdsIaMd48nBO3oieK/NjK2bbJ+eixv1AL
MG8hhAn+Z5J6OIklwFZJ/Lo4weOUUVS+opsnd1JSlU9lTzygdJOOcmbMvm92DlCH
A/c1JxRmj8Tfdb6nNaISxh/s6DfUzf73Qbz5tWtbVjMOSqEPuwyY6vJtMYXu5ebD
YVcpBXMdgNu4l/7aNSBFo+/lqI55ew==
=co8z
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
