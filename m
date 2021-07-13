Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A83C7661
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhGMSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMSWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:22:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 984E06136D;
        Tue, 13 Jul 2021 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626200354;
        bh=cMdO8+EgP81LfDfTGGuhCMJIV2cTg8n2Vt2uLKZKQvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYagHoxmuuhdYYALTMy0Q2QzsYQKQo64SCjxbrQFNSmccdgFZZYj5FhbCWle8irZ4
         ZX3aK0KibU+ac/zl9UoKgsz2NM5X1E3JxiO7AenjX7Jn94Zk2gV96yi8DLX0C8jpgE
         wRtfjCW1lnWQrIvGmGqc31NrCAqW6SNAfcB77sqq0dV3d1J6QLwI/b1LAKmHzgMh9O
         +sVCiQHKSKl2NgahMzCbjgoUv5Yql6QfkcUbbNDSqmLU0J0efFDeiltdUT3Nz8iUh8
         pyKdo6GXMgPySplfafVMb7+DDVzrEuwRFI2kj0gTxoxpBsYJlgPqXQa9eYNbsf29W+
         1CLKwFhM5PgZQ==
Date:   Tue, 13 Jul 2021 19:18:37 +0100
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
Message-ID: <20210713181837.GE4098@sirena.org.uk>
References: <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 06:55:59PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 13, 2021 at 6:25 PM Mark Brown <broonie@kernel.org> wrote:

> > The driver code is trivial boilerplate, assuming someone doesn't go and
> > implement a helper to register stuff separately like I suggested.  The
> > proposed swnode stuff would involve duplicating the DT parsing code.
> > This seems like a whole lot of effort for something that provides a
> > worse result than either of the existing things.

> I'm not sure I follow. Where did you see the duplication when I saw
> the other way around?

The current patch consists entirely of additions, it does not remove any
existing code at all, the diffstat is:

 5 files changed, 174 insertions(+)

> Converting code from OF to fwnode APIs in most cases is smooth and
> doesn't add any overhead to the codebase,

We explicitly do not want to attempt to parse regulator properties out
of ACPI platform descriptions because using the regulator binding on
ACPI platforms conflicts with the ACPI model for power management and
we really don't want to encourage platforms to attempt to mix and match
here, it's not going to lead to anything robust.  System integrators
that need this sort of OS visible low level power management really
should be working with the UEFI forum to get an ACPI specification for
it, or if they don't really need it fixing up their AML to DTRT.

If you were to say that we could bodge around that by somehow forcing
this binding to exist only for swnodes when running on ACPI systems then
we'd still have the problems with creating something with worse tooling
than what's there already.

Like I said in the other mail fwnode is a nice hack for systems that are
using ACPI but have hardware that's doing something totally outside the
ACPI model to allow them to reuse work that's been done for DT, it's not
a universal solution to the lack of appropriate support for describing
modern systems in ACPI.

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDt2PwACgkQJNaLcl1U
h9AIYggAhPNHiBwlKUk6c+lvxWX8ALjqQ6kBBP2KDmwrMIuFZsvdXTXhHUQ1vPkb
w7PG6FcToLxXp/CBQlzstZ9A6UP992Bd750Amcwy/ewXy4iI0EDrxsfcVmFYIonv
KPs1YEint4jWFqG2RshAqI47K1HFFlIMVMdg/ml/RS86ZKYbJ69IzJ0swPfD0yZo
zQ5fmFAStFmy16NRb6TdzWgU3fhulaKZsNrNXAvc7yNK4kuoE5OPfxl+oth46L6k
T3uE9qCP3uTF3IWQLTjdWIvRUpe1fKtkvhedS9BQvgluaECF+bilchTHDkl/oERO
FAXsZvvu/qRAoXEzYBTezPTelH3/BA==
=wdNf
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
