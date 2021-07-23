Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9603D3DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGWQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGWQBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D20CE60200;
        Fri, 23 Jul 2021 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058525;
        bh=4Qmt15RYEVqp2+42Xmn5M6L0KkWhd5FLEyieIa0fiV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxWV7PlH9BkxxUPMZQ93co+cX02FoTXqRziatQ1DcGavDumGXrC+E0dldCnzBd9bb
         OI/l3IHefOtZuWvGfctW7PHlb7qqeu+2J6mkSWvGiYggPDvLuf6Uji5dKO3kq3PiYO
         y3bdg+1adnv3sJuKjuw/qfBptyXHbRbalOG/NcoYtdTe23H/Fr9LhwSWkoOgLk8289
         +6ETWdlxurlYodKq51UGL/lwMnOvuyhhSg8Pi9m8DY+D41ZhH2I++cbxZcLUN+lcfW
         hVE6bhnl9WcfDuIrNfDnMbEe5KzjsnpAA+1KlSeEyvtL2SjK1pgURI24Dp/mPwGksi
         bMhceDiSjzIDQ==
Date:   Fri, 23 Jul 2021 17:41:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Message-ID: <20210723164158.GJ5221@sirena.org.uk>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-3-clement.leger@bootlin.com>
 <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkEkAx9hr54EJ73W"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkEkAx9hr54EJ73W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 23, 2021 at 06:07:44PM +0200, Arnd Bergmann wrote:

> There is also a problem with locking: In the case that both firmware and
> kernel have to access registers within a syscon area, you may need to
> have a semaphore to protect an atomic sequence of accesses, but since
> the interface only provides a single register load/store, there is no way for
> a kernel driver to serialize against a firmware-internal driver.

The standard solution to this for the read/modify/write case would be to
expose an explicit update_bits() operation (some hardware does this for
concurrency and/or bus bandwidth/latency reasons), though that doesn't
help with larger or multi-register sequences (and to be clear as I've
been saying I don't think we should do this at all).

--vkEkAx9hr54EJ73W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD68VUACgkQJNaLcl1U
h9CCLgf9G9jujb81HUy6yEF0B7MlJ4Te7jORS1PzOCwsTVNfQ5Zo0j/Necd8XI4i
RB33uzw+tW7NYUxNXAmJ0V/0GYws8KlEDMPDWbL7cd9vzWrGweJg5Deo6gfvBcnb
I71TpTqz1YlQZ6KqyFSif3TCKiS5NJFd3JBcBRYl7w+Zrx0dgFpPRolKzvL75ulv
MUdmb7aBvC/zNs7OapFR1coxL9HdglYxtmaEg8SpaEOqv8m9e2SnBGDLve5Ip9P0
7v2WBEwtU7Xr1A8d65Re6CgiW0s5GYQNZf242pwR4P+X2el05pwrFZOskgnbDH8q
18Ef/NWjldvS8QoB8tWPPzKm33ZrhQ==
=Zx6D
-----END PGP SIGNATURE-----

--vkEkAx9hr54EJ73W--
