Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1134F06C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhC3SCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhC3SCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDDAE619BB;
        Tue, 30 Mar 2021 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617127332;
        bh=Y45/WrWYteUQd+k3a9s1FlymTzr+5CIVLdESSGSdwF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgYgBPStEvsCMIrKhgF21xVDdGzCOn1xcuRLwHRqpqabpfBf/1jdmaEsOBzpWz5PK
         qbGG8MCDcrvegDrLOcPxzngYY405ZCcshIWROJkkKBB/cLO0MsStdA3CQolyQyvaq7
         fTCfdaR2PLx21Juk+7JqdWOy+Oe2SnVmcnFwiaNop14N9w09DeifCvLUlq2zcyDD+O
         6tCFQFt6BvYxiJqRUPAwaTjViBq9x3eoWOfTIc8uon9uzYAjpEigz1CgisEurWTRX2
         vwZ93G+pwV8ZrHH8a95pi59NsCWCUgbKORH6285tJwYf3Y1iJK9fSOZIl2hnND3Qtc
         VgUvBl9eTmHiA==
Date:   Tue, 30 Mar 2021 19:02:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210330180200.GK4976@sirena.org.uk>
References: <YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net>
 <5105ada1-643a-8e58-a52d-d3c8dbef86b9@roeck-us.net>
 <20210330112254.GB4976@sirena.org.uk>
 <YGNdoYq5lyERVGLO@hatter.bewilderbeest.net>
 <20210330174221.GJ4976@sirena.org.uk>
 <YGNmaNzWOYrJROvX@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <YGNmaNzWOYrJROvX@hatter.bewilderbeest.net>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 30, 2021 at 12:56:56PM -0500, Zev Weiss wrote:

> Okay, to expand a bit on the description in my initial message -- we've
> got a single chassis with multiple server boards and a single manager board
> that handles, among other things, power control for the servers.
> The manager board has one LM25066 for each attached server, which acts as
> the "power switch" for that server.  There thus really isn't any driver to
> speak of for the downstream device.

This sounds like you need a driver representing those server boards (or
the slots they plug into perhaps) that represents everything about those
boards to userspace, including power switching.  I don't see why you
wouldn't have a driver for that - it's a thing that physically exists
and clearly has some software control, and you'd presumably also expect
to represent some labelling about the slot as well.

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjZ5cACgkQJNaLcl1U
h9CdzQf9ERC9wd22hEhQ19B796qXQvItxatpQ4MJaOUZQsXyQ4k2FNls26aJN2x3
luvG+wp65djxDvvIecDshqf+Jc1dKsfvLHWUX+BF2ITaFCUujBRPqqozGeAvtjrv
wFaIMt77lymSGdd24bh7JzeM9QAuGzKcbgPu4SHdW1KRT24z+PY1+fxW2XjJFTlV
4R2+TmHe3cfJEclZ9U3MpCL+CloA0WmNsvVfQA1aS/byFl4gd9IfDpUcelDHpyqd
Rr3hExzCdIiBTczMlACJMQzBF3KvMY5gvX1cGav99Z8P4t+kiJKBlxkw/HNgnAVK
4twhdleGMXt5++WJ4sHJKvk9nfSw1w==
=ZTCR
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
