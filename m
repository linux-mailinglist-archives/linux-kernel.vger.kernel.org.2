Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7443C6155
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhGLREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhGLREo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BFDD611C0;
        Mon, 12 Jul 2021 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626109315;
        bh=JNSRRDX8lmDZ3Nlw/mdJuTp13Ocxa2nqOa9AIYtvYQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYMQZkotFylopqYUbk/z/JVO9hwu3eH4WfvL1xkbiaQn1Y4xiB9Sv3RJxjdpqQOom
         48FnElMguFAYGgczxhzs4VhdBb3znsxP9v3zVuLeuk8zQFzbYpGhc83RMawJ8K+S5W
         Yhb++uKmxNq1Opy4Fb0ErI3iGozi/6yrC6a+KhjC5P5p4Xkpn+xwHcW5igkF4MORuE
         F5U92ijIo5Q0zkTC4ag9HWkbBBra/G9i5N420wfemVnhx7QUAeH3LvOQB/ILyDvm+d
         CQs+9tEIqo0K1sfCE//kimRL+fPTBZh8PJBVC8C/79v7MFMgt6jv6U4isr/ofxSxM7
         Wrt21j7x9a5Nw==
Date:   Mon, 12 Jul 2021 18:01:20 +0100
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
Message-ID: <20210712170120.GG4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 12, 2021 at 07:08:23PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 12, 2021 at 4:35 PM Mark Brown <broonie@kernel.org> wrote:

> > But why?  I'm not seeing the advantage over providing platform data
> > based on DMI quirks here, it seems like a bunch of work for no reason.

> What do you mean by additional work? It's exactly opposite since most
> of the drivers in the kernel are using the fwnode interface rather
> than platform data. Why should we _add_ the specific platform data
> handling code in the certain drivers instead of not touching them at
> all?

It's adding an entirely new representation of standard data with less
validation support than either DT or platform data which seems like a
needlessly roundabout and error prone way of moving the data about with
less tooling support.  As far as I can tell the only advantage is that
it lets you write the quirk in a different source file but I'm finding
it hard to get excited about that.  If we were fixing up an existing
ACPI binding or something this approach would make sense to me but it's
making something entirely new out of whole cloth here.

We already have generic platform data support for the regulator API so
driver modifications would just be the DMI matching which is going to
have to happen somewhere anyway, I don't see a huge win from putting
them in one file rather than another.  It should basically just boil
down to being another data table, I imagine you could write a helper for
it, or probably even come up with some generic thing that let you
register a platform data/DMI combo independently of the driver to get it
out of the driver code (looking more like the existing GPIO code which
is already being used in another bit of this quirking).

It feels like this should be making more use of existing stuff than it
is.  If you look at what the core part of the code does it's taking data
which was provided by one part of the kernel in one set of C structs and
parsing those into a struct init_data which is what the core actually
wants to consume.  This seems like an entirely redundant process, we
should be able to just write the machine configuration into some struct
init_datas and get that associated with the regulators without creating
an otherwise entirely unused intermediate representation of the data.

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsdV8ACgkQJNaLcl1U
h9BEDQf/WQn5d+/awi3jCC+wt4pHwv6odLp0riNPio2YVlNA4fynyreMQIbNM7TB
xB45jAnwI3p2eH6FHF4tN8U6JTuDdvSAFkv9WKnRG1KvFRjWRoufUXY+pB1RAnHc
NpnnIj9mVKdAf9F4ZM3MZVAO8lds8q4JzX2DWFpTPT3iNYhrXrzg4Hq/oYcZSX+7
VZQc9WIKH7fqGGOV9zAHb87efkfTK7DZQdDp7zFolAxeq4Hkdj/M8KiedFbXxJtA
OLKW0vx8L/3ln6/kJ9mgUx5gCD+iMEz6bJOUnewjDZzszc6dRflUnxTUeXJXweUX
XI4vL8nrDtXSJywJJBtpFjZPtJqkuQ==
=Ooz1
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
