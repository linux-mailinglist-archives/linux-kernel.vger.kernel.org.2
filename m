Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303FC3D3BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhGWOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWOCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E36F60EB6;
        Fri, 23 Jul 2021 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627051404;
        bh=KIaWSEbF2ieYnuY6s4j2MJ9g2D0DExusX12aGg1WaiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kW9n1OgpC6et0m+iIISWS3Z36my74IC4W5MB7bLk3K0WAPfpDkzfHiTWatg7mQwvo
         ZPSzmImL9R4qSO7a1g+0i9ec3IoaFC0MHcMr0uPIjA7gFQ3s19y2o+hvC47YJAD9/m
         6kMEHQ8P/O5a1Ik/J76zKjsNwqpj0xnSlN1XIN02DShKatcoSWtfgkLCGpn6R35/63
         82bY61MISyU2w8VAb16yz2l10fB/O3VCt9g4DLd0kcFPirtX7z8bo9uJkoXurgtEsM
         1eavGgVq51eb3+c8M+AaZetik8yFtM7nRzgKE4/CUWzuXGv/h2EYwqx0VraRJckzB4
         +zG/NxDiBpzSg==
Date:   Fri, 23 Jul 2021 15:43:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/3] regmap: add regmap using ARM SMCCC
Message-ID: <20210723144317.GF5221@sirena.org.uk>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <20210723135239.388325-2-clement.leger@bootlin.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 03:52:37PM +0200, Cl=E9ment L=E9ger wrote:

> When running under secure monitor control, some controllers can be placed=
 in
> secure world and their access is thus not possible from normal world. How=
ever,
> these controllers frequently contain registers than are needed by the nor=
mal
> world for a few specific operations.

> This patch adds a regmap where registers are accessed using SMCs. The sec=
ure
> monitor is then responsible to allow or deny access to the requested regi=
sters.

I can't see any SMC specification for this interface?  Frankly I have
some very substantial concerns about the use case for this over exposing
the functionality of whatever device the SMC is gating access to through
SMC interfaces specific to that functionality.  Exposing raw access to a
(presumed?) subset of whatever device functionality feels like the wrong
abstraction level to be working at and like an invitation to system
integrators to do things that are going to get them into trouble down
the line.

If the end user really is just twiddling a few bits here and there I'd
expect those functionality specific services to be pretty simple to do,
slightly more effort on the secure monitor side but a lot safer.  If
there is a use case for passing through an entire device for some reason
(ran out of controllers or something?) then I think we probably want an
abstraction at the bus level so we don't need to add custom support to
every device that we want to pass through and it's clear what's going on.

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD61YUACgkQJNaLcl1U
h9CUxAf+IRLhaLA4FK6gpUbrMRe/InckARWmToFPWsfQAOBRrdBzB4nhM9Kbjto+
zV2AH/3XQgUuVhP1sJom1AI+uPuv4o3hGJD3t6tIiJSXyuESq/ebjqTAZ5+bfu0n
AQZOfqbsfJ1Ui3kEQlqaDtWs6fgJGjC5B4LtvfL1RGw/wOY60BorVQoRT69f0K/d
P4D3YHcM+xt8x4asxgsqXRvIrJWWF0sofQwjBIfjE4YLvBI9lr16xwoHJ7Oy921e
LJreddf4ZxQc/8EG3WWYo5YuW/1Nz3b7mHkyKQ5010xj5rI6AKiB+vHhXeR9g5/O
1x6b+e2mDudxvhAIWOP+4CpIrYRe1w==
=aUun
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
