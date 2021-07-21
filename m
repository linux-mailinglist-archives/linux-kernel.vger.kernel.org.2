Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244133D14BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhGUQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhGUQUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:20:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72F3260FF3;
        Wed, 21 Jul 2021 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626886849;
        bh=hroQ6GW2Js8li6Khq4NdbOetcx6pit97/TyltR5nTXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+zARPPfPdd3B1s1Kt37AVrdb8qbI3cm9ChQkvHhfFLMSuqOCn9dd1j+Io3I7/H7p
         ytCvMLTiKu5IgAePcglp3iq34vfehohjMky3elXA5PV8hjs4i06CEsfzfDS3P3VjcK
         kLYtrzwcQuY5aDkS9CIBO0i/BfG4qoxYR/eR3NUbnZb2Vo7Pr/X0w9wxbweim/CZer
         6slhDdDlzzh4Luw1N/35OJboxCcVB14LSIgPo5KesJBbMXSeWXEX52nnA0ZatTZvR0
         KCGSg4HnqpdgcdV4S8Nnej/asX6AanTo3u3yk7RM8XJp/yoG+L8CQwGnLX496kaCyc
         +GSERaCsr4oyw==
Date:   Wed, 21 Jul 2021 18:00:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
Message-ID: <20210721170043.GH4259@sirena.org.uk>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
 <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
 <20210721125912.GE4259@sirena.org.uk>
 <eb98c10a-cc04-dbcf-b5cf-511703dc22fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <eb98c10a-cc04-dbcf-b5cf-511703dc22fb@linux.intel.com>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 21, 2021 at 08:28:17AM -0500, Pierre-Louis Bossart wrote:

> > Seems like it'd be trivial to arrange in the kernel, or with userspace
> > firmware loading the loader could do the unpacking.

> I think we can bundle the firmware inside of the kernel image itself,
> but we've never tried so it doesn't work by default.
> I don't know what userspace loading means, we rely on request_firmware
> and don't assume any specific support from userspace.

If you have a userspace handler that implements loading firmware into
the kernel (rather than having the kernel just try with a given path
prefix) then that program can do anything it likes to get the firmware,
including unpacking it out of another image.

> > That seems like an orthogonal issue here?  The requirement for a
> > firmware that's joined up with the hardware (and system description)
> > that it's being used with exists regardless of how we rename things.

> It's not completely orthogonal. The topology currently defines e.g. the
> I2S interface index, Mclk, bclk, fsync, etc, and my point is that these
> bits of information are completely related to the hardware and should
> probably come from platform firmware/ACPI.

If only ACPI based platforms offered a standard way to do this like DT
does and didn't rely on all these platform specific hacks!  In any case
my point is more that use case dependent selection of the firmware is a
separate issue to having firmware that matches a specific board and
there seemed to be some conflation of the two.  For having a completely
board specific firmware we already have system level identification in
both DT and ACPI which can be used.

> The topology framework currently provides too much freedom to
> developers, it's fine to add new pipelines, PCM devices and new
> processing, but when it comes to the hardware interfaces the topology is
> completely constrained. I've been arguing for a while now that the
> dailink descriptions and configurations should be treated as an input to
> the topology, not something that the topology can configure. I don't
> know how many issues we had to deal with because the topology settings
> were not supported by the hardware, or mismatches between topology and
> machine drivers (missing dailinks, bad dailink index, etc).

I think it'd definitely help to at least have some strong diagnostics
for detecting mismatches between the topology and the hardware and
machine driver it's being applied to, including what configurations the
machine driver is willing to have on the links (which could be just a
single configuration if that's what makes sense for the platform).  I
can see that the topology might want to select different configurations
for the various hardware links depending on how it wants to use them in
a given application, especially in more embedded contexts.

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD4UroACgkQJNaLcl1U
h9COUwf/QBa/hu110FzQzO7qAGIl1ukQEgywEkbjEHhjzU13EXqQKhKY8zUTcOFW
GItaLI2waPJrI/DjvkKD64gQ5jtkrntoInrRmdNGAGxdo6c0wqyoe8n7+3nG+ap2
AGD/za07Vd94ssr3ii2UFrIck7HXuC3irbMu8jkbBGbY6TC7xR1XIn0eQ51lNdC8
hokGE2w6CwxapGkxsE9By9CdEkmn94aV8N5umRD55QEp2++wROH5E10PVL0PXsLt
PoRxIq9bCx8fGAGivBu2htcE/eIFDy8qu3F5ggZChAT5jeUpeSAO35oMeY62xAlx
MHPU+q6uS3vHDrlKdsu4YsaLajecHA==
=5ZbX
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
