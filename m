Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B53C5D30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhGLN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhGLN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C6A6100B;
        Mon, 12 Jul 2021 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626096227;
        bh=pxLVQp7epb6tjy6xkmV2kK/CPRwd5GYA7XmJtbIgmNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGC2SReDgVWaAPOF3fciiPzMABcw14g4dj8MUSYN9QBMC6ie4+GTdiQsyRfLqVasF
         eiAanttP9ZJQoFLrXgujcFrRrnKayGwCPix3qe0vUhs9aMMV7vo9Uyektl+LMFvfRD
         j95/V/AMOVkDRHg5Vsl9VhE4s1lCArnHHZZHroEp88umUfp2ItAOVDrWhfzFWtsd/p
         ByLozaRhsqXE6CheKYVI2R7k4h4Zbs2QELA1ei7o0SiQ0VHKz9WuErC+n8v2RkApFl
         MiLGTwYpGKR5Nx3nTQjKIIAicAMmiaIOppSO7/dtCSpnyNxiqSWedUHj3sp5LIKzXA
         AJQaQ/41Szg3Q==
Date:   Mon, 12 Jul 2021 14:23:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210712132312.GC4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <YOofAUshZQBPsBR0@pendragon.ideasonboard.com>
 <4381a32a-e6ca-a456-887d-6b343182aed4@gmail.com>
 <YOsimBVS/mElfiA7@pendragon.ideasonboard.com>
 <1944291d-1486-fe7f-376b-fe3250ee6b7d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <1944291d-1486-fe7f-376b-fe3250ee6b7d@gmail.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 12, 2021 at 09:13:00AM +0100, Daniel Scally wrote:
> On 11/07/2021 17:55, Laurent Pinchart wrote:

> > If technically feasible, gathering all the data in a single place would
> > be my preference. Whether that should take the form of software nodes in
> > all cases, or be modelled as custom data that the int3472 driver would
> > interpret to create the regulators and clocks is a different (but
> > related) question.

> I'll have to think on that one then; the problem there is that the
> cio2-bridge is just given ACPI HIDs for the sensors as "ok to parse
> this", and of course the INT347A that is being dealt with here should
> already be supported on most Surface platforms via the intel-skl-int3472
> stuff, so once the ov8865 edits are (posted and) accepted and that
> driver is supported my plan would be to add it into the bridge. So we'd
> need a way to exclude Go2 from that if we wanted to define all the
> software nodes parts in a single board file instead.

Why not just do what things like rt5670 do and have the driver probe
for the PMIC use DMI information to set up platform data?  That seems a
lot more straightforward.

So long as people keep building systems that don't fit the ACPI model
using ACPI, and indeed with no firmware description at all for important
bits of the system, it's just a question of which particular kind of
mess we end up with cleaning up after them.  These vendors really should
adopt a standards based approach rather than relying on these DMI hacks.

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsQj8ACgkQJNaLcl1U
h9Cnwwf+MRljNYVKZijk7Juh1nqE+aIZKxQHSJ7d72GzfE4nZsWGUEMdZDTCXei1
9dHpJdlZpFwrPwNsGXd91kEqgpOZBBvfivxS8Dhuqcwibe8n8eKEoSuNmop84YkK
pZII1tnyoi03cWgwot8H98zfMBn14uVhwvsrU23izDI37JdgBcVEQJyE1HV5D0kp
9HaK+u2C9VvmeBoCDydrYWPL0u9k9BMSx/LG5CKfXkwTfQuDSYfK32P9l7+OPVCL
zgQHmNRlZRNH+5PWGK1bkBLL0slkv7SxKVeU2QldyV6vu04YdjnPVf8dYl/z+F8c
ULj2xG2jnyG2CZQIxX/gUBFb8Nkz8Q==
=gIUh
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
