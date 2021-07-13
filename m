Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4E3C731F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhGMP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhGMP2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3FEF610A6;
        Tue, 13 Jul 2021 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626189930;
        bh=slvo4++D/WMUD87+IeDa43+rMSUdJ7pRafi0OFuXKRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCJxFjmHhOD5YoNcRXzYS2oNmiXBNNahYLUY4Pn2TntSnoUAt9Em1DEIWIKH9Cyx4
         DBH6WzVUyfSPtOOJzlJrietcQejisg2yIaM/wGQL12Q3ZKcZbR40ywGNuvrsPR5tAb
         LoWw1aT8x3swe0ewJfoC5AunhgBLWuED7nT+QeqSIH05Kwt2HZ/dErrf3qiNn01lDs
         DjHpA57nR8nyk8NvolcPIsXvSqK2QuwwR7gsV78vbUKwowcltBC2AW5fX3EVxYQN3J
         Kn8GI2fTLveGRViAwITWW2jKJBdHJeOKyPMIlpmLcIx/QBR1Q6AHFsXgjEYlhudEbp
         EPIyPDHEcFIrA==
Date:   Tue, 13 Jul 2021 16:24:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210713152454.GC4098@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:

> I do think it can simplify driver code too; a lot of them aren't written
> to parse platform data to get the init data, as they're just relying on
> reading it from devicetree so in the event that we get more cases like
> this, we need to modify those drivers to look for platform data too. On
> the other hand, even the drivers that don't directly call
> of_get_regulator_init_data() still do that lookup during the
> regulator_of_get_init_data() call in regulator_register(), so the ones
> that do parse platform data for init_data structs will check DT as part
> of regulator_register() anyway. Imitating that seems simpler to me.

The driver code is trivial boilerplate, assuming someone doesn't go and
implement a helper to register stuff separately like I suggested.  The
proposed swnode stuff would involve duplicating the DT parsing code.
This seems like a whole lot of effort for something that provides a
worse result than either of the existing things.

> It also creates some problems to suppress the enumeration of the i2c
> device via ACPI (which we'll have to do in a machine specific fashion,
> because some laptops have this chip with properly configured ACPI and

To be clear I think that's a terrible idea.

> > down to being another data table, I imagine you could write a helper for
> > it, or probably even come up with some generic thing that let you
> > register a platform data/DMI combo independently of the driver to get it
> > out of the driver code (looking more like the existing GPIO code which
> > is already being used in another bit of this quirking).

> The advantage of the GPIO lookups is there's no need to have the pointer
> to the registered devices to register the lookup table; we could imitate
> that, by adding entries to a list with the lookup values being device
> and regulator name (with the init data as the thing that's "looked up")
> and check for those during regulator_register() maybe?

Like I keep saying I think that's a much better approach than trying to
use swnodes, they just seem like a terrible fit for the problem.

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDtsEUACgkQJNaLcl1U
h9BvuAf9FSesJj6q2adc0w2TQHj3Zun/eu+tdZJc4E3Qv0B/Trmy1Ude28JSR9ZR
wJO2zKMFracVEMutZVH2I08d1F9zfZ/DpNtTsDMVrPBmG3Lt3O9lZDqbwg3KrLNY
fNR8SV9X3gyZJETNdZcEpQNA/9uubj+AEf5HBeaw4uDtytb+VfBRq7vOAf1H8XAs
I9+ai5xpHW4Yj32NxRD4y8/LP0aVrp4Av1NVCJJ47InK3X2R8zzvz5x1YVu/py19
Yn8Z/Pvmc3ZB+QmzET6pKe8/Ro08Rf+Oj+jsDDN4HDLeo8jCsQ/brNb1v2WNHeC2
0IHQ0n5DOcI3pozkKDJIFN0hJTJ7Aw==
=KjyV
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
