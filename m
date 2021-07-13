Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD63C73C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhGMQGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9B8610A6;
        Tue, 13 Jul 2021 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626192214;
        bh=w/5d+mY536564LEOSl91Pnt7ica9jIgGgJp5tvlohYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auY08qT1ThnVLrat9fPM4HI2xognoFLaQAFCk8+yNNmRW2b77vNuewad3R091V4Fp
         nEt0srLCoMNiLXZ2AXC7QbgHVerZYLx+2Aebcotgv6KEPAjg51QpfihFj0efTfKgF3
         8VcLg6wT8XRpvXO8akEwsc+GUZX5QqtXEfdccLfVdEPRkzMLKQzU746OFRxsb359Mm
         C7tvPg0woGjpeu3ZE8HIBN+9I0hsmmyFffCNuXIqICEdNbZIEyk2HyYycI8aO66aLX
         mPa+VDx6PGTpRBYC2klKiXdbekEwObyxiLMfNwqFg4QXcLYyUevS4LJkPdR5qnuxia
         nFlvGKGuxoaUQ==
Date:   Tue, 13 Jul 2021 17:02:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210713160259.GD4098@sirena.org.uk>
References: <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <YO20aXWkqLgwHkku@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <YO20aXWkqLgwHkku@pendragon.ideasonboard.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 06:42:33PM +0300, Laurent Pinchart wrote:
> On Tue, Jul 13, 2021 at 04:24:54PM +0100, Mark Brown wrote:
> > On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:

> > > It also creates some problems to suppress the enumeration of the i2c
> > > device via ACPI (which we'll have to do in a machine specific fashion,
> > > because some laptops have this chip with properly configured ACPI and

> > To be clear I think that's a terrible idea.

> If you're talking about the ACPI implementation on those machines,
> nobody disagrees :-)

> To make sure I understand you correctly, do you advocate for suppressing
> registration of the I2C devices from ACPI and instantiate them from
> board code instead, or to somehow supplement the I2C device with
> board-specific data ?

No, to repeat yet again that is what I think is a terrible idea.

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDtuTIACgkQJNaLcl1U
h9AECQf/ZGEMmqj125P5a/SJoFykM+yrqls7LDNT92phSmxy6smHqTxkVAdM4kNY
6DjwGVT6oJNwWlNQbPdku/hi76Y+mp/FxTY+hpfJp7U6XkddgHeZAg3TXZKrkFss
sU6cFTgmI68wLeefe3I/Otu7d9uJT1mrCDGkOUC0xCM0Taw7ymEYQnKHZgC77MZY
4nxZg6CF/keLClI8gin03AmZiBEcymsrh8DwLpbmW0MtT5BlWMlyh0qGlJL6xuDL
eVziJmZZ57Ujqqzu9BxlJwGtokm9CNpkRXetrHwxm+zAX2SSj+8prMgGzsnbDOec
FVvTXcSkYhXI05opsC63m1MGhw7Qeg==
=QASs
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
