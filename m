Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD63F797E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhHYPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241481AbhHYPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:55:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B62B6112D;
        Wed, 25 Aug 2021 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629906895;
        bh=ZsNvCZY/k5MAyPCNnGO8Lp/k5DGvW29FcyQiTLu08Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRKlqUVVsV2ljxT2c4ZRjOq5nG72QYd67Y0lZhysG+32/ssEDvZqOJ0hHzMy36dqv
         xkdoKwIV5sUXH/+rkdkvqHxyywQFUS24IaKVdaq4ot3/t7xvN8BgYerugsrOBKgh9h
         Z0gxKQp67YXCIEu0IPi/ZUbvXa6qF39ZJp8lCJwSiASnu2LSgXojOOlkdfqDFIXodT
         nL0+7pJ27kPcjdT7EhsjbJGTVVidtrpBy13RBGgopjfpn5jva/YrTXag9/s5wvZlAM
         hc9SqHt8Onkg14QOOcKsOis6rEkqwSIdEnephuson1e1iDHeVBEYNoyaD4GwLcLN1x
         Ti/uFJ9Vxz2lQ==
Date:   Wed, 25 Aug 2021 16:54:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210825155427.GK5186@sirena.org.uk>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 04:54:38PM +0300, Vladimir Oltean wrote:

> - Use a hwspinlock. Never used one, don't know what it's about?!

hwspinlocks are for locking around things that are shared with other
processors not running Linux where the other processors might also take
the lock, they're very specialist.

> Either way, there seems to be no option to use a raw spinlock. "Disable
> locking" sounds like the best bet, but regmap offers regmap_bulk_read()
> and regmap_bulk_write() and those would be broken without locking taken
> at the syscon driver level, I think?

If you disable locks at the regmap level something needs to ensure that
there's no concurrency issues which for a MFD if any of the registers
are shared sounds off.

> I did google for fixes for this kind of issues that were sent in the
> past, but in my limited search I did not find any other driver which
> uses regmap while under a raw spinlock.

No problem with adding raw spinlocks to regmap, I think it's just nobody
needed them before.  I've not looked at the problem in sufficient detail
to figure out if that's actually the best solution here but from an initial
pass through it looks reasonableit looks reasonable

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmZ7MACgkQJNaLcl1U
h9BZkgf+JxwiGsMZkWzpAui2Utv/n7vPJEtP85nTm6yiunbxRB4kq7r9mDckijVX
XDWWB4BktE25SX1cIy8XPLi3YDfKwjirsDQ71yeIo5OM6sJ2c8Nd/z8twe0spD9L
UvWtOTKcOsX9xE3LDnXu4/LbpwBSm1Z4xE90EiffeBPplHrs7DbB5yqm48T2lrSp
0VD7CkZofQSvj8fuSjeCyMp27md5Exr2S3mkrgCiIGNlXzhcoaGK4X5Tt4np8wQ0
QNQaq5OOcoHos4cwuw+PE5tlm9fSSph8yTQ+Ic/qpPWfDIX51vK+0WfPTNpNwGJn
6MeRnoqpa3kUl+1CyIeL7bpR51p0jw==
=ZrHG
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
