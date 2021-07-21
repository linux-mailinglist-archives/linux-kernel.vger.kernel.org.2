Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B063D0F23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhGUMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhGUMSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D980060FE7;
        Wed, 21 Jul 2021 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626872357;
        bh=bPx0RAOvqG2V51PSqVvLYqrpRgZ/GNWQlBdocKw4EY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3Skps0nqx3kwVYJZQiIecCdTbqvHIYkUvpo9OaGrPjgAvT8UOB72JUq23AFRqkIX
         LrtLCGRdochrsAmsYS/XsBIRdQZ9swcdV9zKsAZsBeuVqhIrVIyDlNDzucCsKJFaCn
         KH9f7gP10SwLIHgc35OxsZGkg7J1Kw7xYURLxnQwPe6KaA9yVquNTT++GbC+QmnVHg
         j4oN/aVVquNW0JM9a3HXZ3Hpd0NeVd4mAHo+SNWJBkd6P9cK7YCXmJ3eJgybxZplvv
         x5wuyZHMhSuNMejpOLsLHebx+3Wm16c30PFcOjqscTNZnig92azTHiePbNpfrgGpd/
         lH4VcNBF4uNjQ==
Date:   Wed, 21 Jul 2021 13:59:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
Message-ID: <20210721125912.GE4259@sirena.org.uk>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
 <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 20, 2021 at 10:28:57AM -0500, Pierre-Louis Bossart wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> - we currently don't support 'shipping the topology and firmware
> bundled up in a single image to avoid them getting out of sync'. No
> idea how that might work.

Seems like it'd be trivial to arrange in the kernel, or with userspace
firmware loading the loader could do the unpacking.

> - if the machine driver is specified in DeviceTree, then the topology
> used is *required* to be aligned with the machine driver. The rules
> are that a topology may not make references to a BE dailink exposed in
> the machine driver, but conversely if the topology makes a reference
> to a BE dailink that is not exposed in the machine driver the topology
> parsing will fail. It's one of the current weaknesses of
> topology-based solutions, we have non-configurable hardware-related
> things that are described in topology but should really be described
> in platform firmware, be it ACPI or DT, and provided to the topology.

That seems like an orthogonal issue here?  The requirement for a
firmware that's joined up with the hardware (and system description)
that it's being used with exists regardless of how we rename things.

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD4Gh8ACgkQJNaLcl1U
h9AEtwf+M4F9zXszQKCGjEhLkfF89T99hn0KNEo1eSDdfDW87K02IGExMcgDP3fE
+6NDVnHafyIeJf3AOwQhnuV7/3O9FBnhl2GFrLLENQCZS9lAUmD/eYthE6zNB6Sd
bA+8c0mIIA+ET2VEKzCOWEPK1E9ZKXFp9nN3EPPIdUEOiV/H1NlBV9V3IBTyKIQl
HnKC80MfJRrKEYEeNwZtRq56v9sGxAfVfhUVobthcJbfA7nGHqmEnlNp8O8Kc25G
yOKTXknjkzCH4hSTmkWILd2/O6cM7Qdz4viIi1g+u+aH9qDm8hldPePsM3ME89jf
FKEI2FjObAjR2wc+SudofZkK3BgutA==
=UblC
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
