Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2A3C8857
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGNQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhGNQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:08:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFB560FF2;
        Wed, 14 Jul 2021 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278738;
        bh=72/oQiQdsT/Cwo5iJX87YvVtTW9vsj6VkU2MnEgEThU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPDfDuzJbULpPqRzSkd30cv8qpee9WwAZEfW55Qh3TcbHN9xNXxRF+hMZipYm6XsK
         fO9pQz7amDQSmYPFLoxGqBqStfk9jLjg0ZV2CVS6CYrKaG/S8NZhZ4v32VtpKPd4Cz
         lIfTRcRG/EpqSC6ovT0GdSjhJw77bbp2u+cBky1IJJJTZ8c2T72+VHdY0heiLZat6z
         T/D7OHEXThINNQyxrxOXKPu7098NXvQZ5dFB+MSdrNQ6LQ03Sa1EiIB0UX1xy+idoF
         MRRt7kvneZC+5uvKl+cbgpoNAfh60P29wRQp6WgcRo9hMQO0woGHoy4PjNPigitgCR
         8ZmcxuCL4OG2g==
Date:   Wed, 14 Jul 2021 17:05:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210714160501.GC4719@sirena.org.uk>
References: <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <CAHp75Vfwz-cDrAhOnXaeUSDN-K+YJv8ahmvZ3aJwm2sKqc8HeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <CAHp75Vfwz-cDrAhOnXaeUSDN-K+YJv8ahmvZ3aJwm2sKqc8HeQ@mail.gmail.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 10:46:29PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 13, 2021 at 9:19 PM Mark Brown <broonie@kernel.org> wrote:

> > Like I said in the other mail fwnode is a nice hack for systems that are
> > using ACPI but have hardware that's doing something totally outside the
> > ACPI model to allow them to reuse work that's been done for DT, it's not
> > a universal solution to the lack of appropriate support for describing
> > modern systems in ACPI.

> In some (I suppose rear) cases it may be used by DT-enabled platforms as well.
> I can imagine the case when you have a system in ROM and only what you
> can do to change DTB there is either use DT overlays (which seems to
> be not working, plenty of gaps there according to a Wiki I saw once)
> or do something in the board files.

DT overlays are pretty extensively deployed, it's just that there's very
few use cases where it's done in the kernel - it tends to be better to
do them in either the firmware or a thin wrapper around the kernel so
that the kernel never has to see an unfixed DT, and we don't have to
try to do fixups super early in the boot on a supposedly generic kernel.
The main kernel use cases are things like FPGAs loading a dynamic image
and matching DT at runtime which is a whole additional ball of fun.

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvCy0ACgkQJNaLcl1U
h9DWJQf+ITAL3NEkBDUGUKxXlzZU7IrAMJVdxNeE4V8QLBXZy5os6tWB+dCeQ+cz
g03rkbrcMXIjBGbWtyxb+ydDqpn4DUI7+sm0L6vZTQHIgpFZCrTBZj2kKbpbq0La
9Q6cy5pMzf5bCtd93nUj0O7jF6GriGyFq7x78aWS4SWPcQApOIPAmRtELPpaBy2b
3vQIhaBYHQqSYaqPCYw8xTXT/k2GpUEiETBXv4gPO0eL7uKsZN7cmO07f6nWHsm0
k9OPwoLp3CqQ4ZaHQ5foR62G3LlGHa1zELv+KeXzqyJmA5BKvpoTrUQS//riWQ94
bHo5P4GTsQSXbIl5juoJBRHpNkA/OQ==
=Z0yY
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
